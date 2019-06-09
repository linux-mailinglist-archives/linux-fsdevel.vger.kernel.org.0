Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8576C3ABA9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jun 2019 21:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbfFITgk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jun 2019 15:36:40 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39354 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbfFITgk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jun 2019 15:36:40 -0400
Received: by mail-it1-f193.google.com with SMTP id j204so10110242ite.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Jun 2019 12:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0tNGv+arZFbUC2Bql5ZflXNQOeyrhKP+HeersrnEq2c=;
        b=Tz1CP7qNKp+ywvO0r+kJ97LXd52kHRjysi9o+zkfcOn1MdFDTnoDqngjFjF7OlBOHd
         K1K/+co/1kQzXR/aLTXVsmtPstkk6AKB/ZieUDHDrwDq4++GVL2uMDn1s/XbsDALO6N8
         vPzDPuQuQrltSNbaxTHIipRAQcVLK9yRm7qSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0tNGv+arZFbUC2Bql5ZflXNQOeyrhKP+HeersrnEq2c=;
        b=hgWVC5tDM+IuM4P81dPEFEmpSZtz94NKsMS3J8vTwDwjasBCS2IO0BD06KOojwm8fG
         Cq7cFmeIiQUsKICFhgSugT6N+CDYlW4TmnHo79bcSMitPsmDK/O+n1jzFoJfl+j1Gi+T
         XUgvz/wJ3vWR8s1QckhTvFFXYe6T1NZyzuFzP9jSoVyufQLU2GEiaD6Pxl781BVvP9q+
         WsJ1hz38miXpkWyptLfa0cZXyC69mqGBYJ2TlZuM2+aSYFCe8DPskRJu7YQM0b2Tru/v
         RfTK3z+rm8HXLbc9tJgS4WKEemJHBl+9l5QS/C64xvRaZNkuXlR2GLjOGEMEBp8NWsJ2
         t/Aw==
X-Gm-Message-State: APjAAAXjCPrM6eLezAtwK6AqvQwM5CQuPNgaC/qj1+1wQm5yQbWWDfDe
        s6nX2nWeCJFnYOV2Izzs3GVAJf0b+BPvue8+gSCXoyPbrY0=
X-Google-Smtp-Source: APXvYqzj024nkPLD6+YBKZXRCpCyglYA29adS7WLrx/vssF2bitP3/nxSC+gZVSciAdKxQ5ks791fmqKraCFkjtwWZQ=
X-Received: by 2002:a02:a384:: with SMTP id y4mr42330151jak.77.1560108999151;
 Sun, 09 Jun 2019 12:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190608135717.8472-1-amir73il@gmail.com> <20190608135717.8472-2-amir73il@gmail.com>
In-Reply-To: <20190608135717.8472-2-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Sun, 9 Jun 2019 21:36:28 +0200
Message-ID: <CAJfpegs9=W7BwqqBpTPgoXj5xaR=YMkDHLFM3pBaj8YLK-CwyQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vfs: replace i_readcount with a biased i_count
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 8, 2019 at 3:57 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Count struct files open RO together with inode reference count instead
> of using a dedicated i_readcount field.  This will allow us to use the
> RO count also when CONFIG_IMA is not defined and will reduce the size of
> struct inode for 32bit archs when CONFIG_IMA is defined.
>
> We need this RO count for posix leases code, which currently naively
> checks i_count and d_count in an inaccurate manner.
>
> Should regular i_count overflow into RO count bias by struct files
> opened for write, it's not a big deal, as we mostly need the RO count
> to be reliable when the first writer comes along.
>
> Cc: <stable@vger.kernel.org> # v4.19
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  include/linux/fs.h                | 33 +++++++++++++++++++------------
>  security/integrity/ima/ima_main.c |  2 +-
>  2 files changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f7fdfe93e25d..504bf17967dd 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -694,9 +694,6 @@ struct inode {
>         atomic_t                i_count;
>         atomic_t                i_dio_count;
>         atomic_t                i_writecount;
> -#ifdef CONFIG_IMA
> -       atomic_t                i_readcount; /* struct files open RO */
> -#endif
>         union {
>                 const struct file_operations    *i_fop; /* former ->i_op->default_file_ops */
>                 void (*free_inode)(struct inode *);
> @@ -2890,26 +2887,36 @@ static inline bool inode_is_open_for_write(const struct inode *inode)
>         return atomic_read(&inode->i_writecount) > 0;
>  }
>
> -#ifdef CONFIG_IMA
> +/*
> + * Count struct files open RO together with inode rerefernce count.
> + * We need this count for IMA and for posix leases. The RO count should not
> + * include files opened RDWR nor files opened O_PATH and internal kernel
> + * inode references, like the ones taken by overlayfs and inotify.
> + * Should regular i_count overflow into I_RO_COUNT_BIAS by struct files
> + * opened for write, it's not a big deal, as we mostly need
> + * inode_is_open_rdonly() to be reliable when the first writer comes along.

The bigger issue is allowing i_count to wrap around: all you need is a
file with 1025 hard links and 4194304 opens of said file.  Doable
without privileges?  Not sure, but it does seem pretty fragile.

BTW the current 32 bit i_readcount that IMA uses also has wraparound
issues, though that's not nearly as bad.

Going to a 64 bit i_count would fix these, I guess.

Thanks,
Miklos

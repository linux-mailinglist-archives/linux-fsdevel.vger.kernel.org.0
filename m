Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27ED21FD64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgGNTbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbgGNTbX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:31:23 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB899C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 12:31:22 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q4so25027791lji.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 12:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cPk5LMoGoThBA0eFxbivhO2pS56bC/86EhKFPKHKu4c=;
        b=VLmnr+RKkXZkAascGHD+AaCNa6Y2XPywcyp6v/mdbuMkz/hf+hhfE1/nd7RM0JXapm
         cVYAMBvwJI3Gd5pMjW+DZXpL4Lk84F0PSZHOcvKhlEII13xTPasta+T1CpQkTxCpx6DR
         hsyOPnSmMSJKICLP2tLHfz+bnE3r2Zf/mvQgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPk5LMoGoThBA0eFxbivhO2pS56bC/86EhKFPKHKu4c=;
        b=YnuNROO4ApsIf3yMx/Egs2PxB+gZ45MK9r6pAt1xxBlDwCO3iDrl2DSfdkdftebT3f
         5vraxKAbNqRCw7Z4pYYMSu5oLAjG+gqb1SqX1KJoW6+8uR9Oo/m8gdq+H9zG/z0kscjm
         ukzT3fkwR7UoV2EnRfC4NU9QBZycCaxkaoljvwjNEQZ6VBSz3f0zy96lUXH2vPfIcisC
         smj/G2Y9TSOfPqahyyYNVM7aAAPdG3ZuLOVjAE0JrqLcIm/Tuwp/3ME55Gk9Dru/OWxw
         yxrOUkCRuk8ZHjYkPAE+82XyIlLA2AlErEYVPKuSizxBMzbYEn87AVGqnu85rR3i8S7Y
         vhQQ==
X-Gm-Message-State: AOAM533yEVo1as+yDxTUzYoSdUcpTCqNyKjoxstsRfKrzmF/bfcsRQAM
        2VE3y4MFUWM5qyOgOxqP3CZqJGnm6rI=
X-Google-Smtp-Source: ABdhPJy5tT/N9tTMFMz0IGLW8jgGoC2MFDsMbWiI/jvbH+ZJlf/H/xfWEcWmGMhNWCO8riBHBg7IkA==
X-Received: by 2002:a05:651c:1183:: with SMTP id w3mr2884883ljo.54.1594755080673;
        Tue, 14 Jul 2020 12:31:20 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id b11sm5458623lfa.50.2020.07.14.12.31.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 12:31:19 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id z24so24974582ljn.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 12:31:18 -0700 (PDT)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr3168247ljj.312.1594755078276;
 Tue, 14 Jul 2020 12:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200714190427.4332-1-hch@lst.de> <20200714190427.4332-18-hch@lst.de>
In-Reply-To: <20200714190427.4332-18-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jul 2020 12:31:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whDbHL7x5Jx-CSz97=nVg4V_q45DsokX+X-Y-yZV4rPvw@mail.gmail.com>
Message-ID: <CAHk-=whDbHL7x5Jx-CSz97=nVg4V_q45DsokX+X-Y-yZV4rPvw@mail.gmail.com>
Subject: Re: [PATCH 17/23] initramfs: switch initramfs unpacking to struct
 file based APIs
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 12:09 PM Christoph Hellwig <hch@lst.de> wrote:
>
> There is no good reason to mess with file descriptors from in-kernel
> code, switch the initramfs unpacking to struct file based write
> instead.

Looking at this diff, I realized this really should be cleaned up more.

 +                       wfile = filp_open(collected, openflags, mode);
> +                       if (IS_ERR(wfile))
> +                               return 0;
> +
> +                       vfs_fchown(wfile, uid, gid);
> +                       vfs_fchmod(wfile, mode);
> +                       if (body_len)
> +                               vfs_truncate(&wfile->f_path, body_len);
> +                       vcollected = kstrdup(collected, GFP_KERNEL);

That "vcollected" is ugly and broken, and seems oh-so-wrong.

Because it's only use is:


> -               ksys_close(wfd);
> +               fput(wfile);
>                 do_utime(vcollected, mtime);
>                 kfree(vcollected);

which should just have done the exact same thing that you did with
vfs_chown() and friends: we already have a "utimes_common()" that
takes a path, and it could have been made into "vfs_utimes()", and
then this whole vcollected confusion would go away and be replaced by

        vfs_truncate(&wfile->f_path, mtime);

(ok, with all the "timespec64 t[2]" things going on that do_utime()
does now, but you get the idea).

Talk about de-crufting that initramfs unpacking..

But I don't hate this patch, I'm just pointing out that there's room
for improvement.

             Linus

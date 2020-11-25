Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4892C41AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 15:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgKYOD0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 09:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgKYOD0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 09:03:26 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF755C0613D4;
        Wed, 25 Nov 2020 06:03:18 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id n129so2231136iod.5;
        Wed, 25 Nov 2020 06:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qiCk2eoJyYhywnvNc65wAVuqoqpo10yd3g6pthLzrXc=;
        b=g7yEKGmv65u+bVOj/NLRREqXVf4gI4RqXfmQBWaqRATO5j7YasqCfSjAt+5AZnRc6z
         GuKmthGQZQmbSCZxaFIzVv5sugZ9yKicLU4UND/T+k7cuKM+7n8rtXtSXHbxdziiGNio
         C73zqTeBZKNWu1yLSuTVHXLAhGkTv2JeJ/vEY66nYglDk1gKrHz63OgDRLlUd3AUmqAq
         58JmCCr4ZIJSp4y3VAKnUkADGyVppdN5qXe9mQ3bh0na1evzXwoXiV5W/mqiTEURx10U
         I8JBFVK3e7Sew2eWT6ROQm0l89HDQyjwwyGyii6CE+8kDZOtJlQhfV1I3/N+rqNpfr3k
         oTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qiCk2eoJyYhywnvNc65wAVuqoqpo10yd3g6pthLzrXc=;
        b=ipPPJ57QxTZCRUtAlR3+FPeX7OHLN/VtReYFETt8SCkPr2AfEva4YgdGHeWW2/m7/D
         yjzP7EVnPT/PCZDzrCctBw61Xz+aliw19qGtXNwmbVrMDureWaKC8yEkg5q4hqtTS6dE
         xdeeuDsesmPUV0qq7pvjj24hKbPP6lAA1R8HgR3m9G6JVvh6nQ06Y+47uq9/OCxqc69D
         rHB2bFuUJMNOfWwCeRe1xgS3YJtHwat/hhL14HwKywPNRj2dnsK9oZpuHsxOq/KgLBRY
         3yXq6Da59gftfP04zfmxZ9YTkiEwjrJbv0OYP+d3J6eqk0CFsP6bMdLGUiQTIHT3hwRw
         hDpA==
X-Gm-Message-State: AOAM531CHTSc23g0RU1UWs0d2F6hM83AH3AIAkB9nsri9BQbwm++/5AB
        ZdniBnFkeDYUaUO19aux6BhzmpBMYlFZh5SkJsSqTi3R
X-Google-Smtp-Source: ABdhPJytzX8Xsx1/FZXd6Y7sMl5RXa9gTseV8cUThofzDkUeuO2Qgf3ujgBGfHwjh9dpDdH9R0VqN1Ju3F+9vXZ0d60=
X-Received: by 2002:a05:6602:121c:: with SMTP id y28mr2653097iot.203.1606312998202;
 Wed, 25 Nov 2020 06:03:18 -0800 (PST)
MIME-Version: 1.0
References: <20201125104621.18838-1-sargun@sargun.me> <20201125104621.18838-4-sargun@sargun.me>
In-Reply-To: <20201125104621.18838-4-sargun@sargun.me>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Nov 2020 16:03:06 +0200
Message-ID: <CAOQ4uxhr1iLkvt+LK868pK=AaZ5O6vniPf2t8=u1=Pb+0ELPAw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] overlay: Add rudimentary checking of writeback
 errseq on volatile remount
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 25, 2020 at 12:46 PM Sargun Dhillon <sargun@sargun.me> wrote:
>
> Volatile remounts validate the following at the moment:
>  * Has the module been reloaded / the system rebooted
>  * Has the workdir been remounted
>
> This adds a new check for errors detected via the superblock's
> errseq_t. At mount time, the errseq_t is snapshotted to disk,
> and upon remount it's re-verified. This allows for kernel-level
> detection of errors without forcing userspace to perform a
> sync and allows for the hidden detection of writeback errors.
>

Looks fine as long as you verify that the reuse is also volatile.

Care to also add the alleged issues that Vivek pointed out with existing
volatile mount to the documentation? (unless Vivek intends to do fix those)

> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> ---
>  fs/overlayfs/overlayfs.h | 1 +
>  fs/overlayfs/readdir.c   | 6 ++++++
>  fs/overlayfs/super.c     | 1 +
>  3 files changed, 8 insertions(+)
>
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index de694ee99d7c..e8a711953b64 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -85,6 +85,7 @@ struct ovl_volatile_info {
>          */
>         uuid_t          ovl_boot_id;    /* Must stay first member */
>         u64             s_instance_id;
> +       errseq_t        errseq; /* Implemented as a u32 */
>  } __packed;
>
>  /*
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 4e3e2bc3ea43..2bb0641ecbbd 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -1109,6 +1109,12 @@ static int ovl_verify_volatile_info(struct ovl_fs *ofs,
>                 return -EINVAL;
>         }
>
> +       err = errseq_check(&volatiledir->d_sb->s_wb_err, info.errseq);
> +       if (err) {
> +               pr_debug("Workdir filesystem reports errors: %d\n", err);
> +               return -EINVAL;
> +       }
> +
>         return 1;
>  }
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 9a1b07907662..49dee41ec125 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1248,6 +1248,7 @@ static int ovl_set_volatile_info(struct ovl_fs *ofs, struct dentry *volatiledir)
>         int err;
>         struct ovl_volatile_info info = {
>                 .s_instance_id = volatiledir->d_sb->s_instance_id,
> +               .errseq = errseq_sample(&volatiledir->d_sb->s_wb_err),
>         };
>
>         uuid_copy(&info.ovl_boot_id, &ovl_boot_id);
> --
> 2.25.1
>

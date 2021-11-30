Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B38E462D62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 08:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239000AbhK3HTG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 02:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbhK3HTF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:19:05 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA93C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 23:15:47 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id p23so24805579iod.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 23:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfrRoaImqPR0WIo1SiEM5NuBgL9gXOIVLSMqEw/Q76o=;
        b=KmG8KwQjgBd0L715tsnAhz+IOtjHln849eQfNhw4IhZPq1xcm7E6VWngAdYfQqCBIX
         H8M8NP/HSw/JrehZw2Csw10DMUu7uz6NqLHWbGMVTZGLRq7tzsBSN5oHkOrMKR2fgokU
         /b1Rb2KhC1YKFIdKNs9n5rO1SiMGEUqHFPWh1jdJQzRvY+XzGkbslwismOjMmy+pW1zs
         3l2mt9RSJVhYBlIl+Dn8fXV7BAVMxcX2AJ6n1/EjCDoR3HGcnzfFyJxPZtpPNkXHLexX
         WeN3soBYTWml9nB4ljGpbGUa+XLhw651dqMXzYCLuvSqEJjlla3vaN0a8bJujU3V1eJT
         EHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfrRoaImqPR0WIo1SiEM5NuBgL9gXOIVLSMqEw/Q76o=;
        b=f8oAsV2Bk1/2zFrpHv1un27OEALsQTBaw15AxkzVR49sK5/PvrR8Gr2uNZcdX3bBfn
         e6swK6mTByqxBNogEelTjauS33nsNb7RKJz4JpCIpM69zF8037nXRG8HxphLFwfnQq16
         Ycye4mFDZynQuaRW7qipdjfP4APUW8JeO5CPcFROGhv2b4eVPMAJWf0Dzm14isRMrP/q
         5Mi2Ab2BtOIiZ24wqwdOD8IsrHYxmRAtEwszlwR2PTfipaiV8y6g9fJYfKAwynUsL7NV
         7DYmwRvduwvctF0Pd2ZghsaAsKcnw8+QC5xmPeznjE5+F8rWzWTRJo66cfgatoUiOp3Q
         QeQA==
X-Gm-Message-State: AOAM533yYGRp54dkJ8nDAQeLOSbwL6toFZWpz7WbuwFri6seHG/M/pNB
        28jKTkUBLz3tb6X/xe3mYWi7I2nZv1dQrTELTCM=
X-Google-Smtp-Source: ABdhPJz25euNTEi421hgfB3aXXBmPhTDP2iEjn+lt7S7/RQs31xfWM1+IdjpIKzfJmundQfCBqk22a+oKWZFfZCA4FE=
X-Received: by 2002:a05:6602:29c2:: with SMTP id z2mr58341209ioq.196.1638256546638;
 Mon, 29 Nov 2021 23:15:46 -0800 (PST)
MIME-Version: 1.0
References: <20211123114227.3124056-1-brauner@kernel.org> <20211123114227.3124056-9-brauner@kernel.org>
In-Reply-To: <20211123114227.3124056-9-brauner@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 30 Nov 2021 09:15:35 +0200
Message-ID: <CAOQ4uxhWj_o0WFUpJn7d-YXpT_dTNFWBPzetb13N8LkyMywbDA@mail.gmail.com>
Subject: Re: [PATCH 08/10] fs: port higher-level mapping helpers
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 3:29 PM Christian Brauner <brauner@kernel.org> wrote:
>
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> Enable the mapped_fs{g,u}id() helpers to support filesystems mounted
> with an idmapping. Apart from core mapping helpers that use
> mapped_fs{g,u}id() to initialize struct inode's i_{g,u}id fields xfs is
> the only place that uses these low-level helpers directly.
>
> The patch only extends the helpers to be able to take the filesystem
> idmapping into account. Since we don't actually yet pass the
> filesystem's idmapping in no functional changes happen. This will happen
> in a final patch.
>
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> CC: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  fs/xfs/xfs_inode.c          | 10 ++++++----
>  fs/xfs/xfs_symlink.c        |  5 +++--
>  include/linux/fs.h          |  8 ++++----
>  include/linux/mnt_mapping.h | 12 ++++++++----
>  4 files changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 64b9bf334806..7ac8247b5498 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -977,6 +977,7 @@ xfs_create(
>         struct xfs_trans_res    *tres;
>         uint                    resblks;
>         xfs_ino_t               ino;
> +       struct user_namespace   *fs_userns = &init_user_ns;
>
>         trace_xfs_create(dp, name);
>
> @@ -988,8 +989,8 @@ xfs_create(
>         /*
>          * Make sure that we have allocated dquot(s) on disk.
>          */
> -       error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns),
> -                       mapped_fsgid(mnt_userns), prid,
> +       error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns, fs_userns),
> +                       mapped_fsgid(mnt_userns, fs_userns), prid,

I am confused.
Do we intend to enable idmapped xfs sb?
If the answer is yes, then feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

I did a quick review pass of all the patches.
The ones I did not reply to I felt I needed to take a close look
so will continue with the review later.

Thanks,
Amir.

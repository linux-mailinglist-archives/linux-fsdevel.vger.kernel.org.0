Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B44488202
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jan 2022 08:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbiAHHJK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jan 2022 02:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiAHHJJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jan 2022 02:09:09 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44743C061574;
        Fri,  7 Jan 2022 23:09:09 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id j1so152948iob.1;
        Fri, 07 Jan 2022 23:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sRXzK/lqvK+CkfJ0q4743gkEDTMH9u4vG56Fc2vaE/U=;
        b=ieQQfVLBY3KSd4KecN4JHRORUQEeh/oogCFLY0R/2/kfI0G7S/VhAnBizemKzEprHB
         EKuK/bE1g/3M4xE0uJYxJCw+6ncoMVwLNs6iQTtvmPFpn0kgym7zKX9jdGKZ4g6+5O9w
         WA+cms/PeN55G2DsYXkohXVTBV7Kf+SKuH0GWkbNORUO6Vhy3FB0IvMApo/HdoU0Zxwq
         VMtYqMoXj1TH0/JynvBWvyLNO9sRa6z8HKBfBDGlX1VLzlD8CjAc/tFf9njsL1QRKia5
         08YRaqUW5rYdFQq0XKICA6lNAzhj6obprkj/8e7cLIU6AeCmQ4lYvZU/VAysTgLrGqCu
         np1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sRXzK/lqvK+CkfJ0q4743gkEDTMH9u4vG56Fc2vaE/U=;
        b=SmuPfSMO2tC55xlUJhXoV/EQ8qA+4RGYKcms713TsJqVoLl/gDQUERoYM5Io2N6oDv
         vbW9MxidDA8QUS5F6LYLVx9sVt8amd3MAlhl/NjWOI/amd7klNh58wIBdXkTiQoETyFT
         U7BAb2hHdzJv6CYk0HG+jIOkca2e36e/xyjgkkxpehubfHKG/CR3gIdOu4PvOfacpk97
         A2TdB/smDL6CZX6gPPcBlk6wkGINv2pb1pF/pz80RSvONI8vi44xz3LSdcmMea05biUJ
         6k7dpyyt4HenDDXOfAQowWhC/XOd+2RR6HVIIm3tGsYX8vDN/aBludT+TvUgZ7V3Gobo
         Xcbw==
X-Gm-Message-State: AOAM5304U0sSJlN9fFmRATPNOKYVIqeWcQtiYKlKd9+iv/qoSTcTuIpm
        GrE3wYYnSV6sgtJQrw/ccdJ+ULNh9BlzocJ+APk=
X-Google-Smtp-Source: ABdhPJx+/bHNQi2TJrW6OyIV2QCN1CKOeiSpIVesRRe2vCRlhJscDWjlBTocK3a12pB+qw5jpsCC+o53g/Y1aGq5M88=
X-Received: by 2002:a05:6638:160c:: with SMTP id x12mr33388634jas.1.1641625748333;
 Fri, 07 Jan 2022 23:09:08 -0800 (PST)
MIME-Version: 1.0
References: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
 <164021541207.640689.564689725898537127.stgit@warthog.procyon.org.uk>
In-Reply-To: <164021541207.640689.564689725898537127.stgit@warthog.procyon.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 8 Jan 2022 09:08:57 +0200
Message-ID: <CAOQ4uxjEcvffv=rNXS-r+NLz+=6yk4abRuX_AMq9v-M4nf_PtA@mail.gmail.com>
Subject: Re: [PATCH v4 38/68] vfs, cachefiles: Mark a backing file in use with
 an inode flag
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 25, 2021 at 1:32 AM David Howells <dhowells@redhat.com> wrote:
>
> Use an inode flag, S_KERNEL_FILE, to mark that a backing file is in use by
> the kernel to prevent cachefiles or other kernel services from interfering
> with that file.
>
> Alter rmdir to reject attempts to remove a directory marked with this flag.
> This is used by cachefiles to prevent cachefilesd from removing them.
>
> Using S_SWAPFILE instead isn't really viable as that has other effects in
> the I/O paths.
>
> Changes
> =======
> ver #3:
>  - Check for the object pointer being NULL in the tracepoints rather than
>    the caller.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-cachefs@redhat.com
> Link: https://lore.kernel.org/r/163819630256.215744.4815885535039369574.stgit@warthog.procyon.org.uk/ # v1
> Link: https://lore.kernel.org/r/163906931596.143852.8642051223094013028.stgit@warthog.procyon.org.uk/ # v2
> Link: https://lore.kernel.org/r/163967141000.1823006.12920680657559677789.stgit@warthog.procyon.org.uk/ # v3
> ---
>
>  fs/cachefiles/Makefile            |    1 +
>  fs/cachefiles/namei.c             |   43 +++++++++++++++++++++++++++++++++++++
>  fs/namei.c                        |    3 ++-
>  include/linux/fs.h                |    1 +
>  include/trace/events/cachefiles.h |   42 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 89 insertions(+), 1 deletion(-)
>  create mode 100644 fs/cachefiles/namei.c
>
> diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
> index 463e3d608b75..e0b092ca077f 100644
> --- a/fs/cachefiles/Makefile
> +++ b/fs/cachefiles/Makefile
> @@ -7,6 +7,7 @@ cachefiles-y := \
>         cache.o \
>         daemon.o \
>         main.o \
> +       namei.o \
>         security.o
>
>  cachefiles-$(CONFIG_CACHEFILES_ERROR_INJECTION) += error_inject.o
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> new file mode 100644
> index 000000000000..913f83f1c900
> --- /dev/null
> +++ b/fs/cachefiles/namei.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* CacheFiles path walking and related routines
> + *
> + * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#include <linux/fs.h>
> +#include "internal.h"
> +
> +/*
> + * Mark the backing file as being a cache file if it's not already in use.  The
> + * mark tells the culling request command that it's not allowed to cull the
> + * file or directory.  The caller must hold the inode lock.
> + */
> +static bool __cachefiles_mark_inode_in_use(struct cachefiles_object *object,
> +                                          struct dentry *dentry)
> +{
> +       struct inode *inode = d_backing_inode(dentry);
> +       bool can_use = false;
> +
> +       if (!(inode->i_flags & S_KERNEL_FILE)) {
> +               inode->i_flags |= S_KERNEL_FILE;
> +               trace_cachefiles_mark_active(object, inode);
> +               can_use = true;
> +       } else {
> +               pr_notice("cachefiles: Inode already in use: %pd\n", dentry);
> +       }
> +
> +       return can_use;
> +}
> +
> +/*
> + * Unmark a backing inode.  The caller must hold the inode lock.
> + */
> +static void __cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
> +                                            struct dentry *dentry)
> +{
> +       struct inode *inode = d_backing_inode(dentry);
> +
> +       inode->i_flags &= ~S_KERNEL_FILE;
> +       trace_cachefiles_mark_inactive(object, inode);
> +}
> diff --git a/fs/namei.c b/fs/namei.c
> index 1f9d2187c765..d81f04f8d818 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3958,7 +3958,8 @@ int vfs_rmdir(struct user_namespace *mnt_userns, struct inode *dir,
>         inode_lock(dentry->d_inode);
>
>         error = -EBUSY;
> -       if (is_local_mountpoint(dentry))
> +       if (is_local_mountpoint(dentry) ||
> +           (dentry->d_inode->i_flags & S_KERNEL_FILE))

Better as this check to the many other checks in may_delete()

>                 goto out;
>
>         error = security_inode_rmdir(dir, dentry);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2c0b8e77d9ab..bcf1ca430139 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2249,6 +2249,7 @@ struct super_operations {
>  #define S_ENCRYPTED    (1 << 14) /* Encrypted file (using fs/crypto/) */
>  #define S_CASEFOLD     (1 << 15) /* Casefolded file */
>  #define S_VERITY       (1 << 16) /* Verity file (using fs/verity/) */
> +#define S_KERNEL_FILE  (1 << 17) /* File is in use by the kernel (eg. fs/cachefiles) */
>

Trying to brand this flag as a generic "in use by kernel" is misleading.
Modules other than cachefiles cannot set/clear this flag, because then
cachefiles won't know that it is allowed to set/clear the flag.

So I think it would be better to call it for what it really is - an inode flag
that is controlled by cachefiles.
Also, the name KERNEL_FILE for a directory is a bit confusing IMO.
Perhaps S_CACHEFILES?

Thanks,
Amir.

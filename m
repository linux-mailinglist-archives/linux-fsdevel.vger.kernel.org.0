Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C534A4A9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 16:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379610AbiAaPcW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 10:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379586AbiAaPcU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:32:20 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D25DC061714;
        Mon, 31 Jan 2022 07:32:20 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id i1so11707908ils.5;
        Mon, 31 Jan 2022 07:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jqx1HO/XId0GJ3ue+sgoNKZespsPL3K2xwqbKDpT4Z8=;
        b=qCbG24J5xi7OR+SJA1cM3K3hPlIdCvhlVIYCUMUhWrViwSdV3lI5toGxSOuRjuMaWV
         IbJCYY0jNsFC9Mme90jsYcuqUJvirpwpQvh6S1WmtKEOx2H9AvhxT4vknBWIQnjO7IDy
         5jSv6Oej0c/QJVC5wYdy0arfoIw4Go0UKYaVbjViGstV8gsY+rjqfKyK3HujGaM4QI2/
         0Si1eMGwnT2Ros8DyPHg9iSx+VhGFNWwu19ooNtmXHYEeh/Zw2vD7cJxl/Z6ZZ4TdgrK
         RIeP8pINbPGhXrk27CZhf2MPoz1UbtxFY+AN8IKQhp7glVgOaV3gLbupOefIrxsMFtDD
         GW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jqx1HO/XId0GJ3ue+sgoNKZespsPL3K2xwqbKDpT4Z8=;
        b=RqSUHB50KXt1O0DEEIJ23821m0ogclPTybYY9SWagSgNoMYAsZ2qKzV0rvkQgWxaXz
         ttonSIsxL9+23/ofVL015NWvJMCcOvKzzHpGuaZIlbofGL4YUIIqUQbZmxVyDXz/twip
         xl2t7p/7c0jS4H6iigdpD8tpc30S5RbugFsGdL1S6Bi2UWzUkL4libhrin0T+jn3zKNY
         n2BLTnvXpEMDt0pjpGlYwUOv5RGuwVafqikbaqeB3Uzvo3Op7xp6f7IvmtT3Ze7z3IjO
         zbf9zvzahWav1jCAJ4g+3Z1d6vEWNxSL/zhjQYJrwmisZhkzFcASuSv3Cbq6l41YqaQl
         ZJ6g==
X-Gm-Message-State: AOAM531SLN5uYgGzFJIGXUUnPvWxOaF+YvQZDqktESP3zQyPdYNsRwcm
        HjymEiPNzipMw0w4heGx7t54RSbp4AoDkImbUPkdpcuA
X-Google-Smtp-Source: ABdhPJwDvsoSJdwvQcWZaoSVoJexMFalqqhyG9QHDWiAie63dyRK4SBo1tRqk0uaLKxRPgzVO3JyCZV8AP3wZBQMGx4=
X-Received: by 2002:a05:6e02:5cb:: with SMTP id l11mr13267786ils.198.1643643139591;
 Mon, 31 Jan 2022 07:32:19 -0800 (PST)
MIME-Version: 1.0
References: <164364196407.1476539.8450117784231043601.stgit@warthog.procyon.org.uk>
 <164364202369.1476539.452557132083658522.stgit@warthog.procyon.org.uk>
In-Reply-To: <164364202369.1476539.452557132083658522.stgit@warthog.procyon.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 31 Jan 2022 17:32:08 +0200
Message-ID: <CAOQ4uxit42u7BSM_UAOc9gFsDb5b9JeEh1m_gCKMO7pxrtsAiA@mail.gmail.com>
Subject: Re: [PATCH 2/5] vfs: Add tracepoints for inode_excl_inuse_trylock/unlock
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-cachefs@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 5:13 PM David Howells <dhowells@redhat.com> wrote:
>
> Add tracepoints for inode_excl_inuse_trylock/unlock() to record successful
> and lock, failed lock, successful unlock and unlock when it wasn't locked.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Amir Goldstein <amir73il@gmail.com>
> cc: Miklos Szeredi <miklos@szeredi.hu>
> cc: linux-unionfs@vger.kernel.org
> cc: linux-cachefs@redhat.com
> ---
>
>  fs/inode.c           |   21 +++++++++++++++++----
>  fs/overlayfs/super.c |   10 ++++++----
>  include/linux/fs.h   |    9 +++++++--
>  3 files changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/fs/inode.c b/fs/inode.c
> index 954719f66113..61b93a89853f 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -22,6 +22,8 @@
>  #include <linux/iversion.h>
>  #include <trace/events/writeback.h>
>  #include "internal.h"
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/vfs.h>
>
>  /*
>   * Inode locking rules:
> @@ -2409,11 +2411,14 @@ EXPORT_SYMBOL(current_time);
>  /**
>   * inode_excl_inuse_trylock - Try to exclusively lock an inode for kernel access
>   * @dentry: Reference to the inode to be locked
> + * @o: Private reference for the kernel service
> + * @who: Which kernel service is trying to gain the lock
>   *
>   * Try to gain exclusive access to an inode for a kernel service, returning
>   * true if successful.
>   */
> -bool inode_excl_inuse_trylock(struct dentry *dentry)
> +bool inode_excl_inuse_trylock(struct dentry *dentry, unsigned int o,
> +                             enum inode_excl_inuse_by who)
>  {
>         struct inode *inode = d_inode(dentry);
>         bool locked = false;
> @@ -2421,7 +2426,10 @@ bool inode_excl_inuse_trylock(struct dentry *dentry)
>         spin_lock(&inode->i_lock);
>         if (!(inode->i_state & I_EXCL_INUSE)) {
>                 inode->i_state |= I_EXCL_INUSE;
> +               trace_inode_excl_inuse_lock(inode, o, who);
>                 locked = true;
> +       } else {
> +               trace_inode_excl_inuse_lock_failed(inode, o, who);
>         }
>         spin_unlock(&inode->i_lock);
>
> @@ -2432,18 +2440,23 @@ EXPORT_SYMBOL(inode_excl_inuse_trylock);
>  /**
>   * inode_excl_inuse_unlock - Unlock exclusive kernel access to an inode
>   * @dentry: Reference to the inode to be unlocked
> + * @o: Private reference for the kernel service
>   *
>   * Drop exclusive access to an inode for a kernel service.  A warning is given
>   * if the inode was not marked for exclusive access.
>   */
> -void inode_excl_inuse_unlock(struct dentry *dentry)
> +void inode_excl_inuse_unlock(struct dentry *dentry, unsigned int o)
>  {
>         if (dentry) {
>                 struct inode *inode = d_inode(dentry);
>
>                 spin_lock(&inode->i_lock);
> -               WARN_ON(!(inode->i_state & I_EXCL_INUSE));
> -               inode->i_state &= ~I_EXCL_INUSE;
> +               if (WARN_ON(!(inode->i_state & I_EXCL_INUSE))) {
> +                       trace_inode_excl_inuse_unlock_bad(inode, o);
> +               } else {
> +                       inode->i_state &= ~I_EXCL_INUSE;
> +                       trace_inode_excl_inuse_unlock(inode, o);
> +               }
>                 spin_unlock(&inode->i_lock);
>         }
>  }
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 5c3361a2dc7c..6434ae11496d 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -224,10 +224,10 @@ static void ovl_free_fs(struct ovl_fs *ofs)
>         dput(ofs->indexdir);
>         dput(ofs->workdir);
>         if (ofs->workdir_locked)
> -               inode_excl_inuse_unlock(ofs->workbasedir);
> +               inode_excl_inuse_unlock(ofs->workbasedir, 0);
>         dput(ofs->workbasedir);
>         if (ofs->upperdir_locked)
> -               inode_excl_inuse_unlock(ovl_upper_mnt(ofs)->mnt_root);
> +               inode_excl_inuse_unlock(ovl_upper_mnt(ofs)->mnt_root, 0);
>
>         /* Hack!  Reuse ofs->layers as a vfsmount array before freeing it */
>         mounts = (struct vfsmount **) ofs->layers;
> @@ -1239,7 +1239,8 @@ static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
>         if (upper_mnt->mnt_sb->s_flags & SB_NOSEC)
>                 sb->s_flags |= SB_NOSEC;
>
> -       if (inode_excl_inuse_trylock(ovl_upper_mnt(ofs)->mnt_root)) {
> +       if (inode_excl_inuse_trylock(ovl_upper_mnt(ofs)->mnt_root, 0,
> +                                    inode_excl_inuse_by_overlayfs)) {
>                 ofs->upperdir_locked = true;
>         } else {
>                 err = ovl_report_in_use(ofs, "upperdir");
> @@ -1499,7 +1500,8 @@ static int ovl_get_workdir(struct super_block *sb, struct ovl_fs *ofs,
>
>         ofs->workbasedir = dget(workpath.dentry);
>
> -       if (inode_excl_inuse_trylock(ofs->workbasedir)) {
> +       if (inode_excl_inuse_trylock(ofs->workbasedir, 0,
> +                                    inode_excl_inuse_by_overlayfs)) {

More incentive to keep the ovl_* wrappers.

Thanks,
Amir.

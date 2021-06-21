Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B573AE602
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 11:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFUJ3y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 05:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhFUJ3x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:29:53 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BB0C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 02:27:38 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id c17so6105088uao.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 02:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oO9lmC45H7rnXtiSXchw6M5sQOeL19adAYmIb1tRN1A=;
        b=qi1PZnR9hhovf2zOKGBxegPmYZAWA5tiZIGWAVHnCEF1BiqoZfZAuWJ1KMSJmXTzkA
         lATHyEAQgh00BdEjFAa4K7cGUk63SNFpH3V5LQ0DwGg/SJN2RxJSlhDO1KOxBp2OIQ1Z
         7a/SSPpsnVwnq8bOaR+jR+5tco1730x1XRKcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oO9lmC45H7rnXtiSXchw6M5sQOeL19adAYmIb1tRN1A=;
        b=OQeAc70L5RcvmPSXx7/qe6dvtO+e7MZHR6PoXe6eQrJWa0PM07gB/KqFAQiXnZ8+AB
         ap65Mra1uMQNdjSORuQ001VxUr8jZ8MKf3STD9lVtEH7mdpegatroM6Gn9QJnXl/G6Mv
         MWvk0mKu1YDpsoz6cAYeZEDLAYu2UM6aPEZLeW01is7t0Prial2JQ8lYrFiIzlNtfj1j
         N9Qwcrkf3olxD93FkU5Pd+6dgEcnxY8NhJgky3Dw5TZEnfG+yYXIVexdu0FeHo85si56
         B+rf7G0rBjK1D192mr7d2mlSDRnqh1UXrFHqYfo/aakDJZmXbneB8S+xAl18t24GEx7P
         mvhg==
X-Gm-Message-State: AOAM531/tU1ShqWsjkcwML1xY4F7eWFsFtbKa0yuNh/b1mCDTJclDZp4
        KvlchFyavZdWnvaMf9/Q/VwJB4r8hTv7EDaqkP7m7w==
X-Google-Smtp-Source: ABdhPJy9/9x2ToscpIcQ+6ELHInR5mfV4rWvrCmQLeKsQpUzQMpmXQsOobt5d8KTcaEcpoAjZ9av9I991ClXAqjaJ7w=
X-Received: by 2002:ab0:6998:: with SMTP id t24mr21407865uaq.72.1624267657443;
 Mon, 21 Jun 2021 02:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210609181158.479781-1-amir73il@gmail.com>
In-Reply-To: <20210609181158.479781-1-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Jun 2021 11:27:26 +0200
Message-ID: <CAJfpegtuHerUsWx4Sxxg=EGkg5YEVPQ2A0iYqt0bRn_F-+00uA@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix illegal access to inode with reused nodeid
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Max Reitz <mreitz@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 9 Jun 2021 at 20:12, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Server responds to LOOKUP and other ops (READDIRPLUS/CREATE/MKNOD/...)
> with outarg containing nodeid and generation.
>
> If a fuse inode is found in inode cache with the same nodeid but
> different generation, the existing fuse inode should be unhashed and
> marked "bad" and a new inode with the new generation should be hashed
> instead.
>
> This can happen, for example, with passhrough fuse filesystem that
> returns the real filesystem ino/generation on lookup and where real inode
> numbers can get recycled due to real files being unlinked not via the fuse
> passthrough filesystem.
>
> With current code, this situation will not be detected and an old fuse
> dentry that used to point to an older generation real inode, can be used
> to access a completely new inode, which should be accessed only via the
> new dentry.
>
> Note that because the FORGET message carries the nodeid w/o generation,
> the server should wait to get FORGET counts for the nlookup counts of
> the old and reused inodes combined, before it can free the resources
> associated to that nodeid.
>
> Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxgDMGUpK35huwqFYGH_idBB8S6eLiz85o0DDKOyDH4Syg@mail.gmail.com/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Miklos,
>
> I was able to reproduce this issue with a passthrough fs that stored
> ino+generation and uses then to open fd on lookup.
>
> I extended libfuse's test_syscalls [1] program to demonstrate the issue
> described in commit message.
>
> Max, IIUC, you are making a modification to virtiofs-rs that would
> result is being exposed to this bug.  You are welcome to try out the
> test and let me know if you can reproduce the issue.
>
> Note that some test_syscalls test fail with cache enabled, so libfuse's
> test_examples.py only runs test_syscalls in cache disabled config.
>
> Thanks,
> Amir.
>
> [1] https://github.com/amir73il/libfuse/commits/test-reused-inodes
>
>  fs/fuse/dir.c     | 3 ++-
>  fs/fuse/fuse_i.h  | 9 +++++++++
>  fs/fuse/inode.c   | 4 ++--
>  fs/fuse/readdir.c | 7 +++++--
>  4 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 1b6c001a7dd1..b06628fd7d8e 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -239,7 +239,8 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
>                 if (!ret) {
>                         fi = get_fuse_inode(inode);
>                         if (outarg.nodeid != get_node_id(inode) ||
> -                           (bool) IS_AUTOMOUNT(inode) != (bool) (outarg.attr.flags & FUSE_ATTR_SUBMOUNT)) {
> +                           fuse_stale_inode(inode, outarg.generation,
> +                                            &outarg.attr)) {

This changes behavior in the inode_wrong_type() case.  I guess that
was not intended.


>                                 fuse_queue_forget(fm->fc, forget,
>                                                   outarg.nodeid, 1);
>                                 goto invalid;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 7e463e220053..f1bd28c176a9 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -867,6 +867,15 @@ static inline u64 fuse_get_attr_version(struct fuse_conn *fc)
>         return atomic64_read(&fc->attr_version);
>  }
>
> +static inline bool fuse_stale_inode(const struct inode *inode, int generation,
> +                                   struct fuse_attr *attr)
> +{
> +       return inode->i_generation != generation ||
> +               inode_wrong_type(inode, attr->mode) ||
> +               (bool) IS_AUTOMOUNT(inode) !=
> +               (bool) (attr->flags & FUSE_ATTR_SUBMOUNT);
> +}
> +
>  static inline void fuse_make_bad(struct inode *inode)
>  {
>         remove_inode_hash(inode);
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 393e36b74dc4..257bb3e1cac8 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -350,8 +350,8 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
>                 inode->i_generation = generation;
>                 fuse_init_inode(inode, attr);
>                 unlock_new_inode(inode);
> -       } else if (inode_wrong_type(inode, attr->mode)) {
> -               /* Inode has changed type, any I/O on the old should fail */
> +       } else if (fuse_stale_inode(inode, generation, attr)) {

This one adds the automount check.  That should be okay, since
directories must never have aliases and such a beast would error out
anyway later on d_splice_alias.

> +               /* nodeid was reused, any I/O on the old inode should fail */
>                 fuse_make_bad(inode);
>                 iput(inode);
>                 goto retry;
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index 277f7041d55a..bc267832310c 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -200,9 +200,12 @@ static int fuse_direntplus_link(struct file *file,
>         if (!d_in_lookup(dentry)) {
>                 struct fuse_inode *fi;
>                 inode = d_inode(dentry);
> +               if (inode && get_node_id(inode) != o->nodeid)
> +                       inode = NULL;
>                 if (!inode ||
> -                   get_node_id(inode) != o->nodeid ||
> -                   inode_wrong_type(inode, o->attr.mode)) {
> +                   fuse_stale_inode(inode, o->generation, &o->attr)) {

Again, automount check added, I'm not at all sure how automount and
readdirplus interact.    This needs to be looked at (though it's
mostly a separate issue from this patch).

Thanks,
Miklos

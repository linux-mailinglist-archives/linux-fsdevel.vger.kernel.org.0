Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C617F3A9E7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 17:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhFPPFv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 11:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbhFPPFu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:05:50 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F82C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 08:03:43 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id q15so3374268ioi.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 08:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0OsHGcSJEodswIaE0lnccwazjsPx7DhA2l2pVTms8EI=;
        b=lWlbh0hrsx+YTOwKorAMOB8JD5pekrtpNKWvSP7t48HT+4WnyV65F7FFtVGu649gC+
         LZjYyTs3/Ny6QLKrHLk7NUc1dxwU+/SYfU8eicynHKapFyAiHsVjeM7rcn8csu+BO7Tv
         Ac4Cen/bxtjfJszqqAMX5imznbTwX+6SL7dNAOn3II9CEKf/OLYIG9jr8Zq6uGVyfYxl
         Wcpl3UXCNsZgxkwv6HVpd1N4frMTZrO/sZWN/jhpXJKkJUocPx/OaiIcSgmA+9b7IJz7
         8WpdXZZGgf4OV17fHop7fQbmfn7IpghOtxceNtJHiC7SpdkshVlhkGSjmN46GM/DNhBt
         9r0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0OsHGcSJEodswIaE0lnccwazjsPx7DhA2l2pVTms8EI=;
        b=TQSnJKN6E02B/DLeP6ev9qWvIOWBG+7xKwZylqWEl+LuJmWavniFuh/eQxVtxSifZj
         42LiUa7rstoSTJQVbWWNZhlC3DlRqp0EqKuifQVDv+tvlGxlOA9tH9mYIGOwFTJxxdVv
         HNQYnvTSq1xGPUTwUWtLog3KR28Ksstc2VTrlNTnMafarFMNf1zoutlWC72fpgKaLM7f
         3US9bwIom5QHUYZ6YwnNEJletUJy6xZT/wphlZu/Vrzifdk7AOriYFGLp4J2La7KcrJ/
         V8iyaSZXWMhOYioGGgkPes03/sW+eIGH8i4QYWptA9DHsllFeiv4fqRtTnGSBcURyaMm
         ar8g==
X-Gm-Message-State: AOAM530Et/SjFtnvHiZrFy39jXilv9kh2N17NmRxXNCFCIY/nVivlFR2
        3M/Zmgg/SzREKccyZtD1K1jOtKuWDDVcQWVnF5LHjfkXWIA=
X-Google-Smtp-Source: ABdhPJxrjgxx6DwBosOMeJAlFJWOLUUbiUwYxH3c6OrW6U00jzkv93WShc9AbOaPk43dS4h9wp5TIEgK5k49abbjDY4=
X-Received: by 2002:a05:6602:2d83:: with SMTP id k3mr343365iow.5.1623855822988;
 Wed, 16 Jun 2021 08:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210609181158.479781-1-amir73il@gmail.com>
In-Reply-To: <20210609181158.479781-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 16 Jun 2021 18:03:31 +0300
Message-ID: <CAOQ4uxi3vK1eyWk69asycmo5PTyUE9+o7-Ha17CTXYytQiWPZQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix illegal access to inode with reused nodeid
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Max Reitz <mreitz@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Nikolaus Rath <Nikolaus@rath.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 9, 2021 at 9:12 PM Amir Goldstein <amir73il@gmail.com> wrote:
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

Miklos,

Not sure if you got to look at this already, but I had noticed that the
link above is broken because I deleted the branch after Nikolaus
merged it to upstream libfuse, so here is a new link to the PR [2]
with some more relevant context.

Per request from Nikolaus, I modified the passthrough_hp example
to reuse inodes on last close+unlink, so it now hits the failure in the
new test with upstream kernel and it passes the test with this kernel fix.

Thanks,
Amir.

[2] https://github.com/libfuse/libfuse/pull/612


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
> +                       if (inode)
> +                               fuse_make_bad(inode);
>                         d_invalidate(dentry);
>                         dput(dentry);
>                         goto retry;
> --
> 2.31.1
>

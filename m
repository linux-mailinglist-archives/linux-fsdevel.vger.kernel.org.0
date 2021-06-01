Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB172397370
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 14:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhFAMnW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 08:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbhFAMnW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 08:43:22 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72F8C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jun 2021 05:41:40 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id x1so8358995uau.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jun 2021 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dvdI4K7xdpXoAJCjAWXLfOAj3uqqE6BcIG55D55xcwk=;
        b=SxIYCfjRYTwM71+oo05sup7m18uGcPGNFDLV5n0+U6ad/Nk331Q2+2GOflySuc/+of
         ALcuZ0RIp4QpjtdDWRtsZ1fjueXsHdFb7YxZy7Qfa3x8I6UU3tbUpe3NQ5KR7APbQyPo
         X86d8Rdki8THowvYv24AvSoXQGSWknKsjPGXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dvdI4K7xdpXoAJCjAWXLfOAj3uqqE6BcIG55D55xcwk=;
        b=gjtPTXwfPupd0L5YQKhCIOTxM4/n1eFtiFmCTzjeMBErgmyX3Xt8q3/3dC1/hriwYz
         8MXEY+/YHWSH/pGMXyhJ5ACxM0BHVdfl9ncwbmG4YW+e51GlZOdBeMvbyfRULsY8LIeh
         F5s6RzhZWOOZj8o6G6ADFKqfRcOi5dAbsG7+fCQM5ZvCRsOuY3q4FRiqxpGtkllLq07/
         CE2Q4euoswad0GRR23YYz7aDDF1QrzuCHu00TeDjk3/NsBwn9rkVitfv7+iacNw2BdIa
         yftYSFYTYDqgcrC0eqlZQUS2iCoM0HsjOad9D53s/gm4c/qIdJU4Wb67KbZBXOy8ptW0
         OrWQ==
X-Gm-Message-State: AOAM532QbDg/NZ1u/XaPYCrZ75Yi7L23+aubNLBfZtu7hFVeaDM1Ag9s
        6QUm4E2uoBZxOf/6nows2Ko42Eok1WQSxqaA/uZCpQ==
X-Google-Smtp-Source: ABdhPJw0vFyaijKFI+sMQ46NVitM4k56BVUtgf+/hqX/yZQQy427466Ac3S2HSl9MKUFrqltU2w/j8wpDvYMdRoS8DU=
X-Received: by 2002:a1f:32cf:: with SMTP id y198mr581604vky.23.1622551298685;
 Tue, 01 Jun 2021 05:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
 <162218364554.34379.636306635794792903.stgit@web.messagingengine.com>
In-Reply-To: <162218364554.34379.636306635794792903.stgit@web.messagingengine.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 1 Jun 2021 14:41:27 +0200
Message-ID: <CAJfpeguUj5WKtKZsn_tZZNpiL17ggAPcPBXdpA03aAnjaexWug@mail.gmail.com>
Subject: Re: [REPOST PATCH v4 2/5] kernfs: use VFS negative dentry caching
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 28 May 2021 at 08:34, Ian Kent <raven@themaw.net> wrote:
>
> If there are many lookups for non-existent paths these negative lookups
> can lead to a lot of overhead during path walks.
>
> The VFS allows dentries to be created as negative and hashed, and caches
> them so they can be used to reduce the fairly high overhead alloc/free
> cycle that occurs during these lookups.

Obviously there's a cost associated with negative caching too.  For
normal filesystems it's trivially worth that cost, but in case of
kernfs, not sure...

Can "fairly high" be somewhat substantiated with a microbenchmark for
negative lookups?

More comments inline.

>
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  fs/kernfs/dir.c |   55 +++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 33 insertions(+), 22 deletions(-)
>
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 4c69e2af82dac..5151c712f06f5 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -1037,12 +1037,33 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
>         if (flags & LOOKUP_RCU)
>                 return -ECHILD;
>
> -       /* Always perform fresh lookup for negatives */
> -       if (d_really_is_negative(dentry))
> -               goto out_bad_unlocked;
> +       mutex_lock(&kernfs_mutex);
>
>         kn = kernfs_dentry_node(dentry);
> -       mutex_lock(&kernfs_mutex);
> +
> +       /* Negative hashed dentry? */
> +       if (!kn) {
> +               struct kernfs_node *parent;
> +
> +               /* If the kernfs node can be found this is a stale negative
> +                * hashed dentry so it must be discarded and the lookup redone.
> +                */
> +               parent = kernfs_dentry_node(dentry->d_parent);

This doesn't look safe WRT a racing sys_rename().  In this case
d_move() is called only with parent inode locked, but not with
kernfs_mutex while ->d_revalidate() may not have parent inode locked.
After d_move() the old parent dentry can be freed, resulting in use
after free.  Easily fixed by dget_parent().

> +               if (parent) {
> +                       const void *ns = NULL;
> +
> +                       if (kernfs_ns_enabled(parent))
> +                               ns = kernfs_info(dentry->d_sb)->ns;
> +                       kn = kernfs_find_ns(parent, dentry->d_name.name, ns);

Same thing with d_name.  There's
take_dentry_name_snapshot()/release_dentry_name_snapshot() to properly
take care of that.


> +                       if (kn)
> +                               goto out_bad;
> +               }
> +
> +               /* The kernfs node doesn't exist, leave the dentry negative
> +                * and return success.
> +                */
> +               goto out;
> +       }
>
>         /* The kernfs node has been deactivated */
>         if (!kernfs_active_read(kn))
> @@ -1060,12 +1081,11 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
>         if (kn->parent && kernfs_ns_enabled(kn->parent) &&
>             kernfs_info(dentry->d_sb)->ns != kn->ns)
>                 goto out_bad;
> -
> +out:
>         mutex_unlock(&kernfs_mutex);
>         return 1;
>  out_bad:
>         mutex_unlock(&kernfs_mutex);
> -out_bad_unlocked:
>         return 0;
>  }
>
> @@ -1080,33 +1100,24 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
>         struct dentry *ret;
>         struct kernfs_node *parent = dir->i_private;
>         struct kernfs_node *kn;
> -       struct inode *inode;
> +       struct inode *inode = NULL;
>         const void *ns = NULL;
>
>         mutex_lock(&kernfs_mutex);
> -
>         if (kernfs_ns_enabled(parent))
>                 ns = kernfs_info(dir->i_sb)->ns;
>
>         kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
> -
> -       /* no such entry */
> -       if (!kn || !kernfs_active(kn)) {
> -               ret = NULL;
> -               goto out_unlock;
> -       }
> -
>         /* attach dentry and inode */
> -       inode = kernfs_get_inode(dir->i_sb, kn);
> -       if (!inode) {
> -               ret = ERR_PTR(-ENOMEM);
> -               goto out_unlock;
> +       if (kn && kernfs_active(kn)) {
> +               inode = kernfs_get_inode(dir->i_sb, kn);
> +               if (!inode)
> +                       inode = ERR_PTR(-ENOMEM);
>         }
> -
> -       /* instantiate and hash dentry */
> +       /* instantiate and hash (possibly negative) dentry */
>         ret = d_splice_alias(inode, dentry);
> - out_unlock:
>         mutex_unlock(&kernfs_mutex);
> +
>         return ret;
>  }
>
>
>

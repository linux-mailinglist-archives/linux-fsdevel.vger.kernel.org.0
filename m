Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82B96D5335
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 23:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjDCVOc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 17:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjDCVOb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:14:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910FFEE;
        Mon,  3 Apr 2023 14:14:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 286B662B39;
        Mon,  3 Apr 2023 21:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60DEC433EF;
        Mon,  3 Apr 2023 21:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680556469;
        bh=yN1kxmdF+kV6svO+Sq3uH3oZqQwQEsgKwpal+AbRpVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eFpuM0cjR7l2+MiiamOwpkBDsictwlCb3racMAWtnWrtm6ugIAER0IUy1MpVVbMsO
         HZiBxd5qJdm+hre7ZgcknhSPjqRWjLOTO1CBXkdG3I0DgUdigg8zd7kbfDWPFslTpX
         WD8NINcqJF8WrNd4wH7A6pDefWEVzlftPHUTfpcqS0iHS1H6FThrwxMVz8msNn9W6b
         fZAnzOsknKUbVOTSmwtjXN1fwos/+WCNQ24foRYuCOSf2MgyqgJEoxHGkZq6t8Y9Wd
         NcK693n+5pUhRPrIw1QRIyLqtFUjft/bmvd7oFM6WNZYPJhzmr76PuzuKlVVqHwTLy
         SJkDG1y89FExA==
Date:   Mon, 3 Apr 2023 23:14:23 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     mszeredi@redhat.com, flyingpeng@tencent.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Bernd Schubert <bschubert@ddn.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Subject: Re: [RFC PATCH v2 8/9] namespace: add sb_revalidate_bindmounts helper
Message-ID: <20230403-barmaid-smuggling-e70e604aa34f@brauner>
References: <20230403144517.347517-1-aleksandr.mikhalitsyn@canonical.com>
 <20230403144517.347517-9-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230403144517.347517-9-aleksandr.mikhalitsyn@canonical.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 03, 2023 at 04:45:16PM +0200, Alexander Mikhalitsyn wrote:
> Useful if for some reason bindmounts root dentries get invalidated
> but it's needed to revalidate existing bindmounts without remounting.
> 
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Stéphane Graber <stgraber@ubuntu.com>
> Cc: Seth Forshee <sforshee@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Andrei Vagin <avagin@gmail.com>
> Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> Cc: Bernd Schubert <bschubert@ddn.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: criu@openvz.org
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
>  fs/namespace.c                | 90 +++++++++++++++++++++++++++++++++++
>  include/linux/mnt_namespace.h |  3 ++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index bc0f15257b49..b74d00d6abb0 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -568,6 +568,96 @@ static int mnt_make_readonly(struct mount *mnt)
>  	return ret;
>  }
>  
> +struct bind_mount_list_item {
> +	struct list_head list;
> +	struct vfsmount *mnt;
> +};
> +
> +/*
> + * sb_revalidate_bindmounts - Relookup/reset bindmounts root dentries
> + *
> + * Useful if for some reason bindmount root dentries get invalidated
> + * but it's needed to revalidate existing bindmounts without remounting.
> + */
> +int sb_revalidate_bindmounts(struct super_block *sb)

It's difficult to not strongly dislike this patchset on the basis of the
need for a function like this alone. And I just have to say it even if I
normally try not to do this: This whole function is bonkers in my opinion.

But leaving that aside for a second. This really needs detailed
explanations on locking, assumptions, and an explanation what you're
doing here. This looks crazy to me and definitely isn't fit to be a
generic helper in this form.

> +{
> +	struct mount *mnt;
> +	struct bind_mount_list_item *bmnt, *next;
> +	int err = 0;
> +	struct vfsmount *root_mnt = NULL;
> +	LIST_HEAD(mnt_to_update);
> +	char *buf;
> +
> +	buf = (char *) __get_free_page(GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	lock_mount_hash();
> +	list_for_each_entry(mnt, &sb->s_mounts, mnt_instance) {
> +		/* we only want to touch bindmounts */
> +		if (mnt->mnt.mnt_root == sb->s_root) {
> +			if (!root_mnt)
> +				root_mnt = mntget(&mnt->mnt);
> +
> +			continue;
> +		}
> +
> +		bmnt = kzalloc(sizeof(struct bind_mount_list_item), GFP_NOWAIT | __GFP_NOWARN);

Allocating under lock_mount_hash() even if doable with this flag
combination should be avoided at all costs imho. That just seems hacky.

> +		if (!bmnt) {
> +			err = -ENOMEM;
> +			goto exit;

You're exiting the function with lock_mount_hash() held...

> +		}
> +
> +		bmnt->mnt = mntget(&mnt->mnt);
> +		list_add_tail(&bmnt->list, &mnt_to_update);
> +	}
> +	unlock_mount_hash();

You've dropped unlock_mount_hash() and the function doesn't hold
namespace_lock() and isn't documented as requiring the caller to hold
it. And the later patch that uses this doesn't afaict (although I
haven't looked at any of the fuse specific stuff). So this is open to
all sorts of races with mount and unmount now. This needs an explanation
why that doesn't matter.

> +
> +	/* TODO: get rid of this limitation */

Confused about this comment.

> +	if (!root_mnt) {
> +		err = -ENOENT;
> +		goto exit;
> +	}
> +
> +	list_for_each_entry_safe(bmnt, next, &mnt_to_update, list) {

No one else can access that list so list_for_each_entry_safe() seems
pointless.

> +		struct vfsmount *cur_mnt = bmnt->mnt;
> +		struct path path;
> +		struct dentry *old_root;
> +		char *p;
> +
> +		p = dentry_path(cur_mnt->mnt_root, buf, PAGE_SIZE);
> +		if (IS_ERR(p))
> +			goto exit;
> +
> +		/* TODO: are these lookup flags fully safe and correct? */
> +		err = vfs_path_lookup(root_mnt->mnt_root, root_mnt,
> +				p, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT|LOOKUP_REVAL, &path);
> +		if (err)
> +			goto exit;
> +
> +		/* replace bindmount root dentry */
> +		lock_mount_hash();
> +		old_root = cur_mnt->mnt_root;
> +		cur_mnt->mnt_root = dget(path.dentry);

mnt->mnt_root isn't protected by lock_mount_hash(). It's invariant after
it has been set and a lot of code just assumes that it's stable.

Top of my hat, since you're not holding namespace_lock() mount
propagation can be going on concurrently so propagate_one() can check if
(!is_subdir(mp->m_dentry, m->mnt.mnt_root)) while you're happily
updating it. A lot of code could actually be touching mnt->mnt_root
while you're updating it.

There's probably a lot more issues with this I'm just not seeing without
spending more time on this. But NAK on this as it stands. Sorry.

> +		dput(old_root);
> +		unlock_mount_hash();
> +
> +		path_put(&path);
> +	}
> +
> +exit:
> +	free_page((unsigned long) buf);
> +	mntput(root_mnt);
> +	list_for_each_entry_safe(bmnt, next, &mnt_to_update, list) {
> +		list_del(&bmnt->list);
> +		mntput(bmnt->mnt);
> +		kfree(bmnt);
> +	}
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(sb_revalidate_bindmounts);

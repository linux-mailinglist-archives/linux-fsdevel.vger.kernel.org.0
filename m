Return-Path: <linux-fsdevel+bounces-5044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B62EA807972
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 21:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58C2EB20954
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 20:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA5041859
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 20:35:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E78ABA;
	Wed,  6 Dec 2023 11:58:09 -0800 (PST)
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 18BDD801; Wed,  6 Dec 2023 13:58:07 -0600 (CST)
Date: Wed, 6 Dec 2023 13:58:07 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
	Karel Zak <kzak@redhat.com>, linux-fsdevel@vger.kernel.org,
	Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 3/4] listmount: small changes in semantics
Message-ID: <20231206195807.GA209606@mail.hallyn.com>
References: <20231128160337.29094-1-mszeredi@redhat.com>
 <20231128160337.29094-4-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128160337.29094-4-mszeredi@redhat.com>

On Tue, Nov 28, 2023 at 05:03:34PM +0100, Miklos Szeredi wrote:
> 1) Make permission checking consistent with statmount(2): fail if mount is
> unreachable from current root.  Previously it failed if mount was
> unreachable from root->mnt->mnt_root.
> 
> 2) List all submounts, even if unreachable from current root.  This is
> safe, since 1) will prevent listing unreachable mounts for unprivileged
> users.
> 
> 3) LSMT_ROOT is unchaged, it lists mounts under current root.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/namespace.c | 39 ++++++++++++++-------------------------
>  1 file changed, 14 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ad62cf7ee334..10cd651175b5 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5004,37 +5004,26 @@ static struct mount *listmnt_next(struct mount *curr)
>  	return node_to_mount(rb_next(&curr->mnt_node));
>  }
>  
> -static ssize_t do_listmount(struct mount *first, struct vfsmount *mnt,
> +static ssize_t do_listmount(struct mount *first, struct path *orig, u64 mnt_id,
>  			    u64 __user *buf, size_t bufsize,
>  			    const struct path *root)
>  {
> -	struct mount *r, *m = real_mount(mnt);
> -	struct path rootmnt = {
> -		.mnt = root->mnt,
> -		.dentry = root->mnt->mnt_root
> -	};
> -	struct path orig;
> +	struct mount *r;
>  	ssize_t ctr;
>  	int err;
>  
> -	if (!is_path_reachable(m, mnt->mnt_root, &rootmnt))
> -		return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;
> +	if (!capable(CAP_SYS_ADMIN) &&

Was there a reason to do the capable check first?  In general,
checking capable() when not needed is frowned upon, as it will
set the PF_SUPERPRIV flag.

> +	    !is_path_reachable(real_mount(orig->mnt), orig->dentry, root))
> +		return -EPERM;
>  
> -	err = security_sb_statfs(mnt->mnt_root);
> +	err = security_sb_statfs(orig->dentry);
>  	if (err)
>  		return err;
>  
> -	if (root->mnt == mnt) {
> -		orig = *root;
> -	} else {
> -		orig.mnt = mnt;
> -		orig.dentry = mnt->mnt_root;
> -	}
> -
>  	for (ctr = 0, r = first; r; r = listmnt_next(r)) {
> -		if (r == m)
> +		if (r->mnt_id_unique == mnt_id)
>  			continue;
> -		if (!is_path_reachable(r, r->mnt.mnt_root, &orig))
> +		if (!is_path_reachable(r, r->mnt.mnt_root, orig))
>  			continue;
>  
>  		if (ctr >= bufsize)
> @@ -5053,9 +5042,8 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
>  {
>  	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
>  	struct mnt_id_req kreq;
> -	struct vfsmount *mnt;
>  	struct mount *first;
> -	struct path root;
> +	struct path root, orig;
>  	u64 mnt_id;
>  	ssize_t ret;
>  
> @@ -5071,16 +5059,17 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
>  	down_read(&namespace_sem);
>  	get_fs_root(current->fs, &root);
>  	if (mnt_id == LSMT_ROOT) {
> -		mnt = root.mnt;
> +		orig = root;
>  	} else {
>  		ret = -ENOENT;
> -		mnt  = lookup_mnt_in_ns(mnt_id, ns);
> -		if (!mnt)
> +		orig.mnt  = lookup_mnt_in_ns(mnt_id, ns);
> +		if (!orig.mnt)
>  			goto err;
> +		orig.dentry = orig.mnt->mnt_root;
>  	}
>  	first = node_to_mount(rb_first(&ns->mounts));
>  
> -	ret = do_listmount(first, mnt, buf, bufsize, &root);
> +	ret = do_listmount(first, &orig, mnt_id, buf, bufsize, &root);
>  err:
>  	path_put(&root);
>  	up_read(&namespace_sem);
> -- 
> 2.41.0
> 


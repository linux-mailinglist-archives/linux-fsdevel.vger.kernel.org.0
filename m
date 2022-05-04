Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22E151AF80
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 22:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378292AbiEDUn3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 16:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378246AbiEDUnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 16:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E580D506D1
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 13:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651696786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=euEiHeFQqldqhUxZNJJ0cz+1ehU4YEDXUx0bdAR5qEQ=;
        b=K1sZnItpOBNCF3lyVE1MIDY2S1S/pJZbHo3EvslF3HdIbbAaizddqfKRw/YY3u5x8REt0T
        uibcwai5pCsWXC0P6Jz7XrK47g7S8Ku440vTXKUS0RBgFXTY8n0HyVvQ09jQDXF2MDidLI
        4NILp6VuNufMm0o0/n3k4D6BhkyGgfo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-SThtM3hKNfWDD_onWv1rYw-1; Wed, 04 May 2022 16:39:42 -0400
X-MC-Unique: SThtM3hKNfWDD_onWv1rYw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CFB63C7B127;
        Wed,  4 May 2022 20:39:41 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.16.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E133156CF28;
        Wed,  4 May 2022 20:39:41 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 0F016220463; Wed,  4 May 2022 16:39:41 -0400 (EDT)
Date:   Wed, 4 May 2022 16:39:40 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dharmendra Singh <dharamhans87@gmail.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        bschubert@ddn.com, Dharmendra Singh <dsingh@ddn.com>
Subject: Re: [PATCH v4 3/3] FUSE: Avoid lookup in d_revalidate()
Message-ID: <YnLkjDhcmEqTSpRr@redhat.com>
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <20220502102521.22875-4-dharamhans87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502102521.22875-4-dharamhans87@gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 02, 2022 at 03:55:21PM +0530, Dharmendra Singh wrote:
> From: Dharmendra Singh <dsingh@ddn.com>
> 
> With atomic open + lookup implemented, it is possible
> to avoid lookups in FUSE d_revalidate() for objects
> other than directories.
> 
> If FUSE is mounted with default permissions then this
> optimization is not possible as we need to fetch fresh
> inode attributes for permission check. This lookup
> skipped in d_revalidate() can be performed  as part of
> open call into libfuse which is made from fuse_file_open().
> And when we return from USER SPACE with file opened and
> fresh attributes, we can revalidate the inode.
> 
> Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
> Reported-by: kernel test robot <lkp@intel.com>
> 
> ---
>  fs/fuse/dir.c    | 89 ++++++++++++++++++++++++++++++++++++++++++------
>  fs/fuse/file.c   | 30 ++++++++++++++--
>  fs/fuse/fuse_i.h | 10 +++++-
>  fs/fuse/ioctl.c  |  2 +-
>  4 files changed, 115 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 6879d3a86796..1594fecc920f 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -196,6 +196,7 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
>   * the lookup once more.  If the lookup results in the same inode,
>   * then refresh the attributes, timeouts and mark the dentry valid.
>   */
> +
>  static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
>  {
>  	struct inode *inode;
> @@ -224,6 +225,17 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
>  
>  		fm = get_fuse_mount(inode);
>  
> +		/* If atomic open is supported by FUSE then use this opportunity
> +		 * (only for non-dir) to avoid this lookup and combine
> +		 * lookup + open into single call.
> +		 */
> +		if (!fm->fc->default_permissions && fm->fc->do_atomic_open &&
> +		    !(flags & (LOOKUP_EXCL | LOOKUP_REVAL)) &&
> +		    (flags & LOOKUP_OPEN) && !S_ISDIR(inode->i_mode)) {
> +			ret = 1;

So basically we think that VFS is going to do OPEN and calling
->revalidate() before that. So we are returning "1" to vfs saying
dentry is valid (despite the fact that we have no idea at this
point of time).

And later when open comes we are opening and revalidating inode etc.

Seriously, IMHO, all this seems very fragile and hard to understand
and maintain code. Things can go easily wrong if even little bit
of assumptions change in VFS.

This sounds more like VFS should know about it and if VFS knows
that filesystem supports facility where it can open + revalidate
at the same time, it should probably call that. Something like
->open_revalidate() etc. That would be much more maintainable code but
this feels like very fragile to me, IMHO.

Thanks
Vivek




> +			goto out;
> +		}
> +
>  		forget = fuse_alloc_forget();
>  		ret = -ENOMEM;
>  		if (!forget)
> @@ -515,14 +527,52 @@ static int get_security_context(struct dentry *entry, umode_t mode,
>  	return err;
>  }
>  
> +/*
> + * Revalidate the inode after we got fresh attributes from user space.
> + */
> +static int fuse_atomic_open_revalidate_inode(struct inode *reval_inode,
> +					     struct dentry *entry,
> +					     struct fuse_forget_link *forget,
> +					     struct fuse_entry_out *outentry,
> +					     u64 attr_version)
> +{
> +	struct fuse_inode *fi;
> +	struct fuse_conn *fc = get_fuse_conn(reval_inode);
> +
> +	/* Mode should be other than directory */
> +	BUG_ON(S_ISDIR(reval_inode->i_mode));
> +
> +	if (outentry->nodeid != get_node_id(reval_inode)) {
> +		fuse_queue_forget(fc, forget, outentry->nodeid, 1);
> +		return -ESTALE;
> +	}
> +	if (fuse_stale_inode(reval_inode, outentry->generation,
> +			     &outentry->attr)) {
> +		fuse_make_bad(reval_inode);
> +		return -ESTALE;
> +	}
> +	fi = get_fuse_inode(reval_inode);
> +	spin_lock(&fi->lock);
> +	fi->nlookup++;
> +	spin_unlock(&fi->lock);
> +
> +	forget_all_cached_acls(reval_inode);
> +	fuse_change_attributes(reval_inode, &outentry->attr,
> +			       entry_attr_timeout(outentry), attr_version);
> +	fuse_change_entry_timeout(entry, outentry);
> +	return 0;
> +}
> +
> +
>  /*
>   * This is common function for initiating atomic operations into libfuse.
>   * Currently being used by Atomic create(atomic lookup + create) and
>   * Atomic open(atomic lookup + open).
>   */
> -static int fuse_atomic_do_common(struct inode *dir, struct dentry *entry,
> +static int fuse_do_atomic_common(struct inode *dir, struct dentry *entry,
>  				 struct dentry **alias, struct file *file,
> -				 unsigned int flags, umode_t mode, uint32_t opcode)
> +				 struct inode *reval_inode, unsigned int flags,
> +				 umode_t mode, uint32_t opcode)
>  {
>  	int err;
>  	struct inode *inode;
> @@ -541,6 +591,8 @@ static int fuse_atomic_do_common(struct inode *dir, struct dentry *entry,
>  	bool atomic_create = (opcode == FUSE_ATOMIC_CREATE ? true : false);
>  	bool create_op = (opcode == FUSE_CREATE ||
>  			  opcode == FUSE_ATOMIC_CREATE) ? true : false;
> +	u64 attr_version = fuse_get_attr_version(fm->fc);
> +
>  	if (alias)
>  		*alias = NULL;
>  
> @@ -609,6 +661,20 @@ static int fuse_atomic_do_common(struct inode *dir, struct dentry *entry,
>  	ff->fh = outopen.fh;
>  	ff->nodeid = outentry.nodeid;
>  	ff->open_flags = outopen.open_flags;
> +
> +	/* Inode revalidation was bypassed previously for type other than
> +	 * directories, revalidate now as we got fresh attributes.
> +	 */
> +	if (reval_inode) {
> +		err = fuse_atomic_open_revalidate_inode(reval_inode, entry,
> +							forget, &outentry,
> +							attr_version);
> +		if (err)
> +			goto out_free_ff;
> +		inode = reval_inode;
> +		kfree(forget);
> +		goto out_finish_open;
> +	}
>  	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
>  			  &outentry.attr, entry_attr_timeout(&outentry), 0);
>  	if (!inode) {
> @@ -659,6 +725,7 @@ static int fuse_atomic_do_common(struct inode *dir, struct dentry *entry,
>  	if (!atomic_create || (outopen.open_flags & FOPEN_FILE_CREATED))
>  		fuse_dir_changed(dir);
>  	err = finish_open(file, entry, generic_file_open);
> +out_finish_open:
>  	if (err) {
>  		fi = get_fuse_inode(inode);
>  		fuse_sync_release(fi, ff, flags);
> @@ -686,7 +753,7 @@ static int fuse_atomic_create(struct inode *dir, struct dentry *entry,
>  	if (fc->no_atomic_create)
>  		return -ENOSYS;
>  
> -	err = fuse_atomic_do_common(dir, entry, NULL, file, flags, mode,
> +	err = fuse_do_atomic_common(dir, entry, NULL, file, NULL, flags, mode,
>  				    FUSE_ATOMIC_CREATE);
>  	/* If atomic create is not implemented then indicate in fc so that next
>  	 * request falls back to normal create instead of going into libufse and
> @@ -699,9 +766,10 @@ static int fuse_atomic_create(struct inode *dir, struct dentry *entry,
>  	return err;
>  }
>  
> -static int fuse_do_atomic_open(struct inode *dir, struct dentry *entry,
> -				struct dentry **alias, struct file *file,
> -				unsigned int flags, umode_t mode)
> +int fuse_do_atomic_open(struct inode *dir, struct dentry *entry,
> +			struct dentry **alias, struct file *file,
> +			struct inode *reval_inode, unsigned int flags,
> +			umode_t mode)
>  {
>  	int err;
>  	struct fuse_conn *fc = get_fuse_conn(dir);
> @@ -709,8 +777,8 @@ static int fuse_do_atomic_open(struct inode *dir, struct dentry *entry,
>  	if (!fc->do_atomic_open)
>  		return -ENOSYS;
>  
> -	err = fuse_atomic_do_common(dir, entry, alias, file, flags, mode,
> -				    FUSE_ATOMIC_OPEN);
> +	err = fuse_do_atomic_common(dir, entry, alias, file, reval_inode, flags,
> +				    mode, FUSE_ATOMIC_OPEN);
>  	/* Atomic open imply atomic trunc as well i.e truncate should be performed
>  	 * as part of atomic open call itself.
>  	 */
> @@ -718,7 +786,6 @@ static int fuse_do_atomic_open(struct inode *dir, struct dentry *entry,
>  		if (fc->do_atomic_open)
>  			fc->atomic_o_trunc = 1;
>  	}
> -
>  	return err;
>  }
>  
> @@ -738,7 +805,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
>  
>  	if (!create) {
>  		err = fuse_do_atomic_open(dir, entry, &alias,
> -					  file, flags, mode);
> +					  file, NULL, flags, mode);
>  		res = alias;
>  		if (!err || err != -ENOSYS)
>  			goto out_dput;
> @@ -774,7 +841,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
>  	 * 'mknod' + 'open' requests.
>  	 */
>  	if (err == -ENOSYS) {
> -		err = fuse_atomic_do_common(dir, entry, NULL, file, flags,
> +		err = fuse_do_atomic_common(dir, entry, NULL, file, NULL, flags,
>  					    mode, FUSE_CREATE);
>  	}
>  	if (err == -ENOSYS) {
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 829094451774..2b0548163249 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -125,11 +125,15 @@ static void fuse_file_put(struct fuse_file *ff, bool sync, bool isdir)
>  }
>  
>  struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
> -				 unsigned int open_flags, bool isdir)
> +				 struct file *file, unsigned int open_flags,
> +				 bool isdir)
>  {
>  	struct fuse_conn *fc = fm->fc;
>  	struct fuse_file *ff;
> +	struct dentry *dentry = NULL;
> +	struct dentry *parent = NULL;
>  	int opcode = isdir ? FUSE_OPENDIR : FUSE_OPEN;
> +	int ret;
>  
>  	ff = fuse_file_alloc(fm);
>  	if (!ff)
> @@ -138,6 +142,11 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
>  	ff->fh = 0;
>  	/* Default for no-open */
>  	ff->open_flags = FOPEN_KEEP_CACHE | (isdir ? FOPEN_CACHE_DIR : 0);
> +
> +	/* For directories we already had lookup */
> +	if (!isdir && fc->do_atomic_open && file != NULL)
> +		goto revalidate_atomic_open;
> +
>  	if (isdir ? !fc->no_opendir : !fc->no_open) {
>  		struct fuse_open_out outarg;
>  		int err;
> @@ -164,12 +173,27 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
>  	ff->nodeid = nodeid;
>  
>  	return ff;
> +
> +revalidate_atomic_open:
> +	dentry = file->f_path.dentry;
> +	/* Get ref on parent */
> +	parent = dget_parent(dentry);
> +	open_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY);
> +	ret = fuse_do_atomic_open(d_inode_rcu(parent), dentry, NULL, file,
> +				  d_inode_rcu(dentry), open_flags, 0);
> +	dput(parent);
> +	if (ret)
> +		goto err_out;
> +	ff = file->private_data;
> +	return ff;
> +err_out:
> +	return ERR_PTR(ret);
>  }
>  
>  int fuse_do_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
>  		 bool isdir)
>  {
> -	struct fuse_file *ff = fuse_file_open(fm, nodeid, file->f_flags, isdir);
> +	struct fuse_file *ff = fuse_file_open(fm, nodeid, file, file->f_flags, isdir);
>  
>  	if (!IS_ERR(ff))
>  		file->private_data = ff;
> @@ -252,7 +276,7 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
>  	}
>  
>  	err = fuse_do_open(fm, get_node_id(inode), file, isdir);
> -	if (!err)
> +	if (!err && (!fc->do_atomic_open || isdir))
>  		fuse_finish_open(inode, file);
>  
>  out:
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 24793b82303f..5c83e4249b7e 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1014,6 +1014,13 @@ void fuse_finish_open(struct inode *inode, struct file *file);
>  void fuse_sync_release(struct fuse_inode *fi, struct fuse_file *ff,
>  		       unsigned int flags);
>  
> +/**
> + * Send atomic create + open or lookup + open
> + */
> +int fuse_do_atomic_open(struct inode *dir, struct dentry *entry,
> +			struct dentry **alias, struct file *file,
> +			struct inode *reval_inode, unsigned int flags,
> +			umode_t mode);
>  /**
>   * Send RELEASE or RELEASEDIR request
>   */
> @@ -1317,7 +1324,8 @@ int fuse_fileattr_set(struct user_namespace *mnt_userns,
>  /* file.c */
>  
>  struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
> -				 unsigned int open_flags, bool isdir);
> +				 struct file *file, unsigned int open_flags,
> +				 bool isdir);
>  void fuse_file_release(struct inode *inode, struct fuse_file *ff,
>  		       unsigned int open_flags, fl_owner_t id, bool isdir);
>  
> diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
> index fbc09dab1f85..63106a54ba1a 100644
> --- a/fs/fuse/ioctl.c
> +++ b/fs/fuse/ioctl.c
> @@ -408,7 +408,7 @@ static struct fuse_file *fuse_priv_ioctl_prepare(struct inode *inode)
>  	if (!S_ISREG(inode->i_mode) && !isdir)
>  		return ERR_PTR(-ENOTTY);
>  
> -	return fuse_file_open(fm, get_node_id(inode), O_RDONLY, isdir);
> +	return fuse_file_open(fm, get_node_id(inode), NULL, O_RDONLY, isdir);
>  }
>  
>  static void fuse_priv_ioctl_cleanup(struct inode *inode, struct fuse_file *ff)
> -- 
> 2.17.1
> 


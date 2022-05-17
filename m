Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE0352AD72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 23:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiEQVVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 17:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbiEQVVV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 17:21:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 080E11BEAF
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 May 2022 14:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652822479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/7V7x1GpjVSqeqJcJJCFYfdfhdsBzg9+sabDuOPG7ao=;
        b=bR0oFJ1ZRR0EwF9jWbMBx2ZGrkXwWkczEInceRt+zAlObmyVbrwLZ09f8lU8xrpidyZD3K
        HrnZpK82FsWlG8/Jxkpf5EdZI/lh53yCdFXDc04ILfNtaikORV8rHhNWc0ZX3cAducj5OM
        P6UxLwFN9aR8pcPiy2jfgih8JEBnmFc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13--fs8iDDjO2C9wmc3CF8thA-1; Tue, 17 May 2022 17:21:14 -0400
X-MC-Unique: -fs8iDDjO2C9wmc3CF8thA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3590A3C0CD46;
        Tue, 17 May 2022 21:21:14 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.11.193])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E99FB40C1421;
        Tue, 17 May 2022 21:21:13 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A7D582208FA; Tue, 17 May 2022 17:21:13 -0400 (EDT)
Date:   Tue, 17 May 2022 17:21:13 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dharmendra Singh <dharamhans87@gmail.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        bschubert@ddn.com, Dharmendra Singh <dsingh@ddn.com>
Subject: Re: [PATCH v5 1/3] FUSE: Avoid lookups in fuse create
Message-ID: <YoQRyY8RkEWbn9Zp@redhat.com>
References: <20220517100744.26849-1-dharamhans87@gmail.com>
 <20220517100744.26849-2-dharamhans87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517100744.26849-2-dharamhans87@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 17, 2022 at 03:37:42PM +0530, Dharmendra Singh wrote:
> From: Dharmendra Singh <dsingh@ddn.com>
> 
> When we go for creating a file (O_CREAT), we trigger
> a lookup to FUSE USER space. It is very  much likely
> that file does not exist yet as O_CREAT is passed to
> open(). This extra lookup call can be avoided.
> 
> Here is how current fuse create works:
> 
> A. Looks up dentry (if d_in_lookup() is set.
> B. If dentry is positive or O_CREAT is not set, return.
> C. If server supports atomic create + open, use that to create file
>    and open it as well.
> D. If server does not support atomic create + open, just create file
>    using "mknod" and return. VFS will take care of opening the file.
> 
> Here is how the proposed patch would work:
> 
> A. Skip lookup if extended create is supported and file is being
>    created.
> B. Remains same. if dentry is positive or O_CREATE is not set, return.
> C. If server supports new extended create, use that.
> D. If not, if server supports atomic create + open, use that
> E. If not, fall back to mknod and do not open file.
> 
> (Current code returns file attributes from user space as part of
>  reply of FUSE_CREATE call itself.)
> 
> It is expected that USER SPACE create the file, open it and fills in
> the attributes which are then used to make inode stand/revalidate
> in the kernel cache.

Even current FUSE_CREATE command does that. I think we need to make
changelogs little more readable and clear. Something like.

Current FUSE_CREATE command creates and opens a file. Client has
either has a positive dentry or has done lookup to figure out if
file needs to be created or not. Assumption here is that file does
not exist on server and needs to be created.

Now add command FUSE_CREATE_EXT which can return information whether
file was actually created or not. It is possible that file already
exists. Server sets bit FOPEN_FILE_CREATED in fuse_file_info if
file was indeed created.

> Also if file was newly created(does not
> exist yet by this time) in USER SPACE then it should be indicated
> in `struct fuse_file_info` by setting a bit which is again used by
> libfuse to send some flags back to fuse kernel to indicate that
> that file was newly created. These flags are used by kernel to
> indicate changes in parent directory.
> 
> Fuse kernel automatically detects if extended create is implemented
> by libfuse/USER SPACE or not. And depending upon the outcome of
> this check all further creates are decided to be extended create or
> the old create way.
> 
> If libfuse/USER SPACE has not implemented the extended create operation
> then by default behaviour remains same i.e we do not optimize lookup
> calls which are triggered before create calls into libfuse.
> 
> Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
> ---
>  fs/fuse/dir.c             | 84 +++++++++++++++++++++++++++++++++------
>  fs/fuse/fuse_i.h          |  6 +++
>  include/uapi/linux/fuse.h |  3 ++
>  3 files changed, 81 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 656e921f3506..ed9da8d6b57b 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -523,7 +523,7 @@ static int get_security_context(struct dentry *entry, umode_t mode,
>   */
>  static int fuse_create_open(struct inode *dir, struct dentry *entry,
>  			    struct file *file, unsigned int flags,
> -			    umode_t mode)
> +			    umode_t mode, uint32_t opcode)
>  {
>  	int err;
>  	struct inode *inode;
> @@ -535,8 +535,10 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>  	struct fuse_entry_out outentry;
>  	struct fuse_inode *fi;
>  	struct fuse_file *ff;
> +	struct dentry *res = NULL;
>  	void *security_ctx = NULL;
>  	u32 security_ctxlen;
> +	bool ext_create = (opcode == FUSE_CREATE_EXT ? true : false);
>  
>  	/* Userspace expects S_IFREG in create mode */
>  	BUG_ON((mode & S_IFMT) != S_IFREG);
> @@ -566,7 +568,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>  		inarg.open_flags |= FUSE_OPEN_KILL_SUIDGID;
>  	}
>  
> -	args.opcode = FUSE_CREATE;
> +	args.opcode = opcode;
>  	args.nodeid = get_node_id(dir);
>  	args.in_numargs = 2;
>  	args.in_args[0].size = sizeof(inarg);
> @@ -613,9 +615,37 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>  		goto out_err;
>  	}
>  	kfree(forget);
> -	d_instantiate(entry, inode);
> +	/*
> +	 * In extended create, fuse_lookup() was skipped, which also uses
> +	 * d_splice_alias(). As we come directly here after picking up dentry
> +	 * it is very much likely that dentry has DCACHE_PAR_LOOKUP flag set
> +	 * on it so call d_splice_alias().
> +	 */

Ok, following piece of code I don't understand. If we are not using
FUSE_CREATE_EXT, then d_in_lookup() should always be false. Because
in that case we have done lookup() if needed. So what's the point
of following check.
> +	if (!ext_create && !d_in_lookup(entry))
			    ^^^^ This should always be true if
			    ext_create=0.

> +		d_instantiate(entry, inode);
> +	else {
> +		res = d_splice_alias(inode, entry);

To me we have following 3 conditions.

A. if FUSE_CREATE is being used, we have done the lookup if needed. File
   has definitely been created. Just call d_instantiate().

B. If we are using FUSE_CRATE_EXT, then it is possibel that d_in_lookup()
   is true. But it is also possible that dentry is negative. So looks
   you probably want to do this.

   if (!ext_create || !d_in_lookup()) {
   	d_instanatiate()
   } else {
	/* Dentry is in lookup() as well as we used FUSE_CRATE_EXT and
	 * skipped lookup. So use d_splice_alias() instead of
	 * d_instantiate().
	 */
   	d_splice_alias();
   }

Having said that I am not sure if using dentry_spliace_alias() is the
right thing. I think Miklos or somebody else who understands associated
logic better should have a look at it.

I am just trying to reason through the code based on your arguments.

> +		if (IS_ERR(res)) {
> +			/* Close the file in user space, but do not unlink it,
> +			 * if it was created - with network file systems other
> +			 * clients might have already accessed it.
> +			 */
> +			fi = get_fuse_inode(inode);
> +			fuse_sync_release(fi, ff, flags);
> +			fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
> +			err = PTR_ERR(res);
> +			goto out_err;
> +		}
> +	}
>  	fuse_change_entry_timeout(entry, &outentry);
> -	fuse_dir_changed(dir);
> +	/*
> +	 * This should be always set when the file is created, but only
> +	 * CREATE_EXT introduced FOPEN_FILE_CREATED to user space.
> +	 */
> +	if (!ext_create || (outopen.open_flags & FOPEN_FILE_CREATED)) {
> +		fuse_dir_changed(dir);
> +		file->f_mode |= FMODE_CREATED;
> +	}
>  	err = finish_open(file, entry, generic_file_open);
>  	if (err) {
>  		fi = get_fuse_inode(inode);
> @@ -634,6 +664,29 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>  	return err;
>  }
>  
> +static int fuse_create_ext(struct inode *dir, struct dentry *entry,
> +			   struct file *file, unsigned int flags,
> +			   umode_t mode)
> +{
> +	int err;
> +	struct fuse_conn *fc = get_fuse_conn(dir);
> +
> +	if (fc->no_create_ext)
> +		return -ENOSYS;

If we check this in fuse_atomic_open(), then we don't need this check
here. Look at suggested changes below in fuse_atomic_open().

> +
> +	err = fuse_create_open(dir, entry, file, flags, mode,
> +			       FUSE_CREATE_EXT);
> +	/* If ext create is not implemented then indicate in fc so that next
> +	 * request falls back to normal create instead of going into libufse and
> +	 * returning with -ENOSYS.
> +	 */
> +	if (err == -ENOSYS) {
> +		if (!fc->no_create_ext)

Why to check for !fc->no_create_ext.
> +			fc->no_create_ext = 1;
> +	}
> +	return err;
> +}

I think we can completely get rid of fuse_create_ext() function. And
just add a parameter "opcode" to FUSE_CREATE_OPEN and that should
do it.

> +
>  static int fuse_mknod(struct user_namespace *, struct inode *, struct dentry *,
>  		      umode_t, dev_t);
>  static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
> @@ -643,29 +696,35 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
>  	int err;
>  	struct fuse_conn *fc = get_fuse_conn(dir);
>  	struct dentry *res = NULL;
> +	bool create = flags & O_CREAT ? true : false;
>  
>  	if (fuse_is_bad(dir))
>  		return -EIO;
>  
> -	if (d_in_lookup(entry)) {
> +lookup:
> +	if ((!create || fc->no_create_ext) && d_in_lookup(entry)) {
>  		res = fuse_lookup(dir, entry, 0);
>  		if (IS_ERR(res))
>  			return PTR_ERR(res);
> -
>  		if (res)
>  			entry = res;
>  	}
> -
> -	if (!(flags & O_CREAT) || d_really_is_positive(entry))
> +	if (!create || d_really_is_positive(entry))
>  		goto no_open;
>  
> -	/* Only creates */
> -	file->f_mode |= FMODE_CREATED;
> -
>  	if (fc->no_create)

This should be (fc_no_create && fc->no_create_ext)? In theory it is
possible that a new server has FUSE_CREATE_EXT implemented but not
FUSE_CREATE?

If we are expecting FUSE_CREATE_EXT to be a super set of FUSE_CREATE,
then this should be possible. Maybe it is a good idea to not assume
the state of dentry (whether it is in lookup or not) if FUSE_CREATE_EXT 
is being used. And just design FUSE_CREATE_EXT to be superset of
FUSE_CREATE.

>  		goto mknod;
>  
> -	err = fuse_create_open(dir, entry, file, flags, mode);
> +	if (!fc->no_create_ext) {

What happens if dentry is negative here and d_in_lookup(entry) == false?
I mean there is no need to use FUSE_CREATE_EXT in that case necessarily?

But using it does not harm either. Just that we need to then keep track
what's the state of dentry. Whether it was in in lookup or not.


> +		err = fuse_create_ext(dir, entry, file, flags, mode);
> +		/* If libfuse/user space has not implemented extended create,
> +		 * fall back to normal create.
> +		 */
> +		if (err == -ENOSYS)
> +			goto lookup;
> +	} else
> +		err = fuse_create_open(dir, entry, file, flags, mode,
> +				       FUSE_CREATE);

BTW, may be following code structure is better. We can just add a label
for create_ext.

	if (fc->no_create_ext)
		goto create;
	err = fuse_create_ext(dir, entry, file, flags, mode);
	if (err == -ENOSYS) {
		fc->no_create_ext = 1;
		/*
		 * We might have skipped lookup assuming FUSE_CREATE_EXT
		 * is supported. Go through lookup path again if needed.
		 */
		goto lookup;
	}
create:
	err = fuse_create_open(dir, entry, file, flags, mode);

Thanks
Vivek

>  	if (err == -ENOSYS) {
>  		fc->no_create = 1;
>  		goto mknod;
> @@ -683,6 +742,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
>  }
>  
>  /*
> +
>   * Code shared between mknod, mkdir, symlink and link
>   */
>  static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index e8e59fbdefeb..266133dcab5e 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -669,6 +669,12 @@ struct fuse_conn {
>  	/** Is open/release not implemented by fs? */
>  	unsigned no_open:1;
>  
> +	/*
> +	 * Is atomic lookup-create-open(extended create) not implemented
> +	 * by fs?
> +	 */
> +	unsigned no_create_ext:1;
> +
>  	/** Is opendir/releasedir not implemented by fs? */
>  	unsigned no_opendir:1;
>  
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index d6ccee961891..bebe4be3f1cb 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -301,6 +301,7 @@ struct fuse_file_lock {
>   * FOPEN_CACHE_DIR: allow caching this directory
>   * FOPEN_STREAM: the file is stream-like (no file position at all)
>   * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
> + * FOPEN_FILE_CREATED: the file was actually created
>   */
>  #define FOPEN_DIRECT_IO		(1 << 0)
>  #define FOPEN_KEEP_CACHE	(1 << 1)
> @@ -308,6 +309,7 @@ struct fuse_file_lock {
>  #define FOPEN_CACHE_DIR		(1 << 3)
>  #define FOPEN_STREAM		(1 << 4)
>  #define FOPEN_NOFLUSH		(1 << 5)
> +#define FOPEN_FILE_CREATED	(1 << 6)
>  
>  /**
>   * INIT request/reply flags
> @@ -537,6 +539,7 @@ enum fuse_opcode {
>  	FUSE_SETUPMAPPING	= 48,
>  	FUSE_REMOVEMAPPING	= 49,
>  	FUSE_SYNCFS		= 50,
> +	FUSE_CREATE_EXT		= 51,
>  
>  	/* CUSE specific operations */
>  	CUSE_INIT		= 4096,
> -- 
> 2.17.1
> 


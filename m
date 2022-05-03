Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4ED518808
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 17:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbiECPPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 11:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbiECPPk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 11:15:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 162273A5D7
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 08:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651590727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xALRK9R5AWNZ7LG4kj2LfKpnduFxzArKbMxNGs4Fs8s=;
        b=QcTyESqWGUNWumQlTFssI56d4vnKU3TTH02NMP4mos+8EonPFu5wzwUlU9jBRtJu8feG4Y
        qPXfOQ/Y7DSFDSMqXnggBEeYGay3LzaP5zupIST9GYebAhahkM/1aL67hUYXNg6ULClzLk
        jSYG4cKBONp6PjukMbL6UrNigpQKqEc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-_aljzM8yOpyzI6l71FA7hw-1; Tue, 03 May 2022 11:11:48 -0400
X-MC-Unique: _aljzM8yOpyzI6l71FA7hw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23946B777E9;
        Tue,  3 May 2022 14:13:03 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5FEC40CFD32;
        Tue,  3 May 2022 14:13:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A22E7220463; Tue,  3 May 2022 10:13:02 -0400 (EDT)
Date:   Tue, 3 May 2022 10:13:02 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dharmendra Singh <dharamhans87@gmail.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        bschubert@ddn.com, Dharmendra Singh <dsingh@ddn.com>
Subject: Re: [PATCH v4 1/3] FUSE: Implement atomic lookup + create
Message-ID: <YnE4bqYoUJsJR3tV@redhat.com>
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <20220502102521.22875-2-dharamhans87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502102521.22875-2-dharamhans87@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 02, 2022 at 03:55:19PM +0530, Dharmendra Singh wrote:
> From: Dharmendra Singh <dsingh@ddn.com>
> 
> When we go for creating a file (O_CREAT), we trigger
> a lookup to FUSE USER SPACE. It is very  much likely
> that file does not exist yet as O_CREAT is passed to
> open(). This lookup can be avoided and can be performed
> as part of create call into libfuse.
> 
> This lookup + create in single call to libfuse and finally
> to USER SPACE has been named as atomic create. It is expected
> that USER SPACE create the file, open it and fills in the
> attributes which are then used to make inode stand/revalidate
> in the kernel cache. Also if file was newly created(does not
> exist yet by this time) in USER SPACE then it should be indicated
> in `struct fuse_file_info` by setting a bit which is again used by
> libfuse to send some flags back to fuse kernel to indicate that
> that file was newly created. These flags are used by kernel to
> indicate changes in parent directory.
> 
> Fuse kernel automatically detects if atomic create is implemented
> by libfuse/USER SPACE or not. And depending upon the outcome of
> this check all further creates are decided to be atomic or non-atomic
> creates.
> 
> If libfuse/USER SPACE has not implemented the atomic create operation
> then by default behaviour remains same i.e we do not optimize lookup
> calls which are triggered before create calls into libfuse.
> 
> Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
> ---
>  fs/fuse/dir.c             | 82 +++++++++++++++++++++++++++++++++++----
>  fs/fuse/fuse_i.h          |  3 ++
>  include/uapi/linux/fuse.h |  3 ++
>  3 files changed, 81 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 656e921f3506..cad3322a007f 100644
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
> +	bool atomic_create = (opcode == FUSE_ATOMIC_CREATE ? true : false);
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
> @@ -613,9 +615,44 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>  		goto out_err;
>  	}
>  	kfree(forget);
> -	d_instantiate(entry, inode);
> +	/*
> +	 * In atomic create, we skipped lookup and it is very much likely that
> +	 * dentry has DCACHE_PAR_LOOKUP flag set on it so call d_splice_alias().

Can you please help me understand what does DCACHE_PAR_LOOKUP flag mean.
Also how d_splice_alias() helps in that case.


> +	 * Note: Only REG file is allowed under create/atomic create.
> +	 */
> +	/* There is special case when at very first call where we check if
> +	 * atomic create is implemented by USER SPACE/libfuse or not, we
> +	 * skipped lookup. Now, in case where atomic create is not implemented
> +	 * underlying, we fall back to FUSE_CREATE. here we are required to handle
> +	 * DCACHE_PAR_LOOKUP flag.
> +	 */
> +	if (!atomic_create && !d_in_lookup(entry) && fm->fc->no_atomic_create)
> +		d_instantiate(entry, inode);

So if we are trying to do atomic_create first time, then we skipped lookup
in fuse_atomic_open() (assuming DCACHE_PAR_LOOKUP flag is set). If server
does not support, atomic_create, then we will set
fm->fc->no_atomic_create=1 and non-atomic create will be tried and we will
come here. And given we skipped lookup (even for non-atomic-create) case,
we are going to call d_splice_alias(). Right?

IOW, even without non-atomic-create, you are skipping lookup() and be
able to handle file creation and use d_splice_alias(). If this is
correct, I am wondering why do I need atomic create to begin with.

If this is not correct, then fuse_atomic_open() probably should handle
error from fuse_create_open(FUSE_ATOMIC_CREATE) first, retry lookup
and then retry fuse_create_open(FUSE_CREATE).

What am I missing?

Thanks
Vivek



> +	else {
> +		res = d_splice_alias(inode, entry);
> +		if (res) {
> +			 /* Close the file in user space, but do not unlink it,
> +			  * if it was created - with network file systems other
> +			  * clients might have already accessed it.
> +			  */
> +			if (IS_ERR(res)) {
> +				fi = get_fuse_inode(inode);
> +				fuse_sync_release(fi, ff, flags);
> +				fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
> +				err = PTR_ERR(res);
> +				goto out_err;
> +			}
> +			/* res is expected to be NULL since its REG file */
> +			WARN_ON(res);
> +		}
> +	}


>  	fuse_change_entry_timeout(entry, &outentry);
> -	fuse_dir_changed(dir);
> +	/*
> +	 * In case of atomic create, we want to indicate directory change
> +	 * only if USER SPACE actually created the file.
> +	 */
> +	if (!atomic_create || (outopen.open_flags & FOPEN_FILE_CREATED))
> +		fuse_dir_changed(dir);
>  	err = finish_open(file, entry, generic_file_open);
>  	if (err) {
>  		fi = get_fuse_inode(inode);
> @@ -634,6 +671,29 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>  	return err;
>  }
>  
> +static int fuse_atomic_create(struct inode *dir, struct dentry *entry,
> +			      struct file *file, unsigned int flags,
> +			      umode_t mode)
> +{
> +	int err;
> +	struct fuse_conn *fc = get_fuse_conn(dir);
> +
> +	if (fc->no_atomic_create)
> +		return -ENOSYS;
> +
> +	err = fuse_create_open(dir, entry, file, flags, mode,
> +			       FUSE_ATOMIC_CREATE);
> +	/* If atomic create is not implemented then indicate in fc so that next
> +	 * request falls back to normal create instead of going into libufse and
> +	 * returning with -ENOSYS.
> +	 */
> +	if (err == -ENOSYS) {
> +		if (!fc->no_atomic_create)
> +			fc->no_atomic_create = 1;
> +	}
> +	return err;
> +}
> +
>  static int fuse_mknod(struct user_namespace *, struct inode *, struct dentry *,
>  		      umode_t, dev_t);
>  static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
> @@ -643,11 +703,12 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
>  	int err;
>  	struct fuse_conn *fc = get_fuse_conn(dir);
>  	struct dentry *res = NULL;
> +	bool create = flags & O_CREAT ? true : false;
>  
>  	if (fuse_is_bad(dir))
>  		return -EIO;
>  
> -	if (d_in_lookup(entry)) {
> +	if ((!create || fc->no_atomic_create) && d_in_lookup(entry)) {
>  		res = fuse_lookup(dir, entry, 0);
>  		if (IS_ERR(res))
>  			return PTR_ERR(res);
> @@ -656,7 +717,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
>  			entry = res;
>  	}
>  
> -	if (!(flags & O_CREAT) || d_really_is_positive(entry))
> +	if (!create || d_really_is_positive(entry))
>  		goto no_open;
>  
>  	/* Only creates */
> @@ -665,7 +726,13 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
>  	if (fc->no_create)
>  		goto mknod;
>  
> -	err = fuse_create_open(dir, entry, file, flags, mode);
> +	err = fuse_atomic_create(dir, entry, file, flags, mode);
> +	/* Libfuse/user space has not implemented atomic create, therefore
> +	 * fall back to normal create.
> +	 */
> +	if (err == -ENOSYS)
> +		err = fuse_create_open(dir, entry, file, flags, mode,
> +				       FUSE_CREATE);
>  	if (err == -ENOSYS) {
>  		fc->no_create = 1;
>  		goto mknod;
> @@ -683,6 +750,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
>  }
>  
>  /*
> +
>   * Code shared between mknod, mkdir, symlink and link
>   */
>  static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index e8e59fbdefeb..d577a591ab16 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -669,6 +669,9 @@ struct fuse_conn {
>  	/** Is open/release not implemented by fs? */
>  	unsigned no_open:1;
>  
> +	/** Is atomic create not implemented by fs? */
> +	unsigned no_atomic_create:1;
> +
>  	/** Is opendir/releasedir not implemented by fs? */
>  	unsigned no_opendir:1;
>  
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index d6ccee961891..e4b56004b148 100644
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
> +	FUSE_ATOMIC_CREATE	= 51,
>  
>  	/* CUSE specific operations */
>  	CUSE_INIT		= 4096,
> -- 
> 2.17.1
> 


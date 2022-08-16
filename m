Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F76C5960B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 18:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbiHPQ5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 12:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiHPQ5u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:57:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E517E80E89
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 09:57:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50ECF612E3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 16:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E76DC433C1;
        Tue, 16 Aug 2022 16:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660669066;
        bh=yGZK7DAmWSUqBXoFHdM1Zi5Hc0yLubnWmV0l96ehvFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AijVbsrWVOnECkZDOjfmMwpdF79/nP3HRWHibB/6qCzqBuMTkddZ0FtEXps3UNlC7
         aOjWFstPin6WIRqddybb9w/1w969u9TDmIf7DTmtOYgaHQGuNebXYejL/olf5zDnXB
         Inyr6JMgrALaVWtp4DikMW1LFCewOcb273VgGdQMgK+oYnRCa5TrTCEWRO/9RFP5wC
         DsrsLFi0d3+IahV3XISUuHLjwwxUgTrvj58gw3Gl4BpZVAUVKLaQa8uYHfaELDwCRL
         7TduK+N1VmDLhCQwLP23LkxHiq3WWrF9KyfWkaGNUQePGpMc6ggwsKwqa5depSeP+J
         oHWUbIVpvVgDg==
Date:   Tue, 16 Aug 2022 18:57:42 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] Change calling conventions for filldir_t
Message-ID: <20220816165742.3womuacwfwaahta5@wittgenstein>
References: <YvvBs+7YUcrzwV1a@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvvBs+7YUcrzwV1a@ZenIV>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 05:11:31PM +0100, Al Viro wrote:
> filldir_t instances (directory iterators callbacks) used to return 0 for
> "OK, keep going" or -E... for "stop".  Note that it's *NOT* how the
> error values are reported - the rules for those are callback-dependent
> and ->iterate{,_shared}() instances only care about zero vs. non-zero
> (look at emit_dir() and friends).
> 
> So let's just return bool ("should we keep going?") - it's less confusing
> that way.  The choice between "true means keep going" and "true means
> stop" is bikesheddable; we have two groups of callbacks -
>     do something for everything in directory, until we run into problem
> and
>     find an entry in directory and do something to it.
> 
> The former tended to use 0/-E... conventions - -E<something> on failure.
> The latter tended to use 0/1, 1 being "stop, we are done".
> The callers treated anything non-zero as "stop", ignoring which
> non-zero value did they get.
> 
> "true means stop" would be more natural for the second group; "true
> means keep going" - for the first one.  I tried both variants and
> the things like
> 	if allocation failed
> 		something = -ENOMEM;
> 		return true;
> just looked unnatural and asking for trouble.
>     
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
> index aee9aaf9f3df..60df72f6dd37 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -922,3 +922,14 @@ is provided - file_open_root_mnt().  In-tree users adjusted.
>  no_llseek is gone; don't set .llseek to that - just leave it NULL instead.
>  Checks for "does that file have llseek(2), or should it fail with ESPIPE"
>  should be done by looking at FMODE_LSEEK in file->f_mode.
> +
> +---
> +
> +*mandatory*
> +
> +filldir_t (readdir callbacks) calling conventions have changed.  Instead of
> +returning 0 or -E... it returns bool now.  false means "no more" (as -E... used
> +to to) and true - "keep going" (as 0 in old calling conventions).  Rationale:

s/to to/to/ ?
otherwise looks good to me,
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>

> +callers never looked at specific -E... values anyway.  ->iterate() and
> +->iterate_shared() instance require no changes at all, all filldir_t ones in
> +the tree converted.
> diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
> index d257293401e2..097d42cbd540 100644
> --- a/arch/alpha/kernel/osf_sys.c
> +++ b/arch/alpha/kernel/osf_sys.c
> @@ -108,7 +108,7 @@ struct osf_dirent_callback {
>  	int error;
>  };
>  
> -static int
> +static bool
>  osf_filldir(struct dir_context *ctx, const char *name, int namlen,
>  	    loff_t offset, u64 ino, unsigned int d_type)
>  {
> @@ -120,11 +120,11 @@ osf_filldir(struct dir_context *ctx, const char *name, int namlen,
>  
>  	buf->error = -EINVAL;	/* only used if we fail */
>  	if (reclen > buf->count)
> -		return -EINVAL;
> +		return false;
>  	d_ino = ino;
>  	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
>  		buf->error = -EOVERFLOW;
> -		return -EOVERFLOW;
> +		return false;
>  	}
>  	if (buf->basep) {
>  		if (put_user(offset, buf->basep))
> @@ -141,10 +141,10 @@ osf_filldir(struct dir_context *ctx, const char *name, int namlen,
>  	dirent = (void __user *)dirent + reclen;
>  	buf->dirent = dirent;
>  	buf->count -= reclen;
> -	return 0;
> +	return true;
>  Efault:
>  	buf->error = -EFAULT;
> -	return -EFAULT;
> +	return false;
>  }
>  
>  SYSCALL_DEFINE4(osf_getdirentries, unsigned int, fd,
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 56ae5cd5184f..230c2d19116d 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -24,9 +24,9 @@ static int afs_readdir(struct file *file, struct dir_context *ctx);
>  static int afs_d_revalidate(struct dentry *dentry, unsigned int flags);
>  static int afs_d_delete(const struct dentry *dentry);
>  static void afs_d_iput(struct dentry *dentry, struct inode *inode);
> -static int afs_lookup_one_filldir(struct dir_context *ctx, const char *name, int nlen,
> +static bool afs_lookup_one_filldir(struct dir_context *ctx, const char *name, int nlen,
>  				  loff_t fpos, u64 ino, unsigned dtype);
> -static int afs_lookup_filldir(struct dir_context *ctx, const char *name, int nlen,
> +static bool afs_lookup_filldir(struct dir_context *ctx, const char *name, int nlen,
>  			      loff_t fpos, u64 ino, unsigned dtype);
>  static int afs_create(struct user_namespace *mnt_userns, struct inode *dir,
>  		      struct dentry *dentry, umode_t mode, bool excl);
> @@ -568,7 +568,7 @@ static int afs_readdir(struct file *file, struct dir_context *ctx)
>   * - if afs_dir_iterate_block() spots this function, it'll pass the FID
>   *   uniquifier through dtype
>   */
> -static int afs_lookup_one_filldir(struct dir_context *ctx, const char *name,
> +static bool afs_lookup_one_filldir(struct dir_context *ctx, const char *name,
>  				  int nlen, loff_t fpos, u64 ino, unsigned dtype)
>  {
>  	struct afs_lookup_one_cookie *cookie =
> @@ -584,16 +584,16 @@ static int afs_lookup_one_filldir(struct dir_context *ctx, const char *name,
>  
>  	if (cookie->name.len != nlen ||
>  	    memcmp(cookie->name.name, name, nlen) != 0) {
> -		_leave(" = 0 [no]");
> -		return 0;
> +		_leave(" = true [keep looking]");
> +		return true;
>  	}
>  
>  	cookie->fid.vnode = ino;
>  	cookie->fid.unique = dtype;
>  	cookie->found = 1;
>  
> -	_leave(" = -1 [found]");
> -	return -1;
> +	_leave(" = false [found]");
> +	return false;
>  }
>  
>  /*
> @@ -636,12 +636,11 @@ static int afs_do_lookup_one(struct inode *dir, struct dentry *dentry,
>   * - if afs_dir_iterate_block() spots this function, it'll pass the FID
>   *   uniquifier through dtype
>   */
> -static int afs_lookup_filldir(struct dir_context *ctx, const char *name,
> +static bool afs_lookup_filldir(struct dir_context *ctx, const char *name,
>  			      int nlen, loff_t fpos, u64 ino, unsigned dtype)
>  {
>  	struct afs_lookup_cookie *cookie =
>  		container_of(ctx, struct afs_lookup_cookie, ctx);
> -	int ret;
>  
>  	_enter("{%s,%u},%s,%u,,%llu,%u",
>  	       cookie->name.name, cookie->name.len, name, nlen,
> @@ -663,12 +662,10 @@ static int afs_lookup_filldir(struct dir_context *ctx, const char *name,
>  		cookie->fids[1].unique	= dtype;
>  		cookie->found = 1;
>  		if (cookie->one_only)
> -			return -1;
> +			return false;
>  	}
>  
> -	ret = cookie->nr_fids >= 50 ? -1 : 0;
> -	_leave(" = %d", ret);
> -	return ret;
> +	return cookie->nr_fids < 50;
>  }
>  
>  /*
> diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
> index 18d5b91cb573..c29814a66c5b 100644
> --- a/fs/ecryptfs/file.c
> +++ b/fs/ecryptfs/file.c
> @@ -53,7 +53,7 @@ struct ecryptfs_getdents_callback {
>  };
>  
>  /* Inspired by generic filldir in fs/readdir.c */
> -static int
> +static bool
>  ecryptfs_filldir(struct dir_context *ctx, const char *lower_name,
>  		 int lower_namelen, loff_t offset, u64 ino, unsigned int d_type)
>  {
> @@ -61,18 +61,19 @@ ecryptfs_filldir(struct dir_context *ctx, const char *lower_name,
>  		container_of(ctx, struct ecryptfs_getdents_callback, ctx);
>  	size_t name_size;
>  	char *name;
> -	int rc;
> +	int err;
> +	bool res;
>  
>  	buf->filldir_called++;
> -	rc = ecryptfs_decode_and_decrypt_filename(&name, &name_size,
> -						  buf->sb, lower_name,
> -						  lower_namelen);
> -	if (rc) {
> -		if (rc != -EINVAL) {
> +	err = ecryptfs_decode_and_decrypt_filename(&name, &name_size,
> +						   buf->sb, lower_name,
> +						   lower_namelen);
> +	if (err) {
> +		if (err != -EINVAL) {
>  			ecryptfs_printk(KERN_DEBUG,
>  					"%s: Error attempting to decode and decrypt filename [%s]; rc = [%d]\n",
> -					__func__, lower_name, rc);
> -			return rc;
> +					__func__, lower_name, err);
> +			return false;
>  		}
>  
>  		/* Mask -EINVAL errors as these are most likely due a plaintext
> @@ -81,16 +82,15 @@ ecryptfs_filldir(struct dir_context *ctx, const char *lower_name,
>  		 * the "lost+found" dentry in the root directory of an Ext4
>  		 * filesystem.
>  		 */
> -		return 0;
> +		return true;
>  	}
>  
>  	buf->caller->pos = buf->ctx.pos;
> -	rc = !dir_emit(buf->caller, name, name_size, ino, d_type);
> +	res = dir_emit(buf->caller, name, name_size, ino, d_type);
>  	kfree(name);
> -	if (!rc)
> +	if (res)
>  		buf->entries_written++;
> -
> -	return rc;
> +	return res;
>  }
>  
>  /**
> @@ -111,14 +111,8 @@ static int ecryptfs_readdir(struct file *file, struct dir_context *ctx)
>  	lower_file = ecryptfs_file_to_lower(file);
>  	rc = iterate_dir(lower_file, &buf.ctx);
>  	ctx->pos = buf.ctx.pos;
> -	if (rc < 0)
> -		goto out;
> -	if (buf.filldir_called && !buf.entries_written)
> -		goto out;
> -	if (rc >= 0)
> -		fsstack_copy_attr_atime(inode,
> -					file_inode(lower_file));
> -out:
> +	if (rc >= 0 && (buf.entries_written || !buf.filldir_called))
> +		fsstack_copy_attr_atime(inode, file_inode(lower_file));
>  	return rc;
>  }
>  
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index 3ef80d000e13..c648a493faf2 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -248,21 +248,20 @@ struct getdents_callback {
>   * A rather strange filldir function to capture
>   * the name matching the specified inode number.
>   */
> -static int filldir_one(struct dir_context *ctx, const char *name, int len,
> +static bool filldir_one(struct dir_context *ctx, const char *name, int len,
>  			loff_t pos, u64 ino, unsigned int d_type)
>  {
>  	struct getdents_callback *buf =
>  		container_of(ctx, struct getdents_callback, ctx);
> -	int result = 0;
>  
>  	buf->sequence++;
>  	if (buf->ino == ino && len <= NAME_MAX) {
>  		memcpy(buf->name, name, len);
>  		buf->name[len] = '\0';
>  		buf->found = 1;
> -		result = -1;
> +		return false;	// no more
>  	}
> -	return result;
> +	return true;
>  }
>  
>  /**
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index 249825017da7..00235b8a1823 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -705,7 +705,7 @@ static int fat_readdir(struct file *file, struct dir_context *ctx)
>  }
>  
>  #define FAT_IOCTL_FILLDIR_FUNC(func, dirent_type)			   \
> -static int func(struct dir_context *ctx, const char *name, int name_len,   \
> +static bool func(struct dir_context *ctx, const char *name, int name_len,  \
>  			     loff_t offset, u64 ino, unsigned int d_type)  \
>  {									   \
>  	struct fat_ioctl_filldir_callback *buf =			   \
> @@ -714,7 +714,7 @@ static int func(struct dir_context *ctx, const char *name, int name_len,   \
>  	struct dirent_type __user *d2 = d1 + 1;				   \
>  									   \
>  	if (buf->result)						   \
> -		return -EINVAL;						   \
> +		return false;						   \
>  	buf->result++;							   \
>  									   \
>  	if (name != NULL) {						   \
> @@ -750,10 +750,10 @@ static int func(struct dir_context *ctx, const char *name, int name_len,   \
>  		    put_user(short_len, &d1->d_reclen))			   \
>  			goto efault;					   \
>  	}								   \
> -	return 0;							   \
> +	return true;							   \
>  efault:									   \
>  	buf->result = -EFAULT;						   \
> -	return -EFAULT;							   \
> +	return false;							   \
>  }
>  
>  FAT_IOCTL_FILLDIR_FUNC(fat_ioctl_filldir, __fat_dirent)
> diff --git a/fs/gfs2/export.c b/fs/gfs2/export.c
> index 756d05779200..cf40895233f5 100644
> --- a/fs/gfs2/export.c
> +++ b/fs/gfs2/export.c
> @@ -66,7 +66,7 @@ struct get_name_filldir {
>  	char *name;
>  };
>  
> -static int get_name_filldir(struct dir_context *ctx, const char *name,
> +static bool get_name_filldir(struct dir_context *ctx, const char *name,
>  			    int length, loff_t offset, u64 inum,
>  			    unsigned int type)
>  {
> @@ -74,12 +74,12 @@ static int get_name_filldir(struct dir_context *ctx, const char *name,
>  		container_of(ctx, struct get_name_filldir, ctx);
>  
>  	if (inum != gnfd->inum.no_addr)
> -		return 0;
> +		return true;
>  
>  	memcpy(gnfd->name, name, length);
>  	gnfd->name[length] = 0;
>  
> -	return 1;
> +	return false;
>  }
>  
>  static int gfs2_get_name(struct dentry *parent, char *name,
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index 9751cc92c111..6785a9cc9ee1 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -3779,7 +3779,7 @@ static int reserve_populate_dentry(struct ksmbd_dir_info *d_info,
>  	return 0;
>  }
>  
> -static int __query_dir(struct dir_context *ctx, const char *name, int namlen,
> +static bool __query_dir(struct dir_context *ctx, const char *name, int namlen,
>  		       loff_t offset, u64 ino, unsigned int d_type)
>  {
>  	struct ksmbd_readdir_data	*buf;
> @@ -3793,22 +3793,20 @@ static int __query_dir(struct dir_context *ctx, const char *name, int namlen,
>  
>  	/* dot and dotdot entries are already reserved */
>  	if (!strcmp(".", name) || !strcmp("..", name))
> -		return 0;
> +		return true;
>  	if (ksmbd_share_veto_filename(priv->work->tcon->share_conf, name))
> -		return 0;
> +		return true;
>  	if (!match_pattern(name, namlen, priv->search_pattern))
> -		return 0;
> +		return true;
>  
>  	d_info->name		= name;
>  	d_info->name_len	= namlen;
>  	rc = reserve_populate_dentry(d_info, priv->info_level);
>  	if (rc)
> -		return rc;
> -	if (d_info->flags & SMB2_RETURN_SINGLE_ENTRY) {
> +		return false;
> +	if (d_info->flags & SMB2_RETURN_SINGLE_ENTRY)
>  		d_info->out_buf_len = 0;
> -		return 0;
> -	}
> -	return 0;
> +	return true;
>  }
>  
>  static void restart_ctx(struct dir_context *ctx)
> diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
> index 78d01033604c..48b2b901f6e5 100644
> --- a/fs/ksmbd/vfs.c
> +++ b/fs/ksmbd/vfs.c
> @@ -1105,7 +1105,7 @@ int ksmbd_vfs_unlink(struct user_namespace *user_ns,
>  	return err;
>  }
>  
> -static int __dir_empty(struct dir_context *ctx, const char *name, int namlen,
> +static bool __dir_empty(struct dir_context *ctx, const char *name, int namlen,
>  		       loff_t offset, u64 ino, unsigned int d_type)
>  {
>  	struct ksmbd_readdir_data *buf;
> @@ -1113,9 +1113,7 @@ static int __dir_empty(struct dir_context *ctx, const char *name, int namlen,
>  	buf = container_of(ctx, struct ksmbd_readdir_data, ctx);
>  	buf->dirent_count++;
>  
> -	if (buf->dirent_count > 2)
> -		return -ENOTEMPTY;
> -	return 0;
> +	return buf->dirent_count <= 2;
>  }
>  
>  /**
> @@ -1142,7 +1140,7 @@ int ksmbd_vfs_empty_dir(struct ksmbd_file *fp)
>  	return err;
>  }
>  
> -static int __caseless_lookup(struct dir_context *ctx, const char *name,
> +static bool __caseless_lookup(struct dir_context *ctx, const char *name,
>  			     int namlen, loff_t offset, u64 ino,
>  			     unsigned int d_type)
>  {
> @@ -1151,13 +1149,13 @@ static int __caseless_lookup(struct dir_context *ctx, const char *name,
>  	buf = container_of(ctx, struct ksmbd_readdir_data, ctx);
>  
>  	if (buf->used != namlen)
> -		return 0;
> +		return true;
>  	if (!strncasecmp((char *)buf->private, name, namlen)) {
>  		memcpy((char *)buf->private, name, namlen);
>  		buf->dirent_count = 1;
> -		return -EEXIST;
> +		return false;
>  	}
> -	return 0;
> +	return true;
>  }
>  
>  /**
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index c634483d85d2..b29d27eaa8a6 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -266,7 +266,7 @@ struct nfs4_dir_ctx {
>  	struct list_head names;
>  };
>  
> -static int
> +static bool
>  nfsd4_build_namelist(struct dir_context *__ctx, const char *name, int namlen,
>  		loff_t offset, u64 ino, unsigned int d_type)
>  {
> @@ -275,14 +275,14 @@ nfsd4_build_namelist(struct dir_context *__ctx, const char *name, int namlen,
>  	struct name_list *entry;
>  
>  	if (namlen != HEXDIR_LEN - 1)
> -		return 0;
> +		return true;
>  	entry = kmalloc(sizeof(struct name_list), GFP_KERNEL);
>  	if (entry == NULL)
> -		return -ENOMEM;
> +		return false;
>  	memcpy(entry->name, name, HEXDIR_LEN - 1);
>  	entry->name[HEXDIR_LEN - 1] = '\0';
>  	list_add(&entry->list, &ctx->names);
> -	return 0;
> +	return true;
>  }
>  
>  static int
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 9f486b788ed0..4b0015706e98 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1811,7 +1811,7 @@ struct readdir_data {
>  	int		full;
>  };
>  
> -static int nfsd_buffered_filldir(struct dir_context *ctx, const char *name,
> +static bool nfsd_buffered_filldir(struct dir_context *ctx, const char *name,
>  				 int namlen, loff_t offset, u64 ino,
>  				 unsigned int d_type)
>  {
> @@ -1823,7 +1823,7 @@ static int nfsd_buffered_filldir(struct dir_context *ctx, const char *name,
>  	reclen = ALIGN(sizeof(struct buffered_dirent) + namlen, sizeof(u64));
>  	if (buf->used + reclen > PAGE_SIZE) {
>  		buf->full = 1;
> -		return -EINVAL;
> +		return false;
>  	}
>  
>  	de->namlen = namlen;
> @@ -1833,7 +1833,7 @@ static int nfsd_buffered_filldir(struct dir_context *ctx, const char *name,
>  	memcpy(de->name, name, namlen);
>  	buf->used += reclen;
>  
> -	return 0;
> +	return true;
>  }
>  
>  static __be32 nfsd_buffered_readdir(struct file *file, struct svc_fh *fhp,
> diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
> index 81c3d65d68fe..694471fc46b8 100644
> --- a/fs/ocfs2/dir.c
> +++ b/fs/ocfs2/dir.c
> @@ -2032,7 +2032,7 @@ struct ocfs2_empty_dir_priv {
>  	unsigned seen_other;
>  	unsigned dx_dir;
>  };
> -static int ocfs2_empty_dir_filldir(struct dir_context *ctx, const char *name,
> +static bool ocfs2_empty_dir_filldir(struct dir_context *ctx, const char *name,
>  				   int name_len, loff_t pos, u64 ino,
>  				   unsigned type)
>  {
> @@ -2052,7 +2052,7 @@ static int ocfs2_empty_dir_filldir(struct dir_context *ctx, const char *name,
>  	 */
>  	if (name_len == 1 && !strncmp(".", name, 1) && pos == 0) {
>  		p->seen_dot = 1;
> -		return 0;
> +		return true;
>  	}
>  
>  	if (name_len == 2 && !strncmp("..", name, 2) &&
> @@ -2060,13 +2060,13 @@ static int ocfs2_empty_dir_filldir(struct dir_context *ctx, const char *name,
>  		p->seen_dot_dot = 1;
>  
>  		if (p->dx_dir && p->seen_dot)
> -			return 1;
> +			return false;
>  
> -		return 0;
> +		return true;
>  	}
>  
>  	p->seen_other = 1;
> -	return 1;
> +	return false;
>  }
>  
>  static int ocfs2_empty_dir_dx(struct inode *inode,
> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> index fa87d89cf754..126671e6caed 100644
> --- a/fs/ocfs2/journal.c
> +++ b/fs/ocfs2/journal.c
> @@ -2057,7 +2057,7 @@ struct ocfs2_orphan_filldir_priv {
>  	enum ocfs2_orphan_reco_type orphan_reco_type;
>  };
>  
> -static int ocfs2_orphan_filldir(struct dir_context *ctx, const char *name,
> +static bool ocfs2_orphan_filldir(struct dir_context *ctx, const char *name,
>  				int name_len, loff_t pos, u64 ino,
>  				unsigned type)
>  {
> @@ -2066,21 +2066,21 @@ static int ocfs2_orphan_filldir(struct dir_context *ctx, const char *name,
>  	struct inode *iter;
>  
>  	if (name_len == 1 && !strncmp(".", name, 1))
> -		return 0;
> +		return true;
>  	if (name_len == 2 && !strncmp("..", name, 2))
> -		return 0;
> +		return true;
>  
>  	/* do not include dio entry in case of orphan scan */
>  	if ((p->orphan_reco_type == ORPHAN_NO_NEED_TRUNCATE) &&
>  			(!strncmp(name, OCFS2_DIO_ORPHAN_PREFIX,
>  			OCFS2_DIO_ORPHAN_PREFIX_LEN)))
> -		return 0;
> +		return true;
>  
>  	/* Skip bad inodes so that recovery can continue */
>  	iter = ocfs2_iget(p->osb, ino,
>  			  OCFS2_FI_FLAG_ORPHAN_RECOVERY, 0);
>  	if (IS_ERR(iter))
> -		return 0;
> +		return true;
>  
>  	if (!strncmp(name, OCFS2_DIO_ORPHAN_PREFIX,
>  			OCFS2_DIO_ORPHAN_PREFIX_LEN))
> @@ -2090,7 +2090,7 @@ static int ocfs2_orphan_filldir(struct dir_context *ctx, const char *name,
>  	 * happen concurrently with unlink/rename */
>  	if (OCFS2_I(iter)->ip_next_orphan) {
>  		iput(iter);
> -		return 0;
> +		return true;
>  	}
>  
>  	trace_ocfs2_orphan_filldir((unsigned long long)OCFS2_I(iter)->ip_blkno);
> @@ -2099,7 +2099,7 @@ static int ocfs2_orphan_filldir(struct dir_context *ctx, const char *name,
>  	OCFS2_I(iter)->ip_next_orphan = p->head;
>  	p->head = iter;
>  
> -	return 0;
> +	return true;
>  }
>  
>  static int ocfs2_queue_orphans(struct ocfs2_super *osb,
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 78f62cc1797b..8c25d185cdc0 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -170,7 +170,7 @@ static struct ovl_cache_entry *ovl_cache_entry_new(struct ovl_readdir_data *rdd,
>  	return p;
>  }
>  
> -static int ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
> +static bool ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
>  				  const char *name, int len, u64 ino,
>  				  unsigned int d_type)
>  {
> @@ -179,22 +179,22 @@ static int ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
>  	struct ovl_cache_entry *p;
>  
>  	if (ovl_cache_entry_find_link(name, len, &newp, &parent))
> -		return 0;
> +		return true;
>  
>  	p = ovl_cache_entry_new(rdd, name, len, ino, d_type);
>  	if (p == NULL) {
>  		rdd->err = -ENOMEM;
> -		return -ENOMEM;
> +		return false;
>  	}
>  
>  	list_add_tail(&p->l_node, rdd->list);
>  	rb_link_node(&p->node, parent, newp);
>  	rb_insert_color(&p->node, rdd->root);
>  
> -	return 0;
> +	return true;
>  }
>  
> -static int ovl_fill_lowest(struct ovl_readdir_data *rdd,
> +static bool ovl_fill_lowest(struct ovl_readdir_data *rdd,
>  			   const char *name, int namelen,
>  			   loff_t offset, u64 ino, unsigned int d_type)
>  {
> @@ -211,7 +211,7 @@ static int ovl_fill_lowest(struct ovl_readdir_data *rdd,
>  			list_add_tail(&p->l_node, &rdd->middle);
>  	}
>  
> -	return rdd->err;
> +	return rdd->err == 0;
>  }
>  
>  void ovl_cache_free(struct list_head *list)
> @@ -250,7 +250,7 @@ static void ovl_cache_put(struct ovl_dir_file *od, struct dentry *dentry)
>  	}
>  }
>  
> -static int ovl_fill_merge(struct dir_context *ctx, const char *name,
> +static bool ovl_fill_merge(struct dir_context *ctx, const char *name,
>  			  int namelen, loff_t offset, u64 ino,
>  			  unsigned int d_type)
>  {
> @@ -528,7 +528,7 @@ static int ovl_cache_update_ino(struct path *path, struct ovl_cache_entry *p)
>  	goto out;
>  }
>  
> -static int ovl_fill_plain(struct dir_context *ctx, const char *name,
> +static bool ovl_fill_plain(struct dir_context *ctx, const char *name,
>  			  int namelen, loff_t offset, u64 ino,
>  			  unsigned int d_type)
>  {
> @@ -540,11 +540,11 @@ static int ovl_fill_plain(struct dir_context *ctx, const char *name,
>  	p = ovl_cache_entry_new(rdd, name, namelen, ino, d_type);
>  	if (p == NULL) {
>  		rdd->err = -ENOMEM;
> -		return -ENOMEM;
> +		return false;
>  	}
>  	list_add_tail(&p->l_node, rdd->list);
>  
> -	return 0;
> +	return true;
>  }
>  
>  static int ovl_dir_read_impure(struct path *path,  struct list_head *list,
> @@ -648,7 +648,7 @@ struct ovl_readdir_translate {
>  	bool xinowarn;
>  };
>  
> -static int ovl_fill_real(struct dir_context *ctx, const char *name,
> +static bool ovl_fill_real(struct dir_context *ctx, const char *name,
>  			   int namelen, loff_t offset, u64 ino,
>  			   unsigned int d_type)
>  {
> @@ -1027,7 +1027,7 @@ void ovl_cleanup_whiteouts(struct ovl_fs *ofs, struct dentry *upper,
>  	inode_unlock(upper->d_inode);
>  }
>  
> -static int ovl_check_d_type(struct dir_context *ctx, const char *name,
> +static bool ovl_check_d_type(struct dir_context *ctx, const char *name,
>  			  int namelen, loff_t offset, u64 ino,
>  			  unsigned int d_type)
>  {
> @@ -1036,12 +1036,12 @@ static int ovl_check_d_type(struct dir_context *ctx, const char *name,
>  
>  	/* Even if d_type is not supported, DT_DIR is returned for . and .. */
>  	if (!strncmp(name, ".", namelen) || !strncmp(name, "..", namelen))
> -		return 0;
> +		return true;
>  
>  	if (d_type != DT_UNKNOWN)
>  		rdd->d_type_supported = true;
>  
> -	return 0;
> +	return true;
>  }
>  
>  /*
> diff --git a/fs/readdir.c b/fs/readdir.c
> index 09e8ed7d4161..9c53edb60c03 100644
> --- a/fs/readdir.c
> +++ b/fs/readdir.c
> @@ -140,7 +140,7 @@ struct readdir_callback {
>  	int result;
>  };
>  
> -static int fillonedir(struct dir_context *ctx, const char *name, int namlen,
> +static bool fillonedir(struct dir_context *ctx, const char *name, int namlen,
>  		      loff_t offset, u64 ino, unsigned int d_type)
>  {
>  	struct readdir_callback *buf =
> @@ -149,14 +149,14 @@ static int fillonedir(struct dir_context *ctx, const char *name, int namlen,
>  	unsigned long d_ino;
>  
>  	if (buf->result)
> -		return -EINVAL;
> +		return false;
>  	buf->result = verify_dirent_name(name, namlen);
> -	if (buf->result < 0)
> -		return buf->result;
> +	if (buf->result)
> +		return false;

Probably pretty obvious but just to make sure buf->result being 0 is
supposed to return false in the two locations in this patch?

>  	d_ino = ino;
>  	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
>  		buf->result = -EOVERFLOW;
> -		return -EOVERFLOW;
> +		return false;
>  	}
>  	buf->result++;
>  	dirent = buf->dirent;
> @@ -169,12 +169,12 @@ static int fillonedir(struct dir_context *ctx, const char *name, int namlen,
>  	unsafe_put_user(namlen, &dirent->d_namlen, efault_end);
>  	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
>  	user_write_access_end();
> -	return 0;
> +	return true;
>  efault_end:
>  	user_write_access_end();
>  efault:
>  	buf->result = -EFAULT;
> -	return -EFAULT;
> +	return false;
>  }
>  
>  SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
> @@ -219,7 +219,7 @@ struct getdents_callback {
>  	int error;
>  };
>  
> -static int filldir(struct dir_context *ctx, const char *name, int namlen,
> +static bool filldir(struct dir_context *ctx, const char *name, int namlen,
>  		   loff_t offset, u64 ino, unsigned int d_type)
>  {
>  	struct linux_dirent __user *dirent, *prev;
> @@ -232,18 +232,18 @@ static int filldir(struct dir_context *ctx, const char *name, int namlen,
>  
>  	buf->error = verify_dirent_name(name, namlen);
>  	if (unlikely(buf->error))
> -		return buf->error;
> +		return false;
>  	buf->error = -EINVAL;	/* only used if we fail.. */
>  	if (reclen > buf->count)
> -		return -EINVAL;
> +		return false;
>  	d_ino = ino;
>  	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
>  		buf->error = -EOVERFLOW;
> -		return -EOVERFLOW;
> +		return false;
>  	}
>  	prev_reclen = buf->prev_reclen;
>  	if (prev_reclen && signal_pending(current))
> -		return -EINTR;
> +		return false;
>  	dirent = buf->current_dir;
>  	prev = (void __user *) dirent - prev_reclen;
>  	if (!user_write_access_begin(prev, reclen + prev_reclen))
> @@ -260,12 +260,12 @@ static int filldir(struct dir_context *ctx, const char *name, int namlen,
>  	buf->current_dir = (void __user *)dirent + reclen;
>  	buf->prev_reclen = reclen;
>  	buf->count -= reclen;
> -	return 0;
> +	return true;
>  efault_end:
>  	user_write_access_end();
>  efault:
>  	buf->error = -EFAULT;
> -	return -EFAULT;
> +	return false;
>  }
>  
>  SYSCALL_DEFINE3(getdents, unsigned int, fd,
> @@ -307,7 +307,7 @@ struct getdents_callback64 {
>  	int error;
>  };
>  
> -static int filldir64(struct dir_context *ctx, const char *name, int namlen,
> +static bool filldir64(struct dir_context *ctx, const char *name, int namlen,
>  		     loff_t offset, u64 ino, unsigned int d_type)
>  {
>  	struct linux_dirent64 __user *dirent, *prev;
> @@ -319,13 +319,13 @@ static int filldir64(struct dir_context *ctx, const char *name, int namlen,
>  
>  	buf->error = verify_dirent_name(name, namlen);
>  	if (unlikely(buf->error))
> -		return buf->error;
> +		return false;
>  	buf->error = -EINVAL;	/* only used if we fail.. */
>  	if (reclen > buf->count)
> -		return -EINVAL;
> +		return false;
>  	prev_reclen = buf->prev_reclen;
>  	if (prev_reclen && signal_pending(current))
> -		return -EINTR;
> +		return false;
>  	dirent = buf->current_dir;
>  	prev = (void __user *)dirent - prev_reclen;
>  	if (!user_write_access_begin(prev, reclen + prev_reclen))
> @@ -342,13 +342,13 @@ static int filldir64(struct dir_context *ctx, const char *name, int namlen,
>  	buf->prev_reclen = reclen;
>  	buf->current_dir = (void __user *)dirent + reclen;
>  	buf->count -= reclen;
> -	return 0;
> +	return true;
>  
>  efault_end:
>  	user_write_access_end();
>  efault:
>  	buf->error = -EFAULT;
> -	return -EFAULT;
> +	return false;
>  }
>  
>  SYSCALL_DEFINE3(getdents64, unsigned int, fd,
> @@ -397,7 +397,7 @@ struct compat_readdir_callback {
>  	int result;
>  };
>  
> -static int compat_fillonedir(struct dir_context *ctx, const char *name,
> +static bool compat_fillonedir(struct dir_context *ctx, const char *name,
>  			     int namlen, loff_t offset, u64 ino,
>  			     unsigned int d_type)
>  {
> @@ -407,14 +407,14 @@ static int compat_fillonedir(struct dir_context *ctx, const char *name,
>  	compat_ulong_t d_ino;
>  
>  	if (buf->result)
> -		return -EINVAL;
> +		return false;
>  	buf->result = verify_dirent_name(name, namlen);
> -	if (buf->result < 0)
> -		return buf->result;
> +	if (buf->result)
> +		return false;

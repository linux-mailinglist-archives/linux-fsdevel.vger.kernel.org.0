Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9D83074DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 12:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhA1LdI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 06:33:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:53610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhA1LdG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:33:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8531DB080;
        Thu, 28 Jan 2021 11:32:24 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 2591cab8;
        Thu, 28 Jan 2021 11:33:17 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v4 13/17] ceph: add support to readdir for encrypted
 filenames
References: <20210120182847.644850-1-jlayton@kernel.org>
        <20210120182847.644850-14-jlayton@kernel.org>
Date:   Thu, 28 Jan 2021 11:33:17 +0000
In-Reply-To: <20210120182847.644850-14-jlayton@kernel.org> (Jeff Layton's
        message of "Wed, 20 Jan 2021 13:28:43 -0500")
Message-ID: <8735yljnya.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> writes:

> Add helper functions for buffer management and for decrypting filenames
> returned by the MDS. Wire those into the readdir codepaths.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/crypto.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/ceph/crypto.h | 41 ++++++++++++++++++++++++++
>  fs/ceph/dir.c    | 62 +++++++++++++++++++++++++++++++--------
>  fs/ceph/inode.c  | 38 ++++++++++++++++++++++--
>  4 files changed, 202 insertions(+), 15 deletions(-)
>
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index f037a4939026..7ddd434c5baf 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -107,3 +107,79 @@ int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
>  		ceph_pagelist_release(pagelist);
>  	return ret;
>  }
> +
> +/**
> + * ceph_fname_to_usr - convert a filename for userland presentation
> + * @fname: ceph_fname to be converted
> + * @tname: temporary name buffer to use for conversion (may be NULL)
> + * @oname: where converted name should be placed
> + * @is_nokey: set to true if key wasn't available during conversion (may be NULL)
> + *
> + * Given a filename (usually from the MDS), format it for presentation to
> + * userland. If @parent is not encrypted, just pass it back as-is.
> + *
> + * Otherwise, base64 decode the string, and then ask fscrypt to format it
> + * for userland presentation.
> + *
> + * Returns 0 on success or negative error code on error.
> + */
> +int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
> +		      struct fscrypt_str *oname, bool *is_nokey)
> +{
> +	int ret;
> +	struct fscrypt_str _tname = FSTR_INIT(NULL, 0);
> +	struct fscrypt_str iname;
> +
> +	if (!IS_ENCRYPTED(fname->dir)) {
> +		oname->name = fname->name;
> +		oname->len = fname->name_len;
> +		return 0;
> +	}
> +
> +	/* Sanity check that the resulting name will fit in the buffer */
> +	if (fname->name_len > FSCRYPT_BASE64_CHARS(NAME_MAX))
> +		return -EIO;
> +
> +	ret = __fscrypt_prepare_readdir(fname->dir);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Use the raw dentry name as sent by the MDS instead of
> +	 * generating a nokey name via fscrypt.
> +	 */
> +	if (!fscrypt_has_encryption_key(fname->dir)) {

While chasing a different the bug (the one I mention yesterday on IRC), I
came across this memory leak: oname->name needs to be freed here.  I
believe that a

	fscrypt_fname_free_buffer(oname);

before the kmemdup() below should be enough.

Cheers,
-- 
Luis

> +		oname->name = kmemdup(fname->name, fname->name_len, GFP_KERNEL);
> +		oname->len = fname->name_len;
> +		if (is_nokey)
> +			*is_nokey = true;
> +		return 0;
> +	}
> +
> +	if (fname->ctext_len == 0) {
> +		int declen;
> +
> +		if (!tname) {
> +			ret = fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
> +			if (ret)
> +				return ret;
> +			tname = &_tname;
> +		}
> +
> +		declen = fscrypt_base64_decode(fname->name, fname->name_len, tname->name);
> +		if (declen <= 0) {
> +			ret = -EIO;
> +			goto out;
> +		}
> +		iname.name = tname->name;
> +		iname.len = declen;
> +	} else {
> +		iname.name = fname->ctext;
> +		iname.len = fname->ctext_len;
> +	}
> +
> +	ret = fscrypt_fname_disk_to_usr(fname->dir, 0, 0, &iname, oname);
> +out:
> +	fscrypt_fname_free_buffer(&_tname);
> +	return ret;
> +}
> diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
> index 331b9c8da7fb..5a3fb68eb814 100644
> --- a/fs/ceph/crypto.h
> +++ b/fs/ceph/crypto.h
> @@ -11,6 +11,14 @@
>  
>  #define	CEPH_XATTR_NAME_ENCRYPTION_CONTEXT	"encryption.ctx"
>  
> +struct ceph_fname {
> +	struct inode	*dir;
> +	char 		*name;		// b64 encoded, possibly hashed
> +	unsigned char	*ctext;		// binary crypttext (if any)
> +	u32		name_len;	// length of name buffer
> +	u32		ctext_len;	// length of crypttext
> +};
> +
>  #ifdef CONFIG_FS_ENCRYPTION
>  
>  /*
> @@ -37,6 +45,22 @@ static inline void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc)
>  int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
>  				 struct ceph_acl_sec_ctx *as);
>  
> +static inline int ceph_fname_alloc_buffer(struct inode *parent, struct fscrypt_str *fname)
> +{
> +	if (!IS_ENCRYPTED(parent))
> +		return 0;
> +	return fscrypt_fname_alloc_buffer(NAME_MAX, fname);
> +}
> +
> +static inline void ceph_fname_free_buffer(struct inode *parent, struct fscrypt_str *fname)
> +{
> +	if (IS_ENCRYPTED(parent))
> +		fscrypt_fname_free_buffer(fname);
> +}
> +
> +int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
> +			struct fscrypt_str *oname, bool *is_nokey);
> +
>  #else /* CONFIG_FS_ENCRYPTION */
>  
>  static inline void ceph_fscrypt_set_ops(struct super_block *sb)
> @@ -55,6 +79,23 @@ static inline int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *
>  	return 0;
>  }
>  
> +static inline int ceph_fname_alloc_buffer(struct inode *parent, struct fscrypt_str *fname)
> +{
> +	return 0;
> +}
> +
> +static inline void ceph_fname_free_buffer(struct inode *parent, struct fscrypt_str *fname)
> +{
> +}
> +
> +static inline int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
> +				    struct fscrypt_str *oname, bool *is_nokey)
> +{
> +	oname->name = fname->name;
> +	oname->len = fname->name_len;
> +	return 0;
> +}
> +
>  #endif /* CONFIG_FS_ENCRYPTION */
>  
>  #endif
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 20943769438c..236c381ab6bd 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -9,6 +9,7 @@
>  
>  #include "super.h"
>  #include "mds_client.h"
> +#include "crypto.h"
>  
>  /*
>   * Directory operations: readdir, lookup, create, link, unlink,
> @@ -241,7 +242,9 @@ static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
>  		di = ceph_dentry(dentry);
>  		if (d_unhashed(dentry) ||
>  		    d_really_is_negative(dentry) ||
> -		    di->lease_shared_gen != shared_gen) {
> +		    di->lease_shared_gen != shared_gen ||
> +		    ((dentry->d_flags & DCACHE_NOKEY_NAME) &&
> +		     fscrypt_has_encryption_key(dir))) {
>  			spin_unlock(&dentry->d_lock);
>  			dput(dentry);
>  			err = -EAGAIN;
> @@ -313,6 +316,8 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
>  	int err;
>  	unsigned frag = -1;
>  	struct ceph_mds_reply_info_parsed *rinfo;
> +	struct fscrypt_str tname = FSTR_INIT(NULL, 0);
> +	struct fscrypt_str oname = FSTR_INIT(NULL, 0);
>  
>  	dout("readdir %p file %p pos %llx\n", inode, file, ctx->pos);
>  	if (dfi->file_info.flags & CEPH_F_ATEND)
> @@ -340,6 +345,10 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
>  		ctx->pos = 2;
>  	}
>  
> +	err = fscrypt_prepare_readdir(inode);
> +	if (err)
> +		goto out;
> +
>  	spin_lock(&ci->i_ceph_lock);
>  	/* request Fx cap. if have Fx, we don't need to release Fs cap
>  	 * for later create/unlink. */
> @@ -360,6 +369,14 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
>  		spin_unlock(&ci->i_ceph_lock);
>  	}
>  
> +	err = ceph_fname_alloc_buffer(inode, &tname);
> +	if (err < 0)
> +		goto out;
> +
> +	err = ceph_fname_alloc_buffer(inode, &oname);
> +	if (err < 0)
> +		goto out;
> +
>  	/* proceed with a normal readdir */
>  more:
>  	/* do we have the correct frag content buffered? */
> @@ -387,12 +404,14 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
>  		dout("readdir fetching %llx.%llx frag %x offset '%s'\n",
>  		     ceph_vinop(inode), frag, dfi->last_name);
>  		req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
> -		if (IS_ERR(req))
> -			return PTR_ERR(req);
> +		if (IS_ERR(req)) {
> +			err = PTR_ERR(req);
> +			goto out;
> +		}
>  		err = ceph_alloc_readdir_reply_buffer(req, inode);
>  		if (err) {
>  			ceph_mdsc_put_request(req);
> -			return err;
> +			goto out;
>  		}
>  		/* hints to request -> mds selection code */
>  		req->r_direct_mode = USE_AUTH_MDS;
> @@ -405,7 +424,8 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
>  			req->r_path2 = kstrdup(dfi->last_name, GFP_KERNEL);
>  			if (!req->r_path2) {
>  				ceph_mdsc_put_request(req);
> -				return -ENOMEM;
> +				err = -ENOMEM;
> +				goto out;
>  			}
>  		} else if (is_hash_order(ctx->pos)) {
>  			req->r_args.readdir.offset_hash =
> @@ -426,7 +446,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
>  		err = ceph_mdsc_do_request(mdsc, NULL, req);
>  		if (err < 0) {
>  			ceph_mdsc_put_request(req);
> -			return err;
> +			goto out;
>  		}
>  		dout("readdir got and parsed readdir result=%d on "
>  		     "frag %x, end=%d, complete=%d, hash_order=%d\n",
> @@ -479,7 +499,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
>  			err = note_last_dentry(dfi, rde->name, rde->name_len,
>  					       next_offset);
>  			if (err)
> -				return err;
> +				goto out;
>  		} else if (req->r_reply_info.dir_end) {
>  			dfi->next_offset = 2;
>  			/* keep last name */
> @@ -507,22 +527,37 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
>  	}
>  	for (; i < rinfo->dir_nr; i++) {
>  		struct ceph_mds_reply_dir_entry *rde = rinfo->dir_entries + i;
> +		struct ceph_fname fname = { .dir	= inode,
> +					    .name	= rde->name,
> +					    .name_len	= rde->name_len,
> +					    .ctext	= rde->altname,
> +					    .ctext_len	= rde->altname_len };
> +		u32 olen = oname.len;
>  
>  		BUG_ON(rde->offset < ctx->pos);
> +		BUG_ON(!rde->inode.in);
>  
>  		ctx->pos = rde->offset;
>  		dout("readdir (%d/%d) -> %llx '%.*s' %p\n",
>  		     i, rinfo->dir_nr, ctx->pos,
>  		     rde->name_len, rde->name, &rde->inode.in);
>  
> -		BUG_ON(!rde->inode.in);
> +		err = ceph_fname_to_usr(&fname, &tname, &oname, NULL);
> +		if (err) {
> +			dout("Unable to decode %.*s. Skipping it.\n", rde->name_len, rde->name);
> +			continue;
> +		}
>  
> -		if (!dir_emit(ctx, rde->name, rde->name_len,
> +		if (!dir_emit(ctx, oname.name, oname.len,
>  			      ceph_present_ino(inode->i_sb, le64_to_cpu(rde->inode.in->ino)),
>  			      le32_to_cpu(rde->inode.in->mode) >> 12)) {
>  			dout("filldir stopping us...\n");
> -			return 0;
> +			err = 0;
> +			goto out;
>  		}
> +
> +		/* Reset the lengths to their original allocated vals */
> +		oname.len = olen;
>  		ctx->pos++;
>  	}
>  
> @@ -577,9 +612,12 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
>  					dfi->dir_ordered_count);
>  		spin_unlock(&ci->i_ceph_lock);
>  	}
> -
> +	err = 0;
>  	dout("readdir %p file %p done.\n", inode, file);
> -	return 0;
> +out:
> +	ceph_fname_free_buffer(inode, &tname);
> +	ceph_fname_free_buffer(inode, &oname);
> +	return err;
>  }
>  
>  static void reset_readdir(struct ceph_dir_file_info *dfi)
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 2854711e8988..9863a8818132 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1659,7 +1659,8 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
>  			     struct ceph_mds_session *session)
>  {
>  	struct dentry *parent = req->r_dentry;
> -	struct ceph_inode_info *ci = ceph_inode(d_inode(parent));
> +	struct inode *inode = d_inode(parent);
> +	struct ceph_inode_info *ci = ceph_inode(inode);
>  	struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
>  	struct qstr dname;
>  	struct dentry *dn;
> @@ -1669,6 +1670,8 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
>  	u32 last_hash = 0;
>  	u32 fpos_offset;
>  	struct ceph_readdir_cache_control cache_ctl = {};
> +	struct fscrypt_str tname = FSTR_INIT(NULL, 0);
> +	struct fscrypt_str oname = FSTR_INIT(NULL, 0);
>  
>  	if (test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags))
>  		return readdir_prepopulate_inodes_only(req, session);
> @@ -1720,14 +1723,36 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
>  	cache_ctl.index = req->r_readdir_cache_idx;
>  	fpos_offset = req->r_readdir_offset;
>  
> +	err = ceph_fname_alloc_buffer(inode, &tname);
> +	if (err < 0)
> +		goto out;
> +
> +	err = ceph_fname_alloc_buffer(inode, &oname);
> +	if (err < 0)
> +		goto out;
> +
>  	/* FIXME: release caps/leases if error occurs */
>  	for (i = 0; i < rinfo->dir_nr; i++) {
> +		bool is_nokey = false;
>  		struct ceph_mds_reply_dir_entry *rde = rinfo->dir_entries + i;
>  		struct ceph_vino tvino;
> +		u32 olen = oname.len;
> +		struct ceph_fname fname = { .dir	= inode,
> +					    .name	= rde->name,
> +					    .name_len	= rde->name_len,
> +					    .ctext	= rde->altname,
> +					    .ctext_len	= rde->altname_len };
> +
> +		err = ceph_fname_to_usr(&fname, &tname, &oname, &is_nokey);
> +		if (err) {
> +			dout("Unable to decode %.*s. Skipping it.", rde->name_len, rde->name);
> +			continue;
> +		}
>  
> -		dname.name = rde->name;
> -		dname.len = rde->name_len;
> +		dname.name = oname.name;
> +		dname.len = oname.len;
>  		dname.hash = full_name_hash(parent, dname.name, dname.len);
> +		oname.len = olen;
>  
>  		tvino.ino = le64_to_cpu(rde->inode.in->ino);
>  		tvino.snap = le64_to_cpu(rde->inode.in->snapid);
> @@ -1758,6 +1783,11 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
>  				err = -ENOMEM;
>  				goto out;
>  			}
> +			if (is_nokey) {
> +				spin_lock(&dn->d_lock);
> +				dn->d_flags |= DCACHE_NOKEY_NAME;
> +				spin_unlock(&dn->d_lock);
> +			}
>  		} else if (d_really_is_positive(dn) &&
>  			   (ceph_ino(d_inode(dn)) != tvino.ino ||
>  			    ceph_snap(d_inode(dn)) != tvino.snap)) {
> @@ -1848,6 +1878,8 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
>  		req->r_readdir_cache_idx = cache_ctl.index;
>  	}
>  	ceph_readdir_cache_release(&cache_ctl);
> +	ceph_fname_free_buffer(inode, &tname);
> +	ceph_fname_free_buffer(inode, &oname);
>  	dout("readdir_prepopulate done\n");
>  	return err;
>  }
> -- 
>
> 2.29.2
>

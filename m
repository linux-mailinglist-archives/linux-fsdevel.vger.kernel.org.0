Return-Path: <linux-fsdevel+bounces-78381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAMeF5MVn2nWYwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 16:30:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB6C1999D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 16:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E2B331F7353
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 15:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E753D4120;
	Wed, 25 Feb 2026 15:16:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp03-ext2.udag.de (smtp03-ext2.udag.de [62.146.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8163D34B7;
	Wed, 25 Feb 2026 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032610; cv=none; b=F+J+TNQ0x3MrUDFEtQj8jXKT3sYahc4pXETplm9t1Vy4ttpkFI51ZA7axP7GGzzlJoQK53n+hrtLmAK+IXYQjaPzba8mjcgywtGbIobBmHyLwu1lz7tcpUC5gD+BuktMvPCep+KEQmqCMTSFzhaRnF4LzLLKAB24u57E9FMT28s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032610; c=relaxed/simple;
	bh=fc7/+Dqq9XEJHgf0xf9yoQfMNyVVDvOcPDpDDIbMlC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CB4cKCrFPzlDzvPQ7aP/l+/dlsK0ns8YxzU85J53xLumbdjenpxT+z4SjwOn0n1s9PNMvMKtA5+s/XzHqJ+pV+G3eBCiuxJOaWQNJuSCIbNkaIIRDY0dUe6a0CoOyZHFpONd4cNHnr9id0fHAVMz5nBYVRw8WyGDeFl9MkmodlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp03-ext2.udag.de (Postfix) with ESMTPA id 2EDA8E04CE;
	Wed, 25 Feb 2026 16:08:11 +0100 (CET)
Authentication-Results: smtp03-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Wed, 25 Feb 2026 16:08:10 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, 
	Bernd Schubert <bernd@bsbernd.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Kevin Chen <kchen@ddn.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matt Harvey <mharvey@jumptrading.com>, kernel-dev@igalia.com
Subject: Re: [RFC PATCH v3 8/8] fuse: implementation of
 mkobj_handle+statx+open compound operation
Message-ID: <aZ8O2ohfGEgqE6TT@fedora.fritz.box>
References: <20260225112439.27276-1-luis@igalia.com>
 <20260225112439.27276-9-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225112439.27276-9-luis@igalia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78381-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,ddn.com,bsbernd.com,kernel.org,vger.kernel.org,jumptrading.com,igalia.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:email,fedora.fritz.box:mid]
X-Rspamd-Queue-Id: AAB6C1999D8
X-Rspamd-Action: no action

Hi Luis,

On Wed, Feb 25, 2026 at 11:24:39AM +0000, Luis Henriques wrote:
> The implementation of this compound operation allows atomic_open() to use
> file handle.  It also introduces a new MKOBJ_HANDLE operation that will
> handle the file system object creation and will return the file handle.
> 
> The atomicity of the operation (create + open) needs to be handled in
> user-space (e.g. the handling of the O_EXCL flag).
> 
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
>  fs/fuse/dir.c             | 219 +++++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/fuse.h |   2 +
>  2 files changed, 220 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 7fa8c405f1a3..b5beb1d62c3d 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1173,6 +1173,220 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
>  	return err;
>  }
>  
> +static int fuse_mkobj_handle_init(struct fuse_mount *fm, struct fuse_args *args,
> +				  struct mnt_idmap *idmap, struct inode *dir,
> +				  struct dentry *entry, unsigned int flags,
> +				  umode_t mode,
> +				  struct fuse_create_in *inarg,
> +				  struct fuse_entry2_out *outarg,
> +				  struct fuse_file_handle **fh)
> +{
> +	struct fuse_inode *fi;
> +	size_t fh_size = sizeof(struct fuse_file_handle) + MAX_HANDLE_SZ;
> +	int err = 0;
> +
> +	*fh = kzalloc(fh_size, GFP_KERNEL);
> +	if (!*fh)
> +		return -ENOMEM;
> +
> +	memset(inarg, 0, sizeof(*inarg));
> +	memset(outarg, 0, sizeof(*outarg));
> +
> +	inarg->flags = flags;
> +	inarg->mode = mode;
> +	inarg->umask = current_umask();
> +
> +	if (fm->fc->handle_killpriv_v2 && (flags & O_TRUNC) &&
> +	    !(flags & O_EXCL) && !capable(CAP_FSETID))
> +		inarg->open_flags |= FUSE_OPEN_KILL_SUIDGID;
> +
> +	args->opcode = FUSE_MKOBJ_HANDLE;
> +	args->nodeid = get_node_id(dir);
> +	args->in_numargs = 2;
> +	args->in_args[0].size = sizeof(*inarg);
> +	args->in_args[0].value = inarg;
> +	args->in_args[1].size = entry->d_name.len + 1;
> +	args->in_args[1].value = entry->d_name.name;
> +
> +	err = get_create_ext(idmap, args, dir, entry, mode);
> +	if (err)
> +		goto out_err;
> +	fi = get_fuse_inode(dir);
> +	if (fi && fi->fh) {
> +		if (!args->is_ext) {
> +			args->is_ext = true;
> +			args->ext_idx = args->in_numargs++;
> +		}
> +		err = create_ext_handle(&args->in_args[args->ext_idx], fi);
> +		if (err)
> +			goto out_err;
> +	}
> +
> +	args->out_numargs = 2;
> +	args->out_args[0].size = sizeof(*outarg);
> +	args->out_args[0].value = outarg;
> +	args->out_args[1].size = fh_size;
> +	args->out_args[1].value = *fh;
> +
> +out_err:
> +	if (err) {
> +		kfree(*fh);
> +		free_ext_value(args);
> +	}
> +
> +	return err;
> +}
> +
> +static int fuse_mkobj_statx_open(struct mnt_idmap *idmap, struct inode *dir,
> +				 struct dentry *entry, struct file *file,
> +				 unsigned int flags, umode_t mode)
> +{
> +	struct fuse_compound_req *compound;
> +	struct fuse_mount *fm = get_fuse_mount(dir);
> +	struct fuse_inode *fi = NULL;
> +	struct fuse_create_in mkobj_in;
> +	struct fuse_entry2_out mkobj_out;
> +	struct fuse_statx_in statx_in;
> +	struct fuse_statx_out statx_out;
> +	struct fuse_open_in open_in;
> +	struct fuse_open_out *open_outp;
> +	FUSE_ARGS(mkobj_args);
> +	FUSE_ARGS(statx_args);
> +	FUSE_ARGS(open_args);
> +	struct fuse_forget_link *forget;
> +	struct fuse_file *ff;
> +	struct fuse_attr attr;
> +	struct fuse_file_handle *fh = NULL;
> +	struct inode *inode;
> +	int epoch, ret = -EIO;
> +	int i;
> +
> +	epoch = atomic_read(&fm->fc->epoch);
> +
> +	ret = -ENOMEM;
> +	forget = fuse_alloc_forget();
> +	if (!forget)
> +		return -ENOMEM;
> +	ff = fuse_file_alloc(fm, true);
> +	if (!ff)
> +		goto out_forget;
> +
> +	if (!fm->fc->dont_mask)
> +		mode &= ~current_umask();
> +
> +	flags &= ~O_NOCTTY;
> +
> +	compound = fuse_compound_alloc(fm, FUSE_COMPOUND_ATOMIC);
> +	if (!compound)
> +		goto out_free_ff;
> +

Just to clarify for myself and maybe others.
You want this to be processed atomic on the fuse server and never
be separated by the upcoming 'decode and send separate' code in the
kernel?
Is that really necessarry? What would the consequences be, 
if this is not really atomic?

> +	fi = get_fuse_inode(dir);
> +	if (!fi) {
> +		ret = -EIO;
> +		goto out_compound;
> +	}
> +	ret = fuse_mkobj_handle_init(fm, &mkobj_args, idmap, dir, entry, flags,
> +				     mode, &mkobj_in, &mkobj_out, &fh);
> +	if (ret)
> +		goto out_compound;
> +
> +	ret = fuse_compound_add(compound, &mkobj_args);
> +	if (ret)
> +		goto out_mkobj_args;
> +
> +	fuse_statx_init(&statx_args, &statx_in, FUSE_ROOT_ID, NULL, &statx_out);
> +	ret = fuse_compound_add(compound, &statx_args);
> +	if (ret)
> +		goto out_mkobj_args;
> +
> +	ff->fh = 0;
> +	ff->open_flags = FOPEN_KEEP_CACHE;
> +	memset(&open_in, 0, sizeof(open_in));
> +
> +	/* XXX flags handling */
> +	open_in.flags = ff->open_flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
> +	if (!fm->fc->atomic_o_trunc)
> +		open_in.flags &= ~O_TRUNC;
> +	if (fm->fc->handle_killpriv_v2 &&
> +	    (open_in.flags & O_TRUNC) && !capable(CAP_FSETID))
> +		open_in.open_flags |= FUSE_OPEN_KILL_SUIDGID;
> +
> +	open_outp = &ff->args->open_outarg;
> +	fuse_open_args_fill(&open_args, FUSE_ROOT_ID, FUSE_OPEN, &open_in,
> +			    open_outp);
> +
> +	ret = fuse_compound_add(compound, &open_args);
> +	if (ret)
> +		goto out_mkobj_args;
> +
> +	ret = fuse_compound_send(compound);

Your compound looks good so far ;-)

> +	if (ret)
> +		goto out_mkobj_args;
> +
> +	for (i = 0; i < 3; i++) {
> +		int err;
> +
> +		err = fuse_compound_get_error(compound, i);
> +		if (err && !ret)
> +			ret = err;
> +	}

this is probably why you opted for that 'give me any occurred error'
functionality?

> +	if (ret)
> +		goto out_mkobj_args;
> +
> +	fuse_statx_to_attr(&statx_out.stat, &attr);
> +	WARN_ON(fuse_invalid_attr(&attr));
> +	ret = -EIO;
> +	if (!S_ISREG(attr.mode) || invalid_nodeid(mkobj_out.nodeid) ||
> +	    fuse_invalid_attr(&attr))
> +		goto out_mkobj_args;
> +
> +	ff->fh = open_outp->fh;
> +	ff->nodeid = mkobj_out.nodeid;
> +	ff->open_flags = open_outp->open_flags;
> +	inode = fuse_iget(dir->i_sb, mkobj_out.nodeid, mkobj_out.generation,
> +			  &attr, ATTR_TIMEOUT(&statx_out), 0, 0, fh);
> +	if (!inode) {
> +		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
> +		fuse_sync_release(NULL, ff, flags);
> +		fuse_queue_forget(fm->fc, forget, mkobj_out.nodeid, 1);
> +		ret = -ENOMEM;
> +		goto out_mkobj_args;
> +	}
> +	d_instantiate(entry, inode);
> +
> +	entry->d_time = epoch;
> +	fuse_dentry_settime(entry,
> +		fuse_time_to_jiffies(mkobj_out.entry_valid,
> +				     mkobj_out.entry_valid_nsec));
> +	fuse_dir_changed(dir);
> +	ret = generic_file_open(inode, file);
> +	if (!ret) {
> +		file->private_data = ff;
> +		ret = finish_open(file, entry, fuse_finish_open);
> +	}
> +	if (ret) {
> +		fuse_sync_release(get_fuse_inode(inode), ff, flags);
> +	} else {
> +		if (fm->fc->atomic_o_trunc && (flags & O_TRUNC))
> +			truncate_pagecache(inode, 0);
> +		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
> +			invalidate_inode_pages2(inode->i_mapping);
> +	}
> +
> +out_mkobj_args:
> +	fuse_req_free_argvar_ext(&mkobj_args);
> +out_compound:
> +	kfree(compound);
> +out_free_ff:
> +	if (ret)
> +		fuse_file_free(ff);
> +out_forget:
> +	kfree(forget);
> +	kfree(fh);
> +
> +	return ret;
> +}
> +
>  static int fuse_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
>  		      umode_t, dev_t);
>  static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
> @@ -1201,7 +1415,10 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
>  	if (fc->no_create)
>  		goto mknod;
>  
> -	err = fuse_create_open(idmap, dir, entry, file, flags, mode, FUSE_CREATE);
> +	if (fc->lookup_handle)
> +		err = fuse_mkobj_statx_open(idmap, dir, entry, file, flags, mode);
> +	else
> +		err = fuse_create_open(idmap, dir, entry, file, flags, mode, FUSE_CREATE);
>  	if (err == -ENOSYS) {
>  		fc->no_create = 1;
>  		goto mknod;
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 89e6176abe25..f49eb1b8f2f3 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -243,6 +243,7 @@
>   *
>   *  7.46
>   *  - add FUSE_LOOKUP_HANDLE
> + *  - add FUSE_MKOBJ_HANDLE
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -677,6 +678,7 @@ enum fuse_opcode {
>  	FUSE_COMPOUND		= 54,
>  
>  	FUSE_LOOKUP_HANDLE	= 55,
> +	FUSE_MKOBJ_HANDLE	= 56,
>  
>  	/* CUSE specific operations */
>  	CUSE_INIT		= 4096,
> 


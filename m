Return-Path: <linux-fsdevel+bounces-1472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C856D7DA52A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 07:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2D4282797
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 05:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7311367;
	Sat, 28 Oct 2023 05:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Vuvt25tD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33704387
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 05:18:03 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CF2F0
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 22:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y53ThGkT4CUElKLWNkVXNHgSM3aPpjpFXu/zAmil9IU=; b=Vuvt25tDsHARusFbCd7+wGXu9P
	FYa7baAwOkXf/b7g0t/cAW2pSjotQyZfGrJI1G4Lp8jbAbQCStuxx4Gyz95bsm/yzCpkYc5XcgfWg
	1X1Eo0Ot0GoJB4RiA6ZFTpDlLtgiiqRgAFkOEiJfgU2yqvnQzA7pOS1Hryg3ifJaWmBtg/GYfIsBP
	/gGG1kV2Qnj6ArrXDxp+7MNMNrap4KLs4cbhZUbd4w+ehDJY7onk3fN6zv8cheUEhbI39lARLlGf3
	eg/nZ2Py3y5jOI3xjAglbh7YVJaA2wHy+29xjik7O22Nr6fO2lu68vEQ/XXIUT4MHkpCf5+phsmVo
	GuvY5TCg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qwbhw-006tRa-0s;
	Sat, 28 Oct 2023 05:18:00 +0000
Date: Sat, 28 Oct 2023 06:18:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
	miklos@szeredi.hu, dsingh@ddn.com,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v10 5/8] fuse: Revalidate positive entries in
 fuse_atomic_open
Message-ID: <20231028051800.GT800259@ZenIV>
References: <20231023183035.11035-1-bschubert@ddn.com>
 <20231023183035.11035-6-bschubert@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023183035.11035-6-bschubert@ddn.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Oct 23, 2023 at 08:30:32PM +0200, Bernd Schubert wrote:
> +static struct dentry *
> +fuse_atomic_open_revalidate(struct fuse_conn *fc, struct dentry *entry,
> +			    struct inode *inode, int switched,
> +			    struct fuse_entry_out *outentry,
> +			    wait_queue_head_t *wq, int *alloc_inode)
> +{
> +	u64 attr_version;
> +	struct dentry *prev = entry;
> +
> +	if (outentry->nodeid != get_node_id(inode) ||
> +	    (bool) IS_AUTOMOUNT(inode) !=
> +	    (bool) (outentry->attr.flags & FUSE_ATTR_SUBMOUNT)) {
> +		*alloc_inode = 1;
> +	} else if (fuse_stale_inode(inode, outentry->generation,
> +				  &outentry->attr)) {
> +		fuse_make_bad(inode);
> +		*alloc_inode = 1;
> +	}
> +
> +	if (*alloc_inode) {
> +		struct dentry *new = NULL;
> +
> +		if (!switched && !d_in_lookup(entry)) {
> +			d_drop(entry);
> +			new = d_alloc_parallel(entry->d_parent, &entry->d_name,
> +					       wq);
> +			if (IS_ERR(new))
> +				return new;
> +
> +			if (unlikely(!d_in_lookup(new))) {
> +				dput(new);
> +				new = ERR_PTR(-EIO);
> +				return new;
> +			}
> +		}
> +
> +		fuse_invalidate_entry(entry);
> +
> +		entry = new;
> +	} else if (!*alloc_inode) {
> +		attr_version = fuse_get_attr_version(fc);
> +		forget_all_cached_acls(inode);
> +		fuse_change_attributes(inode, &outentry->attr, NULL,
> +				       ATTR_TIMEOUT(outentry),
> +				       attr_version);
> +	}
> +
> +	if (prev == entry) {
> +		/* nothing changed, atomic-open on the server side
> +		 * had increased the lookup count - do the same here
> +		 */
> +		struct fuse_inode *fi = get_fuse_inode(inode);
> +
> +		spin_lock(&fi->lock);
> +		fi->nlookup++;
> +		spin_unlock(&fi->lock);
> +	}
> +
> +	return entry;
> +}
> +
> +/**
> + * Does 'lookup + create + open' or 'lookup + open' atomically.
> + * @entry might be positive as well, therefore inode is re-validated.
> + * Positive dentry is invalidated in case inode attributes differ or
> + * we encountered error.
> + */
>  static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
>  			     struct file *file, unsigned int flags,
>  			     umode_t mode)
>  {
>  	int err;
> -	struct inode *inode;
> +	struct inode *inode = d_inode(entry);
>  	FUSE_ARGS(args);
>  	struct fuse_mount *fm = get_fuse_mount(dir);
>  	struct fuse_conn *fc = fm->fc;
> @@ -780,10 +865,7 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
>  	struct fuse_file *ff;
>  	struct dentry *switched_entry = NULL, *alias = NULL;
>  	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
> -
> -	/* Expect a negative dentry */
> -	if (unlikely(d_inode(entry)))
> -		goto fallback;
> +	int alloc_inode = 0;
>  
>  	/* Userspace expects S_IFREG in create mode */
>  	if ((flags & O_CREAT) && (mode & S_IFMT) != S_IFREG)
> @@ -835,36 +917,56 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
>  
>  	err = fuse_simple_request(fm, &args);
>  	free_ext_value(&args);
> -	if (err == -ENOSYS || err == -ELOOP) {
> -		if (unlikely(err == -ENOSYS))
> -			fc->no_open_atomic = 1;
> -		goto free_and_fallback;
> -	}
>  
>  	if (!err && !outentry.nodeid)
>  		err = -ENOENT;
>  
> -	if (err)
> -		goto out_free_ff;
> +	if (err) {
> +		if (unlikely(err == -ENOSYS)) {
> +			fc->no_open_atomic = 1;
> +
> +			/* Might come up if userspace tricks us and would
> +			 * return -ENOSYS for OPEN_ATOMIC after it was
> +			 * aready working
> +			 */
> +			if (unlikely(fc->has_open_atomic == 1))
> +				pr_info("fuse server/daemon bug, atomic open "
> +					"got -ENOSYS although it was already "
> +					"succeeding before.");
> +
> +			/* This should better never happen, revalidate
> +			 * is missing for this entry
> +			 */
> +			if (WARN_ON_ONCE(d_really_is_positive(entry))) {
> +				err = -EIO;
> +				goto out_free_ff;
> +			}
> +			goto free_and_fallback;
> +		} else if (err == -ELOOP) {
> +			/* likely a symlink */
> +			goto free_and_fallback;
> +		} else {
> +			if (d_really_is_positive(entry)) {
> +				if (err != -EINTR && err != -ENOMEM)
> +					fuse_invalidate_entry(entry);
> +			}
> +
> +			goto out_free_ff;
> +		}
> +	}
> +
> +	if (!err && !fc->has_open_atomic) {
> +		/* Only set this flag when atomic open did not return an error,
> +		 * so that we are absolutely sure it is implemented.
> +		 */
> +		fc->has_open_atomic = 1;
> +	}
>  
>  	err = -EIO;
>  	if (invalid_nodeid(outentry.nodeid) || fuse_invalid_attr(&outentry.attr))
>  		goto out_free_ff;
>  
> -	ff->fh = outopen.fh;
> -	ff->nodeid = outentry.nodeid;
> -	ff->open_flags = outopen.open_flags;
> -	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
> -			  &outentry.attr, ATTR_TIMEOUT(&outentry), 0);
> -	if (!inode) {
> -		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
> -		fuse_sync_release(NULL, ff, flags);
> -		fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
> -		err = -ENOMEM;
> -		goto out_err;
> -	}
> -
> -	/* prevent racing/parallel lookup on a negative hashed */
> +	/* prevent racing/parallel lookup */
>  	if (!(flags & O_CREAT) && !d_in_lookup(entry)) {
>  		d_drop(entry);
>  		switched_entry = d_alloc_parallel(entry->d_parent,
> @@ -879,10 +981,52 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
>  			/* fall back */
>  			dput(switched_entry);
>  			switched_entry = NULL;
> -			goto free_and_fallback;
> +
> +			if (!inode) {
> +				goto free_and_fallback;
> +			} else {
> +				/* XXX can this happen at all and is there a
> +				 * better way to handle it?
> +				 */

"this" being !d_in_lookup() on result of d_alloc_parallel()?  Sure,
that's what you get if there had been a lookup on the same thing
when you called d_alloc_parallel().  Or, for that matter, if that
lookup got completed just as you called the damn thing.

What are you trying to achieve here?


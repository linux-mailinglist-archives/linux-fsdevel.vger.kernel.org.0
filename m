Return-Path: <linux-fsdevel+bounces-76500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hGm2HrInhWkk9QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 00:28:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B13F856E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 00:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36E703003BE8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 23:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C7233D510;
	Thu,  5 Feb 2026 23:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGFH9p+0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ADC330B2C;
	Thu,  5 Feb 2026 23:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770334125; cv=none; b=A0dR8L/q8Ui7J2qRVcxPnXXI/B+VlA1UVrVf5QyplSmTjyDEYdXBl77FkqRJRiG5e4NMZec18x1uWI1mgNXRrGLdA5gCIYBC8C5kx0au6z7fAqtBCAddyanT3u67d5GViGC1+ufNjeeRAHz0x+ujE7MDGVQmn5SzHA1d5ayMefc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770334125; c=relaxed/simple;
	bh=ROXBPqXgG0oBCMOdWuur0GyXebCA8XnjwqKNyjj09Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaE4V5kiA1iMTdbo3jDo/sm407nSPjYcH+B81afTtMTsUrhszqkcvUodbZarF6qM6LAPnSQ9ydlSnHzS+lIV/JjeNllOQkBYsccD7gjF9oGXkVnA9+R+L5Ox2ec6H99NCj/eUHqPrWxH3enOOh8rjGCkRKkiOn8zGUxCeDxU9/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGFH9p+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C34C4CEF7;
	Thu,  5 Feb 2026 23:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770334124;
	bh=ROXBPqXgG0oBCMOdWuur0GyXebCA8XnjwqKNyjj09Bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cGFH9p+0MdM83HfF/FCYfZjqlEshnfXE1wNzLbluhWZ3EfJh60/mT6zi3iWwDaroJ
	 1qobL+6gaoAK6Uiu31IdZ4P7MTLISl1d6D5KxaGwqIoejQM/eM8ilaW5F5HW+6sYbU
	 qR3zEd3FLzcbIJ/sxZDTNKe36//NQTWZa/7NdBhWugOmYtxVMQwS3+WKnqbNv55aS5
	 Ysr6mjop5QecaqLcLudSlh9ttVphFYKvmCcmyOS0wuQXK6BRdVLYtw9qZ8//9o8ApE
	 RbwvqnVS3piUPBpH6x+rqKB895dhUvsJ6UsvQDyok/odhefI405sslWic6TxU4KQ2H
	 poQ7zOLrT5/XA==
Date: Thu, 5 Feb 2026 15:28:43 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chris Mason <clm@meta.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, bernd@bsbernd.com,
	neal@gompa.dev, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/5] fuse: propagate default and file acls on creation
Message-ID: <20260205232843.GC7686@frogsfrogsfrogs>
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
 <176169809360.1424347.15464466375351097387.stgit@frogsfrogsfrogs>
 <20260205193349.2227351-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205193349.2227351-1-clm@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76500-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,bsbernd.com,gompa.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 94B13F856E
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 11:32:58AM -0800, Chris Mason wrote:
> "Darrick J. Wong" <djwong@kernel.org> wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > For local filesystems, propagate the default and file access ACLs to new
> > children when creating them, just like the other in-kernel local
> > filesystems.
> > 
> 
> Hi everyone,
> 
> I'm trying out my AI review prompts on a few more trees, and I ran it
> on the fuse-iomap-cache branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache

Yessss some detailed review!  For the first time in my Linux career I'm
getting patch feedback before the patches are even posted!

So, thank you! :D

> This was the latest email lore could find, apologies if I grabbed the wrong one.
> 
> Hopefully the review below is useful, please let me know if there are places it
> has gone wildly wrong.  I kept the header to make it obvious exactly which
> commit I'd run through:
> 
> commit 72f7e38b8ab1d52b7e44818ba7db9335bc499476
> Author: Darrick J. Wong <djwong@kernel.org>
> 
> fuse: propagate default and file acls on creation
> 
> For local filesystems, propagate the default and file access ACLs to new
> children when creating them, just like the other in-kernel local
> filesystems.
> 
> > diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
> > index 72bb4c94079b7..f2cb7e8db4cad 100644
> > --- a/fs/fuse/acl.c
> > +++ b/fs/fuse/acl.c
> 
> [ ... ]
> 
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index b2dd3b189246e..3af81a063cc50 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -821,26 +821,28 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
> >  	struct fuse_entry_out outentry;
> >  	struct fuse_inode *fi;
> >  	struct fuse_file *ff;
> > +	struct posix_acl *default_acl = NULL, *acl = NULL;
> >  	int epoch, err;
> >  	bool trunc = flags & O_TRUNC;
> >
> >  	/* Userspace expects S_IFREG in create mode */
> >  	BUG_ON((mode & S_IFMT) != S_IFREG);
> >
> > +	err = fuse_acl_create(dir, &mode, &default_acl, &acl);
> > +	if (err)
> > +		return err;
> > +
> >  	epoch = atomic_read(&fm->fc->epoch);
> >  	forget = fuse_alloc_forget();
> >  	err = -ENOMEM;
> >  	if (!forget)
> > -		goto out_err;
> > +		goto out_acl_release;
> >
> >  	err = -ENOMEM;
> >  	ff = fuse_file_alloc(fm, true);
> >  	if (!ff)
> >  		goto out_put_forget_req;
> >
> > -	if (!fm->fc->dont_mask)
> > -		mode &= ~current_umask();
> > -
> >  	flags &= ~O_NOCTTY;
> >  	memset(&inarg, 0, sizeof(inarg));
> >  	memset(&outentry, 0, sizeof(outentry));
> > @@ -892,12 +894,16 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
> >  		fuse_sync_release(NULL, ff, flags);
> >  		fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
> >  		err = -ENOMEM;
> > -		goto out_err;
> > +		goto out_acl_release;
> >  	}
> >  	kfree(forget);
> >  	d_instantiate(entry, inode);
> >  	entry->d_time = epoch;
> >  	fuse_change_entry_timeout(entry, &outentry);
> > +
> > +	err = fuse_init_acls(inode, default_acl, acl);
> > +	if (err)
> > +		goto out_acl_release;
> >  	fuse_dir_changed(dir);
> >  	err = generic_file_open(inode, file);
> >  	if (!err) {
> > @@ -919,7 +925,9 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
> >  	fuse_file_free(ff);
> >  out_put_forget_req:
> >  	kfree(forget);
> > -out_err:
> > +out_acl_release:
> > +	posix_acl_release(default_acl);
> > +	posix_acl_release(acl);
> >  	return err;
> >  }
> 
> Does this leak the ACL pointers on the success path? When fuse_acl_create()
> allocates non-NULL ACLs (occurs when IS_POSIXACL(dir) &&
> fuse_inode_has_local_acls(dir) and the parent directory has default ACLs),
> and the file creation succeeds, the function returns directly at 'return
> err;' without releasing the ACLs via posix_acl_release().
> 
> The cleanup at out_acl_release is only reached on error paths. This would
> leak the posix_acl structures on every successful file creation when local
> ACLs are enabled.
> 
> Compare with create_new_entry() which correctly calls posix_acl_release()
> on both success and error paths (lines 1056-1057 and 1065-1066).

Oh, yeah, that is a pretty stupid memory leak, thanks for catching it.

> > @@ -979,14 +989,18 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
> >  	struct fuse_forget_link *forget;
> >  	int epoch, err;
> >
> > -	if (fuse_is_bad(dir))
> > -		return ERR_PTR(-EIO);
> > +	if (fuse_is_bad(dir)) {
> > +		err = -EIO;
> > +		goto out_acl_release;
> > +	}
> >
> >  	epoch = atomic_read(&fm->fc->epoch);
> >
> >  	forget = fuse_alloc_forget();
> > -	if (!forget)
> > -		return ERR_PTR(-ENOMEM);
> > +	if (!forget) {
> > +		err = -ENOMEM;
> > +		goto out_acl_release;
> > +	}
> >
> >  	memset(&outarg, 0, sizeof(outarg));
> >  	args->nodeid = get_node_id(dir);
> > @@ -1016,7 +1030,8 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
> >  			  &outarg.attr, ATTR_TIMEOUT(&outarg), 0, 0);
> >  	if (!inode) {
> >  		fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
> > -		return ERR_PTR(-ENOMEM);
> > +		err = -ENOMEM;
> > +		goto out_acl_release;
> >  	}
> >  	kfree(forget);
> >
> > @@ -1032,19 +1047,31 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
> >  		entry->d_time = epoch;
> >  		fuse_change_entry_timeout(entry, &outarg);
> >  	}
> > +
> > +	err = fuse_init_acls(inode, default_acl, acl);
> > +	if (err)
> > +		goto out_acl_release;
> >  	fuse_dir_changed(dir);
> > +
> > +	posix_acl_release(default_acl);
> > +	posix_acl_release(acl);
> >  	return d;
> >
> >  out_put_forget_req:
> >  	if (err == -EEXIST)
> >  		fuse_invalidate_entry(entry);
> >  	kfree(forget);
> > + out_acl_release:
> > +	posix_acl_release(default_acl);
> > +	posix_acl_release(acl);
> >  	return ERR_PTR(err);
> >  }
> 
> Chen Linxuan raised a concern in v5 about pairing fuse_acl_create and
> posix_acl_release together. While the author's response explained the
> design choice to have create_new_entry consume the ACL arguments, there is
> a memory leak when d_splice_alias returns an error:
> 
> >  		d = d_splice_alias(inode, entry);
> >  		if (IS_ERR(d))
> >  			return d;
> 
> The function returns ERR_PTR without releasing the ACL pointers. The
> normal path (lines 1056-1057) and error path (lines 1065-1066) both
> release ACLs, but the IS_ERR(d) path at line 1041 does not.
> 
> https://lore.kernel.org/all/CAC1kPDOv4sy3NPexFtdoROFi18b98W+PbP+9t8y4Jd5fQqCxCg@mail.gmail.com/

Whoops.  Also a good catch; I'll change that to:

	d = d_splice_alias(inode, entry);
	if (IS_ERR(d)) {
		err = PTR_ERR(d);
		goto out_acl_release;
	}

--D

> [ ... ]
> 
> 


Return-Path: <linux-fsdevel+bounces-1470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4617DA4FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 05:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F5D28284F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 03:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4E6A5C;
	Sat, 28 Oct 2023 03:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CPFWTTmw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C871396
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 03:03:28 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B1919B2
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 20:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=awm+nPqyPW0TP6sRIUE6KcF8gq47l2asTjCPcT+FWOU=; b=CPFWTTmwRm8HJeQIx9hnqVWsO3
	01BSANvGUtwmyCYROJD8POKreiSvI9vVGmAfdfdkLEPYBAU/4HDWi9W05f5LNQkVL1RTByiMmtjxV
	P5ifu0MQ4ox4bprN1ZMgNbDTymAXRSMoNe9cq4JaW6Dg9pJuL/07KNxoABicWRvWYcS4xuJi67hhr
	0j1dryyXDSmFk2xgnUqmNhwxFYgD1ZiTV/GfV/ZRdXtr85ML9zVa0sPlCUWUHSHmbMbulifOyIB8l
	8GQqU9hLCC3tMsJpFCH3GGAQg3aFSIZiIKoEtq/u6WCZ5KcGLg2fOiCUW2P2cLufejwLthGcilx/w
	qZwSVREQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qwZbS-006r1W-1T;
	Sat, 28 Oct 2023 03:03:10 +0000
Date: Sat, 28 Oct 2023 04:03:10 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
	miklos@szeredi.hu, dsingh@ddn.com,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v10 2/8] fuse: introduce atomic open
Message-ID: <20231028030310.GR800259@ZenIV>
References: <20231023183035.11035-1-bschubert@ddn.com>
 <20231023183035.11035-3-bschubert@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023183035.11035-3-bschubert@ddn.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Oct 23, 2023 at 08:30:29PM +0200, Bernd Schubert wrote:
> +{
> +	int err;
> +	struct inode *inode;
> +	FUSE_ARGS(args);
> +	struct fuse_mount *fm = get_fuse_mount(dir);
> +	struct fuse_conn *fc = fm->fc;
> +	struct fuse_forget_link *forget;
> +	struct fuse_create_in inarg;
> +	struct fuse_open_out outopen;
> +	struct fuse_entry_out outentry;
> +	struct fuse_inode *fi;
> +	struct fuse_file *ff;
> +	struct dentry *switched_entry = NULL, *alias = NULL;
> +	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
> +
> +	/* Expect a negative dentry */
> +	if (unlikely(d_inode(entry)))
> +		goto fallback;
> +
> +	/* Userspace expects S_IFREG in create mode */
> +	if ((flags & O_CREAT) && (mode & S_IFMT) != S_IFREG)
> +		goto fallback;

How could it get there with such mode?  We could check that
in fs/namei.c:atomic_open() (with
	if (WARN_ON_ONCE((open_flags & O_CREAT) && !S_ISREG(mode)))
		error = -EINVAL; // for the lack of EWTFAREYOUSMOKING
	else
		error = dir->i_op->atomic_open(....)
or something similar), but that doesn't belong in the method instances.
And it really should never happen - that thing comes from op->mode and
we have build_open_flags() doing this:
        if (WILL_CREATE(flags)) {
                if (how->mode & ~S_IALLUGO)
                        return -EINVAL;
                op->mode = how->mode | S_IFREG;
        } else {
                if (how->mode != 0)
                        return -EINVAL;
                op->mode = 0;
        }
so...  Are other instances doing the same kind of paranoia?  That BUG_ON()
in current fuse_atomic_open() is bogus (and seriously misplaced)...

> +	forget = fuse_alloc_forget();
> +	err = -ENOMEM;
> +	if (!forget)
> +		goto out_err;
> +
> +	err = -ENOMEM;
> +	ff = fuse_file_alloc(fm);
> +	if (!ff)
> +		goto out_put_forget_req;
> +
> +	if (!fc->dont_mask)
> +		mode &= ~current_umask();
> +
> +	flags &= ~O_NOCTTY;
> +	memset(&inarg, 0, sizeof(inarg));
> +	memset(&outentry, 0, sizeof(outentry));
> +	inarg.flags = flags;
> +	inarg.mode = mode;
> +	inarg.umask = current_umask();
> +
> +	if (fc->handle_killpriv_v2 && (flags & O_TRUNC) &&
> +	    !(flags & O_EXCL) && !capable(CAP_FSETID)) {
> +		inarg.open_flags |= FUSE_OPEN_KILL_SUIDGID;
> +	}
> +
> +	args.opcode = FUSE_OPEN_ATOMIC;
> +	args.nodeid = get_node_id(dir);
> +	args.in_numargs = 2;
> +	args.in_args[0].size = sizeof(inarg);
> +	args.in_args[0].value = &inarg;
> +	args.in_args[1].size = entry->d_name.len + 1;
> +	args.in_args[1].value = entry->d_name.name;
> +	args.out_numargs = 2;
> +	args.out_args[0].size = sizeof(outentry);
> +	args.out_args[0].value = &outentry;
> +	args.out_args[1].size = sizeof(outopen);
> +	args.out_args[1].value = &outopen;
> +
> +	if (flags & O_CREAT) {
> +		err = get_create_ext(&args, dir, entry, mode);
> +		if (err)
> +			goto out_free_ff;
> +	}
> +
> +	err = fuse_simple_request(fm, &args);
> +	free_ext_value(&args);
> +	if (err == -ENOSYS || err == -ELOOP) {
> +		if (unlikely(err == -ENOSYS))
> +			fc->no_open_atomic = 1;
> +		goto free_and_fallback;
> +	}
> +
> +	if (!err && !outentry.nodeid)
> +		err = -ENOENT;
> +
> +	if (err)
> +		goto out_free_ff;
> +
> +	err = -EIO;
> +	if (invalid_nodeid(outentry.nodeid) || fuse_invalid_attr(&outentry.attr))
> +		goto out_free_ff;
> +
> +	ff->fh = outopen.fh;
> +	ff->nodeid = outentry.nodeid;
> +	ff->open_flags = outopen.open_flags;
> +	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
> +			  &outentry.attr, ATTR_TIMEOUT(&outentry), 0);
> +	if (!inode) {
> +		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
> +		fuse_sync_release(NULL, ff, flags);
> +		fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
> +		err = -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	/* prevent racing/parallel lookup on a negative hashed */
> +	if (!(flags & O_CREAT) && !d_in_lookup(entry)) {

... in which case it has just passed ->d_revalidate()...

> +		d_drop(entry);
> +		switched_entry = d_alloc_parallel(entry->d_parent,
> +						   &entry->d_name, &wq);
> +		if (IS_ERR(switched_entry)) {
> +			err = PTR_ERR(switched_entry);
> +			switched_entry = NULL;
> +			goto out_free_ff;

leaked inode?

> +		}
> +
> +		if (unlikely(!d_in_lookup(switched_entry))) {
> +			/* fall back */
> +			dput(switched_entry);
> +			switched_entry = NULL;
> +			goto free_and_fallback;

ditto, and I don't really understand what the hell is going on with
dentry references here.  What is the intended behaviour in that case?

> +		}
> +
> +		entry = switched_entry;
> +	}
> +
> +	if (d_really_is_negative(entry)) {
> +		d_drop(entry);
> +		alias = d_exact_alias(entry, inode);

What case is that about?  "We have an unhashed positive dentry with that
exact name, parent and inode"?  Where would it have come from?

Another thing: this does not consume an inode reference, no matter what
gets returned,

> +		if (!alias) {
> +			alias = d_splice_alias(inode, entry);

but that one *does* consume the inode reference; note the igrab() in
nfs4 code where you've nicked that from...

> +			if (IS_ERR(alias)) {
> +				/*
> +				 * Close the file in user space, but do not unlink it,
> +				 * if it was created - with network file systems other
> +				 * clients might have already accessed it.
> +				 */
> +				fi = get_fuse_inode(inode);

... so this is asking for UAF.

> +				fuse_sync_release(fi, ff, flags);
> +				fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
> +				err = PTR_ERR(alias);
> +				goto out_err;
> +			}
> +		}
> +
> +		if (alias)
> +			entry = alias;
> +	}

... and here we have no way to tell if inode needs to be dropped.

> +
> +	fuse_change_entry_timeout(entry, &outentry);
> +
> +	/*  File was indeed created */
> +	if (outopen.open_flags & FOPEN_FILE_CREATED) {
> +		if (!(flags & O_CREAT)) {
> +			pr_debug("Server side bug, FOPEN_FILE_CREATED set "
> +				 "without O_CREAT, ignoring.");
> +		} else {
> +			/* This should be always set when the file is created */
> +			fuse_dir_changed(dir);
> +			file->f_mode |= FMODE_CREATED;
> +		}
> +	}
> +
> +	if (S_ISDIR(mode))
> +		ff->open_flags &= ~FOPEN_DIRECT_IO;
> +	err = finish_open(file, entry, generic_file_open);
> +	if (err) {
> +		fi = get_fuse_inode(inode);
> +		fuse_sync_release(fi, ff, flags);
> +	} else {
> +		file->private_data = ff;
> +		fuse_finish_open(inode, file);
> +	}
> +
> +	kfree(forget);
> +
> +	if (switched_entry) {
> +		d_lookup_done(switched_entry);
> +		dput(switched_entry);
> +	}
> +
> +	dput(alias);
> +
> +	return err;
> +
> +out_free_ff:
> +	fuse_file_free(ff);
> +out_put_forget_req:
> +	kfree(forget);
> +out_err:
> +	if (switched_entry) {
> +		d_lookup_done(switched_entry);
> +		dput(switched_entry);
> +	}
> +
> +	return err;
> +
> +free_and_fallback:
> +	fuse_file_free(ff);
> +	kfree(forget);
> +fallback:
> +	return fuse_create_open(dir, entry, file, flags, mode);
> +}


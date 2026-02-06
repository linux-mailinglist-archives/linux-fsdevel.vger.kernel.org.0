Return-Path: <linux-fsdevel+bounces-76511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHx1LFZNhWmq/gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 03:09:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C60AF9233
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 03:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00822301690E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 02:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAA523EAB8;
	Fri,  6 Feb 2026 02:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/vYETuN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9BF238D54;
	Fri,  6 Feb 2026 02:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770343713; cv=none; b=Tgja0UJtGaymGgnKC5iT0h9CYn37K7/FSHP0YKSWU7/a8ZoubIz8+2G04HyF7wm52GTbpmNG40HioNpdhIH5kVYXSWdRNYQ4QmJjXAwLskbOA+hmlz/crblp/SOFSnQIOrZY+qDfgXzl5eim2TWv+TWAed81T/OkDgTU9YRFqL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770343713; c=relaxed/simple;
	bh=xj1LGByNVWkJ/5rQxFEzQKPA6jnMXZH4SMWnFJJVjE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4kTvd5yc60lNQnDfuuT8I797iSMkkJato+dsmw/jYrtiNUpBn93GSifC4ptMzITgoX8wrOep+MofmBR4JfYpBCVWmdqHsCe8od0nsec5XJmq0FCAZkWUugu0mykcDoSbJ5OTBUHKrnDZ2mhEZEJYZ2Op2sgiZv5ZwTjA4t0uFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/vYETuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FDAC4CEF7;
	Fri,  6 Feb 2026 02:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770343713;
	bh=xj1LGByNVWkJ/5rQxFEzQKPA6jnMXZH4SMWnFJJVjE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/vYETuN7B2bTM2pWDHbYey7q59ZTrFK4zZlo6vIHsEScka8iy+b5i8abXVyX+ekb
	 0SaiffTFHaLpD3AqQoyA/ZLIEvTQ6Z3VXxLXKzw3rScW2QiOzpNgpXHrmIgG1tlI33
	 dx33yrA+z7+ho08p4VJvnuY0OfpfdG/zQtjPgTj48/tWfDH9VvMHTAuVsG6FGJDDLC
	 yYflqozPvuydTV6r0n+sO3dVZG2W/nsb1Qr+4SkdMhloVeX8Et26yYEY8M4JmEAICw
	 89lnvbdcIkhjZdoBv9QJQY/3fI7lksaqL1QJRFc0jD6AdkyZ/7nmkc4yovrrqaImeV
	 r/4TMnIr2zRRw==
Date: Thu, 5 Feb 2026 18:08:32 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chris Mason <clm@meta.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, bernd@bsbernd.com,
	neal@gompa.dev, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/31] fuse: implement direct IO with iomap
Message-ID: <20260206020832.GE7686@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810612.1424854.16053093294573829123.stgit@frogsfrogsfrogs>
 <20260205192011.2087250-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205192011.2087250-1-clm@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,bsbernd.com,gompa.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-76511-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C60AF9233
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 11:19:11AM -0800, Chris Mason wrote:
> "Darrick J. Wong" <djwong@kernel.org> wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Start implementing the fuse-iomap file I/O paths by adding direct I/O
> > support and all the signalling flags that come with it.  Buffered I/O
> > is much more complicated, so we leave that to a subsequent patch.
> > 
> 
> Hi everyone,
> 
> I'm trying out my AI review prompts on a few more trees, and I ran it
> on the fuse-iomap-cache branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache

I should mention: I appreciate you rolling out the AI reviews by slowly
expanding the number of trees you scan for bugs.

> This was the latest email lore could find, apologies if I grabbed the wrong one.
> 
> Hopefully the review below is useful, please let me know if there are places it
> has gone wildly wrong.  I kept the header to make it obvious exactly which
> commit I'd run through:
> 
> commit fab88aeb077db04c5f4fdbaff31a58f4dd9450c8
> Author: Darrick J. Wong <djwong@kernel.org>
> 
> fuse: implement direct IO with iomap
> 
> Start implementing the fuse-iomap file I/O paths by adding direct I/O
> support and all the signalling flags that come with it. Buffered I/O is
> much more complicated, so we leave that to a subsequent patch.
> 
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index bec299865d8fe..07be70d314eff 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> 
> [ ... ]
> 
> > @@ -408,7 +416,7 @@ void fuse_sync_release(struct fuse_inode *fi, struct fuse_file *ff,
> >  {
> >  	WARN_ON(refcount_read(&ff->count) > 1);
> >  	fuse_prepare_release(fi, ff, flags, FUSE_RELEASE, true);
> > -	fuse_file_put(ff, true);
> > +	fuse_file_put(ff, &fi->inode, true);
> >  }
> >  EXPORT_SYMBOL_GPL(fuse_sync_release);
> 
> Can this code dereference a NULL pointer when fi is NULL?

Yikes, yes it can...

> Looking at fuse_create_open in dir.c, when fuse_iget() fails, it calls:
> 
>     fuse_sync_release(NULL, ff, flags);
> 
> The fuse_prepare_release function explicitly handles fi == NULL with
> the comment "Inode is NULL on error path of fuse_create_open()".
> 
> However, the new call to fuse_file_put passes &fi->inode, which
> evaluates to &NULL->inode. While the inode parameter is unused in the
> current commit's implementation of fuse_file_put, the API contract is
> broken.

...so this is a very good catch!  Though as it turns out we don't need
this change to fuse_file_put until we actually add fuse_iomap_release()
several patchsets from now, so I think I'll revert this part of the
patch.

> In commit 5f4e9030b26b (fuse: enable iomap), fuse_file_put uses the
> inode parameter to call fuse_inode_has_iomap(inode). Since struct inode
> is the first member of struct fuse_inode (offsetof == 0), &fi->inode
> evaluates to NULL, and fuse_inode_has_iomap(NULL) will dereference NULL.
> 
> > diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> > index bc55e87751215..9796e3b994565 100644
> > --- a/fs/fuse/fuse_iomap.c
> > +++ b/fs/fuse/fuse_iomap.c
> 
> [ ... ]
> 
> > @@ -545,6 +551,120 @@ static const struct iomap_ops fuse_iomap_ops = {
> >  	.iomap_end		= fuse_iomap_end,
> >  };
> >
> > +static inline bool
> > +fuse_should_send_iomap_ioend(const struct fuse_mount *fm,
> > +			     const struct fuse_iomap_ioend_in *inarg)
> > +{
> > +	/* Not implemented on fuse server */
> > +	if (fm->fc->iomap_conn.no_ioend)
> > +		return false;
> > +
> > +	/* Always send an ioend for errors. */
> > +	if (inarg->error)
> > +		return true;
> > +
> > +	/* Send an ioend if we performed an IO involving metadata changes. */
> > +	return inarg->written > 0 &&
> > +	       (inarg->flags & (FUSE_IOMAP_IOEND_SHARED |
> > +				FUSE_IOMAP_IOEND_UNWRITTEN |
> > +				FUSE_IOMAP_IOEND_APPEND));
> > +}
> 
> [ ... ]
> 
> > +static int fuse_iomap_ioend(struct inode *inode, loff_t pos, size_t written,
> > +			    int error, unsigned ioendflags,
> > +			    struct block_device *bdev, sector_t new_addr)
> > +{
> > +	struct fuse_inode *fi = get_fuse_inode(inode);
> > +	struct fuse_mount *fm = get_fuse_mount(inode);
> > +	struct fuse_iomap_ioend_in inarg = {
> > +		.flags = ioendflags,
> > +		.error = error,
> > +		.attr_ino = fi->orig_ino,
> > +		.pos = pos,
> > +		.written = written,
> > +		.dev = fuse_iomap_find_backing_id(fm->fc, bdev),
> > +		.new_addr = new_addr,
> > +	};
> > +	struct fuse_iomap_ioend_out outarg = { };
> > +
> > +	if (fuse_ioend_is_append(fi, pos, written))
> > +		inarg.flags |= FUSE_IOMAP_IOEND_APPEND;
> > +
> > +	if (fuse_should_send_iomap_ioend(fm, &inarg)) {
> > +		FUSE_ARGS(args);
> > +		int iomap_error;
> > +
> > +		args.opcode = FUSE_IOMAP_IOEND;
> > +		args.nodeid = get_node_id(inode);
> > +		args.in_numargs = 1;
> > +		args.in_args[0].size = sizeof(inarg);
> > +		args.in_args[0].value = &inarg;
> > +		args.out_numargs = 1;
> > +		args.out_args[0].size = sizeof(outarg);
> > +		args.out_args[0].value = &outarg;
> > +		iomap_error = fuse_simple_request(fm, &args);
> > +		switch (iomap_error) {
> > +		case -ENOSYS:
> > +			/*
> > +			 * fuse servers can return ENOSYS if ioend processing
> > +			 * is never needed for this filesystem.  Don't pass
> > +			 * that up to iomap.
> > +			 */
> > +			fm->fc->iomap_conn.no_ioend = 1;
> > +			break;
> > +		case 0:
> > +			break;
> > +		default:
> > +			/*
> > +			 * If the write IO failed, return the failure code to
> > +			 * the caller no matter what happens with the ioend.
> > +			 * If the write IO succeeded but the ioend did not,
> > +			 * pass the new error up to the caller.
> > +			 */
> > +			if (!error)
> > +				error = iomap_error;
> > +			break;
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * Pass whatever error iomap gave us (or any new errors since then)
> > +	 * back to iomap.
> > +	 */
> > +	if (error)
> > +		return error;
> > +
> > +	/*
> > +	 * If there weren't any ioend errors, update the incore isize, which
> > +	 * confusingly takes the new i_size as "pos".
> > +	 */
> > +	fi->i_disk_size = outarg.newsize;
> > +	fuse_write_update_attr(inode, pos + written, written);
> > +	return 0;
> > +}
> 
> When the fuse server returns -ENOSYS (indicating it doesn't implement
> FUSE_IOMAP_IOEND), the code sets fm->fc->iomap_conn.no_ioend = 1 but
> does NOT return early. It falls through to the update code where
> 'outarg' was zero-initialized and never filled by the server.
> 
> This corrupts i_disk_size by setting it to 0:
> 
>     fi->i_disk_size = outarg.newsize;  // outarg.newsize == 0
> 
> On subsequent writes, fuse_should_send_iomap_ioend() returns false due
> to no_ioend being set, so the code skips the server call and again uses
> the zero-initialized outarg.newsize.

Yeah.  outarg should be initialized with fi->i_disk_size, though I think
this bug is benign because no_ioend being set to 1 in that ENOSYS case
means that this function doesn't do much of anything after that.

> The i_disk_size field is used by fuse_ioend_is_append() to detect
> append writes, so corrupting it to 0 will cause incorrect append
> detection for all subsequent writes.
> 
> Should the code return early when the request is not sent or returns
> -ENOSYS, or skip the i_disk_size update in this case?
> 
> > +static int fuse_iomap_ilock_iocb(const struct kiocb *iocb,
> > +				 enum fuse_ilock_type type)
> > +{
> > +	struct inode *inode = file_inode(iocb->ki_filp);
> > +
> > +	if (iocb->ki_flags & IOCB_NOWAIT) {
> > +		switch (type) {
> > +		case SHARED:
> > +			return inode_trylock_shared(inode) ? 0 : -EAGAIN;
> > +		case EXCL:
> > +			return inode_trylock(inode) ? 0 : -EAGAIN;
> > +		default:
> > +			ASSERT(0);
> > +			return -EIO;
> > +		}
> > +
> > +		return 0;
> > +	}
> 
> This isn't a bug, but the 'return 0;' after the switch statement inside
> the IOCB_NOWAIT block is unreachable since every switch case returns.

gcc is too stupid to detect that it's impossible to reach this case and
whines about the lack of a return.

--D


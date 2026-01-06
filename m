Return-Path: <linux-fsdevel+bounces-72532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B77CF9E1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 18:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A5B1317FAB7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 17:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6023C2FFDE2;
	Tue,  6 Jan 2026 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwjQKP0w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95312FF169;
	Tue,  6 Jan 2026 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720913; cv=none; b=fSVYitgqD7TlsEDZ2BMftXDozzhe69Emnzw3zAtVf8m7N4TcRbKHQ/LjjGKGpS841biV0FFO9esFRxlDX3b44JzvjM9GnpjEdygrtl7Hlntctu53cy7++DSese8XCvPJ9xPUwBdo0B9ekIQB37Wjpccndbg2YRou1pTpDzPWVCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720913; c=relaxed/simple;
	bh=dW7umfsK1VacKIp4oUBWq7npbj36ith8MtnWEdP0dz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHiAObAvOJ39GYYRJuBo3c+QuCjEXgriXkxf0smQZwUZWQ8PT4Kc/uruTPK7RYb59EhSIHDj2WNSlgZIVkJRayAY97m9PGCGjZm9//TyzhuQAS6dy8ObH+CJNYk6XwIz6fOL3uzBaWzSTUiSbzrosf42LSR/A7hvl/CGK2lPlV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwjQKP0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D796C16AAE;
	Tue,  6 Jan 2026 17:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767720913;
	bh=dW7umfsK1VacKIp4oUBWq7npbj36ith8MtnWEdP0dz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UwjQKP0wi0NCe8UvgeBnhmboEr1ZVKCBj9yoKOwNRRNobWZa26Utn/Kwz5fUK74LB
	 jBnrdmzxZ61pgjiDoZVAOVFdnANX/ojPrpM8aCLnEtB/ezUT/TU+3JtBhT6h+XeD0h
	 EwB5un8tvMQm4nMjZtXXABxtbQ7GQLlBCGhFAl60cWXj2QbLqGQY9ugIBspdBZsM+j
	 fLi0r11KYqGwIRr6fs0P9GcP7RbsN26h18XgFlyJDjREHjyAMn2lZS7AFhYT1vtK5R
	 cRzPjQehRPbvfjq9PYYel5iboMhXedVqMKGmjaYOMyCrGSo9Nb5qmeddtlA//D9/j3
	 Q0M/AMaxGDf1A==
Date: Tue, 6 Jan 2026 09:35:13 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, hch@lst.de, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gabriel@krisman.be, amir73il@gmail.com
Subject: Re: [PATCH 2/6] fs: report filesystem and file I/O errors to fsnotify
Message-ID: <20260106173513.GD191481@frogsfrogsfrogs>
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
 <176602332171.686273.14690243193639006055.stgit@frogsfrogsfrogs>
 <cunesvp5k37ocmz2nbkdov7ssu3djqvdii26d4gn6sj7sgtnca@b5mokxhvneay>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cunesvp5k37ocmz2nbkdov7ssu3djqvdii26d4gn6sj7sgtnca@b5mokxhvneay>

On Mon, Dec 22, 2025 at 04:36:14PM +0100, Jan Kara wrote:
> On Wed 17-12-25 18:03:11, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Create some wrapper code around struct super_block so that filesystems
> > have a standard way to queue filesystem metadata and file I/O error
> > reports to have them sent to fsnotify.
> > 
> > If a filesystem wants to provide an error number, it must supply only
> > negative error numbers.  These are stored internally as negative
> > numbers, but they are converted to positive error numbers before being
> > passed to fanotify, per the fanotify(7) manpage.  Implementations of
> > super_operations::report_error are passed the raw internal event data.
> > 
> > Note that we have to play some shenanigans with mempools and queue_work
> > so that the error handling doesn't happen outside of process context,
> > and the event handler functions (both ->report_error and fsnotify) can
> > handle file I/O error messages without having to worry about whatever
> > locks might be held.  This asynchronicity requires that unmount wait for
> > pending events to clear.
> > 
> > Add a new callback to the superblock operations structure so that
> > filesystem drivers can themselves respond to file I/O errors if they so
> > desire.  This will be used for an upcoming self-healing patchset for
> > XFS.
> > 
> > Suggested-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> Looks good to me. Besides the nits Christoph commented on just two comments:
> 
> > +static inline struct fserror_event *fserror_alloc_event(struct super_block *sb,
> > +							gfp_t gfp_flags)
> > +{
> > +	struct fserror_event *event = NULL;
> > +
> > +	/*
> > +	 * If pending_errors already reached zero or is no longer active,
> > +	 * the superblock is being deactivated so there's no point in
> > +	 * continuing.
> > +	 */
> > +	if (!refcount_inc_not_zero(&sb->s_pending_errors))
> > +		return NULL;
> 
> It would be good here or in the above comment explicitely mention that the
> ordering of s_pending_errors check and SB_ACTIVE check is mandated by the
> ordering in generic_shutdown_super() and that the barriers are implicitely
> provided by the refcount manipulations here and in fserror_unmount().

Ok.  I'll send a follow-on patch, though I don't see vfs-7.0.fserror on
vfs.git so I'm confused about where things are right now.

> > +	if (!(sb->s_flags & SB_ACTIVE))
> > +		goto out_pending;
> > +
> > +	event = mempool_alloc(&fserror_events_pool, gfp_flags);
> > +	if (!event)
> > +		goto out_pending;
> > +
> > +	/* mempool_alloc doesn't support GFP_ZERO */
> > +	memset(event, 0, sizeof(*event));
> > +	event->sb = sb;
> > +	INIT_WORK(&event->work, fserror_worker);
> > +
> > +	return event;
> > +
> > +out_pending:
> > +	fserror_pending_dec(sb);
> > +	return NULL;
> > +}
> > +
> > +/**
> > + * fserror_report - report a filesystem error of some kind
> > + *
> > + * Report details of a filesystem error to the super_operations::report_error
> > + * callback if present; and to fsnotify for distribution to userspace.  @sb,
> > + * @gfp, @type, and @error must all be specified.  For file I/O errors, the
> > + * @inode, @pos, and @len fields must also be specified.  For file metadata
> > + * errors, @inode must be specified.  If @inode is not NULL, then @inode->i_sb
> > + * must point to @sb.
> > + *
> > + * Reporting work is deferred to a workqueue to ensure that ->report_error is
> > + * called from process context without any locks held.  An active reference to
> > + * the inode is maintained until event handling is complete, and unmount will
> > + * wait for queued events to drain.
> > + *
> > + * @sb:		superblock of the filesystem
> > + * @inode:	inode within that filesystem, if applicable
> > + * @type:	type of error encountered
> > + * @pos:	start of inode range affected, if applicable
> > + * @len:	length of inode range affected, if applicable
> > + * @error:	error number encountered, must be negative
> > + * @gfp:	memory allocation flags for conveying the event to a worker,
> > + *		since this function can be called from atomic contexts
> > + */
> > +void fserror_report(struct super_block *sb, struct inode *inode,
> > +		    enum fserror_type type, loff_t pos, u64 len, int error,
> > +		    gfp_t gfp)
> > +{
> > +	struct fserror_event *event;
> > +
> > +	/* sb and inode must be from the same filesystem */
> > +	WARN_ON_ONCE(inode && inode->i_sb != sb);
> > +
> > +	/* error number must be negative */
> > +	WARN_ON_ONCE(error >= 0);
> 
> Since the error reporting is kind of expensive now (allocation & queueing
> work) it would be nice to check somebody actually cares about the error
> events at all. We can provide a helper from fsnotify for that, I'm not sure
> about ->report_error hook since it didn't get used in this series at all in
> the end...

I didn't quite get to posting that patchset before vacation, but it's
posted now in "xfs: convey file I/O errors to the health monitor":

https://lore.kernel.org/linux-fsdevel/176766637421.774337.94510884010750487.stgit@frogsfrogsfrogs/T/#Z2e.:..:176766637421.774337.94510884010750487.stgit::40frogsfrogsfrogs:1fs:xfs:xfs_super.c

--D
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 


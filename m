Return-Path: <linux-fsdevel+bounces-71684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBFFCCD376
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 19:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2CE83015E2F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 18:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23193090EB;
	Thu, 18 Dec 2025 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="He0Y5l/t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102BB2FFDE4;
	Thu, 18 Dec 2025 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766083470; cv=none; b=Rf0ePP2UMR+XTQ21ci2mS7JUqtS9C0qU12m9Ehj5MpbvZcKATp4aUMQFelzJiVrtaNFEz2r5uyIuyPhybMDJOxbW5sr1KVyUrrBF2eylX/yzKrSBIOOhaoCCQOl8mQ1D9DL0BlvTDLVeveZcdhXtz+2MrYejHMVLB/dKd/42cJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766083470; c=relaxed/simple;
	bh=JzKypX1p1kuMtIsMz+Vfwf5mXNthFZpyVSu3eHGQbWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fE7cA2AajSZaJ5xz/40K5fi/BuRiZupBtsiDXLSL8yTA0ZhZb5XLzAxQknzXuoAWDG3CrRUk1+ayA/WflPthNylpyOQoZNsl2C8SXSp+DV+5usfcZS3qDvMwaYtyTQZDR+rDiAG5zozeS+ETAOWwNkjV/dDZeg42Sl78qtNfg6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=He0Y5l/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA17C4CEFB;
	Thu, 18 Dec 2025 18:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766083469;
	bh=JzKypX1p1kuMtIsMz+Vfwf5mXNthFZpyVSu3eHGQbWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=He0Y5l/tWAiEFFRnAceQSIlONvqXcTAPmJCulG7gXITCvP7T4egN9Ipw+oc7RzFKo
	 S595MEgGyyM9PkM7fZAUybEnFBrrbjfjy4QxBWYe2lljf4yGW5VAqpgYJrCqi9fiI2
	 Z7Anfrgr+lIrQUWStEhtd49bj+M04HpF3Z6YRAcfeclKWRExJkBe/DyPQYxjPdnROi
	 4k8hSnmh2jQFbOEb54mz7LloiSsJFZ8UXFdDyy3H+YndaW6ljIxefbES8AfrrX5ud5
	 M2wBw7IErOtAG4392kdHgjMX/sTxY7LiGAu4XAq8womtGNjdALko7m0VE40Ah6sJeJ
	 wxGCJgDWcoG5Q==
Date: Thu, 18 Dec 2025 10:44:29 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, linux-ext4@vger.kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gabriel@krisman.be, amir73il@gmail.com
Subject: Re: [PATCH 2/6] fs: report filesystem and file I/O errors to fsnotify
Message-ID: <20251218184429.GX7725@frogsfrogsfrogs>
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
 <176602332171.686273.14690243193639006055.stgit@frogsfrogsfrogs>
 <aUOPcNNR1oAxa1hC@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUOPcNNR1oAxa1hC@infradead.org>

On Wed, Dec 17, 2025 at 09:21:52PM -0800, Christoph Hellwig wrote:
> >  	long					s_min_writeback_pages;
> > +
> > +	/* number of fserrors that are being sent to fsnotify/filesystems */
> > +	refcount_t		s_pending_errors;
> 
> Use the same tab-alignment as the fields above?  Also is this really

Will fix.

> a refcount?  It's a counter, but not really a reference?  I guess
> that doesn't matter too much.

<shrug> It does count pending events, but you could also look upon it as
a count of weak "references" to the super_block since the fserror_event
object does point to the super_block.

(Not sure what happens if we get more than 2^31 errors...)

> > +static inline void fserror_unmount(struct super_block *sb)
> > +{
> > +	/*
> > +	 * If we don't drop the pending error count to zero, then wait for it
> > +	 * to drop below 1, which means that the pending errors cleared or
> > +	 * that we saturated the system with 1 billion+ concurrent events.
> > +	 */
> > +	if (!refcount_dec_and_test(&sb->s_pending_errors))
> > +		wait_var_event(&sb->s_pending_errors,
> > +			       refcount_read(&sb->s_pending_errors) < 1);
> > +}
> 
> Should this be out of line?

Yes, it's better to hide these details (particularly since there's a fat
comment about the refcount bias) in fserror.c.

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
> 
> The normal convention is to have the arguments documented above the
> long description.  Any reason to deviate from that here?

Nope.  Fixed.

--D


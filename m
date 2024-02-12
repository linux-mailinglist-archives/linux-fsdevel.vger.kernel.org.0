Return-Path: <linux-fsdevel+bounces-11123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA5A8515A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 14:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C2F2849DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 13:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947B34653A;
	Mon, 12 Feb 2024 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bETrA4AA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E3646542
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745182; cv=none; b=VRMaeD3b2CUHMsd5ViErhYhiwyI1gbuBQpr6vo8UgFcUpBK2LtSoi7cgkqH9T0ww0G5MJhqpP4a4hbkkKnbL4pr7P7Z+FFUbkArtMr6Y1VMhmYkB0AXN/0nUEKThvCdUtNz4weovLYxHPGD54d7ajP7cBu+9xDnZ35KHIa8j9zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745182; c=relaxed/simple;
	bh=y4MykJUXdhoEb+0BGWt8fQgpbiWGjqQkC2tgBVcDciU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BanuI/VMryBmroOQ5fN0SeU23q8tPDB36HD1VnmYVS6eHeUaXG8kWPRChzHvkjqR6wbP2CC1kAkHy9QjlPsVxqth25PxXo4vCgAxVbLmrDmR/mHSqC+vaBhlnGtSUeWPwaohZFVNJxWT0peQRl4CZwDSeYGUAkqmAWhdrEuMlC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bETrA4AA; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 12 Feb 2024 08:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707745177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=87TCBaNU5o6Vxo7PXgbxsTc2mzZkmFF+JQAg6IQuI5w=;
	b=bETrA4AArtw4k2Zz7GaCKViZgXXMu3vy899ykUTeqHMTPXjJD7r7kYmHdKfp5FYMhJ7mTv
	eFZMTdTQeSoR1XOuextz30Xq7ZZkBaiM103fZiRhZV5SW+Cr2k/3sEfOdqp8kSBctP2lPD
	COtJudRmpOMPqfwe7i4SWaDJcbNzHS8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Brian Foster <bfoster@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Dave Chinner <dchinner@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2 3/7] fs: FS_IOC_GETUUID
Message-ID: <dfnric7xlns3u2hc4s4zfeotxpksmvnkvr5dv7hogvothdb3un@b5icg6irxyr5>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
 <20240206201858.952303-4-kent.overstreet@linux.dev>
 <ZcKsIbRRfeXfCObl@dread.disaster.area>
 <cm4wbdmpuq6mlyfqrb3qqwyysa3qao6t5sc2eq3ykmgb4ptpab@qkyberqtvrtt>
 <ZcN+8iOBR97t451x@bfoster>
 <krc2udjtkvylugzuledk7hre7rizmiajrgkiwvwcmsxtgxobyz@miqndphw7uhi>
 <ZcoTROgZiKOfp3iM@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcoTROgZiKOfp3iM@bfoster>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 12, 2024 at 07:47:00AM -0500, Brian Foster wrote:
> On Thu, Feb 08, 2024 at 04:57:02PM -0500, Kent Overstreet wrote:
> > On Wed, Feb 07, 2024 at 08:05:29AM -0500, Brian Foster wrote:
> > > On Tue, Feb 06, 2024 at 05:37:22PM -0500, Kent Overstreet wrote:
> > > > On Wed, Feb 07, 2024 at 09:01:05AM +1100, Dave Chinner wrote:
> > > > > On Tue, Feb 06, 2024 at 03:18:51PM -0500, Kent Overstreet wrote:
> > > > > > +static int ioctl_getfsuuid(struct file *file, void __user *argp)
> > > > > > +{
> > > > > > +	struct super_block *sb = file_inode(file)->i_sb;
> > > > > > +
> > > > > > +	if (!sb->s_uuid_len)
> > > > > > +		return -ENOIOCTLCMD;
> > > > > > +
> > > > > > +	struct fsuuid2 u = { .len = sb->s_uuid_len, };
> > > > > > +	memcpy(&u.uuid[0], &sb->s_uuid, sb->s_uuid_len);
> > > > > > +
> > > > > > +	return copy_to_user(argp, &u, sizeof(u)) ? -EFAULT : 0;
> > > > > > +}
> > > > > 
> > > > > Can we please keep the declarations separate from the code? I always
> > > > > find this sort of implicit scoping of variables both difficult to
> > > > > read (especially in larger functions) and a landmine waiting to be
> > > > > tripped over. This could easily just be:
> > > > > 
> > > > > static int ioctl_getfsuuid(struct file *file, void __user *argp)
> > > > > {
> > > > > 	struct super_block *sb = file_inode(file)->i_sb;
> > > > > 	struct fsuuid2 u = { .len = sb->s_uuid_len, };
> > > > > 
> > > > > 	....
> > > > > 
> > > > > and then it's consistent with all the rest of the code...
> > > > 
> > > > The way I'm doing it here is actually what I'm transitioning my own code
> > > > to - the big reason being that always declaring variables at the tops of
> > > > functions leads to separating declaration and initialization, and worse
> > > > it leads people to declaring a variable once and reusing it for multiple
> > > > things (I've seen that be a source of real bugs too many times).
> > > > 
> > > 
> > > I still think this is of questionable value. I know I've mentioned
> > > similar concerns to Dave's here on the bcachefs list, but still have not
> > > really seen any discussion other than a bit of back and forth on the
> > > handful of generally accepted (in the kernel) uses of this sort of thing
> > > for limiting scope in loops/branches and such.
> > > 
> > > I was skimming through some more recent bcachefs patches the other day
> > > (the journal write pipelining stuff) where I came across one or two
> > > medium length functions where this had proliferated, and I found it kind
> > > of annoying TBH. It starts to almost look like there are casts all over
> > > the place and it's a bit more tedious to filter out logic from the
> > > additional/gratuitous syntax, IMO.
> > > 
> > > That's still just my .02, but there was also previous mention of
> > > starting/having discussion on this sort of style change. Is that still
> > > the plan? If so, before or after proliferating it throughout the
> > > bcachefs code? ;) I am curious if there are other folks in kernel land
> > > who think this makes enough sense that they'd plan to adopt it. Hm?
> > 
> > That was the discussion :)
> > 
> > bcachefs is my codebase, so yes, I intend to do it there. I really think
> > this is an instance where you and Dave are used to the way C has
> > historically forced us to do things; our brains get wired to read code a
> > certain way and changes are jarring.
> > 
> 
> Heh, fair enough. That's certainly your prerogative. I'm certainly not
> trying to tell you what to do or not with bcachefs. That's at least
> direct enough that it's clear it's not worth debating too much. ;)
> 
> > But take a step back; if we were used to writing code the way I'm doing
> > it, and you were arguing for putting declarations at the tops of
> > functions, what would the arguments be?
> > 
> 
> I think my thought process would be similar. I.e., is the proposed
> benefit of such a change worth the tradeoffs?
> 
> > I would say you're just breaking up the flow of ideas for no reason; a
> > chain of related statements now includes a declaration that isn't with
> > the actual logic.
> > 
> > And bugs due to variable reuse, missed initialization - there's real
> > reasons not to do it that way.
> > 
> 
> And were I in that position, I don't think I would reduce a decision
> that affects readability/reviewability of my subsystem to a nontrivial
> degree (for other people, at least) to that single aspect. This would be
> the answer to the question: "is this worth considering?"

If you feel this affected by this, how are you going to cope with Rust?


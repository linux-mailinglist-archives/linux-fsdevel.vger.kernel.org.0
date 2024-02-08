Return-Path: <linux-fsdevel+bounces-10849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC7E84EAF9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7321F276D1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 21:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E53A4F5FA;
	Thu,  8 Feb 2024 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ciA597Dv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E7B4F5ED
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429430; cv=none; b=rZ1YgAgIIeSu4RTpLWUyAGN0i76kLgxEEc5s3ur4VGRo9zHXCcGCJym3bFPLVYJyrVgUU6xoZH07KWKm2+s9vyVkimqMpu4m7tC+RuGzE998zEAw9QhGpMXySPeicZo4o0lmI1KI6sy6EFliWBwTQKME42p41XIfbAij3MctVyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429430; c=relaxed/simple;
	bh=526f+OIfR5lt7kk3+KKqpP0mRWkrmTnf4eSgFYgV+j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uG08TFTDQs7/I2M52umtXOPqNT9zmVPUJb/9w7yxuvfyiXnMTRYnT/umW+VGnDAYt6dddtFrTsVD9zK43plkgr19la/lkCfNxqOQnnz9IKxVtNIE79r5Bw9/y4S3WrYKboCQh5T2k0emnQDZPm4E4hCd7SV/aqwEdsdfL2nRlcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ciA597Dv; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 8 Feb 2024 16:57:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707429426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uuBkW91bKSdtv/qP/AAZDiygwHtnsXoTG5ybHQAGsCM=;
	b=ciA597DvX/DbqrTOLewrCkHfHBc/438L8b8bIJN6CwD5wXKHgud0/jNmgQd8T0Vhq5sRMM
	DY9x3M/y9L9tfX6w9wgoyPrzZZVj1tYtot8PgdAvz9gONZyuRvVtX0FcVjBeVBtSxccL1v
	5x4xoLO0gU3MmkLq/DnwI/tXqKf2PFg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Brian Foster <bfoster@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Dave Chinner <dchinner@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2 3/7] fs: FS_IOC_GETUUID
Message-ID: <krc2udjtkvylugzuledk7hre7rizmiajrgkiwvwcmsxtgxobyz@miqndphw7uhi>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
 <20240206201858.952303-4-kent.overstreet@linux.dev>
 <ZcKsIbRRfeXfCObl@dread.disaster.area>
 <cm4wbdmpuq6mlyfqrb3qqwyysa3qao6t5sc2eq3ykmgb4ptpab@qkyberqtvrtt>
 <ZcN+8iOBR97t451x@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcN+8iOBR97t451x@bfoster>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 07, 2024 at 08:05:29AM -0500, Brian Foster wrote:
> On Tue, Feb 06, 2024 at 05:37:22PM -0500, Kent Overstreet wrote:
> > On Wed, Feb 07, 2024 at 09:01:05AM +1100, Dave Chinner wrote:
> > > On Tue, Feb 06, 2024 at 03:18:51PM -0500, Kent Overstreet wrote:
> > > > +static int ioctl_getfsuuid(struct file *file, void __user *argp)
> > > > +{
> > > > +	struct super_block *sb = file_inode(file)->i_sb;
> > > > +
> > > > +	if (!sb->s_uuid_len)
> > > > +		return -ENOIOCTLCMD;
> > > > +
> > > > +	struct fsuuid2 u = { .len = sb->s_uuid_len, };
> > > > +	memcpy(&u.uuid[0], &sb->s_uuid, sb->s_uuid_len);
> > > > +
> > > > +	return copy_to_user(argp, &u, sizeof(u)) ? -EFAULT : 0;
> > > > +}
> > > 
> > > Can we please keep the declarations separate from the code? I always
> > > find this sort of implicit scoping of variables both difficult to
> > > read (especially in larger functions) and a landmine waiting to be
> > > tripped over. This could easily just be:
> > > 
> > > static int ioctl_getfsuuid(struct file *file, void __user *argp)
> > > {
> > > 	struct super_block *sb = file_inode(file)->i_sb;
> > > 	struct fsuuid2 u = { .len = sb->s_uuid_len, };
> > > 
> > > 	....
> > > 
> > > and then it's consistent with all the rest of the code...
> > 
> > The way I'm doing it here is actually what I'm transitioning my own code
> > to - the big reason being that always declaring variables at the tops of
> > functions leads to separating declaration and initialization, and worse
> > it leads people to declaring a variable once and reusing it for multiple
> > things (I've seen that be a source of real bugs too many times).
> > 
> 
> I still think this is of questionable value. I know I've mentioned
> similar concerns to Dave's here on the bcachefs list, but still have not
> really seen any discussion other than a bit of back and forth on the
> handful of generally accepted (in the kernel) uses of this sort of thing
> for limiting scope in loops/branches and such.
> 
> I was skimming through some more recent bcachefs patches the other day
> (the journal write pipelining stuff) where I came across one or two
> medium length functions where this had proliferated, and I found it kind
> of annoying TBH. It starts to almost look like there are casts all over
> the place and it's a bit more tedious to filter out logic from the
> additional/gratuitous syntax, IMO.
> 
> That's still just my .02, but there was also previous mention of
> starting/having discussion on this sort of style change. Is that still
> the plan? If so, before or after proliferating it throughout the
> bcachefs code? ;) I am curious if there are other folks in kernel land
> who think this makes enough sense that they'd plan to adopt it. Hm?

That was the discussion :)

bcachefs is my codebase, so yes, I intend to do it there. I really think
this is an instance where you and Dave are used to the way C has
historically forced us to do things; our brains get wired to read code a
certain way and changes are jarring.

But take a step back; if we were used to writing code the way I'm doing
it, and you were arguing for putting declarations at the tops of
functions, what would the arguments be?

I would say you're just breaking up the flow of ideas for no reason; a
chain of related statements now includes a declaration that isn't with
the actual logic.

And bugs due to variable reuse, missed initialization - there's real
reasons not to do it that way.


Return-Path: <linux-fsdevel+bounces-49555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E33ABE94B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 03:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B17B1BA6BE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 01:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BAE1BE251;
	Wed, 21 May 2025 01:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ymwkwlm0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9486D1AC43A
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 01:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747792189; cv=none; b=b82RFcnP2uXpeCU8YdYHtar+62X8eeRVoLmpRI+39/bgXxdu+05zAJtmloAsRPDJZWw4p7IJm2QwczCGrbVbJ28Rae1GF7tLW7uJ2JpjbPGeuwQh7PPoPthzliHsogSdVVSR616ygE8uPJcm2qC9cCnBeTXiwjMMFGmMJwhpp9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747792189; c=relaxed/simple;
	bh=r6660o7TrV9mIX0QiqN4LlypHPU9HIyb4tcU13soERs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGTTncqUv7pNGN9pGsQBfN7ZYQxGCVM0CWx/nRtOzWD8mudSQrFHlMC8Gg2CA0WVWwy4DrqK+8yMGjzpiyjmmOJvpkiaHM6lzoxNRi2A7sURXIgqLLZDcXYuXIGgn6Kr8AzyCNvOiy1Wai07jRz1WrVjlOTC7g8/W8nTsplU32k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ymwkwlm0; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 May 2025 21:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747792174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l1O+r1kz2S9v4rWK4s64ptW8HHdeRPASy0UUAjHkGbs=;
	b=Ymwkwlm0QpBL0rQI5k+gMMRe7sS8GUH+8Afwpa4tQvB3TXtItxTmNdgboUuCcijzvJ2ocb
	QSKvnWCWjc6MFS+F/LN0N9rgd+Ae20myvLl1jn/IT8CuiWYRrA6mhDlmXPRYLNNJ4Jwiou
	SexVldyCrl+iycUOCwZJcXxyrSERzDY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: John Stoffel <john@stoffel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/6] overlayfs + casefolding
Message-ID: <7b272tdagnkvzt5eo4g4wy47rjwf67nqk26aq27uetc57kzza5@7p5cmikl2fw6>
References: <20250520051600.1903319-1-kent.overstreet@linux.dev>
 <CAOQ4uxg8p2Kg0BKrU4NSUzLVVLWcW=vLaw4kJkVR1Q-LyRbRXA@mail.gmail.com>
 <osbsqlzkc4zttz4gxa25exm5bhqog3tpyirsezcbcdesaucd7g@4sltqny4ybnz>
 <CAOQ4uxjUC=1MinjDCOfY5t89N3ga6msLmpVXL1p23qdQax6fSg@mail.gmail.com>
 <gdvg6zswvq4zjzo6vntggoacrgxxh33zmejo72yusp7aqkqzic@kaibexik7lvh>
 <CAOQ4uxg9sKC_8PLARkN6aB3E_U62_S3kfnBuRbAvho9BNzGAsQ@mail.gmail.com>
 <rkbkjp7xvefmtutkwtltyd6xch2pbw47x5czx6ctldemus2bvj@2ukfdmtfjjbw>
 <26668.52908.574606.416955@quad.stoffel.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26668.52908.574606.416955@quad.stoffel.home>
X-Migadu-Flow: FLOW_OUT

On Tue, May 20, 2025 at 02:49:16PM -0400, John Stoffel wrote:
> >>>>> "Kent" == Kent Overstreet <kent.overstreet@linux.dev> writes:
> 
> > On Tue, May 20, 2025 at 04:03:27PM +0200, Amir Goldstein wrote:
> >> On Tue, May 20, 2025 at 2:43 PM Kent Overstreet
> >> <kent.overstreet@linux.dev> wrote:
> >> >
> >> > On Tue, May 20, 2025 at 02:40:07PM +0200, Amir Goldstein wrote:
> >> > > On Tue, May 20, 2025 at 2:25 PM Kent Overstreet
> >> > > <kent.overstreet@linux.dev> wrote:
> >> > > >
> >> > > > On Tue, May 20, 2025 at 10:05:14AM +0200, Amir Goldstein wrote:
> >> > > > > On Tue, May 20, 2025 at 7:16 AM Kent Overstreet
> >> > > > > <kent.overstreet@linux.dev> wrote:
> >> > > > > >
> >> > > > > > This series allows overlayfs and casefolding to safely be used on the
> >> > > > > > same filesystem by providing exclusion to ensure that overlayfs never
> >> > > > > > has to deal with casefolded directories.
> >> > > > > >
> >> > > > > > Currently, overlayfs can't be used _at all_ if a filesystem even
> >> > > > > > supports casefolding, which is really nasty for users.
> >> > > > > >
> >> > > > > > Components:
> >> > > > > >
> >> > > > > > - filesystem has to track, for each directory, "does any _descendent_
> >> > > > > >   have casefolding enabled"
> >> > > > > >
> >> > > > > > - new inode flag to pass this to VFS layer
> >> > > > > >
> >> > > > > > - new dcache methods for providing refs for overlayfs, and filesystem
> >> > > > > >   methods for safely clearing this flag
> >> > > > > >
> >> > > > > > - new superblock flag for indicating to overlayfs & dcache "filesystem
> >> > > > > >   supports casefolding, it's safe to use provided new dcache methods are
> >> > > > > >   used"
> >> > > > > >
> >> > > > >
> >> > > > > I don't think that this is really needed.
> >> > > > >
> >> > > > > Too bad you did not ask before going through the trouble of this implementation.
> >> > > > >
> >> > > > > I think it is enough for overlayfs to know the THIS directory has no
> >> > > > > casefolding.
> >> > > >
> >> > > > overlayfs works on trees, not directories...
> >> > >
> >> > > I know how overlayfs works...
> >> > >
> >> > > I've explained why I don't think that sanitizing the entire tree is needed
> >> > > for creating overlayfs over a filesystem that may enable casefolding
> >> > > on some of its directories.
> >> >
> >> > So, you want to move error checking from mount time, where we _just_
> >> > did a massive API rework so that we can return errors in a way that
> >> > users will actually see them - to open/lookup, where all we have are a
> >> > small fixed set of error codes?
> >> 
> >> That's one way of putting it.
> >> 
> >> Please explain the use case.
> >> 
> >> When is overlayfs created over a subtree that is only partially case folded?
> >> Is that really so common that a mount time error justifies all the vfs
> >> infrastructure involved?
> 
> > Amir, you've got two widely used filesystem features that conflict and
> > can't be used on the same filesystem.
> 
> Wait, what?  How many people use casefolding, on a per-directory
> basis?  It's stupid.  Unix/Linux has used case-sensitive filesystems
> for years.  Yes, linux supports other OSes which did do casefolding,
> but yikes... per-directory support is just insane.  It should be
> per-filesystem only at BEST.  

Quite a lot.

You may not realize this, but Valve has, quietly, behind the scenes,
been intelligently funding a ton of Linux work with an eye towards not
just gaming, but improving Linus on the desktop. And they've been
deploying it too, you can buy a Steam deck today.

And a significant fraction of desktop users like to play games - we're
not just all work. Windows ports need casefolding - alternatives have
been discussed and they're non viable.

(I fondly remember the days when I had time for such things).

Samba fileservers are a thing, too.

And for all us desktop/workstation users, not being able to use the same
filesystem for wine and docker is the kind of jankiness that makes
people say "maybe Linux isn't ready for the desktop after all".

Put aside your feelings on casefolding - this is about basic attention
to detail.

> > That's _broken_.
> 
> So?  what about my cross mounting of VMS filesystems with "foo.txt;3"
> version control so I can go back to previous versions?  Why can't I do
> that from my Linux systems that's mounting that VMS image?   
> 
> Just because it's done doesn't mean it's not dumb.  
> 
> > Users hate partitioning just for separate /boot and /home, having to
> > partition for different applications is horrible. And since overlay
> > fs is used under the hood by docker, and casefolding is used under
> > the hood for running Windows applications, this isn't something
> > people can predict in advance.
> 
> Sure I can, I don't run windows applications to screw casefolding.
> :-)
> 
> And I personally LIKE having a seperate /boot and /home, because it
> gives isolation.  The world is not just single user laptops with
> everything all on one disk or spread across a couple of disks using
> LVM or RAID or all of the above.  
> 
> I also don't see any updates for the XFS tests, or any other
> filesystem tests, that actually checks and confirms this decidedly
> obtuse and dumb to implement idea.  

Well, you certainly are making your personal feelings known :)

But for me, as the engineer designing and implementing this stuff, I
don't let my personal feelings dictate.

That's not my place.

My job is to write code that works, works reliably, solves real
problems, and lets users do the things they want with their machines.

All this drama over casefolding has been pure distraction, and I would
appreciate if you and everyone else could tone it down now.


Return-Path: <linux-fsdevel+bounces-9072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A13E83DDBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 16:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2121C2107C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 15:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E611D52B;
	Fri, 26 Jan 2024 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oWmKYlal"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA4D1D522
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283692; cv=none; b=Jvy445pVh30RMRS/PFOlkoTM9Jw3VgEvOhuvlWtBOazeP9bjQkd18WctC8I6Hm3rYxROlh0YN6XCIyW2H7pPhJs0T8k0zeN/CSLmvGBYCm+wGMGFT63bvL8dMN+BevoT+pi2tEH+VFO8SOfnz21psoEtxBatIfOoFZxNn7UJgxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283692; c=relaxed/simple;
	bh=hC1B447Z1lBeod671z+o2TWvfmM9yYECqlfKSJTiddc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOiX04saaRQdz0I0Eamx4O6esTgw9DOcBN42X3sChwl0+pTs4Q7w2qmLUoSfruidLQ3hp2DKm81bHmAnhE0jEwuEHw++NuoriseZHPd1GhwBFqji6cDKMIhjyBKdSFNyrpNwn3Q21+Zabnv/ySOHKPv0UqhtplUu/Su8PIegyEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oWmKYlal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3D5C433F1;
	Fri, 26 Jan 2024 15:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706283692;
	bh=hC1B447Z1lBeod671z+o2TWvfmM9yYECqlfKSJTiddc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oWmKYlalUtCj+H1VRRfkSHZa0+1l11mtdT+khGBHB7n6TAHMmFD8Dz43wDY/aoKb4
	 y11oV3fh0cD9GnrU6bZgg2nxrQkw4twkzwV328BlQJf6OMecHwZNZNg/EaGbvfGKlR
	 htvRLu10PH75x1xnQihAx0qq5Wu9taXG5hl4nLK4=
Date: Fri, 26 Jan 2024 07:41:31 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [LSF/MM TOPIC] Making pseudo file systems inodes/dentries more
 like normal file systems
Message-ID: <2024012600-dose-happiest-f57d@gregkh>
References: <20240125104822.04a5ad44@gandalf.local.home>
 <2024012522-shorten-deviator-9f45@gregkh>
 <20240125205055.2752ac1c@rorschach.local.home>
 <2024012528-caviar-gumming-a14b@gregkh>
 <20240125214007.67d45fcf@rorschach.local.home>
 <2024012634-rotten-conjoined-0a98@gregkh>
 <20240126101553.7c22b054@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126101553.7c22b054@gandalf.local.home>

On Fri, Jan 26, 2024 at 10:15:53AM -0500, Steven Rostedt wrote:
> On Fri, 26 Jan 2024 06:16:38 -0800
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Jan 25, 2024 at 09:40:07PM -0500, Steven Rostedt wrote:
> > > On Thu, 25 Jan 2024 17:59:40 -0800
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > >   
> > > > > I tried to use kernfs when doing a lot of this and I had issues. I
> > > > > don't remember what those were, but I can revisit it.    
> > > > 
> > > > You might, as kernfs makes it so that the filesystem structures are
> > > > created on demand, when accessed, and then removed when memory pressure
> > > > happens.  That's what sysfs and configfs and cgroups use quite
> > > > successfully.  
> > > 
> > > kernfs doesn't look trivial and I can't find any documentation on how
> > > to use it.  
> > 
> > You have the code :)
> 
> Really Greg?
> 
> I can write what I want to do twice as fast than trying to figure out why
> someone else did what they did in their code, unless there's good
> documentation on the subject.

Sorry, that was snarky, but yes, there is no documentation for kernfs,
as it evolved over time with the users of it being converted to use it
as it went.  I'd suggest looking at how cgroups uses it as odds are
that's the simplest way.

> > > Should there be work to move debugfs over to kernfs?  
> > 
> > Why?  Are you seeing real actual memory use with debugfs that is causing
> > problems?  That is why we made kernfs, because people were seeing this
> > in sysfs.
> 
> The reason I brought it up was from Linus's comment about dentries and
> inodes should not exist if the file system isn't mounted. That's not the
> case with debugfs. My question is, do we want debugfs to not use dentries
> as its main handle?

In the long run, yes, I want the "handle" that all callers to debugfs to
NOT use a dentry, and have been slowly migrating away from allowing
debugfs to actually return a dentry to the caller.  When that is
eventually finished, it will be an opaque "handle" that all users of
debugfs has and THEN we can convert debugfs to do whatever it wants to.

Again, long-term plans, slowly getting there, if only I had an intern or
10 to help out with it :)

But, this is only being driven by my "this feels like the wrong api to
use" ideas, and seeing how debugfs returning a dentry has been abused by
many subsystems in places, not by any real-world measurements of
"debugfs is using up too much memory!" like we have had for sysfs ever
since the beginning.

If someone comes up with a real workload that shows debugfs is just too
slow or taking up too much memory for their systems for functionality
that they rely on (that's the kicker), then the movement for debugfs to
kernfs would happen much faster as someone would actually have the need
to do so.

> > Don't change stuff unless you need to, right?
> > 
> > > I could look at it too, but as tracefs, and more specifically eventfs,
> > > has 10s of thousands of files, I'm very concerned about meta data size.  
> > 
> > Do you have real numbers?  If not, then don't worry about it :)
> 
> I wouldn't be doing any of this without real numbers. They are in the
> change log of eventfs.
> 
>  See commits:
> 
>    27152bceea1df27ffebb12ac9cd9adbf2c4c3f35
>    5790b1fb3d672d9a1fe3881a7181dfdbe741568f

Sorry, I mean for debugfs.

> > Again, look at kernfs if you care about the memory usage of your virtual
> > filesystem, that's what it is there for, you shouldn't have to reinvent
> > the wheel.
> 
> Already did because it was much easier than trying to use kernfs without
> documentation. I did try at first, and realized it was easier to do it
> myself. tracefs was based on top of debugfs, and I saw no easy path to go
> from that to kernfs.

Perhaps do some digging into history and see how we moved sysfs to
kernfs, as originally sysfs looked exactly like debugfs.  That might
give you some ideas of what to do here.

> > And the best part is, when people find issues with scaling or other
> > stuff with kernfs, your filesystem will then benifit (lots of tweaks
> > have gone into kernfs for this over the past few kernel releases.)
> 
> Code is already done. It would be a huge effort to try to convert it over
> to kernfs without even knowing if it will regress the memory issues, which
> I believe it would (as the second commit saved 2 megs by getting rid of
> meta data per file, which kernfs would bring back).
> 
> So, unless there's proof that kernfs would not add that memory footprint
> back, I have no time to waste on it.

That's fine, I was just responding to your "do we need a in-kernel way
to do this type of thing" and I pointed out that kernfs already does
just that.  Rolling your own is great, like you did, I'm not saying you
have to move to kernfs at all if you don't want to as I'm not the one
having to maintain eventfs :)

thanks,

greg k-h


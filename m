Return-Path: <linux-fsdevel+bounces-9080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 428F783DF14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 17:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEDA7B212FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 16:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642321DDC9;
	Fri, 26 Jan 2024 16:44:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2851DA22
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287490; cv=none; b=aA8r3Ou2sDVq62yUq3UwLEcbdcui5fi7q6q7gkyAXLVGSZR9p/2SRvyOsUD+LUa9nVo4XadOAxJfxHKb3dnuWzUvtQFNExj+bOlgpMRASAXJ7br2+AXzZNaVby+mEfS6bsueV1GvuAfWKncOlSFlt+/zatXCf0DX42D5HKO0HtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287490; c=relaxed/simple;
	bh=2lz/gOxdPBL+Y7kg1/Djo4YDYTOkCcwSCaz4+PGUXlg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/cYiPbtRV9CoVMS4j74NXSKZVHKkvqpmLgUSPbdknEHEbn9AndlcGtrT4keEww53mtMhhK4UEXPFnLt3U5Eqpz4DVXpvKC0Y6DqyE88IFJEjNIx4KdExiEeDzzfpj7HpB1CXX5pVYtpn0EATk9CQE7XwGqyfyiGEZThQEz+obM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1602C433F1;
	Fri, 26 Jan 2024 16:44:48 +0000 (UTC)
Date: Fri, 26 Jan 2024 11:44:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Christian Brauner <brauner@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [LSF/MM TOPIC] Making pseudo file systems inodes/dentries more
 like normal file systems
Message-ID: <20240126114451.17be7e15@gandalf.local.home>
In-Reply-To: <2024012600-dose-happiest-f57d@gregkh>
References: <20240125104822.04a5ad44@gandalf.local.home>
	<2024012522-shorten-deviator-9f45@gregkh>
	<20240125205055.2752ac1c@rorschach.local.home>
	<2024012528-caviar-gumming-a14b@gregkh>
	<20240125214007.67d45fcf@rorschach.local.home>
	<2024012634-rotten-conjoined-0a98@gregkh>
	<20240126101553.7c22b054@gandalf.local.home>
	<2024012600-dose-happiest-f57d@gregkh>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 07:41:31 -0800
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> > The reason I brought it up was from Linus's comment about dentries and
> > inodes should not exist if the file system isn't mounted. That's not the
> > case with debugfs. My question is, do we want debugfs to not use dentries
> > as its main handle?  
> 
> In the long run, yes, I want the "handle" that all callers to debugfs to
> NOT use a dentry, and have been slowly migrating away from allowing
> debugfs to actually return a dentry to the caller.  When that is
> eventually finished, it will be an opaque "handle" that all users of
> debugfs has and THEN we can convert debugfs to do whatever it wants to.

So it does sound like we are on the same page ;-)

> 
> Again, long-term plans, slowly getting there, if only I had an intern or
> 10 to help out with it :)

Yeah, this is something we need to think about when people come up to us
and say "I'd like to be a kernel developer, is there anything you know of
that I can work on?" Add a KTODO?

> 
> But, this is only being driven by my "this feels like the wrong api to
> use" ideas, and seeing how debugfs returning a dentry has been abused by
> many subsystems in places, not by any real-world measurements of
> "debugfs is using up too much memory!" like we have had for sysfs ever
> since the beginning.

So we have a bit of miscommunication. My motivation for this topic wasn't
necessary on memory overhead (but it does help). But more about the
correctness of debugfs. I can understand how you could have interpreted my
motivation, as eventfs was solely motivated by memory pressure. But this
thread was motivated by Linus's comment about dentries not being allocated
before mounting.

> 
> If someone comes up with a real workload that shows debugfs is just too
> slow or taking up too much memory for their systems for functionality
> that they rely on (that's the kicker), then the movement for debugfs to
> kernfs would happen much faster as someone would actually have the need
> to do so.

Another motivation is to prevent another tracefs happening. That is,
another pseudo file system that copies debugfs like the way tracefs was
created. I've had a few conversations with others that say "we have a
special interface in debugfs but we want to move it out". And I've been
(incorrectly) telling them what I did with tracefs from debugfs.

> 
> > > Don't change stuff unless you need to, right?
> > >   
> > > > I could look at it too, but as tracefs, and more specifically eventfs,
> > > > has 10s of thousands of files, I'm very concerned about meta data size.    
> > > 
> > > Do you have real numbers?  If not, then don't worry about it :)  
> > 
> > I wouldn't be doing any of this without real numbers. They are in the
> > change log of eventfs.
> > 
> >  See commits:
> > 
> >    27152bceea1df27ffebb12ac9cd9adbf2c4c3f35
> >    5790b1fb3d672d9a1fe3881a7181dfdbe741568f  
> 
> Sorry, I mean for debugfs.

No problem. This is how I figured we were talking pass each other. eventfs
was a big culprit in memory issues, as it has so many files. But now I'm
talking about correctness more than memory savings. And this came about
from my conversations with Linus pointing out that "I was doing it wrong" ;-)

> 
> > > Again, look at kernfs if you care about the memory usage of your virtual
> > > filesystem, that's what it is there for, you shouldn't have to reinvent
> > > the wheel.  
> > 
> > Already did because it was much easier than trying to use kernfs without
> > documentation. I did try at first, and realized it was easier to do it
> > myself. tracefs was based on top of debugfs, and I saw no easy path to go
> > from that to kernfs.  
> 
> Perhaps do some digging into history and see how we moved sysfs to
> kernfs, as originally sysfs looked exactly like debugfs.  That might
> give you some ideas of what to do here.

I believe one project that should come out of this (again for those that
want to be a kernel developer) is to document how to create a new pseudo
file system out of kernfs.

> 
> > > And the best part is, when people find issues with scaling or other
> > > stuff with kernfs, your filesystem will then benifit (lots of tweaks
> > > have gone into kernfs for this over the past few kernel releases.)  
> > 
> > Code is already done. It would be a huge effort to try to convert it over
> > to kernfs without even knowing if it will regress the memory issues, which
> > I believe it would (as the second commit saved 2 megs by getting rid of
> > meta data per file, which kernfs would bring back).
> > 
> > So, unless there's proof that kernfs would not add that memory footprint
> > back, I have no time to waste on it.  
> 
> That's fine, I was just responding to your "do we need a in-kernel way
> to do this type of thing" and I pointed out that kernfs already does
> just that.  Rolling your own is great, like you did, I'm not saying you
> have to move to kernfs at all if you don't want to as I'm not the one
> having to maintain eventfs :)

Yeah. So now the focus is on keeping others from rolling their own unless
they have to. I (or more realistically, someone else) could possibly
convert the tracefs portion to kernfs (keeping eventfs separate as it is
from tracefs, due to the amount of files). It would probably take the same
effort as moving debugfs over to kernfs as the two are pretty much
identical.

Creating eventfs was a great learning experience for me. But it took much
more time than I had allocated for it (putting me way behind in other
responsibilities I have).

I still like to bring up this discussion with the hopes that someone may be
interested in fixing this.

Thanks,

-- Steve


Return-Path: <linux-fsdevel+bounces-9067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 789FC83DD3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 16:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5241C20C30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 15:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9069F1CF87;
	Fri, 26 Jan 2024 15:15:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A35D1D53F
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282152; cv=none; b=TwBZtNo+t0huDEDDp/JYt9Ti7YMGueLYex1o5C0AKTWkShfc/z+HRoiimE9W09iOD7KAogNq+lsOem9sGAin33x0nziwYOnta3xtzBHOZ2uDqaoUozHFBRN/ApxDj9JKXTd6wB5YujZNkaas7sHX3bZ5eYKf8Su/YH1xn2TdxDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282152; c=relaxed/simple;
	bh=sPhhokVOKoqIv9LAM2NxBchT8ryRQxGs7gei6eSoITo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCiQmNikhQFt9Era3ziX1bUjMg5ClDbyqCnIBaZVfoy/PXQ2YIBVJmoOd78e5J+RS3HTHAe653yG5QcobdEEPK9ysalVmDZ0JY0o0Or53ZgqLNnRIwcTbFd2FV35L0pTQ874nolBBQ8MeZhE+k75lNvfWJW7VZHB7W+/fLKs5Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C84C43390;
	Fri, 26 Jan 2024 15:15:51 +0000 (UTC)
Date: Fri, 26 Jan 2024 10:15:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Christian Brauner <brauner@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [LSF/MM TOPIC] Making pseudo file systems inodes/dentries more
 like normal file systems
Message-ID: <20240126101553.7c22b054@gandalf.local.home>
In-Reply-To: <2024012634-rotten-conjoined-0a98@gregkh>
References: <20240125104822.04a5ad44@gandalf.local.home>
	<2024012522-shorten-deviator-9f45@gregkh>
	<20240125205055.2752ac1c@rorschach.local.home>
	<2024012528-caviar-gumming-a14b@gregkh>
	<20240125214007.67d45fcf@rorschach.local.home>
	<2024012634-rotten-conjoined-0a98@gregkh>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 06:16:38 -0800
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Jan 25, 2024 at 09:40:07PM -0500, Steven Rostedt wrote:
> > On Thu, 25 Jan 2024 17:59:40 -0800
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >   
> > > > I tried to use kernfs when doing a lot of this and I had issues. I
> > > > don't remember what those were, but I can revisit it.    
> > > 
> > > You might, as kernfs makes it so that the filesystem structures are
> > > created on demand, when accessed, and then removed when memory pressure
> > > happens.  That's what sysfs and configfs and cgroups use quite
> > > successfully.  
> > 
> > kernfs doesn't look trivial and I can't find any documentation on how
> > to use it.  
> 
> You have the code :)

Really Greg?

I can write what I want to do twice as fast than trying to figure out why
someone else did what they did in their code, unless there's good
documentation on the subject.

> 
> > Should there be work to move debugfs over to kernfs?  
> 
> Why?  Are you seeing real actual memory use with debugfs that is causing
> problems?  That is why we made kernfs, because people were seeing this
> in sysfs.

The reason I brought it up was from Linus's comment about dentries and
inodes should not exist if the file system isn't mounted. That's not the
case with debugfs. My question is, do we want debugfs to not use dentries
as its main handle?

> 
> Don't change stuff unless you need to, right?
> 
> > I could look at it too, but as tracefs, and more specifically eventfs,
> > has 10s of thousands of files, I'm very concerned about meta data size.  
> 
> Do you have real numbers?  If not, then don't worry about it :)

I wouldn't be doing any of this without real numbers. They are in the
change log of eventfs.

 See commits:

   27152bceea1df27ffebb12ac9cd9adbf2c4c3f35
   5790b1fb3d672d9a1fe3881a7181dfdbe741568f

> 
> > Currently eventfs keeps a data structure for every directory, but for
> > the files, it only keeps an array of names and callbacks. When a
> > directory is registered, it lists the files it needs. eventfs is
> > specific that the number of files a directory has is always constant,
> > and files will not be removed or added once a directory is created.
> > 
> > This way, the information on how a file is created is done via a
> > callback that was registered when the directory was created.  
> 
> That's fine, and shouldn't matter.
> 
> > For this use case, I don't think kernfs could be used. But I would
> > still like to talk about what I'm trying to accomplish, and perhaps see
> > if there's work that can be done to consolidate what is out there.  
> 
> Again, look at kernfs if you care about the memory usage of your virtual
> filesystem, that's what it is there for, you shouldn't have to reinvent
> the wheel.

Already did because it was much easier than trying to use kernfs without
documentation. I did try at first, and realized it was easier to do it
myself. tracefs was based on top of debugfs, and I saw no easy path to go
from that to kernfs.

> 
> And the best part is, when people find issues with scaling or other
> stuff with kernfs, your filesystem will then benifit (lots of tweaks
> have gone into kernfs for this over the past few kernel releases.)

Code is already done. It would be a huge effort to try to convert it over
to kernfs without even knowing if it will regress the memory issues, which
I believe it would (as the second commit saved 2 megs by getting rid of
meta data per file, which kernfs would bring back).

So, unless there's proof that kernfs would not add that memory footprint
back, I have no time to waste on it.

-- Steve


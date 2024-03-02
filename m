Return-Path: <linux-fsdevel+bounces-13346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11F086EE2F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 03:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A5B1C21BAE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 02:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C006FCA;
	Sat,  2 Mar 2024 02:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOHMLjfU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C39D110A;
	Sat,  2 Mar 2024 02:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709347712; cv=none; b=gYGyaZ6cY/7FSZj0YENG88WiCGu5ifXvt9GTzWUb5SfgmWiHLynQxOrMYf+NpNOVOH4zcLeRjy6vDwnfG1w2ifeypbNYixUwAPLEz22VNQoa8Sg0wFCzNRsbYaAf6JJ9PjGTrShe8F+MDeDJyMmpzWaFcb4z6wDaR6UZAuOWWmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709347712; c=relaxed/simple;
	bh=rSzHh+yf3pqOy0q5p0puXfA0m9yhsfFdIwnXmfsDPTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQmYKSQClx5smNSrr6vqxc2njpuflHEOkmRNu5sBMymLBQKm4ya9YY7G5buxyQl/AJkjA+FYoifghWl5fNyZUWbCyWdNU4UhmbV4OEMR9JJGPNFGXLd2VrPLMCieQgChyW/hxukwG/CklGA5l8ITyN41kriG93ZPZ1qSjZgblMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOHMLjfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30097C433C7;
	Sat,  2 Mar 2024 02:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709347712;
	bh=rSzHh+yf3pqOy0q5p0puXfA0m9yhsfFdIwnXmfsDPTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mOHMLjfUhJlAmUo61hDrJCebD0hImIyLXHc/sPNGhNepmi1J4GtHDEhEuBb4nClht
	 ehPLIo+DnVRLq8IglnDew0FyBYKZofkyJHlczsNaziZpsb5+6I+ZzN6yUcmblqq5GL
	 0zJkju8Gy4FbpCHup0EXlpfRNS2hoxwrUN9nZcjydiirTDfjTArD0A9iwKgrNwI09q
	 i2CrzZmA1pd3TOBjzIIMl1/MRZUsMt1klTvU0TULU3hCakR94OyNEkTEnMq+Tk70+C
	 qaWPeLuFcXRia4g2LGTDlcsEkBGnxkQ07GSlOyz9PC0x9/z9zg/oCYchy/Ti1Kh8lQ
	 l5YmbFmACbiZA==
Date: Fri, 1 Mar 2024 18:48:31 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 14/13] xfs: make XFS_IOC_COMMIT_RANGE freshness data
 opaque
Message-ID: <20240302024831.GL1927156@frogsfrogsfrogs>
References: <170900011604.938268.9876750689883987904.stgit@frogsfrogsfrogs>
 <20240227174649.GL6184@frogsfrogsfrogs>
 <CAOQ4uxiPfno-Hx+fH3LEN_4D6HQgyMAySRNCU=O2R_-ksrxSDQ@mail.gmail.com>
 <20240229232724.GD1927156@frogsfrogsfrogs>
 <bf2f4a0e7033091d34139540737674dc998fe010.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf2f4a0e7033091d34139540737674dc998fe010.camel@kernel.org>

On Fri, Mar 01, 2024 at 08:31:21AM -0500, Jeff Layton wrote:
> On Thu, 2024-02-29 at 15:27 -0800, Darrick J. Wong wrote:
> > On Tue, Feb 27, 2024 at 08:52:58PM +0200, Amir Goldstein wrote:
> > > On Tue, Feb 27, 2024 at 7:46 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > 
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > 
> > > > To head off bikeshedding about the fields in xfs_commit_range, let's
> > > > make it an opaque u64 array and require the userspace program to call
> > > > a third ioctl to sample the freshness data for us.  If we ever converge
> > > > on a definition for i_version then we can use that; for now we'll just
> > > > use mtime/ctime like the old swapext ioctl.
> > > 
> > > This addresses my concerns about using mtime/ctime.
> > 
> > Oh good! :)
> > 
> > > I have to say, Darrick, that I think that referring to this concern as
> > > bikeshedding is not being honest.
> > > 
> > > I do hate nit picking reviews and I do hate "maybe also fix the world"
> > > review comments, but I think the question about using mtime/ctime in
> > > this new API was not out of place
> > 
> > I agree, your question about mtime/ctime:
> > 
> > "Maybe a stupid question, but under which circumstances would mtime
> > change and ctime not change? Why are both needed?"
> > 
> > was a very good question.  But perhaps that statement referred to the
> > other part of that thread.
> > 
> > >                                   and I think that making the freshness
> > > data opaque is better for everyone in the long run and hopefully, this will
> > > help you move to the things you care about faster.
> > 
> > I wish you'd suggested an opaque blob that the fs can lay out however it
> > wants instead of suggesting specifically the change cookie.  I'm very
> > much ok with an opaque freshness blob that allows future flexibility in
> > how we define the blob's contents.
> > 
> > I was however very upset about the Jeff's suggestion of using i_version.
> > I apologize for using all caps in that reply, and snarling about it in
> > the commit message here.  The final version of this patch will not have
> > that.
> > 
> > That said, I don't think it is at all helpful to suggest using a file
> > attribute whose behavior is as yet unresolved.  Multigrain timestamps
> > were a clever idea, regrettably reverted.  As far as I could tell when I
> > wrote my reply, neither had NFS implemented a better behavior and
> > quietly merged it; nor have Jeff and Dave produced any sort of candidate
> > patchset to fix all the resulting issues in XFS.
> >
> > Reading "I realize that STATX_CHANGE_COOKIE is currently kernel
> > internal" made me think "OH $deity, they wants me to do that work
> > too???"
> > 
> > A better way to have woreded that might've been "How about switching
> > this to a fs-determined structure so that we can switch the freshness
> > check to i_version when that's fully working on XFS?"
> > 
> > The problem I have with reading patch review emails is that I can't
> > easily tell whether an author's suggestion is being made in a casual
> > offhand manner?  Or if it reflects something they feel strongly needs
> > change before merging.
> > 
> > In fairness to you, Amir, I don't know how much you've kept on top of
> > that i_version vs. XFS discussion.  So I have no idea if you were aware
> > of the status of that work.
> > 
> 
> Sorry, I didn't mean to trigger anyone, but I do have real concerns
> about any API that attempts to use timestamps to detect whether
> something has changed.
> 
> We learned that lesson in NFS in the 90's. VFS timestamp resolution is
> just not enough to show whether there was a change to a file -- full
> stop.
> 
> I get the hand-wringing over i_version definitions and I don't care to
> rehash that discussion here, but I'll point out that this is a
> (proposed) XFS-private interface:
> 
> What you could do is expose the XFS change counter (the one that gets
> bumped for everything, even atime updates, possibly via different
> ioctl), and use that for your "freshness" check.
> 
> You'd unfortunately get false negative freshness checks after read
> operations, but you shouldn't get any false positives (which is real
> danger with timestamps).

I don't see how would that work for this usecase?  You have to sample
file2 before reflinking file2's contents to file1, writing the changes
to file1, and executing COMMIT_RANGE.  Setting the xfs-private REFLINK
inode flag on file2 will trigger an iversion update even though it won't
change mtime or ctime.  The COMMIT then fails due to the inode flags
change.

Worse yet, applications aren't going to know if a particular access is
actually the one that will trigger an atime update.  So this will just
fail unpredictably.

If iversion was purely a write counter then I would switch the freshness
implementation to use it.  But it's not, and I know this to be true
because I tried that and could not get COMMIT_RANGE to work reliably.
I suppose the advantage of the blob thing is that we actually /can/
switch over whenever it's ready.

--D

> -- 
> Jeff Layton <jlayton@kernel.org>
> 


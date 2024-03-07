Return-Path: <linux-fsdevel+bounces-13952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5935F875B15
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 00:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C701F229C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 23:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBE63FB2F;
	Thu,  7 Mar 2024 23:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgukGQ/n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7589F3F9C6;
	Thu,  7 Mar 2024 23:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709853950; cv=none; b=ZIDDYHDoCELLoLvSFz4kmQqOl4vR7elrREioKsuKr/E+RZQwQzRV5rwF9UI+EeOsJVjgB0J92HWtXg9KYvdlPnaA0i+NwPJgdv1SXPw6nj7WHSdgyT6wrhy/xszsuufs9W15G2OS7aDqMWrxxbgEzN3tqD89td2KDCxSNK0VUHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709853950; c=relaxed/simple;
	bh=Q7EOO9sACNMTrdopkPP9b92/L32m5EGawjyCVMe2IE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9h3GGLRSUtaCKRm+Ecn6EQfwOJ61ahltxAM6kVKecyt/KD+splded7uM1wbCcHZXbOcwvK4VG60etDVsR81XsUhkqlA9eme5nolXdASwvluMnDir62xjr6vCz6TZJ27ck0U8qnzfxAc+fh8HLmoGIW+l73nSBCeo3R1xV026D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgukGQ/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA36C433C7;
	Thu,  7 Mar 2024 23:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709853949;
	bh=Q7EOO9sACNMTrdopkPP9b92/L32m5EGawjyCVMe2IE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SgukGQ/nGA6LPXD1upS/mbPTe9t8xNUARhOdM0FVIkEIKnJLFS4hR5XZOGfQsBqAH
	 OceJhviayYDNkxZJMqGrXfkziWqnwsHmL+neEFbiZ2OFbmqacMSVSSLAP056mRMZU4
	 AfWj+XoD3j2nET+AALXaznJx76K8h49N8PxW4+FKpx9GAkwKv5NguogIpNFy/HNy2N
	 W2MwiQGsRlZI06fWYeBdcCYWs++crTUWrTJGQfw/X7G1A/WjlPUO+iPXJ1NK7PstV5
	 99scHwd+ycB7SljR3HmIcsWMUZLz2/iAa6jdxdj8dDLK474mWm8rkJK0H2apJXhhFG
	 ep7lN5GOYf6qw==
Date: Thu, 7 Mar 2024 15:25:49 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 14/13] xfs: make XFS_IOC_COMMIT_RANGE freshness data
 opaque
Message-ID: <20240307232549.GI1927156@frogsfrogsfrogs>
References: <170900011604.938268.9876750689883987904.stgit@frogsfrogsfrogs>
 <20240227174649.GL6184@frogsfrogsfrogs>
 <CAOQ4uxiPfno-Hx+fH3LEN_4D6HQgyMAySRNCU=O2R_-ksrxSDQ@mail.gmail.com>
 <20240229232724.GD1927156@frogsfrogsfrogs>
 <bf2f4a0e7033091d34139540737674dc998fe010.camel@kernel.org>
 <20240302024831.GL1927156@frogsfrogsfrogs>
 <98b41ce0e577cffcc45c7d29781ca2d85ed19d5e.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98b41ce0e577cffcc45c7d29781ca2d85ed19d5e.camel@kernel.org>

On Sat, Mar 02, 2024 at 07:43:53AM -0500, Jeff Layton wrote:
> On Fri, 2024-03-01 at 18:48 -0800, Darrick J. Wong wrote:
> > On Fri, Mar 01, 2024 at 08:31:21AM -0500, Jeff Layton wrote:
> > > On Thu, 2024-02-29 at 15:27 -0800, Darrick J. Wong wrote:
> > > > On Tue, Feb 27, 2024 at 08:52:58PM +0200, Amir Goldstein wrote:
> > > > > On Tue, Feb 27, 2024 at 7:46 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > > > 
> > > > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > > > 
> > > > > > To head off bikeshedding about the fields in xfs_commit_range, let's
> > > > > > make it an opaque u64 array and require the userspace program to call
> > > > > > a third ioctl to sample the freshness data for us.  If we ever converge
> > > > > > on a definition for i_version then we can use that; for now we'll just
> > > > > > use mtime/ctime like the old swapext ioctl.
> > > > > 
> > > > > This addresses my concerns about using mtime/ctime.
> > > > 
> > > > Oh good! :)
> > > > 
> > > > > I have to say, Darrick, that I think that referring to this concern as
> > > > > bikeshedding is not being honest.
> > > > > 
> > > > > I do hate nit picking reviews and I do hate "maybe also fix the world"
> > > > > review comments, but I think the question about using mtime/ctime in
> > > > > this new API was not out of place
> > > > 
> > > > I agree, your question about mtime/ctime:
> > > > 
> > > > "Maybe a stupid question, but under which circumstances would mtime
> > > > change and ctime not change? Why are both needed?"
> > > > 
> > > > was a very good question.  But perhaps that statement referred to the
> > > > other part of that thread.
> > > > 
> > > > >                                   and I think that making the freshness
> > > > > data opaque is better for everyone in the long run and hopefully, this will
> > > > > help you move to the things you care about faster.
> > > > 
> > > > I wish you'd suggested an opaque blob that the fs can lay out however it
> > > > wants instead of suggesting specifically the change cookie.  I'm very
> > > > much ok with an opaque freshness blob that allows future flexibility in
> > > > how we define the blob's contents.
> > > > 
> > > > I was however very upset about the Jeff's suggestion of using i_version.
> > > > I apologize for using all caps in that reply, and snarling about it in
> > > > the commit message here.  The final version of this patch will not have
> > > > that.
> > > > 
> > > > That said, I don't think it is at all helpful to suggest using a file
> > > > attribute whose behavior is as yet unresolved.  Multigrain timestamps
> > > > were a clever idea, regrettably reverted.  As far as I could tell when I
> > > > wrote my reply, neither had NFS implemented a better behavior and
> > > > quietly merged it; nor have Jeff and Dave produced any sort of candidate
> > > > patchset to fix all the resulting issues in XFS.
> > > > 
> > > > Reading "I realize that STATX_CHANGE_COOKIE is currently kernel
> > > > internal" made me think "OH $deity, they wants me to do that work
> > > > too???"
> > > > 
> > > > A better way to have woreded that might've been "How about switching
> > > > this to a fs-determined structure so that we can switch the freshness
> > > > check to i_version when that's fully working on XFS?"
> > > > 
> > > > The problem I have with reading patch review emails is that I can't
> > > > easily tell whether an author's suggestion is being made in a casual
> > > > offhand manner?  Or if it reflects something they feel strongly needs
> > > > change before merging.
> > > > 
> > > > In fairness to you, Amir, I don't know how much you've kept on top of
> > > > that i_version vs. XFS discussion.  So I have no idea if you were aware
> > > > of the status of that work.
> > > > 
> > > 
> > > Sorry, I didn't mean to trigger anyone, but I do have real concerns
> > > about any API that attempts to use timestamps to detect whether
> > > something has changed.
> > > 
> > > We learned that lesson in NFS in the 90's. VFS timestamp resolution is
> > > just not enough to show whether there was a change to a file -- full
> > > stop.
> > > 
> > > I get the hand-wringing over i_version definitions and I don't care to
> > > rehash that discussion here, but I'll point out that this is a
> > > (proposed) XFS-private interface:
> > > 
> > > What you could do is expose the XFS change counter (the one that gets
> > > bumped for everything, even atime updates, possibly via different
> > > ioctl), and use that for your "freshness" check.
> > > 
> > > You'd unfortunately get false negative freshness checks after read
> > > operations, but you shouldn't get any false positives (which is real
> > > danger with timestamps).
> > 
> > I don't see how would that work for this usecase?  You have to sample
> > file2 before reflinking file2's contents to file1, writing the changes
> > to file1, and executing COMMIT_RANGE.  Setting the xfs-private REFLINK
> > inode flag on file2 will trigger an iversion update even though it won't
> > change mtime or ctime.  The COMMIT then fails due to the inode flags
> > change.
> > 
> > Worse yet, applications aren't going to know if a particular access is
> > actually the one that will trigger an atime update.  So this will just
> > fail unpredictably.
> > 
> > If iversion was purely a write counter then I would switch the freshness
> > implementation to use it.  But it's not, and I know this to be true
> > because I tried that and could not get COMMIT_RANGE to work reliably.
> > I suppose the advantage of the blob thing is that we actually /can/
> > switch over whenever it's ready.
> > 
> 
> Yeah, that's the other part -- you have to be willing to redrive the I/O
> every time the freshness check fails, which can get expensive depending
> on how active the file is. Again this is an XFS interface, so I don't
> really have a dog in this fight. If you think timestamps are good
> enough, then so be it.
> 
> All I can do is mention that it has been our experience in the NFS world
> that relying on timestamps like this will eventually lead to data
> corruption. The race conditions may be tight, and much of the time the
> race may be benign, but if you do this enough you'll eventually get
> bitten, and end up exchanging data when you shouldn't have.
> 
> All of that said, I think this is great discussion fodder for LSF this
> year. I feel like the time is right to consider these sorts of
> interfaces that do synchronized I/O without locking. I've already
> proposed a discussion around the state of the i_version counter, so
> maybe we can chat about it then?

Yes.  I've gotten an invitation, so corporate approval and dumb injuries
notwithstanding, I'll be there this year. :)

--D

> -- 
> Jeff Layton <jlayton@kernel.org>
> 


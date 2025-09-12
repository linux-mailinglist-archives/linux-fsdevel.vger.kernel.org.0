Return-Path: <linux-fsdevel+bounces-61092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A099B55286
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 16:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B92CA169538
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594D9313E2B;
	Fri, 12 Sep 2025 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmoCwZSy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF2D256C9B;
	Fri, 12 Sep 2025 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689138; cv=none; b=gsbIJ0+gPRjxn7aRGtK3ENOwhojqsyXefuc5Ks5quKRDZRLzPJ282si1ijXj2BShVu6FS9rc3s/6yVS1cnM31l9R1IxCScceuuNIdgxjgNBIDcKySLHMclauJvR92Pci8LFYo8yg2pHED16nz4/xZjNsnCa5b0Nzm+tJdD8YWPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689138; c=relaxed/simple;
	bh=IbGGPnja3Pw/pYEQhfDuD63zXjf7UQWXx6Xegr9kjxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxIkQRRv58lIQIPXEOMX4L9xaNCVV323OYpEhHNbK5DYrV6+q7Uym78JUY1I5sqVMCx8EyYb+MqlYx/pquSJ959XYP+QPokNx1N2OKy9BvTS8R49VdDPysrc0cXQzc0M2Gefvs5Bv6AW3+djLEvSeAN6utRJGqs0gIQ0W9gAM0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmoCwZSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15020C4CEF1;
	Fri, 12 Sep 2025 14:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757689138;
	bh=IbGGPnja3Pw/pYEQhfDuD63zXjf7UQWXx6Xegr9kjxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gmoCwZSyKuiswNLhlwM1xmuN0EFmGVe5qDdB4cRTF6w9iwM69JKM9SkpYG3WOeqwh
	 Iimohm3llK0DUYa/PkTBQyCS7gwRS5WkNpMpxuGdYTm6GxzebzX6dlmzxtX/lwoZ/w
	 3m8vf7c5SPfJi5dShXYXdATfj3GLby6eO+YydZXEc94NDFmDkR898Q/G2urPB8mdwt
	 Y5FaN9UwAAqgURFjfJf2YMknHmJbSpDGajI+s8o7iSDLl68By8ZPoWpUV08U9RSYSd
	 SyiIcvYb506GbNHnHDiZdPvQmE5mq2m9pvCEtFYSUw9SNng4HbChwF5AFDc+UnBnlq
	 oqNbTixfsob2Q==
Date: Fri, 12 Sep 2025 07:58:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Luis Henriques <luis@igalia.com>,
	Theodore Ts'o <tytso@mit.edu>, Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kevin Chen <kchen@ddn.com>
Subject: Re: [RFC] Another take at restarting FUSE servers
Message-ID: <20250912145857.GQ8117@frogsfrogsfrogs>
References: <8734afp0ct.fsf@igalia.com>
 <20250729233854.GV2672029@frogsfrogsfrogs>
 <20250731130458.GE273706@mit.edu>
 <20250731173858.GE2672029@frogsfrogsfrogs>
 <8734abgxfl.fsf@igalia.com>
 <39818613-c10b-4ed2-b596-23b70c749af1@bsbernd.com>
 <CAOQ4uxg1zXPTB1_pFB=hyqjAGjk=AC34qP1k9C043otxcwqJGg@mail.gmail.com>
 <2e57be4f-e61b-4a37-832d-14bdea315126@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e57be4f-e61b-4a37-832d-14bdea315126@bsbernd.com>

On Fri, Sep 12, 2025 at 02:29:03PM +0200, Bernd Schubert wrote:
> 
> 
> On 9/12/25 13:41, Amir Goldstein wrote:
> > On Fri, Sep 12, 2025 at 12:31 PM Bernd Schubert <bernd@bsbernd.com> wrote:
> >>
> >>
> >>
> >> On 8/1/25 12:15, Luis Henriques wrote:
> >>> On Thu, Jul 31 2025, Darrick J. Wong wrote:
> >>>
> >>>> On Thu, Jul 31, 2025 at 09:04:58AM -0400, Theodore Ts'o wrote:
> >>>>> On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. Wong wrote:
> >>>>>>
> >>>>>> Just speaking for fuse2fs here -- that would be kinda nifty if libfuse
> >>>>>> could restart itself.  It's unclear if doing so will actually enable us
> >>>>>> to clear the condition that caused the failure in the first place, but I
> >>>>>> suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe restarts
> >>>>>> aren't totally crazy.
> >>>>>
> >>>>> I'm trying to understand what the failure scenario is here.  Is this
> >>>>> if the userspace fuse server (i.e., fuse2fs) has crashed?  If so, what
> >>>>> is supposed to happen with respect to open files, metadata and data
> >>>>> modifications which were in transit, etc.?  Sure, fuse2fs could run
> >>>>> e2fsck -fy, but if there are dirty inode on the system, that's going
> >>>>> potentally to be out of sync, right?
> >>>>>
> >>>>> What are the recovery semantics that we hope to be able to provide?
> >>>>
> >>>> <echoing what we said on the ext4 call this morning>
> >>>>
> >>>> With iomap, most of the dirty state is in the kernel, so I think the new
> >>>> fuse2fs instance would poke the kernel with FUSE_NOTIFY_RESTARTED, which
> >>>> would initiate GETATTR requests on all the cached inodes to validate
> >>>> that they still exist; and then resend all the unacknowledged requests
> >>>> that were pending at the time.  It might be the case that you have to
> >>>> that in the reverse order; I only know enough about the design of fuse
> >>>> to suspect that to be true.
> >>>>
> >>>> Anyhow once those are complete, I think we can resume operations with
> >>>> the surviving inodes.  The ones that fail the GETATTR revalidation are
> >>>> fuse_make_bad'd, which effectively revokes them.
> >>>
> >>> Ah! Interesting, I have been playing a bit with sending LOOKUP requests,
> >>> but probably GETATTR is a better option.
> >>>
> >>> So, are you currently working on any of this?  Are you implementing this
> >>> new NOTIFY_RESTARTED request?  I guess it's time for me to have a closer
> >>> look at fuse2fs too.
> >>
> >> Sorry for joining the discussion late, I was totally occupied, day and
> >> night. Added Kevin to CC, who is going to work on recovery on our
> >> DDN side.
> >>
> >> Issue with GETATTR and LOOKUP is that they need a path, but on fuse
> >> server restart we want kernel to recover inodes and their lookup count.
> >> Now inode recovery might be hard, because we currently only have a
> >> 64-bit node-id - which is used my most fuse application as memory
> >> pointer.
> >>
> >> As Luis wrote, my issue with FUSE_NOTIFY_RESEND is that it just re-sends
> >> outstanding requests. And that ends up in most cases in sending requests
> >> with invalid node-IDs, that are casted and might provoke random memory
> >> access on restart. Kind of the same issue why fuse nfs export or
> >> open_by_handle_at doesn't work well right now.
> >>
> >> So IMHO, what we really want is something like FUSE_LOOKUP_FH, which
> >> would not return a 64-bit node ID, but a max 128 byte file handle.
> >> And then FUSE_REVALIDATE_FH on server restart.
> >> The file handles could be stored into the fuse inode and also used for
> >> NFS export.
> >>
> >> I *think* Amir had a similar idea, but I don't find the link quickly.
> >> Adding Amir to CC.
> > 
> > Or maybe it was Miklos' idea. Hard to keep track of this rolling thread:
> > https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com/
> 
> Thanks for the reference Amir! I even had been in that thread.
> 
> > 
> >>
> >> Our short term plan is to add something like FUSE_NOTIFY_RESTART, which
> >> will iterate over all superblock inodes and mark them with fuse_make_bad.
> >> Any objections against that?

What if you actually /can/ reuse a nodeid after a restart?  Consider
fuse4fs, where the nodeid is the on-disk inode number.  After a restart,
you can reconnect the fuse_inode to the ondisk inode, assuming recovery
didn't delete it, obviously.

I suppose you could just ask for refreshed stat information and either
the server gives it to you and the fuse_inode lives; or the server
returns ENOENT and then we mark it bad.  But I'd have to see code
patches to form a real opinion.

It's very nice of fuse to have implemented revoke() ;)

--D

> > IDK, it seems much more ugly than implementing LOOKUP_HANDLE
> > and I am not sure that LOOKUP_HANDLE is that hard to implement, when
> > comparing to this alternative.
> > 
> > I mean a restartable server is going to be a new implementation anyway, right?
> > So it makes sense to start with a cleaner and more adequate protocol,
> > does it not?
> 
> Definitely, if we agree on the approach on LOOKUP_HANDLE and using it
> for recovery, adding that op seems simple. And reading through the
> thread you had posted above, just the implementation was missing.
> So let's go ahead to do this approach.
> 
> 
> Thanks,
> Bernd
> 
> 
> 


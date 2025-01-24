Return-Path: <linux-fsdevel+bounces-40028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9C9A1B1F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 09:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F68B188F098
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 08:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BD8219A6E;
	Fri, 24 Jan 2025 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBt5czsZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550F1DB134;
	Fri, 24 Jan 2025 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737708787; cv=none; b=V9xCda4drsteLxjsKu/Ykgzsng647JqJkyxT5AV6XgBIohrMPivf8arsnRn/NOV0Jy6snxi3sGxgj++IRSzJVqoAPBDCHj/YY0gJYT0JRRIq28x7bW+RbDL+NO7dqg2dirh/J1J8iZ/YfWSsucGAy80i5jM7+y/5B4nRzjDHq+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737708787; c=relaxed/simple;
	bh=FL0e58rRFCvhM1qtTdMAcpnBPN6srK7m5MmE+mGNm78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDdNHNXIKpbklN+I61lcVbxDa30BVOLtwfuupuOZ50gz/1j8biM9r2sIMQOdYdAqAEVZT6fszQpg4SqtN3uLAJyKC6d7MHIrc2pFnsj3E0V+gyc0K7EvQcCQmOn1M7SBh58GVT6OctCfttVQD6bQjK5eM9+BoL/2njGtx1AY4EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBt5czsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC80C4CED2;
	Fri, 24 Jan 2025 08:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737708787;
	bh=FL0e58rRFCvhM1qtTdMAcpnBPN6srK7m5MmE+mGNm78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sBt5czsZC5Gu/tt0MOFh/hbiIWrj/LK9iaUDON28FjgrthlJVsUyTfwzeJ8qXL65B
	 KbBhKqt3CVTCmbKU5dmUzPwBUvcEORuPpveUITyXFRD6SKJGLD3/zqN0+nNuUQG5TH
	 c1dGNDMW9ThF3yf0/+GTcSZcq5IXnNVgiuMqYziyVWk6yil6SIy+9wxxT/jxe1Ek6B
	 ElLDtgCIymaj2ZfaNIN6THSmVFJ5pAZIG19uqvWuELheF4AZGsqSuUq0xLU0Qxibli
	 OdQhEKu9gCRcuzreQteNdTeOl8NnnqrS2LXB0rOeOgX7ovsrSC90PzOhZyrrAQUxyQ
	 ck3QBvyMssqVw==
Date: Fri, 24 Jan 2025 09:53:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: xfs_repair after data corruption (not caused by xfs, but by
 failing nvme drive)
Message-ID: <20250124-geldkassette-fotowettbewerb-3440f8527f7b@brauner>
References: <20250120-hackbeil-matetee-905d32a04215@brauner>
 <Z5FqAgxiLbqI6gmz@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z5FqAgxiLbqI6gmz@dread.disaster.area>

On Thu, Jan 23, 2025 at 08:58:26AM +1100, Dave Chinner wrote:
> On Mon, Jan 20, 2025 at 04:15:00PM +0100, Christian Brauner wrote:
> > Hey,
> > 
> > so last week I got a nice surprise when my (relatively new) nvme drive
> > decided to tell me to gf myself. I managed to recover by now and get
> > pull requests out and am back in a working state.
> > 
> > I had to reboot and it turned out that my LUKS encrypted xfs filesystem
> > got corrupted. I booted a live image and did a ddrescue to an external
> > drive in the hopes of recovering the things that hadn't been backed up
> > and also I didn't want to have to go and setup my laptop again.
> > 
> > The xfs filesystem was mountable with:
> > 
> > mount -t xfs -o norecovery,ro /dev/mapper/dm4 /mnt
> > 
> > and I was able to copy out everything without a problem.
> > 
> > However, I was curious whether xfs_repair would get me anything and so I
> > tried it (with and without the -L option and with and without the -o
> > force_geometry option).
> > 
> > What was surprising to me is that xfs_repair failed at the first step
> > finding a usable superblock:
> > 
> > > sudo xfs_repair /dev/mapper/dm-sdd4
> > Phase 1 - find and verify superblock...
> > couldn't verify primary superblock - not enough secondary superblocks with matching geometry !!!
> > 
> > attempting to find secondary superblock...
> > ..found candidate secondary superblock...
> > unable to verify superblock, continuing...
> > ....found candidate secondary superblock...
> > unable to verify superblock, continuing...
> 
> Yeah, so it's a 4 AG filesystem so it has 1 primary superblock and 2
> secondary superblocks. Two of the 3 secondary superblocks are trash,
> and repair needs 2 of the secondary superblocks to match the primary
> for it to validate the primary as a good superblock.
> 
> xfs_repair considers this situation as "too far gone to reliably
> repair" and so aborts.
> 
> I did notice a pattern to the corruption, though. while sb 1 is
> trashed, the adjacent sector (agf 1) is perfectly fine. So is agi 1.
> But then agfl 1 is trash. But then the first filesystem block after
> these (a free space btree block) is intact. In the case of sb 3,
> it's just a single sector that is gone.
> 
> To find if there were any other metadata corruptions, I copied the
> primary superblock over the corrupted one in AG 1:
> 
> xfs_db> sb 1
> Superblock has bad magic number 0xa604f4c6. Not an XFS filesystem?
> xfs_db> daddr
> datadev daddr is 246871552
> xfs_db> q
> $ dd if=t.img of=t.img oseek=246871552 bs=512 count=1 conv=notrunc
> ...
> 
> and then ran repair on it again. This time repair ran (after zeroing
> the log) and there were no corruptions other than what I'd expect
> from zeroing the log (e.g. unlinked inode lists were populated,
> some free space mismatches, etc).
> 
> Hence there doesn't appear to be any other metadata corruptions
> outside of the 3 bad sectors already identified. Two of those
> sectors were considered critical by repair, hence it's failure.
> 
> What I suspect happened is that the drive lost the first page that
> data was ever written to - mkfs lays down the AG headers first, so
> there is every chance that the FTL has put them in the same physical
> page. the primary superblock, all the AGI, AGF and AGFL headers get
> rewritten all the time, so the current versions of them will be
> immediately moved to some other page. hence if the original page is
> lost, the contents of those sectors will still be valid. However,
> the superblocks never get rewritten, so only they get lost.
> 
> Journal recovery failed on the AGFL sector in AG 1 that was also
> corrupted - that had been rewritten many times, so it's possible
> that the drive lost multiple flash pages. It is also possible that
> garbage collection had recently relocated the secondary superblocks
> and that AGFL into the same page and that was lost. This is only
> speculation, though.

Thanks for taking the time to look into this!

> 
> That said, Christian, I wouldn't trust any of the recovered data to
> be perfectly intact - there's every chance random files have random

Yes, I think I'm fine with that risk. The data I recovered is strictly
from /home/ so at least I won't have to worry about some system library
being corrupted.

> data corruption in them. Even though the filesystem was recovered,
> it is worth checking the validity of the data as much as you can...

Fwiw, xfs did a great job here. I was very happy how it behaved even
though that drive was shot to hell!


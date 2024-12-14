Return-Path: <linux-fsdevel+bounces-37396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4F29F1B69
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 01:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DAA188EB3D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 00:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412ADD2FF;
	Sat, 14 Dec 2024 00:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDEg2Plc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910677489;
	Sat, 14 Dec 2024 00:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734136977; cv=none; b=iIEk4Q+pfxYJbhWp/nFKBsNEXbF3a4uEbG+D9BFoaeSg1X3Tb+xFIbpU0zL1ZRWt+99zCYFGo265gTXb6C7NVhKpieg9glIUC0PGpZ3MkfHt2SsrP4/PLu+byy/hSJTQc598qpjWmDNLyMSjr6TCL2U5w4hmqdYSEAWJHoFyscI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734136977; c=relaxed/simple;
	bh=RcJB+ksq3j2DHuVJXkt//1T8dmV0rXxp14DpBfSWqlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEl29qMOUxXRGIP/50SqLVe1uifh1oG57ilxqfDGJ/o6fP8l5yTtEo68HofRnf4W8T2jXSTCdCQW3EvPzVrtmS7iC7ux0Xqc1hsVh2PeuZrIXDQhZvIPVRe8ih94OUXOB1Kk8z3TNoH39BmaamypPKyOxmE/6BrBWhvPBEVx2rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDEg2Plc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674A9C4CED0;
	Sat, 14 Dec 2024 00:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734136977;
	bh=RcJB+ksq3j2DHuVJXkt//1T8dmV0rXxp14DpBfSWqlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VDEg2Plc1da22qv5SDbkKeeSjM2kAi2J2gTssmnjAuE7dvEuL3J4ICfxlAtcAbknE
	 ys4hvP6/dzi57yyGMszKgovlDD6ZlNjYlRg/NQuS1ZAvyqvVrYIHEngZRYMD5KVrTT
	 B5KXqDQsHnne/+od3DwUFKuaa0OCYYtE+/swd9b5ShRWm3f7vFvGSrzNKn8u86BJ9O
	 PCC37o7+Q39H/aeH6efs8wArqTVOSdblj/RSHwTEhHwlyiLD3d+sewTk59sV8dX0Eu
	 J1X51puDiI4IdMR8Ss8kUQFoBkeAYpnZP3p2+Vrxh/FXZrwh5J7gAQxWTwQsWI/r+Q
	 JWhQCxH+BWmsQ==
Date: Fri, 13 Dec 2024 16:42:56 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, cem@kernel.org,
	dchinner@redhat.com, ritesh.list@gmail.com,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH v2 0/7] large atomic writes for xfs
Message-ID: <20241214004256.GI6678@frogsfrogsfrogs>
References: <20241210125737.786928-1-john.g.garry@oracle.com>
 <20241213143841.GC16111@lst.de>
 <51f5b96e-0a7e-4a88-9ba2-2d67c7477dfb@oracle.com>
 <20241213172243.GA30046@lst.de>
 <9e119d74-868e-4f60-9ed7-ed782d5433da@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e119d74-868e-4f60-9ed7-ed782d5433da@oracle.com>

On Fri, Dec 13, 2024 at 05:43:09PM +0000, John Garry wrote:
> On 13/12/2024 17:22, Christoph Hellwig wrote:
> > On Fri, Dec 13, 2024 at 05:15:55PM +0000, John Garry wrote:
> > > Sure, so some background is that we are using atomic writes for innodb
> > > MySQL so that we can stop relying on the double-write buffer for crash
> > > protection. MySQL is using an internal 16K page size (so we want 16K atomic
> > > writes).
> > 
> > Make perfect sense so far.
> > 
> > > 
> > > MySQL has what is known as a REDO log - see
> > > https://dev.mysql.com/doc/dev/mysql-server/9.0.1/PAGE_INNODB_REDO_LOG.html
> > > 
> > > Essentially it means that for any data page we write, ahead of time we do a
> > > buffered 512B log update followed by a periodic fsync. I think that such a
> > > thing is common to many apps.
> > 
> > So it's actually using buffered I/O for that and not direct I/O?
> 
> Right
> 
> > >> When we tried just using 16K FS blocksize, we found for low thread
> count
> > > testing that performance was poor - even worse baseline of 4K FS blocksize
> > > and double-write buffer. We put this down to high write latency for REDO
> > > log. As you can imagine, mostly writing 16K for only a 512B update is not
> > > efficient in terms of traffic generated and increased latency (versus 4K FS
> > > block size). At higher thread count, performance was better. We put that
> > > down to bigger log data portions to be written to REDO per FS block write.
> > 
> > So if the redo log uses buffered I/O I can see how that would bloat writes.
> > But then again using buffered I/O for a REDO log seems pretty silly
> > to start with.
> > 
> 
> Yeah, at the low end, it may make sense to do the 512B write via DIO. But
> OTOH sync'ing many redo log FS blocks at once at the high end can be more
> efficient.
> 
> From what I have heard, this was attempted before (using DIO) by some
> vendor, but did not come to much.
> 
> So it seems that we are stuck with this redo log limitation.
> 
> Let me know if you have any other ideas to avoid large atomic writes...

From the description it sounds like the redo log consists of 512b blocks
that describe small changes to the 16k table file pages.  If they're
issuing 16k atomic writes to get each of those 512b redo log records to
disk it's no wonder that cranks up the overhead substantially.  Also,
replaying those tiny updates through the pagecache beats issuing a bunch
of tiny nonlocalized writes.

For the first case I don't know why they need atomic writes -- 512b redo
log records can't be torn because they're single-sector writes.  The
second case might be better done with exchange-range.

--D

> Cheers,
> John
> 
> 


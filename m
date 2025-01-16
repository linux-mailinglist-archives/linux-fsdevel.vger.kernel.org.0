Return-Path: <linux-fsdevel+bounces-39413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6897A13DD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 16:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484253AC9F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 15:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE1522B8CD;
	Thu, 16 Jan 2025 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="BwPEVphx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4E22B8C8
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041828; cv=none; b=Mk0UmBWWCe12e6uBlnooA+kJsaoAF6JNsL6E1nkkfveHkvA1FhdIYDw0rz15qoVrBHORS+f0AG9SaCxNjZzhAG9Av83IDyxI+AIdepARp1X/L+0NhgdYVlgt2NNV55uLmNUKcNj4b0JkNedKWU8p00vsqeMCbo6cqDzjQ+JoFeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041828; c=relaxed/simple;
	bh=t24c0eM8KHh8FGiRorWZ685Ub1GrK6Uip0R3+DvkbWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzAMuk3E8F5xuQ88S0sHL3RhheNlkpdjhlm7oP+2mEPgZbXigyvWAD5v7poRcB2cyyw6r6YVwBm64isnIw8cQBkWNFIzBTeHghJXXqcDepPQmTAy0PNoWiRpgBfVqQ42ymYIKNELgV52X5OtfaKTJfwXZNuutCBF9bwBp7/1g18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=BwPEVphx; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-113.bstnma.fios.verizon.net [108.26.156.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50GFanwH009842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 10:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1737041812; bh=iPKdQs8uflu2Stql2atdadH5H0PtUFQgOadTLW8ZP4o=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=BwPEVphxAoGYgAhF8WUXU3E0mia640CpS+30LLb1S5DqeQQxsDiiP3yGW8mN5eqw5
	 33ZBRGUem6nqLELYJo3FjZJ52yfrMUPM2nmWplOyZ8kWrXj9zd0EvS/akc2yp5wsgr
	 b60nk/qRWsTWGBQAWz5O/ZEfIHM537Hik0opvjJQnzre+KAxE+ZjPirW7+X7Wo3tz+
	 va5bpfTa7wH4K8rklNuRNPo1S7W0v2vrlxciKOx8SyQrSulYr3uJ16SkLSM0+BV88k
	 hCG5VTCdIpAMU4iHc81ZOLBXQiy98wjmodh+9HauI1mGbTMb6lthbzGZx98ufb04gU
	 jT7W8VcThqqdQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id D212F15C0108; Thu, 16 Jan 2025 10:36:49 -0500 (EST)
Date: Thu, 16 Jan 2025 10:36:49 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>,
        Anna Schumaker <anna.schumaker@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Implementing the NFS v4.2 WRITE_SAME
 operation: VFS or NFS ioctl() ?
Message-ID: <20250116153649.GC2446278@mit.edu>
References: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>
 <Z4bv8FkvCn9zwgH0@dread.disaster.area>
 <Z4icRdIpG4v64QDR@infradead.org>
 <20250116133701.GB2446278@mit.edu>
 <21c7789f-2d59-42ce-8fcc-fd4c08bcb06f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21c7789f-2d59-42ce-8fcc-fd4c08bcb06f@oracle.com>

On Thu, Jan 16, 2025 at 08:59:19AM -0500, Chuck Lever wrote:
> 
> See my previous reply in this thread: WRITE_SAME has a long-standing
> existing use case in the database world. The NFSv4.2 WRITE_SAME
> operation was designed around this use case.
> 
> You remember database workloads, right? ;-)

My understanding is that the database use case maps onto BLKZEROOUT
--- specifically, databases want to be able to extend a tablespace
file, and what they want to be able to do is to allocate a contiguous
range using fallocate(2), but then want to make sure that the blocks
in the block are marked as initialized so that future writes to the
file do not require metadata updates when fsync(2) is called.
Enterprise databases like Oracle and db2 have been doing this for
decades; and just in the past two months recently I've had
representatives from certain open source databases ask for something
like the FALLOC_FL_WRITE_ZEROES.

So yes, I'm very much aware of database workloads --- but all they
need is to write zeros to mark a file range that was freshly allocated
using fallocate to be initialized.  They do not need the more
expansive features which as defined by the SCSI or NFSv4.2.  All of
the use cases done by enterprise Oracle, db2, and various open source
databases which have approached me are typically allocating a chunk
of aligned space (say, 32MiB) and then they want to initalize this
range of blocks.

This then doesn't require poison sentinals, since it's strictly
speaking an optimization.  The extent tree doesn't get marked as
initalized until the zero-write has been commited to the block device
via a CACHE FLUSH.  If we crash before this happens, reads from the
file will get zeros, and writes to the blocks that didn't get
initialized will still work, but the fsync(2) might trigger a
filesystem-level journal commit.  This isn't a disaster....

Now, there might be some database that needs something more
complicated, but I'm not aware of them.  If you know of any, is that
something that you are able to share?

Cheers,

					- Ted


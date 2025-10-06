Return-Path: <linux-fsdevel+bounces-63451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5148ABBCFD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 04:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401FA1893C2F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 02:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71C31C5D55;
	Mon,  6 Oct 2025 02:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Y6mGpBUB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEEE1A0728
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 02:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759717012; cv=none; b=Cfr7PwlZsd6xot24eH/yEsbAypCidvazCdDlOehVayihm0ncGg5Cqg6hXk8Q/TXM9hYZNCGTZVVxn+2CcVVFyfKWV1uFMjYptnkf3Ym3Q0g0WGB657QPVZepA3rHsD5aQrdEd5ZoIs1JyBlqw+iYZwyHvT2MeMJaE+KYPBLz6vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759717012; c=relaxed/simple;
	bh=bLf2PSDbd1Byjlxpi5JzlbRsOEawOHN3S2WcjzBwruo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlkNmMJWsuWLoJ6w5TdckcZDbyBwdHpJi52/NMSyUWtGw+LjUVPl9EC/KZ/6Q8RZEHIlM4HKGooaFOiXJQEA58id+Cr2Yb02u4QL0iZmApECvzPJIwuTCEIceRDQLbog92vC3iBpgNf2wmVENejIiu7W3n6seOxqAWdtDYGw+sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Y6mGpBUB; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-229.bstnma.fios.verizon.net [173.48.112.229])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5962GWpE010511
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 5 Oct 2025 22:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1759716995; bh=OWFEEQYm5h8XADMkvErW/V6zMXyzYfkjgcksdY3kPUU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Y6mGpBUB8bT0tSIT8Qqpb9kJ9Ck6NU4lzpaVc+FzHS4z+q/toO3m/dFi48+RgyrJx
	 POHXIoEt9wsMbIEBuUv+oXKrj9bGp3E9Hbh2qqv7Q6ZbjxrNE0uzEmuEhlnwQsYf8l
	 qAoV8aiQYuqtJnkuP6WNQF4UxuNcI2i1Sl3sEMwRBpc9pefuU9B5NxUJtwiAfw9tN9
	 WyiTsfCOUTL4LvPNCWa2UZfj7Krtb0FVtpyqiooWaznaK/k2UujiBUH2vxUU7gMT+q
	 5lEcpKJXOlsmr7tOzZ8HM9lfuD5whnbXuEFC7A7+631jjmo2oX0b/ubODlrUn7SWO6
	 cAiGSYAQpERSw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 677412E00D9; Sun, 05 Oct 2025 22:16:32 -0400 (EDT)
Date: Sun, 5 Oct 2025 22:16:32 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Pavel Emelyanov <xemul@scylladb.com>, linux-fsdevel@vger.kernel.org,
        "Raphael S . Carvalho" <raphaelsc@scylladb.com>,
        linux-api@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] fs: Propagate FMODE_NOCMTIME flag to user-facing
 O_NOCMTIME
Message-ID: <20251006021632.GI386127@mit.edu>
References: <20251003093213.52624-1-xemul@scylladb.com>
 <aOCiCkFUOBWV_1yY@infradead.org>
 <aOMBbKUlvv2uYLzD@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOMBbKUlvv2uYLzD@dread.disaster.area>

On Mon, Oct 06, 2025 at 10:38:20AM +1100, Dave Chinner wrote:
> We have already provided a safe method for minimising the overhead
> of c/mtime updates in the IO path - it's called lazytime.  The
> lazytime mount option provides eventual consistency for c/mtime
> updates for IO operations instead of immediate consistency.
> 
> Timestamps are still updated to have the correct values, but the
> latency/performance of the timestamp updates is greatly improved by
> holding them purely in memory until some other trigger forces them
> to be persisted to disk.

Specifically, the timestamps are persisted to stable store when (a)
the file system is unmounted, (b) when the inode needs to be pushed
out to memory due to memory pressure, (c) when the inode is forcibly
persisted using fsync(), (d) when some other inode field is updated,
and the inode gets written out, or (e) after 24 hours.

As a result, the on-disk timestamps will be at most 24 hours stale.
But this is POSIX compliant, because if you read the timestamps using
stat(1), you will get the updated values, and what happens after a
crash in the absense of an fsync(2) is not defined.

The reason why we implemented this at $WORK is you are constantly
updating a database using fdatasync(2), and you care about 99.9
percentage I/O latency, the 4k writes to the inode table will
eventually triger a hard drive's Adjacent Track Interference (ATI)
mitigation, which involves rewriting set of disk tracks to avoid the
analog signal for adjacent tracks getting weakened by the hot-spot
writes, and this is measurable if you are looking at long-tail I/O
latencies.  (And yes, we had to talk to our HDD vendors to figure out
this is what was going on, since performance is out of scop[e of
SCSI/SATA specifications.  Hence, random long-tail ATI latencies to
preserve data integrity is allowed, and in fact, actually a good
thing.  :-)

					- Ted


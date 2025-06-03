Return-Path: <linux-fsdevel+bounces-50412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91240ACBF58
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 06:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F543188B5C9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 04:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917DC1F1524;
	Tue,  3 Jun 2025 04:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CR2ZpW4J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD82F2D;
	Tue,  3 Jun 2025 04:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748926206; cv=none; b=aXRnUoPQPnr82JTM9OqsQKwbdj3o/TDJzP7vK8kkcBUCUHHV+2Qtz9zzS0B+rBwR1JnaPyJR7MCOiN7QLmUs1QIkpPIYe3pUYPyD97NEOYHMSjEGZYgrBzVIyeSx4XSCejS14HRO+Fd4+TeU9kmnivfVhPLSleejNAyL+npA+rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748926206; c=relaxed/simple;
	bh=3aQP4cVOXn4BZRakpLih4t7hE3enQFEXZnnf1lO+fek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXg3JzxjXUtr/S2eZmxBmq6AestiJjhieL5eY664/qPq9DdCWYXhpbu/20C1oIFj84Fov8uJOKmiV42AgoHqvMq/riOBo9p8U4UyiHIJ8b2uqLtx+Q1dk9yk2vyVLWhminCLHNHLhVxCyLP1WPo0cVaNNP5KbEHdiypFVNDr5aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CR2ZpW4J; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eARmH9Rn306+PBP02fqjqI67S938hpTq6nRX+WXqcD4=; b=CR2ZpW4JA0X6L3PCAryW7hZ8ZU
	rWCHceDqHyr+q9KnIFftL3mrRP1nged2fbqewgkK65H64l03DglOHIDqYtdrB3hEblIavRoUu1wn6
	5mXcdzaAVITfSdNvd0OwMOeyOyiA9T3ieA8nwMoCaveDQa6Az/jAXnlTp085P0EA9xmmTwjqP5PaD
	7wKs6aoYmfK273/dG87ADJI9C45Y4jHhwzjjJmVUitdrqS8c9UxwOhYWLlJXYK11gHuLcOwRbXAQX
	t+muMp4aaPB5BnC9maNWM6eyqWWOezqGNIPyoYLKUEkUgpYqwpgtg3kcQd2KJx71RlHJ5bY3WY5RI
	tBQwR98g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMJbA-00000009ias-0W2a;
	Tue, 03 Jun 2025 04:50:04 +0000
Date: Mon, 2 Jun 2025 21:50:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	cem@kernel.org, linux-xfs@vger.kernel.org,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
Message-ID: <aD5-_OOsKyX0rDDO@infradead.org>
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <aDfkTiTNH1UPKvC7@dread.disaster.area>
 <aD04v9dczhgGxS3K@infradead.org>
 <aD4xboH2mM1ONhB-@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD4xboH2mM1ONhB-@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 03, 2025 at 09:19:10AM +1000, Dave Chinner wrote:
> > In other words, write errors in Linux are in general expected to be
> > persistent, modulo explicit failfast requests like REQ_NOWAIT.
> 
> Say what? the blk_errors array defines multiple block layer errors
> that are transient in nature - stuff like ENOSPC, ETIMEDOUT, EILSEQ,
> ENOLINK, EBUSY - all indicate a transient, retryable error occurred
> somewhere in the block/storage layers.

Let's use the block layer codes reported all the way up to the file
systems and their descriptions instead of the errnos they are
mapped to for compatibility.  The above would be in order:

[BLK_STS_NOSPC]         = { -ENOSPC,    "critical space allocation" },
[BLK_STS_TIMEOUT]       = { -ETIMEDOUT, "timeout" },
[BLK_STS_PROTECTION]    = { -EILSEQ,    "protection" },
[BLK_STS_TRANSPORT]     = { -ENOLINK,   "recoverable transport" },
[BLK_STS_DEV_RESOURCE]  = { -EBUSY,     "device resource" },

> What is permanent about dm-thinp returning ENOSPC to a write
> request? Once the pool has been GC'd to free up space or expanded,
> the ENOSPC error goes away.

Everything.  ENOSPC means there is no space.  There might be space in
the non-determinant future, but if the layer just needs to GC it must
not report the error.

u

> What is permanent about an IO failing with EILSEQ because a t10
> checksum failed due to a random bit error detected between the HBA
> and the storage device? Retry the IO, and it goes through just fine
> without any failures.

Normally it means your checksum was wrong.  If you have bit errors
in the cable they will show up again, maybe not on the next I/O
but soon.

> These transient error types typically only need a write retry after
> some time period to resolve, and that's what XFS does by default.
> What makes these sorts of errors persistent in the linux block layer
> and hence requiring an immediate filesystem shutdown and complete
> denial of service to the storage?
> 
> I ask this seriously, because you are effectively saying the linux
> storage stack now doesn't behave the same as the model we've been
> using for decades. What has changed, and when did it change?

Hey, you can retry.  You're unlikely to improve the situation though
but instead just keep deferring the inevitable shutdown.

> > Which also leaves me a bit puzzled what the XFS metadata retries are
> > actually trying to solve, especially without even having a corresponding
> > data I/O version.
> 
> It's always been for preventing immediate filesystem shutdown when
> spurious transient IO errors occur below XFS. Data IO errors don't
> cause filesystem shutdowns - errors get propagated to the
> application - so there isn't a full system DOS potential for
> incorrect classification of data IO errors...

Except as we see in this thread for a fairly common use case (buffered
I/O without fsync) they don't.  And I agree with you that this is not
how you write applications that care about data integrity - but the
entire reset of the system and just about every common utility is
written that way.

And even applications that fsync won't see you fancy error code.  The
only thing stored in the address_space for fsync to catch is EIO and
ENOSPC.


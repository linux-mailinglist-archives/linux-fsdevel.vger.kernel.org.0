Return-Path: <linux-fsdevel+bounces-7425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450F5824A22
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 22:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D389F285B4F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 21:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA43D2C6AE;
	Thu,  4 Jan 2024 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ty799Qn8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A032C698;
	Thu,  4 Jan 2024 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=p5F8u3xrKU8ESZxmcg8jQ8IAjNp1yE/fjU1J5AXQvGQ=; b=ty799Qn8Fd+rytCk14M0ZVq25I
	YiBoR7XxLbFmlNS85l+O0gooTrHaDk5fhLePvNU0dGp4e1aMmTnss9STQyHl1VejW4/57v7YeIMBT
	ZP9rfvynFQ/IN6FqUpfPmxtyPBqFFxwyJMh/iOFqQYxJdTTEz1eSljsz03RUgd9NPFc9D695RfHwk
	+08zzTszFt8/e9TS1tjVeg0a9Dg7clSrdazeYNx0BSMUnh50XbIuN4hkn2wwogAacauBJO2ucG1rP
	JnlzoMgHsQUMwe3gYgnlXHjcmHCDNYpPswNwzduYNn/s2OLszGXp84YD0ABSGA9UbbP+tu1yvCFeQ
	WLAfi1sQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rLV5Y-00G1t1-Vo; Thu, 04 Jan 2024 21:17:17 +0000
Date: Thu, 4 Jan 2024 21:17:16 +0000
From: Matthew Wilcox <willy@infradead.org>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Message-ID: <ZZcgXI46AinlcBDP@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is primarily a _FILESYSTEM_ track topic.  All the work has already
been done on the MM side; the FS people need to do their part.  It could
be a joint session, but I'm not sure there's much for the MM people
to say.

There are situations where we need to allocate memory, but cannot call
into the filesystem to free memory.  Generally this is because we're
holding a lock or we've started a transaction, and attempting to write
out dirty folios to reclaim memory would result in a deadlock.

The old way to solve this problem is to specify GFP_NOFS when allocating
memory.  This conveys little information about what is being protected
against, and so it is hard to know when it might be safe to remove.
It's also a reflex -- many filesystem authors use GFP_NOFS by default
even when they could use GFP_KERNEL because there's no risk of deadlock.

The new way is to use the scoped APIs -- memalloc_nofs_save() and
memalloc_nofs_restore().  These should be called when we start a
transaction or take a lock that would cause a GFP_KERNEL allocation to
deadlock.  Then just use GFP_KERNEL as normal.  The memory allocators
can see the nofs situation is in effect and will not call back into
the filesystem.

This results in better code within your filesystem as you don't need to
pass around gfp flags as much, and can lead to better performance from
the memory allocators as GFP_NOFS will not be used unnecessarily.

The memalloc_nofs APIs were introduced in May 2017, but we still have
over 1000 uses of GFP_NOFS in fs/ today (and 200 outside fs/, which is
really sad).  This session is for filesystem developers to talk about
what they need to do to fix up their own filesystem, or share stories
about how they made their filesystem better by adopting the new APIs.

My interest in this is that I'd like to get rid of the FGP_NOFS flag.
It'd also be good to get rid of the __GFP_FS flag since there's always
demand for more GFP flags.  I have a git branch with some work in this
area, so there's a certain amount of conference-driven development going
on here too.

We could mutatis mutandi for GFP_NOIO, memalloc_noio_save/restore,
__GFP_IO, etc, so maybe the block people are also interested.  I haven't
looked into that in any detail though.  I guess we'll see what interest
this topic gains.


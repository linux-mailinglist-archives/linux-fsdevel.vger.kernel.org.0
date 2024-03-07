Return-Path: <linux-fsdevel+bounces-13917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C848757AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 20:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AFF02865CE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 19:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CD31350D6;
	Thu,  7 Mar 2024 19:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FAceBK/T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A031332B3;
	Thu,  7 Mar 2024 19:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841306; cv=none; b=WD9CnEtD+hU3H1xEUxbRbH2QNqMpjqsTUHsOVFR01hBvlYqdZWzkqxnvUEIgVc44RMAqRSyzsVMnRuFMcwVM57jc1E/aBkS8nTjQGvq0BdMH0jw7cgcIyXcil6GA/eIHUW6VWiHGB6wsEDjL+pZ/drzmf068I5rMPlpN7FRYM7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841306; c=relaxed/simple;
	bh=5MEqqGRgQWE/Yasm8wtzZiD02wvptqCi6srcepNdiPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F0YzIlYCHTcokzU/flkkqaqVQDqxF9s9AyapLX2k6CEQs2WkIyqUainkXxfFxMzJqBNLnW9sk0iLuTCwlp0Ysh3MFZcjP2FF351E8LHBd/RQyirKsn3pLScld8XKxj/rZHhvInPNR5K97qgYmEOU51hgDHwlhe9u4I/OIa/pAeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FAceBK/T; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=KdUReECK6yv0klISswefryC4t0TYivcyEoL0v9VbHEU=; b=FAceBK/T3lPG7e+iEGAKxd7y1n
	f2QMqtkU+L88JedyHGlknWz1uqCutT25vzgUABf8TfbN38V9fnlh50CXWsUDETOSxPuXEd1UxEGUO
	imV7okghXJkze5eToVih5lELudzQzoeubS5FW9VS+a3NPkPM1xx17KB04OPT5mRGCQS4DMgwvB54h
	rTgVkkymtvqbZANHMhLJ7YsRIWlzArh0pVZVRHxpW/HT3SjHOhcfDRh7vj2zu8cCtlTgOBca2JDWs
	NG9xmCY/C394KeENak12lGdv3L1eeuQ131O9D0veP/HIWg034Hlq7lFTjnahm+yMkJjXL7n/aVR5p
	E3VtKD/A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riJpV-00000009r4y-3s3b;
	Thu, 07 Mar 2024 19:55:01 +0000
Date: Thu, 7 Mar 2024 19:55:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: On the optimum size of a batch
Message-ID: <Zeoble0xJQYEAriE@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've had a few conversations recently about how many objects should be
in a batch in some disparate contextx, so I thought I'd write down my
opinion so I can refer to it in future.  TLDR: Start your batch size
around 10, adjust the batch size when measurements tell you to change it.

In this model, let's look at the cost of allocating N objects from an
allocator.  Assume there's a fixed cost, say 4 (units are not relevant
here) for going into the allocator and then there's a 1 unit cost per
object (eg we're taking a spinlock, pulling N objects out of the data
structure and releasing the spinlock again).

Allocating 100 * 1 objects would cost 500 units.  Our best case is that
we could save 396 units by allocating a batch of 100.  But we probably
don't know how many objects we're going to need to allocate, so we pull
objects from the allocator in smaller batches.  Here's a table showing
the costs for different batch sizes:

Batch size      Cost of allocating 100          thousand        million
1               500 (5 * 100)                   5000            5M
2               300 (6 * 50)                    3000            3M
4               200 (8 * 25)                    2000            2M
8               156 (12 * 13)                   1500            1.5M
16              140 (20 * 7)                    1260            1.25M
32              144 (36 * 4)                    1152            1.13M
64              136 (68 * 2)                    1088            1.06M
128             132 (132 * 1)                   1056            1.03M

You can see the knee of this curve is around 8.  It fluctuates a bit after
that depending on how many "left over" objects we have after allocating
the 100 it turned out that we needed.  Even if we think we're going to
be dealing with a _lot_ of objects (the thousand and million column),
we've got most of the advantage by the time we get to 8 (eg a reduction
of 3.5M from a total possible reduction of 4M), and while I wouldn't
sneeze at getting a few more percentage points of overhead reduction,
we're scrabbling at the margins now, not getting big wins.

This is a simple model for only one situation.  If we have a locking
contention breakdown, the overhead cost might be much higher than 4 units,
and that would lead us to a larger batch size.

Another consideration is how much of each object we have to touch.
put_pages_list() is frequently called with batches of 500 pages.  In order
to free a folio, we have to manipulate its contents, so touching at least
one cacheline per object.  And we make multiple passes over the batch,
first decrementing the refcount, removing it from the lru list; second
uncharging the folios from the memcg (writes to folio->memcg_data);
third calling free_pages_prepare which, eg, sets ->mapping to NULL;
fourth putting the folio on the pcp list (writing to the list_head).

With 500 folios on the list, that uses 500 * 64 bytes of cache which
just barely fits into the L1 cache of a modern laptop CPU (never mind
whatever else we might want to have in the L1).  Capping the batch size
at 15 (as my recent patches do) uses only 1kB of L1, which is a much
more reasonable amount of cache to take up.  We can be pretty sure the
first one is still in it when the last one has finished being processed.


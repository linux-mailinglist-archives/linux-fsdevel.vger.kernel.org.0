Return-Path: <linux-fsdevel+bounces-58237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A204B2B74F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 04:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B62189F5F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 02:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5D629E0FF;
	Tue, 19 Aug 2025 02:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="me7CRAgI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA6415667D;
	Tue, 19 Aug 2025 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755571853; cv=none; b=ixXoju2sp1IVhFX0g034fnQ+5wYY3TtPGPZSx2QcH6bO4Sx8P4olx/3KW47BTWJAH6xcgy2T3KjTHlo+VaqRyK6GcGp82rAwF2kyL5ccJrd6iMrZ7OPj3VHEvDcJEbecaJAlJpTL4FEDzCiJmldhLf+clT1gn9BJyHD6uTCRAqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755571853; c=relaxed/simple;
	bh=0q4Sc2MWA6II6epWUUzkImee40kAZkvMQXrAXzWXzPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pi61lY2u9AdJ6M2Z/3phJGh2nBUYRM6qz2RfApU79EJMnB/UzLl7Ttqq/mfMhk7VJ2R5Rg/fr+0eYFiS709r2sfwsK/CX+5nVrMZKgQrZ+Nfcbz1+/A/J3Y2EmnLRI9FQoWuJ3NfzduvHDUM2qewq51diLM1tKPGvnUIBpmbH6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=me7CRAgI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/gNl5UMTbOEoKpJ5CDqWNUpbWwrnu+YVi+0gNZI2EBM=; b=me7CRAgIMphqXVElePHnpdxF3/
	CkZT/+pEf8QMTK7z7b/52AbVyTENK/3LfZAsQjSbECcluP0aSgcQyUYYnxvpccuKWGFVDdQCuGgiN
	CetMk3HG/k0ucOYmXKqsETGV8ndvr1+wYFLiedep5gYB8PvCM0iPAC/Sgh0Q5AbZP6tonhDbrAHNj
	mlJiMevsXi6vlHr/HUBO1yaiBGmi73qJbkLLN3mA70a9E7EOlP2OOOWBabos+SvJu11CXxX/4IL7Y
	CW6rMIz00mAKo/tIZ4gCbh+C9+EevzUlDou4gH7xIwYKe4ddWXjr6aiBRNyqOiyor3MGDanXJuXth
	hNG9h5GQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoCR0-0000000F3wS-00PC;
	Tue, 19 Aug 2025 02:50:50 +0000
Date: Tue, 19 Aug 2025 03:50:49 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Boris Burkov <boris@bur.io>
Cc: akpm@linux-foundation.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com, shakeel.butt@linux.dev, wqu@suse.com,
	mhocko@kernel.org, muchun.song@linux.dev, roman.gushchin@linux.dev,
	hannes@cmpxchg.org
Subject: Re: [PATCH v3 2/4] mm: add vmstat for cgroup uncharged pages
Message-ID: <aKPmiWAwDPNdNBUA@casper.infradead.org>
References: <cover.1755562487.git.boris@bur.io>
 <04b3a5c9944d79072d752c85dac1294ca9bee183.1755562487.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04b3a5c9944d79072d752c85dac1294ca9bee183.1755562487.git.boris@bur.io>

On Mon, Aug 18, 2025 at 05:36:54PM -0700, Boris Burkov wrote:
> Uncharged pages are tricky to track by their essential "uncharged"
> nature. To maintain good accounting, introduce a vmstat counter tracking
> all uncharged pages. Since this is only meaningful when cgroups are
> configured, only expose the counter when CONFIG_MEMCG is set.

I don't understand why this is needed.  Maybe Shakeel had better
reasoning that wasn't captured in the commit message.

If they're unaccounted, then you can get a good estimate of them
just by subtracting the number of accounted pages from the number of
file pages.  Sure there's a small race between the two numbers being
updated, so you migth be off by a bit.


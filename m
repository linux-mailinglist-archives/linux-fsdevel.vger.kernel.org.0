Return-Path: <linux-fsdevel+bounces-58387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42323B2DD99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 15:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399FC1C80AA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 13:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD4B31CA68;
	Wed, 20 Aug 2025 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MxDKVRCi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353E327BF99;
	Wed, 20 Aug 2025 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755695970; cv=none; b=bLkGfkHbShX5NbkzIym83cG6IONI1KswWnrVbeoUW7tZc3gev1uBLYzF3O0aX1L39gpIKIrsnwu4s12pv7Mv5y35sfqHBT5dQlEbO6ilWcjW34HhERcpnnnyFxLvHuJCnucG/tNmeauNIzA92XvaIbDnQGdmkh7WCaESjyYmBis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755695970; c=relaxed/simple;
	bh=H54lFfaLHCN+ofvzv859ScHjwUJrYa8gSwr0xBMg1X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2MI8kPk039FUABk/lkyyhvKJMT0Zbpuo/ZAjBoXs2iNZT6OIc1Xu4Oy9s3S1Wa31yVdC1hE9f6bt3z1COIYL/h0Dy+89LN/Bg9eu3CbJ5vUGy/BJ7j9FDBLjM+cXqiE2NWr4Bia1Ccci0iKNn1mokgDaGcsA6tXYATRToqn31c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MxDKVRCi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/Rf1gRvfsQcsfD3pWbw3tEq8WPxbn5ncB2F5gE38IRc=; b=MxDKVRCiAxCdKxMNwjP7qRKHEu
	Tjs+AegVgBtZ3NoDzVBCPmIdeNfzc65MHMoiz7gNjJHVktqIm/JezxB/RFkKwc+PQBV8Ni90ia+t0
	NkvOdBJx7WOeUsJLk3pTyyM+CWKyzkQ9uNhb7rZq1DeT7XbSTrOw0w6D1Xdh0QYeA2DPrXyW4J0Se
	zHjFOHzPAny6IsoT2wUP/sX/tKGvYr+o7STD7b3cylwyn8q8QdFxAmb4El2WMnXfYZX2jS8d9JnJa
	h01FBXB7akxZE/hu676Kp9Xi6QQRkBKrQCijkHXaAin8JWKRsH8/NNKYQKKChJ1EY9IF/Kb5mI2kD
	k8637daQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoiiq-00000006rUZ-453Y;
	Wed, 20 Aug 2025 13:19:25 +0000
Date: Wed, 20 Aug 2025 14:19:24 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Boris Burkov <boris@bur.io>, akpm@linux-foundation.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, kernel-team@fb.com, wqu@suse.com,
	mhocko@kernel.org, muchun.song@linux.dev, roman.gushchin@linux.dev,
	hannes@cmpxchg.org
Subject: Re: [PATCH v3 2/4] mm: add vmstat for cgroup uncharged pages
Message-ID: <aKXLXJw7m-TSkZOI@casper.infradead.org>
References: <cover.1755562487.git.boris@bur.io>
 <04b3a5c9944d79072d752c85dac1294ca9bee183.1755562487.git.boris@bur.io>
 <aKPmiWAwDPNdNBUA@casper.infradead.org>
 <tw5qydmgv35v63lhqgl7zbjmgwxm2cujqdjq3deicdz2k26ymh@mnxhz43e6jwl>
 <aKUM49I-4D24MmwZ@casper.infradead.org>
 <i4hg4g75ywbera643uhtshkj6xrriqi4mi5dg3oga5os3tp6m5@u2dcv2snbiqs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i4hg4g75ywbera643uhtshkj6xrriqi4mi5dg3oga5os3tp6m5@u2dcv2snbiqs>

On Tue, Aug 19, 2025 at 06:25:36PM -0700, Shakeel Butt wrote:
> On Wed, Aug 20, 2025 at 12:46:43AM +0100, Matthew Wilcox wrote:
> > OK, but couldn't we make that argument for anything else?  Like slab,
> > say.  Why's "file" memory different?
> 
> Good point and I think it does apply to other memory types too. I would
> call "file" memory to be more important as it is one of the largest
> consumer of DRAM on, at least, Meta infra. Slab needs a bit more thought.
> At the system level (i.e. /proc/meminfo), we account at the page (or
> slab) level while for memcg, we account per-object (plus obj_cgroup
> pointer).

That was supposed to be a reductio ad absurdum, not an invitation to
add more counters.

Look, if this is information you really need, I think you should come
up with a better way of collecting it than by adding new counters and
new complexity to everything involved in GFP_ACCOUNT activities.

The unaccounted address_spaces are a very tiny percentage of file
memory, at least as far as this patch set goes.  I don't think this
patch is justifiable on its face.


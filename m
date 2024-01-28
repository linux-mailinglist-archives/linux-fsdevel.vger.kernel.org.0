Return-Path: <linux-fsdevel+bounces-9262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2E383FA3F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 23:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E658B21B46
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 22:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3CE3D393;
	Sun, 28 Jan 2024 22:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X1k8QQ5p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12B83CF44;
	Sun, 28 Jan 2024 22:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706479374; cv=none; b=jVPeuUFSoiu3UdkZkiJOcfWbtn5O3ylE6kiUaaLoaMw+gwApuyndZ2t0eD9r8/qmMdpKfTBbBge4Axy4FSB52/aouNZ9JwJikWWHkLfGwP/4nmbO+YfATdg9tAWQiTIUSlqg281/itUBPqZgsvMTSmyOchLEfecSQQL4npYpRJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706479374; c=relaxed/simple;
	bh=5C4J0Ao+ZJ0LzdgubJzD/RjoPDpCc0XCOKB+k/bVZG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SO6AdjCfZo2c1fj4hABa+XjkJ/MoSpk4Q8zFfInK3AaXJsq1yJEoRw3DP4RSR6BHSGgzaHXgjsbTYIC+1WXJ0ps9KJRi9R86Rbgh5Xk5NoOSwLT7pPQWdOrb614AyCNsO1itlKJkKQ2imnETyw61kHJTNPcWpj/2ggI4cSZy2TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X1k8QQ5p; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y7owlhmhi2gAoXU/UeiIuxV6mq5IG8XVGr21uGp5/40=; b=X1k8QQ5pXWWbzG7O67QZFKgivf
	fC4g/yiD/pw9sbIud887+AHkhsj549Vtg9KNot/nBjV/HBtKG7yyvZKb4qzLdYyBXeX1FVqwTzk5+
	OLVa4cfZYnxTiitLTIbnFTGWY5XD23C/3DYNAvZcKrbGDzeSypq9QHkgVFmnIaRz/WlR9AjqzBpwO
	JnwOEI14KUxGFsDAfQpYKajyh/iBrk6vy5fMzpPgSAMsohdV4ZgxYgd7RCPoxjUZf8Q9uetdVPZw0
	Awbmxv1kdTiw9EuDqww/jOSeysk0rC+is0rNAaqXlEbxxaSqAczD9GbtHGIz9RORFmZWehVOoB2TE
	+MRe/u2w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUDEn-00000004g71-0xeS;
	Sun, 28 Jan 2024 22:02:49 +0000
Date: Sun, 28 Jan 2024 22:02:49 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
	Don Dutile <ddutile@redhat.com>,
	Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] mm/readahead: readahead aggressively if read drops
 in willneed range
Message-ID: <ZbbPCQZdazF7s0_b@casper.infradead.org>
References: <20240128142522.1524741-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128142522.1524741-1-ming.lei@redhat.com>

On Sun, Jan 28, 2024 at 10:25:22PM +0800, Ming Lei wrote:
> Since commit 6d2be915e589 ("mm/readahead.c: fix readahead failure for
> memoryless NUMA nodes and limit readahead max_pages"), ADV_WILLNEED
> only tries to readahead 512 pages, and the remained part in the advised
> range fallback on normal readahead.

Does the MAINTAINERS file mean nothing any more?

> If bdi->ra_pages is set as small, readahead will perform not efficient
> enough. Increasing read ahead may not be an option since workload may
> have mixed random and sequential I/O.

I thik there needs to be a lot more explanation than this about what's
going on before we jump to "And therefore this patch is the right
answer".

> @@ -972,6 +974,7 @@ struct file_ra_state {
>  	unsigned int ra_pages;
>  	unsigned int mmap_miss;
>  	loff_t prev_pos;
> +	struct maple_tree *need_mt;

No.  Embed the struct maple tree.  Don't allocate it.  What made you
think this was the right approach?



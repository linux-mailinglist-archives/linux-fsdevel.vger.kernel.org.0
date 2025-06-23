Return-Path: <linux-fsdevel+bounces-52545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ECCAE403C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591B83BFAFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095E62459D2;
	Mon, 23 Jun 2025 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LnNB/HnR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5114123C4F3;
	Mon, 23 Jun 2025 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750681397; cv=none; b=iAbAPJXFa/k1OUU2YqgNeM1Y2THe4mI33Ym5Q4Ku3emPI6YIGOk4Ojpq2SQeRoVRSKD5SB3uuLJU3ojNKyjPIKDD5SNMKVliN7KAd9AyVxTpE3VJPzz/yaKpdk7AHw9tEGhnOe78vAwcoWnBhzDX/YtRWDBO6UzXA2JgdSIQ+g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750681397; c=relaxed/simple;
	bh=spx48TxfkANdTm+YuFHey2z5P4yfowIJjITuirl3kDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mt/++Q8JJObIt6YI2zs5Dq8dkfVi7SawCunAg1PsnQkc+GyPi44Lr+9OgpUaSn9SurgkW4lHIHvlMwQ7dnad/bqcyO3CcSb9V1cVm1+jB2b6db+RkE0jeLGxL+fmP8CWAPPd7JZ3ulcyDiTs7ElH0PkI4jUfhIxHWrJDY9b9slE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LnNB/HnR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3oCr8/2E/ECUGMdCQG5uK2s/rAaWdb4SF8d9yHw1SGc=; b=LnNB/HnRw1ZuK8fdt8rSMJ2ZYs
	q+mW5oayHUBd2qfRNZL5j0uUh9ko/ejIS840XHJrbvp0XXsnPshvxo22sJ2/tdoYi6ERn4uQPoids
	wWMoD9y+CL3Eubvm4JTJtsfBUMB3K5F7LRxS8wdG6bSZK4z6byuJQYa85lbqNFDJRZj4Ia/+OYd8d
	9ipCORuobaKsyF0cXHA8WHbUY6oPA7b/XkqQtx4BeOji44BWo4jJcuXOvV5cy7UrNymptQgKKmQ04
	nj/lr96lizIJt52vWyInxpNXHVuHv8TrB4k/r+WH2R08hi5XIz+wWuYWais41pGsOlRtF3aaeYV3n
	Lx7l0xHw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTgCR-00000003OC9-0JQF;
	Mon, 23 Jun 2025 12:22:59 +0000
Date: Mon, 23 Jun 2025 13:22:58 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Shivank Garg <shivankg@amd.com>
Cc: kent.overstreet@linux.dev, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, xiang@kernel.org, chao@kernel.org,
	jaegeuk@kernel.org, akpm@linux-foundation.org, david@redhat.com,
	vbabka@suse.cz, zbestahu@gmail.com, jefflexu@linux.alibaba.com,
	dhavale@google.com, lihongbo22@huawei.com, pankaj.gupta@amd.com,
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH V2 1/2] mm/filemap: Add NUMA mempolicy support to
 filemap_alloc_folio()
Message-ID: <aFlHIjLBwn3LQFMC@casper.infradead.org>
References: <20250623093939.1323623-4-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623093939.1323623-4-shivankg@amd.com>

On Mon, Jun 23, 2025 at 09:39:41AM +0000, Shivank Garg wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Add a mempolicy parameter to filemap_alloc_folio() to enable NUMA-aware
> page cache allocations. This will be used by upcoming changes to
> support NUMA policies in guest-memfd, where guest_memory needs to be
> allocated according to NUMA policy specified by the VMM.
> 
> All existing users pass NULL maintaining current behavior.

I don't want to see this as a separate series.  I want to see it as part
of the series that introduces the user.

Andrew, please drop these two patches from your tree.


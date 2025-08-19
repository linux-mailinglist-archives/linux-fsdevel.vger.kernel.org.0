Return-Path: <linux-fsdevel+bounces-58236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F1DB2B73F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 04:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C586222ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 02:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5264528BAAC;
	Tue, 19 Aug 2025 02:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wEqEC/Ki"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E172C181;
	Tue, 19 Aug 2025 02:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755571607; cv=none; b=FKMBfG0ax3cdwuk3T0c+88c8nW05lorRdbfc7akiBbVxxSx9SaTz7k6hIutPMsunEe/ZfZ2Z/hat+aMRVJemuYjAugtrx601bhAwnPb11n279J1TGcWCaIoM5ELpxECdbYxz7Hs97gPFdcDbJqyrzJX6XPgFpJnH5l3I2JSgc2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755571607; c=relaxed/simple;
	bh=iLvm+Zwx3aEhx1RYrvsUzXCJBxhXIVIH2mX93iW2Pb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j46sCjvzjXET3lJgP4/guwxbB1oOdbXxAFNfKyWrgTBvSiTaBTtMNqXmqW3OOvlUFAaMlob8pzEaevx8BZcVvED7EZwIQuVC0xz+Y7mthOKekpr470fUDMeIIHp8T3XSpjkhzVywmz85yfF15e3bHRaq1WCfNCK++Ed5HuQw3+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wEqEC/Ki; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bRcfDxQN0Y07fq+oKJMThMYIDH4cn5ueNFH/T0aHZsU=; b=wEqEC/KiXklf7eS2WgGEIgkIYR
	iZZbLkZJsJ6RbCIrjJhSKwyqix5agvMYN81rEa6KzpC6MKKmqt9fgxVx5Ie6dRtaFt+rk7rUnIL02
	dXKTthU7DqTnf9+W+v48hPboU7vjjfL02caVhyAH5/LQBpXjta5TJzZKfeE6SRgeubbqHnMgMtGfV
	ylLkPlHSB0DV4FJpfmxw2d9rXDdUmGsPy3ZG0vOdfBWvyFQm0jiLpvlcZ+99B40/zUaFM8bhGMjQr
	r3sIm24nHwWQmbBW9KhByQhoLc1NyKKXMTk0rPYbsLqkD950r+d+301vQTqWLUZiwEv0oAr2ZPt+I
	Igr4Kyww==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoCN1-0000000F0kr-0WSI;
	Tue, 19 Aug 2025 02:46:43 +0000
Date: Tue, 19 Aug 2025 03:46:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Boris Burkov <boris@bur.io>
Cc: akpm@linux-foundation.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com, shakeel.butt@linux.dev, wqu@suse.com,
	mhocko@kernel.org, muchun.song@linux.dev, roman.gushchin@linux.dev,
	hannes@cmpxchg.org
Subject: Re: [PATCH v3 1/4] mm/filemap: add AS_UNCHARGED
Message-ID: <aKPlkhXY9CON4x9v@casper.infradead.org>
References: <cover.1755562487.git.boris@bur.io>
 <43fed53d45910cd4fa7a71d2e92913e53eb28774.1755562487.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43fed53d45910cd4fa7a71d2e92913e53eb28774.1755562487.git.boris@bur.io>

On Mon, Aug 18, 2025 at 05:36:53PM -0700, Boris Burkov wrote:
> +++ b/mm/filemap.c
> @@ -960,15 +960,19 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
>  {
>  	void *shadow = NULL;
>  	int ret;
> +	bool charge_mem_cgroup = !test_bit(AS_UNCHARGED, &mapping->flags);
>  
> -	ret = mem_cgroup_charge(folio, NULL, gfp);
> -	if (ret)
> -		return ret;
> +	if (charge_mem_cgroup) {
> +		ret = mem_cgroup_charge(folio, NULL, gfp);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	__folio_set_locked(folio);
>  	ret = __filemap_add_folio(mapping, folio, index, gfp, &shadow);
>  	if (unlikely(ret)) {
> -		mem_cgroup_uncharge(folio);
> +		if (charge_mem_cgroup)
> +			mem_cgroup_uncharge(folio);
>  		__folio_clear_locked(folio);

This is unnecessarily complex; mem_cgroup_uncharge() is a no-op if
the folio is not charged.  Sure, it's a wasted function call, but
this is a rare error path, so minimising size is more important than
minimising time.

So you can drop the 'bool' as well:

+	if (!test_bit(AS_UNCHARGED, &mapping->flags)) {


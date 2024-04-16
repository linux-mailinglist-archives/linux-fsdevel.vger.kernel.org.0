Return-Path: <linux-fsdevel+bounces-17077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6C18A75FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 22:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56638B224DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 20:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582B46996A;
	Tue, 16 Apr 2024 20:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MeZrTq7d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EE05A4D8;
	Tue, 16 Apr 2024 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713300875; cv=none; b=QJ05PsZ+pB3/UhwOjurEObKJJevfbgbdC28XfD3lPsFK4CTH7q94SgNLyBRT7cZ5l5qXlIhfH/dA4RpaOYaynjXEiCL1lm4dLeHffwnHaCblFYnZtPG0aMfr1wSu9zZiL4JwFZsCnIx6yNK8XHIPNpODqXU5T1ETk1yso72Aub0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713300875; c=relaxed/simple;
	bh=znt09ZKf/WSyDQZxpbQsoP4CergUzZbVINbdKDx3s4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrD9E5qyvLMeaTRwCLzi8anKs/zfe7rUufI8w65HbmYMfVfX9FxDVlRc8CKT8tmG/p/x1NQDnYO0GTOkWefRReMFiLqgpzoIQE/nWHiwd7FKDl2jGB8qb/CrS7MhvhGV+cyOY6V85Fsn8P69204FqBeSENhnu91B0tPEighXwus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MeZrTq7d; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CvfKII9Ey67SD+8qh7yMsDVcRpvNqlMhWe2P/D6dDSQ=; b=MeZrTq7dInM0fW1d4LyApMradW
	diRVdeeO0287HG7lWB08jMShf06reiRYo6cQXffE+rHrAMCkn52vV9rcs/rMSoiBdQr/Ek+ws/3Kj
	nUuOPSxy3MBHZjJQgaT+4uqXcXiuVpVymhp9M7I4sCcOk789C3LKz02aK8WBtuxZOVCkCE+5eSeMa
	z31e0OtWV0T8rXKhEqznvlezTzD0YWbfI21SDNJ4E08jsIzRslNWZ/0mcn5w+7lvsSuGAIYy9PsWL
	9YSb0glxtmA4yR/KzKYB4I//Tkz0NkzU3fv/gQOj0TSg8Qe7NTWTLhjSappGg9728TN0X/lNjDGOm
	WowEWrJw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwpmk-00000001OPN-2QDc;
	Tue, 16 Apr 2024 20:52:10 +0000
Date: Tue, 16 Apr 2024 21:52:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Sourav Panda <souravpanda@google.com>
Cc: corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org,
	akpm@linux-foundation.org, mike.kravetz@oracle.com,
	muchun.song@linux.dev, rppt@kernel.org, david@redhat.com,
	rdunlap@infradead.org, chenlinxuan@uniontech.com,
	yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com,
	bhelgaas@google.com, ivan@cloudflare.com, pasha.tatashin@soleen.com,
	yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
	kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
	adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
	surenb@google.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, weixugc@google.com
Subject: Re: [PATCH v10] mm: report per-page metadata information
Message-ID: <Zh7k-jFRTe9RN2Lr@casper.infradead.org>
References: <20240416201335.3551099-1-souravpanda@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416201335.3551099-1-souravpanda@google.com>

On Tue, Apr 16, 2024 at 08:13:35PM +0000, Sourav Panda wrote:
> +++ b/include/linux/mmzone.h
> @@ -217,6 +217,10 @@ enum node_stat_item {
>  	PGDEMOTE_KSWAPD,
>  	PGDEMOTE_DIRECT,
>  	PGDEMOTE_KHUGEPAGED,
> +	NR_MEMMAP,		/* Page metadata size (struct page and page_ext)
> +				 * in pages
> +				 */

This is not how we write comments in the kernel ...



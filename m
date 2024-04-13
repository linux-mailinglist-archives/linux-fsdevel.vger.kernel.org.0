Return-Path: <linux-fsdevel+bounces-16845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89948A3A09
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 03:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B616B220A3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 01:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154ED4A33;
	Sat, 13 Apr 2024 01:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oQoGRz9q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12962F2A
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 01:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712970339; cv=none; b=JJjE2Zc4YGR0CwpMfejnL664aJAW7v7hvsZ1zfZT4fFj8pYPhTfUxga/nTYxn9uYeqI6fqy2cd0KOqYbshQj9P60u+wDyi7K1M5Pk/bdFBDP8tGirCyyLV/P2iSs89lw3TvoV67xoSXlUzG1WUIE8E38fGqdiCxWT4S7WblAAk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712970339; c=relaxed/simple;
	bh=dHt26m98Cl1jEADlnr5zi5IeaUXr8GpABdUliyPfNeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUPdRBY2ES8T7E0EsvZiMhgoQeV7F4oE/Ko2s5WU4ZYudeuP0R8yzYkECO1msb2yBtLSo66o56wVECrI+4x95RcjFAWdhIKIIZiYowHsBgmBuz10RYKeJ2zvDPYHyoS9UssVdxOPga6oLNLKyP6pIGZvYYKOM3NgM9wfWJwYfp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oQoGRz9q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZCZYjLkgB6G67OXLnc2JUYOap4XC9wLoHWTQr08jEBw=; b=oQoGRz9qnOrPl6ib+8HYrCaLPI
	FVyu9OfFA/QRnapcD5uCQ4mXPW6mzjXF840ZQVTzt0geTJrLOdTr/xvtnqJkHyPYZOw+IJ1ub/bH/
	WREvcdDdYPq1po8QOLjJxQV2eBxvDgZa2OujI4GJlghnIOPNqzj/GyvODA/HAx5HthS1iLwpnqe9p
	FV0JgkdI8eViLjZkZvrww/3kI+lGeBTdDOZzVdeRR6jICLlJh35iE6ThNAVP9nofZ+xWVnTbsQ73f
	bCFVsJ81rQqjWRkijCiiNlVyW3VKQ3rJufkel4wBOnDVg4+iio1g8HO+T+wmyiYukshJDDfLfJl0s
	g98TFRCA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvRpj-0000000AP7E-2MaG;
	Sat, 13 Apr 2024 01:05:31 +0000
Date: Sat, 13 Apr 2024 02:05:31 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] mm: batch mm counter updating in
 filemap_map_pages()
Message-ID: <ZhnaW0CzJZb_rrTl@casper.infradead.org>
References: <20240412064751.119015-1-wangkefeng.wang@huawei.com>
 <20240412161217.c7dc1af77babe5004bd3e71d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412161217.c7dc1af77babe5004bd3e71d@linux-foundation.org>

On Fri, Apr 12, 2024 at 04:12:17PM -0700, Andrew Morton wrote:
> On Fri, 12 Apr 2024 14:47:49 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> 
> > Let's batch mm counter updating to accelerate filemap_map_pages(). 
> 
> Are any performance testing results available?

Patch 2/2 says 12% improvement


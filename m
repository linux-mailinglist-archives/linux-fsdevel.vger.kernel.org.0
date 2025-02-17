Return-Path: <linux-fsdevel+bounces-41901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9356DA38E6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 23:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11E697A17DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 21:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170CD1A9B5B;
	Mon, 17 Feb 2025 21:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v3VXdVcq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30685224F0;
	Mon, 17 Feb 2025 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739829591; cv=none; b=OZlKCW9p067WxIJRYtcxprbzpyhFcSLwTRZybkytT/gC2oy9Tl8zLgc3NfN6iUYKcGU44hAQHm7kaOFfCvmQYOZpLxcAvnYwcW6ag2Q4Z9zbKZnhek7/kOEsxOQTAmsVGEwaTcnlHEkuz6A8uHJpQV+MMTB0UQz6tINfxF+WJd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739829591; c=relaxed/simple;
	bh=GjL6VV9Q4UUP134g8WIIj3AT3jk5Cck/LKhwnKF6AFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NweSssyCzpLFVPKjK3LpR9AkfJSNXywsqI7i+3Bb1XX1SvTZz5361MmdOmMI0hPlGVVTNPWyQtd3aXTbdxbP73r38xaTERnYfrg74R065cieLZ27t0NQh+ZvWYg+fSDR+C3aUallVpx4oEOIqmeKUn/jxUhbg/YH2soNMKAvA2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=v3VXdVcq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UqfeASeSerYkxGqFEpE1FT6i6GwmCUodWmslwGCKNtc=; b=v3VXdVcqyYiZjdfplsZLrJWL9j
	LNcimDTgvh4cMuOxBLEDW5aZgrDDAeN4M7sCWRdw1U8a0P+epNQ22lAMaY41W5mBbUBi+gbs+pjm9
	T1EaIUkaUw47RGVMHv44kkvfj8n22sPgwpC1dI6lFdDQa92/xsrbBqFUffWFwf0O4WK611WBv6U1r
	Q0P1HcIR5Qh3rxwoQ0mkMmJJydMZ9PavbbsaJu12qb9Mcu4Lpx4P4yCb5WzfZp6tF+NuCrJ2mDGU8
	DLHqtEFB4pJiSamoY+gkcbk08yilFk1GuvovMOJV5tOZsiAus9izsIm0QCaXI2E8TRRWvlyThfRgk
	EEYLEmvw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk99V-0000000205j-3jEw;
	Mon, 17 Feb 2025 21:59:45 +0000
Date: Mon, 17 Feb 2025 21:59:45 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hare@suse.de, dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org,
	kbusch@kernel.org, john.g.garry@oracle.com, hch@lst.de,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH v2 6/8] block/bdev: enable large folio support for large
 logical block sizes
Message-ID: <Z7OxUZCDtXaOQmkj@casper.infradead.org>
References: <20250204231209.429356-1-mcgrof@kernel.org>
 <20250204231209.429356-7-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204231209.429356-7-mcgrof@kernel.org>

On Tue, Feb 04, 2025 at 03:12:07PM -0800, Luis Chamberlain wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Call mapping_set_folio_min_order() when modifying the logical block
> size to ensure folios are allocated with the correct size.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>


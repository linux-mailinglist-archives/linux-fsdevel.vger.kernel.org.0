Return-Path: <linux-fsdevel+bounces-42308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48965A4014A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 21:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF330863BC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 20:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A3825333E;
	Fri, 21 Feb 2025 20:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gbBWvYNo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4E4215F43;
	Fri, 21 Feb 2025 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740170746; cv=none; b=ldKSS1Ku/WArAOA7VNM98rmgSKwQKVUhTC43qIfpYgA+Ihtfcu7edPzqHu7GGt8ArnXFlwGhVY+mnT4bol9iki0QjlkIfXPNqo1y8aopzTJyibDNwBGpRxkZ5h3fEQVt9tm+wQAe6KmCTYuVN8K02ONx1b5mBdcFvjLbvSL40C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740170746; c=relaxed/simple;
	bh=oztAQtYxx3Z51m0CQdT2Cr6EXDdCsO8JyKsmO0EWXgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUodArdgQNS2mAGpL8l3mgUka2dEFNR7hzz7Wm1JkT2Sd4CIFLqHhXtVFGF1jtwydlxZCNag2Ic2qKtTwQEIYF04ZXIXAwoo/VfPBxCXoVWFBs7X6mwvj6JtxlxeQmFdneYHGSfyjBsQeZrVetwAt8vrTjx2/iAem9Mds9mW4O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gbBWvYNo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oztAQtYxx3Z51m0CQdT2Cr6EXDdCsO8JyKsmO0EWXgo=; b=gbBWvYNobJ7QxYoqcU61sYGEl2
	r7W1flrcw1TgRUfrqf062y6L3vAdkcQd7mAyrbyn4l+oEGfBNeexAXmuRufEC3PV3RLJAE49MUUr3
	NREZwEVruM8uJzYYw3CoVMvfmQjOG6N2ZA9NpYAFESUJcIJ4BTIXCW3uiSeZcT3CJqYi5XRyrwql8
	w8WoUmtCI7sItolpt9jDfEe8f+edcSLU0KuR6bL1G0K7sh2dvFvxZgH13qGxfoF9RqZ/2O8Pu2AMU
	RmOIrkiRZGQXiEoBvbtEgaKG6DjwlpvJbKi4AkAF1kSWDVHSr0iu7MBIBa2CLfgTbJu69uTSNE9vZ
	NF1Gj2AA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlZu1-0000000F45b-34VI;
	Fri, 21 Feb 2025 20:45:42 +0000
Date: Fri, 21 Feb 2025 20:45:41 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v3 10/9] fs: Remove page_mkwrite_check_truncate()
Message-ID: <Z7jl9cIZ2gka0QP6@casper.infradead.org>
References: <20250217185119.430193-1-willy@infradead.org>
 <20250221204421.3590340-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221204421.3590340-1-willy@infradead.org>

On Fri, Feb 21, 2025 at 08:44:19PM +0000, Matthew Wilcox (Oracle) wrote:
> All callers of this function have now been converted to use
> folio_mkwrite_check_truncate().

Ceph was the last user of this function, and as part of the effort to
remove all uses of page->index during the next merge window, I'd like it
if this patch can go along with the ceph patches.


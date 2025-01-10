Return-Path: <linux-fsdevel+bounces-38802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB69AA086BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 06:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84EC3188A666
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 05:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797F02066FF;
	Fri, 10 Jan 2025 05:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LGWTuyCe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C241E0E0B
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 05:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736487841; cv=none; b=B3Wswym3C2SDDAr+giYEBy90Aq1yU/KDtIgp1A1EV+XnCHgbckq6WyBKqJHkefXcQ+8lanHnCmRGFgMV+l5z3XB+06X9gyuPS9DswlrDq6Nep+075AMe6IID6nF8M0dAyJizKjU04LEEk2Nm5sSR0Vp+aiDq5iyNm5woiXWuSDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736487841; c=relaxed/simple;
	bh=+2Ah0gtqRF1Zuk5ihHDgwdC87CTfGwyeVILIdaJDCBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfyGYVFcI1N5WZhbrBmun3JZEx+jmz24pTRlyOeJhR7JOIx6aP16ewZ3fp1p/dGDJGwlTbRI1x4kSbCYQzzBfFYlwazhmnOCOSzHKU70V2+Gc359muJJvPn9tTNX1xhbS/HrUSQ5861sxp9iiSYHMeTBKJeTXzA/86cf1zlnDb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LGWTuyCe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bJ1rQvFWAU9SGSKH7s1SbjVP4inlCelUlRtoueYL/0k=; b=LGWTuyCeUejobeWpkskRg4rfBB
	fw6kBVNGEZ/SD0TuS2SGSzUubXlxvt/sz02roDZ0mXNKL+KphsVl7OoEkgdRRVtKWslQFsTnHUTPB
	KvjGKCBwSy3JuiQimEM79cVpgsx4iCgtpKkR38b0RICnXLDMCsU4Y9BPaZmiJ73ax9p8cM32Dcq+8
	DsWNSf0/BFKP1LH31N2eNFbdNoSt1XrtmXVM9sbqF9k+YmuMu1RNaUYLNCJud4iZS5/NwiQf5L1ZD
	4wEKVDnnSOPMsJFUF5FsUu6O0ynLpYLg+ZusDTsPxqfF5sm7/K/L+4549WwDhEE3YBLAHjE/+hlNr
	twpNeF9w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tW7oH-0000000Bt1r-4B2d;
	Fri, 10 Jan 2025 05:43:54 +0000
Date: Fri, 10 Jan 2025 05:43:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] hostfs: Convert to writepages
Message-ID: <Z4CzmTsAjKtUfu6I@casper.infradead.org>
References: <20241220051500.1919389-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220051500.1919389-1-willy@infradead.org>

On Fri, Dec 20, 2024 at 05:14:58AM +0000, Matthew Wilcox (Oracle) wrote:
> If we add a migrate_folio operation, we can convert the writepage
> operation to writepages.  The large folio support here is illusory;
> we would need to kmap each page in turn for proper support.  But we do
> remove a few hidden calls to compound_head().

This patch isn't in linux-next yet.  Any comments?


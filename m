Return-Path: <linux-fsdevel+bounces-46230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FEDA84E12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 22:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17071B63CBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 20:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F284628F945;
	Thu, 10 Apr 2025 20:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s+uiFzZJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985D8204C22;
	Thu, 10 Apr 2025 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744316602; cv=none; b=EzB5HNRci6ub7Oa9mgVwHoIRgmtRFiTw5o4cp+CagAstB+x+cVeWSLO4ATOpriTGeRkpefcDLMpGO13RoEKFpY/MWMrCEvobXqo+KdP6nXKzs+xWMsfxeRQdgAwafiE5J72IOrfVjpZYUCrq8eFOfgLOh+ciDhm4qd+KHA0toVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744316602; c=relaxed/simple;
	bh=TuFo7i0a6vrYYV3Wvl6lQkFF4JO8jwB47A12gGxbz4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBN6zxAN4LBqb9OJrz/WsRLzgpgpTtVGcaoQSkO7nkCa5yKwluKndYgLkQq/tQBd8mc2DmOHNIPtloj5F6LS+VAywszGUi1Cfabk+BwzFvqULalRMVONEY6UNIESzqaYmoq8e3FMoxhGkRPLqaFPDmK/EURgmQ5gmdEMhvmHbvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s+uiFzZJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JA5xnFiYRdoPh7JXzWsP6L7crchKwYbI+Ps2YIbs+fI=; b=s+uiFzZJlCh98vm9rwNyZu0Rhf
	iPdtA/5OvIiUl/CzlLXYSaPhjHZuIPetcHDqKzXC2TmWW8y5O6ic6WC9OTSO3Y+x4ckNdmrJYCsWY
	t/hR2gzPHXLBUmUL6rIEmm/U8ozQz5e21E/HG09btnbo0uJSXhXGfSP6g0MNPBCWJH2C9t+ZlvvFC
	LwNgwjxbx5xsdhX3tZvrchVzekhRDeg32TCowWCGxesynq0DRuDy0kIz0uAI+zu6dk/L4hmJF1FZ0
	59eRC8Pkvull77XbOzO0IWY6hqzAMmyZzNAHGZGHF0xoF+PksgUaAtkIKSsJRrgJ28d3a345gYO8+
	kmnRF2YQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2yQe-00000003Llz-48OG;
	Thu, 10 Apr 2025 20:23:17 +0000
Date: Thu, 10 Apr 2025 21:23:16 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	Alison Schofield <alison.schofield@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v1] fs/dax: fix folio splitting issue by resetting old
 folio order + _nr_pages
Message-ID: <Z_gotADO2ba-Qz9Z@casper.infradead.org>
References: <20250410091020.119116-1-david@redhat.com>
 <67f826cbd874f_72052944e@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67f826cbd874f_72052944e@dwillia2-xfh.jf.intel.com.notmuch>

On Thu, Apr 10, 2025 at 01:15:07PM -0700, Dan Williams wrote:
> For consistency and clarity what about this incremental change, to make
> the __split_folio_to_order() path reuse folio_reset_order(), and use
> typical bitfield helpers for manipulating _flags_1?

I dislike this intensely.  It obfuscates rather than providing clarity.

>  static inline unsigned int folio_large_order(const struct folio *folio)
>  {
> -	return folio->_flags_1 & 0xff;
> +	return FIELD_GET(FOLIO_ORDER_MASK, folio->_flags_1);
>  }
>  
>  #ifdef NR_PAGES_IN_LARGE_FOLIO


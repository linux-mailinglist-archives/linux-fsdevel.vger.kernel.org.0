Return-Path: <linux-fsdevel+bounces-9923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0E18461F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 21:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB1CDB24415
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 20:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82031E4AA;
	Thu,  1 Feb 2024 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ItybdaiD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CF117BD2
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706819684; cv=none; b=Zc6DvuC1KrGHq7VYi6u/W1s55T4yBholMU3nEXOhdtYcAdiW1MH3N9xz+9FwMek4svWymMJL1uzLrNeqHSiVJ89g6x4P4OyxiPTmvNeMHbu27Y4CfdIHuOgZ1dtZGAFd5qCfq9+mJW4i1mvAJ5H+x9IKT+3ZP4v21Eov25mHxTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706819684; c=relaxed/simple;
	bh=uccUdd792mAvvUXfzSZhJUkDVjrSq/5f2R3C4X3iCaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqowWGLZyv8QFN+132iN1NWFBv2Bk/KdyT/2aNFSYdtFzjB8Z2F7EN+JlM9A9/5bESYw3iVpypW+AvFtJnF8PSK9dL1OXDipJoemGiKnG+sSsUczDA1Rt2hGe2yIy5PwzZ6LAV5EI0ymlepLLh3V/LuYsslKPoSfXWwR7tOaVX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ItybdaiD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qoxvFkY910Gqu3IoCO6Ky1UpafCyAu20SH1jpKymbD8=; b=ItybdaiD6RA+Cso6v5t8YNJnOw
	R+YdqPDEpKQxaBkjfZ9e9D7S5JwdMjflSqezj4N6TxAtE6peyaqrl6e63mKUNjJ4kUY5YnwYFHCRp
	n3/Ceqa4moJc4sscJemJun665LZZyX2/igBC81TRbcoPQk3vfUixh2XCN6hIYgpmKSpFsf1lK+zCR
	1Z/vVW+4S932eXzR6pvd24XVcebnHV16yy+UDQaEtGgoTOLxNm6rtEEByxAU480zNA6+CAwsvKA4k
	Wgre2TbjX31UExdM78KXII24CWH9IdabTPN1IihcgtrvMUAHhQaKPJsAJZZwnP533ONc3XGQ5HYO7
	gkwHf5Eg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVdlZ-0000000GkUx-0PEX;
	Thu, 01 Feb 2024 20:34:33 +0000
Date: Thu, 1 Feb 2024 20:34:33 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Tony Luck <tony.luck@intel.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	David Hildenbrand <david@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Benjamin LaHaise <bcrl@kvack.org>, jglisse@redhat.com,
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH rfc 6/9] mm: migrate: support poisoned recover from
 migrate folio
Message-ID: <ZbwAWXhz26Q7ZYMr@casper.infradead.org>
References: <20240129070934.3717659-1-wangkefeng.wang@huawei.com>
 <20240129070934.3717659-7-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129070934.3717659-7-wangkefeng.wang@huawei.com>

On Mon, Jan 29, 2024 at 03:09:31PM +0800, Kefeng Wang wrote:
> In order to support poisoned folio copy recover from migrate folio,
> let's use folio_mc_copy() and move it in the begin of the function
> of __migrate_folio(), which could simply error handling since there
> is no turning back if folio_migrate_mapping() return success, the
> downside is the folio copied even though folio_migrate_mapping()
> return fail, a small optimization is to check whether folio does
> not have extra refs before we do more work ahead in __migrate_folio(),
> which could help us avoid unnecessary folio copy.

OK, I see why you've done it this way.

Would it make more sense if we pulled the folio refcount freezing
out of folio_migrate_mapping() into its callers?  That way
folio_migrate_mapping() could never fail.


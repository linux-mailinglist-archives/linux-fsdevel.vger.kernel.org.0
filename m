Return-Path: <linux-fsdevel+bounces-17262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75A28AA265
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 21:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833ED284A93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 19:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8560617AD88;
	Thu, 18 Apr 2024 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LwBcPSmu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5094D17AD7E;
	Thu, 18 Apr 2024 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713466874; cv=none; b=KRsGYkPbyCyhe1S81f8o+Gr8rJD0TDj2DXL1NY8+HLVaSvMq62+u/4yw5e3B4svMT3BuXbXJC/XcFoOXpTlakCC0LVRqV7sOF4jfhZuctturJiIU1Sei2dwvj+d8hvCL3O6qA3idZ3Widg/Vw6T6mGzVbFzIidlJp3O/45BY9Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713466874; c=relaxed/simple;
	bh=eFq87EeF9EAQoHaWtrdfQxVjPWTJO9j+NRlpzgO87RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWICBYfPn9qZ210eIkfy5L4S2RANrCeRakS4W4iVVBhyVrME1T0/oVe0sl6ohWtulJCEF3mlFo9rB/cpxuNnrk2ivmx9BLFQCnR0+bcHlJDYf3snVNp4Ynqh3d5l+GXbPqktcUmFxjBBuR/sjlz/rNGx0NiSjctAESYvv7x/2+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LwBcPSmu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tj8FE6iEyaF2IxXlnuLTq4i7vDQkIsbYJGnwMexY1O8=; b=LwBcPSmu9/OoFUmg3f2aOONL5X
	UCwFiOGdufrx7TH2tQzjaJW/yYDuPV3DEU0ql/kl4kICiQRmYIuVmNtHWZMVf79GtYOQM0QS6lSvG
	K/enduxZRnnjtdbGu9kbuBR6418LDZdQ12yRpaxx9UjTWzCw0M7JNX/pjSW8sCBbsP2V0CkiRkUte
	gOKQ2FfDjQRwO27TXUBn/PlGqOjSKFSuF6d7Zafj57eTotKv1WC/GmNEkXj38GrCUNo11QRTJWcrk
	AE85UqXcEqRJfmVtYADy1Knu7xxzmNezSsdVbMqhPerZFONm235uFkvmmhjmZvdNsOtAM4QfCf9io
	DeM9wL1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxX0N-00000005xCR-04Kf;
	Thu, 18 Apr 2024 19:01:07 +0000
Date: Thu, 18 Apr 2024 20:01:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>, fstests@vger.kernel.org,
	kdevops@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, david@redhat.com,
	linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de
Subject: Re: [PATCH] fstests: add fsstress + compaction test
Message-ID: <ZiFt8uGMLIWuTh4g@casper.infradead.org>
References: <20240418001356.95857-1-mcgrof@kernel.org>
 <ZiB5x-EKrmb1ZPuf@casper.infradead.org>
 <ZiDEYrY479OdZBq2@infradead.org>
 <d0d118ed-88dd-4757-8693-f0730dc9727c@suse.cz>
 <20240418114552.37e9cc827d68e3c4781dd61a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418114552.37e9cc827d68e3c4781dd61a@linux-foundation.org>

On Thu, Apr 18, 2024 at 11:45:52AM -0700, Andrew Morton wrote:
> It indeed appears that I can move
> 
> mm-create-folio_flag_false-and-folio_type_ops-macros.patch
> mm-support-page_mapcount-on-page_has_type-pages.patch
> mm-turn-folio_test_hugetlb-into-a-pagetype.patch
> mm-turn-folio_test_hugetlb-into-a-pagetype-fix.patch
> 
> without merge or build issues.  I added
> 
> Fixes: 9c5ccf2db04b ("mm: remove HUGETLB_PAGE_DTOR")
> Cc: <stable@vger.kernel.org>
> 
> to all patches.
> 
> But a question: 9c5ccf2db04b is from August 2023.  Why are we seeing
> this issue now?

We saw it earlier, we just didn't know how to fix it.
eg December 2023:
https://lore.kernel.org/all/ZXNhGsX32y19a2Xv@casper.infradead.org/

I think there were earlier reports, but I'm not finding them now.


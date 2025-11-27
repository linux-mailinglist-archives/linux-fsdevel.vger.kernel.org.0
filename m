Return-Path: <linux-fsdevel+bounces-70040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC11C8F094
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 16:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0A83B40C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 14:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B049335BC5;
	Thu, 27 Nov 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J7WljQI6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7987334685;
	Thu, 27 Nov 2025 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255329; cv=none; b=ACVARsN+gmYCMkO2PvirIKvwEB8f4emDjutYmwy9o7p0vu72MI8z6UTzdJFsWPP8MHcCtpDv1yxaFwtTNNJNncxU2h5tU613boIUinHoHLOGsHVM6hDWSnP3I+G+zoQcoAIrvXROBGl6EVPW3z3VQspywBLCIt83/DhNezs3Q24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255329; c=relaxed/simple;
	bh=865BE6L6luNXaaB9ASnTnki9ZUwhJxMV+gLXPZPUkfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLzU1Xrmg/L54bWsTEZnILLs3VM7BUiemA3nI5ic/myBdp5Mi/6jtEIysvDfPqoEh6+GkO4yMJSt5qOdCRVddunbR/h9WrUCcV76pu6X3Nt9xmeFDoXLQRv4K6dnV9WjHp+YS8+wx/3RdDnhKXuqJzfI2ykSeZW254ybxkBHZG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J7WljQI6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=58WYeoWp+L034I9TYiz+ieCppakm+AyyWrLBMP+OM0A=; b=J7WljQI6KUNn+EFR6+1UQpkkcf
	g945pGaj0nuiFCTt/jREJ1RI0jT3fLpA5GPL9DsFKpQQskDHtAyC5cK+3xWxu60A1i1WTafjj6pUw
	EuQjqtvIxuPDusDWAaSgq0T3mpqMmCOYM0UuKFcmyykVb+b7J9c5j3ZuEE9e4yF1guMiJQYFq9uQi
	dR+CsEru2Pt/hvvx9bZxrRzY0ZA3ETAoJ1SFrqjtgv8WWShGIq0WqsCymYRkOjJ9Rx2zE+gNmGCsK
	wJ/OIBP+CKWBJ3SUk/Px0lrTg/W3lSuWqRKYtVw23FelO65F9b61rO3bFUl+SifJHiF+6SiEUNQMq
	Cwbdn31Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOdP1-0000000Bsna-0xik;
	Thu, 27 Nov 2025 14:55:23 +0000
Date: Thu, 27 Nov 2025 14:55:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Jan Sokolowski <jan.sokolowski@intel.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/1] idr: do not create idr if new id would be
 outside given range
Message-ID: <aShmW2gMTyRwyC6m@casper.infradead.org>
References: <20251127092732.684959-1-jan.sokolowski@intel.com>
 <20251127092732.684959-2-jan.sokolowski@intel.com>
 <aShYJta2EHh1d8az@casper.infradead.org>
 <06dbd4f8-ef5f-458c-a8b4-8a8fb2a7877c@amd.com>
 <aShb9lLyR537WDNq@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aShb9lLyR537WDNq@casper.infradead.org>

On Thu, Nov 27, 2025 at 02:11:02PM +0000, Matthew Wilcox wrote:
> Hm.  That's not what it does for me.  It gives me id == 1, which isn't
> correct!  I'll look into that, but it'd be helpful to know what
> combination of inputs gives us 2.

Oh, never mind, I see what's happening.

int idr_alloc(struct idr *idr, void *ptr, int start, int end, gfp_t gfp)

        ret = idr_alloc_u32(idr, ptr, &id, end > 0 ? end - 1 : INT_MAX, gfp);
so it's passing 0 as 'max' to idr_alloc_u32() which does:

        slot = idr_get_free(&idr->idr_rt, &iter, gfp, max - base);

and max - base becomes -1 or rather ULONG_MAX, and so we'll literally
allocate any number.  If the first slot is full, we'll get back 1
and then add 'base' to it, giving 2.

Here's the new test-case:

+void idr_alloc2_test(void)
+{
+       int id;
+       struct idr idr = IDR_INIT_BASE(idr, 1);
+
+       id = idr_alloc(&idr, idr_alloc2_test, 0, 1, GFP_KERNEL);
+       assert(id == -ENOSPC);
+
+       id = idr_alloc(&idr, idr_alloc2_test, 1, 2, GFP_KERNEL);
+       assert(id == 1);
+
+       id = idr_alloc(&idr, idr_alloc2_test, 0, 1, GFP_KERNEL);
+       assert(id == -ENOSPC);
+
+       id = idr_alloc(&idr, idr_alloc2_test, 0, 2, GFP_KERNEL);
+       assert(id == -ENOSPC);
+
+       idr_destroy(&idr);
+}

and with this patch, it passes:

+++ b/lib/idr.c
@@ -40,6 +40,8 @@ int idr_alloc_u32(struct idr *idr, void *ptr, u32 *nextid,

        if (WARN_ON_ONCE(!(idr->idr_rt.xa_flags & ROOT_IS_IDR)))
                idr->idr_rt.xa_flags |= IDR_RT_MARKER;
+       if (max < base)
+               return -ENOSPC;

        id = (id < base) ? 0 : id - base;
        radix_tree_iter_init(&iter, id);



Return-Path: <linux-fsdevel+bounces-21008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A998FC109
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 02:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42678B25599
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 00:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DEC5C82;
	Wed,  5 Jun 2024 00:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YJIbCAlf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59FD6FB0;
	Wed,  5 Jun 2024 00:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717549049; cv=none; b=IhRwI1h6F3NOXm7Zgatua43iEhxiOz/0hRQTS05zbKNgp+BU7jWeRFuV4lB6MpX0S18oOSzBpzEidhYtec6it9k0HhqQQAvNDslUBzA/7Q/foegkz11rrHz0I3niJU5by6cRSb4m5vyO8DbYjtrH+g7wz5RYNPNZyIteIK/f4Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717549049; c=relaxed/simple;
	bh=+xrDUIF+EJ+GMGqVUKrY/AR4ZBF14Q2JYATUJuO/NAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhIPoYZNPqqQUkOCBIBkLxU73rnxTjxVmLuzTkBcsSO0FCMMAEa2uxehO+SKwrbZy7exHp/pWLr4dFPOSm1vILVW21rZFsssx4HvCfY8xM7IjXlfLdxq6rS5993bfPpXcCJX5YOtXkghVMh0iWnNPDVDBw8PyhvXI2bQzQRlvu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YJIbCAlf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aBjOdC47mqVeNYrbSIGN2A/7SGRjWQavLlZ1uT7tR5I=; b=YJIbCAlfyAOt49uyvw1ZysTsMR
	z6dl0Jr0j0MnxqnB0gB4HRq3QfiZZfNLjRPN+0nHkPRR3VvTxi+2m9uNZ2NwTHesXUI5Z2QPV+Cxv
	qjxLjWvy6qxqotQl5DWGi89siuIr7gmIFqFNNKJHkMnKsoQz7QkrfwW32AHmWgbMBCwMHIfnseBgX
	h9HIUHo7yGPJ4AYbTF2hgiTlJVKdHzlSQdprG8uli3eE3JIIoN6FoISHT9MyJ78UazJqMjrqRsLKb
	DLYPf8IRdeNbpbA96kmoEL7UExbMiwr15JRjzwNiGwHhxEOcbvQf6g6vhrE5UkphXYr+sWA2KVsPN
	a0QNlCXA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEexu-0000000FFDM-0FOy;
	Wed, 05 Jun 2024 00:57:22 +0000
Date: Wed, 5 Jun 2024 01:57:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	gregkh@linuxfoundation.org, linux-mm@kvack.org,
	liam.howlett@oracle.com, surenb@google.com, rppt@kernel.org
Subject: Re: [PATCH v3 1/9] mm: add find_vma()-like API but RCU protected and
 taking VMA lock
Message-ID: <Zl-38XrUw9entlFR@casper.infradead.org>
References: <20240605002459.4091285-1-andrii@kernel.org>
 <20240605002459.4091285-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605002459.4091285-2-andrii@kernel.org>

On Tue, Jun 04, 2024 at 05:24:46PM -0700, Andrii Nakryiko wrote:
> +/*
> + * find_and_lock_vma_rcu() - Find and lock the VMA for a given address, or the
> + * next VMA. Search is done under RCU protection, without taking or assuming
> + * mmap_lock. Returned VMA is guaranteed to be stable and not isolated.

You know this is supposed to be the _short_ description, right?
Three lines is way too long.  The full description goes between the
arguments and the Return: line.

> + * @mm: The mm_struct to check
> + * @addr: The address
> + *
> + * Returns: The VMA associated with addr, or the next VMA.
> + * May return %NULL in the case of no VMA at addr or above.
> + * If the VMA is being modified and can't be locked, -EBUSY is returned.
> + */
> +struct vm_area_struct *find_and_lock_vma_rcu(struct mm_struct *mm,
> +					     unsigned long address)
> +{
> +	MA_STATE(mas, &mm->mm_mt, address, address);
> +	struct vm_area_struct *vma;
> +	int err;
> +
> +	rcu_read_lock();
> +retry:
> +	vma = mas_find(&mas, ULONG_MAX);
> +	if (!vma) {
> +		err = 0; /* no VMA, return NULL */
> +		goto inval;
> +	}
> +
> +	if (!vma_start_read(vma)) {
> +		err = -EBUSY;
> +		goto inval;
> +	}
> +
> +	/*
> +	 * Check since vm_start/vm_end might change before we lock the VMA.
> +	 * Note, unlike lock_vma_under_rcu() we are searching for VMA covering
> +	 * address or the next one, so we only make sure VMA wasn't updated to
> +	 * end before the address.
> +	 */
> +	if (unlikely(vma->vm_end <= address)) {
> +		err = -EBUSY;
> +		goto inval_end_read;
> +	}
> +
> +	/* Check if the VMA got isolated after we found it */
> +	if (vma->detached) {
> +		vma_end_read(vma);
> +		count_vm_vma_lock_event(VMA_LOCK_MISS);
> +		/* The area was replaced with another one */

Surely you need to mas_reset() before you goto retry?

> +		goto retry;
> +	}


Return-Path: <linux-fsdevel+bounces-33071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78529B3275
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 15:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25191B22B0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 14:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2371DD867;
	Mon, 28 Oct 2024 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lxCZvALT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0949F1DB372;
	Mon, 28 Oct 2024 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124255; cv=none; b=KHvY0DlCS9IB8qs41YbAXlfjTTk/Z5PihKGYQ1t8nwq0r5xxOz0FRoPZHHPX0D3wInEQSmbAiiU2L6rfovkHKKSFZVAaNYO9iHI0KR1iltID/htqTKG38Mx1lHf3BUpU9z9EqSc+FVPXkm/jpMcUS3inkXSFdKxsZM4YJKmn2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124255; c=relaxed/simple;
	bh=SNFmw9lcQmn/cgpI6BNBlDafgBf4IGjFU+dS3PXsQAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rB+H0T0ttZyjBxD/x/0Akynux87xj0cXevSNRAZq3wrsRtyOdEr+BoTSAFLy+s+85YtTPwdmto0xCxjZSuITP/Mf5rQQJMCeqaXyYkyDqBJ/smQU/bQY978tTiXWU+jpU91nPErw4NhX89SUXrD87Pyp9ED/MJfy7esfK0q1QsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lxCZvALT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Sq3n4ZBLfS4RB/WURRVHc91SFe8DIKYxMpdakJNvepo=; b=lxCZvALTryteSo3HihrYgynWDg
	Oafy7lbdM82qIS7vgdx0ipIdHZYfWkDki/wfqkX/v0pukUrMEgZA2OKbWwRiNNJYskP71Z3OvRgor
	wbVHDDcOWeLect7PRt27wSywAYt6K4YtXJa58xRao2Y7yJP6dKpej7uBUQyAA+MXJeOjk9BNTLVwy
	ANtmbqTMoq0Sc3klJWQSkhcx2f7F8J4ePu0a7EJZIhzjAhsMZ0CUpfjq8SoUq0UI6xwrLMmvpT6fZ
	73KvxEkHaSKPWo+wSb/gRnii7xqzHolW0ZyTpMJa4Gd59Kyb505dhSiRRUG09ut1nhD+2XPJ6ndKl
	iq8hLzKA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t5QLm-00000008aT6-2tF9;
	Mon, 28 Oct 2024 14:04:06 +0000
Date: Mon, 28 Oct 2024 14:04:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hugh Dickins <hughd@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] iov_iter: fix copy_page_from_iter_atomic() if
 KMAP_LOCAL_FORCE_MAP
Message-ID: <Zx-Z1vqRkyokcHmQ@casper.infradead.org>
References: <dd5f0c89-186e-18e1-4f43-19a60f5a9774@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd5f0c89-186e-18e1-4f43-19a60f5a9774@google.com>

On Sun, Oct 27, 2024 at 03:23:23PM -0700, Hugh Dickins wrote:
> generic/077 on x86_32 CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y with highmem,
> on huge=always tmpfs, issues a warning and then hangs (interruptibly):

> +++ b/lib/iov_iter.c
> @@ -461,6 +461,8 @@ size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
>  		size_t bytes, struct iov_iter *i)
>  {
>  	size_t n, copied = 0;
> +	bool uses_kmap = IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) ||
> +			 PageHighMem(page);
>  
>  	if (!page_copy_sane(page, offset, bytes))
>  		return 0;
> @@ -471,7 +473,7 @@ size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
>  		char *p;
>  
>  		n = bytes - copied;
> -		if (PageHighMem(page)) {
> +		if (uses_kmap) {
>  			page += offset / PAGE_SIZE;
>  			offset %= PAGE_SIZE;
>  			n = min_t(size_t, n, PAGE_SIZE - offset);

Urgh.  I've done this same optimisation elsewhere.

memcpy_from_folio:
                if (folio_test_highmem(folio) &&
                    chunk > PAGE_SIZE - offset_in_page(offset))
                        chunk = PAGE_SIZE - offset_in_page(offset);

also memcpy_to_folio(), folio_zero_tail(), folio_fill_tail(),
memcpy_from_file_folio()

I think that means we need a new predicate.  I don't have a good name
yet.  folio_kmap_can_access_multiple_pages() is a bit too wordy.  Anyone
think of a good one?


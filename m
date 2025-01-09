Return-Path: <linux-fsdevel+bounces-38712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C038FA06EB6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 08:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D59127A12F1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 07:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248B821421B;
	Thu,  9 Jan 2025 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xTZacRhJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C71474A9;
	Thu,  9 Jan 2025 07:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736406655; cv=none; b=Cxtio5EumOc8bK4yWfE7DHGaftdNQ/gjXM/xDmW2IWuT/FZ4NzWwmG8qBISGonM+qhKOO++V2w69aMLvt91NNegAe7CjZESaDj6HEi6EeV76ySlPfG5r/qBTBafO/oaKunebeiQ3weH1O3lChnWQbHl3i6JCgNExtC6InTH1Ecw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736406655; c=relaxed/simple;
	bh=EooKVarekYvXxSl8xrPACbNUrrlxLmt9yYIzpy0n1i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QenZkoP+Ufl1t2ta56OF17mB9lVh7/ivQWXRz1nfc5hHb/8KVV2CyNXnaRt+dxxWdkWphcTajpFaKXNESD2dmJWojD5pTLdqlCALSwr1LXTfLR6Oq6R5D7nkjcXgvtZUPHJe7LKkDUuGTXJNG0YCTj72BWqq896f4EqkdjfiBvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xTZacRhJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uye2VnixGES0qlXGGH1SHMA1WUeP+3tvXbdu1q2CShY=; b=xTZacRhJv+lZYYaPATX7mEJMJX
	OTaMKCp/CXDyJs2H8O4SGqyCrQUunUyZp+YnKhCZlK5yROhpy0TB57jWDltQv26nqMS6tld3fJYlc
	IjVngZM6Q5EAY6Rds2J4W75W4d4gzLgTApqql23fM4cHAQKrQVjk/smntyGAebFv81QWyMY8bG5so
	Ihyw5lz22l4tBkbW63vSLFWFaR6Slyufj9lBlgBYMZLfje9bvr6TzVs5CFNBhomwCrDbo4izWOtMh
	MAX3Uhr+/m5AeyHSuIYvOZreM99aMTv7j8ZAfSAkZeS4XPFpLVGgGUTZknjQJcTAgp+KfHB7eyapz
	16XDfc+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVmgr-0000000B0Gm-01iK;
	Thu, 09 Jan 2025 07:10:49 +0000
Date: Wed, 8 Jan 2025 23:10:48 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/6] iomap: advance the iter directly on buffered writes
Message-ID: <Z392eER1_ceFfMJe@infradead.org>
References: <20241213143610.1002526-1-bfoster@redhat.com>
 <20241213143610.1002526-5-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213143610.1002526-5-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Dec 13, 2024 at 09:36:08AM -0500, Brian Foster wrote:
> +		loff_t pos = iter->pos;
> +		loff_t length = iomap_length(iter);

AFAICS we could just do away with these local variables as they should
never get out of sync with the values in the iter.  If so I'd love to see
that one.  If they can get out of sync and we actually need them, that
would warrant a comment.

Otherwise this looks good to me, and the same applies to the next two
patches.



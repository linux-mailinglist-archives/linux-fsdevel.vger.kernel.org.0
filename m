Return-Path: <linux-fsdevel+bounces-40276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B2EA2178A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 06:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112D23A6E04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 05:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846D7191F8C;
	Wed, 29 Jan 2025 05:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q3PGWCCg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AE35672;
	Wed, 29 Jan 2025 05:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738130173; cv=none; b=tWNNrnbtSS7nfUvm0WGr4f3+0qP6KSyuwNXmH4+FRs+ya0JpIvJBZ/YXy+8GjfKf+uym/dLSA9QhUeAUrQMQsl+8Aw8NDHgZ7dF1ITxua+8qX8oMHBxboBiDx0df36VFjpqApJUF4+DdbDzEwY2NzxosjvO3EIwBbpqEruORYKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738130173; c=relaxed/simple;
	bh=HSsEGkh9NLRSNzOoIdIRh055LLKO9QLqdh25NAMP5Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4NWoOmXDhhEolcsetOiG6nhvrEgyZjtA9NzNypPZ8P6fQsa/hbSvArhvhXB6H9Trtuk1awvL9EcrQtaM6fbk1ksIQpgY2umldsYxZygbM/iMHFwlFJgAmdVngH7FQdmbDnm8tX4lHCaMBNFl6Li6KayuGHgPJ313Ukm1ODlYbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q3PGWCCg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=TQ0Qr+WpYNaaNYgGpB31rHcyPitG1dGNAiWhHnZMzbc=; b=q3PGWCCgMXKtUIaQVxaRrTKUnB
	W/Tos1t5ocfZMHRPaM4Tt+Uy1YNTFfh2U8JB0wJ88SqmCy5B7Zp+5vN4efO7lLdzy3JOX0AHjzpCG
	mSnLxTSAS96ZW4bqCAO4ppAXJypRNJrYC8baI7GGRV/EnkOFIW67AhXn8yG7SauLtVtSjoo5X0puP
	jnabuBZR3s4uwt9t/2h7r4fTLE4DNC9ABP+LsC28v75e1n0ByV3fyB5YBS0YTozNqnwZOyYIlQSuF
	H6etRauBKI6fctHHQABdIzfi2KHtSDMwsuFXgOdx2eFCPX1h3rJqpH9rsTBk8stMnxx/XDZnoEjuC
	A4+aBWgg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1td13a-00000006NMO-3Gig;
	Wed, 29 Jan 2025 05:56:10 +0000
Date: Tue, 28 Jan 2025 21:56:10 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 6/7] iomap: advance the iter directly on unshare range
Message-ID: <Z5nC-n2EsEQcmm6X@infradead.org>
References: <20250122133434.535192-1-bfoster@redhat.com>
 <20250122133434.535192-7-bfoster@redhat.com>
 <Z5htdTPrS58_QKsc@infradead.org>
 <Z5ka7TYWr7Y9TrYO@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5ka7TYWr7Y9TrYO@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jan 28, 2025 at 12:59:09PM -0500, Brian Foster wrote:
> But that raises another question. I'd want bytes to be s64 here to
> support the current factoring, but iomap_length() returns a u64. In
> poking around a bit I _think_ this is practically safe because the high
> level operations are bound by loff_t (int64_t), so IIUC that means we
> shouldn't actually see a length that doesn't fit in s64.
> 
> That said, that still seems a bit grotty. Perhaps one option could be to
> tweak iomap_length() to return something like this:
> 
> 	min_t(u64, SSIZE_MAX, end);
> 
> ... to at least makes things explicit.

Yeah.  I'm actually not sure why went want to support 64-bit ranges.
I don't even remember if this comes from Dave's really first version
or was my idea, but in hindsight just sticking to ssize_t bounds
would have been smarter.

> I'd guess the (i.e. iomap_file_unshare()) loop logic would look more
> like:
> 
> 	do {
> 		...
> 		ret = iomap_iter_advance(iter, &bytes);
> 	} while (!ret && bytes > 0);
> 
> 	return ret;
> 
> Hmm.. now that I write it out that doesn't seem so bad. It does clean up
> the return path a bit. I think I'll play around with that, but let me
> know if there are other thoughts or ideas..

Given that all the kernel read/write code mixes up bytes and negative
return values I think doing that in iomap is also fine.  But you are
deeper into the code right now, and if you think splitting the errno
and bytes is cleaner that sounds perfectly fine to me as well.  In
general not overloading a single return value with two things tends
to lead to cleaner code.

Although the above sniplet (I´m not sure how representative it is
anyway) would be a bit nicer as the slightly more verbose version
below:

	do {
		...
		ret = iomap_iter_advance(iter, &bytes);
		if (ret)
			return ret;
	} while (bytes > 0);


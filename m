Return-Path: <linux-fsdevel+bounces-39002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD67A0AE8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 05:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 929847A2B27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 04:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA8F18C936;
	Mon, 13 Jan 2025 04:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FiuGiIeQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C44B1474D3;
	Mon, 13 Jan 2025 04:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736743874; cv=none; b=N1Zv+7k4InAXsUxUpuTOQLtAVJiuQTHD70bmBi/9i0wx2iI6vpkBEX6ydFekiilng8qI335taEpMI531nxKhM0uM+k3bjYAzUR+MPgqn2b6C5PxCaYsPMJjD6EXe/0sjRE80nG7XU91Yy/AybgM6eeQjibDqz9kYQkwO5PiYyvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736743874; c=relaxed/simple;
	bh=S63CSU21AWbKqU7Yo7WVZFz4heQJllA63bYDqczQ2PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1atd1n5VhiUBhfQeoLeUkGjrb2wMDURLQBhkor6WfHZ8CLrTThAQEWQxpdyL2Vt0HmVcXyVnlZSFeH9FpZk1XsLswBWXbNJ3yF5uviCv1sJ9ESJTCT6Vcp7fPXjWMbiF+hMSMMUrOtaoqbXhIKanKOU3QFetJxa/sNlUjOCc6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FiuGiIeQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uPlsrx9ZVc0SGEC8bFQUT4ARkO7TYxXAo/m+CH2fXUw=; b=FiuGiIeQjaoixiar4vW3LHa1ky
	unmhzXdYSwAPhKt/pjiWdO0FmlpO+RFeNNQzCVU8gYIY3xCq9k1fanSyUUXYvkUf4j++rA4BVEOHG
	vWM7Eux4ypVyFPybLErit3Deyxt/ggatCl2nTouu8U3Cc4NWe3+4KN42V0CHZeuM9L0uM/nbb1gxu
	g/CWziVL+Q/ecLCsHyEwgbU0FM9FdvWYA1Fcr2IwwAXYRfgLkfw7MFBv1WgKAmpZbt1f+iQLgOmWV
	jOI8EN4AhzZv4HJDQC0A7OC5K+e9WlXreTAm1e11Gjk3cRGfnOEbDCQy8UCkkmjlAJaNRJCmXdhLl
	kkRQAAfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tXCPw-0000000411H-3x81;
	Mon, 13 Jan 2025 04:51:12 +0000
Date: Sun, 12 Jan 2025 20:51:12 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFCv2 2/4] iomap: optional zero range dirty folio
 processing
Message-ID: <Z4SbwEbcp5AlxMIv@infradead.org>
References: <20241213150528.1003662-1-bfoster@redhat.com>
 <20241213150528.1003662-3-bfoster@redhat.com>
 <Z394x1XyN5F0fd4h@infradead.org>
 <Z4Fejwv9XmNkJEGl@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4Fejwv9XmNkJEGl@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jan 10, 2025 at 12:53:19PM -0500, Brian Foster wrote:
> processing.
> 
> For example, if we have a largish dirty folio backed by an unwritten
> extent with maybe a single block that is actually dirty, would we be
> alright to just zero the requested portion of the folio as long as some
> part of the folio is dirty? Given the historical ad hoc nature of XFS
> speculative prealloc zeroing, personally I don't see that as much of an
> issue in practice as long as subsequent reads return zeroes, but I could
> be missing something.

That's a very good question I haven't though about much yet.  And
everytime I try to think of the speculative preallocations and they're
implications my head begins to implode..

> > >  static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
> > >  {
> > > +	if (iter->fbatch) {
> > > +		folio_batch_release(iter->fbatch);
> > > +		kfree(iter->fbatch);
> > > +		iter->fbatch = NULL;
> > > +	}
> > 
> > Does it make sense to free the fbatch allocation on every iteration,
> > or should we keep the memory allocation around and only free it after
> > the last iteration?
> > 
> 
> In the current implementation the existence of the fbatch is what
> controls the folio lookup path, so we'd only want it for unwritten
> mappings. That said, this could be done differently with a flag or
> something that indicates whether to use the batch. Given that we release
> the folios anyways and zero range isn't the most frequent thing, I
> figured this keeps things simple for now. I don't really have a strong
> preference for either approach, however.

I was just worried about the overhead of allocating and freeing
it all the time.  OTOH we probably rarely have more than a single
extent to process with the batch right now.



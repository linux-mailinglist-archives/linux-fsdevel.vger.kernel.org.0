Return-Path: <linux-fsdevel+bounces-19481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF5B8C5E6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 02:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E226128285B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 00:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA241FA3;
	Wed, 15 May 2024 00:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X8v93qoj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D3463C;
	Wed, 15 May 2024 00:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715734266; cv=none; b=rpRMA/pOSLiknSt2KmFeuH1A0Uec0rFZC5Jy+c23KRa0woxbfQ1uvPWbiLESKWIf6CGUP3cl0Bfiy5Yj5rKSme2gbj7UwHmdW9xyMj50aZPnLQrJDm0e0tpgU2lz5G6BeaewdKojvM/NA09Fq2yIRa6ao8NfddnERo0kQlzBB94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715734266; c=relaxed/simple;
	bh=XrU4gVLUj+QtsCUrCpbdeajccpMXRTfCLj/RE4o1L8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpTO92RmBSqiyASOtFeRveTuuGCEKcHA9vltRNLljL/S5ZQ2e8BKiT0N3ZlJvaD3lZT6uscQUbi+6uBzrE6/CdI7Gx9od+IhfXuqxqdHDPfiL25WnPbvLMbAm5UqVlA5r3nZqNKMJ1lKxJPA+WO1qdompVGGAwIhvYO8TWpzy4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X8v93qoj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d2WoPf8FVGAZcrlDza9yKd8fs7vahaiBJfMXWRmXlLo=; b=X8v93qoj4H6mz6dpxY6CH+O6+B
	uGyvmf11d9aHWr19yR3YXSKyae4hQ3r7vY0u6PkTElCCjl699RDY3/r45ZYaSHDGbqoH4bcvXd3wb
	m41cTUh/MBHYUaia8peCEeaqtsVDPa1C49WnlwPGYnaohaWcNnXwy0JIrbPCyITQbDR3mY3Gvf2QM
	cac7FL8SiBdjsi52vs8spYabqZx2JzVMeSvB6UW9/qzrMJAv/Jt9gRe3WdMMebEY8GJvbiER/6aVH
	MyLOn+TWZ91DbeCIlEqwsz8RGHZxBD5JZpKQx7FR8+4yrp9QcjCb7KcUIBtpoxtgecxwCFmms1r+a
	buZC9bDA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s72r8-00000009gPC-08RP;
	Wed, 15 May 2024 00:50:54 +0000
Date: Wed, 15 May 2024 01:50:53 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: hch@lst.de, mcgrof@kernel.org, akpm@linux-foundation.org,
	brauner@kernel.org, chandan.babu@oracle.com, david@fromorbit.com,
	djwong@kernel.org, gost.dev@samsung.com, hare@suse.de,
	john.g.garry@oracle.com, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	ritesh.list@gmail.com, ziy@nvidia.com
Subject: Re: [RFC] iomap: use huge zero folio in iomap_dio_zero
Message-ID: <ZkQG7bdFStBLFv3g@casper.infradead.org>
References: <20240503095353.3798063-8-mcgrof@kernel.org>
 <20240507145811.52987-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507145811.52987-1-kernel@pankajraghav.com>

On Tue, May 07, 2024 at 04:58:12PM +0200, Pankaj Raghav (Samsung) wrote:
> Instead of looping with ZERO_PAGE, use a huge zero folio to zero pad the
> block. Fallback to ZERO_PAGE if mm_get_huge_zero_folio() fails.

So the block people say we're doing this all wrong.  We should be
issuing a REQ_OP_WRITE_ZEROES bio, and the block layer will take care of
using the ZERO_PAGE if the hardware doesn't natively support
WRITE_ZEROES or a DISCARD that zeroes or ...


I suspect all these places should be checked to see if they can use
WRITE_ZEROES too:

fs/bcachefs/checksum.c:                         page_address(ZERO_PAGE(0)), page_len);
fs/bcachefs/io_write.c:         if (bv->bv_page != ZERO_PAGE(0))
fs/bcachefs/quota.c:            if (memcmp(mq, page_address(ZERO_PAGE(0)), sizeof(*mq))) {
fs/cramfs/inode.c:              return page_address(ZERO_PAGE(0));
fs/crypto/bio.c:                ret = bio_add_page(bio, ZERO_PAGE(0), bytes_this_page, 0);
fs/crypto/bio.c:                                                      ZERO_PAGE(0), pages[i],
fs/direct-io.c:         dio->pages[0] = ZERO_PAGE(0);
fs/direct-io.c: page = ZERO_PAGE(0);
fs/iomap/direct-io.c:   struct page *page = ZERO_PAGE(0);



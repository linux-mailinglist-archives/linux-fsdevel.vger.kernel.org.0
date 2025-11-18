Return-Path: <linux-fsdevel+bounces-68940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B59C6979B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 13:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0DD683539C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 12:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4950F23E346;
	Tue, 18 Nov 2025 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UMShjRt3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F2A1FE44A;
	Tue, 18 Nov 2025 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763470324; cv=none; b=Rj4/oid2SCt0O0IvByhOJHvRXsiw27LQ9QufuFTk+Nk3y7nLi99xKMAzMZ0149XlxkIxbbxBpyNhx061VGiagGb4aUFBywZAPCTUOUTTiyfOwrP/LmPLE5KRNLcDKegZP/ScDry/b8gTTkLc1v0R3E/ZtjHpRigRCZp+FAOcanU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763470324; c=relaxed/simple;
	bh=klAfDHUdmhbvO7+Qa147C+Zm+QmcHrqs0bD7pqivDUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pgft5XHF1iAvyXVLR3bTn81qgH2UnRgaAF3L17/WuzzbpaCfehHo0D6VPqjkNtTTgmIySxzlATidiOf91u6pODHuPDuqmnNXcT3XmgapLiEoZkE4SMEbOtEbOFEaEtbYEjd1uXlSXtgxXR1SoC6o8kJoB0wjz7GmucNwVFIE7dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UMShjRt3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OzxLKs39PWDbcq4Lbqe/ZoP4a39VPMRKYU7TDvRKOxU=; b=UMShjRt32ga8qnRRWFrepB2Pgz
	OgEt5WtRa5Trl4ds6e5rKqrXJoP8wUOyus3IVsusUjlJ8oszfliaxlucomDLrBxZrddCOcny5698t
	BSk1G9c3nnsYTKVX+xuGppqOi7asRlYQlUXF8Ixxt8JQJ7FDjN3VrqSYyoAt7YTOdzNuCrl9YyMEp
	oP78RDKeE2AElybsO5Dq48Wmb9I7LQVfi5GyMupPE6LqZ3jCUrzYYPt13Y/p5LtLTlhywjQJK7Ywz
	42dI2tc2yvJD+62zjtzY57kSMr9ERElNlra4MidXQcKbuQNE9yng6enKYvdJf2G92TxwnIFoQhMU5
	JFgspVcQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLLBW-0000000FUZC-37rp;
	Tue, 18 Nov 2025 12:51:50 +0000
Date: Tue, 18 Nov 2025 12:51:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>, akpm@linux-foundation.org,
	shakeel.butt@linux.dev, eddyz87@gmail.com, andrii@kernel.org,
	ast@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org,
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/filemap: fix NULL pointer dereference in
 do_read_cache_folio()
Message-ID: <aRxr5l-usmPvenbM@casper.infradead.org>
References: <20251114193729.251892-1-ssranevjti@gmail.com>
 <aReUv1kVACh3UKv-@casper.infradead.org>
 <CANNWa07Y_GPKuYNQ0ncWHGa4KX91QFosz6WGJ9P6-AJQniD3zw@mail.gmail.com>
 <aRpQ7LTZDP-Xz-Sr@casper.infradead.org>
 <aRv-jfh0WkVZLd_d@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRv-jfh0WkVZLd_d@infradead.org>

On Mon, Nov 17, 2025 at 09:05:17PM -0800, Christoph Hellwig wrote:
> On Sun, Nov 16, 2025 at 10:32:12PM +0000, Matthew Wilcox wrote:
> > I don't think it's necessarily all that hard to make buildid work
> > for DAX.  It's probably something like:
> > 
> > 	if (IS_DAX(file_inode(file)))
> > 		kernel_read(file, buf, count, &pos);
> > 
> > but that's just off the top of my head.
> 
> The code should just unconditionally use kernel_read().  Relying
> on ->read_folio to just work is only something file system code and
> library code called by the file systems can assume.
> 
> Something reading ELF headers has no bunsiness poking into this layer.

Please read the rest of the thread; this code can be called in contexts
that can't block.  That was why I proposed the kiocb_read() refactoring
that I would expect you to have an opinion on.


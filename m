Return-Path: <linux-fsdevel+bounces-20886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCB08FA90B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 06:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DB0288AC7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 04:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE58839FC;
	Tue,  4 Jun 2024 04:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JSQNjaS1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A7038B
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 04:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717474103; cv=none; b=ErzXPfKC0Txzgp83fOX2Vt7UmByeNzq+VNTdjONHgM0OqduCSj10dvDZ+ABr7Hf8C7GbJhYABjO++pZQvTSSxamO35NYdQREKoXrBc9vMxQPA4M6I7P6VruTpPJfq5qanqhjP0f96pSlmi22KZk2RZylebXJsjr7MpXBAIsOODY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717474103; c=relaxed/simple;
	bh=F966li4SdxEPItmPQuQ6mfwrFLHv0y7d2PqXvOgktsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kh6BV0hx+dYgbUtksGtmqCDOk0Llu0yjgIj3uCiQ5YTVM3vgiokklD5FW2ro9bq53nKa9OHaYUdWbV95eKVEIvqxeP+T4jzjZi1Bf19og/7bdds7blASZ5xSUBDQe0To4gROk+5o7m0I+ohdtuucmw7ZcNFqYktkxpP5jEd0tME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JSQNjaS1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AmRDFRq2h+wkvcIuVopUs9+FGy5YQEUrcZGBabJNXm0=; b=JSQNjaS1pAcDInk6ao4C2YLd/4
	Nq5dYtco79G3NfXQ/4VQBxW7Y+3YcI9MfS1Wy2l+tpPbtoSEJ63C219YRqoV2SBd9d8qaUGnGVB7P
	lrefRsbVGeI6sP3cEYE1DfWc+CCV9TQ0P2/1GPOeaM4245ZKL1pI6NmvRWLI1coSnjcxbEvjvpILn
	dhlWu7J5JQRsah/TgXlG8Dhwx3A6SlCMWqA0yTRn++0mBuvYeRF4DOj9LqrIeTPpV5+M5x6ZJkKWh
	entKWY48lcGLpidZ9Vvv2OaOGGW/n1bx4YJKIK3IzcJEbwdf7qkTYYhFbKFtS7RksnbiuLvpf9LcI
	UCcRpZYw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sELT7-000000018kQ-0JBm;
	Tue, 04 Jun 2024 04:08:17 +0000
Date: Mon, 3 Jun 2024 21:08:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bernd Schubert <bschubert@ddn.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH RFC v2 06/19] Add a vmalloc_node_user function
Message-ID: <Zl6TMVrCm43Jy7zc@infradead.org>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-6-d149476b1d65@ddn.com>
 <ZlnW8UFrGmY-kgoV@infradead.org>
 <sxnfn6u4szyly7yu54pyhtg44qe3hlwjgok4xw3a5mr3r2vrwb@3lecpeavc2os>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sxnfn6u4szyly7yu54pyhtg44qe3hlwjgok4xw3a5mr3r2vrwb@3lecpeavc2os>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 03, 2024 at 11:59:01AM -0400, Kent Overstreet wrote:
> On Fri, May 31, 2024 at 06:56:01AM -0700, Christoph Hellwig wrote:
> > >  void *vmalloc_user(unsigned long size)
> > >  {
> > > -	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
> > > -				    GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL,
> > > -				    VM_USERMAP, NUMA_NO_NODE,
> > > -				    __builtin_return_address(0));
> > > +	return _vmalloc_node_user(size, NUMA_NO_NODE);
> > 
> > But I suspect simply adding a gfp_t argument to vmalloc_node might be
> > a much easier to use interface here, even if it would need a sanity
> > check to only allow for actually useful to vmalloc flags.
> 
> vmalloc doesn't properly support gfp flags due to page table allocation

Which I tried to cover by the above "to only allow for actually useful
to vmalloc flags".  I.e. the __GFP_ZERO used here is useful, as would be
a GFP_USER which we'd probably actually want here as well.


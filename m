Return-Path: <linux-fsdevel+bounces-50462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D051ACC792
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E114318945DB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBDB22D9ED;
	Tue,  3 Jun 2025 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zx62paCd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42A513C8E8;
	Tue,  3 Jun 2025 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748956787; cv=none; b=OzXII4s0dwiLfSMYhUhxKE0BzT4o5fXm0ASiDpQl37X1SMucw7LmFm2tUItG3H5g0oIqqj6qpKBw1tmy/HuVV7YDMTyTFDVAUjQYzH9MHuXLu/Rf5MeguQJ5pgnia44iw7QebZust6ytp13PfrL3f0wW1LwqJizy+xgNdknDMy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748956787; c=relaxed/simple;
	bh=4zckt7TbeInVzta8xoxiyPesS/ueBZE4ZUAMclJmViY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCHpKqV6WAfI2kYpsbfZaNpbIOmvrGuqWDmCoLd0ewu1WsgmEuvi+IWfNqbj5Rgqee8qy6SBCQGXRJVgKYpN0uRxm5Ef+1p3B4yYkgB+Pa0/VImDlXy9Y4oKZK8cyDFkYEnzzzoSmg5M9n6GPgbBFZYBkPXg0di+Cg0uFwbcofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zx62paCd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=IMyZpNPWuRD8Yt0Bj66tbpS5jFHAY+R03rfqd24z1tA=; b=Zx62paCdRIfY0a9wF1dF/rAnNo
	UiHTftfyE+VGyqJw2HuPeDULbIREjlmcy3gsX/PpD0vl91RQKOjPUf80vBJyOYXNYYOvQWp51X0az
	28iNgL0C6G1PkGFGA/O/X50dvI586E5cM6uuXdEeMXCnDiGkmWwz+ybw5XaMPcnF04tWsNM2lhXPL
	qQG+LPDKpcTmCnzRrFrZvTxc/Z2izJLAJvnUt7mQKGQRrzVCedZELM+5pxIeSGdU09pIPsEZQGote
	dWu2tqnaHPFjDJdBXCVu3HNouwDQ3iB3IQj5QrXprdLj3shYEHJfcAcfjQwRnVrG5PyT3IByVNWjb
	lOa4UeiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMRYI-0000000B0wB-3pbC;
	Tue, 03 Jun 2025 13:19:38 +0000
Date: Tue, 3 Jun 2025 06:19:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Christoph Hellwig <hch@infradead.org>, wangtao <tao.wangtao@honor.com>,
	sumit.semwal@linaro.org, kraxel@redhat.com,
	vivek.kasireddy@intel.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hughd@google.com, akpm@linux-foundation.org,
	amir73il@gmail.com, benjamin.gaignard@collabora.com,
	Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com,
	jack@suse.cz, baolin.wang@linux.alibaba.com,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	bintian.wang@honor.com, yipengxiang@honor.com, liulu.liu@honor.com,
	feng.han@honor.com
Subject: Re: [PATCH v4 0/4] Implement dmabuf direct I/O via copy_file_range
Message-ID: <aD72alIxu718uri4@infradead.org>
References: <20250603095245.17478-1-tao.wangtao@honor.com>
 <aD7x_b0hVyvZDUsl@infradead.org>
 <09c8fb7c-a337-4813-9f44-3a538c4ee8b1@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09c8fb7c-a337-4813-9f44-3a538c4ee8b1@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 03, 2025 at 03:14:20PM +0200, Christian König wrote:
> On 6/3/25 15:00, Christoph Hellwig wrote:
> > This is a really weird interface.  No one has yet to explain why dmabuf
> > is so special that we can't support direct I/O to it when we can support
> > it to otherwise exotic mappings like PCI P2P ones.
> 
> With udmabuf you can do direct I/O, it's just inefficient to walk the
> page tables for it when you already have an array of all the folios.

Does it matter compared to the I/O in this case?

Either way there has been talk (in case of networking implementations)
that use a dmabuf as a first class container for lower level I/O.
I'd much rather do that than adding odd side interfaces.  I.e. have
a version of splice that doesn't bother with the pipe, but instead
just uses in-kernel direct I/O on one side and dmabuf-provided folios
on the other.



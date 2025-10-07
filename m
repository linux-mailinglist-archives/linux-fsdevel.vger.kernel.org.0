Return-Path: <linux-fsdevel+bounces-63526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E977DBC0211
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 06:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39703A69C1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 04:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1320221859A;
	Tue,  7 Oct 2025 04:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PAQipcac"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECA720FAAB;
	Tue,  7 Oct 2025 04:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759809923; cv=none; b=eMzP5+j7LcPRdfsJMvMPf3sXILPKpDR/CiQGSD3GkYwaiHeJY09BfDAAfcAJ3uz+y9YxNu0+ElzL8b3q7Dx4b5Syx8NoQWUwHOt8RjT+pUKcx35FVNsgBgPt8KlA/o/avisX/kQd2+LR5gfXcNKCl9p6VHlRErEAblajQMVg4mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759809923; c=relaxed/simple;
	bh=0dJNJ+VhAuGP5ZyzATwMiFGMegzDbez/iRWbSVzSyug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7Ew80H8xjS5sxTELEWan9f/YNsGZ5NoJPlRWYh4uXiKWEY1ZkSA2s+pOd5I76UZTyLJjGpSe80e8ShYLqfEhGmJMi8uGsSz6w3hNmFgENSNKCN7CXaqQGcUnA8xdgnTPsVI/SkRkukovrrakAPVwJPX63V7ZNGadO8ZeRLj+bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PAQipcac; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QYDVnqB7iQXOgXr2iKKcl8B6YeN2q3jw9LwVc5Cc9VA=; b=PAQipcacPi4Q5nOLf5cnGWepDe
	tt1H5Y0tCt6miyjf3KLW3NnMBVCujRZ92esP1IFlBQRD1FXf6Z9o4pwf+yiDFuggrdPj9HuVHrMRV
	KPkG6JTBHp6XHLRXmEg65+Lr3TFXimnkND6q6shqrDIyFRw1kyoz4lZNO6N1gI7q1ov5p87/FA8pw
	9yWcbRHG1LA3DGI04jD6exaNLS9sAp7iTUSmF8FlyIbmMC63g969pQ19s6iQS+cxCleVoZ09vbnuy
	ybgWtSQh4vCOlpNU7E+lvz5kZRv6JVl5Sousq8UD43sANQ5l+LX5KE4wvWz8mK5u8gjOeV79FB5se
	OEzFlraQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5ywt-00000001EmY-3flM;
	Tue, 07 Oct 2025 04:05:15 +0000
Date: Mon, 6 Oct 2025 21:05:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] iomap: ensure iomap_dio_bio_iter() only submit bios
 that are fs block aligned
Message-ID: <aOSRe1wDI5JD_wvc@infradead.org>
References: <aeed3476f7cff20c59172f790167b5879f5fec87.1759806405.git.wqu@suse.com>
 <aOSOaYLpBOZwMMF9@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOSOaYLpBOZwMMF9@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 07, 2025 at 04:52:09AM +0100, Matthew Wilcox wrote:
> On Tue, Oct 07, 2025 at 01:40:22PM +1030, Qu Wenruo wrote:
> > During my development of btrfs bs > ps support, I hit some read bios
> > that are submitted from iomap to btrfs, but are not aligned to fs block
> > size.
> > 
> > In my case the fs block size is 8K, the page size is 4K. The ASSERT()
> > looks like this:
> 
> Why isn't bdev_logical_block_size() set correctly by btrfs?

bdev_logical_block_size is never set by the file system.  It is the LBA
size of the underlying block device.  But if the file system block size
is larger AND the file system needs to do file system block size
granularity operations that is not the correct boundary.  See also the
iov_iter_alignment for always COW / zoned file system in
xfs_file_dio_write.



Return-Path: <linux-fsdevel+bounces-66799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D0AC2C5E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 15:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E4D3BCE5F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 14:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DFB305056;
	Mon,  3 Nov 2025 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0w3eG3YO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7FC22FAFD;
	Mon,  3 Nov 2025 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179145; cv=none; b=dVAz/O7MXMUZe37ww4FKAGzqT8cFTUH7mknOv6sM7ngtS/Z2quT5h3HD077jxpr6ylUM4r5cTf3Lh4IBBBWfixKgVmVMfv/m2FtmZgOj0LqrCA/KBFFr+m/J3yeOt8NUmeNpAAwDeBTO0oubAQWPL1Uc/sfBJVyeTQsLP7FrYMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179145; c=relaxed/simple;
	bh=ilIZIpOzxo0vMLzlT+FUShn/ORFaaMZFYXqI2jDx8Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h27sWfliFFkelIcnF6yqfmvOKbSnw11GAGmvPxAfIK9WVwZKla3IGP6gxQlWWCDhZ12r8FxxhwzYVBaaLRiBFZYy39+yarAc8WtWpysBCklhgM+qW/G2qbY+GmfXriKnskdHf+J+t/cCAjA3Nze/rgM3tWb+C2FJfW4O4MVc+9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0w3eG3YO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I/+ppzjeuB1VxkT2dp3Hv/N7bgrac9alC6j10M2k1n4=; b=0w3eG3YOLP0UKnGdRXaZU+j61+
	coz2qVF5rG0+5z+Hng8RDVYOQzek1NYN2palD0JEeWcyp6tF4/InpLllVN5l2T0PB2qX5nsYA32aD
	1wMWKSuPZiJZznoPshHqjpZkim+VCwiSBYWmXd6/QWyBzgjHO6aqtgeKBBs3EUz8lSSr0FY+Asctw
	mzmZYeLsMg6WnXu+V0hklg5iaDbTFOsszxdxjGhN2ntev1asSKnSeXD02qryL+5LVtLSF7ysvCpao
	+MfzbA2CBrzjaV3r6cv0f8c+nYvfJOYXbqEgr4nqkmzjIifw4dj5W+qE1Xk+vkt1krspfKbf1vUZO
	PYTX0J/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFvIB-0000000A0QY-0kkM;
	Mon, 03 Nov 2025 14:12:19 +0000
Date: Mon, 3 Nov 2025 06:12:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: Re: [PATCH v3] fix missing sb_min_blocksize() return value checks in
 some filesystems
Message-ID: <aQi4Q536D6VviQ-6@infradead.org>
References: <20251103135024.35289-1-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103135024.35289-1-yangyongpeng.storage@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 03, 2025 at 09:50:24PM +0800, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> When emulating an nvme device on qemu with both logical_block_size and
> physical_block_size set to 8 KiB, but without format, a kernel panic
> was triggered during the early boot stage while attempting to mount a
> vfat filesystem.

Please split this into a patch per file system, with a proper commit
log for each.

> Cc: <stable@vger.kernel.org> # v6.15
> Fixes: a64e5a596067bd ("bdev: add back PAGE_SIZE block size validation
> for sb_set_blocksize()")

That just adds back one error case in sb_set_blocksize.

The Fixes tag should be for the commit adding the call to
sb_set_blocksize / sb_min_blocksize in each of the file systems.



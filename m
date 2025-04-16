Return-Path: <linux-fsdevel+bounces-46532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4185A8AF1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 06:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C18441C88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 04:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3542229B3C;
	Wed, 16 Apr 2025 04:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Za48eWoZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6DB1A3144;
	Wed, 16 Apr 2025 04:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744778495; cv=none; b=IAQQwvqtRCaPZy/QOPVWp1zHZaQSrhpDl7Pw+CNhad4QakHSZw6xDvtR3YVD7IgD9CPpTyP3QzJKT5fbMHOT/UKkNY6Pq7Oelv/9NPHXhsVRc94xLYj12BCLVh3Hfom7wapPrim2ykh88JjUjoRP5qwbuIzj6mIsbuLmIC/X1t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744778495; c=relaxed/simple;
	bh=OibJN0w9jAxEe8p3f+GtJU0vGjtOQiICQKSYtbxfulU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKVZlQm7XYxti97JL+Ep/wjwJyXfPY6srWBLJGbzleS00pVVVejfdv8M06tDl+/JdquiCAxA107EvvqqdomrXGu1jNU8WNYgU2+155fu4lTgg6ds/USdhH3KcXNZnEZfeVccqcRjBI6bKUJ3F5jWTfc9fecigRdmmC8soGb+uBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Za48eWoZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=frCeEBjvttsVcdvt8XY/0LGbxQeap/dL5eJvtPFV3rg=; b=Za48eWoZ4XG8NLWu0oYRV/5m9/
	qHeQ44cmzb28TcGYrfVjeBku36JUEmJpcUPpIx7ACSgCEeihdz+9U6PjEMmoMTX35nVVoMm/quG+i
	Ek/3Mhu/hK1KlH71XL9KI6FqJv4FBvs2tOO/LGrVJaJY9pi3K/KZKILAsAb3q00OEAqC7TPWu7SEH
	7TsVLRr+lqriIJ572Ef2iEKzwAknrVZFveeTgo3pfYVdWdRcmPlty3fp0q6ggPSWanusMD2DBX2X5
	AHsQg4WK1DQiPcTuk2ydR6u6yoZhuqVFEl+rD0R6pTtaxoZiYhNfOr9u0AYJ56b5E8BPaEjXj9P8y
	YbunwJFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4uaa-00000008AjM-4ANg;
	Wed, 16 Apr 2025 04:41:32 +0000
Date: Tue, 15 Apr 2025 21:41:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: axboe@kernel.dk, Christoph Hellwig <hch@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-block <linux-block@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>, Jack Vogel <jack.vogel@oracle.com>
Subject: Re: [RFC[RAP] 1/2] block: fix race between set_blocksize and read
 paths
Message-ID: <Z_80_EXzPUiAow2I@infradead.org>
References: <20250415001405.GA25659@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415001405.GA25659@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 14, 2025 at 05:14:05PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> With the new large sector size support, it's now the case that
> set_blocksize can change i_blksize and the folio order in a manner that
> conflicts with a concurrent reader and causes a kernel crash.
> 
> Specifically, let's say that udev-worker calls libblkid to detect the
> labels on a block device.  The read call can create an order-0 folio to
> read the first 4096 bytes from the disk.  But then udev is preempted.
> 
> Next, someone tries to mount an 8k-sectorsize filesystem from the same
> block device.  The filesystem calls set_blksize, which sets i_blksize to
> 8192 and the minimum folio order to 1.
> 
> Now udev resumes, still holding the order-0 folio it allocated.  It then
> tries to schedule a read bio and do_mpage_readahead tries to create
> bufferheads for the folio.  Unfortunately, blocks_per_folio == 0 because
> the page size is 4096 but the blocksize is 8192 so no bufferheads are
> attached and the bh walk never sets bdev.  We then submit the bio with a
> NULL block device and crash.
> 

Do we have a testcase for blktests or xfstests for this?  The issue is
subtle and some of the code in the patch looks easy to accidentally
break again (not the fault of this patch primarily).

>  	} else {
> +		inode_lock_shared(bd_inode);
>  		ret = blkdev_buffered_write(iocb, from);
> +		inode_unlock_shared(bd_inode);

Does this need a comment why we take i_rwsem?

> +	inode_lock_shared(bd_inode);
>  	ret = filemap_read(iocb, to, ret);
> +	inode_unlock_shared(bd_inode);

Same here.  Especially as the protection is now heavier than for most
file systems.

I also wonder if we need locking asserts in some of the write side
functions that expect the shared inode lock and invalidate lock now?



Return-Path: <linux-fsdevel+bounces-63529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B3ABC0260
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 06:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0193D3C11B5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 04:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB8921A94F;
	Tue,  7 Oct 2025 04:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I77Qri3N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E011F19A;
	Tue,  7 Oct 2025 04:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759811075; cv=none; b=e1NeFQDEzZa7dygxKScr2DJH9P75dtLfGa8mK2yfZIdtbwcqiMN0thmQGbrenSKABltYyEfy8DMgMXqCdM+2U0a9XTdmi/Nsjh0f1LtGYTPjTXEpi/OI1EmdR2OULoBWFw4hFrni4kjAJ2/bI4T7npLEFSeSEfhu2zVsb+OFUVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759811075; c=relaxed/simple;
	bh=U89/3QmjhzOftDxo+uaIDDNKZ1rqVAIHJ2uTdgAtjD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/aehn3KE5c7GDPd55hgiw1SwviOCjjdFKESCepO/YSNTNtDKY7Ajh5ITCxRR5AK0cgrAloXManFFTR4mFGGmjKKH9BBrq5phx1YMvxeqqRV+pwvJ/g43DYYKodM84piOg0KQFLGIH32HzTxDSoQSOSMuIcaGKM/t59VHwQ39pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I77Qri3N; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CNH+vHYgkl69sbT5f8PfyRC+F0WBajoXTglmrdjKuU4=; b=I77Qri3N0rUyqqSd3ZgrX1fTxU
	39xs7Wbzz712suK5dXYEHE2opouzJ2iKBFg2xe5jYYmhJSkWee7lECPRdZR7anTM2kfPItFK6jyhj
	Drg6IwO2s8g53LZgLAdeeT43dV2p6dvXuyL6v7tPvIUgLEhNUNoh0pykYsQ/rDqylGgh/hYvEafTA
	UAHR6HtME66tcLyEtpDsnth461NP7daR0sE2UDGK6S/rE0JWh4Ld1zQVSSeJLCTaxuxnrNNP8AxNT
	tqAASb26EfUSILzzN84S3iExiYCLmB+nTjPPaXaeGJECvbRrhvsywu/rF4roXqgET5oe2lpkZ8r5j
	377TEUZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5zFZ-00000001FRg-2AH7;
	Tue, 07 Oct 2025 04:24:33 +0000
Date: Mon, 6 Oct 2025 21:24:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, brauner@kernel.org, djwong@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] iomap: ensure iomap_dio_bio_iter() only submit bios
 that are fs block aligned
Message-ID: <aOSWAShrcxxzgDPq@infradead.org>
References: <aeed3476f7cff20c59172f790167b5879f5fec87.1759806405.git.wqu@suse.com>
 <aOSOaYLpBOZwMMF9@casper.infradead.org>
 <aOSRe1wDI5JD_wvc@infradead.org>
 <aOSU3h7tTLz-qDeE@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOSU3h7tTLz-qDeE@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 07, 2025 at 05:19:42AM +0100, Matthew Wilcox wrote:
> > bdev_logical_block_size is never set by the file system.  It is the LBA
> > size of the underlying block device.  But if the file system block size
> > is larger AND the file system needs to do file system block size
> > granularity operations that is not the correct boundary.  See also the
> > iov_iter_alignment for always COW / zoned file system in
> > xfs_file_dio_write.
> 
> But the case he's complaining about is bs>PS, so the LBA size really is
> larger than PAGE_SIZE.

The file system block size is, the LBA probably is not unless Qu is
running on not generally available prototype hardware.


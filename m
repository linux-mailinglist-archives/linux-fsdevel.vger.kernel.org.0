Return-Path: <linux-fsdevel+bounces-46536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 770E2A8AF8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 07:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9552D3A5CBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 05:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FA622A1E5;
	Wed, 16 Apr 2025 05:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="03MCjjrL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D1220012C;
	Wed, 16 Apr 2025 05:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744780469; cv=none; b=Gcma54CdYQwbMMz24D3bICg/++Nt08cxLOruwhhJvCS48C9A3yyKrdoleLik0Ir8nd2z6Z02KhUeP41eodtPDFnk0XvE5/AnCsCvV1l/jVJjgmOtamFLfwMjwWIoUP63wqU2cRAMkgcUNL8woezXkh4cFXk1SDXxm3d8KnAdp8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744780469; c=relaxed/simple;
	bh=8h7WW1FnI/nvIPgKqAkD9uBYO+6zSAESWqco0XydnMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgVEVDfzUeqJ7vPtho8pU8LcQ+bIe/1eNqqMZQD2Bkf5VSQD/Ls9pnm5Vb4YHfeOA+E/Bl/42rl7xm2nF0gHo9eFADZ7hM+xE2bJGdLu8cOfN+Vr7CPEdrYECQ7fpqa8WZQkgpCgx/4VI2PQepY3X1gKzAM9bHkMQsEHy90qrgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=03MCjjrL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qsGzg3Sd5C0Y3pw8kB1gwhQlffBa5k4R/Ymp6+h5h8A=; b=03MCjjrL2eROzOGyXlpddzFvbL
	9RWSQW2THHFOjqCfSsqnd2wu7nnBqk1C/1Tgh5K3GhHoyzS9Eurt6KOyOpIkh/O/OvVbn1vJISZ0B
	HvNZ54L5fMRvxXlsq/nWJwQBZYCWRev5izaQz2TX5AM32+dVS5EhXrCfvQ6I4hOzU6m2z2eAL1RPr
	esj6r+aM8BPRHMC8fE1sjSiZIXjVcQD/25rgDomUvEVpXIETshsdEc0vqh13HgCWY/nmJkIoCi1og
	pKQP2/S1K9K+MBlBLU6ZcAUhGmz/HUxWlFOPpcHqGdlGJJ68uiMaX9GHbHQcEaV6mCgwi+C7rtfgw
	cbkuVQ5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4v6R-00000008EMG-1x7w;
	Wed, 16 Apr 2025 05:14:27 +0000
Date: Tue, 15 Apr 2025 22:14:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-block <linux-block@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>, Jack Vogel <jack.vogel@oracle.com>
Subject: Re: [RFC[RAP] 1/2] block: fix race between set_blocksize and read
 paths
Message-ID: <Z_88swOZp_SlQYgC@infradead.org>
References: <20250415001405.GA25659@frogsfrogsfrogs>
 <Z_80_EXzPUiAow2I@infradead.org>
 <20250416050144.GZ25675@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416050144.GZ25675@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Apr 15, 2025 at 10:01:44PM -0700, Darrick J. Wong wrote:
> It's the same patch as:
> https://lore.kernel.org/linux-fsdevel/20250408175125.GL6266@frogsfrogsfrogs/
> 
> which is to say, xfs/032 with while true; do blkid; done running in the
> background to increase the chances of a collision.

I think the xfs-zoned CI actually hit this with 032 without any extra
action the.

> 	/*
> 	 * Flush and truncate the pagecache before we reconfigure the
> 	 * mapping geometry because folio sizes are variable now.  If
> 	 * a reader has already allocated a folio whose size is smaller
> 	 * than the new min_order but invokes readahead after the new
> 	 * min_order becomes visible, readahead will think there are
> 	 * "zero" blocks per folio and crash.
> 	 */
> 
> And then the read/write paths can say something simpler:
> 
> 	/*
> 	 * Take i_rwsem and invalidate_lock to avoid racing with a
> 	 * blocksize change punching out the pagecache.
> 	 */

Sounds reasonable.

> > I also wonder if we need locking asserts in some of the write side
> > functions that expect the shared inode lock and invalidate lock now?
> 
> Probably.  Do you have specific places in mind?

Looking at it more closely: no.  We're only calling very low-level
helpers, so this might not actually be feasible.



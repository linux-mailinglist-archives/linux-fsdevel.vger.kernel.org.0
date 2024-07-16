Return-Path: <linux-fsdevel+bounces-23772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C23F932A6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 17:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4931C22F11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 15:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1441719E7D0;
	Tue, 16 Jul 2024 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wlwvi9e1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE323198E80;
	Tue, 16 Jul 2024 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721143752; cv=none; b=M7PC79S7JikE6q2vhg3ewxNbeiZ0BHMcsOFna2UDMW3VAAJTqAPp2HFhOWqHbHMGu+QI2iRsX9amognPYg7yxSJ/Vw+SmRvRC0HBktG3DP15YEPDDMPs/bpiZnSmFwsWxnsYQiIb5hfaLVSmkyzgor9vC7SKmmT3RXzTLHXpzr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721143752; c=relaxed/simple;
	bh=tsJ3Z0dkia4spcBcQ5hQV4+nk+BSDMUbilC0I/SkX4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eF1QPZTR8wI7vYtfVSkUJ0b2mYMfdCvir0tyLkHRcEuQ8A7b7GIfJFSCoKvv0VepRvKBlE1engMAfyHtcrS/HFJvixLLCuytwo0fnEQnZ7+cY96/mh1cr2AIWvvcyDRUebVs5FHkok+immMEhHMZP4Y4S3BCZMGRm9gRS4o0Sf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wlwvi9e1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dDRACH2HHcim9UX3PaS7VDc6SEL6ZuTEADUo9eEcXBU=; b=Wlwvi9e1dHjqquYLnaeF8bHCg1
	7oMEeKnsZn5q9sOKHcqJD6DtVV6MLOfKapWL5pbQdKf3Uz43lVqw4z7cCK3sSrSCfdrtTEHcnbsUJ
	tWYsBSKInnqUP9l1ggBzQWkMmfpNILYOulsy3V3CYowleZNp8c22g99QK/6H8/eLKejFq/GHSt2b7
	NpZijnKeJHDMQEcGafV0HxCKSF/hr5hYV18Db26UvBPVLh7fuRCHFNYs6N7gE9FnMO5y2V3xi0wCH
	LHxe7+ZY/9Q3n3JAdVrhWlR1oN0aQezV+bykYgRJ2gpyxjUb1GR/HG5Ew+bGSfoHmWu8FYLkcxbxd
	vpsWQclA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTk6z-0000000HFSe-0jAP;
	Tue, 16 Jul 2024 15:29:05 +0000
Date: Tue, 16 Jul 2024 16:29:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, chandan.babu@oracle.com, djwong@kernel.org,
	brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, ryan.roberts@arm.com, hch@lst.de,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v10 10/10] xfs: enable block size larger than page size
 support
Message-ID: <ZpaRwdi3Vo3qutyk@casper.infradead.org>
References: <20240715094457.452836-1-kernel@pankajraghav.com>
 <20240715094457.452836-11-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715094457.452836-11-kernel@pankajraghav.com>

On Mon, Jul 15, 2024 at 11:44:57AM +0200, Pankaj Raghav (Samsung) wrote:
> +++ b/fs/xfs/xfs_super.c
> @@ -1638,16 +1638,30 @@ xfs_fs_fill_super(
>  		goto out_free_sb;
>  	}
>  
> -	/*
> -	 * Until this is fixed only page-sized or smaller data blocks work.
> -	 */
>  	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
> -		xfs_warn(mp,
> -		"File system with blocksize %d bytes. "
> -		"Only pagesize (%ld) or less will currently work.",
> +		size_t max_folio_size = mapping_max_folio_size_supported();
> +
> +		if (!xfs_has_crc(mp)) {
> +			xfs_warn(mp,
> +"V4 Filesystem with blocksize %d bytes. Only pagesize (%ld) or less is supported.",
>  				mp->m_sb.sb_blocksize, PAGE_SIZE);
> -		error = -ENOSYS;
> -		goto out_free_sb;
> +			error = -ENOSYS;
> +			goto out_free_sb;
> +		}
> +
> +		if (mp->m_sb.sb_blocksize > max_folio_size) {
> +			xfs_warn(mp,
> +"block size (%u bytes) not supported; maximum folio size supported in "\
> +"the page cache is (%ld bytes). Check MAX_PAGECACHE_ORDER (%d)",
> +			mp->m_sb.sb_blocksize, max_folio_size,
> +			MAX_PAGECACHE_ORDER);

Again, too much message.  Way too much.  We shouldn't even allow block
devices to be created if their block size is larger than the max supported
by the page cache.



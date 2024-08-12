Return-Path: <linux-fsdevel+bounces-25685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCC294EFC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 16:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEB4BB22C8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CDB183CA6;
	Mon, 12 Aug 2024 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d071O82E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADEA14C5A4;
	Mon, 12 Aug 2024 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473580; cv=none; b=ataHe1xnzDSdAYbmA2VUXdSwruQpP87w3cADvquIHg4DxF/RypKdsOqeYbKmPpjiCCSQ2Wo76sxlPrWMoJKhO+45VEO6bpLk2Wy9ELsrhlXalh3ps0mtbgDrCzqBhf7IS5ZaQvCvPSegf704v5V15W/Tqgte6CYNIA3q6fM30dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473580; c=relaxed/simple;
	bh=X7b1kEjfecMMoXWWV3HinlADCRydpY6O1Ae8ZBvwHW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fczKkdETaF+8V9WEKHnJvXOeEDPIhCj+YoARaAA0++bNz0jMmJhpAwm4V9MpUn/HzN1ncE4DyLsIGTUp3+uaAyebn6fvKQRR/PaSR5LS08me7PXchseGv8Dx8oL1AD/jHw1TOto8QH8STVElis11UGUSkKRrRFaAwsb8RDr1jAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d071O82E; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5UR9N97Qa+ZWRRZ7cPa3pX7BFclXVZdx2nxad0Owaas=; b=d071O82E0qyhRoYdhZriwFmDaX
	a9N1DdeGa9iqnx+HyfkcL9OlCOMKfoh4GIrniiNiM6ciXyutgj+rxUCsOnJxpWwNzxGOfy0nBquP0
	Mnj1lO929bfWWcZOn5BRSqtV1GPn3+UOxk8S98tegM8i1yy7Nw3Emk5ITbddbjxaOccTpqiiVHlPo
	YK09ZzD23UOISal3vSVlmG4HMoNAv+m8l582kNtl9vp9txeJASgZqoSxUwo0xzg41b/4PFE4OFUxx
	UMc+D4HCDFYahqrD4F2xaDHi3ax1QBAKKD5noQ6+ScKimzC1X/qA6Buxxo3a2S5KP/6kJx9bMCKpk
	nPrZcxUg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdWCs-0000000F8Pd-0B2a;
	Mon, 12 Aug 2024 14:39:34 +0000
Date: Mon, 12 Aug 2024 15:39:33 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] xfs: convert perag lookup to xarray
Message-ID: <ZroepUyYganq8UHJ@casper.infradead.org>
References: <20240812063143.3806677-1-hch@lst.de>
 <20240812063143.3806677-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812063143.3806677-3-hch@lst.de>

On Mon, Aug 12, 2024 at 08:31:01AM +0200, Christoph Hellwig wrote:
> @@ -1020,14 +1016,16 @@ xfs_reclaim_inodes_count(
>  	struct xfs_mount	*mp)
>  {
>  	struct xfs_perag	*pag;
> -	xfs_agnumber_t		ag = 0;
> +	unsigned long		index = 0;
>  	long			reclaimable = 0;
>  
> -	while ((pag = xfs_perag_get_tag(mp, ag, XFS_ICI_RECLAIM_TAG))) {
> -		ag = pag->pag_agno + 1;
> +	rcu_read_lock();
> +	xa_for_each_marked(&mp->m_perags, index, pag, XFS_ICI_RECLAIM_TAG) {
> +		trace_xfs_reclaim_inodes_count(pag, _THIS_IP_);
>  		reclaimable += pag->pag_ici_reclaimable;
> -		xfs_perag_put(pag);
>  	}
> +	rcu_read_unlock();

Would you rather use xas_for_each_marked() here?  O(n) rather than
O(n.log(n)).

Other than that, looks like a straightforward and correct conversion.


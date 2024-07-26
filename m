Return-Path: <linux-fsdevel+bounces-24336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF64B93D743
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 19:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C209B239D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 17:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB0717C7AD;
	Fri, 26 Jul 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mX1zBFgh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7AB5684;
	Fri, 26 Jul 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722013385; cv=none; b=bkykVHSGbMqbLUeiilE65HIiX/jybPkRFcE1rJzwAUVR8xdcSfUR0DbN+fJIs/yEuk3+hv190g74ekd58ZGg5Ke2BXPSoAfJgPmGyqUBfvJ0hhFYZWu+6EKNyXMok2UteD2m7Y3B4jNdTWxMNX/ZyMRgYwW9hm69pue1/8yE1eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722013385; c=relaxed/simple;
	bh=+Ep2CkQZRAKvCPQTj24Lkl8qPc5J0uE3EXedxHbxxlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5e4pSp+Nz16PGURzfeRgkye1TTRsOIsiPO+oOTcJm5v8DCl56bgZEEWx18K8BkzxZ7qcfSn/X6pQYdwoG2+KWxhkrTp1ZL67KVc1gM8DjNrNdy6OZ2pHgx3Et8jUw4bxK7aBh6Z3ZgFAP0GP2vLOxl7nRHySlB+WRDWRKWajXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mX1zBFgh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BRXqqxv9lnht2OZmbghTCtGPoxjJZtGQu0RpfH4WRWQ=; b=mX1zBFghefdgZXHrXmXIcSbIqT
	WIM8YxrmsZ0IDd+AXZP6IwJVfk3eIoCLV6jHLBMmySWPE2ivI6pL5R/DQk4/MA0i5ZTVrsBtKngsf
	V5i5AqyIbuZOCRkgJKltoZb+xMeGOOoawEYwIPIFuBo85zC86zRRJBFNKBWwNepPCIbLbu0kjZN2M
	x5hRxqrjfqLweiMG3IuDhyuaUCIH/vk5+lJiOAsb6kkVOG9bvwFMI3Oymb5LRwh34rHg7+NQhGKdC
	aMFhDtMT6gsdF5ubGbw+DFSNLEi++UxQ7Lo9Ua7Nsp9zyWCQwAwQKShBsCFXN3dFyQWYJNwpmBfIP
	NZbkzq9A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXOLM-0000000AT3Y-443Z;
	Fri, 26 Jul 2024 17:03:01 +0000
Date: Fri, 26 Jul 2024 18:03:00 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, Xu Yang <xu.yang_2@nxp.com>
Subject: Re: [PATCH] netfs: Fault in smaller chunks for non-large folio
 mappings
Message-ID: <ZqPWxFYBPWcDjPMq@casper.infradead.org>
References: <20240527201735.1898381-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527201735.1898381-1-willy@infradead.org>

On Mon, May 27, 2024 at 09:17:32PM +0100, Matthew Wilcox (Oracle) wrote:
> As in commit 4e527d5841e2 ("iomap: fault in smaller chunks for non-large
> folio mappings"), we can see a performance loss for filesystems
> which have not yet been converted to large folios.

Did this patch get lost?

> Fixes: c38f4e96e605 ("netfs: Provide func to copy data to pagecache for buffered write")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/netfs/buffered_write.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
> index 07bc1fd43530..3288561e98dd 100644
> --- a/fs/netfs/buffered_write.c
> +++ b/fs/netfs/buffered_write.c
> @@ -184,7 +184,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
>  	unsigned int bdp_flags = (iocb->ki_flags & IOCB_NOWAIT) ? BDP_ASYNC : 0;
>  	ssize_t written = 0, ret, ret2;
>  	loff_t i_size, pos = iocb->ki_pos, from, to;
> -	size_t max_chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
> +	size_t max_chunk = mapping_max_folio_size(mapping);
>  	bool maybe_trouble = false;
>  
>  	if (unlikely(test_bit(NETFS_ICTX_WRITETHROUGH, &ctx->flags) ||
> -- 
> 2.43.0
> 


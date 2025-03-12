Return-Path: <linux-fsdevel+bounces-43778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37948A5D77F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 08:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D373D3B21DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 07:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C3F20CCED;
	Wed, 12 Mar 2025 07:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wpOMS/Jt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D87820C02F;
	Wed, 12 Mar 2025 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765361; cv=none; b=j4Jlhiu1v2q0w2vXN7SRsS90XEip4Wa7CJoKZaQ7sSbHyUgT/XFkN6J9KgjchQHYuQ1khLQIOKnP15ApKHNyjj6aqGRCk0UBKNI0SqHZHwrH4nPEBDVl9Ij56hhZies/cZ3RUNuJeguYNCPrewaNU1RDEYupIk+U/Ltuj/yXKyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765361; c=relaxed/simple;
	bh=64jUVBNN8zBl8PcQfs9Hre/DkbIOQF/e5JcRTVM860Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqGq7hd79PHrIdSdBzASbXjldTqq3Po4mlDkX7F+JRcySeFDK8Jk45HsitOySVCiC7u6CIOViMT3pltxvzgyKPcHwxuEbSKLIZQXCkeSz4bQb0n34ioRy4nRC/iWE5Pvlk9EG4e4I5zQSWbsvC0DYLsBrSEjeI0nbgRTKNHEt8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wpOMS/Jt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jzjlaQ2yiJZW1GJ8cWDufGSTRSx8+XILMBlzlDXKGH8=; b=wpOMS/JtqEYO9t+inFHH5suQQd
	0/bjBJmDNqrdmvuNmcAKOTnC8LVk6CZo13g7Sway11UPXVoJZWlz4xV8apWEcN3NCFIJ0SiHKQW94
	bkZ1jv2nOIZArVW4WvnxviLKFv3ViqnFmpI8CK1ETAz1ul8bsj9HOOv+BrBXTGEbtFd7q1JlRVUEZ
	ng5MNOgLxoYhjVdR5Z0Ci6+4RlBZJ7wVicST/NHjBJUnQyUKIG6YLgj3agpgDtVGCmI8cSBsYhIT6
	2SulRdYWKqoz4KBsSxgNqQaRvVB/qCwnRSVi8qg519E3JMlBu9nbY04seRzGt4+yya7wcRckhPNO4
	GHm6SvwQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsGjf-00000007jNR-1QyL;
	Wed, 12 Mar 2025 07:42:39 +0000
Date: Wed, 12 Mar 2025 00:42:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com
Subject: Re: [PATCH v5 09/10] xfs: Allow block allocator to take an alignment
 hint
Message-ID: <Z9E679YhzP6grfDV@infradead.org>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-10-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310183946.932054-10-john.g.garry@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

>  	else if (ap->datatype & XFS_ALLOC_USERDATA)
>  		align = xfs_get_extsz_hint(ap->ip);
> +
> +	if (align > 1 && (ap->flags & XFS_BMAPI_EXTSZALIGN))
> +		args->alignment = align;
> +

Add a comment please.

> +/* Try to align allocations to the extent size hint */
> +#define XFS_BMAPI_EXTSZALIGN	(1u << 11)

Shouldn't we be doing this by default for any extent size hint
based allocations?

>  	bool			found;
>  	bool			atomic_sw = flags & XFS_REFLINK_ATOMIC_SW;
> +	uint32_t		bmapi_flags = XFS_BMAPI_COWFORK |
> +					      XFS_BMAPI_PREALLOC;
> +
> +	if (atomic_sw)
> +		bmapi_flags |= XFS_BMAPI_EXTSZALIGN;

Please add a comment why you are doing this.



Return-Path: <linux-fsdevel+bounces-71615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F029CCCA529
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 06:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 165FE301FF4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 05:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBBA30B533;
	Thu, 18 Dec 2025 05:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="omWLDLR5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A008309EE9;
	Thu, 18 Dec 2025 05:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766035603; cv=none; b=Cw5zZAtFslxC3UNfSSO5ie3UJp4Byhn5bI9H41eiNr16lQLrsKBsKT3gNYnO1+RU4Airyn6nzQc24RMf+z+lScsXCD/IQz7fS6lf+2t/SQE5pDsQmgsdsGwugFNuFKnOHTkqRVxm4M6TLcxYt53xuW/ARha8cwvvRIjHgCIXeuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766035603; c=relaxed/simple;
	bh=hwq2bTblsRNSibyRhdIYW+yvNcEid7LOaQkQUpNJuWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIAVjPi2sdg1y+mSe+g31Y2NW6KBLbld9t8ALmc4mZNlfJ8s8KDrVR0rtn37P6gUt6gcdBRJkcbnAidO/u9GupjK8Q4wWS64x7+wwo5KLe/ypPRZTDBDxE86oA/vMWAQEmjNj123jGBrrbHikERCfUIp/dabLV/8qquJJMkzIeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=omWLDLR5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=11TJynZSCSe5ajHgqk5p+lbLu96gTOEOyitBFxlx80U=; b=omWLDLR55Y4V0S7lrVD669C2iR
	aFdNloBX4fDCCd07TguNBiomj8BI5m/3hKOY7oa2P8RQaJsvteYT+2k7o3Ezhz74uVadGq2C3Lh5P
	lWGuPJ2c2tkVNIIJjThTB1MJ7jvuyGWqGDan6luV5WbujjxjlAgBgKkYH9PUZPT+fXoDIQDnpn8n1
	9dj4ZfEw/8melpfi28Dy9MbC5l2qN6coPm1D9KQci7obXGp7jFvn+G7ge5+JLSYA5AJ1Z8p1fw1TD
	0wb/DDdeFYuhFDg3qghQ/NxMrh2k09KMpIz/TsBnmLOqTAtxKpijsbu10Hy1Vvu2zrZR7gABWbtBl
	ANMEGkLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW6XB-00000007qN7-2B49;
	Thu, 18 Dec 2025 05:26:41 +0000
Date: Wed, 17 Dec 2025 21:26:41 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] fs: send uevents for filesystem mount events
Message-ID: <aUOQkY3s_D_REIsH@infradead.org>
References: <176602332484.688213.11232314346072982565.stgit@frogsfrogsfrogs>
 <176602332527.688213.9644123318095990966.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176602332527.688213.9644123318095990966.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +#define ADVANCE_ENV(envp, buf, buflen, written) \
> +	do { \
> +		ssize_t __written = (written); \
> +\
> +		WARN_ON((buflen) < (__written) + 1); \
> +		*(envp) = (buf); \
> +		(envp)++; \
> +		(buf) += (__written) + 1; \
> +		(buflen) -= (__written) + 1; \
> +	} while (0)

Any reason this is a macro vs an (inline?) function?  Looking at this a
bit more, could this simply use a seq_buf?



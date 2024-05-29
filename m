Return-Path: <linux-fsdevel+bounces-20397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6318D2C2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 07:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1851B1C21D2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 05:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E1615B972;
	Wed, 29 May 2024 05:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hFLsUGXw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE44879F2;
	Wed, 29 May 2024 05:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716959748; cv=none; b=NYA7cFhMHNZwDzzK7EbYTPI+oFAg0XRBWuclf99iQjPqQKucveqhLOxcmVIb/zVIBM2MDdwHTImm5adFCUTZP7i0DlutP1aYvg0SwzhkraupFYe7xjAOqYhzJ2+4zd41bCwCyUQa9tvIkWBVo44wIsevdzNDRhLpXG3bnIY+i6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716959748; c=relaxed/simple;
	bh=405fmI54HGw3CsvdFhrDG0owulKYlZPf1JUCgWhpdww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Efmh7iySRXX1cZkWWjRlHjT0YcxIO/YLdC+JnN7Kw47SkRsJ57Ym9wAph9c0Nu6NHgGmhY96wkg8H3kdFzdx2bzRtOAxOsA5Nmj2F+HxqxC5yIZGXiy5rsz7JOHcU5Njh2vOeq7BOx6TFkbF6IwZBVds/ca5e0r0pGkFlqcgOLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hFLsUGXw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/ACG9Ek88EjhjWT8FizxBf7xtM0XajlJ2TJlG/RMopw=; b=hFLsUGXwozkqF6iM8hwef87AKY
	tOHk253ez7fOkFLHs9NwoEVPsCELh0C1YUasNCOh5rkpwhi7NrwQlDNjvI047vRyJ6dxnKGn36tAO
	vfV+1Mg8vt/7aQ9mMlAitm3IQwdgoRcjf2NHx0agBEh6lZEsRu3MfN+kWjh+eKx4PWYJ4d+dzPWZY
	oOepTH2sexB7bt8iNEUhvRi37JI+YGmZGy7Kdi5MI7PV/gB90woJl0zx42iGUQbBUasjayI4qclcD
	ETdaaRgpCUYxYBxCdY0AHZLNm1Z7qIH6iAzjDlYqkqLFWtCVsBh9oEfv0xvnTfN+EmdLhqJAfJ9fe
	CqcZbHrg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCBf7-00000002rSI-2tM5;
	Wed, 29 May 2024 05:15:45 +0000
Date: Tue, 28 May 2024 22:15:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <Anna.Schumaker@netapp.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] nfs: Fix misuses of folio_shift() and folio_order()
Message-ID: <Zla6Afcg7BnVY3xS@infradead.org>
References: <20240527163616.1135968-1-hch@lst.de>
 <20240528210407.2158964-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528210407.2158964-1-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index c6aaceed0de6..df57d7361a9a 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -212,8 +212,8 @@ enum mapping_flags {
>  	AS_FOLIO_ORDER_MAX = 21, /* Bits 16-25 are used for FOLIO_ORDER */
>  };
>  
> -#define AS_FOLIO_ORDER_MIN_MASK 0x001f0000
> -#define AS_FOLIO_ORDER_MAX_MASK 0x03e00000
> +#define AS_FOLIO_ORDER_MIN_MASK (31 << AS_FOLIO_ORDER_MIN)
> +#define AS_FOLIO_ORDER_MAX_MASK (31 << AS_FOLIO_ORDER_MAX)

This looks unrelated.

The NFS changes do look good to me, I'll kick off a testing run on
them in a bit.



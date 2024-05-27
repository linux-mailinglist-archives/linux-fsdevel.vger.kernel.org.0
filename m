Return-Path: <linux-fsdevel+bounces-20270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412958D09D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 20:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50FAB1C22191
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 18:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58B915F3FD;
	Mon, 27 May 2024 18:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EBoD/Hrh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4C01DA23;
	Mon, 27 May 2024 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716833843; cv=none; b=TgMJXZGBrUdDnaJMEyYgwlNCo1zs9i7I2nEL3Kv+O7pySw5P35wg607CqiwswRtUhFIih9lMZSGVLeO702PK3VQov4oXA6PUx4ugTF3bCeUYqyi6dAuVrPEz1fZlecaOX2jgcoTykOAwRT1Jud49iWAlXCLDp6PoDVZtCFc0fgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716833843; c=relaxed/simple;
	bh=73l1YPr/2J7LXLM4NzJGlrHdLbkHv4cNTEwSMSwytdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkJcHLodrcMgh7Y4trPt/IdGSec+XjkKuGyVZf2+eLsTFDeOwAINykeCxtKZcBuvfzcm4C38ozPYIADCL3AMqB0/xU94118uRSFljvV/WJgUx8l3LnqIQoN+V1Mha7/u5Eqz+DPITMfPueuM+ZR35n6hwiuF8WPFu9wOROXbpbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EBoD/Hrh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yQPndnt/VKkoxE+QATcqk3pffHAGhUlkEJl1EekOfS0=; b=EBoD/HrhhFDFz4F7sBZCAVQPZ3
	UdPROiG8LxqhGX4WRjDUOkrv/AG5V/dDZE0KCq0UT1U7xc+ygKs4+n3RfQWs8xwEgBIopsRAC1BlN
	+pbsBC1Eqdkk7Lv06FUj8iLILqJU0qpqWZ5U0J3gRjRvqWmtfvof0zSHvb4fHqbpM5exeJeN9G3uC
	h8hH6miNT4tf4zY0nvd6MDPJ15+dPejJTPhb3OPZy4JGs47OgDCjbvNVsApJ+87WwHo/jarDC3uiO
	Nq4q6dA9H4UtVIPaE/oDcG7YAc7YUnK325Dpy7hgiSKfb0jLGQrZZWdMV9bvuI3JS1licFjcnRc7V
	apptAnSA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBeuM-00000007sZU-0Y5G;
	Mon, 27 May 2024 18:17:18 +0000
Date: Mon, 27 May 2024 19:17:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] filemap: Convert generic_perform_write() to support
 large folios
Message-ID: <ZlTOLsrhD4P4Yiwl@casper.infradead.org>
References: <20240527163616.1135968-1-hch@lst.de>
 <20240527163616.1135968-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527163616.1135968-2-hch@lst.de>

On Mon, May 27, 2024 at 06:36:08PM +0200, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Modelled after the loop in iomap_write_iter(), copy larger chunks from
> userspace if the filesystem has created large folios.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> [hch: use mapping_max_folio_size to keep supporting file systems that do
>  not support large folios]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yup, this still makes sense to me.

Could you remind me why we need to call flush_dcache_folio() in
generic_perform_write() while we don't in iomap_write_iter()?

>  		if (mapping_writably_mapped(mapping))
> -			flush_dcache_page(page);
> +			flush_dcache_folio(folio);

(i'm not talking about this one)

> -		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
> -		flush_dcache_page(page);
> +		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
> +		flush_dcache_folio(folio);

(this one has no equivalent in iomap)

>  		status = a_ops->write_end(file, mapping, pos, bytes, copied,
>  						page, fsdata);


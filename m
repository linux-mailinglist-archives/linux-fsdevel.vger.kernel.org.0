Return-Path: <linux-fsdevel+bounces-21650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 454879075D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 16:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3091F24E01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 14:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A786146019;
	Thu, 13 Jun 2024 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ny1gxOFz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF5982C76
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290588; cv=none; b=Ci1tmQOkeUpCXJwkFRKJXBGU63AYgQilHKhw80zJD5njdCW6t4IjIBCmyExBARTZcE/Hj1h5HsApcUw8m4lq0a1YECLPfxHCscTU1lra0YfK+0tpzv2oXbCT+a1rWxoeYoYxZ5+asvSWGOhBLl7FG8kXkPGCpB81x7xs7+Rs6vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290588; c=relaxed/simple;
	bh=oEsB/YCyMqZWc/z+85EP2IGe3loxKImh1O0iBJl3i7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4hynakz0M18vPgvfSSaaRTvSysfZpuUYMarxm/vYU/MgUL8cZNowd61fH3B377h5+yFIPIruKBF3MLc4+cxFFIz5iUqELrPEWLcb7opnM1Y47OREBHr/OohM59t5EoSoXCvL1+XMXCDneLhaP2ACHOpLkR2wNC45a5XjP5UB/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ny1gxOFz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wvNM+YAJ0ywdCNm8d2ZNL78NN2Bt8Qj5+Mzvx26xJBk=; b=ny1gxOFzWjljF4FpTVEIBYnYq7
	U4amEDYNTOZ8dZjDjoJLFW/MSsvxvMysPLStxuD5XgHGDz0Xp/74dKvXLOR+8xGZ1VlaOKypJ0E7S
	NfRv9Aah5jsTn8MkW1Jjlv8RwnlisRPr9koEFGoYMGLB0NE2DN6DEuYWd+cKL2Ae6BiL34c2JPNtj
	L27x6t4kFQiyMDxaWp1VFe0uQ7ha1UVpiqGu/vyv2y+MpGHsWARULjb3n8VAKAeLITlnsERKfp3/R
	uCq7zHaHE4fNAK7mh0ZJ+7zK36O8+UMuqbk3a+4A3zOv4AEARKyHgfhRLVfJcFc4RWemSUTpQI6Qb
	bfj0SGqg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHlsF-0000000FsPE-0xXi;
	Thu, 13 Jun 2024 14:56:23 +0000
Date: Thu, 13 Jun 2024 15:56:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] mm: Provide a means of invalidation without using
 launder_folio
Message-ID: <ZmsIl5y3-RKtlxVZ@casper.infradead.org>
References: <8b6bd8e0-04a2-4b51-9b29-74804ba11564@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b6bd8e0-04a2-4b51-9b29-74804ba11564@moroto.mountain>

On Thu, Jun 13, 2024 at 04:55:30PM +0300, Dan Carpenter wrote:
> Hello David Howells,
> 
> Commit 74e797d79cf1 ("mm: Provide a means of invalidation without
> using launder_folio") from Mar 27, 2024 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	mm/filemap.c:4229 filemap_invalidate_inode()
> 	error: we previously assumed 'mapping' could be null (see line 4200)

I think David has been overly cautious here.  I don't think i_mapping
can ever be NULL.  inode_init_always() sets i_mapping to be
&inode->i_data and I don't see anywhere that changes i_mapping to be
NULL.

> mm/filemap.c
>   4192  int filemap_invalidate_inode(struct inode *inode, bool flush,
>   4193                               loff_t start, loff_t end)
>   4194  {
>   4195          struct address_space *mapping = inode->i_mapping;
>   4196          pgoff_t first = start >> PAGE_SHIFT;
>   4197          pgoff_t last = end >> PAGE_SHIFT;
>   4198          pgoff_t nr = end == LLONG_MAX ? ULONG_MAX : last - first + 1;
>   4199  
>   4200          if (!mapping || !mapping->nrpages || end < start)
>                     ^^^^^^^^
> If mapping is NULL


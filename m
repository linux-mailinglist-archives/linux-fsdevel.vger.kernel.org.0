Return-Path: <linux-fsdevel+bounces-21450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2259040F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 18:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C5A1C23D7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 16:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F053B2BB;
	Tue, 11 Jun 2024 16:13:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A9E42067;
	Tue, 11 Jun 2024 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718122406; cv=none; b=Lc1SiVjHNOD1lZ1dDsTNcbDMldb4P9hEQqQiZTr2nUOrO+E5Algpvmm5D2+VwaP0e4mQbaq+6cfpfb3qswxiPT7U18jILHOwPN3H5VRM2gW4AeDxnJAoyMJdpF1po7/e8X5eECK1KSTK057ql48rV0KorPbDE1pGys2gMXG/A98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718122406; c=relaxed/simple;
	bh=tbMHWdvlPuZV3ILs1/2g8pxQ4cjE1edWyrzdSdTpf6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJP2TVbfkvJb8IsuAvJX5S3bCFPqsUEpzXbmjoMRTbJxeFjG9zc9hHaDp2pgEUFNv3dNcvQkV0nWwy9LlhdbzEU23/Hn1Sqy0GUIPKvK2UbRiKSlCBL/kqYIDMDAc2MUuJryK+reYJRXq31sOvg7NxZ6zAlcEcKRVuCEWPCuDJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7C5CE68BEB; Tue, 11 Jun 2024 18:13:11 +0200 (CEST)
Date: Tue, 11 Jun 2024 18:13:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shaun Tancheff <shaun.tancheff@hpe.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] filemap: Convert generic_perform_write() to
 support large folios
Message-ID: <20240611161311.GA12257@lst.de>
References: <20240527163616.1135968-1-hch@lst.de> <20240527163616.1135968-2-hch@lst.de> <8e23be47-e542-4bb8-8da7-da7801c98e42@hpe.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e23be47-e542-4bb8-8da7-da7801c98e42@hpe.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 11, 2024 at 05:47:12PM +0700, Shaun Tancheff wrote:
>>   	const struct address_space_operations *a_ops = mapping->a_ops;
>> +	size_t chunk = mapping_max_folio_size(mapping);
>
> Better to default chunk to PAGE_SIZE for backward compat
> +       size_t chunk = PAGE_SIZE;
>
>>   	long status = 0;
>>   	ssize_t written = 0;
>>   
>
> Have fs opt in to large folio support:
>
> +       if (mapping_large_folio_support(mapping))
> +               chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;

I don't think you've actually read the code, have you?



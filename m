Return-Path: <linux-fsdevel+bounces-21500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE449049D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 06:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFAC282AB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 04:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FE5219E4;
	Wed, 12 Jun 2024 04:02:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C93111AD;
	Wed, 12 Jun 2024 04:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718164943; cv=none; b=ga5sejzO9wdELqLsUs9RhlNjMeTcQsaLT6mqMm2el4ZwIbVqsJl4qJY7vV5Mfpu/5T41QQ3N6XgUG11JOg8hiZW2OjHAEjKU3bVI1InUY2VPXmcGJ1HXRIlUeoUeNK+xzwp5CYYc0BdbLGSH30ZrHKXs/ZvEr1kucsczwcL1ehA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718164943; c=relaxed/simple;
	bh=XZBIEX0qR+cjLlTgxTI6SBCB2zKryvbDl4fHNPGYWj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDXr9Xq7qTME4RDGsV3rNeah1CHOoaS2VmNBPvrfU8r/dSEJzNY+KI1MDEVKJ2zlye9Dh3ElQIe4ESCOPQMsT8Wy7C7Kabs4VSizAhYThai2+wZyykbrgIrV9dpIuMx1ZODKUbeorHdEdQ/VRP+i4tD/fHwEdkdaOzicTV8HeZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4EBFD68BEB; Wed, 12 Jun 2024 06:02:17 +0200 (CEST)
Date: Wed, 12 Jun 2024 06:02:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shaun Tancheff <shaun.tancheff@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Shaun Tancheff <shaun.tancheff@hpe.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] filemap: Convert generic_perform_write() to
 support large folios
Message-ID: <20240612040216.GA25886@lst.de>
References: <20240527163616.1135968-1-hch@lst.de> <20240527163616.1135968-2-hch@lst.de> <8e23be47-e542-4bb8-8da7-da7801c98e42@hpe.com> <20240611161311.GA12257@lst.de> <1d87741b-7178-4791-aca2-da3ac3033552@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d87741b-7178-4791-aca2-da3ac3033552@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 12, 2024 at 08:41:01AM +0700, Shaun Tancheff wrote:
> On 6/11/24 23:13, Christoph Hellwig wrote:
>
>> On Tue, Jun 11, 2024 at 05:47:12PM +0700, Shaun Tancheff wrote:
>>>>    	const struct address_space_operations *a_ops = mapping->a_ops;
>>>> +	size_t chunk = mapping_max_folio_size(mapping);
>>> Better to default chunk to PAGE_SIZE for backward compat
>>> +       size_t chunk = PAGE_SIZE;
>>>
>>>>    	long status = 0;
>>>>    	ssize_t written = 0;
>>>>    
>>> Have fs opt in to large folio support:
>>>
>>> +       if (mapping_large_folio_support(mapping))
>>> +               chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
>> I don't think you've actually read the code, have you?
>
> I checked from 6.6 to linux-next with this patch and my ext4 VM does not boot without the opt-in.

Please take a look at the definition of mapping_max_folio_size,
which is called above in the quoted patch.



Return-Path: <linux-fsdevel+bounces-48924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC47AB6018
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 02:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717C28630F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 00:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9AE17BA3;
	Wed, 14 May 2025 00:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wkmpc8Ja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9291C137E
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 00:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747181948; cv=none; b=mhJxsBhE5tKOavQGlhlt9HBh44lzPjynaa9eQHEwF7HW8S8Ls7qKprslpO/LKG0/+2bOgB2atrUB0s/uE8Sw/Q0H6x374IpOJL0svCYhmOw5yh7FqrGiLPYQinqLysswSk6s8WUWUSmJ/16Jg6mPNAdJaJZl9zjpg5+l2a7AtfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747181948; c=relaxed/simple;
	bh=jyz/VfQxFVrDx/hATgvgxa29leBPBv2qSgdKrhSjim8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRF8JgByFKCdd1OsGvZepIJyw3GdSiFpMs+2/JDohWnO+4QAbxIiagWhOjoW8aDSfVWehXVaiOoeDjoaecJqeuwoFsZDtPEkM4K6ThP0bS+JZRDFHVXLSHU8MM44KH/cijnnUL5Zf55EK+p3zUKK5bi7l0Jb4uRRFfHdDNSI9SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wkmpc8Ja; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SloGSPyxpzlwX7ZZI9C3ISRGLHoVGcyLgXDcG1yir+U=; b=Wkmpc8JanX3rhpubyhFGdaPg0h
	kaDzuAHths068zWWRmL3p3uZhf5tSnHMV+tiEobBoLGQ8e+2Kb2N5o9wuU8tXl1+YqQBgJe13YKmp
	brGSyno/jn+tK9D7zamgw9YDc7iKNMIJ94dQK2RrQa+bH/p3Xngx3sinvtd+HValyRdZOG2aw8Bnc
	7lm0IMIG/FKHfNDDJNaOi3xF0Xnbize00V87xvRKPN/zdv1NMHL5awk9z+iNi3NYKl4lCsT2l+0e9
	3nUsoaJlxARjwCT3GWqGh1edlpsU2zslCA3bOqqImgMAiS++sDYF0G9MxVOQPNhHHOSS6TU3cl05c
	55S0TBAg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEzpm-0000000BVMo-0LOf;
	Wed, 14 May 2025 00:18:54 +0000
Date: Wed, 14 May 2025 01:18:53 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jlayton@kernel.org,
	jefflexu@linux.alibaba.com, josef@toxicpanda.com,
	kernel-team@meta.com, Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v6 01/11] fuse: support copying large folios
Message-ID: <aCPhbVxmfmBjC8Jh@casper.infradead.org>
References: <20250512225840.826249-1-joannelkoong@gmail.com>
 <20250512225840.826249-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512225840.826249-2-joannelkoong@gmail.com>

On Mon, May 12, 2025 at 03:58:30PM -0700, Joanne Koong wrote:
> @@ -1126,22 +1127,22 @@ static int fuse_copy_page(struct fuse_copy_state *cs, struct page **pagep,
>  					return err;
>  			}
>  		}
> -		if (page) {
> -			void *mapaddr = kmap_local_page(page);
> -			void *buf = mapaddr + offset;
> +		if (folio) {
> +			void *mapaddr = kmap_local_folio(folio, offset);
> +			void *buf = mapaddr;
>  			offset += fuse_copy_do(cs, &buf, &count);
>  			kunmap_local(mapaddr);

kmap_local_folio() only maps the page which contains 'offset'.
following what the functions in highmem.h do, i'd suggest something
like:

		if (folio) {
			void *mapaddr = kmap_local_folio(folio, offset);
			void *buf = mapaddr;

			if (folio_test_highmem(folio) &&
			    size > PAGE_SIZE - offset_in_page(offset))
				size = PAGE_SIZE - offset_in_page(offset);
			offset += fuse_copy_do(cs, &buf, &count);
			kunmap_local(mapaddr);



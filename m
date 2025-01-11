Return-Path: <linux-fsdevel+bounces-38949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B667BA0A3DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 14:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C614216A819
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 13:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A863A192D7C;
	Sat, 11 Jan 2025 13:21:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ECB198A34
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jan 2025 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736601703; cv=none; b=cd93VYe9/dsA9D1wIJspk2zIR1PD2EOKRhy9Z2dmtjrzC+P8TwC1dt11xmif2ygMVxs/iYg5M2peBaGpacpbCbmcj/b4+YMMRluY/3KeA4CX55doIIzzT6b94GZkAaXZcohNWzs/db2n7oyKNdlyJD066HZ9uZdyuX7hyDX8MLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736601703; c=relaxed/simple;
	bh=vF/ne1ODwaO9He5LBjtlQRYKWN0W4tCCHq2JbF67USE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+lCv7oojehE6AJ32JlAE0VtJU6R2c1CGCqrakALBbE0HojPCZezt6bnzbDNmdiKPk2RJkjvxSJzSSyORoLwWEaVl4Yhv6ZGPHdy4VeB6/mi7J+bjbFG3npsrUgQnatjdT+HRebqhsbvHXeuV4uD17Ex04m+DMZqocbP2As4JVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A131511FB;
	Sat, 11 Jan 2025 05:22:02 -0800 (PST)
Received: from [10.57.94.123] (unknown [10.57.94.123])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A9F03F59E;
	Sat, 11 Jan 2025 05:21:33 -0800 (PST)
Message-ID: <b9ce358d-4f67-48be-94b3-b65a17ef56f9@arm.com>
Date: Sat, 11 Jan 2025 13:21:31 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] squashfs: Fix "convert squashfs_fill_page() to take a
 folio"
Content-Language: en-GB
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
 squashfs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
References: <20250110163300.3346321-1-willy@infradead.org>
 <20250110163300.3346321-2-willy@infradead.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250110163300.3346321-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/01/2025 16:32, Matthew Wilcox (Oracle) wrote:
> I got the polarity of "uptodate" wrong.  Rename it.  Thanks to
> Ryan for testing; please fold into above named patch, and he'd like
> you to add
> 
> Tested-by: Ryan Roberts <ryan.roberts@arm.com>

This is missing the change to folio_end_read() and the change for IS_ERR() that
was in the version of the patch I tested. Just checking that those were handled
separately in a thread I'm not CCed on?

> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/squashfs/file.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index da25d6fa45ce..018f0053a4f5 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -400,7 +400,7 @@ void squashfs_copy_cache(struct folio *folio,
>  			bytes -= PAGE_SIZE, offset += PAGE_SIZE) {
>  		struct folio *push_folio;
>  		size_t avail = buffer ? min(bytes, PAGE_SIZE) : 0;
> -		bool uptodate = true;
> +		bool updated = false;
>  
>  		TRACE("bytes %zu, i %d, available_bytes %zu\n", bytes, i, avail);
>  
> @@ -415,9 +415,9 @@ void squashfs_copy_cache(struct folio *folio,
>  		if (folio_test_uptodate(push_folio))
>  			goto skip_folio;
>  
> -		uptodate = squashfs_fill_page(push_folio, buffer, offset, avail);
> +		updated = squashfs_fill_page(push_folio, buffer, offset, avail);
>  skip_folio:
> -		folio_end_read(push_folio, uptodate);
> +		folio_end_read(push_folio, updated);
>  		if (i != folio->index)
>  			folio_put(push_folio);
>  	}



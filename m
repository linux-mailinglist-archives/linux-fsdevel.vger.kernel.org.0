Return-Path: <linux-fsdevel+bounces-41902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 771E0A38E73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 23:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7F0170F26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 22:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFE51A8F6D;
	Mon, 17 Feb 2025 22:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CrrSfvxY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317AC7D3F4;
	Mon, 17 Feb 2025 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739829697; cv=none; b=TOB7ZicQGkXAi5Hmk3T29zyY9u9zPUwFY4uBYS3+kIaQGcmrf167lq0akq5c30GsCxNJKPZqV5IKhgwbXW5W2mfBZjsX7aa2nJNNgOzpfwGkQVsu3iV4P5cNB1OjvvY4qXLpRTYzv5FpKbrW9kkQQLOkNNvVqWEDgPjJhqdSpzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739829697; c=relaxed/simple;
	bh=PnixvO0d55mIZXfP3OxrXzkCMdllOXT9QRj1aKFo2ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHqznry89pXqWkJSN3n0gTJEtP+qY/0VzL1Ml0m+iuu/SVYPRKe4V2XtHMCcLdj4cE+0v69IAE3pz3AL6emVQ4A2E+tKYLYyxBoIKUAa6KWn9mx6BaSJ7mAsIJhArkkldr3Cuf2eXVyAvikfMD2JXQtm7WRrDrJ4SX7I7DpQFds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CrrSfvxY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lykvh8EenMgekboDKJkwHqwiihLh3ixvLzc2NNaJgVw=; b=CrrSfvxYnkAy1LcSd5BRaGEXMk
	hXtIvwYg0oEaKE1W6ubvyTRZZIVCiOortDXhG0sEuM++bKxKYznkad23wEG7NIXLU8UcywWhyFjWm
	PbM1hPOus9EQI4QGWYfdGLHz9KIx+Zql28VKUC+4KHSlHzVbupFa46ooSb8hAwbGJmc1oDOajd6g/
	3HMq0VAeIf487c32soWoj2vZNSJaIik5/n8qemkajfi3o1Hg1an10p5+41b5vQ1zX+PxXnefU9nOn
	H0F371b6+29CRdg+sNw7OPBzXIBifCwwOHxgWHK4wb3yttEgzZbNQ+eJvR6g4jUSm8wVqfMkVj20m
	L13iPBoA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk9BD-000000020Ag-1V40;
	Mon, 17 Feb 2025 22:01:31 +0000
Date: Mon, 17 Feb 2025 22:01:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hare@suse.de, dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org,
	kbusch@kernel.org, john.g.garry@oracle.com, hch@lst.de,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH v2 7/8] block/bdev: lift block size restrictions to 64k
Message-ID: <Z7Oxu9J4gkUFdP_t@casper.infradead.org>
References: <20250204231209.429356-1-mcgrof@kernel.org>
 <20250204231209.429356-8-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204231209.429356-8-mcgrof@kernel.org>

On Tue, Feb 04, 2025 at 03:12:08PM -0800, Luis Chamberlain wrote:
> We now can support blocksizes larger than PAGE_SIZE, so in theory
> we should be able to lift the restriction up to the max supported page
> cache order. However bound ourselves to what we can currently validate
> and test. Through blktests and fstest we can validate up to 64k today.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 248416ecd01c..a89513302977 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -26,6 +26,7 @@
>  #include <linux/xarray.h>
>  #include <linux/file.h>
>  #include <linux/lockdep.h>
> +#include <linux/pagemap.h>

We can drop this until we actually use 

> + * We should strive for 1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER)

right?  I don't see anything else that needs this include.


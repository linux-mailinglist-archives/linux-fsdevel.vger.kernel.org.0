Return-Path: <linux-fsdevel+bounces-34651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A481D9C74F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E62D0B2717E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 14:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09747200B84;
	Wed, 13 Nov 2024 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DZCbfABc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169AB7081F;
	Wed, 13 Nov 2024 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507272; cv=none; b=YGo70+SBy333r58McYGTGRAE0kiQZyypGmqtVFlyCOJN7JFHHG7+2b5Lw82Ik3fULaW/ahU0chbDDWnLst/s7cb2s+HsTpt71q2IBUF7kn08FB4E6GV1CRUPs1mkd8ITWLDKMExU5SvRCsHPeuzXO2gJyfZt8TGLfCCgz5rO48Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507272; c=relaxed/simple;
	bh=S5b4aciOWt/GJ0H+qOz8BrCo6s/jXpzkZyTjxzDG6JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afZAdedexURtPCSWC90eW9RhpU928dhMJa5MkIc3j9Hdk4Wu2kilvehJgbUnOM7YvAx02R+KTYWN0V3kvf5Tq2aASN6yoPkdG+vtR2TkzX3Wx6YAa8zDPHw/Ka+1ZfBNsYooInj1MQ5qhVXIdFh23LVcYGX0O+F5jiEdp4JKkZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DZCbfABc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dR/eQNA/p7Fur9CKjeVK9QBEm5x5S0TSUaRl4x8UFpc=; b=DZCbfABcQtHDJbiDvoeMwVGczs
	Sdfgmp+E7gvWbM+wVFIDlB4ap2qzpv8TrlEq9TGYSxAVXstVh5WU7Qr3MDJjy1M37P62CA/38in+S
	x+E5Lc9gUgtYs3Ts/2+pANp8+AS0lOaJNMkjVJLMVqPiCZ6uuCESSYIwynahmIthmbcJq/+LzuQFX
	o7NkPICis8K0MtPcNpn5AGHAbOCpCkcVUQS2XnjgLbCanY30AXavYObzS+xlhdvWKntqnRntVb9Vd
	+zIMwQX3sktOgnJW4QtDcoUjqAL+vLExX3P18AQrNFRSvljijDGgPre6CHoZFYE0BN/PTRDGv0JMw
	lgkZAIcA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBE8Y-0000000GRdw-2jHd;
	Wed, 13 Nov 2024 14:14:26 +0000
Date: Wed, 13 Nov 2024 14:14:26 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hch@lst.de, hare@suse.de, david@fromorbit.com, djwong@kernel.org,
	john.g.garry@oracle.com, ritesh.list@gmail.com, kbusch@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
	kernel@pankajraghav.com
Subject: Re: [RFC 6/8] block/bdev: lift block size restrictions and use
 common definition
Message-ID: <ZzS0QjUpTND9mgF-@casper.infradead.org>
References: <20241113094727.1497722-1-mcgrof@kernel.org>
 <20241113094727.1497722-7-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113094727.1497722-7-mcgrof@kernel.org>

On Wed, Nov 13, 2024 at 01:47:25AM -0800, Luis Chamberlain wrote:
> @@ -185,7 +184,7 @@ int sb_set_blocksize(struct super_block *sb, int size)
>  	if (set_blocksize(sb->s_bdev_file, size))
>  		return 0;
>  	/* If we get here, we know size is power of two
> -	 * and it's value is between 512 and PAGE_SIZE */
> +	 * and it's value is larger than 512 */

If you're changing this line, please delete the incorrect apostrophe.

>  	sb->s_blocksize = size;
>  	sb->s_blocksize_bits = blksize_bits(size);
>  	return sb->s_blocksize;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 50c3b959da28..cc9fca1fceaa 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -25,6 +25,7 @@
>  #include <linux/uuid.h>
>  #include <linux/xarray.h>
>  #include <linux/file.h>
> +#include <linux/pagemap.h>

Why do we need to add this include?

> @@ -268,10 +269,13 @@ static inline dev_t disk_devt(struct gendisk *disk)
>  	return MKDEV(disk->major, disk->first_minor);
>  }
>  
> +/* We should strive for 1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER) */
> +#define BLK_MAX_BLOCK_SIZE      (SZ_64K)

I think we need CONFIG_TRANSPARENT_HUGEPAGE to go over PAGE_SIZE.



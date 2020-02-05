Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3256F153841
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 19:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgBESgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 13:36:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgBESgK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 13:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wOZCtDUg0G8yt+sIQgMP9QT09NzDhu2T37fFXWcoB9c=; b=SE9i9hS00UWQr8oEdZ5z7FN7Gn
        tKuxduysSjGf/ApVbMLPhqxxp6QnKWndbOEnRN432+HsREEc8pJVCv8RMBAAFOPLTF/RmbOBcpZ1l
        dbo8J0FRr7NJhYLIJjRaz7s9SVP/oW5mSN8jdB08ojRDa3LkBRXkuW+dk1EcsFpgxaB+1kFb8XoBf
        v0mt0aCi9F0VO82ccBqcLSuiiZ8aoyrpUHnT9If2njdO2WIyoknOIX2IWrcUgL35FPwnDuFFqsEvo
        lRn3fLA/F6DR/i6wyhXkQl/gWHxWZtrC66t8W8i8f6rO0Z7cvTIuRW84MtCw7xJNLZ0wnOp9qhN8Q
        74GcpCZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izPWz-0003Bc-OE; Wed, 05 Feb 2020 18:36:09 +0000
Date:   Wed, 5 Feb 2020 10:36:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, hch@infradead.org, dm-devel@redhat.com
Subject: Re: [PATCH 5/5] dax,iomap: Add helper dax_iomap_zero() to zero a
 range
Message-ID: <20200205183609.GE26711@infradead.org>
References: <20200203200029.4592-1-vgoyal@redhat.com>
 <20200203200029.4592-6-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203200029.4592-6-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
> +			      struct iomap *iomap)
>  {
>  	pgoff_t pgoff;
>  	long rc, id;
> +	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
>  
> -	rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
> +	rc = bdev_dax_pgoff(iomap->bdev, sector, PAGE_SIZE, &pgoff);
>  	if (rc)
>  		return rc;
>  
>  	id = dax_read_lock();
> -	rc = dax_zero_page_range(dax_dev, pgoff, offset, size);
> +	rc = dax_zero_page_range(iomap->dax_dev, pgoff, offset, size);
>  	dax_read_unlock(id);
>  	return rc;
>  }
> -EXPORT_SYMBOL_GPL(__dax_zero_page_range);
> +EXPORT_SYMBOL_GPL(dax_iomap_zero);

This function is only used by fs/iomap/buffered-io.c, so no need to
export it.

>  #ifdef CONFIG_FS_DAX
> -int __dax_zero_page_range(struct block_device *bdev,
> -		struct dax_device *dax_dev, sector_t sector,
> -		unsigned int offset, unsigned int length);
> +int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
> +			      struct iomap *iomap);
>  #else
> -static inline int __dax_zero_page_range(struct block_device *bdev,
> -		struct dax_device *dax_dev, sector_t sector,
> -		unsigned int offset, unsigned int length)
> +static inline int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
> +				 struct iomap *iomap)
>  {
>  	return -ENXIO;
>  }

Given that the only caller is under an IS_DAX() check you could just
declare the function unconditionally and let the compiler optimize
away the guaranteed dead call for the !CONFIG_FS_DAX case, like we
do with various other functions.

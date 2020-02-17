Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC199161339
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgBQNXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:23:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgBQNXJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ByxHNx18slAjQKwWQOPPOSwhUVNs5MumxpbzTsFX1YE=; b=Wg1XDz5aNxcq5v1gyNrnTidPVe
        8HqRWPY8J3R0MOaBmB84CGVgjJW8Wkm26X9SxtIyNA23KgARIHqBYzhF7l5Xe5CPKp6zeIvMBLSSo
        Zp/KPaNj/+C5aTS1vM8gSadnQ0MtWm+OQtWROKv1HSCV6fgOy9s0fCfGuJSdV/ko28taJVN4QMeDw
        TvcYwpurjpczt6e6i1epwKNk544VeTVuBOqrynLRMIGHbumNS4rvWcryZ/unl9DonoDWAtau5G6zx
        7m2E/xMW+pIO739uAVglRnCPOJ9hu0fInTTEkea6UsQdAXsetRo/Jax9ZOmDTCQaO61PK+AC2kQDB
        4wFeg11w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3gMf-0002bB-FE; Mon, 17 Feb 2020 13:23:09 +0000
Date:   Mon, 17 Feb 2020 05:23:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com, dm-devel@redhat.com,
        vishal.l.verma@intel.com
Subject: Re: [PATCH v3 2/7] pmem: Enable pmem_do_write() to deal with
 arbitrary ranges
Message-ID: <20200217132309.GC14490@infradead.org>
References: <20200207202652.1439-1-vgoyal@redhat.com>
 <20200207202652.1439-3-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207202652.1439-3-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 03:26:47PM -0500, Vivek Goyal wrote:
> Currently pmem_do_write() is written with assumption that all I/O is
> sector aligned. Soon I want to use this function in zero_page_range()
> where range passed in does not have to be sector aligned.
> 
> Modify this function to be able to deal with an arbitrary range. Which
> is specified by pmem_off and len.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  drivers/nvdimm/pmem.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 9ad07cb8c9fc..281fe04d25fd 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -154,15 +154,23 @@ static blk_status_t pmem_do_read(struct pmem_device *pmem,
>  
>  static blk_status_t pmem_do_write(struct pmem_device *pmem,
>  			struct page *page, unsigned int page_off,
> -			sector_t sector, unsigned int len)
> +			u64 pmem_off, unsigned int len)
>  {
>  	blk_status_t rc = BLK_STS_OK;
>  	bool bad_pmem = false;
> -	phys_addr_t pmem_off = sector * 512 + pmem->data_offset;
> -	void *pmem_addr = pmem->virt_addr + pmem_off;
> -
> -	if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
> -		bad_pmem = true;
> +	phys_addr_t pmem_real_off = pmem_off + pmem->data_offset;
> +	void *pmem_addr = pmem->virt_addr + pmem_real_off;
> +	sector_t sector_start, sector_end;
> +	unsigned nr_sectors;
> +
> +	sector_start = DIV_ROUND_UP(pmem_off, SECTOR_SIZE);
> +	sector_end = (pmem_off + len) >> SECTOR_SHIFT;
> +	if (sector_end > sector_start) {
> +		nr_sectors = sector_end - sector_start;
> +		if (unlikely(is_bad_pmem(&pmem->bb, sector_start,
> +					 nr_sectors << SECTOR_SHIFT)))
> +			bad_pmem = true;

I don't think an unlikely annotation makes much sense for assigning
a boolean value to a flag variable.

> +		/*
> +		 * Pass sector aligned offset and length. That seems
> +		 * to work as of now. Other finer grained alignment
> +		 * cases can be addressed later if need be.
> +		 */

This comment seems pretty scary.  What other cases can you think of?

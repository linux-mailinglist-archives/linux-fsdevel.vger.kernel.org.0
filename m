Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6607A162B9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 18:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgBRRJ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 12:09:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49470 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgBRRJ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Leb7QTqh5fSW+ghKsnBixVziPFOkNZgzg9WjmOIRDnA=; b=ZyMmRzVP1vAuptylmoI4D/y6pR
        c4MJTWlmjsmnzq3bEIbq8d39WbgTuWQY2jSSU7TvIE1r7alHmSKszYGuDv9yea7Y8Zp0+UoHn2qWh
        2axbaQ4c8jqqf5g2FeMX7dJ6FKt+hiQBmgXR+xifdl+AtkqH9+w8MSZS8JgPGSvfzjF3gZCnuRdah
        xQtdFd5IVuSrZ/vaRE3j6rf0KZ1QMX8FcNMsEFT6IY2l8D/5v134HM5wxZ93VRsiL0vXxfvdiGyzd
        +m0k6BpVsch+HU+PHVi3EnsXuOAzkMU1Ct3TQrM8BdzGNWsroU4gUi6qGN23BdSXMfsRO4nXDLH5E
        pOXPEfDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j46NE-0000Ag-MC; Tue, 18 Feb 2020 17:09:28 +0000
Date:   Tue, 18 Feb 2020 09:09:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dm-devel@redhat.com
Subject: Re: [dm-devel] [PATCH v4 2/7] pmem: Enable pmem_do_write() to deal
 with arbitrary ranges
Message-ID: <20200218170928.GB30766@infradead.org>
References: <20200217181653.4706-1-vgoyal@redhat.com>
 <20200217181653.4706-3-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217181653.4706-3-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 01:16:48PM -0500, Vivek Goyal wrote:
> Currently pmem_do_write() is written with assumption that all I/O is
> sector aligned. Soon I want to use this function in zero_page_range()
> where range passed in does not have to be sector aligned.
> 
> Modify this function to be able to deal with an arbitrary range. Which
> is specified by pmem_off and len.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  drivers/nvdimm/pmem.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 075b11682192..fae8f67da9de 100644
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
> +		if (is_bad_pmem(&pmem->bb, sector_start,
> +				nr_sectors << SECTOR_SHIFT))
> +			bad_pmem = true;
> +	}
>  
>  	/*
>  	 * Note that we write the data both before and after
> @@ -181,7 +189,13 @@ static blk_status_t pmem_do_write(struct pmem_device *pmem,
>  	flush_dcache_page(page);
>  	write_pmem(pmem_addr, page, page_off, len);
>  	if (unlikely(bad_pmem)) {
> -		rc = pmem_clear_poison(pmem, pmem_off, len);
> +		/*
> +		 * Pass sector aligned offset and length. That seems
> +		 * to work as of now. Other finer grained alignment
> +		 * cases can be addressed later if need be.
> +		 */
> +		rc = pmem_clear_poison(pmem, ALIGN(pmem_real_off, SECTOR_SIZE),
> +				       nr_sectors << SECTOR_SHIFT);
>  		write_pmem(pmem_addr, page, page_off, len);

I'm still scared about the as of now commnet.  If the interface to
clearing poison is page aligned I think we should document that in the
actual pmem_clear_poison function, and make that take the unaligned
offset.  I also think we want some feedback from Dan or other what the
official interface is instead of "seems to work".


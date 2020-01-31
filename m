Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 797F514E87A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 06:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgAaFg1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 00:36:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgAaFg1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 00:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ke3dbCT+YnwsZLsPUvD3ntvW/LJGtenDcwK609jHAEo=; b=XGBnBHmrgeZ1KD+iKgjtwobVZ
        AOiVetEPQaMRsUQyeS24o+ElFc41RCZjoMHqo/sQbKqo94T1Xz9NmDVG1SCAxqK1KWmSX1Y/5AxSw
        PfpZ4lgc5Jc6pF0yQsPDpZ+riAe2h2enTMBTPZA1IOpcxAYyhwIPd6QCJZn7vNZuOD8YNSvmXLkUs
        dk1wz+l6aiHgcBu71pm039D3gK5eubVeXmGe7XqRpWdrt+AE2qkUJb68/SbSS384+MpFZAwSvhCzu
        ZINDOjYKskS6YjtYcZ80fiaklzx255DavCoWNWQotmtwOrw0Cs51+E69PpwIjLCTHLkwawbikbCN/
        uCO3wQr/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixOye-0005Db-2i; Fri, 31 Jan 2020 05:36:24 +0000
Date:   Thu, 30 Jan 2020 21:36:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, dan.j.williams@intel.com,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] dax,pmem: Provide a dax operation to zero range of memory
Message-ID: <20200131053624.GA3353@infradead.org>
References: <20200123165249.GA7664@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123165249.GA7664@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 23, 2020 at 11:52:49AM -0500, Vivek Goyal wrote:
> Hi,
> 
> This is an RFC patch to provide a dax operation to zero a range of memory.
> It will also clear poison in the process. This is primarily compile tested
> patch. I don't have real hardware to test the poison logic. I am posting
> this to figure out if this is the right direction or not.
> 
> Motivation from this patch comes from Christoph's feedback that he will
> rather prefer a dax way to zero a range instead of relying on having to
> call blkdev_issue_zeroout() in __dax_zero_page_range().
> 
> https://lkml.org/lkml/2019/8/26/361
> 
> My motivation for this change is virtiofs DAX support. There we use DAX
> but we don't have a block device. So any dax code which has the assumption
> that there is always a block device associated is a problem. So this
> is more of a cleanup of one of the places where dax has this dependency
> on block device and if we add a dax operation for zeroing a range, it
> can help with not having to call blkdev_issue_zeroout() in dax path.
> 
> I have yet to take care of stacked block drivers (dm/md).
> 
> Current poison clearing logic is primarily written with assumption that
> I/O is sector aligned. With this new method, this assumption is broken
> and one can pass any range of memory to zero. I have fixed few places
> in existing logic to be able to handle an arbitrary start/end. I am
> not sure are there other dependencies which might need fixing or
> prohibit us from providing this method.
> 
> Any feedback or comment is welcome.
> 
> Thanks
> Vivek
> 
> ---
>  drivers/dax/super.c   |   13 +++++++++
>  drivers/nvdimm/pmem.c |   67 ++++++++++++++++++++++++++++++++++++++++++--------
>  fs/dax.c              |   39 ++++++++---------------------
>  include/linux/dax.h   |    3 ++
>  4 files changed, 85 insertions(+), 37 deletions(-)
> 
> Index: rhvgoyal-linux/drivers/nvdimm/pmem.c
> ===================================================================
> --- rhvgoyal-linux.orig/drivers/nvdimm/pmem.c	2020-01-23 11:32:11.075139183 -0500
> +++ rhvgoyal-linux/drivers/nvdimm/pmem.c	2020-01-23 11:32:28.660139183 -0500
> @@ -52,8 +52,8 @@ static void hwpoison_clear(struct pmem_d
>  	if (is_vmalloc_addr(pmem->virt_addr))
>  		return;
>  
> -	pfn_start = PHYS_PFN(phys);
> -	pfn_end = pfn_start + PHYS_PFN(len);
> +	pfn_start = PFN_UP(phys);
> +	pfn_end = PFN_DOWN(phys + len);
>  	for (pfn = pfn_start; pfn < pfn_end; pfn++) {
>  		struct page *page = pfn_to_page(pfn);
>  

This change looks unrelated to the rest.

> +	sector_end = ALIGN_DOWN((offset - pmem->data_offset + len), 512)/512;
> +	nr_sectors =  sector_end - sector_start;
>  
>  	cleared = nvdimm_clear_poison(dev, pmem->phys_addr + offset, len);
>  	if (cleared < len)
>  		rc = BLK_STS_IOERR;
> -	if (cleared > 0 && cleared / 512) {
> +	if (cleared > 0 && nr_sectors > 0) {
>  		hwpoison_clear(pmem, pmem->phys_addr + offset, cleared);
> -		cleared /= 512;
> -		dev_dbg(dev, "%#llx clear %ld sector%s\n",
> -				(unsigned long long) sector, cleared,
> -				cleared > 1 ? "s" : "");
> -		badblocks_clear(&pmem->bb, sector, cleared);
> +		dev_dbg(dev, "%#llx clear %d sector%s\n",
> +				(unsigned long long) sector_start, nr_sectors,
> +				nr_sectors > 1 ? "s" : "");
> +		badblocks_clear(&pmem->bb, sector_start, nr_sectors);
>  		if (pmem->bb_state)
>  			sysfs_notify_dirent(pmem->bb_state);
>  	}

As does this one?

>  int __dax_zero_page_range(struct block_device *bdev,
>  		struct dax_device *dax_dev, sector_t sector,
>  		unsigned int offset, unsigned int size)
>  {
> +	pgoff_t pgoff;
> +	long rc, id;
>  
> +	rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
> +	if (rc)
> +		return rc;
> +
> +	id = dax_read_lock();
> +	rc = dax_zero_page_range(dax_dev, pgoff, offset, size);
> +	if (rc == -EOPNOTSUPP) {
>  		void *kaddr;
>  
> +		/* If driver does not implement zero page range, fallback */

I think we'll want to restructure this a bit.  First make the new
method mandatory, and just provide a generic_dax_zero_page_range or
similar for the non-pmem instances.

Then __dax_zero_page_range and iomap_dax_zero should merge, and maybe
eventually iomap_zero_range_actor and iomap_zero_range should be split
into a pagecache and DAX variant, lifting the IS_DAXD check into the
callers.

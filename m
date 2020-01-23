Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14AD2147157
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 20:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgAWTBl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 14:01:41 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56944 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAWTBk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:01:40 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NJ0Uko152379;
        Thu, 23 Jan 2020 19:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=TGwwceTb5XOMDhp8vVKKDOgktEhgcIdP172xsUDeJcA=;
 b=PIab1DMjmLNDxtwYQt3PSgETIz1MtM+TLtlI+ORhABXaNk6xYDuXqd1icf2fS8zEnjj7
 HoSKOetQo8lLCmUWmeZ/ufjng9KtkRYvOmAoQfjz/tZZgfX8Sg4ZFcVZTRXAyxMGF1Nc
 6Zws6NbRRPLLNQuJC3X3uB1d0kGNuO0V53ZlFwQkfyDPC6M2kUMSdeRHu8Nde9f8f4Ab
 MLnWitgeUAx5rc2f8BmZwHHQPGWg5LbNnpT7NwLnMbvZVmQ70ydeBrinRgZAdObLma32
 n1HiP6WqBnOc2Q3xkTKH+k3ZTocGiuZAPI4THBQQc9ZIXIREDfKavlqwHGfO9U9I22cT UQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xktnrm8ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 19:01:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NInfQj121748;
        Thu, 23 Jan 2020 19:01:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2xpt6q02d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 19:01:06 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00NJ145F002358;
        Thu, 23 Jan 2020 19:01:05 GMT
Received: from localhost (/10.159.139.74)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Jan 2020 11:01:04 -0800
Date:   Thu, 23 Jan 2020 11:01:03 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, dan.j.williams@intel.com,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        vishal.l.verma@intel.com, Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [RFC] dax,pmem: Provide a dax operation to zero range of memory
Message-ID: <20200123190103.GB8236@magnolia>
References: <20200123165249.GA7664@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123165249.GA7664@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001230142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001230142
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

So who gest to use this? :)

Should we (XFS) make fallocate(ZERO_RANGE) detect when it's operating on
a written extent in a DAX file and call this instead of what it does now
(punch range and reallocate unwritten)?

Is this the kind of thing XFS should just do on its own when DAX us that
some range of pmem has gone bad and now we need to (a) race with the
userland programs to write /something/ to the range to prevent a machine
check, (b) whack all the programs that think they have a mapping to
their data, (c) see if we have a DRAM copy and just write that back, (d)
set wb_err so fsyncs fail, and/or (e) regenerate metadata as necessary?

<cough> Will XFS ever get that "your storage went bad" hook that was
promised ages ago?

Though I guess it only does this a single page at a time, which won't be
awesome if we're trying to zero (say) 100GB of pmem.  I was expecting to
see one big memset() call to zero the entire range followed by
pmem_clear_poison() on the entire range, but I guess you did tag this
RFC. :)

--D

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
> @@ -71,22 +71,24 @@ static blk_status_t pmem_clear_poison(st
>  		phys_addr_t offset, unsigned int len)
>  {
>  	struct device *dev = to_dev(pmem);
> -	sector_t sector;
> +	sector_t sector_start, sector_end;
>  	long cleared;
>  	blk_status_t rc = BLK_STS_OK;
> +	int nr_sectors;
>  
> -	sector = (offset - pmem->data_offset) / 512;
> +	sector_start = ALIGN((offset - pmem->data_offset), 512) / 512;
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
> @@ -268,6 +270,50 @@ static const struct block_device_operati
>  	.revalidate_disk =	nvdimm_revalidate_disk,
>  };
>  
> +static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
> +				    unsigned int offset, loff_t len)
> +{
> +	int rc = 0;
> +	phys_addr_t phys_pos = pgoff * PAGE_SIZE + offset;
> +	struct pmem_device *pmem = dax_get_private(dax_dev);
> +	struct page *page = ZERO_PAGE(0);
> +
> +	do {
> +		unsigned bytes, nr_sectors = 0;
> +		sector_t sector_start, sector_end;
> +		bool bad_pmem = false;
> +		phys_addr_t pmem_off = phys_pos + pmem->data_offset;
> +		void *pmem_addr = pmem->virt_addr + pmem_off;
> +		unsigned int page_offset;
> +
> +		page_offset = offset_in_page(phys_pos);
> +		bytes = min_t(loff_t, PAGE_SIZE - page_offset, len);
> +
> +		sector_start = ALIGN(phys_pos, 512)/512;
> +		sector_end = ALIGN_DOWN(phys_pos + bytes, 512)/512;
> +		if (sector_end > sector_start)
> +			nr_sectors = sector_end - sector_start;
> +
> +		if (nr_sectors &&
> +		    unlikely(is_bad_pmem(&pmem->bb, sector_start,
> +					 nr_sectors * 512)))
> +			bad_pmem = true;
> +
> +		write_pmem(pmem_addr, page, 0, bytes);
> +		if (unlikely(bad_pmem)) {
> +			rc = pmem_clear_poison(pmem, pmem_off, bytes);
> +			write_pmem(pmem_addr, page, 0, bytes);
> +		}
> +		if (rc > 0)
> +			return -EIO;
> +
> +		phys_pos += phys_pos + bytes;
> +		len -= bytes;
> +	} while (len > 0);
> +
> +	return 0;
> +}
> +
>  static long pmem_dax_direct_access(struct dax_device *dax_dev,
>  		pgoff_t pgoff, long nr_pages, void **kaddr, pfn_t *pfn)
>  {
> @@ -299,6 +345,7 @@ static const struct dax_operations pmem_
>  	.dax_supported = generic_fsdax_supported,
>  	.copy_from_iter = pmem_copy_from_iter,
>  	.copy_to_iter = pmem_copy_to_iter,
> +	.zero_page_range = pmem_dax_zero_page_range,
>  };
>  
>  static const struct attribute_group *pmem_attribute_groups[] = {
> Index: rhvgoyal-linux/include/linux/dax.h
> ===================================================================
> --- rhvgoyal-linux.orig/include/linux/dax.h	2020-01-23 11:25:23.814139183 -0500
> +++ rhvgoyal-linux/include/linux/dax.h	2020-01-23 11:32:17.799139183 -0500
> @@ -34,6 +34,8 @@ struct dax_operations {
>  	/* copy_to_iter: required operation for fs-dax direct-i/o */
>  	size_t (*copy_to_iter)(struct dax_device *, pgoff_t, void *, size_t,
>  			struct iov_iter *);
> +	/* zero_page_range: optional operation for fs-dax direct-i/o */
> +	int (*zero_page_range)(struct dax_device *, pgoff_t, unsigned, loff_t);
>  };
>  
>  extern struct attribute_group dax_attribute_group;
> @@ -209,6 +211,7 @@ size_t dax_copy_from_iter(struct dax_dev
>  		size_t bytes, struct iov_iter *i);
>  size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
>  		size_t bytes, struct iov_iter *i);
> +int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff, unsigned offset, loff_t len);
>  void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
>  
>  ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
> Index: rhvgoyal-linux/fs/dax.c
> ===================================================================
> --- rhvgoyal-linux.orig/fs/dax.c	2020-01-23 11:25:23.814139183 -0500
> +++ rhvgoyal-linux/fs/dax.c	2020-01-23 11:32:17.801139183 -0500
> @@ -1044,38 +1044,23 @@ static vm_fault_t dax_load_hole(struct x
>  	return ret;
>  }
>  
> -static bool dax_range_is_aligned(struct block_device *bdev,
> -				 unsigned int offset, unsigned int length)
> -{
> -	unsigned short sector_size = bdev_logical_block_size(bdev);
> -
> -	if (!IS_ALIGNED(offset, sector_size))
> -		return false;
> -	if (!IS_ALIGNED(length, sector_size))
> -		return false;
> -
> -	return true;
> -}
> -
>  int __dax_zero_page_range(struct block_device *bdev,
>  		struct dax_device *dax_dev, sector_t sector,
>  		unsigned int offset, unsigned int size)
>  {
> -	if (dax_range_is_aligned(bdev, offset, size)) {
> -		sector_t start_sector = sector + (offset >> 9);
> +	pgoff_t pgoff;
> +	long rc, id;
>  
> -		return blkdev_issue_zeroout(bdev, start_sector,
> -				size >> 9, GFP_NOFS, 0);
> -	} else {
> -		pgoff_t pgoff;
> -		long rc, id;
> +	rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
> +	if (rc)
> +		return rc;
> +
> +	id = dax_read_lock();
> +	rc = dax_zero_page_range(dax_dev, pgoff, offset, size);
> +	if (rc == -EOPNOTSUPP) {
>  		void *kaddr;
>  
> -		rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
> -		if (rc)
> -			return rc;
> -
> -		id = dax_read_lock();
> +		/* If driver does not implement zero page range, fallback */
>  		rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
>  		if (rc < 0) {
>  			dax_read_unlock(id);
> @@ -1083,9 +1068,9 @@ int __dax_zero_page_range(struct block_d
>  		}
>  		memset(kaddr + offset, 0, size);
>  		dax_flush(dax_dev, kaddr + offset, size);
> -		dax_read_unlock(id);
>  	}
> -	return 0;
> +	dax_read_unlock(id);
> +	return rc;
>  }
>  EXPORT_SYMBOL_GPL(__dax_zero_page_range);
>  
> Index: rhvgoyal-linux/drivers/dax/super.c
> ===================================================================
> --- rhvgoyal-linux.orig/drivers/dax/super.c	2020-01-23 11:25:23.814139183 -0500
> +++ rhvgoyal-linux/drivers/dax/super.c	2020-01-23 11:32:17.802139183 -0500
> @@ -344,6 +344,19 @@ size_t dax_copy_to_iter(struct dax_devic
>  }
>  EXPORT_SYMBOL_GPL(dax_copy_to_iter);
>  
> +int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
> +			unsigned offset, loff_t len)
> +{
> +	if (!dax_alive(dax_dev))
> +		return 0;
> +
> +	if (!dax_dev->ops->zero_page_range)
> +		return -EOPNOTSUPP;
> +
> +	return dax_dev->ops->zero_page_range(dax_dev, pgoff, offset, len);
> +}
> +EXPORT_SYMBOL_GPL(dax_zero_page_range);
> +
>  #ifdef CONFIG_ARCH_HAS_PMEM_API
>  void arch_wb_cache_pmem(void *addr, size_t size);
>  void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
> 

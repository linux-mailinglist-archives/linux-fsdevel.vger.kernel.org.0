Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C1126A9E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 18:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgIOQef (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 12:34:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51368 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbgIOQdm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:33:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FGUxkp137274;
        Tue, 15 Sep 2020 16:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=EySSFs/mkWAdsBkj1u/J5ie8Sv/9oH6sVII8xbItpCw=;
 b=p5iQS7y18Ip+5cIDhWFg1wnPX0miaN9TSUk18AqKYQnOWi9sblfvEOreraAEaPnPs9Gi
 GJpmffca68bOdAGLz7c6GDNVE1LSAZHyExlQEWpkSsiDQ+padABKXNo/rkQ5RyklpaB6
 xv8bwcdCYXMLX//tElU1CFQqEqvjaME4Gwvie+mfI4hVcMIAdCJlsodG6cKH+qLo+EPJ
 fbjPDMktxCS2JUDcuKNWlyFF/xQK69MkjQW9l649+ZEVCDfRa1c0j3qraTdJdBb8ugWX
 GXlEbtCJUJAHs3z/sF62QySDF2awj7iFUNqB3I4s/Y2MOHkbODYmjDDkZC/RhCmgHoTY TA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 33j91dfu6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 16:33:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FGTwFn120010;
        Tue, 15 Sep 2020 16:31:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 33h7wpd5gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 16:31:07 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08FGV4nB012357;
        Tue, 15 Sep 2020 16:31:05 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Sep 2020 16:31:04 +0000
Date:   Tue, 15 Sep 2020 09:31:04 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de,
        qi.fuli@fujitsu.com, y-goto@fujitsu.com
Subject: Re: [RFC PATCH 2/4] pagemap: introduce ->memory_failure()
Message-ID: <20200915163104.GG7964@magnolia>
References: <20200915101311.144269-1-ruansy.fnst@cn.fujitsu.com>
 <20200915101311.144269-3-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915101311.144269-3-ruansy.fnst@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=1 mlxlogscore=999
 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150134
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 06:13:09PM +0800, Shiyang Ruan wrote:
> When memory-failure occurs, we call this function which is implemented
> by each devices.  For fsdax, pmem device implements it.  Pmem device
> will find out the block device where the error page located in, gets the
> filesystem on this block device, and finally call ->storage_lost() to
> handle the error in filesystem layer.
> 
> Normally, a pmem device may contain one or more partitions, each
> partition contains a block device, each block device contains a
> filesystem.  So we are able to find out the filesystem by one offset on
> this pmem device.  However, in other cases, such as mapped device, I
> didn't find a way to obtain the filesystem laying on it.  It is a
> problem need to be fixed.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> ---
>  block/genhd.c            | 12 ++++++++++++
>  drivers/nvdimm/pmem.c    | 31 +++++++++++++++++++++++++++++++
>  include/linux/genhd.h    |  2 ++
>  include/linux/memremap.h |  3 +++
>  4 files changed, 48 insertions(+)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 99c64641c314..e7442b60683e 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1063,6 +1063,18 @@ struct block_device *bdget_disk(struct gendisk *disk, int partno)
>  }
>  EXPORT_SYMBOL(bdget_disk);
>  
> +struct block_device *bdget_disk_sector(struct gendisk *disk, sector_t sector)
> +{
> +	struct block_device *bdev = NULL;
> +	struct hd_struct *part = disk_map_sector_rcu(disk, sector);
> +
> +	if (part)
> +		bdev = bdget(part_devt(part));
> +
> +	return bdev;
> +}
> +EXPORT_SYMBOL(bdget_disk_sector);
> +
>  /*
>   * print a full list of all partitions - intended for places where the root
>   * filesystem can't be mounted and thus to give the victim some idea of what
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index fab29b514372..3ed96486c883 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -364,9 +364,40 @@ static void pmem_release_disk(void *__pmem)
>  	put_disk(pmem->disk);
>  }
>  
> +static int pmem_pagemap_memory_failure(struct dev_pagemap *pgmap,
> +		struct mf_recover_controller *mfrc)
> +{
> +	struct pmem_device *pdev;
> +	struct block_device *bdev;
> +	sector_t disk_sector;
> +	loff_t bdev_offset;
> +
> +	pdev = container_of(pgmap, struct pmem_device, pgmap);
> +	if (!pdev->disk)
> +		return -ENXIO;
> +
> +	disk_sector = (PFN_PHYS(mfrc->pfn) - pdev->phys_addr) >> SECTOR_SHIFT;

Ah, I see, looking at the current x86 MCE code, the MCE handler gets a
physical address, which is then rounded down to a PFN, which is then
blown back up into a byte address(?) and then rounded down to sectors.
That is then blown back up into a byte address and passed on to XFS,
which rounds it down to fs blocksize.

/me wishes that wasn't so convoluted, but reforming the whole mm poison
system to have smaller blast radii isn't the purpose of this patch. :)

> +	bdev = bdget_disk_sector(pdev->disk, disk_sector);
> +	if (!bdev)
> +		return -ENXIO;
> +
> +	// TODO what if block device contains a mapped device

Find its dev_pagemap_ops and invoke its memory_failure function? ;)

> +	if (!bdev->bd_super)
> +		goto out;
> +
> +	bdev_offset = ((disk_sector - get_start_sect(bdev)) << SECTOR_SHIFT) -
> +			pdev->data_offset;
> +	bdev->bd_super->s_op->storage_lost(bdev->bd_super, bdev_offset, mfrc);

->storage_lost is required for all filesystems?

--D

> +
> +out:
> +	bdput(bdev);
> +	return 0;
> +}
> +
>  static const struct dev_pagemap_ops fsdax_pagemap_ops = {
>  	.kill			= pmem_pagemap_kill,
>  	.cleanup		= pmem_pagemap_cleanup,
> +	.memory_failure		= pmem_pagemap_memory_failure,
>  };
>  
>  static int pmem_attach_disk(struct device *dev,
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 4ab853461dff..16e9e13e0841 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -303,6 +303,8 @@ static inline void add_disk_no_queue_reg(struct gendisk *disk)
>  extern void del_gendisk(struct gendisk *gp);
>  extern struct gendisk *get_gendisk(dev_t dev, int *partno);
>  extern struct block_device *bdget_disk(struct gendisk *disk, int partno);
> +extern struct block_device *bdget_disk_sector(struct gendisk *disk,
> +			sector_t sector);
>  
>  extern void set_device_ro(struct block_device *bdev, int flag);
>  extern void set_disk_ro(struct gendisk *disk, int flag);
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 5f5b2df06e61..efebefa70d00 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -6,6 +6,7 @@
>  
>  struct resource;
>  struct device;
> +struct mf_recover_controller;
>  
>  /**
>   * struct vmem_altmap - pre-allocated storage for vmemmap_populate
> @@ -87,6 +88,8 @@ struct dev_pagemap_ops {
>  	 * the page back to a CPU accessible page.
>  	 */
>  	vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
> +	int (*memory_failure)(struct dev_pagemap *pgmap,
> +			      struct mf_recover_controller *mfrc);
>  };
>  
>  #define PGMAP_ALTMAP_VALID	(1 << 0)
> -- 
> 2.28.0
> 
> 
> 

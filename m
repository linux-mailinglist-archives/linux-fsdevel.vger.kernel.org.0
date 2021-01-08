Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85A92EF7E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 20:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbhAHTIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 14:08:44 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44178 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbhAHTIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 14:08:44 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 108J3uhx137700;
        Fri, 8 Jan 2021 19:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=gTWNh4yAjiGfRbnekPKUs3nwesv1+4so7sLkT0tKLdk=;
 b=jBtRaw+/CWQFKX8HElrE6u7EFhoI/GD7hrSfD+WIAKiDASf4rXEZYcb0jLSAtnDHPwTZ
 1DNYYUCXB7SaQVVB9HHSb86FhIA6QSn4IhEPTXbSZCGsCIxM2FBlAdkPPIrwRJEGnkac
 FKSigVSi6pvz10rAkvmJhs/dzySw8nSWu+7zvO4qDx1OfzJQXYRbhM/BLyTyr6G2XeQz
 UeuFKWrE3LWBQ+O5IaI3NTjMxuMuvaTXCtrieocLZFQdNINPJfvATswlCY7gj3kw3k8B
 gqgCejhzE1IYAO3kjJ/dLeWW5I7fh/YerS94hAxKSR6nS1l11OVSsdtdOj25NskHY5Wk Gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 35wftxj2eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 08 Jan 2021 19:07:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 108J5V6j013394;
        Fri, 8 Jan 2021 19:05:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 35w3g4t0t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jan 2021 19:05:33 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 108J5L04021299;
        Fri, 8 Jan 2021 19:05:21 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Jan 2021 11:05:21 -0800
Date:   Fri, 8 Jan 2021 11:05:19 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@lst.de,
        song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com,
        y-goto@fujitsu.com, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [RFC PATCH v3 8/9] md: Implement ->corrupted_range()
Message-ID: <20210108190519.GQ6918@magnolia>
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
 <20201215121414.253660-9-ruansy.fnst@cn.fujitsu.com>
 <20201215205102.GB6918@magnolia>
 <cc48c42d-d8af-c915-5aef-17b7d4853c3c@cn.fujitsu.com>
 <20210104233423.GR6918@magnolia>
 <77ecf385-0edc-6576-8963-867adbb9405b@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77ecf385-0edc-6576-8963-867adbb9405b@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9858 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101080102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9858 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101080102
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 08, 2021 at 05:52:11PM +0800, Ruan Shiyang wrote:
> 
> 
> On 2021/1/5 上午7:34, Darrick J. Wong wrote:
> > On Fri, Dec 18, 2020 at 10:11:54AM +0800, Ruan Shiyang wrote:
> > > 
> > > 
> > > On 2020/12/16 上午4:51, Darrick J. Wong wrote:
> > > > On Tue, Dec 15, 2020 at 08:14:13PM +0800, Shiyang Ruan wrote:
> > > > > With the support of ->rmap(), it is possible to obtain the superblock on
> > > > > a mapped device.
> > > > > 
> > > > > If a pmem device is used as one target of mapped device, we cannot
> > > > > obtain its superblock directly.  With the help of SYSFS, the mapped
> > > > > device can be found on the target devices.  So, we iterate the
> > > > > bdev->bd_holder_disks to obtain its mapped device.
> > > > > 
> > > > > Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> > > > > ---
> > > > >    drivers/md/dm.c       | 66 +++++++++++++++++++++++++++++++++++++++++++
> > > > >    drivers/nvdimm/pmem.c |  9 ++++--
> > > > >    fs/block_dev.c        | 21 ++++++++++++++
> > > > >    include/linux/genhd.h |  7 +++++
> > > > >    4 files changed, 100 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > > > > index 4e0cbfe3f14d..9da1f9322735 100644
> > > > > --- a/drivers/md/dm.c
> > > > > +++ b/drivers/md/dm.c
> > > > > @@ -507,6 +507,71 @@ static int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
> > > > >    #define dm_blk_report_zones		NULL
> > > > >    #endif /* CONFIG_BLK_DEV_ZONED */
> > > > > +struct dm_blk_corrupt {
> > > > > +	struct block_device *bdev;
> > > > > +	sector_t offset;
> > > > > +};
> > > > > +
> > > > > +static int dm_blk_corrupt_fn(struct dm_target *ti, struct dm_dev *dev,
> > > > > +				sector_t start, sector_t len, void *data)
> > > > > +{
> > > > > +	struct dm_blk_corrupt *bc = data;
> > > > > +
> > > > > +	return bc->bdev == (void *)dev->bdev &&
> > > > > +			(start <= bc->offset && bc->offset < start + len);
> > > > > +}
> > > > > +
> > > > > +static int dm_blk_corrupted_range(struct gendisk *disk,
> > > > > +				  struct block_device *target_bdev,
> > > > > +				  loff_t target_offset, size_t len, void *data)
> > > > > +{
> > > > > +	struct mapped_device *md = disk->private_data;
> > > > > +	struct block_device *md_bdev = md->bdev;
> > > > > +	struct dm_table *map;
> > > > > +	struct dm_target *ti;
> > > > > +	struct super_block *sb;
> > > > > +	int srcu_idx, i, rc = 0;
> > > > > +	bool found = false;
> > > > > +	sector_t disk_sec, target_sec = to_sector(target_offset);
> > > > > +
> > > > > +	map = dm_get_live_table(md, &srcu_idx);
> > > > > +	if (!map)
> > > > > +		return -ENODEV;
> > > > > +
> > > > > +	for (i = 0; i < dm_table_get_num_targets(map); i++) {
> > > > > +		ti = dm_table_get_target(map, i);
> > > > > +		if (ti->type->iterate_devices && ti->type->rmap) {
> > > > > +			struct dm_blk_corrupt bc = {target_bdev, target_sec};
> > > > > +
> > > > > +			found = ti->type->iterate_devices(ti, dm_blk_corrupt_fn, &bc);
> > > > > +			if (!found)
> > > > > +				continue;
> > > > > +			disk_sec = ti->type->rmap(ti, target_sec);
> > > > 
> > > > What happens if the dm device has multiple reverse mappings because the
> > > > physical storage is being shared at multiple LBAs?  (e.g. a
> > > > deduplication target)
> > > 
> > > I thought that the dm device knows the mapping relationship, and it can be
> > > done by implementation of ->rmap() in each target.  Did I understand it
> > > wrong?
> > 
> > The dm device /does/ know the mapping relationship.  I'm asking what
> > happens if there are *multiple* mappings.  For example, a deduplicating
> > dm device could observe that the upper level code wrote some data to
> > sector 200 and now it wants to write the same data to sector 500.
> > Instead of writing twice, it simply maps sector 500 in its LBA space to
> > the same space that it mapped sector 200.
> > 
> > Pretend that sector 200 on the dm-dedupe device maps to sector 64 on the
> > underlying storage (call it /dev/pmem1 and let's say it's the only
> > target sitting underneath the dm-dedupe device).
> > 
> > If /dev/pmem1 then notices that sector 64 has gone bad, it will start
> > calling ->corrupted_range handlers until it calls dm_blk_corrupted_range
> > on the dm-dedupe device.  At least in theory, the dm-dedupe driver's
> > rmap method ought to return both (64 -> 200) and (64 -> 500) so that
> > dm_blk_corrupted_range can pass on both corruption notices to whatever's
> > sitting atop the dedupe device.
> > 
> > At the moment, your ->rmap prototype is only capable of returning one
> > sector_t mapping per target, and there's only the one target under the
> > dedupe device, so we cannot report the loss of sectors 200 and 500 to
> > whatever device is sitting on top of dm-dedupe.
> 
> Got it.  I didn't know there is a kind of dm device called dm-dedupe. Thanks
> for the guidance.

There isn't one upstream, but there are out of tree deduplication
drivers (VDO) and in principle any dm target can have multiple forward
mappings to a single block on the lower device.

--D

> 
> --
> Thanks,
> Ruan Shiyang.
> 
> > 
> > --D
> > 
> > > > 
> > > > > +			break;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	if (!found) {
> > > > > +		rc = -ENODEV;
> > > > > +		goto out;
> > > > > +	}
> > > > > +
> > > > > +	sb = get_super(md_bdev);
> > > > > +	if (!sb) {
> > > > > +		rc = bd_disk_holder_corrupted_range(md_bdev, to_bytes(disk_sec), len, data);
> > > > > +		goto out;
> > > > > +	} else if (sb->s_op->corrupted_range) {
> > > > > +		loff_t off = to_bytes(disk_sec - get_start_sect(md_bdev));
> > > > > +
> > > > > +		rc = sb->s_op->corrupted_range(sb, md_bdev, off, len, data);
> > > > 
> > > > This "call bd_disk_holder_corrupted_range or sb->s_op->corrupted_range"
> > > > logic appears twice; should it be refactored into a common helper?
> > > > 
> > > > Or, should the superblock dispatch part move to
> > > > bd_disk_holder_corrupted_range?
> > > 
> > > bd_disk_holder_corrupted_range() requires SYSFS configuration.  I introduce
> > > it to handle those block devices that can not obtain superblock by
> > > `get_super()`.
> > > 
> > > Usually, if we create filesystem directly on a pmem device, or make some
> > > partitions at first, we can use `get_super()` to get the superblock.  In
> > > other case, such as creating a LVM on pmem device, `get_super()` does not
> > > work.
> > > 
> > > So, I think refactoring it into a common helper looks better.
> > > 
> > > 
> > > --
> > > Thanks,
> > > Ruan Shiyang.
> > > 
> > > > 
> > > > > +	}
> > > > > +	drop_super(sb);
> > > > > +
> > > > > +out:
> > > > > +	dm_put_live_table(md, srcu_idx);
> > > > > +	return rc;
> > > > > +}
> > > > > +
> > > > >    static int dm_prepare_ioctl(struct mapped_device *md, int *srcu_idx,
> > > > >    			    struct block_device **bdev)
> > > > >    {
> > > > > @@ -3084,6 +3149,7 @@ static const struct block_device_operations dm_blk_dops = {
> > > > >    	.getgeo = dm_blk_getgeo,
> > > > >    	.report_zones = dm_blk_report_zones,
> > > > >    	.pr_ops = &dm_pr_ops,
> > > > > +	.corrupted_range = dm_blk_corrupted_range,
> > > > >    	.owner = THIS_MODULE
> > > > >    };
> > > > > diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> > > > > index 4688bff19c20..e8cfaf860149 100644
> > > > > --- a/drivers/nvdimm/pmem.c
> > > > > +++ b/drivers/nvdimm/pmem.c
> > > > > @@ -267,11 +267,14 @@ static int pmem_corrupted_range(struct gendisk *disk, struct block_device *bdev,
> > > > >    	bdev_offset = (disk_sector - get_start_sect(bdev)) << SECTOR_SHIFT;
> > > > >    	sb = get_super(bdev);
> > > > > -	if (sb && sb->s_op->corrupted_range) {
> > > > > +	if (!sb) {
> > > > > +		rc = bd_disk_holder_corrupted_range(bdev, bdev_offset, len, data);
> > > > > +		goto out;
> > > > > +	} else if (sb->s_op->corrupted_range)
> > > > >    		rc = sb->s_op->corrupted_range(sb, bdev, bdev_offset, len, data);
> > > > > -		drop_super(sb);
> > > > 
> > > > This is out of scope for this patch(set) but do you think that the scsi
> > > > disk driver should intercept media errors from sense data and call
> > > > ->corrupted_range too?  ISTR Ted muttering that one of his employers had
> > > > a patchset to do more with sense data than the upstream kernel currently
> > > > does...
> > > > 
> > > > > -	}
> > > > > +	drop_super(sb);
> > > > > +out:
> > > > >    	bdput(bdev);
> > > > >    	return rc;
> > > > >    }
> > > > > diff --git a/fs/block_dev.c b/fs/block_dev.c
> > > > > index 9e84b1928b94..d3e6bddb8041 100644
> > > > > --- a/fs/block_dev.c
> > > > > +++ b/fs/block_dev.c
> > > > > @@ -1171,6 +1171,27 @@ struct bd_holder_disk {
> > > > >    	int			refcnt;
> > > > >    };
> > > > > +int bd_disk_holder_corrupted_range(struct block_device *bdev, loff_t off, size_t len, void *data)
> > > > > +{
> > > > > +	struct bd_holder_disk *holder;
> > > > > +	struct gendisk *disk;
> > > > > +	int rc = 0;
> > > > > +
> > > > > +	if (list_empty(&(bdev->bd_holder_disks)))
> > > > > +		return -ENODEV;
> > > > > +
> > > > > +	list_for_each_entry(holder, &bdev->bd_holder_disks, list) {
> > > > > +		disk = holder->disk;
> > > > > +		if (disk->fops->corrupted_range) {
> > > > > +			rc = disk->fops->corrupted_range(disk, bdev, off, len, data);
> > > > > +			if (rc != -ENODEV)
> > > > > +				break;
> > > > > +		}
> > > > > +	}
> > > > > +	return rc;
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(bd_disk_holder_corrupted_range);
> > > > > +
> > > > >    static struct bd_holder_disk *bd_find_holder_disk(struct block_device *bdev,
> > > > >    						  struct gendisk *disk)
> > > > >    {
> > > > > diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> > > > > index ed06209008b8..fba247b852fa 100644
> > > > > --- a/include/linux/genhd.h
> > > > > +++ b/include/linux/genhd.h
> > > > > @@ -382,9 +382,16 @@ int blkdev_ioctl(struct block_device *, fmode_t, unsigned, unsigned long);
> > > > >    long compat_blkdev_ioctl(struct file *, unsigned, unsigned long);
> > > > >    #ifdef CONFIG_SYSFS
> > > > > +int bd_disk_holder_corrupted_range(struct block_device *bdev, loff_t off,
> > > > > +				   size_t len, void *data);
> > > > >    int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk);
> > > > >    void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk);
> > > > >    #else
> > > > > +int bd_disk_holder_corrupted_range(struct block_device *bdev, loff_t off,
> > > > > +				   size_t len, void *data)
> > > > > +{
> > > > > +	return 0;
> > > > > +}
> > > > >    static inline int bd_link_disk_holder(struct block_device *bdev,
> > > > >    				      struct gendisk *disk)
> > > > >    {
> > > > > -- 
> > > > > 2.29.2
> > > > > 
> > > > > 
> > > > > 
> > > > 
> > > > 
> > > 
> > > 
> > 
> > 
> 
> 

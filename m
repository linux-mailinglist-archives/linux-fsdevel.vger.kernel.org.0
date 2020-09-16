Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E378026B9C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 04:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgIPCQ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 22:16:57 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:50154 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726061AbgIPCQ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:16:56 -0400
X-IronPort-AV: E=Sophos;i="5.76,430,1592841600"; 
   d="scan'208";a="99286190"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Sep 2020 10:16:51 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 5F18648990F1;
        Wed, 16 Sep 2020 10:16:48 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Sep
 2020 10:16:46 +0800
Subject: Re: [RFC PATCH 1/4] fs: introduce ->storage_lost() for memory-failure
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>,
        <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
References: <20200915101311.144269-1-ruansy.fnst@cn.fujitsu.com>
 <20200915101311.144269-2-ruansy.fnst@cn.fujitsu.com>
 <20200915161606.GD7955@magnolia>
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <a84d6fcb-977c-0b00-0690-350dcd8a5117@cn.fujitsu.com>
Date:   Wed, 16 Sep 2020 10:15:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915161606.GD7955@magnolia>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 5F18648990F1.A96BC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/9/16 上午12:16, Darrick J. Wong wrote:
> On Tue, Sep 15, 2020 at 06:13:08PM +0800, Shiyang Ruan wrote:
>> This function is used to handle errors which may cause data lost in
>> filesystem.  Such as memory-failure in fsdax mode.
>>
>> In XFS, it requires "rmapbt" feature in order to query for files or
>> metadata which associated to the error block.  Then we could call fs
>> recover functions to try to repair the damaged data.(did not implemented
>> in this patch)
>>
>> After that, the memory-failure also needs to kill processes who are
>> using those files.  The struct mf_recover_controller is created to store
>> necessary parameters.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
>> ---
>>   fs/xfs/xfs_super.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/fs.h |  1 +
>>   include/linux/mm.h |  6 ++++
>>   3 files changed, 87 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
>> index 71ac6c1cdc36..118d9c5d9e1e 100644
>> --- a/fs/xfs/xfs_super.c
>> +++ b/fs/xfs/xfs_super.c
>> @@ -35,6 +35,10 @@
>>   #include "xfs_refcount_item.h"
>>   #include "xfs_bmap_item.h"
>>   #include "xfs_reflink.h"
>> +#include "xfs_alloc.h"
>> +#include "xfs_rmap.h"
>> +#include "xfs_rmap_btree.h"
>> +#include "xfs_bit.h"
>>   
>>   #include <linux/magic.h>
>>   #include <linux/fs_context.h>
>> @@ -1104,6 +1108,81 @@ xfs_fs_free_cached_objects(
>>   	return xfs_reclaim_inodes_nr(XFS_M(sb), sc->nr_to_scan);
>>   }
>>   
>> +static int
>> +xfs_storage_lost_helper(
>> +	struct xfs_btree_cur		*cur,
>> +	struct xfs_rmap_irec		*rec,
>> +	void				*priv)
>> +{
>> +	struct xfs_inode		*ip;
>> +	struct mf_recover_controller	*mfrc = priv;
>> +	int				rc = 0;
>> +
>> +	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner)) {
>> +		// TODO check and try to fix metadata
>> +	} else {
>> +		/*
>> +		 * Get files that incore, filter out others that are not in use.
>> +		 */
>> +		xfs_iget(cur->bc_mp, cur->bc_tp, rec->rm_owner, XFS_IGET_INCORE,
>> +			 0, &ip);
> 
> Missing return value check here.

Yes, I ignored it.  My fault.

> 
>> +		if (!ip)
>> +			return 0;
>> +		if (!VFS_I(ip)->i_mapping)
>> +			goto out;
>> +
>> +		rc = mfrc->recover_fn(mfrc->pfn, mfrc->flags,
>> +				      VFS_I(ip)->i_mapping, rec->rm_offset);
>> +
>> +		// TODO try to fix data
>> +out:
>> +		xfs_irele(ip);
>> +	}
>> +
>> +	return rc;
>> +}
>> +
>> +static int
>> +xfs_fs_storage_lost(
>> +	struct super_block	*sb,
>> +	loff_t			offset,
> 
> offset into which device?  XFS supports three...
> 
> I'm also a little surprised you don't pass in a length.
> 
> I guess that means this function will get called repeatedly for every
> byte in the poisoned range?

The memory-failure will triggered on one PFN each time, so its length 
could be one PAGE_SIZE.  But I think you are right, it's better to tell 
filesystem how much range is effected and need to be fixed.  I didn't 
know but I think there may be some other cases besides memory-failure. 
So the length is necessary.

> 
>> +	void			*priv)
>> +{
>> +	struct xfs_mount	*mp = XFS_M(sb);
>> +	struct xfs_trans	*tp = NULL;
>> +	struct xfs_btree_cur	*cur = NULL;
>> +	struct xfs_rmap_irec	rmap_low, rmap_high;
>> +	struct xfs_buf		*agf_bp = NULL;
>> +	xfs_fsblock_t		fsbno = XFS_B_TO_FSB(mp, offset);
>> +	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
>> +	xfs_agblock_t		agbno = XFS_FSB_TO_AGBNO(mp, fsbno);
>> +	int			error = 0;
>> +
>> +	error = xfs_trans_alloc_empty(mp, &tp);
>> +	if (error)
>> +		return error;
>> +
>> +	error = xfs_alloc_read_agf(mp, tp, agno, 0, &agf_bp);
>> +	if (error)
>> +		return error;
>> +
>> +	cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, agno);
> 
> ...and this is definitely the wrong call sequence if the malfunctioning
> device is the realtime device.  If a dax rt device dies, you'll be
> shooting down files on the data device, which will cause all sorts of
> problems.

I didn't notice that.  Let me think about it.
> 
> Question: Should all this poison recovery stuff go into a new file?
> xfs_poison.c?  There's already a lot of code in xfs_super.c.

Yes, it's a bit too much.  I'll move them into a new file.


--
Thanks,
Ruan Shiyang.
> 
> --D
> 
>> +
>> +	/* Construct a range for rmap query */
>> +	memset(&rmap_low, 0, sizeof(rmap_low));
>> +	memset(&rmap_high, 0xFF, sizeof(rmap_high));
>> +	rmap_low.rm_startblock = rmap_high.rm_startblock = agbno;
>> +
>> +	error = xfs_rmap_query_range(cur, &rmap_low, &rmap_high,
>> +				     xfs_storage_lost_helper, priv);
>> +	if (error == -ECANCELED)
>> +		error = 0;
>> +
>> +	xfs_btree_del_cursor(cur, error);
>> +	xfs_trans_brelse(tp, agf_bp);
>> +	return error;
>> +}
>> +
>>   static const struct super_operations xfs_super_operations = {
>>   	.alloc_inode		= xfs_fs_alloc_inode,
>>   	.destroy_inode		= xfs_fs_destroy_inode,
>> @@ -1117,6 +1196,7 @@ static const struct super_operations xfs_super_operations = {
>>   	.show_options		= xfs_fs_show_options,
>>   	.nr_cached_objects	= xfs_fs_nr_cached_objects,
>>   	.free_cached_objects	= xfs_fs_free_cached_objects,
>> +	.storage_lost		= xfs_fs_storage_lost,
>>   };
>>   
>>   static int
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index e019ea2f1347..bd90485cfdc9 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1951,6 +1951,7 @@ struct super_operations {
>>   				  struct shrink_control *);
>>   	long (*free_cached_objects)(struct super_block *,
>>   				    struct shrink_control *);
>> +	int (*storage_lost)(struct super_block *sb, loff_t offset, void *priv);
>>   };
>>   
>>   /*
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 1983e08f5906..3f0c36e1bf3d 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3002,6 +3002,12 @@ extern void shake_page(struct page *p, int access);
>>   extern atomic_long_t num_poisoned_pages __read_mostly;
>>   extern int soft_offline_page(unsigned long pfn, int flags);
>>   
>> +struct mf_recover_controller {
>> +	int (*recover_fn)(unsigned long pfn, int flags,
>> +		struct address_space *mapping, pgoff_t index);
>> +	unsigned long pfn;
>> +	int flags;
>> +};
>>   
>>   /*
>>    * Error handlers for various types of pages.
>> -- 
>> 2.28.0
>>
>>
>>
> 
> 



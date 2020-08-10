Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3AA24032D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 10:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgHJIH2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 04:07:28 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:54095 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725857AbgHJIH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 04:07:28 -0400
X-IronPort-AV: E=Sophos;i="5.75,456,1589212800"; 
   d="scan'208";a="97927301"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 10 Aug 2020 16:07:18 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 566BF4CE38A1;
        Mon, 10 Aug 2020 16:07:18 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 10 Aug
 2020 16:07:21 +0800
Subject: Re: [RFC PATCH 1/8] fs: introduce get_shared_files() for dax&reflink
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>,
        <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
References: <20200807131336.318774-1-ruansy.fnst@cn.fujitsu.com>
 <20200807131336.318774-2-ruansy.fnst@cn.fujitsu.com>
 <20200807161526.GD6090@magnolia>
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <5883fb44-4fdb-1068-b8fd-4ceab391c2a6@cn.fujitsu.com>
Date:   Mon, 10 Aug 2020 16:07:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807161526.GD6090@magnolia>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 566BF4CE38A1.AFADE
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/8/8 上午12:15, Darrick J. Wong wrote:
> On Fri, Aug 07, 2020 at 09:13:29PM +0800, Shiyang Ruan wrote:
>> Under the mode of both dax and reflink on, one page may be shared by
>> multiple files and offsets.  In order to track them in memory-failure or
>> other cases, we introduce this function by finding out who is sharing
>> this block(the page) in a filesystem.  It returns a list that contains
>> all the owners, and the offset in each owner.
>>
>> For XFS, rmapbt is used to find out the owners of one block.  So, it
>> should be turned on when we want to use dax&reflink feature together.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
>> ---
>>   fs/xfs/xfs_super.c  | 67 +++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/dax.h |  7 +++++
>>   include/linux/fs.h  |  2 ++
>>   3 files changed, 76 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
>> index 379cbff438bc..b71392219c91 100644
>> --- a/fs/xfs/xfs_super.c
>> +++ b/fs/xfs/xfs_super.c
>> @@ -35,6 +35,9 @@
>>   #include "xfs_refcount_item.h"
>>   #include "xfs_bmap_item.h"
>>   #include "xfs_reflink.h"
>> +#include "xfs_alloc.h"
>> +#include "xfs_rmap.h"
>> +#include "xfs_rmap_btree.h"
>>   
>>   #include <linux/magic.h>
>>   #include <linux/fs_context.h>
>> @@ -1097,6 +1100,69 @@ xfs_fs_free_cached_objects(
>>   	return xfs_reclaim_inodes_nr(XFS_M(sb), sc->nr_to_scan);
>>   }
>>   
>> +static int _get_shared_files_fn(
> 
> Needs an xfs_ prefix...
> 
>> +	struct xfs_btree_cur	*cur,
>> +	struct xfs_rmap_irec	*rec,
>> +	void			*priv)
>> +{
>> +	struct list_head	*list = priv;
>> +	struct xfs_inode	*ip;
>> +	struct shared_files	*sfp;
>> +
>> +	/* Get files that incore, filter out others that are not in use. */
>> +	xfs_iget(cur->bc_mp, cur->bc_tp, rec->rm_owner, XFS_IGET_INCORE, 0, &ip);
> 
> No error checking at all?
> 
> What if rm_owner refers to metadata?

Yes, we need to check whether the page contains metadata.  I remembered 
that.  I wrote the check code but removed it in this patch, because I 
didn't find a way to associate this block device with the dax page that 
contains metadata.  We can call dax_associate_entry() to create the 
association if the page's owner is a file, but it's not work for 
metadata.  I should have explained here.

> 
>> +	if (ip && !ip->i_vnode.i_mapping)
>> +		return 0;
> 
> When is the xfs_inode released?  We don't iput it here, and there's no
> way for dax_unlock_page (afaict the only consumer) to do it, so we
> leak the reference.

Do you mean xfs_irele() ?  Sorry, I didn't realize that.  All we need is 
get the ->mapping form a given inode number.  So, I think we can call 
xfs_irele() when exiting this function.

> 
>> +
>> +	sfp = kmalloc(sizeof(*sfp), GFP_KERNEL);
> 
> If there are millions of open files reflinked to this range of pmem this
> is going to allocate a /lot/ of memory.
> 
>> +	sfp->mapping = ip->i_vnode.i_mapping;
> 
> sfp->mapping = VFS_I(ip)->i_mapping;
> 
>> +	sfp->index = rec->rm_offset;
>> +	list_add_tail(&sfp->list, list);
> 
> Why do we leave ->cookie uninitialized?  What does it even do?

It's my fault.  ->cookie should have been added in the next patch.  It 
stores each owner's dax entry when calling dax_lock_page() in 
memory-failure.

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int
>> +xfs_fs_get_shared_files(
>> +	struct super_block	*sb,
>> +	pgoff_t			offset,
> 
> Which device does this offset refer to?  XFS supports multiple storage
> devices.
> 
> Also, uh, is this really a pgoff_t?  If yes, you can't use it with
> XFS_B_TO_FSB below without first converting it to a loff_t.

The offset here is assigned as iomap->addr, which is obtained from 
iomap_begin().  So that we can easily looking up for the owners of this 
offset.

I don't quite understand what you said about supporting multiple storage 
devices.  What are these devices?  Do you mean NVDIMM, HDD, SSD and others?

> 
>> +	struct list_head	*list)
>> +{
>> +	struct xfs_mount	*mp = XFS_M(sb);
>> +	struct xfs_trans	*tp = NULL;
>> +	struct xfs_btree_cur	*cur = NULL;
>> +	struct xfs_rmap_irec	rmap_low = { 0 }, rmap_high = { 0 };
> 
> No need to memset(0) rmap_low later, or zero rmap_high just to memset it
> later.
> 
>> +	struct xfs_buf		*agf_bp = NULL;
>> +	xfs_agblock_t		bno = XFS_B_TO_FSB(mp, offset);
> 
> "FSB" refers to xfs_fsblock_t.  You just ripped the upper 32 bits off
> the fsblock number.

I think I misused these types.  Sorry for that.
> 
>> +	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, bno);
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
>> +
>> +	memset(&cur->bc_rec, 0, sizeof(cur->bc_rec));
> 
> Not necessary, bc_rec is zero in a freshly created cursor.
> 
>> +	/* Construct the range for one rmap search */
>> +	memset(&rmap_low, 0, sizeof(rmap_low));
>> +	memset(&rmap_high, 0xFF, sizeof(rmap_high));
>> +	rmap_low.rm_startblock = rmap_high.rm_startblock = bno;
>> +
>> +	error = xfs_rmap_query_range(cur, &rmap_low, &rmap_high,
>> +				     _get_shared_files_fn, list);
>> +	if (error == -ECANCELED)
>> +		error = 0;
>> +
>> +	xfs_btree_del_cursor(cur, error);
>> +	xfs_trans_brelse(tp, agf_bp);
>> +	return error;
>> +}
> 
> Looking at this, I don't think this is the right way to approach memory
> poisoning.  Rather than allocating a (potentially huge) linked list and
> passing it to the memory poison code to unmap pages, kill processes, and
> free the list, I think:
> 
> 1) "->get_shared_files" should be more targetted.  Call it ->storage_lost
> or something, so that it only has one purpose, which is to react to
> asynchronous notifications that storage has been lost.

Yes, it's better.  I only considered file tracking.
> 
> 2) The inner _get_shared_files_fn should directly call back into the
> memory manager to remove a poisoned page from the mapping and signal
> whatever process might have it mapped.

For the error handling part, it's really reasonable.  But we have to 
call dax_lock_page() at the beginning of memory-failure, which also need 
to iterate all the owners in order to lock their dax entries.  I think 
it not supposed to call the lock in each iteration instead of at the 
beginning.

> 
> That way, _get_shared_files_fn can look in the xfs buffer cache to see
> if we have a copy in DRAM, and immediately write it back to pmem.

I didn't think of fixing the storage device.  Will take it into 
consideration.

> 
> Hmm and now that you've gotten me rambling about hwpoison, I wonder what
> happens if dram backing part of the xfs buffer cache goes bad...

Yes, so many possible situations to consider.  For the current stage, 
just shutdown the filesystem if memory failures on metadata, and kill 
user processes if failures on normal files.  Is that OK?


Anyway, thanks for reviewing.

--
Thanks,
Ruan Shiyang.

> 
> --D
> 
>> +
>>   static const struct super_operations xfs_super_operations = {
>>   	.alloc_inode		= xfs_fs_alloc_inode,
>>   	.destroy_inode		= xfs_fs_destroy_inode,
>> @@ -1110,6 +1176,7 @@ static const struct super_operations xfs_super_operations = {
>>   	.show_options		= xfs_fs_show_options,
>>   	.nr_cached_objects	= xfs_fs_nr_cached_objects,
>>   	.free_cached_objects	= xfs_fs_free_cached_objects,
>> +	.get_shared_files	= xfs_fs_get_shared_files,
>>   };
>>   
>>   static int
>> diff --git a/include/linux/dax.h b/include/linux/dax.h
>> index 6904d4e0b2e0..0a85e321d6b4 100644
>> --- a/include/linux/dax.h
>> +++ b/include/linux/dax.h
>> @@ -40,6 +40,13 @@ struct dax_operations {
>>   
>>   extern struct attribute_group dax_attribute_group;
>>   
>> +struct shared_files {
>> +	struct list_head	list;
>> +	struct address_space	*mapping;
>> +	pgoff_t			index;
>> +	dax_entry_t		cookie;
>> +};
>> +
>>   #if IS_ENABLED(CONFIG_DAX)
>>   struct dax_device *dax_get_by_host(const char *host);
>>   struct dax_device *alloc_dax(void *private, const char *host,
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index f5abba86107d..81de3d2739b9 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1977,6 +1977,8 @@ struct super_operations {
>>   				  struct shrink_control *);
>>   	long (*free_cached_objects)(struct super_block *,
>>   				    struct shrink_control *);
>> +	int (*get_shared_files)(struct super_block *sb, pgoff_t offset,
>> +				struct list_head *list);
>>   };
>>   
>>   /*
>> -- 
>> 2.27.0
>>
>>
>>
> 
> 



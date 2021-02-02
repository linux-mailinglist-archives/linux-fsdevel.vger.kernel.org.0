Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C5F30BEB3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 13:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhBBMuA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 07:50:00 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:58826 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231879AbhBBMtz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:49:55 -0500
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="104103944"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 02 Feb 2021 20:48:06 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id C3DA44CE6D68;
        Tue,  2 Feb 2021 20:48:02 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Feb
 2021 20:48:03 +0800
Subject: Re: [PATCH RESEND v2 09/10] xfs: Implement ->corrupted_range() for
 XFS
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dm-devel@redhat.com>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <agk@redhat.com>,
        <snitzer@redhat.com>, <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>,
        <y-goto@fujitsu.com>
References: <20210129062757.1594130-1-ruansy.fnst@cn.fujitsu.com>
 <20210129062757.1594130-10-ruansy.fnst@cn.fujitsu.com>
 <20210202024147.GI7193@magnolia>
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <d9c989bc-be7d-4771-4cd8-2e4653648b4d@cn.fujitsu.com>
Date:   Tue, 2 Feb 2021 20:48:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210202024147.GI7193@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: C3DA44CE6D68.AE3BA
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/2/2 上午10:41, Darrick J. Wong wrote:
> On Fri, Jan 29, 2021 at 02:27:56PM +0800, Shiyang Ruan wrote:
>> This function is used to handle errors which may cause data lost in
>> filesystem.  Such as memory failure in fsdax mode.
>>
>> In XFS, it requires "rmapbt" feature in order to query for files or
>> metadata which associated to the corrupted data.  Then we could call fs
>> recover functions to try to repair the corrupted data.(did not
>> implemented in this patchset)
> 
> I would suggest:
> "If the rmap feature of XFS enabled, we can query it to find files and
> metadata which are associated with the corrupt data.  For now all we do
> is kill processes with that file mapped into their address spaces, but
> future patches could actually do something about corrupt metadata."
> 

Yes, this is better.

>> After that, the memory failure also needs to notify the processes who
>> are using those files.
>>
>> Only support data device.  Realtime device is not supported for now.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
>> ---
>>   fs/xfs/xfs_fsops.c |   5 +++
>>   fs/xfs/xfs_mount.h |   1 +
>>   fs/xfs/xfs_super.c | 109 +++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 115 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
>> index 959ce91a3755..f03901a5c673 100644
>> --- a/fs/xfs/xfs_fsops.c
>> +++ b/fs/xfs/xfs_fsops.c
>> @@ -498,6 +498,11 @@ xfs_do_force_shutdown(
>>   "Corruption of in-memory data detected.  Shutting down filesystem");
>>   		if (XFS_ERRLEVEL_HIGH <= xfs_error_level)
>>   			xfs_stack_trace();
>> +	} else if (flags & SHUTDOWN_CORRUPT_META) {
>> +		xfs_alert_tag(mp, XFS_PTAG_SHUTDOWN_CORRUPT,
>> +"Corruption of on-disk metadata detected.  Shutting down filesystem");
>> +		if (XFS_ERRLEVEL_HIGH <= xfs_error_level)
>> +			xfs_stack_trace();
>>   	} else if (logerror) {
>>   		xfs_alert_tag(mp, XFS_PTAG_SHUTDOWN_LOGERROR,
>>   			"Log I/O Error Detected. Shutting down filesystem");
>> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
>> index dfa429b77ee2..8f0df67ffcc1 100644
>> --- a/fs/xfs/xfs_mount.h
>> +++ b/fs/xfs/xfs_mount.h
>> @@ -274,6 +274,7 @@ void xfs_do_force_shutdown(struct xfs_mount *mp, int flags, char *fname,
>>   #define SHUTDOWN_LOG_IO_ERROR	0x0002	/* write attempt to the log failed */
>>   #define SHUTDOWN_FORCE_UMOUNT	0x0004	/* shutdown from a forced unmount */
>>   #define SHUTDOWN_CORRUPT_INCORE	0x0008	/* corrupt in-memory data structures */
>> +#define SHUTDOWN_CORRUPT_META	0x0010  /* corrupt metadata on device */
>>   
>>   /*
>>    * Flags for xfs_mountfs
>> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
>> index 813be879a5e5..93093fe0ee8a 100644
>> --- a/fs/xfs/xfs_super.c
>> +++ b/fs/xfs/xfs_super.c
>> @@ -35,6 +35,11 @@
>>   #include "xfs_refcount_item.h"
>>   #include "xfs_bmap_item.h"
>>   #include "xfs_reflink.h"
>> +#include "xfs_alloc.h"
>> +#include "xfs_rmap.h"
>> +#include "xfs_rmap_btree.h"
>> +#include "xfs_rtalloc.h"
>> +#include "xfs_bit.h"
>>   
>>   #include <linux/magic.h>
>>   #include <linux/fs_context.h>
>> @@ -1105,6 +1110,109 @@ xfs_fs_free_cached_objects(
>>   	return xfs_reclaim_inodes_nr(XFS_M(sb), sc->nr_to_scan);
>>   }
>>   
>> +static int
>> +xfs_corrupt_helper(
>> +	struct xfs_btree_cur		*cur,
>> +	struct xfs_rmap_irec		*rec,
>> +	void				*data)
>> +{
>> +	struct xfs_inode		*ip;
>> +	struct address_space		*mapping;
>> +	int				rc = 0;
>> +	int				*flags = data;
>> +
>> +	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
>> +	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
>> +		// TODO check and try to fix metadata
>> +		rc = -EFSCORRUPTED;
> 
> The xfs_force_shutdown() call should go here, since SHUTDOWN_CORRUPT_META
> is specific to this case.

OK.
> 
> I guess one could also dig through the buffer cache and delwri_submit
> those buffers or something.
> 
>> +	} else {
>> +		/*
>> +		 * Get files that incore, filter out others that are not in use.
>> +		 */
>> +		rc = xfs_iget(cur->bc_mp, cur->bc_tp, rec->rm_owner,
>> +			      XFS_IGET_INCORE, 0, &ip);
>> +		if (rc || !ip)
>> +			return rc;
>> +		if (!VFS_I(ip)->i_mapping)
>> +			goto out;
>> +
>> +		mapping = VFS_I(ip)->i_mapping;
>> +		if (IS_DAX(VFS_I(ip)))
>> +			rc = mf_dax_mapping_kill_procs(mapping, rec->rm_offset,
>> +						       *flags);
>> +		else
>> +			mapping_set_error(mapping, -EIO);
>> +
>> +		// TODO try to fix data
> 
> What could we do to fix the data?  If we're not in S_DAX mode and
> there's actually pagecache mapped in, does that imply that we could
> mark it dirty and kick off dirty pagecache writeback?

But in this case, the dax page is already broken, it seems that page 
cache should not be written back to the origin dax page.  I think 
another dax page need to be allocate for the writeback.

> 
>> +out:
>> +		xfs_irele(ip);
>> +	}
>> +
>> +	return rc;
>> +}
>> +
>> +static int
>> +xfs_fs_corrupted_range(
>> +	struct super_block	*sb,
>> +	struct block_device	*bdev,
>> +	loff_t			offset,
>> +	size_t			len,
>> +	void			*data)
>> +{
>> +	struct xfs_mount	*mp = XFS_M(sb);
>> +	struct xfs_trans	*tp = NULL;
>> +	struct xfs_btree_cur	*cur = NULL;
>> +	struct xfs_rmap_irec	rmap_low, rmap_high;
>> +	struct xfs_buf		*agf_bp = NULL;
>> +	xfs_fsblock_t		fsbno = XFS_B_TO_FSB(mp, offset);
>> +	xfs_filblks_t		bcnt = XFS_B_TO_FSB(mp, len);
>> +	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
>> +	xfs_agblock_t		agbno = XFS_FSB_TO_AGBNO(mp, fsbno);
>> +	int			error = 0;
>> +
>> +	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_bdev == bdev) {
>> +		xfs_warn(mp, "corrupted_range support not available for realtime device!");
>> +		return 0;
>> +	}
>> +	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_bdev == bdev &&
>> +	    mp->m_logdev_targp != mp->m_ddev_targp) {
>> +		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
>> +		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_META);
> 
> Longer term question for the rest of the xfs community: Can we do better
> than this?  If the ail has checkpointed past this part of the log then
> we could just write zeroes into dead area, right?
> 
> Also, if one of the log buffers points to a dead log area and isn't the
> one that's currently being written into, can we just submit_bio it to
> rewrite the lost part of the log??

Yes, We should also fix the log rather than shutdown it directly.  I 
will take that into consideration in future patches.

> 
>> +		return 0;
>> +	}
>> +
>> +	if (!xfs_sb_version_hasrmapbt(&mp->m_sb)) {
>> +		xfs_warn(mp, "corrupted_range needs rmapbt enabled!");
>> +		return 0;
>> +	}
>> +
>> +	error = xfs_trans_alloc_empty(mp, &tp);
>> +	if (error)
>> +		return error;
>> +
>> +	error = xfs_alloc_read_agf(mp, tp, agno, 0, &agf_bp);
>> +	if (error)
>> +		goto out_cancel_tp;
>> +
>> +	cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, agno);
>> +
>> +	/* Construct a range for rmap query */
>> +	memset(&rmap_low, 0, sizeof(rmap_low));
>> +	memset(&rmap_high, 0xFF, sizeof(rmap_high));
>> +	rmap_low.rm_startblock = rmap_high.rm_startblock = agbno;
>> +	rmap_low.rm_blockcount = rmap_high.rm_blockcount = bcnt;
>> +
>> +	error = xfs_rmap_query_range(cur, &rmap_low, &rmap_high, xfs_corrupt_helper, data);
> 
> Long line here...
> 
>> +	if (error == -EFSCORRUPTED)
>> +		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_META);
> 
> This should go in xfs_corrupt_helper as I mentioned above.

OK.


--
Thanks,
Ruan Shiyang.
> 
> --D
> 
>> +
>> +	xfs_btree_del_cursor(cur, error);
>> +	xfs_trans_brelse(tp, agf_bp);
>> +out_cancel_tp:
>> +	xfs_trans_cancel(tp);
>> +	return error;
>> +}
>> +
>>   static const struct super_operations xfs_super_operations = {
>>   	.alloc_inode		= xfs_fs_alloc_inode,
>>   	.destroy_inode		= xfs_fs_destroy_inode,
>> @@ -1118,6 +1226,7 @@ static const struct super_operations xfs_super_operations = {
>>   	.show_options		= xfs_fs_show_options,
>>   	.nr_cached_objects	= xfs_fs_nr_cached_objects,
>>   	.free_cached_objects	= xfs_fs_free_cached_objects,
>> +	.corrupted_range	= xfs_fs_corrupted_range,
>>   };
>>   
>>   static int
>> -- 
>> 2.30.0
>>
>>
>>
> 
> 



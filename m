Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390782DDCF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 03:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbgLRCev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 21:34:51 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:62003 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727148AbgLRCev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 21:34:51 -0500
X-IronPort-AV: E=Sophos;i="5.78,428,1599494400"; 
   d="scan'208";a="102693910"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Dec 2020 10:33:50 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id ED9DA4CE601B;
        Fri, 18 Dec 2020 10:33:47 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Dec
 2020 10:33:47 +0800
Subject: Re: [RFC PATCH v3 9/9] xfs: Implement ->corrupted_range() for XFS
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <dan.j.williams@intel.com>, <david@fromorbit.com>, <hch@lst.de>,
        <song@kernel.org>, <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>,
        <y-goto@fujitsu.com>
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
 <20201215121414.253660-10-ruansy.fnst@cn.fujitsu.com>
 <20201215204032.GA6918@magnolia>
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <c216d87b-c1ab-48f5-e247-edbf943455c0@cn.fujitsu.com>
Date:   Fri, 18 Dec 2020 10:31:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201215204032.GA6918@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: ED9DA4CE601B.A0131
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/12/16 上午4:40, Darrick J. Wong wrote:
> On Tue, Dec 15, 2020 at 08:14:14PM +0800, Shiyang Ruan wrote:
>> This function is used to handle errors which may cause data lost in
>> filesystem.  Such as memory failure in fsdax mode.
>>
>> In XFS, it requires "rmapbt" feature in order to query for files or
>> metadata which associated to the corrupted data.  Then we could call fs
>> recover functions to try to repair the corrupted data.(did not
>> implemented in this patchset)
>>
>> After that, the memory failure also needs to notify the processes who
>> are using those files.
>>
>> Only support data device.  Realtime device is not supported for now.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
>> ---
>>   fs/xfs/xfs_fsops.c | 10 +++++
>>   fs/xfs/xfs_mount.h |  2 +
>>   fs/xfs/xfs_super.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 105 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
>> index ef1d5bb88b93..0ec1b44bfe88 100644
>> --- a/fs/xfs/xfs_fsops.c
>> +++ b/fs/xfs/xfs_fsops.c
>> @@ -501,6 +501,16 @@ xfs_do_force_shutdown(
>>   "Corruption of in-memory data detected.  Shutting down filesystem");
>>   		if (XFS_ERRLEVEL_HIGH <= xfs_error_level)
>>   			xfs_stack_trace();
>> +	} else if (flags & SHUTDOWN_CORRUPT_META) {
>> +		xfs_alert_tag(mp, XFS_PTAG_SHUTDOWN_CORRUPT,
>> +"Corruption of on-disk metadata detected.  Shutting down filesystem");
>> +		if (XFS_ERRLEVEL_HIGH <= xfs_error_level)
>> +			xfs_stack_trace();
>> +	} else if (flags & SHUTDOWN_CORRUPT_DATA) {
>> +		xfs_alert_tag(mp, XFS_PTAG_SHUTDOWN_CORRUPT,
>> +"Corruption of on-disk file data detected.  Shutting down filesystem");
>> +		if (XFS_ERRLEVEL_HIGH <= xfs_error_level)
>> +			xfs_stack_trace();
>>   	} else if (logerror) {
>>   		xfs_alert_tag(mp, XFS_PTAG_SHUTDOWN_LOGERROR,
>>   			"Log I/O Error Detected. Shutting down filesystem");
>> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
>> index dfa429b77ee2..e36c07553486 100644
>> --- a/fs/xfs/xfs_mount.h
>> +++ b/fs/xfs/xfs_mount.h
>> @@ -274,6 +274,8 @@ void xfs_do_force_shutdown(struct xfs_mount *mp, int flags, char *fname,
>>   #define SHUTDOWN_LOG_IO_ERROR	0x0002	/* write attempt to the log failed */
>>   #define SHUTDOWN_FORCE_UMOUNT	0x0004	/* shutdown from a forced unmount */
>>   #define SHUTDOWN_CORRUPT_INCORE	0x0008	/* corrupt in-memory data structures */
>> +#define SHUTDOWN_CORRUPT_META	0x0010  /* corrupt metadata on device */
>> +#define SHUTDOWN_CORRUPT_DATA	0x0020  /* corrupt file data on device */
> 
> This symbol isn't used anywhere.  I don't know why we'd shut down the fs
> for data loss, as we don't do that anywhere else in xfs.

I prepared this flag for the later use if possible.  But since it seems 
unnecessary, I will remove it in the next version.

> 
>>   
>>   /*
>>    * Flags for xfs_mountfs
>> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
>> index e3e229e52512..30202de7e89d 100644
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
>> @@ -1103,6 +1108,93 @@ xfs_fs_free_cached_objects(
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
>> +	int				rc = 0;
> 
> Note: we usually use the name "error", not "rc".

OK.

> 
>> +	int				*flags = data;
>> +
>> +	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner)) {
> 
> There are a few more things to check here to detect if metadata has been
> lost.  The first is that any loss in the extended attribute information
> is considered filesystem metadata; and the second is that loss of an
> extent btree block is also metadata.
> 
> IOWs, this check should be:
> 
> 	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
> 	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
> 		// TODO check and try to fix metadata
> 		return -EFSCORRUPTED;
> 	}

Thanks for pointing out.

> 
>> +		// TODO check and try to fix metadata
>> +		rc = -EFSCORRUPTED;
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
>> +		if (IS_DAX(VFS_I(ip)))
>> +			rc = mf_dax_mapping_kill_procs(VFS_I(ip)->i_mapping,
>> +						       rec->rm_offset, *flags);
> 
> If the file isn't S_DAX, should we call mapping_set_error here so
> that the next fsync() will also return EIO?

Nice idea.  I will try.

> 
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
>> +	xfs_filblks_t		bc = XFS_B_TO_FSB(mp, len);
>> +	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
>> +	xfs_agblock_t		agbno = XFS_FSB_TO_AGBNO(mp, fsbno);
>> +	int			rc = 0;
>> +
>> +	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_bdev == bdev) {
>> +		xfs_warn(mp, "storage lost support not available for realtime device!");
>> +		return 0;
>> +	}
> 
> This ought to kill the fs when an external log device is configured:
> 
> 	if (mp->m_logdev_targp &&
> 	    mp->m_logdev_targp != mp->m_ddev_targp &&
> 	    mp->m_logdev_targp->bt_bdev == bdev) {
> 		xfs_error(mp, "ondisk log corrupt, shutting down fs!");
> 		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_META);
> 		return 0;
> 	}
> 
> Then, we need to check explicitly for rmap support:
> 
> 	if (!xfs_sb_version_hasrmapbt(&mp->m_sb))
> 		return 0;
> 
> so that we screen out filesystems that don't have rmap enabled.

Ah...  I was too negligent to think of this.  That's very thoughtful of 
you.  Thanks.

> 
>> +	rc = xfs_trans_alloc_empty(mp, &tp);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = xfs_alloc_read_agf(mp, tp, agno, 0, &agf_bp);
>> +	if (rc)
>> +		return rc;
>> +
>> +	cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, agno);
>> +
>> +	/* Construct a range for rmap query */
>> +	memset(&rmap_low, 0, sizeof(rmap_low));
>> +	memset(&rmap_high, 0xFF, sizeof(rmap_high));
>> +	rmap_low.rm_startblock = rmap_high.rm_startblock = agbno;
>> +	rmap_low.rm_blockcount = rmap_high.rm_blockcount = bc;
>> +
>> +	rc = xfs_rmap_query_range(cur, &rmap_low, &rmap_high, xfs_corrupt_helper, data);
>> +	if (rc == -ECANCELED)
>> +		rc = 0;
> 
> I don't think anything returns ECANCELED here...

Yes.  Will remove it.


--
Thanks,
Ruan Shiyang.
> 
> --D
> 
>> +	if (rc == -EFSCORRUPTED)
>> +		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_META);
>> +
>> +	xfs_btree_del_cursor(cur, rc);
>> +	xfs_trans_brelse(tp, agf_bp);
>> +	return rc;
>> +}
>> +
>>   static const struct super_operations xfs_super_operations = {
>>   	.alloc_inode		= xfs_fs_alloc_inode,
>>   	.destroy_inode		= xfs_fs_destroy_inode,
>> @@ -1116,6 +1208,7 @@ static const struct super_operations xfs_super_operations = {
>>   	.show_options		= xfs_fs_show_options,
>>   	.nr_cached_objects	= xfs_fs_nr_cached_objects,
>>   	.free_cached_objects	= xfs_fs_free_cached_objects,
>> +	.corrupted_range	= xfs_fs_corrupted_range,
>>   };
>>   
>>   static int
>> -- 
>> 2.29.2
>>
>>
>>
> 
> 



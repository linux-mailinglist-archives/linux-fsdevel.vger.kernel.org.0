Return-Path: <linux-fsdevel+bounces-37780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9719F7548
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 08:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F95016CBD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 07:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87D9216E1F;
	Thu, 19 Dec 2024 07:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WKqxdhg3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3A97082A;
	Thu, 19 Dec 2024 07:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734592830; cv=none; b=r67DjMsYmZSbgPvLicCawlkPNph8kPBtH7Ub06HOsQuoSVzvjCfYV/g9PR5zarH5HthRPuqV9Uv85zcxr4LnkKcvwGcGhIdkez8siehJpHCRY4jdFnDGGGttwhncfLemEgWfQ7YFl5zc1OILx28sDwRpJqbbHW4J4pRTnHedo54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734592830; c=relaxed/simple;
	bh=K7+6eIBsM9cT2n1sW+PGgL7yKTLsy6qCreKTtcS4IbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqTouwcODbdQ8aPFDL98Xr6//GL8Kc6RkxDnw4oWVzjE7Vy91OBi4Bq48SI6LafJWhzYCr5UJPr+UFKlfzr8eE2Wuv99AItD9zanIc24O1vpr3DBw6rnjIZwg9q3TU/x14f4cyxeBhFejy8yHBoiSBYcpyZW6T3AEeXtus1TyR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WKqxdhg3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ3qrN6025027;
	Thu, 19 Dec 2024 07:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Fq4OC/
	zST+6kr7yzWYiZgCb0zkX2J8C06oDPUnCpZ2w=; b=WKqxdhg37XTroB2re4D+CO
	22u3UYtezmzW4DSi8nHEFipJ4KWO61qfWoQhl8YPN6MuJ191BaN/1/gSU/KSdHWa
	1y4gpbWw0hkoQna45ZEIKoCJ+iJdYfWhQj2S12k+UfSwxn1jy0Y5fDlVDQqBCfat
	iJBw6meRa/1d6qhYQWZilI4sIjPZpU0n/LWCLr3lFCAtguMfO5BX6bN15PYDZ8fo
	8y5gUSrM4C/UOUGw2eZpGxjXkp49piXybRg3jEE31hX3jQv2xZVbJ8SeHCG7WudZ
	mGAFlgv8Od+b5p5k9GuZTUx8OY3Ww/cbMA7RxKoQCHIw42tD+5+Mh1Co1vttwdLQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mbyhrp1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 07:20:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ7I2GN014320;
	Thu, 19 Dec 2024 07:20:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hmqyc53w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 07:20:05 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BJ7K3vV18547088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 07:20:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C1482004B;
	Thu, 19 Dec 2024 07:20:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 471AC20040;
	Thu, 19 Dec 2024 07:20:01 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.124.218.178])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 19 Dec 2024 07:20:00 +0000 (GMT)
Date: Thu, 19 Dec 2024 12:49:58 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 01/10] ext4: remove writable userspace mappings before
 truncating page cache
Message-ID: <Z2PJHssCBqVDDU7w@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-2-yi.zhang@huaweicloud.com>
 <Z2KcZt91otMCYqvi@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <a2be273d-f7d2-48e4-84c8-27066d8136b1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2be273d-f7d2-48e4-84c8-27066d8136b1@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: l0LfRjHBP4QSjYz9MwUR-KLlLCyDMFp-
X-Proofpoint-GUID: l0LfRjHBP4QSjYz9MwUR-KLlLCyDMFp-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190054

On Wed, Dec 18, 2024 at 09:02:18PM +0800, Zhang Yi wrote:
> On 2024/12/18 17:56, Ojaswin Mujoo wrote:
> > On Mon, Dec 16, 2024 at 09:39:06AM +0800, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> When zeroing a range of folios on the filesystem which block size is
> >> less than the page size, the file's mapped blocks within one page will
> >> be marked as unwritten, we should remove writable userspace mappings to
> >> ensure that ext4_page_mkwrite() can be called during subsequent write
> >> access to these partial folios. Otherwise, data written by subsequent
> >> mmap writes may not be saved to disk.
> >>
> >>  $mkfs.ext4 -b 1024 /dev/vdb
> >>  $mount /dev/vdb /mnt
> >>  $xfs_io -t -f -c "pwrite -S 0x58 0 4096" -c "mmap -rw 0 4096" \
> >>                -c "mwrite -S 0x5a 2048 2048" -c "fzero 2048 2048" \
> >>                -c "mwrite -S 0x59 2048 2048" -c "close" /mnt/foo
> >>
> >>  $od -Ax -t x1z /mnt/foo
> >>  000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
> >>  *
> >>  000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
> >>  *
> >>  001000
> >>
> >>  $umount /mnt && mount /dev/vdb /mnt
> >>  $od -Ax -t x1z /mnt/foo
> >>  000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
> >>  *
> >>  000800 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>  *
> >>  001000
> >>
> >> Fix this by introducing ext4_truncate_page_cache_block_range() to remove
> >> writable userspace mappings when truncating a partial folio range.
> >> Additionally, move the journal data mode-specific handlers and
> >> truncate_pagecache_range() into this function, allowing it to serve as a
> >> common helper that correctly manages the page cache in preparation for
> >> block range manipulations.
> > 
> > Hi Zhang,
> > 
> > Thanks for the fix, just to confirm my understanding, the issue arises
> > because of the following flow:
> > 
> > 1. page_mkwrite() makes folio dirty when we write to the mmap'd region
> > 
> > 2. ext4_zero_range (2kb to 4kb)
> >     truncate_pagecache_range
> >       truncate_inode_pages_range
> >         truncate_inode_partial_folio
> >           folio_zero_range (2kb to 4kb)
> >             folio_invalidate
> >               ext4_invalidate_folio
> >                 block_invalidate_folio -> clear the bh dirty bit
> > 
> > 3. mwrite (2kb to 4kb): Again we write in pagecache but the bh is not
> >    dirty hence after a remount the data is not seen on disk
> > 
> > Also, we won't see this issue if we are zeroing a page aligned range
> > since we end up unmapping the pages from the proccess address space in 
> > that case. Correct?
> 
> Thank you for review! Yes, it's correct.
> 
> > 
> > I have also tested the patch in PowerPC with 64k pagesize and 4k blocks
> > size and can confirm that it fixes the data loss issue. That being said,
> > I have a few minor comments on the patch below:
> > 
> 
> Thank you for the test.
> 
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >> ---
> >>  fs/ext4/ext4.h    |  2 ++
> >>  fs/ext4/extents.c | 19 ++++-----------
> >>  fs/ext4/inode.c   | 62 +++++++++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 69 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> >> index 74f2071189b2..8843929b46ce 100644
> >> --- a/fs/ext4/ext4.h
> >> +++ b/fs/ext4/ext4.h
> >> @@ -3016,6 +3016,8 @@ extern int ext4_inode_attach_jinode(struct inode *inode);
> >>  extern int ext4_can_truncate(struct inode *inode);
> >>  extern int ext4_truncate(struct inode *);
> >>  extern int ext4_break_layouts(struct inode *);
> >> +extern int ext4_truncate_page_cache_block_range(struct inode *inode,
> >> +						loff_t start, loff_t end);
> >>  extern int ext4_punch_hole(struct file *file, loff_t offset, loff_t length);
> >>  extern void ext4_set_inode_flags(struct inode *, bool init);
> >>  extern int ext4_alloc_da_blocks(struct inode *inode);
> >> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> >> index a07a98a4b97a..8dc6b4271b15 100644
> >> --- a/fs/ext4/extents.c
> >> +++ b/fs/ext4/extents.c
> >> @@ -4667,22 +4667,13 @@ static long ext4_zero_range(struct file *file, loff_t offset,
> >>  			goto out_mutex;
> >>  		}
> >>  
> >> -		/*
> >> -		 * For journalled data we need to write (and checkpoint) pages
> >> -		 * before discarding page cache to avoid inconsitent data on
> >> -		 * disk in case of crash before zeroing trans is committed.
> >> -		 */
> >> -		if (ext4_should_journal_data(inode)) {
> >> -			ret = filemap_write_and_wait_range(mapping, start,
> >> -							   end - 1);
> >> -			if (ret) {
> >> -				filemap_invalidate_unlock(mapping);
> >> -				goto out_mutex;
> >> -			}
> >> +		/* Now release the pages and zero block aligned part of pages */
> >> +		ret = ext4_truncate_page_cache_block_range(inode, start, end);
> >> +		if (ret) {
> >> +			filemap_invalidate_unlock(mapping);
> >> +			goto out_mutex;
> >>  		}
> >>  
> >> -		/* Now release the pages and zero block aligned part of pages */
> >> -		truncate_pagecache_range(inode, start, end - 1);
> >>  		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
> >>  
> >>  		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
> >> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> >> index 89aade6f45f6..c68a8b841148 100644
> >> --- a/fs/ext4/inode.c
> >> +++ b/fs/ext4/inode.c
> >> @@ -31,6 +31,7 @@
> >>  #include <linux/writeback.h>
> >>  #include <linux/pagevec.h>
> >>  #include <linux/mpage.h>
> >> +#include <linux/rmap.h>
> >>  #include <linux/namei.h>
> >>  #include <linux/uio.h>
> >>  #include <linux/bio.h>
> >> @@ -3902,6 +3903,67 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
> >>  	return ret;
> >>  }
> >>  
> >> +static inline void ext4_truncate_folio(struct inode *inode,
> >> +				       loff_t start, loff_t end)
> >> +{
> >> +	unsigned long blocksize = i_blocksize(inode);
> >> +	struct folio *folio;
> >> +
> >> +	/* Nothing to be done if no complete block needs to be truncated. */
> >> +	if (round_up(start, blocksize) >= round_down(end, blocksize))
> >> +		return;
> >> +
> >> +	folio = filemap_lock_folio(inode->i_mapping, start >> PAGE_SHIFT);
> >> +	if (IS_ERR(folio))
> >> +		return;
> >> +
> >> +	if (folio_mkclean(folio))
> >> +		folio_mark_dirty(folio);
> >> +	folio_unlock(folio);
> >> +	folio_put(folio);
> >> +}
> >> +
> >> +int ext4_truncate_page_cache_block_range(struct inode *inode,
> >> +					 loff_t start, loff_t end)
> >> +{
> >> +	unsigned long blocksize = i_blocksize(inode);
> >> +	int ret;
> >> +
> >> +	/*
> >> +	 * For journalled data we need to write (and checkpoint) pages
> >> +	 * before discarding page cache to avoid inconsitent data on disk
> >> +	 * in case of crash before freeing or unwritten converting trans
> >> +	 * is committed.
> >> +	 */
> >> +	if (ext4_should_journal_data(inode)) {
> >> +		ret = filemap_write_and_wait_range(inode->i_mapping, start,
> >> +						   end - 1);
> >> +		if (ret)
> >> +			return ret;
> >> +		goto truncate_pagecache;
> >> +	}
> >> +
> >> +	/*
> >> +	 * If the block size is less than the page size, the file's mapped
> >> +	 * blocks within one page could be freed or converted to unwritten.
> >> +	 * So it's necessary to remove writable userspace mappings, and then
> >> +	 * ext4_page_mkwrite() can be called during subsequent write access
> >> +	 * to these partial folios.
> >> +	 */
> >> +	if (blocksize < PAGE_SIZE && start < inode->i_size) {
> > 
> > Maybe we should only call ext4_truncate_folio() if the range is not page
> > aligned, rather than calling it everytime for bs < ps?
> 
> I agree with you, so how about below？
> 
> 	if (!IS_ALIGNED(start | end, PAGE_SIZE) &&
> 	    blocksize < PAGE_SIZE && start < inode->i_size && )

This looks good Zhang, with this change and the variable rename, feel free to add

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin
> 
> > 
> >> +		loff_t start_boundary = round_up(start, PAGE_SIZE);
> > 
> > I think page_boundary seems like a more suitable name for the variable.
> 
> Yeah, it looks fine to me.
> 
> Thanks,
> Yi.
> 


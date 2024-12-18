Return-Path: <linux-fsdevel+bounces-37714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB9D9F6238
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 10:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF109170845
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 09:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008D8199EB2;
	Wed, 18 Dec 2024 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aExibpZf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89110199249;
	Wed, 18 Dec 2024 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734515839; cv=none; b=syoT0W9XfnLoN2i6BNqBoVUhahmCJf28vHvIfwCHMl6E5dQ7ET2w6xrh0FW9eHc0dX8XeLa1hASIbUL3M0x9Bxdce6UWri3DDKokO76jiTAtADPzwPCohUt7/mtsAuvEy7mQAzjja2N+JCrFe+hmvjJ+OR+8e8d2+NtReTFmzf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734515839; c=relaxed/simple;
	bh=pGrIfIwIw9QgCOLgvL8MqZpwZyYRFPc9rLJDu1YDRcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwdYwjsWxl56vr3ZDHuUPf6mnpOxVEfwR1QwblAEpkj+wLJ3++1cNsiBKQ+cL2pwwCCZx/68unJG8AZ+52G56qeVhdh+vjbiDFLwYVGN4cibeqEVeJY+EtnL+T4GBmRe9NXYvi1EWV+YDnOBChk99Zdj3tMkpn4Z/fJBnEoc/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aExibpZf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI3qlfH028489;
	Wed, 18 Dec 2024 09:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=1TdArYKj9UOOnov2T5MAWW02/sn1lF
	q4u/OkRtt1YXg=; b=aExibpZf3Kub/U1xWTVVaI0YdKBDGJJc9AkC070U0sccVg
	3EQwSX9e5EkYXaCX9NBSlivUYAwPd3hHWAmTgo9eRpR6lgfeNtXydgHGijA1b79h
	8AvT+c12fflKB+tv0r/i6Dji/E0KGi5Xl8lqp1UewlqyPa+UlGFnhvPQyejjVwSW
	6HZ/zWRhf7h0Nq//4JiwjfTzxI5S8wyfTGszhUXpdU0EOMYie9eU2q2lTHF0/9+h
	b0dzog91mseuYnWOlurSfLh1PbJ7p29mhlg9hF9NXxH59oz084gjW80LTYMJFx+3
	0DiB5k2WnakPfwB8B6WOaie4fYu00o0YLZrDdvZg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kpvgsenu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 09:57:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI9JIZB011267;
	Wed, 18 Dec 2024 09:57:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hpjk70r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 09:57:00 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BI9uwrv34669134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 09:56:58 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B015A2004D;
	Wed, 18 Dec 2024 09:56:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C98022004B;
	Wed, 18 Dec 2024 09:56:56 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 18 Dec 2024 09:56:56 +0000 (GMT)
Date: Wed, 18 Dec 2024 15:26:54 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 01/10] ext4: remove writable userspace mappings before
 truncating page cache
Message-ID: <Z2KcZt91otMCYqvi@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216013915.3392419-2-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: opKHJWySx_z_h4Q6stajvrpU0yvUmDli
X-Proofpoint-ORIG-GUID: opKHJWySx_z_h4Q6stajvrpU0yvUmDli
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180076

On Mon, Dec 16, 2024 at 09:39:06AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When zeroing a range of folios on the filesystem which block size is
> less than the page size, the file's mapped blocks within one page will
> be marked as unwritten, we should remove writable userspace mappings to
> ensure that ext4_page_mkwrite() can be called during subsequent write
> access to these partial folios. Otherwise, data written by subsequent
> mmap writes may not be saved to disk.
> 
>  $mkfs.ext4 -b 1024 /dev/vdb
>  $mount /dev/vdb /mnt
>  $xfs_io -t -f -c "pwrite -S 0x58 0 4096" -c "mmap -rw 0 4096" \
>                -c "mwrite -S 0x5a 2048 2048" -c "fzero 2048 2048" \
>                -c "mwrite -S 0x59 2048 2048" -c "close" /mnt/foo
> 
>  $od -Ax -t x1z /mnt/foo
>  000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
>  *
>  000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
>  *
>  001000
> 
>  $umount /mnt && mount /dev/vdb /mnt
>  $od -Ax -t x1z /mnt/foo
>  000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
>  *
>  000800 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  *
>  001000
> 
> Fix this by introducing ext4_truncate_page_cache_block_range() to remove
> writable userspace mappings when truncating a partial folio range.
> Additionally, move the journal data mode-specific handlers and
> truncate_pagecache_range() into this function, allowing it to serve as a
> common helper that correctly manages the page cache in preparation for
> block range manipulations.

Hi Zhang,

Thanks for the fix, just to confirm my understanding, the issue arises
because of the following flow:

1. page_mkwrite() makes folio dirty when we write to the mmap'd region

2. ext4_zero_range (2kb to 4kb)
    truncate_pagecache_range
      truncate_inode_pages_range
        truncate_inode_partial_folio
          folio_zero_range (2kb to 4kb)
            folio_invalidate
              ext4_invalidate_folio
                block_invalidate_folio -> clear the bh dirty bit

3. mwrite (2kb to 4kb): Again we write in pagecache but the bh is not
   dirty hence after a remount the data is not seen on disk

Also, we won't see this issue if we are zeroing a page aligned range
since we end up unmapping the pages from the proccess address space in 
that case. Correct?

I have also tested the patch in PowerPC with 64k pagesize and 4k blocks
size and can confirm that it fixes the data loss issue. That being said,
I have a few minor comments on the patch below:

> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/ext4.h    |  2 ++
>  fs/ext4/extents.c | 19 ++++-----------
>  fs/ext4/inode.c   | 62 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 74f2071189b2..8843929b46ce 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3016,6 +3016,8 @@ extern int ext4_inode_attach_jinode(struct inode *inode);
>  extern int ext4_can_truncate(struct inode *inode);
>  extern int ext4_truncate(struct inode *);
>  extern int ext4_break_layouts(struct inode *);
> +extern int ext4_truncate_page_cache_block_range(struct inode *inode,
> +						loff_t start, loff_t end);
>  extern int ext4_punch_hole(struct file *file, loff_t offset, loff_t length);
>  extern void ext4_set_inode_flags(struct inode *, bool init);
>  extern int ext4_alloc_da_blocks(struct inode *inode);
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index a07a98a4b97a..8dc6b4271b15 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4667,22 +4667,13 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  			goto out_mutex;
>  		}
>  
> -		/*
> -		 * For journalled data we need to write (and checkpoint) pages
> -		 * before discarding page cache to avoid inconsitent data on
> -		 * disk in case of crash before zeroing trans is committed.
> -		 */
> -		if (ext4_should_journal_data(inode)) {
> -			ret = filemap_write_and_wait_range(mapping, start,
> -							   end - 1);
> -			if (ret) {
> -				filemap_invalidate_unlock(mapping);
> -				goto out_mutex;
> -			}
> +		/* Now release the pages and zero block aligned part of pages */
> +		ret = ext4_truncate_page_cache_block_range(inode, start, end);
> +		if (ret) {
> +			filemap_invalidate_unlock(mapping);
> +			goto out_mutex;
>  		}
>  
> -		/* Now release the pages and zero block aligned part of pages */
> -		truncate_pagecache_range(inode, start, end - 1);
>  		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
>  
>  		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 89aade6f45f6..c68a8b841148 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -31,6 +31,7 @@
>  #include <linux/writeback.h>
>  #include <linux/pagevec.h>
>  #include <linux/mpage.h>
> +#include <linux/rmap.h>
>  #include <linux/namei.h>
>  #include <linux/uio.h>
>  #include <linux/bio.h>
> @@ -3902,6 +3903,67 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
>  	return ret;
>  }
>  
> +static inline void ext4_truncate_folio(struct inode *inode,
> +				       loff_t start, loff_t end)
> +{
> +	unsigned long blocksize = i_blocksize(inode);
> +	struct folio *folio;
> +
> +	/* Nothing to be done if no complete block needs to be truncated. */
> +	if (round_up(start, blocksize) >= round_down(end, blocksize))
> +		return;
> +
> +	folio = filemap_lock_folio(inode->i_mapping, start >> PAGE_SHIFT);
> +	if (IS_ERR(folio))
> +		return;
> +
> +	if (folio_mkclean(folio))
> +		folio_mark_dirty(folio);
> +	folio_unlock(folio);
> +	folio_put(folio);
> +}
> +
> +int ext4_truncate_page_cache_block_range(struct inode *inode,
> +					 loff_t start, loff_t end)
> +{
> +	unsigned long blocksize = i_blocksize(inode);
> +	int ret;
> +
> +	/*
> +	 * For journalled data we need to write (and checkpoint) pages
> +	 * before discarding page cache to avoid inconsitent data on disk
> +	 * in case of crash before freeing or unwritten converting trans
> +	 * is committed.
> +	 */
> +	if (ext4_should_journal_data(inode)) {
> +		ret = filemap_write_and_wait_range(inode->i_mapping, start,
> +						   end - 1);
> +		if (ret)
> +			return ret;
> +		goto truncate_pagecache;
> +	}
> +
> +	/*
> +	 * If the block size is less than the page size, the file's mapped
> +	 * blocks within one page could be freed or converted to unwritten.
> +	 * So it's necessary to remove writable userspace mappings, and then
> +	 * ext4_page_mkwrite() can be called during subsequent write access
> +	 * to these partial folios.
> +	 */
> +	if (blocksize < PAGE_SIZE && start < inode->i_size) {

Maybe we should only call ext4_truncate_folio() if the range is not page
aligned, rather than calling it everytime for bs < ps?

> +		loff_t start_boundary = round_up(start, PAGE_SIZE);

I think page_boundary seems like a more suitable name for the variable.

Regards,
ojaswin

> +
> +		ext4_truncate_folio(inode, start, min(start_boundary, end));
> +		if (end > start_boundary)
> +			ext4_truncate_folio(inode,
> +					    round_down(end, PAGE_SIZE), end);
> +	}
> +
> +truncate_pagecache:
> +	truncate_pagecache_range(inode, start, end - 1);
> +	return 0;
> +}
> +
>  static void ext4_wait_dax_page(struct inode *inode)
>  {
>  	filemap_invalidate_unlock(inode->i_mapping);
> -- 
> 2.46.1
> 


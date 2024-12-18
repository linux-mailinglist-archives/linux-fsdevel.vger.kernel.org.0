Return-Path: <linux-fsdevel+bounces-37717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C269F6290
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 11:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42181894BE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 10:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C376199254;
	Wed, 18 Dec 2024 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cUgFjiwS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0752C35963;
	Wed, 18 Dec 2024 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734517077; cv=none; b=oJoJqrjx6Hjkgmz2AxqBO9ILjVyrfPTNiuoszlRE4lWH9MVhprTkek1YUQD6zZTmxpDbBpM443MQdF1CMv1O0FG+n1T21MM6jJGooZibSkjJR5CkrmMH0V3vroWMjabx1RcSuhgQh3rRgs6HlOShKORgYiRBFvJgtKAFpGLstnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734517077; c=relaxed/simple;
	bh=HTuCvoqMCtgVIF/YL+3M+FEHQ+Gsi41a7kVNFzTXkX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nn8LZX4LB+UEf5iu3CDM9Z9bD7/Viq11HYUluXOblR2JZ0SntePF8rJDXAOLDsey0S+0sJzWH/b28UeyxJ8cOBD7jbbDPFUZsTwQYVfWks4mgH1MYW7HiQvwz6/5Qvf1SPLF+QrTXEVUoG+ago91hXbRw1ZPBOb15qBQjDJ00W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cUgFjiwS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI3rSOs030331;
	Wed, 18 Dec 2024 10:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=TP63WkaapmksyMzcK3LH2VJ2dB2jNS
	VPXYNqgsuPg2s=; b=cUgFjiwSHS15uca+TMnIG+oD7tM3J1QhjiUFIr433+VFSQ
	SqLDlMrGVUipbU7ksy2ZfWHAHeD00x+VHA4vVbaaE+TGaJRcncBOL10Ia8SsSzir
	n/b9sNPp5jb3n6jVI+ToidIdopmdD8JtG9hohyr6Pn7D2p/di1qxifrOAUCjsrv/
	dfvmdHnlx3Kpf4V/XPV49rE7tBFPMKWm1TvF9nsm7Q8/1BYID/u2633oXYpQa5I5
	XmWtW/+Hr9OfiPFsNswJInM9AJQLS1dCk25EGI/ShxF7bNNpFThy0POmMRjCijyS
	uPjUIdkHY41PAMkZCf0D6Sp0UwnYvhZy5I2R5t2Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kpvb9hkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:17:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI7uhEx014350;
	Wed, 18 Dec 2024 10:17:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hmqy7fq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:17:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BIAHbnb55902522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 10:17:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B0C82007C;
	Wed, 18 Dec 2024 10:17:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CF7620081;
	Wed, 18 Dec 2024 10:17:35 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 18 Dec 2024 10:17:35 +0000 (GMT)
Date: Wed, 18 Dec 2024 15:47:33 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 04/10] ext4: refactor ext4_punch_hole()
Message-ID: <Z2KhPcxh9ESbD5l5@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216013915.3392419-5-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _L1A7NGvqXoie5peDlmdROTWeC-qbDZN
X-Proofpoint-ORIG-GUID: _L1A7NGvqXoie5peDlmdROTWeC-qbDZN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=964 clxscore=1015 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180080

On Mon, Dec 16, 2024 at 09:39:09AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The current implementation of ext4_punch_hole() contains complex
> position calculations and stale error tags. To improve the code's
> clarity and maintainability, it is essential to clean up the code and
> improve its readability, this can be achieved by: a) simplifying and
> renaming variables; b) eliminating unnecessary position calculations;
> c) writing back all data in data=journal mode, and drop page cache from
> the original offset to the end, rather than using aligned blocks,
> d) renaming the stale error tags.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/ext4.h  |   2 +
>  fs/ext4/inode.c | 119 +++++++++++++++++++++---------------------------
>  2 files changed, 55 insertions(+), 66 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 8843929b46ce..8be06d5f5b43 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -367,6 +367,8 @@ struct ext4_io_submit {
>  #define EXT4_MAX_BLOCKS(size, offset, blkbits) \
>  	((EXT4_BLOCK_ALIGN(size + offset, blkbits) >> blkbits) - (offset >> \
>  								  blkbits))
> +#define EXT4_B_TO_LBLK(inode, offset) \
> +	(round_up((offset), i_blocksize(inode)) >> (inode)->i_blkbits)
>  
>  /* Translate a block number to a cluster number */
>  #define EXT4_B2C(sbi, blk)	((blk) >> (sbi)->s_cluster_bits)
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index a5ba2b71d508..7720d3700b27 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4008,13 +4008,13 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  {
>  	struct inode *inode = file_inode(file);
>  	struct super_block *sb = inode->i_sb;
> -	ext4_lblk_t first_block, stop_block;
> +	ext4_lblk_t start_lblk, end_lblk;
>  	struct address_space *mapping = inode->i_mapping;
> -	loff_t first_block_offset, last_block_offset, max_length;
> -	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +	loff_t max_end = EXT4_SB(sb)->s_bitmap_maxbytes - sb->s_blocksize;
> +	loff_t end = offset + length;
>  	handle_t *handle;
>  	unsigned int credits;
> -	int ret = 0, ret2 = 0;
> +	int ret = 0;
>  
>  	trace_ext4_punch_hole(inode, offset, length, 0);
>  
> @@ -4022,36 +4022,27 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  
>  	/* No need to punch hole beyond i_size */
>  	if (offset >= inode->i_size)
> -		goto out_mutex;
> +		goto out;
>  
>  	/*
> -	 * If the hole extends beyond i_size, set the hole
> -	 * to end after the page that contains i_size
> +	 * If the hole extends beyond i_size, set the hole to end after
> +	 * the page that contains i_size, and also make sure that the hole
> +	 * within one block before last range.
>  	 */
> -	if (offset + length > inode->i_size) {
> -		length = inode->i_size +
> -		   PAGE_SIZE - (inode->i_size & (PAGE_SIZE - 1)) -
> -		   offset;
> -	}
> +	if (end > inode->i_size)
> +		end = round_up(inode->i_size, PAGE_SIZE);
> +	if (end > max_end)
> +		end = max_end;
> +	length = end - offset;
>  
>  	/*
> -	 * For punch hole the length + offset needs to be within one block
> -	 * before last range. Adjust the length if it goes beyond that limit.
> +	 * Attach jinode to inode for jbd2 if we do any zeroing of partial
> +	 * block.
>  	 */
> -	max_length = sbi->s_bitmap_maxbytes - inode->i_sb->s_blocksize;
> -	if (offset + length > max_length)
> -		length = max_length - offset;
> -
> -	if (offset & (sb->s_blocksize - 1) ||
> -	    (offset + length) & (sb->s_blocksize - 1)) {
> -		/*
> -		 * Attach jinode to inode for jbd2 if we do any zeroing of
> -		 * partial block
> -		 */
> +	if (!IS_ALIGNED(offset | end, sb->s_blocksize)) {
>  		ret = ext4_inode_attach_jinode(inode);
>  		if (ret < 0)
> -			goto out_mutex;
> -
> +			goto out;
>  	}
>  
>  	/* Wait all existing dio workers, newcomers will block on i_rwsem */
> @@ -4059,7 +4050,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  
>  	ret = file_modified(file);
>  	if (ret)
> -		goto out_mutex;
> +		goto out;
>  
>  	/*
>  	 * Prevent page faults from reinstantiating pages we have released from
> @@ -4069,22 +4060,16 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  
>  	ret = ext4_break_layouts(inode);
>  	if (ret)
> -		goto out_dio;
> +		goto out_invalidate_lock;
>  
> -	first_block_offset = round_up(offset, sb->s_blocksize);
> -	last_block_offset = round_down((offset + length), sb->s_blocksize) - 1;
> +	ret = ext4_update_disksize_before_punch(inode, offset, length);

Hey Zhang,

The changes look good to me, just one question, why are we doing
disksize update unconditionally now and not only when the range 
spans a complete block or more.

(Same question for the next patch refactoring ext4_zero_range())

Regards,
ojaswin

> +	if (ret)
> +		goto out_invalidate_lock;
>  
>  	/* Now release the pages and zero block aligned part of pages*/
> -	if (last_block_offset > first_block_offset) {
> -		ret = ext4_update_disksize_before_punch(inode, offset, length);
> -		if (ret)
> -			goto out_dio;
> -
> -		ret = ext4_truncate_page_cache_block_range(inode,
> -				first_block_offset, last_block_offset + 1);
> -		if (ret)
> -			goto out_dio;
> -	}
> +	ret = ext4_truncate_page_cache_block_range(inode, offset, end);
> +	if (ret)
> +		goto out_invalidate_lock;
>  
>  	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>  		credits = ext4_writepage_trans_blocks(inode);
> @@ -4094,52 +4079,54 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	if (IS_ERR(handle)) {
>  		ret = PTR_ERR(handle);
>  		ext4_std_error(sb, ret);
> -		goto out_dio;
> +		goto out_invalidate_lock;
>  	}
>  
> -	ret = ext4_zero_partial_blocks(handle, inode, offset,
> -				       length);
> +	ret = ext4_zero_partial_blocks(handle, inode, offset, length);
>  	if (ret)
> -		goto out_stop;
> -
> -	first_block = (offset + sb->s_blocksize - 1) >>
> -		EXT4_BLOCK_SIZE_BITS(sb);
> -	stop_block = (offset + length) >> EXT4_BLOCK_SIZE_BITS(sb);
> +		goto out_handle;
>  
>  	/* If there are blocks to remove, do it */
> -	if (stop_block > first_block) {
> -		ext4_lblk_t hole_len = stop_block - first_block;
> +	start_lblk = EXT4_B_TO_LBLK(inode, offset);
> +	end_lblk = end >> inode->i_blkbits;
> +
> +	if (end_lblk > start_lblk) {
> +		ext4_lblk_t hole_len = end_lblk - start_lblk;
>  
>  		down_write(&EXT4_I(inode)->i_data_sem);
>  		ext4_discard_preallocations(inode);
>  
> -		ext4_es_remove_extent(inode, first_block, hole_len);
> +		ext4_es_remove_extent(inode, start_lblk, hole_len);
>  
>  		if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> -			ret = ext4_ext_remove_space(inode, first_block,
> -						    stop_block - 1);
> +			ret = ext4_ext_remove_space(inode, start_lblk,
> +						    end_lblk - 1);
>  		else
> -			ret = ext4_ind_remove_space(handle, inode, first_block,
> -						    stop_block);
> +			ret = ext4_ind_remove_space(handle, inode, start_lblk,
> +						    end_lblk);
> +		if (ret) {
> +			up_write(&EXT4_I(inode)->i_data_sem);
> +			goto out_handle;
> +		}
>  
> -		ext4_es_insert_extent(inode, first_block, hole_len, ~0,
> +		ext4_es_insert_extent(inode, start_lblk, hole_len, ~0,
>  				      EXTENT_STATUS_HOLE, 0);
>  		up_write(&EXT4_I(inode)->i_data_sem);
>  	}
> -	ext4_fc_track_range(handle, inode, first_block, stop_block);
> +	ext4_fc_track_range(handle, inode, start_lblk, end_lblk);
> +
> +	ret = ext4_mark_inode_dirty(handle, inode);
> +	if (unlikely(ret))
> +		goto out_handle;
> +
> +	ext4_update_inode_fsync_trans(handle, inode, 1);
>  	if (IS_SYNC(inode))
>  		ext4_handle_sync(handle);
> -
> -	ret2 = ext4_mark_inode_dirty(handle, inode);
> -	if (unlikely(ret2))
> -		ret = ret2;
> -	if (ret >= 0)
> -		ext4_update_inode_fsync_trans(handle, inode, 1);
> -out_stop:
> +out_handle:
>  	ext4_journal_stop(handle);
> -out_dio:
> +out_invalidate_lock:
>  	filemap_invalidate_unlock(mapping);
> -out_mutex:
> +out:
>  	inode_unlock(inode);
>  	return ret;
>  }
> -- 
> 2.46.1
> 


Return-Path: <linux-fsdevel+bounces-37637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 597BD9F4DCE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 15:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBE118934D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 14:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278A91F63CB;
	Tue, 17 Dec 2024 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IcCrdJ5d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F6C1D5AB6;
	Tue, 17 Dec 2024 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445920; cv=none; b=IjPo1lBguZQP+dsQbuWzfGjYSmtCrBiMNPzRZ1BG9nXaguZ2e+8ay74Be8+0vHsajv6mb+pGRMxD7tKqRPQrUlQKtUDI7g4GEBwOjZ9KUneVvw1ayK5lr4kCCR18bJPnmvjdoq1QiuRccLROa8Ii+fQx8FNysWMndYN855U8JqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445920; c=relaxed/simple;
	bh=9kge3CIPxqjFmXDmL45ANILnVwjTV+072zHYSO3YAU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wn0rDxPYVtAByzr1DhaiHaGQrDmCQVRFUuvcbwTmiLRy1VJIhMbUFMh7sKzD+KCGiLuNdSydNvKVo+SFJC8CnH4KdPzZLn884iIeR67RP593bRdmDuxMJnFGPP7Q/ojVQYQeMNnfN84rhcXLfgUtGxkeLYrKW5qoZePaZ+j0hGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IcCrdJ5d; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHE6lVJ021945;
	Tue, 17 Dec 2024 14:31:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=8UzmbUR8Tpe5gsu/QU5QKuGhKMhwp6
	+6UM2NBTUncCg=; b=IcCrdJ5dJptM/XOoomiayx8kwEv0/3OCAAXqMhcws0nJjS
	PwRG4ND+/MIp0ERg/Z+EER3bNgzKXB9cMGUec9uDmDLl6HrzhvQ9OPlr58QK//S4
	ujnq0byo1OdkgsIAfQcP8zHdC/YJnrGPtM+TJ/9RWxOG/IAc+nKgblrKqL4QP6fr
	XBub5aU499EBKTD8DG6q5AxHuYcQzWpJ9zHd+SWgX3Ns/9VW5fEJl4YyU0W/aum4
	SufI5FrLEXmmdrg0tvoC66Xp9m4F4bViKHBSJVL+pq+ZRklKaMTC0PbuzrZa6+80
	te+gvmSizcrV1pfmOFstAvT9Nv/eeT6nEFsGcijg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kas4r4gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 14:31:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHDwPmZ014391;
	Tue, 17 Dec 2024 14:31:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hq21jryy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 14:31:32 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BHEVUFb40042780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 14:31:30 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B7AD20049;
	Tue, 17 Dec 2024 14:31:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2B112004B;
	Tue, 17 Dec 2024 14:31:28 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.124.215.128])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Dec 2024 14:31:28 +0000 (GMT)
Date: Tue, 17 Dec 2024 20:01:26 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 03/10] ext4: don't write back data before punch hole
 in nojournal mode
Message-ID: <Z2GLPnX24/gvYl98@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216013915.3392419-4-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: y7jY75OJndxLCD0VC-QbVJGKUvgArs3G
X-Proofpoint-GUID: y7jY75OJndxLCD0VC-QbVJGKUvgArs3G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1011 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170115

On Mon, Dec 16, 2024 at 09:39:08AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> There is no need to write back all data before punching a hole in
> non-journaled mode since it will be dropped soon after removing space.
> Therefore, the call to filemap_write_and_wait_range() can be eliminated.

Hi, sorry I'm a bit late to this however following the discussion here
[1], I believe the initial concern was that we don't in PATCH v1 01/10 
was that after truncating the pagecache, the ext4_alloc_file_blocks()
call might fail with errors like EIO, ENOMEM etc leading to inconsistent
data. 

Is my understanding correct that  we realised that these are very rare
cases and are not worth the performance penalty of writeback? In which
case, is it really okay to just let the scope for corruption exist even
though its rare. There might be some other error cases we might be
missing which might be more easier to hit. For eg I think we can also
fail ext4_alloc_file_blocks() with ENOSPC in case there is a written to
unwritten extent conversion causing an extent split leading to  extent
tree node allocation. (Maybe can be avoided by using PRE_IO with
EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT in the first ext4_alloc_file_blocks() call)

So does it make sense to retain the writeback behavior or am I just
being paranoid :) 

Regards,
ojaswin

> Besides, similar to ext4_zero_range(), we must address the case of
> partially punched folios when block size < page size. It is essential to
> remove writable userspace mappings to ensure that the folio can be
> faulted again during subsequent mmap write access.
> 
> In journaled mode, we need to write dirty pages out before discarding
> page cache in case of crash before committing the freeing data
> transaction, which could expose old, stale data, even if synchronization
> has been performed.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/inode.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index bf735d06b621..a5ba2b71d508 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4018,17 +4018,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  
>  	trace_ext4_punch_hole(inode, offset, length, 0);
>  
> -	/*
> -	 * Write out all dirty pages to avoid race conditions
> -	 * Then release them.
> -	 */
> -	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
> -		ret = filemap_write_and_wait_range(mapping, offset,
> -						   offset + length - 1);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	inode_lock(inode);
>  
>  	/* No need to punch hole beyond i_size */
> @@ -4090,8 +4079,11 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  		ret = ext4_update_disksize_before_punch(inode, offset, length);
>  		if (ret)
>  			goto out_dio;
> -		truncate_pagecache_range(inode, first_block_offset,
> -					 last_block_offset);
> +
> +		ret = ext4_truncate_page_cache_block_range(inode,
> +				first_block_offset, last_block_offset + 1);
> +		if (ret)
> +			goto out_dio;
>  	}
>  
>  	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> -- 
> 2.46.1
> 


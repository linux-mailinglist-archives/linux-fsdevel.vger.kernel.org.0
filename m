Return-Path: <linux-fsdevel+bounces-37716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 794529F6277
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 11:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA1016CB2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 10:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EBD199E88;
	Wed, 18 Dec 2024 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FJzDClcR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CF218CC0B;
	Wed, 18 Dec 2024 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734516859; cv=none; b=Xy8ScKOk3NXUVYGMd0SSPblrrwrp7scbR2xf5fk5wk934/s6UGVDFmu2hKg4F3ar82zyjSeWyzxLEFz3v+bgqZ6R5YT4L9WEACPjhJMwkdkxvxy4lI1OqGBH12a1JREqtZAmmw3vcw8syWI9HKHYCDu/aLyV5LdZEL2/fheoQqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734516859; c=relaxed/simple;
	bh=Yoi/x1hLmNvz7cVG7F5fusNyGHezMp3EaB/kzsLKVfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=os4qGrq+d97V+L3jBFVAacJS4ubbTjz0/IBIoaK5Ae0gbDa9AQqHt7IHKIEJiP6CFA4F8rnaaYZA95Et3okcuUwFX9CgXRFlcT5/nY+MBiCoU2oNGl1/OPXyKfbc+YOhFXC6OcFMG2o43cpMk1B8ds5wq+XscGts3KSSj4Ixn+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FJzDClcR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI3qXeM027425;
	Wed, 18 Dec 2024 10:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=noNvFtHyWDI7OFNxhb6XLresFbHraw
	ubdPMV3xNv+p0=; b=FJzDClcRyXvOS8LrtMDzYC6zoPfhY7TFl4TWs8piHY2MmY
	Vda/SHoec0zySwgCOfcTILWESWbgCBS1D0s2bCs6c8LbnsIRhK78mGfW8WvxTeB9
	w6eLKe3988kJ9jhWfGY63I+gNxe36mmC1915CD/b5fsr+n6UWnPTon66GBX3jRMW
	nTDyiw9KO6zmHLlxiFD2zUem5duivg0Wp58esJGlKZJoO7mMGMqSISGpZargP5TA
	Po3oWisN+afIhvnxvuSp4UC3pQEVLAVsPRdWv+Py5iKqGCq/S2alyMcqaWns5wfb
	lTgXUb6XpLwxpFimDOTWA3a/N6p3utOXCX4Kh2FQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kpvb9h5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:14:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI8VdCR005549;
	Wed, 18 Dec 2024 10:14:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnbn7bfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:14:01 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BIADxu939125438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 10:14:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C851520074;
	Wed, 18 Dec 2024 10:13:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D84202007E;
	Wed, 18 Dec 2024 10:13:57 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 18 Dec 2024 10:13:57 +0000 (GMT)
Date: Wed, 18 Dec 2024 15:43:55 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 03/10] ext4: don't write back data before punch hole
 in nojournal mode
Message-ID: <Z2KgY1FzZRIKAW3U@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-4-yi.zhang@huaweicloud.com>
 <Z2GLPnX24/gvYl98@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <ff8abd75-b325-4f93-a838-0020e97e0b25@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff8abd75-b325-4f93-a838-0020e97e0b25@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 12XdOQGLm2AbBCLb6rdZXvRFaw4yaaRw
X-Proofpoint-ORIG-GUID: 12XdOQGLm2AbBCLb6rdZXvRFaw4yaaRw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180080

On Wed, Dec 18, 2024 at 03:10:36PM +0800, Zhang Yi wrote:
> On 2024/12/17 22:31, Ojaswin Mujoo wrote:
> > On Mon, Dec 16, 2024 at 09:39:08AM +0800, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> There is no need to write back all data before punching a hole in
> >> non-journaled mode since it will be dropped soon after removing space.
> >> Therefore, the call to filemap_write_and_wait_range() can be eliminated.
> > 
> > Hi, sorry I'm a bit late to this however following the discussion here
> > [1], I believe the initial concern was that we don't in PATCH v1 01/10 
> > was that after truncating the pagecache, the ext4_alloc_file_blocks()
> > call might fail with errors like EIO, ENOMEM etc leading to inconsistent
> > data. 
> > 
> > Is my understanding correct that  we realised that these are very rare
> > cases and are not worth the performance penalty of writeback? In which
> > case, is it really okay to just let the scope for corruption exist even
> > though its rare. There might be some other error cases we might be
> > missing which might be more easier to hit. For eg I think we can also
> > fail ext4_alloc_file_blocks() with ENOSPC in case there is a written to
> > unwritten extent conversion causing an extent split leading to  extent
> > tree node allocation. (Maybe can be avoided by using PRE_IO with
> > EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT in the first ext4_alloc_file_blocks() call)
> > 
> > So does it make sense to retain the writeback behavior or am I just
> > being paranoid :) 
> > 
> 
> Hi, Ojaswin!
> 
> Yeah, from my point of view, ENOSPC could happen, and it may be more
> likely to happen if we intentionally create conditions for it. However,
> all the efforts we can make at this point are merely best efforts and
> reduce the probability. We cannot 100% guarantee it will not happen,
> even if we write back the whole range before manipulating extents and
> blocks. This is because we do not accurately reserve space for extents
> split. Additionally, In ext4_punch_hole(), we have used 'nofail' flag

Right, rechecking the ext4_map_blocks code, seems like we can also result
in a failure after unwrit extents have successfully been allocated so 
either ways we can't be sure that we'll retain old data on failure even
with writeback. 

> while freeing blocks to reduce the possibility of ENOSPC. So I suppose
> it's fine by now, but we may need to implement additional measures if
> we truly want to resolve the issue completely.

Sure I agree that in that case we should ideally have something more
robust to handle these edge cases. For now, this change looks good.

Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

> 
> Thanks,
> Yi.
> 
> > 
> >> Besides, similar to ext4_zero_range(), we must address the case of
> >> partially punched folios when block size < page size. It is essential to
> >> remove writable userspace mappings to ensure that the folio can be
> >> faulted again during subsequent mmap write access.
> >>
> >> In journaled mode, we need to write dirty pages out before discarding
> >> page cache in case of crash before committing the freeing data
> >> transaction, which could expose old, stale data, even if synchronization
> >> has been performed.
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >> ---
> >>  fs/ext4/inode.c | 18 +++++-------------
> >>  1 file changed, 5 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> >> index bf735d06b621..a5ba2b71d508 100644
> >> --- a/fs/ext4/inode.c
> >> +++ b/fs/ext4/inode.c
> >> @@ -4018,17 +4018,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
> >>  
> >>  	trace_ext4_punch_hole(inode, offset, length, 0);
> >>  
> >> -	/*
> >> -	 * Write out all dirty pages to avoid race conditions
> >> -	 * Then release them.
> >> -	 */
> >> -	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
> >> -		ret = filemap_write_and_wait_range(mapping, offset,
> >> -						   offset + length - 1);
> >> -		if (ret)
> >> -			return ret;
> >> -	}
> >> -
> >>  	inode_lock(inode);
> >>  
> >>  	/* No need to punch hole beyond i_size */
> >> @@ -4090,8 +4079,11 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
> >>  		ret = ext4_update_disksize_before_punch(inode, offset, length);
> >>  		if (ret)
> >>  			goto out_dio;
> >> -		truncate_pagecache_range(inode, first_block_offset,
> >> -					 last_block_offset);
> >> +
> >> +		ret = ext4_truncate_page_cache_block_range(inode,
> >> +				first_block_offset, last_block_offset + 1);
> >> +		if (ret)
> >> +			goto out_dio;
> >>  	}
> >>  
> >>  	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> >> -- 
> >> 2.46.1
> >>
> 


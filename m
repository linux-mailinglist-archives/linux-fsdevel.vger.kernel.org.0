Return-Path: <linux-fsdevel+bounces-37640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956609F4E6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 15:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2EE169D6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 14:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B9C1F7081;
	Tue, 17 Dec 2024 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XPdO//p2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CFB1F542F;
	Tue, 17 Dec 2024 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447060; cv=none; b=faYMRsP2/zW8pDYRGlDHZUqt2QJT6H6vpysmInSLRI2WIDl3B4xht3F54xzK1EPo0k1hAxnNquWEH1jODHbUJLVz32uRFbrcwcYfSblWapCpTaq/7+j4ioDJH3TxE9SwBefoYL2h3sIJ6EZpY/IlZ+Phiq+6k9iCLQPt/4bEHkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447060; c=relaxed/simple;
	bh=hK+5RvsXt6+5TcMTIgKZgLYBHTVtdNDyG04YPhIQvd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgIn6dSR5hKwY5g0lLNIlu7T4qQJzqbqf1MQb3EAMF4lT50AeIVMNSPC5Q04zckXUs8nA95i4HLOc6NVpDK4AfS400JTVAidu5PsSORJq+J1TtuX2SxnRCAkEfoYO0ic4A9qrSQupqrDIXNpwkp1bm5/es97aEXhncwKsrJZZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XPdO//p2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHBwjO4029079;
	Tue, 17 Dec 2024 14:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=FlRm0FAR+SREVLUW5esXaZDOmfYWE7
	GZ7t6GDJ6ejJs=; b=XPdO//p2QfIMVXd9RGKxublUFMFokzfowzifIegSnGAT/m
	Eo7t/aVl1X9vs4eWz671VYEJqeqjjY0qCKDUd7AD3Fjwj87jDdC7daPcZMR/ZmlI
	3BOU1nZSZvxBESDNERzo1/fl79wgFctENpv0mcGJ3uBPhVCBVQ43s2PDboOS3SSw
	Ry502yjZcpbfRlSIZGMR37aN0cIbCuIO9XtJIBIn1idzLP1lITHXsXAAOJgbJuZU
	+4uvkgrMnBC5i7/fFgz9XPGZtItGjQvoF1ozQyQz9X4H6EgSK4uWMlUUPEDFpIe9
	O8IDQvTqE5u5m0SV5zY0qRgqBY4z0Ord5SwuuE0Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jxbh3ek4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 14:50:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHDj2EI014378;
	Tue, 17 Dec 2024 14:50:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hq21ju1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 14:50:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BHEoWfg54264170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 14:50:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1345120075;
	Tue, 17 Dec 2024 14:50:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 193C620073;
	Tue, 17 Dec 2024 14:50:30 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.124.215.128])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Dec 2024 14:50:29 +0000 (GMT)
Date: Tue, 17 Dec 2024 20:20:27 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 03/10] ext4: don't write back data before punch hole
 in nojournal mode
Message-ID: <Z2GPszLGfwG/ujl2@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-4-yi.zhang@huaweicloud.com>
 <Z2GLPnX24/gvYl98@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2GLPnX24/gvYl98@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yxoPszBdvVjGnVNtcGjBjtdSdYZLDwkX
X-Proofpoint-ORIG-GUID: yxoPszBdvVjGnVNtcGjBjtdSdYZLDwkX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170115

On Tue, Dec 17, 2024 at 08:01:26PM +0530, Ojaswin Mujoo wrote:
> On Mon, Dec 16, 2024 at 09:39:08AM +0800, Zhang Yi wrote:
> > From: Zhang Yi <yi.zhang@huawei.com>
> > 
> > There is no need to write back all data before punching a hole in
> > non-journaled mode since it will be dropped soon after removing space.
> > Therefore, the call to filemap_write_and_wait_range() can be eliminated.
> 
> Hi, sorry I'm a bit late to this however following the discussion here
> [1], I believe the initial concern was that we don't in PATCH v1 01/10 
> was that after truncating the pagecache, the ext4_alloc_file_blocks()
> call might fail with errors like EIO, ENOMEM etc leading to inconsistent
> data. 
> 
> Is my understanding correct that  we realised that these are very rare
> cases and are not worth the performance penalty of writeback? In which
> case, is it really okay to just let the scope for corruption exist even
> though its rare. There might be some other error cases we might be
> missing which might be more easier to hit. For eg I think we can also
> fail ext4_alloc_file_blocks() with ENOSPC in case there is a written to
> unwritten extent conversion causing an extent split leading to  extent
> tree node allocation. (Maybe can be avoided by using PRE_IO with
> EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT in the first ext4_alloc_file_blocks() call)
> 
> So does it make sense to retain the writeback behavior or am I just
> being paranoid :) 
> 
> Regards,
> ojaswin

[1]
https://lore.kernel.org/linux-ext4/20240917165007.j5dywaekvnirfffm@quack3/
> 
> > Besides, similar to ext4_zero_range(), we must address the case of
> > partially punched folios when block size < page size. It is essential to
> > remove writable userspace mappings to ensure that the folio can be
> > faulted again during subsequent mmap write access.
> > 
> > In journaled mode, we need to write dirty pages out before discarding
> > page cache in case of crash before committing the freeing data
> > transaction, which could expose old, stale data, even if synchronization
> > has been performed.
> > 
> > Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > ---
> >  fs/ext4/inode.c | 18 +++++-------------
> >  1 file changed, 5 insertions(+), 13 deletions(-)
> > 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index bf735d06b621..a5ba2b71d508 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -4018,17 +4018,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
> >  
> >  	trace_ext4_punch_hole(inode, offset, length, 0);
> >  
> > -	/*
> > -	 * Write out all dirty pages to avoid race conditions
> > -	 * Then release them.
> > -	 */
> > -	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
> > -		ret = filemap_write_and_wait_range(mapping, offset,
> > -						   offset + length - 1);
> > -		if (ret)
> > -			return ret;
> > -	}
> > -
> >  	inode_lock(inode);
> >  
> >  	/* No need to punch hole beyond i_size */
> > @@ -4090,8 +4079,11 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
> >  		ret = ext4_update_disksize_before_punch(inode, offset, length);
> >  		if (ret)
> >  			goto out_dio;
> > -		truncate_pagecache_range(inode, first_block_offset,
> > -					 last_block_offset);
> > +
> > +		ret = ext4_truncate_page_cache_block_range(inode,
> > +				first_block_offset, last_block_offset + 1);
> > +		if (ret)
> > +			goto out_dio;
> >  	}
> >  
> >  	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> > -- 
> > 2.46.1
> > 


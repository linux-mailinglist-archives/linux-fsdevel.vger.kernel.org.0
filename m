Return-Path: <linux-fsdevel+bounces-72342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC26CF00DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 03 Jan 2026 15:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CA9C3039323
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jan 2026 14:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAEE30DEA5;
	Sat,  3 Jan 2026 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QOuc1wqK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9075830C639;
	Sat,  3 Jan 2026 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767449705; cv=none; b=GI1kvmLN2Qyxm0Mhu/4t9f+O98f3SQNmfyP4ZpdL74FvuJbM85+YIrRKe3paka3KlE1B/sqJDsuLKPssZWAVc9zLGzs0HYkNJ9OXjzTg6xssad1xWtsRVlMNtlILKop4nfnCXMCIMwrY/+hrzQyqgA5x/GLwtPJmrIZUSH9ZvuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767449705; c=relaxed/simple;
	bh=dGiUns1jcHC1LFG71/zcKJo67m9x82CX4B3QrLX/hZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWAiAx+MjxR6lS553IG/yzBkWAbGL9CQnL+/3K9FzWfhfychD0qMostIGQ10tAPi+rWLVLwWbEzf5PBNoac7hpugNCTH/Gvx7ZhenFAY+JMYeiinZ1YDE/U9+i2LpBdi0a//vRNLMJinlU4EQWLWSFeE2FcHE+DkqTZ1YM0URfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QOuc1wqK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 603CuJj1016513;
	Sat, 3 Jan 2026 14:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=zoJYwoB9uuCDRz9ozSMo2fAH5ozVAU
	wibE29ibdKI3A=; b=QOuc1wqK32MPK9hbpAeeNW2QW4bfhRjLvYd5/gTqJGhrZ9
	fKKy9tyEU8LQgP7192fyhaSmfRwmeqb4X75LWUeaVYCfbV8qlh32epHRGh/RGxzN
	8NC+hljCRqymomxB43U42caG59l59YKxSr/jGOUgFTN9dKYDgqrmUIKqqJJUj9w5
	lKXchSL56AuMaloZvfRUCcRFmVPiptyOp1zPanM4UH3LJd3goeMDsv3PYbEpHM4m
	CV7fmFL4qpvUrf5LStvTdaoJgkg0atyx0eRfUn4Ejp/qsGRPIVWcCjLFjPI7VFW3
	nLy/4D+fhFeRvkhKsWrWqnORq+miCmqvNUCJsbwg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betsps7mj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Jan 2026 14:14:31 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 603EEUOr019124;
	Sat, 3 Jan 2026 14:14:30 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betsps7mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Jan 2026 14:14:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 603DYv8E023904;
	Sat, 3 Jan 2026 14:14:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bat5yth3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Jan 2026 14:14:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 603EERXU13238722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 3 Jan 2026 14:14:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65AF020043;
	Sat,  3 Jan 2026 14:14:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ABA620040;
	Sat,  3 Jan 2026 14:14:24 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.213.223])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  3 Jan 2026 14:14:23 +0000 (GMT)
Date: Sat, 3 Jan 2026 19:44:21 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, yi.zhang@huawei.com,
        yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com,
        yukuai@fnnas.com
Subject: Re: [PATCH -next v2 4/7] ext4: remove useless
 ext4_iomap_overwrite_ops
Message-ID: <aVkkPZV-ymHm215K@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251223011802.31238-1-yi.zhang@huaweicloud.com>
 <20251223011802.31238-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223011802.31238-5-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WWBYSvu4Vot7xPq4vh-uLJnw9sp6gN1p
X-Authority-Analysis: v=2.4 cv=Jvf8bc4C c=1 sm=1 tr=0 ts=69592447 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=Q5UtyL6Jz_20AhNk72IA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: G2sxyc8ro5g3JrQRLBNwEiArXmggDNm8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAzMDEyNSBTYWx0ZWRfX5J4gw5kL5A8k
 Pck6Z6cUtdk126qDU34NBQgq020lNUTNxJUx0EsLwHN12ZPvUgle2elOp8EkDlTmjbceNHryuwY
 z47gTGIfI1xbuRdGtmWrqlMHaMWhpMklIA1H7ETnmcTDOtoz93pQ4vH35MOkBSDCe1mx7yVtisE
 2IhsjWfUYtEdvzyux1yJJpzeqWArtpNPnYJTxtGkGsykbr4mgtw2RiuSXiPWoFOupDTgec6NXmM
 d7f5sLqSUrBG3jQzlByoxwzXMZEkKLLe/QtIOYuRU4JDSZ8YiBjREuf/M703bGgMIiDcEP5wPr6
 jJGZddX+KZXoktmurYazoFaiIzyxNaZIRMAxESjo1WCNzgRfT3iI91Ow/TPcXzyy4uhjuDe0RyI
 KkN8iiFbM83tbCxSqJVe8mxfKQNeNga/HiD7uMI+OCc4vw3+sERTN5SziJcVRbB+89XnONPKPcQ
 XireEGzYckK+bHWNKbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-03_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601030125

On Tue, Dec 23, 2025 at 09:17:59AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> ext4_iomap_overwrite_ops was introduced in commit 8cd115bdda17 ("ext4:
> Optimize ext4 DIO overwrites"), which can optimize pure overwrite
> performance by dropping the IOMAP_WRITE flag to only query the mapped
> mapping information. This avoids starting a new journal handle, thereby
> improving speed. Later, commit 9faac62d4013 ("ext4: optimize file
> overwrites") also optimized similar scenarios, but it performs the check
> later, examining the mappings status only when the actual block mapping
> is needed. Thus, it can handle the previous commit scenario. That means
> in the case of an overwrite scenario, the condition
> "offset + length <= i_size_read(inode)" in the write path must always be
> true.
> 
> Therefore, it is acceptable to remove the ext4_iomap_overwrite_ops,
> which will also clarify the write and read paths of ext4_iomap_begin.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks good, feel free to add:
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/ext4/ext4.h  |  1 -
>  fs/ext4/file.c  |  5 +----
>  fs/ext4/inode.c | 24 ------------------------
>  3 files changed, 1 insertion(+), 29 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 56112f201cac..9a71357f192d 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3909,7 +3909,6 @@ static inline void ext4_clear_io_unwritten_flag(ext4_io_end_t *io_end)
>  }
>  
>  extern const struct iomap_ops ext4_iomap_ops;
> -extern const struct iomap_ops ext4_iomap_overwrite_ops;
>  extern const struct iomap_ops ext4_iomap_report_ops;
>  
>  static inline int ext4_buffer_uptodate(struct buffer_head *bh)
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 9f571acc7782..6b4b68f830d5 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -506,7 +506,6 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  	loff_t offset = iocb->ki_pos;
>  	size_t count = iov_iter_count(from);
> -	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
>  	bool extend = false, unwritten = false;
>  	bool ilock_shared = true;
>  	int dio_flags = 0;
> @@ -573,9 +572,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  			goto out;
>  	}
>  
> -	if (ilock_shared && !unwritten)
> -		iomap_ops = &ext4_iomap_overwrite_ops;
> -	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
> +	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, &ext4_dio_write_ops,
>  			   dio_flags, NULL, 0);
>  	if (ret == -ENOTBLK)
>  		ret = 0;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ff3ad1a2df45..b84a2a10dfb8 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3833,10 +3833,6 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  		}
>  		ret = ext4_iomap_alloc(inode, &map, flags);
>  	} else {
> -		/*
> -		 * This can be called for overwrites path from
> -		 * ext4_iomap_overwrite_begin().
> -		 */
>  		ret = ext4_map_blocks(NULL, inode, &map, 0);
>  	}
>  
> @@ -3865,30 +3861,10 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  	return 0;
>  }
>  
> -static int ext4_iomap_overwrite_begin(struct inode *inode, loff_t offset,
> -		loff_t length, unsigned flags, struct iomap *iomap,
> -		struct iomap *srcmap)
> -{
> -	int ret;
> -
> -	/*
> -	 * Even for writes we don't need to allocate blocks, so just pretend
> -	 * we are reading to save overhead of starting a transaction.
> -	 */
> -	flags &= ~IOMAP_WRITE;
> -	ret = ext4_iomap_begin(inode, offset, length, flags, iomap, srcmap);
> -	WARN_ON_ONCE(!ret && iomap->type != IOMAP_MAPPED);
> -	return ret;
> -}
> -
>  const struct iomap_ops ext4_iomap_ops = {
>  	.iomap_begin		= ext4_iomap_begin,
>  };
>  
> -const struct iomap_ops ext4_iomap_overwrite_ops = {
> -	.iomap_begin		= ext4_iomap_overwrite_begin,
> -};
> -
>  static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
>  				   loff_t length, unsigned int flags,
>  				   struct iomap *iomap, struct iomap *srcmap)
> -- 
> 2.52.0
> 


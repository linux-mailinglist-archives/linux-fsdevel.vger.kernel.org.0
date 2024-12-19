Return-Path: <linux-fsdevel+bounces-37778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5FB9F7526
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 08:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294D416C9AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 07:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77C0216611;
	Thu, 19 Dec 2024 07:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q/fT32+k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963C61C69D;
	Thu, 19 Dec 2024 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734592325; cv=none; b=EXs1M9Cvp5gVKXDWjkmdF38llgSHcjtg/CasJCRnDyfuD+VGSsUV3Xl/Fsr5/t1aWzZmEw5UkbUcDO7WNgV4fUEebzf2tRerMPo7ZHJl8ivx6FZUlhM/pF62E+XyV0qsnoyN8SZSNbQco9TC+faJxH+dAxLTQLlyTaM5n5hOv9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734592325; c=relaxed/simple;
	bh=Pbtvh/owiGIl0gW0ermBY2O+ChQ7U1BaNa/SBSGdask=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0Ibza/g9K1bofEFUiLgBag7OgQu2oK1Myjwjzn+JYBRNr4rbwL5SSwFbGAoUSqOoTo2zgi84acb/TE6bs0k2eXohE1w3WJHcNtfCAuewHaKnAIi61X5Ehi5A+HfFyU4ymZPxxHnOxyWXfy5RLNY988+3bsSk9eq2gINia81GrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q/fT32+k; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BINaugt031716;
	Thu, 19 Dec 2024 07:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=6vZq0dFqtHjiffSaLTaQTfmX6Tz6CJ
	RTFTY5trTrpJA=; b=q/fT32+k3oDuzwW1Yk+SJsY6+dXBcEqudbd3YTXsmePZG/
	FwBY6AAaLbvqOWg+/jP5C6BMWClt+CcRtaPSetV12b6ftNMrZZcDfLb5HVjncimQ
	F4BPHvEb6Q+BoELzXLpCGGEmMMa0QZ+IEiJLK9IkdCTPUhwdWQrtV91rKSxzBFBK
	4lOrZwdfkX8zDI1nCFAeoCGmyDUIWCw+4f7eEmt5KB7+jb+RgV3EwrYo4VjfT9+P
	fWcPM3PjjdAscGyniObc39rkfJG47uMlI10SkrSZGgIPESHRYhMeHkYpqtZiQwsS
	6WiFuERUEuEqX7C+BgIQi+Qs8IOYo3OycJbA8Few==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43m87a1ey0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 07:11:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ5XMxV011252;
	Thu, 19 Dec 2024 07:11:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hpjkbq31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 07:11:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BJ7Bbev38142326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 07:11:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F369D20040;
	Thu, 19 Dec 2024 07:11:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B055220049;
	Thu, 19 Dec 2024 07:11:34 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.124.218.178])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 19 Dec 2024 07:11:34 +0000 (GMT)
Date: Thu, 19 Dec 2024 12:41:31 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 04/10] ext4: refactor ext4_punch_hole()
Message-ID: <Z2PHI7ks4hr7pEoM@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-5-yi.zhang@huaweicloud.com>
 <Z2KhPcxh9ESbD5l5@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <221b151d-12c7-4e98-afc4-d248aa3637ba@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <221b151d-12c7-4e98-afc4-d248aa3637ba@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ckarNY-z97g8DM6eMvjplrSFXmoSNtca
X-Proofpoint-GUID: ckarNY-z97g8DM6eMvjplrSFXmoSNtca
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190054

On Wed, Dec 18, 2024 at 09:13:46PM +0800, Zhang Yi wrote:
> On 2024/12/18 18:17, Ojaswin Mujoo wrote:
> > On Mon, Dec 16, 2024 at 09:39:09AM +0800, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> The current implementation of ext4_punch_hole() contains complex
> >> position calculations and stale error tags. To improve the code's
> >> clarity and maintainability, it is essential to clean up the code and
> >> improve its readability, this can be achieved by: a) simplifying and
> >> renaming variables; b) eliminating unnecessary position calculations;
> >> c) writing back all data in data=journal mode, and drop page cache from
> >> the original offset to the end, rather than using aligned blocks,
> >> d) renaming the stale error tags.
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >> ---
> >>  fs/ext4/ext4.h  |   2 +
> >>  fs/ext4/inode.c | 119 +++++++++++++++++++++---------------------------
> >>  2 files changed, 55 insertions(+), 66 deletions(-)
> >>
> >> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> >> index 8843929b46ce..8be06d5f5b43 100644
> >> --- a/fs/ext4/ext4.h
> >> +++ b/fs/ext4/ext4.h
> >> @@ -367,6 +367,8 @@ struct ext4_io_submit {
> >>  #define EXT4_MAX_BLOCKS(size, offset, blkbits) \
> >>  	((EXT4_BLOCK_ALIGN(size + offset, blkbits) >> blkbits) - (offset >> \
> >>  								  blkbits))
> >> +#define EXT4_B_TO_LBLK(inode, offset) \
> >> +	(round_up((offset), i_blocksize(inode)) >> (inode)->i_blkbits)
> >>  
> >>  /* Translate a block number to a cluster number */
> >>  #define EXT4_B2C(sbi, blk)	((blk) >> (sbi)->s_cluster_bits)
> >> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> >> index a5ba2b71d508..7720d3700b27 100644
> >> --- a/fs/ext4/inode.c
> >> +++ b/fs/ext4/inode.c
> [..]
> >> @@ -4069,22 +4060,16 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
> >>  
> >>  	ret = ext4_break_layouts(inode);
> >>  	if (ret)
> >> -		goto out_dio;
> >> +		goto out_invalidate_lock;
> >>  
> >> -	first_block_offset = round_up(offset, sb->s_blocksize);
> >> -	last_block_offset = round_down((offset + length), sb->s_blocksize) - 1;
> >> +	ret = ext4_update_disksize_before_punch(inode, offset, length);
> > 
> > Hey Zhang,
> > 
> > The changes look good to me, just one question, why are we doing
> > disksize update unconditionally now and not only when the range 
> > spans a complete block or more.
> > 
> 
> I want to simplify the code. We only need to update the disksize when
> the end of the punching or zeroing range is >= the EOF and i_disksize
> is less than i_size. ext4_update_disksize_before_punch() has already
> performed this check and has ruled out most cases. Therefore, I
> believe that calling it unconditionally will not incur significant
> costs.

Okay sure, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin
> 
> Thanks,
> Yi.
> 


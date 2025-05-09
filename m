Return-Path: <linux-fsdevel+bounces-48529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 433EAAB09AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 07:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E61188C760
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 05:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0579267B97;
	Fri,  9 May 2025 05:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F4Vq/W/X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B3B267B6F;
	Fri,  9 May 2025 05:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746768100; cv=none; b=GRPudq0794mZDloMINKr3EKeFYxy51rE/SVkY/SOrgor8oKfZ+st/RqyZa2rIgC+4rjl54IzGZSbmCI9tQNsqI0mdG+MlOUFWygck6GhHfflyHpgbVpsR99rnwf54WEvv+3M5wn0qHtNzKReSFDok2ux2L8Faz/8+cI7ZR0AGMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746768100; c=relaxed/simple;
	bh=NxeyCefMKzU9iG88ojXPIB7wjPcFv82KoV0E0GkDlPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bknrks0Mf7WSICyFz08YRHADvHhWNs5NpURYJqG1DvFgqdF4A3L3YrOyWvwitSGGKzN0c5KrUAyNP9jkni4X6O5/Xt29opnxnIljlIjgWt+9rgb2NUaiQK8bMcddmENHJZBFJNHkHF4JUcw91dWvYQQS9CPe1LBQqT6apI0xJPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F4Vq/W/X; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5494BvSC022124;
	Fri, 9 May 2025 05:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ijKHZBeKgBb+LvKKxHi0IN//TGodfQ
	K55rA4lQTcJVs=; b=F4Vq/W/Xf4INMWS9kC25Kl9J5oTHd8cIzwpm6IxNvw5D6M
	tOZeygdO8be4sxXO68y1J3K9U90UqEwPAt3WJw0YgD5sdI1z11MEnlAc/ngnbkSU
	NCu07da1tsCZ5OLSVty1Jwbrp8DwtkhOUliAgbjJ43PlrGtmbWP1jJxWJ1xju4jj
	5MOwoSIaBPvbzCft6zH+vRSImHQo6w9g+jHV/cenqOH3MCKs9WeHM2hqN1EsWP2d
	MN4Lim9g/Vr11NAZKsQyKg28uNET9larnn2Us55WZVB1i7ZCTPsPqZ3FMKry+jUa
	QJehFI/4FH6Ob/G+tAyMai7jUMW6VshV8xEhCDXQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gu2t4qg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 05:21:29 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54959FIO006717;
	Fri, 9 May 2025 05:21:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gu2t4qg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 05:21:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5494WonA026011;
	Fri, 9 May 2025 05:21:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dwv09pqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 05:21:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5495LQcH56557872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 05:21:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C5922004E;
	Fri,  9 May 2025 05:21:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BF862004B;
	Fri,  9 May 2025 05:21:24 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.209.93])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  9 May 2025 05:21:24 +0000 (GMT)
Date: Fri, 9 May 2025 10:51:20 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] ext4: Make ext4_meta_trans_blocks() non-static
 for later use
Message-ID: <aB2Q0A64l79MaAuR@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1746734745.git.ritesh.list@gmail.com>
 <53dd687535024df91147d1c30124330d1a5c985c.1746734745.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53dd687535024df91147d1c30124330d1a5c985c.1746734745.git.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NLnV+16g c=1 sm=1 tr=0 ts=681d90d9 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=2dvoARLY7QW6gT7WcqQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: QxhYxrTFzHf8gKMxJVZ0nlZ219JiJGyi
X-Proofpoint-GUID: YRUnT8noMcuBndz_OpbNLs-myjF7sslF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA0NyBTYWx0ZWRfX63GNS58nwVt6 Svlur359W7zK9zCfuO/wY2eQc+KzvXHiljSOVpOVZcobY8ho1sUL7z/0emwiDzUaRvbdi20kU10 1se6CY9h4IOAYfJMf7ksPi0CvUxhlc+9GfRk1AUJOpPRLoKq46x7z5qwR9pAkyn3TJUz7M6miDM
 BK6Ip3eRIxBSpmPb0kXl9WF8Y6KcfQiMMpG+Sakyduwr+ZIA9Y8ScW6N6TPu0ktHtevYGRU9fIA pB79g7vFBFJb6Kq1/wLXzu0MmZpjDEtnpv34kOCGZBB9KpMdXu+ho5IwDExiFFw9m2rAXbEoU+P jwJFKdRR6Y4f6PNKvYO4mqG/oHUQ/0PeAjobP2/Q1s/Yn36+74QQdheiEzmzBo7qc7Uvr98y7ia
 lSiV5MK+9iQYm6IeZl/eZ8akIXUSkFJHzNifgYJpwgkcfrSLwV5JKeqxiDfC8c9Wfci46LZR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_01,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxlogscore=693 phishscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090047

On Fri, May 09, 2025 at 02:20:33AM +0530, Ritesh Harjani (IBM) wrote:
> Let's make ext4_meta_trans_blocks() non-static for use in later
> functions during ->end_io conversion for atomic writes.
> We will need this function to estimate journal credits for a special
> case. Instead of adding another wrapper around it, let's make this
> non-static.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good Ritesh. Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

> ---
>  fs/ext4/ext4.h  | 2 ++
>  fs/ext4/inode.c | 6 +-----
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index c0240f6f6491..e2b36a3c1b0f 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3039,6 +3039,8 @@ extern void ext4_set_aops(struct inode *inode);
>  extern int ext4_writepage_trans_blocks(struct inode *);
>  extern int ext4_normal_submit_inode_data_buffers(struct jbd2_inode *jinode);
>  extern int ext4_chunk_trans_blocks(struct inode *, int nrblocks);
> +extern int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
> +				  int pextents);
>  extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
>  			     loff_t lstart, loff_t lend);
>  extern vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index b10e5cd5bb5c..2f99b087a5d8 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -142,9 +142,6 @@ static inline int ext4_begin_ordered_truncate(struct inode *inode,
>  						   new_size);
>  }
>  
> -static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
> -				  int pextents);
> -
>  /*
>   * Test whether an inode is a fast symlink.
>   * A fast symlink has its symlink data stored in ext4_inode_info->i_data.
> @@ -5777,8 +5774,7 @@ static int ext4_index_trans_blocks(struct inode *inode, int lblocks,
>   *
>   * Also account for superblock, inode, quota and xattr blocks
>   */
> -static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
> -				  int pextents)
> +int ext4_meta_trans_blocks(struct inode *inode, int lblocks, int pextents)
>  {
>  	ext4_group_t groups, ngroups = ext4_get_groups_count(inode->i_sb);
>  	int gdpblocks;
> -- 
> 2.49.0
> 


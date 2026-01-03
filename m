Return-Path: <linux-fsdevel+bounces-72343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B532CF00E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 03 Jan 2026 15:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04D193004297
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jan 2026 14:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFFE30DD07;
	Sat,  3 Jan 2026 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Bc8IONhj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A871E1DE5;
	Sat,  3 Jan 2026 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767449834; cv=none; b=IdhddhgpVFiP7/6cbtBDroi37YnGncrDjC/pvsS7jquePa+IQj70VYP5KBdCxOd67N++ByAwOJdnvaifBdIastk229iDjEMWKEc6lNUMnbnKSFAcwGfMvpaIMCnC8h/OlTb9vahUfpa1FUSdDD4/C+OiHA1HnsMmG/PF68hhleQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767449834; c=relaxed/simple;
	bh=V0pUmpx2jxRTAOX2paMscbwZCDEEaQsBJtfi2wzXvqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j86R/LFoiiI2SaAsQuIrCIDfui6CYmNvc6i8wb0ShZwAs90hltXziFrUIFHMB8tGvZ0zxsPdchA3IoIoqnytolkZHV4ZhUfpYnpYQ4foKLUrhpyugvI9UqB3VnCmQP6MnYC3IDejwjMj/SToxPpU6zkWWAkXLpg+uSNUnWt9Wfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Bc8IONhj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6031WbAc008196;
	Sat, 3 Jan 2026 14:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=nQK7MoJwViNs+3ygbtvr8TS6pfy4fO
	ePkboyajmseUs=; b=Bc8IONhjfvfFcHNufbcefZ72MV49oPryHToQ8BbOKDbUC4
	WDNFjXIUU40AmN8BdNaUJ4ZmWXGoo0fEFUqHjoF92zrvmCWh/PP0OXccODP0sp5P
	8QpNEpfeIbPae1YBLng5nE1JmbHNMQN7sCpTggUHxhsKm4LyPJ0r587RRuBubvmL
	AkDNfFlrWDz/d9VVkQ2JAi164QQy0GcIqMUdIeD0NakzJ9jAWD0Od50TqUmRUGIu
	fUFtq2l1vImHflDroWTbRxZskAFhxdaegOS1SPKjpLXhe891J/UEEr8eZs9YHL7D
	Vd/W0TQzYORi1b52SwevV842fkU7qvL54zsI9oCQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4besheh8nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Jan 2026 14:16:44 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 603EGhUs009697;
	Sat, 3 Jan 2026 14:16:43 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4besheh8nh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Jan 2026 14:16:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 603CkZ8R012876;
	Sat, 3 Jan 2026 14:16:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4basstameq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Jan 2026 14:16:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 603EGfgI29557470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 3 Jan 2026 14:16:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E36B720043;
	Sat,  3 Jan 2026 14:16:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD71A20040;
	Sat,  3 Jan 2026 14:16:37 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.213.223])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  3 Jan 2026 14:16:37 +0000 (GMT)
Date: Sat, 3 Jan 2026 19:46:35 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, yi.zhang@huawei.com,
        yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com,
        yukuai@fnnas.com
Subject: Re: [PATCH -next v2 5/7] ext4: remove unused unwritten parameter in
 ext4_dio_write_iter()
Message-ID: <aVkkw8aN7sUnSs2U@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251223011802.31238-1-yi.zhang@huaweicloud.com>
 <20251223011802.31238-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223011802.31238-6-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAzMDEzMCBTYWx0ZWRfXwH/+3BZ0nUzk
 lc0EfJlX3+fntrYZGulwxszkQBMXLDxNIC/HeVFnzglQSQA8nBPkuFeoNE87QR8yhV9z63XiypQ
 2H/f2eghbU/dkntvWzZrRunp/iQK9NrMzRuCweRY5j+0ST8/4V50ZcTr14DSaNSe8QuCgS68Y4Y
 AN2JFGZAfxLoV9zpLtR7RVMiN41gfZTkyNBiEDEP7f5xYTEJgkxcxXKopShpW5KV7zV3u79l7TM
 jjGNJTrh1ZkdTFYeKBqukChxUqi5eB0JjYu/RNHO9OM1kW7u9uDDKbr5Y6rHm43ZjyOE5h7eS2K
 zu6Q8B5O5hYBa/CbAIHziODgrR/rQa7KFgueogpd9a1dAEuU9RbcZGO50PmjaLxgRxFSOG36R3w
 7RP0z/xhJ+4+KIRd2D+cvsBw8o/rXVlU2j62QZwhglivwkwgOAYj51zoI4hWmQ7wzXe+JIYoiWY
 1K1ki738fHd5474qNpA==
X-Proofpoint-GUID: KGzf35hhyZof5DBnZn815JGXULs_SmOv
X-Proofpoint-ORIG-GUID: 8cRseJ6pAt1001C4Vn--LXV_UH7t_P0D
X-Authority-Analysis: v=2.4 cv=AOkvhdoa c=1 sm=1 tr=0 ts=695924cc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=HLe6iSWBm_v00hWEfWYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-03_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601030130

On Tue, Dec 23, 2025 at 09:18:00AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The parameter unwritten in ext4_dio_write_iter() is no longer needed,
> simply remove it.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks good, feel free to add:
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/ext4/file.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 6b4b68f830d5..fa22fc0e45f3 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -424,14 +424,14 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
>   */
>  static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>  				     bool *ilock_shared, bool *extend,
> -				     bool *unwritten, int *dio_flags)
> +				     int *dio_flags)
>  {
>  	struct file *file = iocb->ki_filp;
>  	struct inode *inode = file_inode(file);
>  	loff_t offset;
>  	size_t count;
>  	ssize_t ret;
> -	bool overwrite, unaligned_io;
> +	bool overwrite, unaligned_io, unwritten;
>  
>  restart:
>  	ret = ext4_generic_write_checks(iocb, from);
> @@ -443,7 +443,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>  
>  	unaligned_io = ext4_unaligned_io(inode, from, offset);
>  	*extend = ext4_extending_io(inode, offset, count);
> -	overwrite = ext4_overwrite_io(inode, offset, count, unwritten);
> +	overwrite = ext4_overwrite_io(inode, offset, count, &unwritten);
>  
>  	/*
>  	 * Determine whether we need to upgrade to an exclusive lock. This is
> @@ -458,7 +458,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>  	 */
>  	if (*ilock_shared &&
>  	    ((!IS_NOSEC(inode) || *extend || !overwrite ||
> -	     (unaligned_io && *unwritten)))) {
> +	     (unaligned_io && unwritten)))) {
>  		if (iocb->ki_flags & IOCB_NOWAIT) {
>  			ret = -EAGAIN;
>  			goto out;
> @@ -481,7 +481,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>  			ret = -EAGAIN;
>  			goto out;
>  		}
> -		if (unaligned_io && (!overwrite || *unwritten))
> +		if (unaligned_io && (!overwrite || unwritten))
>  			inode_dio_wait(inode);
>  		*dio_flags = IOMAP_DIO_FORCE_WAIT;
>  	}
> @@ -506,7 +506,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  	loff_t offset = iocb->ki_pos;
>  	size_t count = iov_iter_count(from);
> -	bool extend = false, unwritten = false;
> +	bool extend = false;
>  	bool ilock_shared = true;
>  	int dio_flags = 0;
>  
> @@ -552,7 +552,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
>  
>  	ret = ext4_dio_write_checks(iocb, from, &ilock_shared, &extend,
> -				    &unwritten, &dio_flags);
> +				    &dio_flags);
>  	if (ret <= 0)
>  		return ret;
>  
> -- 
> 2.52.0
> 


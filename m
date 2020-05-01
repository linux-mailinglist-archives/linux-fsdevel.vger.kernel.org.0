Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B991C212E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 May 2020 01:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgEAXVD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 19:21:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgEAXVD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 19:21:03 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 041N2DA9054231;
        Fri, 1 May 2020 19:20:56 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30r5cnbt2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 19:20:55 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 041N3FlB056282;
        Fri, 1 May 2020 19:20:55 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30r5cnbt25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 19:20:55 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 041NJ7d5007458;
        Fri, 1 May 2020 23:20:53 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 30mcu7ytxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 23:20:53 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 041NKoTj35520586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 23:20:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0A94AE045;
        Fri,  1 May 2020 23:20:50 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD659AE04D;
        Fri,  1 May 2020 23:20:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.81.13])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 23:20:48 +0000 (GMT)
Subject: Re: [PATCH 02/11] ext4: fix fiemap size checks for bitmap files
To:     Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
References: <20200427181957.1606257-1-hch@lst.de>
 <20200427181957.1606257-3-hch@lst.de>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Sat, 2 May 2020 04:50:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200427181957.1606257-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200501232048.DD659AE04D@d06av26.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_17:2020-05-01,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010156
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/27/20 11:49 PM, Christoph Hellwig wrote:
> Add an extra validation of the len parameter, as for ext4 some files
> might have smaller file size limits than others.  This also means the
> redundant size check in ext4_ioctl_get_es_cache can go away, as all
> size checking is done in the shared fiemap handler.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>


Looks fine. Feel free to add
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
>   fs/ext4/extents.c | 31 +++++++++++++++++++++++++++++++
>   fs/ext4/ioctl.c   | 33 ++-------------------------------
>   2 files changed, 33 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index f2b577b315a09..2b4b94542e34d 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4832,6 +4832,28 @@ static const struct iomap_ops ext4_iomap_xattr_ops = {
>   	.iomap_begin		= ext4_iomap_xattr_begin,
>   };
>   
> +static int ext4_fiemap_check_ranges(struct inode *inode, u64 start, u64 *len)
> +{
> +	u64 maxbytes;
> +
> +	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> +		maxbytes = inode->i_sb->s_maxbytes;
> +	else
> +		maxbytes = EXT4_SB(inode->i_sb)->s_bitmap_maxbytes;
> +
> +	if (*len == 0)
> +		return -EINVAL;
> +	if (start > maxbytes)
> +		return -EFBIG;
> +
> +	/*
> +	 * Shrink request scope to what the fs can actually handle.
> +	 */
> +	if (*len > maxbytes || (maxbytes - *len) < start)
> +		*len = maxbytes - start;
> +	return 0;
> +}
> +
>   static int _ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   			__u64 start, __u64 len, bool from_es_cache)
>   {
> @@ -4852,6 +4874,15 @@ static int _ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   	if (fiemap_check_flags(fieinfo, ext4_fiemap_flags))
>   		return -EBADR;
>   
> +	/*
> +	 * For bitmap files the maximum size limit could be smaller than
> +	 * s_maxbytes, so check len here manually instead of just relying on the
> +	 * generic check.
> +	 */
> +	error = ext4_fiemap_check_ranges(inode, start, &len);
> +	if (error)
> +		return error;
> +
>   	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
>   		fieinfo->fi_flags &= ~FIEMAP_FLAG_XATTR;
>   		error = iomap_fiemap(inode, fieinfo, start, len,
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index bfc1281fc4cbc..0746532ba463d 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -733,29 +733,6 @@ static void ext4_fill_fsxattr(struct inode *inode, struct fsxattr *fa)
>   		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
>   }
>   
> -/* copied from fs/ioctl.c */
> -static int fiemap_check_ranges(struct super_block *sb,
> -			       u64 start, u64 len, u64 *new_len)
> -{
> -	u64 maxbytes = (u64) sb->s_maxbytes;
> -
> -	*new_len = len;
> -
> -	if (len == 0)
> -		return -EINVAL;
> -
> -	if (start > maxbytes)
> -		return -EFBIG;
> -
> -	/*
> -	 * Shrink request scope to what the fs can actually handle.
> -	 */
> -	if (len > maxbytes || (maxbytes - len) < start)
> -		*new_len = maxbytes - start;
> -
> -	return 0;
> -}
> -
>   /* So that the fiemap access checks can't overflow on 32 bit machines. */
>   #define FIEMAP_MAX_EXTENTS	(UINT_MAX / sizeof(struct fiemap_extent))
>   
> @@ -765,8 +742,6 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
>   	struct fiemap __user *ufiemap = (struct fiemap __user *) arg;
>   	struct fiemap_extent_info fieinfo = { 0, };
>   	struct inode *inode = file_inode(filp);
> -	struct super_block *sb = inode->i_sb;
> -	u64 len;
>   	int error;
>   
>   	if (copy_from_user(&fiemap, ufiemap, sizeof(fiemap)))
> @@ -775,11 +750,6 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
>   	if (fiemap.fm_extent_count > FIEMAP_MAX_EXTENTS)
>   		return -EINVAL;
>   
> -	error = fiemap_check_ranges(sb, fiemap.fm_start, fiemap.fm_length,
> -				    &len);
> -	if (error)
> -		return error;
> -
>   	fieinfo.fi_flags = fiemap.fm_flags;
>   	fieinfo.fi_extents_max = fiemap.fm_extent_count;
>   	fieinfo.fi_extents_start = ufiemap->fm_extents;
> @@ -792,7 +762,8 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
>   	if (fieinfo.fi_flags & FIEMAP_FLAG_SYNC)
>   		filemap_write_and_wait(inode->i_mapping);
>   
> -	error = ext4_get_es_cache(inode, &fieinfo, fiemap.fm_start, len);
> +	error = ext4_get_es_cache(inode, &fieinfo, fiemap.fm_start,
> +			fiemap.fm_length);
>   	fiemap.fm_flags = fieinfo.fi_flags;
>   	fiemap.fm_mapped_extents = fieinfo.fi_extents_mapped;
>   	if (copy_to_user(ufiemap, &fiemap, sizeof(fiemap)))
> 

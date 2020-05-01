Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFB71C2131
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 May 2020 01:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgEAXVd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 19:21:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgEAXVd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 19:21:33 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 041N2DED054211;
        Fri, 1 May 2020 19:21:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30r5cnbteu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 19:21:26 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 041N2JU0054564;
        Fri, 1 May 2020 19:21:25 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30r5cnbte5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 19:21:25 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 041NHr6W022363;
        Fri, 1 May 2020 23:21:23 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 30mcu5bvkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 23:21:23 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 041NKCuF328358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 23:20:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8010EAE051;
        Fri,  1 May 2020 23:21:21 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C57A5AE045;
        Fri,  1 May 2020 23:21:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.81.13])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 23:21:19 +0000 (GMT)
Subject: Re: [PATCH 03/11] ext4: split _ext4_fiemap
To:     Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
References: <20200427181957.1606257-1-hch@lst.de>
 <20200427181957.1606257-4-hch@lst.de>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Sat, 2 May 2020 04:51:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200427181957.1606257-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200501232119.C57A5AE045@d06av26.portsmouth.uk.ibm.com>
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
> The fiemap and EXT4_IOC_GET_ES_CACHE cases share almost no code, so split
> them into entirely separate functions.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks fine. Feel free to add
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

> ---
>   fs/ext4/extents.c | 72 +++++++++++++++++++++++------------------------
>   1 file changed, 35 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 2b4b94542e34d..d2a2a3ba5c44a 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4854,11 +4854,9 @@ static int ext4_fiemap_check_ranges(struct inode *inode, u64 start, u64 *len)
>   	return 0;
>   }
>   
> -static int _ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -			__u64 start, __u64 len, bool from_es_cache)
> +int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> +		u64 start, u64 len)
>   {
> -	ext4_lblk_t start_blk;
> -	u32 ext4_fiemap_flags = FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR;
>   	int error = 0;
>   
>   	if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
> @@ -4868,10 +4866,7 @@ static int _ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   		fieinfo->fi_flags &= ~FIEMAP_FLAG_CACHE;
>   	}
>   
> -	if (from_es_cache)
> -		ext4_fiemap_flags &= FIEMAP_FLAG_XATTR;
> -
> -	if (fiemap_check_flags(fieinfo, ext4_fiemap_flags))
> +	if (fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR))
>   		return -EBADR;
>   
>   	/*
> @@ -4885,40 +4880,20 @@ static int _ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   
>   	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
>   		fieinfo->fi_flags &= ~FIEMAP_FLAG_XATTR;
> -		error = iomap_fiemap(inode, fieinfo, start, len,
> -				     &ext4_iomap_xattr_ops);
> -	} else if (!from_es_cache) {
> -		error = iomap_fiemap(inode, fieinfo, start, len,
> -				     &ext4_iomap_report_ops);
> -	} else {
> -		ext4_lblk_t len_blks;
> -		__u64 last_blk;
> -
> -		start_blk = start >> inode->i_sb->s_blocksize_bits;
> -		last_blk = (start + len - 1) >> inode->i_sb->s_blocksize_bits;
> -		if (last_blk >= EXT_MAX_BLOCKS)
> -			last_blk = EXT_MAX_BLOCKS-1;
> -		len_blks = ((ext4_lblk_t) last_blk) - start_blk + 1;
> -
> -		/*
> -		 * Walk the extent tree gathering extent information
> -		 * and pushing extents back to the user.
> -		 */
> -		error = ext4_fill_es_cache_info(inode, start_blk, len_blks,
> -						fieinfo);
> +		return iomap_fiemap(inode, fieinfo, start, len,
> +				    &ext4_iomap_xattr_ops);
>   	}
> -	return error;
> -}
>   
> -int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -		__u64 start, __u64 len)
> -{
> -	return _ext4_fiemap(inode, fieinfo, start, len, false);
> +	return iomap_fiemap(inode, fieinfo, start, len, &ext4_iomap_report_ops);
>   }
>   
>   int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   		      __u64 start, __u64 len)
>   {
> +	ext4_lblk_t start_blk, len_blks;
> +	__u64 last_blk;
> +	int error = 0;
> +
>   	if (ext4_has_inline_data(inode)) {
>   		int has_inline;
>   
> @@ -4929,9 +4904,32 @@ int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   			return 0;
>   	}
>   
> -	return _ext4_fiemap(inode, fieinfo, start, len, true);
> -}
> +	if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
> +		error = ext4_ext_precache(inode);
> +		if (error)
> +			return error;
> +		fieinfo->fi_flags &= ~FIEMAP_FLAG_CACHE;
> +	}
> +
> +	if (fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC))
> +		return -EBADR;
>   
> +	error = ext4_fiemap_check_ranges(inode, start, &len);
> +	if (error)
> +		return error;
> +
> +	start_blk = start >> inode->i_sb->s_blocksize_bits;
> +	last_blk = (start + len - 1) >> inode->i_sb->s_blocksize_bits;
> +	if (last_blk >= EXT_MAX_BLOCKS)
> +		last_blk = EXT_MAX_BLOCKS-1;
> +	len_blks = ((ext4_lblk_t) last_blk) - start_blk + 1;
> +
> +	/*
> +	 * Walk the extent tree gathering extent information
> +	 * and pushing extents back to the user.
> +	 */
> +	return ext4_fill_es_cache_info(inode, start_blk, len_blks, fieinfo);
> +}
>   
>   /*
>    * ext4_access_path:
> 

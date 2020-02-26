Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4691703DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 17:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgBZQMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 11:12:15 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33744 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgBZQMP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:12:15 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QFvgLT033929;
        Wed, 26 Feb 2020 16:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=YbNJsmUfsUEFD7d1eHTqn0q9n5eOHlz7ui0y6YtuBSw=;
 b=yhoB3k401XDyuuzpsmgcCT/31wyF+4Ft6MtDXBtAU17nlN6GpLFpJQKJeYLqWAoy1kv3
 cNX8p4C3jMsyA+MqzRoMx7ViG6rhPUKFm3MrJLRT8NOzqhaLa9rYLDNn20jkXLjBPVAS
 W/un4eIkSJ30lsBgcFPhi3l/mR3Im05HdRjSPdHdRrxKwFFvYoaVAwsKr+tKlW/kVnFc
 sUv+MV/pbJpG36JmouaeSuJWmhCsxRj6ikP4O0uHqJgh8/tUeEwzTHWn2fI5LAsRA/iC
 GLvEIpWp1WgZ0o9KbDy9DFMIO3FRXw6HSXfn8dNeaPHgmePR17/PNeTkM+O464iJESoc Hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2ydcsrmpge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 16:11:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QFuiV7098734;
        Wed, 26 Feb 2020 16:11:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2ydcsa4xkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 16:11:58 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01QGBqmK026431;
        Wed, 26 Feb 2020 16:11:52 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Feb 2020 08:11:52 -0800
Date:   Wed, 26 Feb 2020 08:11:50 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, cmaiolino@redhat.com
Subject: Re: [PATCHv3 4/6] ext4: Make ext4_ind_map_blocks work with fiemap
Message-ID: <20200226161150.GA8036@magnolia>
References: <cover.1582702693.git.riteshh@linux.ibm.com>
 <56fc8d3802c578d27d49270600946a0737cef119.1582702694.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56fc8d3802c578d27d49270600946a0737cef119.1582702694.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260111
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 03:27:06PM +0530, Ritesh Harjani wrote:
> For indirect block mapping if the i_block > max supported block in inode
> then ext4_ind_map_blocks may return a -EIO error. But in case of fiemap
> this could be a valid query to ext4_map_blocks.
> So in case if !create then return 0. This also makes ext4_warning to
> ext4_debug in ext4_block_to_path() for the same reason.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/ext4/indirect.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
> index 3a4ab70fe9e0..e1ab495dd900 100644
> --- a/fs/ext4/indirect.c
> +++ b/fs/ext4/indirect.c
> @@ -102,7 +102,11 @@ static int ext4_block_to_path(struct inode *inode,
>  		offsets[n++] = i_block & (ptrs - 1);
>  		final = ptrs;
>  	} else {
> -		ext4_warning(inode->i_sb, "block %lu > max in inode %lu",
> +		/*
> +		 * It's not yet an error to just query beyond max
> +		 * block in inode. Fiemap callers may do so.
> +		 */
> +		ext4_debug("block %lu > max in inode %lu",
>  			     i_block + direct_blocks +
>  			     indirect_blocks + double_blocks, inode->i_ino);

Does that mean fiemap callers can spamflood dmesg with this message just
by setting the query start range to a huge value?

--D

>  	}
> @@ -537,8 +541,11 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
>  	depth = ext4_block_to_path(inode, map->m_lblk, offsets,
>  				   &blocks_to_boundary);
>  
> -	if (depth == 0)
> +	if (depth == 0) {
> +		if (!(flags & EXT4_GET_BLOCKS_CREATE))
> +			err = 0;
>  		goto out;
> +	}
>  
>  	partial = ext4_get_branch(inode, depth, offsets, chain, &err);
>  
> -- 
> 2.21.0
> 

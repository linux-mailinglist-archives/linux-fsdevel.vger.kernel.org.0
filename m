Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60A30E122D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 08:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387528AbfJWGcE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 02:32:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbfJWGcE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:32:04 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9N6LqkK146521
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 02:32:03 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vtdb4xgc1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 02:32:02 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 23 Oct 2019 07:32:00 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Oct 2019 07:31:56 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9N6VNt437093822
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 06:31:23 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADB254C052;
        Wed, 23 Oct 2019 06:31:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEE024C050;
        Wed, 23 Oct 2019 06:31:52 +0000 (GMT)
Received: from [9.199.158.207] (unknown [9.199.158.207])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Oct 2019 06:31:52 +0000 (GMT)
Subject: Re: [PATCH v5 01/12] ext4: move set iomap routines into separate
 helper ext4_set_iomap()
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <7dd1a1a895fd7e55c659b10bba16976faab4cd85.1571647178.git.mbobrowski@mbobrowski.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 23 Oct 2019 12:01:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <7dd1a1a895fd7e55c659b10bba16976faab4cd85.1571647178.git.mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102306-0028-0000-0000-000003ADDE40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102306-0029-0000-0000-000024700B42
Message-Id: <20191023063152.EEE024C050@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910230062
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/21/19 2:47 PM, Matthew Bobrowski wrote:
> Separate the iomap field population chunk of code that is currently
> within ext4_iomap_begin() into a new helper called
> ext4_set_iomap(). The intent of this function is self explanatory,
> however the rationale behind doing so is to also reduce the overall
> clutter that we currently have within the ext4_iomap_begin() callback.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

Could you please re-arrange patch sequence in this fashion.

1. Patch-11 (re-ordering of unwritten flags)
2. Patch-8 (trylock in IOCB_NOWAIT cases)
3. Patch-2 (should explain offset & len in this patch)
4. Patch-1 (this patch).

This is so that some of these are anyway fixes or refactoring
which can be picked up easily, either for backporting or
sometimes this helps in getting some of the patches in, if the patch
series gets bigger.
Also others (like me) can also pick some of these changes then to meet
their dependency. :)


This patch looks good to me. You may add:

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>



> ---
>   fs/ext4/inode.c | 59 +++++++++++++++++++++++++++----------------------
>   1 file changed, 33 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 516faa280ced..158eea9a1944 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3406,10 +3406,39 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
>   	return inode->i_state & I_DIRTY_DATASYNC;
>   }
>   
> +static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
> +			   struct ext4_map_blocks *map, loff_t offset,
> +			   loff_t length)
> +{
> +	u8 blkbits = inode->i_blkbits;
> +
> +	iomap->flags = 0;
> +	if (ext4_inode_datasync_dirty(inode))
> +		iomap->flags |= IOMAP_F_DIRTY;
> +
> +	if (map->m_flags & EXT4_MAP_NEW)
> +		iomap->flags |= IOMAP_F_NEW;
> +
> +	iomap->bdev = inode->i_sb->s_bdev;
> +	iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
> +	iomap->offset = (u64) map->m_lblk << blkbits;
> +	iomap->length = (u64) map->m_len << blkbits;
> +
> +	if (map->m_flags & (EXT4_MAP_MAPPED | EXT4_MAP_UNWRITTEN)) {
> +		if (map->m_flags & EXT4_MAP_MAPPED)
> +			iomap->type = IOMAP_MAPPED;
> +		else if (map->m_flags & EXT4_MAP_UNWRITTEN)
> +			iomap->type = IOMAP_UNWRITTEN;
> +		iomap->addr = (u64) map->m_pblk << blkbits;
> +	} else {
> +		iomap->type = IOMAP_HOLE;
> +		iomap->addr = IOMAP_NULL_ADDR;
> +	}
> +}
> +
>   static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   			    unsigned flags, struct iomap *iomap)
>   {
> -	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>   	unsigned int blkbits = inode->i_blkbits;
>   	unsigned long first_block, last_block;
>   	struct ext4_map_blocks map;
> @@ -3523,31 +3552,9 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   			return ret;
>   	}
>   
> -	iomap->flags = 0;
> -	if (ext4_inode_datasync_dirty(inode))
> -		iomap->flags |= IOMAP_F_DIRTY;
> -	iomap->bdev = inode->i_sb->s_bdev;
> -	iomap->dax_dev = sbi->s_daxdev;
> -	iomap->offset = (u64)first_block << blkbits;
> -	iomap->length = (u64)map.m_len << blkbits;
> -
> -	if (ret == 0) {
> -		iomap->type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
> -		iomap->addr = IOMAP_NULL_ADDR;
> -	} else {
> -		if (map.m_flags & EXT4_MAP_MAPPED) {
> -			iomap->type = IOMAP_MAPPED;
> -		} else if (map.m_flags & EXT4_MAP_UNWRITTEN) {
> -			iomap->type = IOMAP_UNWRITTEN;
> -		} else {
> -			WARN_ON_ONCE(1);
> -			return -EIO;
> -		}
> -		iomap->addr = (u64)map.m_pblk << blkbits;
> -	}
> -
> -	if (map.m_flags & EXT4_MAP_NEW)
> -		iomap->flags |= IOMAP_F_NEW;
> +	ext4_set_iomap(inode, iomap, &map, offset, length);
> +	if (delalloc && iomap->type == IOMAP_HOLE)
> +		iomap->type = IOMAP_DELALLOC;
>   
>   	return 0;
>   }
> 


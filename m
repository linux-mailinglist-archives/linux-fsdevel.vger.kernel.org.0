Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7E60D06FE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 08:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfJIGDn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 02:03:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726698AbfJIGDn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:03:43 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9963d1i133307
        for <linux-fsdevel@vger.kernel.org>; Wed, 9 Oct 2019 02:03:41 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vh86c2ys3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2019 02:03:40 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 9 Oct 2019 07:03:02 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Oct 2019 07:02:58 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9962vpf29098128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Oct 2019 06:02:57 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A510242054;
        Wed,  9 Oct 2019 06:02:57 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8055742049;
        Wed,  9 Oct 2019 06:02:55 +0000 (GMT)
Received: from [9.199.159.72] (unknown [9.199.159.72])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Oct 2019 06:02:55 +0000 (GMT)
Subject: Re: [PATCH v4 1/8] ext4: move out iomap field population into
 separate helper
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <8b4499e47bea3841194850e1b3eeb924d87e69a5.1570100361.git.mbobrowski@mbobrowski.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 9 Oct 2019 11:32:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8b4499e47bea3841194850e1b3eeb924d87e69a5.1570100361.git.mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100906-4275-0000-0000-0000037057C5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100906-4276-0000-0000-000038835A8C
Message-Id: <20191009060255.8055742049@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-09_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=894 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910090056
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some minor comments apart from Jan comments.

On 10/3/19 5:03 PM, Matthew Bobrowski wrote:
> Separate the iomap field population chunk into a separate simple
> helper routine. This helps reducing the overall clutter within the
> ext4_iomap_begin() callback, especially as we move across more code to
> make use of iomap infrastructure.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> ---
>   fs/ext4/inode.c | 65 ++++++++++++++++++++++++++++---------------------
>   1 file changed, 37 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 516faa280ced..1ccdc14c4d69 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3406,10 +3406,43 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
>   	return inode->i_state & I_DIRTY_DATASYNC;
>   }
> 
> +static int ext4_set_iomap(struct inode *inode, struct iomap *iomap, u16 type,
> +			  unsigned long first_block, struct ext4_map_blocks *map)

Line beyond 80 chars. Please check with checkpatch once.

We can also get rid of "first_block" argument here.
Also the "type" argument also looks confusing.
Please see comment on patch 3.


> +{
> +	u8 blkbits = inode->i_blkbits;
> +
> +	iomap->flags = 0;
> +	if (ext4_inode_datasync_dirty(inode))
> +		iomap->flags |= IOMAP_F_DIRTY;
> +	iomap->bdev = inode->i_sb->s_bdev;
> +	iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
> +	iomap->offset = (u64) first_block << blkbits;
> +	iomap->length = (u64) map->m_len << blkbits;
> +
> +	if (type) {
> +		iomap->type = type;
> +		iomap->addr = IOMAP_NULL_ADDR;
> +	} else {
> +		if (map->m_flags & EXT4_MAP_MAPPED) {
> +			iomap->type = IOMAP_MAPPED;
> +		} else if (map->m_flags & EXT4_MAP_UNWRITTEN) {
> +			iomap->type = IOMAP_UNWRITTEN;
> +		} else {
> +			WARN_ON_ONCE(1);
> +			return -EIO;
> +		}
> +		iomap->addr = (u64) map->m_pblk << blkbits;
> +	}
> +
> +	if (map->m_flags & EXT4_MAP_NEW)
> +		iomap->flags |= IOMAP_F_NEW;
> +	return 0;
> +}
> +
>   static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   			    unsigned flags, struct iomap *iomap)
>   {
> -	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +	u16 type = 0;
>   	unsigned int blkbits = inode->i_blkbits;
>   	unsigned long first_block, last_block;
>   	struct ext4_map_blocks map;
> @@ -3523,33 +3556,9 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
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
> -
> -	return 0;
> +	if (!ret)
> +		type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
> +	return ext4_set_iomap(inode, iomap, type, first_block, &map);
>   }
> 
>   static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
> 


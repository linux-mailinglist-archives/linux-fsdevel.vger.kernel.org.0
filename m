Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD047D071E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 08:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfJIGWx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 02:22:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726651AbfJIGWx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:22:53 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x996MJ4b126842
        for <linux-fsdevel@vger.kernel.org>; Wed, 9 Oct 2019 02:22:52 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vha7c00wm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2019 02:22:51 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 9 Oct 2019 07:22:49 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Oct 2019 07:22:45 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x996MiSp43123170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Oct 2019 06:22:44 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C42842049;
        Wed,  9 Oct 2019 06:22:44 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87D244204B;
        Wed,  9 Oct 2019 06:22:42 +0000 (GMT)
Received: from [9.199.159.72] (unknown [9.199.159.72])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Oct 2019 06:22:42 +0000 (GMT)
Subject: Re: [PATCH v4 2/8] ext4: move out IOMAP_WRITE path into separate
 helper
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <99b317af0f20a170fba2e70695d7cca1597fb19a.1570100361.git.mbobrowski@mbobrowski.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 9 Oct 2019 11:52:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <99b317af0f20a170fba2e70695d7cca1597fb19a.1570100361.git.mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100906-0016-0000-0000-000002B65809
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100906-0017-0000-0000-000033175CDC
Message-Id: <20191009062242.87D244204B@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-09_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910090058
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/3/19 5:03 PM, Matthew Bobrowski wrote:
> In preparation for porting across the direct I/O path to iomap, split
> out the IOMAP_WRITE logic into a separate helper. This way, we don't
> need to clutter the ext4_iomap_begin() callback.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

Minor comment, but otherwise.
Patch looks good to me. You may add:

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
>   fs/ext4/inode.c | 110 ++++++++++++++++++++++++++----------------------
>   1 file changed, 60 insertions(+), 50 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 1ccdc14c4d69..caeb3dec0dec 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3439,6 +3439,62 @@ static int ext4_set_iomap(struct inode *inode, struct iomap *iomap, u16 type,
>   	return 0;
>   }
> 
> +static int ext4_iomap_alloc(struct inode *inode,
> +			    unsigned flags,
> +			    unsigned long first_block,
> +			    struct ext4_map_blocks *map)
> +{
> +	handle_t *handle;
> +	u8 blkbits = inode->i_blkbits;
> +	int ret, dio_credits, retries = 0;
> +
> +	/*
> +	 * Trim mapping request to the maximum value that we can map
> +	 * at once for direct I/O.
> +	 */
> +	if (map->m_len > DIO_MAX_BLOCKS)
> +		map->m_len = DIO_MAX_BLOCKS;
> +	dio_credits = ext4_chunk_trans_blocks(inode, map->m_len);
> +retry:
> +	/*
> +	 * Either we allocate blocks and then we don't get unwritten
> +	 * extent so we have reserved enough credits, or the blocks
> +	 * are already allocated and unwritten. In that case, the
> +	 * extent conversion fits in the credits as well.
> +	 */
> +	handle = ext4_journal_start(inode, EXT4_HT_MAP_BLOCKS, dio_credits);
> +	if (IS_ERR(handle))
> +		return PTR_ERR(handle);
> +
> +	ret = ext4_map_blocks(handle, inode, map, EXT4_GET_BLOCKS_CREATE_ZERO);
> +	if (ret < 0)
> +		goto journal_stop;
> +
> +	/*
> +	 * If we have allocated blocks beyond the EOF, we need to make
> +	 * sure that they get truncate if we crash before updating the
> +	 * inode size metadata in ext4_iomap_end(). For faults, we
> +	 * don't need to do that (and cannot due to the orphan list
> +	 * operations needing an inode_lock()). If we happen to
> +	 * instantiate blocks beyond EOF, it is because we race with a
> +	 * truncate operation, which already has added the inode onto
> +	 * the orphan list.
> +	 */
> +	if (!(flags & IOMAP_FAULT) && first_block + map->m_len >
> +	    (i_size_read(inode) + (1 << blkbits) - 1) >> blkbits) {
> +		int err;
> +
> +		err = ext4_orphan_add(handle, inode);
> +		if (err < 0)
> +			ret = err;
> +	}
> +journal_stop:
> +	ext4_journal_stop(handle);
> +	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
> +		goto retry;
> +	return ret;
> +}
> +
>   static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   			    unsigned flags, struct iomap *iomap)
>   {
> @@ -3500,62 +3556,16 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   			}
>   		}
>   	} else if (flags & IOMAP_WRITE) {
> -		int dio_credits;
> -		handle_t *handle;
> -		int retries = 0;
> -
> -		/* Trim mapping request to maximum we can map at once for DIO */
> -		if (map.m_len > DIO_MAX_BLOCKS)
> -			map.m_len = DIO_MAX_BLOCKS;
> -		dio_credits = ext4_chunk_trans_blocks(inode, map.m_len);
> -retry:
> -		/*
> -		 * Either we allocate blocks and then we don't get unwritten
> -		 * extent so we have reserved enough credits, or the blocks
> -		 * are already allocated and unwritten and in that case
> -		 * extent conversion fits in the credits as well.
> -		 */
> -		handle = ext4_journal_start(inode, EXT4_HT_MAP_BLOCKS,
> -					    dio_credits);
> -		if (IS_ERR(handle))
> -			return PTR_ERR(handle);
> -
> -		ret = ext4_map_blocks(handle, inode, &map,
> -				      EXT4_GET_BLOCKS_CREATE_ZERO);
> -		if (ret < 0) {
> -			ext4_journal_stop(handle);
> -			if (ret == -ENOSPC &&
> -			    ext4_should_retry_alloc(inode->i_sb, &retries))
> -				goto retry;
> -			return ret;
> -		}
> -
> -		/*
> -		 * If we added blocks beyond i_size, we need to make sure they
> -		 * will get truncated if we crash before updating i_size in
> -		 * ext4_iomap_end(). For faults we don't need to do that (and
> -		 * even cannot because for orphan list operations inode_lock is
> -		 * required) - if we happen to instantiate block beyond i_size,
> -		 * it is because we race with truncate which has already added
> -		 * the inode to the orphan list.
> -		 */
> -		if (!(flags & IOMAP_FAULT) && first_block + map.m_len >
> -		    (i_size_read(inode) + (1 << blkbits) - 1) >> blkbits) {
> -			int err;
> -
> -			err = ext4_orphan_add(handle, inode);
> -			if (err < 0) {
> -				ext4_journal_stop(handle);
> -				return err;
> -			}
> -		}
> -		ext4_journal_stop(handle);
> +		ret = ext4_iomap_alloc(inode, flags, first_block, &map);

We don't need "first_block" argument here. Since
map->m_lblk saves first_block directly above in the same function.

No strong objection against ext4_iomap_alloc, but
maybe ext4_iomap_map_write sounds better?
Either way is fine though.


>   	} else {
>   		ret = ext4_map_blocks(NULL, inode, &map, 0);
>   		if (ret < 0)
>   			return ret;
>   	}
> 
> +	if (ret < 0)
> +		return ret;
> +
>   	if (!ret)
>   		type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
>   	return ext4_set_iomap(inode, iomap, type, first_block, &map);
> 


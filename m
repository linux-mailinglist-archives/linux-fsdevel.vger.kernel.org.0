Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA8BE1235
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 08:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbfJWGh2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 02:37:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34264 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730146AbfJWGh2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:37:28 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9N6b34D117934
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 02:37:27 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vtfgx3khx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 02:37:26 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 23 Oct 2019 07:37:24 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Oct 2019 07:37:21 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9N6bLnR34406512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 06:37:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDEDA4C04A;
        Wed, 23 Oct 2019 06:37:20 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F3B34C046;
        Wed, 23 Oct 2019 06:37:17 +0000 (GMT)
Received: from [9.199.158.207] (unknown [9.199.158.207])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Oct 2019 06:37:17 +0000 (GMT)
Subject: Re: [PATCH v5 03/12] ext4: split IOMAP_WRITE branch in
 ext4_iomap_begin() into helper
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <80f6c773a80a731c5c1f5e4d8ebb75d6da58a587.1571647179.git.mbobrowski@mbobrowski.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 23 Oct 2019 12:07:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <80f6c773a80a731c5c1f5e4d8ebb75d6da58a587.1571647179.git.mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102306-0012-0000-0000-0000035BE43C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102306-0013-0000-0000-000021971179
Message-Id: <20191023063717.8F3B34C046@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910230064
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/21/19 2:48 PM, Matthew Bobrowski wrote:
> In preparation for porting across the ext4 direct I/O path for reads
> and writes over to the iomap infrastructure, split up the IOMAP_WRITE
> chunk of code into a separate helper ext4_alloc_iomap(). This way,
> when we add the necessary bits for direct I/O, we don't end up with
> ext4_iomap_begin() becoming a behemoth twisty maze.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

Patch looks good to me. You may add:

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
>   fs/ext4/inode.c | 112 ++++++++++++++++++++++++++----------------------
>   1 file changed, 60 insertions(+), 52 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 0dd29ae5cc8c..3dc92bd8a944 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3442,6 +3442,62 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
>   	}
>   }
>   
> +static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
> +			    unsigned int flags)
> +{
> +	handle_t *handle;
> +	u8 blkbits = inode->i_blkbits;
> +	int ret, dio_credits, retries = 0;
> +
> +	/*
> +	 * Trim the mapping request to the maximum value that we can map at
> +	 * once for direct I/O.
> +	 */
> +	if (map->m_len > DIO_MAX_BLOCKS)
> +		map->m_len = DIO_MAX_BLOCKS;
> +	dio_credits = ext4_chunk_trans_blocks(inode, map->m_len);
> +
> +retry:
> +	/*
> +	 * Either we allocate blocks and then don't get an unwritten extent, so
> +	 * in that case we have reserved enough credits. Or, the blocks are
> +	 * already allocated and and unwritten. In that case, the extent
> +	 * conversion fits into the credits too.
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
> +	 * If we have allocated blocks beyond EOF, we need to ensure that
> +	 * they're truncated if we crash before updating the inode size
> +	 * metadata within ext4_iomap_end(). For faults, we don't need to do
> +	 * that (and cannot due to the orphan list operations needing an
> +	 * inode_lock()). If we happen to instantiate blocks beyond EOF, it is
> +	 * because we race with a truncate operation, which already has added
> +	 * the inode onto the orphan list.
> +	 */
> +	if (!(flags & IOMAP_FAULT) && map->m_lblk + map->m_len >
> +	    (i_size_read(inode) + (1 << blkbits) - 1) >> blkbits) {
> +		int err;
> +
> +		err = ext4_orphan_add(handle, inode);
> +		if (err < 0)
> +			ret = err;
> +	}
> +
> +journal_stop:
> +	ext4_journal_stop(handle);
> +	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
> +		goto retry;
> +
> +	return ret;
> +}
> +
>   static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   			    unsigned flags, struct iomap *iomap)
>   {
> @@ -3502,62 +3558,14 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
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
> +		ret = ext4_iomap_alloc(inode, &map, flags);
>   	} else {
>   		ret = ext4_map_blocks(NULL, inode, &map, 0);
> -		if (ret < 0)
> -			return ret;
>   	}
>   
> +	if (ret < 0)
> +		return ret;
> +
>   	ext4_set_iomap(inode, iomap, &map, offset, length);
>   	if (delalloc && iomap->type == IOMAP_HOLE)
>   		iomap->type = IOMAP_DELALLOC;
> 


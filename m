Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0D7D073A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 08:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfJIGae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 02:30:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726698AbfJIGad (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:30:33 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x996S1CJ141413
        for <linux-fsdevel@vger.kernel.org>; Wed, 9 Oct 2019 02:30:32 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vha4cg9gb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2019 02:30:31 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 9 Oct 2019 07:30:29 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Oct 2019 07:30:27 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x996UQ2h35651954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Oct 2019 06:30:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F12B4204C;
        Wed,  9 Oct 2019 06:30:26 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E332942047;
        Wed,  9 Oct 2019 06:30:23 +0000 (GMT)
Received: from [9.199.159.72] (unknown [9.199.159.72])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Oct 2019 06:30:23 +0000 (GMT)
Subject: Re: [PATCH v4 6/8] ext4: move inode extension checks out from
 ext4_iomap_alloc()
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <d1ca9cc472175760ef629fb66a88f0c9b0625052.1570100361.git.mbobrowski@mbobrowski.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 9 Oct 2019 12:00:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d1ca9cc472175760ef629fb66a88f0c9b0625052.1570100361.git.mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100906-0020-0000-0000-000003775960
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100906-0021-0000-0000-000021CD5DE6
Message-Id: <20191009063023.E332942047@d06av24.portsmouth.uk.ibm.com>
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



On 10/3/19 5:04 PM, Matthew Bobrowski wrote:
> We lift the inode extension/orphan list handling logic out from
> ext4_iomap_alloc() and place it within the caller
> ext4_dax_write_iter().
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

This looks good. Should solve our previous lengthy discussion
about orphan handling :)

You may add:
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
>   fs/ext4/file.c  | 17 +++++++++++++++++
>   fs/ext4/inode.c | 22 ----------------------
>   2 files changed, 17 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 2883711e8a33..f64da0c590b2 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -309,6 +309,7 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	ssize_t ret;
>   	size_t count;
>   	loff_t offset;
> +	handle_t *handle;
>   	struct inode *inode = file_inode(iocb->ki_filp);
> 
>   	if (!inode_trylock(inode)) {
> @@ -328,6 +329,22 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
> 
>   	offset = iocb->ki_pos;
>   	count = iov_iter_count(from);
> +
> +	if (offset + count > EXT4_I(inode)->i_disksize) {
> +		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> +		if (IS_ERR(handle)) {
> +			ret = PTR_ERR(handle);
> +			goto out;
> +		}
> +
> +		ret = ext4_orphan_add(handle, inode);
> +		if (ret) {
> +			ext4_journal_stop(handle);
> +			goto out;
> +		}
> +		ext4_journal_stop(handle);
> +	}
> +
>   	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
> 
>   	error = ext4_handle_inode_extension(inode, offset, ret, count);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d616062b603e..e133dda55063 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3508,7 +3508,6 @@ static int ext4_iomap_alloc(struct inode *inode,
>   			    struct ext4_map_blocks *map)
>   {
>   	handle_t *handle;
> -	u8 blkbits = inode->i_blkbits;
>   	int ret, dio_credits, retries = 0;
> 
>   	/*
> @@ -3530,28 +3529,7 @@ static int ext4_iomap_alloc(struct inode *inode,
>   		return PTR_ERR(handle);
> 
>   	ret = ext4_map_blocks(handle, inode, map, EXT4_GET_BLOCKS_CREATE_ZERO);
> -	if (ret < 0)
> -		goto journal_stop;
> 
> -	/*
> -	 * If we have allocated blocks beyond the EOF, we need to make
> -	 * sure that they get truncate if we crash before updating the
> -	 * inode size metadata in ext4_iomap_end(). For faults, we
> -	 * don't need to do that (and cannot due to the orphan list
> -	 * operations needing an inode_lock()). If we happen to
> -	 * instantiate blocks beyond EOF, it is because we race with a
> -	 * truncate operation, which already has added the inode onto
> -	 * the orphan list.
> -	 */
> -	if (!(flags & IOMAP_FAULT) && first_block + map->m_len >
> -	    (i_size_read(inode) + (1 << blkbits) - 1) >> blkbits) {
> -		int err;
> -
> -		err = ext4_orphan_add(handle, inode);
> -		if (err < 0)
> -			ret = err;
> -	}
> -journal_stop:
>   	ext4_journal_stop(handle);
>   	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
>   		goto retry;
> 


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B161B450E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 14:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgDVM0R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 08:26:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26588 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725810AbgDVM0R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:26:17 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MC96Wj193774
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2020 08:26:16 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gmubj7jf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2020 08:26:16 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 22 Apr 2020 13:25:21 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Apr 2020 13:25:17 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03MCQ9bL56426552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Apr 2020 12:26:09 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AEA4AE05D;
        Wed, 22 Apr 2020 12:26:09 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E552AAE045;
        Wed, 22 Apr 2020 12:26:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.60.18])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Apr 2020 12:26:06 +0000 (GMT)
Subject: Re: [PATCHv2 1/1] ext4: Fix overflow case for map.m_len in
 ext4_iomap_begin_*
To:     linux-ext4@vger.kernel.org
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        darrick.wong@oracle.com, hch@infradead.org,
        linux-fsdevel@vger.kernel.org,
        syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
References: <1a2dc8f198e1225ddd40833de76b60c7ee20d22d.1587024137.git.riteshh@linux.ibm.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 22 Apr 2020 17:56:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1a2dc8f198e1225ddd40833de76b60c7ee20d22d.1587024137.git.riteshh@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20042212-0020-0000-0000-000003CC83D6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042212-0021-0000-0000-000022257FC2
Message-Id: <20200422122606.E552AAE045@d06av26.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_03:2020-04-22,2020-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=1 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220093
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NACK on this patch.

Even though this fixes syzcaller reproducer, still it seems the right
fix should be:-
1. To make EXT4_MAX_LOGICAL_BLOCK to 0xfffffffe
2. And also add fiemap_check_ranges() call in overlayfs.
This is because fiemap_check_ranges() takes care of truncating the
length parameter to max sb->s_maxbytes which underlying filesystem can
handle. This will be similar to how VFS calls for fiemap on underlying
FS.

Currently running xfstests on patches which implements above logic.

-ritesh

On 4/17/20 12:22 AM, Ritesh Harjani wrote:
> EXT4_MAX_LOGICAL_BLOCK - map.m_lblk + 1 in case when
> map.m_lblk (offset) is 0 could overflow an unsigned int
> and become 0.
> 
> Fix this.
> 
> Fixes: d3b6f23f7167 ("ext4: move ext4_fiemap to use iomap framework")
> Reported-and-tested-by: syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
> @Jan,
> I retained your Reviewed by, since there was no logic change, but just couple
> of minor change - missed semicolon and tab space issue.
> 
>   fs/ext4/inode.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e416096fc081..d9feaaad8ab8 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3424,6 +3424,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   	int ret;
>   	struct ext4_map_blocks map;
>   	u8 blkbits = inode->i_blkbits;
> +	loff_t len;
>   
>   	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
>   		return -EINVAL;
> @@ -3435,8 +3436,11 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   	 * Calculate the first and last logical blocks respectively.
>   	 */
>   	map.m_lblk = offset >> blkbits;
> -	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
> -			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
> +	len = min_t(loff_t, (offset + length - 1) >> blkbits,
> +		    EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
> +	if (len > EXT4_MAX_LOGICAL_BLOCK)
> +		len = EXT4_MAX_LOGICAL_BLOCK;
> +	map.m_len = len;
>   
>   	if (flags & IOMAP_WRITE)
>   		ret = ext4_iomap_alloc(inode, &map, flags);
> @@ -3524,6 +3528,7 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
>   	bool delalloc = false;
>   	struct ext4_map_blocks map;
>   	u8 blkbits = inode->i_blkbits;
> +	loff_t len;
>   
>   	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
>   		return -EINVAL;
> @@ -3541,8 +3546,11 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
>   	 * Calculate the first and last logical block respectively.
>   	 */
>   	map.m_lblk = offset >> blkbits;
> -	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
> -			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
> +	len = min_t(loff_t, (offset + length - 1) >> blkbits,
> +		    EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
> +	if (len > EXT4_MAX_LOGICAL_BLOCK)
> +		len = EXT4_MAX_LOGICAL_BLOCK;
> +	map.m_len = len;
>   
>   	/*
>   	 * Fiemap callers may call for offset beyond s_bitmap_maxbytes.
> 


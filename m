Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5EDAD4E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 10:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389179AbfIIIau (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 04:30:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbfIIIau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:30:50 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x898GlBG088854
        for <linux-fsdevel@vger.kernel.org>; Mon, 9 Sep 2019 04:30:49 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uwh1jxbfk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2019 04:30:49 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 9 Sep 2019 09:30:46 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Sep 2019 09:30:43 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x898UgbR24641664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Sep 2019 08:30:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 877864204F;
        Mon,  9 Sep 2019 08:30:42 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8126B4204B;
        Mon,  9 Sep 2019 08:30:40 +0000 (GMT)
Received: from [9.199.158.183] (unknown [9.199.158.183])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Sep 2019 08:30:40 +0000 (GMT)
Subject: Re: [PATCH v2 4/6] ext4: reorder map.m_flags checks in
 ext4_iomap_begin()
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
References: <cover.1567978633.git.mbobrowski@mbobrowski.org>
 <38c2c1dd6f62f82e485b1a767ddeb49606439d67.1567978633.git.mbobrowski@mbobrowski.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Mon, 9 Sep 2019 14:00:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <38c2c1dd6f62f82e485b1a767ddeb49606439d67.1567978633.git.mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19090908-0020-0000-0000-00000369AB63
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090908-0021-0000-0000-000021BF2B17
Message-Id: <20190909083040.8126B4204B@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=622 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909090090
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/9/19 4:49 AM, Matthew Bobrowski wrote:
> For iomap direct IO write code path changes, we need to accommodate
> for the case where the block mapping flags passed to ext4_map_blocks()
> will result in m_flags having both EXT4_MAP_MAPPED and
> EXT4_MAP_UNWRITTEN bits set. In order for the allocated unwritten
> extents to be converted properly in the end_io handler, iomap->type
> must be set to IOMAP_UNWRITTEN, so we need to reshuffle the
> conditional statement in order to achieve this.
> 
> This change is a no-op for DAX code path as the block mapping flag
> passed to ext4_map_blocks() when IS_DAX(inode) never results in
> EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN being set at once.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

Looks good to me.

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
>   fs/ext4/inode.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 761ce6286b05..efb184928e51 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3581,10 +3581,21 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   		iomap->type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
>   		iomap->addr = IOMAP_NULL_ADDR;
>   	} else {
> -		if (map.m_flags & EXT4_MAP_MAPPED) {
> -			iomap->type = IOMAP_MAPPED;
> -		} else if (map.m_flags & EXT4_MAP_UNWRITTEN) {
> +		/*
> +		 * Flags passed to ext4_map_blocks() for direct IO
> +		 * writes can result in m_flags having both
> +		 * EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN bits set. In
> +		 * order for allocated unwritten extents to be
> +		 * converted to written extents in the end_io handler
> +		 * correctly, we need to ensure that the iomap->type
> +		 * is also set appropriately in that case. Thus, we
> +		 * need to check whether EXT4_MAP_UNWRITTEN is set
> +		 * first.
> +		 */
> +		if (map.m_flags & EXT4_MAP_UNWRITTEN) {
>   			iomap->type = IOMAP_UNWRITTEN;
> +		} else if (map.m_flags & EXT4_MAP_MAPPED) {
> +			iomap->type = IOMAP_MAPPED;
>   		} else {
>   			WARN_ON_ONCE(1);
>   			return -EIO;
> 


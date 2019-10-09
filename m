Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32334D0747
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 08:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfJIGgA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 02:36:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727572AbfJIGgA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:36:00 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x996VZ5V015263
        for <linux-fsdevel@vger.kernel.org>; Wed, 9 Oct 2019 02:35:59 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vh7t0vnab-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2019 02:35:58 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 9 Oct 2019 07:35:56 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Oct 2019 07:35:53 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x996Zq6l55705712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Oct 2019 06:35:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8261C42041;
        Wed,  9 Oct 2019 06:35:52 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90C434203F;
        Wed,  9 Oct 2019 06:35:48 +0000 (GMT)
Received: from [9.199.159.72] (unknown [9.199.159.72])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Oct 2019 06:35:48 +0000 (GMT)
Subject: Re: [PATCH v4 7/8] ext4: reorder map.m_flags checks in
 ext4_set_iomap()
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <3551610e53aa1984210a4de04ad6e1a89f5bf0a3.1570100361.git.mbobrowski@mbobrowski.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 9 Oct 2019 12:05:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <3551610e53aa1984210a4de04ad6e1a89f5bf0a3.1570100361.git.mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100906-0020-0000-0000-0000037759C9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100906-0021-0000-0000-000021CD5E74
Message-Id: <20191009063548.90C434203F@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-09_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=756 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910090059
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/3/19 5:04 PM, Matthew Bobrowski wrote:
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

You may be changing the function parameters & name here,
(in ext4_set_iomap)
But functionality wise the patch looks good to me.

You may add:
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
>   fs/ext4/inode.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e133dda55063..63ad23ae05b8 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3420,10 +3420,20 @@ static int ext4_set_iomap(struct inode *inode, struct iomap *iomap, u16 type,
>   		iomap->type = type;
>   		iomap->addr = IOMAP_NULL_ADDR;
>   	} else {
> -		if (map->m_flags & EXT4_MAP_MAPPED) {
> -			iomap->type = IOMAP_MAPPED;
> -		} else if (map->m_flags & EXT4_MAP_UNWRITTEN) {
> +		/*
> +		 * Flags passed to ext4_map_blocks() for direct I/O
> +		 * writes can result in map->m_flags having both
> +		 * EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN bits set. In
> +		 * order for allocated extents to be converted to
> +		 * written extents in the ->end_io handler correctly,
> +		 * we need to ensure that the iomap->type is set
> +		 * approprately. Thus, we need to check whether
> +		 * EXT4_MAP_UNWRITTEN is set first.
> +		 */
> +		if (map->m_flags & EXT4_MAP_UNWRITTEN) {
>   			iomap->type = IOMAP_UNWRITTEN;
> +		} else if (map->m_flags & EXT4_MAP_MAPPED) {
> +			iomap->type = IOMAP_MAPPED;
>   		} else {
>   			WARN_ON_ONCE(1);
>   			return -EIO;
> 


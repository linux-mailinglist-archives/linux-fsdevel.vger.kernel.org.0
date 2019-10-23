Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 209CCE1232
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 08:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbfJWGgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 02:36:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725874AbfJWGgI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:36:08 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9N6WHn8095120
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 02:36:07 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vthcjrn3p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 02:36:07 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 23 Oct 2019 07:36:05 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Oct 2019 07:36:01 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9N6ZSGj20709866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 06:35:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 940304C046;
        Wed, 23 Oct 2019 06:36:00 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21C964C050;
        Wed, 23 Oct 2019 06:35:57 +0000 (GMT)
Received: from [9.199.158.207] (unknown [9.199.158.207])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Oct 2019 06:35:56 +0000 (GMT)
Subject: Re: [PATCH v5 02/12] ext4: iomap that extends beyond EOF should be
 marked dirty
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <995387be9841bde2151c85880555c18bec68a641.1571647179.git.mbobrowski@mbobrowski.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 23 Oct 2019 12:05:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <995387be9841bde2151c85880555c18bec68a641.1571647179.git.mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102306-0008-0000-0000-00000325E0A7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102306-0009-0000-0000-00004A450ECE
Message-Id: <20191023063557.21C964C050@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910230063
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/21/19 2:47 PM, Matthew Bobrowski wrote:
> This patch is effectively addressed what Dave Chinner had found and
> fixed within this commit: 8a23414ee345. Justification for needing this
> modification has been provided below:
Not sure if this is a valid commit id. I couldn't find it.


> 
> When doing a direct IO that spans the current EOF, and there are
> written blocks beyond EOF that extend beyond the current write, the
> only metadata update that needs to be done is a file size extension.
> 
> However, we don't mark such iomaps as IOMAP_F_DIRTY to indicate that
> there is IO completion metadata updates required, and hence we may
> fail to correctly sync file size extensions made in IO completion when
> O_DSYNC writes are being used and the hardware supports FUA.
> 
> Hence when setting IOMAP_F_DIRTY, we need to also take into account
> whether the iomap spans the current EOF. If it does, then we need to
> mark it dirty so that IO completion will call generic_write_sync() to
> flush the inode size update to stable storage correctly.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>


Otherwise, this patch looks good to me. You may add:

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>



> ---
>   fs/ext4/inode.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 158eea9a1944..0dd29ae5cc8c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3412,8 +3412,14 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
>   {
>   	u8 blkbits = inode->i_blkbits;
>   
> +	/*
> +	 * Writes that span EOF might trigger an I/O size update on completion,
> +	 * so consider them to be dirty for the purposes of O_DSYNC, even if
> +	 * there is no other metadata changes being made or are pending here.
> +	 */
>   	iomap->flags = 0;
> -	if (ext4_inode_datasync_dirty(inode))
> +	if (ext4_inode_datasync_dirty(inode) ||
> +	    offset + length > i_size_read(inode))
>   		iomap->flags |= IOMAP_F_DIRTY;
>   
>   	if (map->m_flags & EXT4_MAP_NEW)
> 


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10D0017565D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 09:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgCBI6v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 03:58:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727084AbgCBI6u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:58:50 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0228nbxx129802
        for <linux-fsdevel@vger.kernel.org>; Mon, 2 Mar 2020 03:58:50 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfk5kjpj1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2020 03:58:50 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 2 Mar 2020 08:58:47 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Mar 2020 08:58:43 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0228whT560096580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Mar 2020 08:58:43 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E07ECA4051;
        Mon,  2 Mar 2020 08:58:42 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A41E3A4053;
        Mon,  2 Mar 2020 08:58:40 +0000 (GMT)
Received: from [9.199.158.200] (unknown [9.199.158.200])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Mar 2020 08:58:40 +0000 (GMT)
Subject: Re: [PATCHv5 3/6] ext4: Move ext4 bmap to use iomap infrastructure.
To:     "Darrick J. Wong" <darrick.wong@oracle.com>, jack@suse.cz
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, cmaiolino@redhat.com, david@fromorbit.com
References: <cover.1582880246.git.riteshh@linux.ibm.com>
 <8bbd53bd719d5ccfecafcce93f2bf1d7955a44af.1582880246.git.riteshh@linux.ibm.com>
 <20200228152524.GE8036@magnolia>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Mon, 2 Mar 2020 14:28:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200228152524.GE8036@magnolia>
Content-Type: multipart/mixed;
 boundary="------------6BD3087F7CA8EB3CC5202732"
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20030208-0008-0000-0000-000003584BD9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030208-0009-0000-0000-00004A79768E
Message-Id: <20200302085840.A41E3A4053@d06av23.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_02:2020-02-28,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=920 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020069
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6BD3087F7CA8EB3CC5202732
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/28/20 8:55 PM, Darrick J. Wong wrote:
> On Fri, Feb 28, 2020 at 02:56:56PM +0530, Ritesh Harjani wrote:
>> ext4_iomap_begin is already implemented which provides ext4_map_blocks,
>> so just move the API from generic_block_bmap to iomap_bmap for iomap
>> conversion.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> ---
>>   fs/ext4/inode.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 6cf3b969dc86..81fccbae0aea 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -3214,7 +3214,7 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
>>   			return 0;
>>   	}
>>   
>> -	return generic_block_bmap(mapping, block, ext4_get_block);
>> +	return iomap_bmap(mapping, block, &ext4_iomap_ops);
> 
> /me notes that iomap_bmap will filemap_write_and_wait for you, so one
> could optimize ext4_bmap to avoid the double-flush by moving the
> filemap_write_and_wait at the top of the function into the JDATA state
> clearing block.

IIUC, delalloc and data=journal mode are both mutually exclusive.
So we could get rid of calling filemap_write_and_wait() all together
from ext4_bmap().
And as you pointed filemap_write_and_wait() is called by default in
iomap_bmap which should cover for delalloc case.


@Jan/Darrick,
Could you check if the attached patch looks good. If yes then
will add your Reviewed-by and send a v6.

Thanks for the review!!

-ritesh



--------------6BD3087F7CA8EB3CC5202732
Content-Type: text/x-patch;
 name="0001-ext4-Move-ext4-bmap-to-use-iomap-infrastructure.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ext4-Move-ext4-bmap-to-use-iomap-infrastructure.patch"

From 93f560d9a483b4f389056e543012d0941734a8f4 Mon Sep 17 00:00:00 2001
From: Ritesh Harjani <riteshh@linux.ibm.com>
Date: Tue, 20 Aug 2019 18:36:33 +0530
Subject: [PATCH 3/6] ext4: Move ext4 bmap to use iomap infrastructure.

ext4_iomap_begin is already implemented which provides ext4_map_blocks,
so just move the API from generic_block_bmap to iomap_bmap for iomap
conversion.

Also no need to call for filemap_write_and_wait() any more in ext4_bmap
since data=journal mode anyway doesn't support delalloc and for all other
cases iomap_bmap() anyway calls the same function, so no need for doing
it twice.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/inode.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 6cf3b969dc86..fac8adbbb3f6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3174,16 +3174,6 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
 	if (ext4_has_inline_data(inode))
 		return 0;
 
-	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) &&
-			test_opt(inode->i_sb, DELALLOC)) {
-		/*
-		 * With delalloc we want to sync the file
-		 * so that we can make sure we allocate
-		 * blocks for file
-		 */
-		filemap_write_and_wait(mapping);
-	}
-
 	if (EXT4_JOURNAL(inode) &&
 	    ext4_test_inode_state(inode, EXT4_STATE_JDATA)) {
 		/*
@@ -3214,7 +3204,7 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
 			return 0;
 	}
 
-	return generic_block_bmap(mapping, block, ext4_get_block);
+	return iomap_bmap(mapping, block, &ext4_iomap_ops);
 }
 
 static int ext4_readpage(struct file *file, struct page *page)
-- 
2.21.0


--------------6BD3087F7CA8EB3CC5202732--


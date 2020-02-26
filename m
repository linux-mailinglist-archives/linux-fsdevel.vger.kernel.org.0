Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A4F16FF41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 13:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgBZMrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 07:47:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18030 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726525AbgBZMrb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:47:31 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01QCigQP077490
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2020 07:47:30 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydq6gvc1b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2020 07:47:30 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 26 Feb 2020 12:47:27 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Feb 2020 12:47:24 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01QClOpU65798308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 12:47:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9BC952051;
        Wed, 26 Feb 2020 12:47:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.58.45])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 278C852050;
        Wed, 26 Feb 2020 12:47:21 +0000 (GMT)
Subject: Re: [PATCHv3 4/6] ext4: Make ext4_ind_map_blocks work with fiemap
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, hch@infradead.org, cmaiolino@redhat.com
References: <cover.1582702693.git.riteshh@linux.ibm.com>
 <56fc8d3802c578d27d49270600946a0737cef119.1582702694.git.riteshh@linux.ibm.com>
 <20200226123940.GP10728@quack2.suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 26 Feb 2020 18:17:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200226123940.GP10728@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022612-0020-0000-0000-000003ADC29D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022612-0021-0000-0000-00002205DD71
Message-Id: <20200226124722.278C852050@d06av21.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_04:2020-02-26,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 mlxlogscore=907
 clxscore=1015 priorityscore=1501 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260095
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/26/20 6:09 PM, Jan Kara wrote:
> On Wed 26-02-20 15:27:06, Ritesh Harjani wrote:
>> For indirect block mapping if the i_block > max supported block in inode
>> then ext4_ind_map_blocks may return a -EIO error. But in case of fiemap
>> this could be a valid query to ext4_map_blocks.
>> So in case if !create then return 0. This also makes ext4_warning to
>> ext4_debug in ext4_block_to_path() for the same reason.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> 
> Hmm, won't it be cleaner to just handle this in ext4_iomap_begin_report()?
> We do trim map.m_len there anyway so it is only logical to trim it to
> proper value supported by the inode on-disk format... BTW, note we have
> sbi->s_bitmap_maxbytes value already computed in the superblock...

hmm. Yes, thanks for the pointers. Let me check this again.

-ritesh


> 
> 								Honza
> 
>> ---
>>   fs/ext4/indirect.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
>> index 3a4ab70fe9e0..e1ab495dd900 100644
>> --- a/fs/ext4/indirect.c
>> +++ b/fs/ext4/indirect.c
>> @@ -102,7 +102,11 @@ static int ext4_block_to_path(struct inode *inode,
>>   		offsets[n++] = i_block & (ptrs - 1);
>>   		final = ptrs;
>>   	} else {
>> -		ext4_warning(inode->i_sb, "block %lu > max in inode %lu",
>> +		/*
>> +		 * It's not yet an error to just query beyond max
>> +		 * block in inode. Fiemap callers may do so.
>> +		 */
>> +		ext4_debug("block %lu > max in inode %lu",
>>   			     i_block + direct_blocks +
>>   			     indirect_blocks + double_blocks, inode->i_ino);
>>   	}
>> @@ -537,8 +541,11 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
>>   	depth = ext4_block_to_path(inode, map->m_lblk, offsets,
>>   				   &blocks_to_boundary);
>>   
>> -	if (depth == 0)
>> +	if (depth == 0) {
>> +		if (!(flags & EXT4_GET_BLOCKS_CREATE))
>> +			err = 0;
>>   		goto out;
>> +	}
>>   
>>   	partial = ext4_get_branch(inode, depth, offsets, chain, &err);
>>   
>> -- 
>> 2.21.0
>>


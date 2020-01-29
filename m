Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C02014C66C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 07:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgA2GTu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 01:19:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10142 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725966AbgA2GTu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 01:19:50 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00T68WpY021649
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2020 01:19:48 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xtmmwyx82-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2020 01:19:48 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 29 Jan 2020 06:19:46 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Jan 2020 06:19:42 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00T6JfBP54722726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 06:19:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4505A11C058;
        Wed, 29 Jan 2020 06:19:41 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61BFF11C04C;
        Wed, 29 Jan 2020 06:19:39 +0000 (GMT)
Received: from [9.199.159.131] (unknown [9.199.159.131])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 29 Jan 2020 06:19:38 +0000 (GMT)
Subject: Re: [RFCv2 4/4] ext4: Move ext4_fiemap to use iomap infrastructure
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, cmaiolino@redhat.com
References: <cover.1580121790.git.riteshh@linux.ibm.com>
 <0147a2923d339bdef5802dde8d5019d719f0d796.1580121790.git.riteshh@linux.ibm.com>
 <20200128152830.GA3673284@magnolia>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 29 Jan 2020 11:49:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200128152830.GA3673284@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20012906-0016-0000-0000-000002E1A29F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012906-0017-0000-0000-000033446736
Message-Id: <20200129061939.61BFF11C04C@d06av25.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_09:2020-01-28,2020-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1911200001 definitions=main-2001290050
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Darrick,

On 1/28/20 8:58 PM, Darrick J. Wong wrote:
> On Tue, Jan 28, 2020 at 03:48:28PM +0530, Ritesh Harjani wrote:
>> Since ext4 already defines necessary iomap_ops required to move to iomap
>> for fiemap, so this patch makes those changes to use existing iomap_ops
>> for ext4_fiemap and thus removes all unwanted code.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>> ---
>>   fs/ext4/extents.c | 279 +++++++---------------------------------------
>>   fs/ext4/inline.c  |  41 -------
>>   2 files changed, 38 insertions(+), 282 deletions(-)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index 0de548bb3c90..901caee2fcb1 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
> 
> <snip> Just a cursory glance...
> 
>> @@ -5130,40 +4927,42 @@ static int ext4_xattr_fiemap(struct inode *inode,
>>   				EXT4_I(inode)->i_extra_isize;
>>   		physical += offset;
>>   		length = EXT4_SB(inode->i_sb)->s_inode_size - offset;
>> -		flags |= FIEMAP_EXTENT_DATA_INLINE;
>>   		brelse(iloc.bh);
>>   	} else { /* external block */
>>   		physical = (__u64)EXT4_I(inode)->i_file_acl << blockbits;
>>   		length = inode->i_sb->s_blocksize;
>>   	}
>>   
>> -	if (physical)
>> -		error = fiemap_fill_next_extent(fieinfo, 0, physical,
>> -						length, flags);
>> -	return (error < 0 ? error : 0);
>> +	iomap->addr = physical;
>> +	iomap->offset = 0;
>> +	iomap->length = length;
>> +	iomap->type = IOMAP_INLINE;
>> +	iomap->flags = 0;
> 
> Er... external "ACL" blocks aren't IOMAP_INLINE.

Sorry, I should have mentioned about this too in the cover letter.
So current patchset is mainly only converting bmap & fiemap to use iomap 
APIs. Even the original implementation does not have external ACL block
implemented for xattr_fiemap.

Let me spend some time to implement it. But I would still like to keep
that as a separate patch.

But thanks for looking into it. There's this point 2.a & 2.b mentioned 
in the cover letter where I could really use your help in understanding
if all of that is a known behavior from iomap_fiemap side
(whenever you have some time of course :) )

-ritesh


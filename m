Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 466A914D41B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 00:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgA2XyY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 18:54:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10030 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726401AbgA2XyY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 18:54:24 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00TNnMCW077880
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2020 18:54:22 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xttnu82fp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2020 18:54:22 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 29 Jan 2020 23:54:20 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Jan 2020 23:54:18 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00TNsHS423658672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 23:54:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72E32A404D;
        Wed, 29 Jan 2020 23:54:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96EBCA4051;
        Wed, 29 Jan 2020 23:54:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.92.238])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 29 Jan 2020 23:54:15 +0000 (GMT)
Subject: Re: [RFCv2 4/4] ext4: Move ext4_fiemap to use iomap infrastructure
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, cmaiolino@redhat.com
References: <cover.1580121790.git.riteshh@linux.ibm.com>
 <0147a2923d339bdef5802dde8d5019d719f0d796.1580121790.git.riteshh@linux.ibm.com>
 <20200128152830.GA3673284@magnolia>
 <20200129061939.61BFF11C04C@d06av25.portsmouth.uk.ibm.com>
 <20200129161839.GA3674276@magnolia>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 30 Jan 2020 05:24:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200129161839.GA3674276@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20012923-0020-0000-0000-000003A533C4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012923-0021-0000-0000-000021FCE685
Message-Id: <20200129235415.96EBCA4051@d06av23.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-29_08:2020-01-28,2020-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=922 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001290185
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/29/20 9:48 PM, Darrick J. Wong wrote:
> On Wed, Jan 29, 2020 at 11:49:38AM +0530, Ritesh Harjani wrote:
>> Hello Darrick,
>>
>> On 1/28/20 8:58 PM, Darrick J. Wong wrote:
>>> On Tue, Jan 28, 2020 at 03:48:28PM +0530, Ritesh Harjani wrote:
>>>> Since ext4 already defines necessary iomap_ops required to move to iomap
>>>> for fiemap, so this patch makes those changes to use existing iomap_ops
>>>> for ext4_fiemap and thus removes all unwanted code.
>>>>
>>>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>>>> ---
>>>>    fs/ext4/extents.c | 279 +++++++---------------------------------------
>>>>    fs/ext4/inline.c  |  41 -------
>>>>    2 files changed, 38 insertions(+), 282 deletions(-)
>>>>
>>>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>>>> index 0de548bb3c90..901caee2fcb1 100644
>>>> --- a/fs/ext4/extents.c
>>>> +++ b/fs/ext4/extents.c
>>>
>>> <snip> Just a cursory glance...
>>>
>>>> @@ -5130,40 +4927,42 @@ static int ext4_xattr_fiemap(struct inode *inode,
>>>>    				EXT4_I(inode)->i_extra_isize;
>>>>    		physical += offset;
>>>>    		length = EXT4_SB(inode->i_sb)->s_inode_size - offset;
>>>> -		flags |= FIEMAP_EXTENT_DATA_INLINE;
>>>>    		brelse(iloc.bh);
>>>>    	} else { /* external block */
>>>>    		physical = (__u64)EXT4_I(inode)->i_file_acl << blockbits;
>>>>    		length = inode->i_sb->s_blocksize;
>>>>    	}
>>>> -	if (physical)
>>>> -		error = fiemap_fill_next_extent(fieinfo, 0, physical,
>>>> -						length, flags);
>>>> -	return (error < 0 ? error : 0);
>>>> +	iomap->addr = physical;
>>>> +	iomap->offset = 0;
>>>> +	iomap->length = length;
>>>> +	iomap->type = IOMAP_INLINE;
>>>> +	iomap->flags = 0;
>>>
>>> Er... external "ACL" blocks aren't IOMAP_INLINE.
>>
>> Sorry, I should have mentioned about this too in the cover letter.
>> So current patchset is mainly only converting bmap & fiemap to use iomap
>> APIs. Even the original implementation does not have external ACL block
>> implemented for xattr_fiemap.
> 
> Er ... yes it did.  The "} else { /* external block */" block sets
> physical to i_file_acl.

Oops.. my bad. I got it confused with EA inode feature.
Urghh... I should remove my bias while looking at a review comment.

so I think for i_file_acl (external block) we should set
iomap->type = IOMAP_MAPPED.

Will fix this and submit in the same thread. Thanks for catching it.

> 
>> Let me spend some time to implement it. But I would still like to keep
>> that as a separate patch.
>>
>> But thanks for looking into it. There's this point 2.a & 2.b mentioned in
>> the cover letter where I could really use your help in understanding
>> if all of that is a known behavior from iomap_fiemap side
>> (whenever you have some time of course :) )
> 
> i'll go have a look.

Thanks.


> 
> --D
> 
>> -ritesh
>>


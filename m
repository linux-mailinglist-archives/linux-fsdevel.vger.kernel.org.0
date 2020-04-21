Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAAA1B1D8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 06:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgDUEZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 00:25:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbgDUEZH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 00:25:07 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03L43HGE135227
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2020 00:25:06 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30gc2wpqbr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2020 00:25:06 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 21 Apr 2020 05:24:30 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Apr 2020 05:24:26 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03L4OxeF20447430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 04:24:59 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD1324C04A;
        Tue, 21 Apr 2020 04:24:59 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40BB74C046;
        Tue, 21 Apr 2020 04:24:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.92.243])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Apr 2020 04:24:58 +0000 (GMT)
Subject: Re: [RFCv2 1/1] ext4: Fix race in ext4 mb discard group
 preallocations
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, sandeen@sandeen.net
References: <cover.1586954511.git.riteshh@linux.ibm.com>
 <533ac1f5b19c520b08f8c99aec5baf8729185714.1586954511.git.riteshh@linux.ibm.com>
 <20200420143807.GE17130@quack2.suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 21 Apr 2020 09:54:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200420143807.GE17130@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20042104-0008-0000-0000-000003747F6C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042104-0009-0000-0000-00004A964389
Message-Id: <20200421042458.40BB74C046@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_09:2020-04-20,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=2 bulkscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004210033
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Jan,

Thanks for your email.

On 4/20/20 8:08 PM, Jan Kara wrote:
> On Wed 15-04-20 22:53:01, Ritesh Harjani wrote:
>> There could be a race in function ext4_mb_discard_group_preallocations()
>> where the 1st thread may iterate through group's bb_prealloc_list and
>> remove all the PAs and add to function's local list head.
>> Now if the 2nd thread comes in to discard the group preallocations,
>> it will see that the group->bb_prealloc_list is empty and will return 0.
>>
>> Consider for a case where we have less number of groups (for e.g. just group 0),
>> this may even return an -ENOSPC error from ext4_mb_new_blocks()
>> (where we call for ext4_mb_discard_group_preallocations()).
>> But that is wrong, since 2nd thread should have waited for 1st thread to release
>> all the PAs and should have retried for allocation. Since 1st thread
>> was anyway going to discard the PAs.
>>
>> This patch fixes this race by introducing two paths (fastpath and
>> slowpath). We first try the fastpath via
>> ext4_mb_discard_preallocations(). So if any of the group's PA list is
>> empty then instead of waiting on the group_lock we continue to discard
>> other group's PA. This could help maintain the parallelism in trying to
>> discard multiple group's PA list. So if at the end some process is
>> not able to find any freed block, then we retry freeing all of the
>> groups PA list while holding the group_lock. And in case if the PA list
>> is empty, then we try return grp->bb_free which should tell us
>> whether there are any free blocks in the given group or not to make any
>> forward progress.
>>
>> Suggested-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> 
> Ritesh, do you still want to push this patch as is or do you plan to change
> it after a discussion on Thursday?

I would need more time on this. I will get back on this, once I do some
study to see how your suggested approach works out.

-ritesh


> 
>> @@ -3967,9 +3986,15 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
>>   		goto repeat;
>>   	}
>>   
>> -	/* found anything to free? */
>> +	/*
>> +	 * If this list is empty, then return the grp->bb_free. As someone
>> +	 * else may have freed the PAs and updated grp->bb_free.
>> +	 */
>>   	if (list_empty(&list)) {
>>   		BUG_ON(free != 0);
>> +		mb_debug(1, "Someone may have freed PA for this group %u, grp->bb_free %d\n",
>> +			 group, grp->bb_free);
>> +		free = grp->bb_free;
>>   		goto out;
>>   	}
> 
> I'm still somewhat concerned about the forward progress guarantee here...
> If you're convinced the allocation from goal is the only possibility of
> lockup and that logic can be removed, then please remove it and then write a
> good comment why lockup is not possible due to this.
> 
>> @@ -4464,17 +4492,39 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * ext4_mb_discard_preallocations: This function loop over each group's prealloc
>> + * list and try to free it. It may so happen that more than 1 process try to
>> + * call this function in parallel. That's why we initially take a fastpath
>> + * approach in which we first check if the grp->bb_prealloc_list is empty,
>> + * that could mean that, someone else may have removed all of it's PA and added
>> + * into it's local list. So we quickly return from there and try to discard
>> + * next group's PAs. This way we try to parallelize discarding of multiple group
>> + * PAs. But in case if any of the process is unfortunate to not able to free
>> + * any of group's PA, then we retry with slow path which will gurantee that
>> + * either some PAs will be made free or we will get group->bb_free blocks
>> + * (grp->bb_free if non-zero gurantees forward progress in ext4_mb_new_blocks())
>> + */
>>   static int ext4_mb_discard_preallocations(struct super_block *sb, int needed)
>>   {
>>   	ext4_group_t i, ngroups = ext4_get_groups_count(sb);
>>   	int ret;
>>   	int freed = 0;
>> +	bool fastpath = true;
>> +	int tmp_needed;
>>   
>> -	trace_ext4_mb_discard_preallocations(sb, needed);
>> -	for (i = 0; i < ngroups && needed > 0; i++) {
>> -		ret = ext4_mb_discard_group_preallocations(sb, i, needed);
>> +repeat:
>> +	tmp_needed = needed;
>> +	trace_ext4_mb_discard_preallocations(sb, tmp_needed);
>> +	for (i = 0; i < ngroups && tmp_needed > 0; i++) {
>> +		ret = ext4_mb_discard_group_preallocations(sb, i, tmp_needed,
>> +							   fastpath);
>>   		freed += ret;
>> -		needed -= ret;
>> +		tmp_needed -= ret;
>> +	}
> 
> Why do you need 'tmp_needed'? When freed is 0, tmp_needed == needed, right?
> 
>> +	if (!freed && fastpath) {
>> +		fastpath = false;
>> +		goto repeat;
>>   	}
> 
> 								Honza
> 


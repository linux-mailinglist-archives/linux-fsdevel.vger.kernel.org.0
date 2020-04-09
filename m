Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 474511A39EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 20:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgDISpx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 14:45:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19896 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726702AbgDISpx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:45:53 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 039IYA6x059589
        for <linux-fsdevel@vger.kernel.org>; Thu, 9 Apr 2020 14:45:53 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30920t195y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2020 14:45:52 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 9 Apr 2020 19:45:30 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Apr 2020 19:45:27 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 039IjlxI37617682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Apr 2020 18:45:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2430EA405D;
        Thu,  9 Apr 2020 18:45:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E0CBA4040;
        Thu,  9 Apr 2020 18:45:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.62.10])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Apr 2020 18:45:45 +0000 (GMT)
Subject: Re: [RFC 1/1] ext4: Fix race in
 ext4_mb_discard_group_preallocations()
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        sandeen@sandeen.net
References: <cover.1586358980.git.riteshh@linux.ibm.com>
 <2e231c371cc83357a6c9d55e4f7284f6c1fb1741.1586358980.git.riteshh@linux.ibm.com>
 <20200409133719.GA18960@quack2.suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri, 10 Apr 2020 00:15:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200409133719.GA18960@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20040918-0008-0000-0000-0000036DBAC2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040918-0009-0000-0000-00004A8F5E25
Message-Id: <20200409184545.7E0CBA4040@d06av23.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-09_06:2020-04-07,2020-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=2 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090131
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Jan,

Thanks for looking into this.

On 4/9/20 7:07 PM, Jan Kara wrote:
> Hello Ritesh!
> 
> On Wed 08-04-20 22:24:10, Ritesh Harjani wrote:
>> @@ -3908,16 +3919,13 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
>>   
>>   	mb_debug(1, "discard preallocation for group %u\n", group);
>>   
>> -	if (list_empty(&grp->bb_prealloc_list))
>> -		return 0;
>> -
> 
> OK, so ext4_mb_discard_preallocations() is now going to lock every group
> when we try to discard preallocations. That's likely going to increase lock
> contention on the group locks if we are running out of free blocks when
> there are multiple processes trying to allocate blocks. I guess we don't
> care about the performace of this case too deeply but I'm not sure if the
> cost won't be too big - probably we should check how much the CPU usage
> with multiple allocating process trying to find free blocks grows...

Sure let me check the cpu usage in my test case with this patch.
But either ways unless we take the lock we are not able to confirm
that what are no. of free blocks available in the filesystem, right?

This mostly will happen only when there are lot of threads and due to
all of their preallocations filesystem is running into low space and
hence
trying to discard all the preallocations. => so when FS is going low on 
space, isn't this cpu usage justifiable? (in an attempt to make sure we
don't fail with ENOSPC)?
Maybe not since this is only due to spinlock case, is it?

Or are you suggesting we should use some other method for discarding
all the group's PA. So that other threads could sleep while discard is 
happening. Something like a discard work item which should free up
all of the group's PA. But we need a way to determine if the needed
no of blocks were freed so that we wake up and retry the allocation.

(Darrick did mentioned something on this line related to work/workqueue,
but couldn't discuss much that time).


> 
>>   	bitmap_bh = ext4_read_block_bitmap(sb, group);
>>   	if (IS_ERR(bitmap_bh)) {
>>   		err = PTR_ERR(bitmap_bh);
>>   		ext4_set_errno(sb, -err);
>>   		ext4_error(sb, "Error %d reading block bitmap for %u",
>>   			   err, group);
>> -		return 0;
>> +		goto out_dbg;
>>   	}
>>   
>>   	err = ext4_mb_load_buddy(sb, group, &e4b);
>> @@ -3925,7 +3933,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
>>   		ext4_warning(sb, "Error %d loading buddy information for %u",
>>   			     err, group);
>>   		put_bh(bitmap_bh);
>> -		return 0;
>> +		goto out_dbg;
>>   	}
>>   
>>   	if (needed == 0)
>> @@ -3967,9 +3975,15 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
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
> OK, but this still doesn't reliably fix the problem, does it? Because > bb_free can be still zero and another process just has some extents 
to free
> in its local 'list' (e.g. because it has decided it doesn't have enough
> extents, some were busy and it decided to cond_resched()), so bb_free will
> increase from 0 only once these extents are freed.

This patch should reliably fix it, I think.
So even if say Process P1 didn't free all extents, since some of the
PAs were busy it decided to cond_resched(), that still means that the
list(bb_prealloc_list) is not empty and whoever will get the
ext4_lock_group() next will either
get the busy PAs or it will be blocked on this lock_group() until all of
the PAs were freed by processes.
So if you see we may never actually return 0, unless, there are no PAs 
and grp->bb_free is truely 0.

But your case does shows that grp->bb_free may not be the upper bound
of free blocks for this group. It could be just 1 PA's free blocks, 
while other PAs are still in some other process's local list (due to 
cond_reched())


> 
> Honestly, I don't understand why ext4_mb_discard_group_preallocations()
> bothers with the local 'list'. Why doesn't it simply free the preallocation

Let's see if someone else know about this. I am not really sure
why it was done this way.


> right away? And that would also basically fix your problem (well, it would
> still theoretically exist because there's still freeing of one extent
> potentially pending but I'm not sure if that will still be a practical
> issue).

I guess this still can be a problem. So let's say if the process P1
just checks that the list was not empty and then in parallel process P2
just deletes the last entry - then when process P1 iterates over the 
list, it will find it empty and return 0, which may return -ENOSPC failure.
unless we again take the group lock to check if the list is really free
and return grp->bb_free if it is.


-ritesh


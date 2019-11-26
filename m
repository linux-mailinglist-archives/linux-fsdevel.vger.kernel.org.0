Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECF0109C8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 11:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfKZKv3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 05:51:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727739AbfKZKv3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 05:51:29 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAQAlKNA117391
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2019 05:51:29 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wfk4688sj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2019 05:51:28 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 26 Nov 2019 10:51:26 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Nov 2019 10:51:24 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAQAojVQ32637362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 10:50:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D854DA405B;
        Tue, 26 Nov 2019 10:51:23 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75EC6A4060;
        Tue, 26 Nov 2019 10:51:22 +0000 (GMT)
Received: from [9.199.158.76] (unknown [9.199.158.76])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Nov 2019 10:51:21 +0000 (GMT)
Subject: Re: [RFCv3 4/4] ext4: Move to shared iolock even without
 dioread_nolock mount opt
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org
References: <20191120050024.11161-1-riteshh@linux.ibm.com>
 <20191120050024.11161-5-riteshh@linux.ibm.com>
 <20191120143257.GE9509@quack2.suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 26 Nov 2019 16:21:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191120143257.GE9509@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19112610-0028-0000-0000-000003C02577
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112610-0029-0000-0000-0000248326B9
Message-Id: <20191126105122.75EC6A4060@b06wcsmtp001.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-26_01:2019-11-26,2019-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911260099
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Jan,

Sorry about getting a little late on this.

On 11/20/19 8:02 PM, Jan Kara wrote:
> On Wed 20-11-19 10:30:24, Ritesh Harjani wrote:
>> We were using shared locking only in case of dioread_nolock
>> mount option in case of DIO overwrites. This mount condition
>> is not needed anymore with current code, since:-
>>
>> 1. No race between buffered writes & DIO overwrites.
>> Since buffIO writes takes exclusive locks & DIO overwrites
>> will take share locking. Also DIO path will make sure
>> to flush and wait for any dirty page cache data.
>>
>> 2. No race between buffered reads & DIO overwrites, since there
>> is no block allocation that is possible with DIO overwrites.
>> So no stale data exposure should happen. Same is the case
>> between DIO reads & DIO overwrites.
>>
>> 3. Also other paths like truncate is protected,
>> since we wait there for any DIO in flight to be over.
>>
>> 4. In case of buffIO writes followed by DIO reads:
>> Since here also we take exclusive locks in ext4_write_begin/end().
>> There is no risk of exposing any stale data in this case.
>> Since after ext4_write_end, iomap_dio_rw() will wait to flush &
>> wait for any dirty page cache data.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> 
> There's one more case to consider here as I mentioned in [1]. There can be

Yes, I should have mentioned about this in cover letter and about my
thoughts on that.
I was of the opinion that since the race is already existing
and it may not be caused due to this patch, so we should handle that in 
incremental fashion and as a separate patch series after this one.
Let me know your thoughts on above.

Also, I wanted to have some more discussions on this race before
making the changes.
But nevertheless, it's the right time to discuss those changes here.

> mmap write instantiating dirty page and then someone starting writeback
> against that page while DIO read is running still theoretically leading to
> stale data exposure. Now this patch does not have influence on that race
> but:

Yes, agreed.

> 
> 1) We need to close the race mentioned above. Maybe we could do that by
> proactively allocating unwritten blocks for a page being faulted when there
> is direct IO running against the file - the one who fills holes through
> mmap write while direct IO is running on the file deserves to suffer the
> performance penalty...

I was giving this a thought. So even if we try to penalize mmap
write as you mentioned above, what I am not sure about it, is that, how 
can we reliably detect that the DIO is in progress?

Say even if we try to check for atomic_read(&inode->i_dio_count) in mmap
ext4_page_mkwrite path, it cannot be reliable unless there is some sort 
of a lock protection, no?
Because after the check the DIO can still snoop in, right?


2. Also what about the delalloc opt. in that case? Even for delalloc
should we go ahead and allocate the unwritten blocks? That may even need
to start/stop the journal which could add more latency, no?


> 
> 2) After this patch there's no point in having dioread_nolock at all so we
> can just make that mount option no-op and drop all the precautions from the
> buffered IO path connected with dioread_nolock.

Yes, with some careful review we should be able to drop those
precautions related to dioread_nolock, after getting above race fixed.



> 
> [1] https://lore.kernel.org/linux-ext4/20190925092339.GB23277@quack2.suse.cz
> 
> 								Honza
> 
>> ---
>>   fs/ext4/file.c | 25 +++++++++++++++++++------
>>   1 file changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>> index 18cbf9fa52c6..b97efc89cd63 100644
>> --- a/fs/ext4/file.c
>> +++ b/fs/ext4/file.c
>> @@ -383,6 +383,17 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
>>   	.end_io = ext4_dio_write_end_io,
>>   };
>>   
>> +static bool ext4_dio_should_shared_lock(struct inode *inode)
>> +{
>> +	if (!S_ISREG(inode->i_mode))
> 
> This cannot happen for DIO so no point in checking here.
> 
>> +		return false;
>> +	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
> 
> Why this?
> 
>> +		return false;
>> +	if (ext4_should_journal_data(inode))
> 
> We don't do DIO when journalling data so no point in checking here
> (dio_supported() already checked this).
> 
> 								Honza
>> +		return false;
>> +	return true;
>> +}
>> +

Yes, agreed we don't need this function (ext4_dio_should_shared_lock)
anyways.


>>   /*
>>    * The intention here is to start with shared lock acquired then see if any
>>    * condition requires an exclusive inode lock. If yes, then we restart the
>> @@ -394,8 +405,8 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
>>    * - For extending writes case we don't take the shared lock, since it requires
>>    *   updating inode i_disksize and/or orphan handling with exclusive lock.
>>    *
>> - * - shared locking will only be true mostly in case of overwrites with
>> - *   dioread_nolock mode. Otherwise we will switch to excl. iolock mode.
>> + * - shared locking will only be true mostly in case of overwrites.
>> + *   Otherwise we will switch to excl. iolock mode.
>>    */
>>   static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>>   				 unsigned int *iolock, bool *unaligned_io,
>> @@ -433,15 +444,14 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>>   		*extend = true;
>>   	/*
>>   	 * Determine whether the IO operation will overwrite allocated
>> -	 * and initialized blocks. If so, check to see whether it is
>> -	 * possible to take the dioread_nolock path.
>> +	 * and initialized blocks.
>>   	 *
>>   	 * We need exclusive i_rwsem for changing security info
>>   	 * in file_modified().
>>   	 */
>>   	if (*iolock == EXT4_IOLOCK_SHARED &&
>>   	    (!IS_NOSEC(inode) || *unaligned_io || *extend ||
>> -	     !ext4_should_dioread_nolock(inode) ||
>> +	     !ext4_dio_should_shared_lock(inode) ||
>>   	     !ext4_overwrite_io(inode, offset, count))) {
>>   		ext4_iunlock(inode, *iolock);
>>   		*iolock = EXT4_IOLOCK_EXCL;
>> @@ -485,7 +495,10 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>   		iolock = EXT4_IOLOCK_EXCL;
>>   	}
>>   
>> -	if (iolock == EXT4_IOLOCK_SHARED && !ext4_should_dioread_nolock(inode))
>> +	/*
>> +	 * Check if we should continue with shared iolock
>> +	 */
>> +	if (iolock == EXT4_IOLOCK_SHARED && !ext4_dio_should_shared_lock(inode))
>>   		iolock = EXT4_IOLOCK_EXCL;
>>   
>>   	if (iocb->ki_flags & IOCB_NOWAIT) {
>> -- 
>> 2.21.0
>>


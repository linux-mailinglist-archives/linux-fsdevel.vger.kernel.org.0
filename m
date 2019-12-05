Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB1701141B1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 14:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfLENkQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 08:40:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18526 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729587AbfLENkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 08:40:16 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB5DdBl4053986
        for <linux-fsdevel@vger.kernel.org>; Thu, 5 Dec 2019 08:40:15 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wq1ky46hs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2019 08:40:15 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 5 Dec 2019 13:40:13 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Dec 2019 13:40:09 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB5De8ia46596288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Dec 2019 13:40:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B295D42041;
        Thu,  5 Dec 2019 13:40:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 605A44203F;
        Thu,  5 Dec 2019 13:40:07 +0000 (GMT)
Received: from [9.199.159.163] (unknown [9.199.159.163])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Dec 2019 13:40:07 +0000 (GMT)
Subject: Re: [PATCHv4 2/3] ext4: Start with shared i_rwsem in case of DIO
 instead of exclusive
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org,
        joseph.qi@linux.alibaba.com
References: <20191205064624.13419-1-riteshh@linux.ibm.com>
 <20191205064624.13419-3-riteshh@linux.ibm.com>
 <20191205120307.GA32639@quack2.suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 5 Dec 2019 19:10:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191205120307.GA32639@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19120513-0016-0000-0000-000002D1A2B5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120513-0017-0000-0000-00003333A792
Message-Id: <20191205134007.605A44203F@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_03:2019-12-04,2019-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912050114
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Jan,

Thanks a lot for your reviews.

On 12/5/19 5:33 PM, Jan Kara wrote:
> On Thu 05-12-19 12:16:23, Ritesh Harjani wrote:
>> Earlier there was no shared lock in DIO read path. But this patch
>> (16c54688592ce: ext4: Allow parallel DIO reads)
>> simplified some of the locking mechanism while still allowing for parallel DIO
>> reads by adding shared lock in inode DIO read path.
>>
>> But this created problem with mixed read/write workload. It is due to the fact
>> that in DIO path, we first start with exclusive lock and only when we determine
>> that it is a ovewrite IO, we downgrade the lock. This causes the problem, since
>> we still have shared locking in DIO reads.
>>
>> So, this patch tries to fix this issue by starting with shared lock and then
>> switching to exclusive lock only when required based on ext4_dio_write_checks().
>>
>> Other than that, it also simplifies below cases:-
>>
>> 1. Simplified ext4_unaligned_aio API to ext4_unaligned_io. Previous API was
>> abused in the sense that it was not really checking for AIO anywhere also it
>> used to check for extending writes. So this API was renamed and simplified to
>> ext4_unaligned_io() which actully only checks if the IO is really unaligned.
>>
>> Now, in case of unaligned direct IO, iomap_dio_rw needs to do zeroing of partial
>> block and that will require serialization against other direct IOs in the same
>> block. So we take a exclusive inode lock for any unaligned DIO. In case of AIO
>> we also need to wait for any outstanding IOs to complete so that conversion from
>> unwritten to written is completed before anyone try to map the overlapping block.
>> Hence we take exclusive inode lock and also wait for inode_dio_wait() for
>> unaligned DIO case. Please note since we are anyway taking an exclusive lock in
>> unaligned IO, inode_dio_wait() becomes a no-op in case of non-AIO DIO.
>>
>> 2. Added ext4_extending_io(). This checks if the IO is extending the file.
>>
>> 3. Added ext4_dio_write_checks(). In this we start with shared inode lock and
>> only switch to exclusive lock if required. So in most cases with aligned,
>> non-extending, dioread_nolock & overwrites, it tries to write with a shared
>> lock. If not, then we restart the operation in ext4_dio_write_checks(), after
>> acquiring exclusive lock.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> 
> Cool, the patch looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

great!

> 
> Two small nits below:
> 
>> -static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
>> +static ssize_t ext4_generic_write_checks(struct kiocb *iocb,
>> +					 struct iov_iter *from)
>>   {
>>   	struct inode *inode = file_inode(iocb->ki_filp);
>>   	ssize_t ret;
>> @@ -228,11 +235,21 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
>>   		iov_iter_truncate(from, sbi->s_bitmap_maxbytes - iocb->ki_pos);
>>   	}
>>   
>> +	return iov_iter_count(from);
>> +}
> 
> You return iov_iter_count() from ext4_generic_write_checks()...
> 
>> +static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>> +				     bool *ilock_shared, bool *extend)
>> +{
>> +	struct file *file = iocb->ki_filp;
>> +	struct inode *inode = file_inode(file);
>> +	loff_t offset;
>> +	size_t count;
>> +	ssize_t ret;
>> +
>> +restart:
>> +	ret = ext4_generic_write_checks(iocb, from);
>> +	if (ret <= 0)
>> +		goto out;
>> +
>> +	offset = iocb->ki_pos;
>> +	count = iov_iter_count(from);
> 
> But you don't use the returned count here and just call iov_iter_count()
> again (which is cheap anyway but still it's strange).

Yes. iov_iter_count() (as you also said) is anyway a inline function
which only does from->count, which comes at no cost.
But re-assigning a ssize_t value to size_t is something I was getting
uncomfortable with. Although I agree that it should be completely fine
here, I just was not convinced to use that instead of directly accessing
it from iov_iter_count() for better readability reasons.

But unless you feel otherwise, I could make those changes at 2 places
which you mentioned.

> 
>> +	if (ext4_extending_io(inode, offset, count))
>> +		*extend = true;
>> +	/*
>> +	 * Determine whether the IO operation will overwrite allocated
>> +	 * and initialized blocks. If so, check to see whether it is
>> +	 * possible to take the dioread_nolock path.
>> +	 *
>> +	 * We need exclusive i_rwsem for changing security info
>> +	 * in file_modified().
>> +	 */
>> +	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
>> +	     !ext4_should_dioread_nolock(inode) ||
>> +	     !ext4_overwrite_io(inode, offset, count))) {
>> +		inode_unlock_shared(inode);
>> +		*ilock_shared = false;
>> +		inode_lock(inode);
>> +		goto restart;
>> +	}
>> +
>> +	ret = file_modified(file);
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	return count;
> 
> And then you return count from ext4_dio_write_checks() here...

ditto
> 
>> -	ret = ext4_write_checks(iocb, from);
>> -	if (ret <= 0) {
>> -		inode_unlock(inode);
>> +	ret = ext4_dio_write_checks(iocb, from, &ilock_shared, &extend);
>> +	if (ret <= 0)
>>   		return ret;
>> -	}
>>   
>> -	/*
>> -	 * Unaligned asynchronous direct I/O must be serialized among each
>> -	 * other as the zeroing of partial blocks of two competing unaligned
>> -	 * asynchronous direct I/O writes can result in data corruption.
>> -	 */
>>   	offset = iocb->ki_pos;
>>   	count = iov_iter_count(from);
> 
> And then again just don't use the value here...

ditto
> 
> 								Honza
> 


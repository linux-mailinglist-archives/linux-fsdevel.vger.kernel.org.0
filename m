Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2334EB49F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 11:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfIQJA2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 05:00:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbfIQJA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 05:00:28 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8H8vN2w033704
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2019 05:00:27 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v2sfhppdy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2019 05:00:26 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 17 Sep 2019 10:00:24 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Sep 2019 10:00:19 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8H90IY344892222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Sep 2019 09:00:18 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89C135208E;
        Tue, 17 Sep 2019 09:00:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.31.57])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 266CB520A1;
        Tue, 17 Sep 2019 09:00:16 +0000 (GMT)
Subject: Re: [PATCH v3 5/6] ext4: introduce direct IO write path using iomap
 infrastructure
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Christoph Hellwig <hch@infradead.org>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, darrick.wong@oracle.com
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <db33705f9ba35ccbe20fc19b8ecbbf2078beff08.1568282664.git.mbobrowski@mbobrowski.org>
 <20190916121248.GD4005@infradead.org> <20190916223741.GA5936@bobrowski>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 17 Sep 2019 14:30:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190916223741.GA5936@bobrowski>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19091709-0016-0000-0000-000002AD0DF1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091709-0017-0000-0000-0000330DB08D
Message-Id: <20190917090016.266CB520A1@d06av21.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=898 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909170096
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On 9/17/19 4:07 AM, Matthew Bobrowski wrote:
> On Mon, Sep 16, 2019 at 05:12:48AM -0700, Christoph Hellwig wrote:
>> On Thu, Sep 12, 2019 at 09:04:46PM +1000, Matthew Bobrowski wrote:
>>> @@ -213,12 +214,16 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
>>>   	struct inode *inode = file_inode(iocb->ki_filp);
>>>   	ssize_t ret;
>>>   
>>> +	if (unlikely(IS_IMMUTABLE(inode)))
>>> +		return -EPERM;
>>> +
>>>   	ret = generic_write_checks(iocb, from);
>>>   	if (ret <= 0)
>>>   		return ret;
>>>   
>>> -	if (unlikely(IS_IMMUTABLE(inode)))
>>> -		return -EPERM;
>>> +	ret = file_modified(iocb->ki_filp);
>>> +	if (ret)
>>> +		return 0;
>>>   
>>>   	/*
>>>   	 * If we have encountered a bitmap-format file, the size limit
>>
>> Independent of the error return issue you probably want to split
>> modifying ext4_write_checks into a separate preparation patch.
> 
> Providing that there's no objections to introducing a possible performance
> change with this separate preparation patch (overhead of calling
> file_remove_privs/file_update_time twice), then I have no issues in doing so.
> 
>>> +/*
>>> + * For a write that extends the inode size, ext4_dio_write_iter() will
>>> + * wait for the write to complete. Consequently, operations performed
>>> + * within this function are still covered by the inode_lock(). On
>>> + * success, this function returns 0.
>>> + */
>>> +static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
>>> +				 unsigned int flags)
>>> +{
>>> +	int ret;
>>> +	loff_t offset = iocb->ki_pos;
>>> +	struct inode *inode = file_inode(iocb->ki_filp);
>>> +
>>> +	if (error) {
>>> +		ret = ext4_handle_failed_inode_extension(inode, offset + size);
>>> +		return ret ? ret : error;
>>> +	}
>>
>> Just a personal opinion, but I find the use of the ternary operator
>> here a little weird.
>>
>> A plain old:
>>
>> 	ret = ext4_handle_failed_inode_extension(inode, offset + size);
>> 	if (ret)
>> 		return ret;
>> 	return error;
>>
>> flow much easier.
> 
> Agree, much cleaner.
> 
>>> +	if (!inode_trylock(inode)) {
>>> +		if (iocb->ki_flags & IOCB_NOWAIT)
>>> +			return -EAGAIN;
>>> +		inode_lock(inode);
>>> +	}
>>> +
>>> +	if (!ext4_dio_checks(inode)) {
>>> +		inode_unlock(inode);
>>> +		/*
>>> +		 * Fallback to buffered IO if the operation on the
>>> +		 * inode is not supported by direct IO.
>>> +		 */
>>> +		return ext4_buffered_write_iter(iocb, from);
>>
>> I think you want to lift the locking into the caller of this function
>> so that you don't have to unlock and relock for the buffered write
>> fallback.
> 
> I don't exactly know what you really mean by "lift the locking into the caller
> of this function". I'm interpreting that as moving the inode_unlock()
> operation into ext4_buffered_write_iter(), but I can't see how that would be
> any different from doing it directly here? Wouldn't this also run the risk of
> the locks becoming unbalanced as we'd need to add checks around whether the
> resource is being contended? Maybe I'm misunderstanding something here...
> 
>>> +	if (offset + count > i_size_read(inode) ||
>>> +	    offset + count > EXT4_I(inode)->i_disksize) {
>>> +		ext4_update_i_disksize(inode, inode->i_size);
>>> +		extend = true;
>>
>> Doesn't the ext4_update_i_disksize need to be under an open journal
>> handle?
> 
> After all, it is a metadata update, which should go through an open journal
> handle.

Hmmm, it seems like a race here. But I am not sure if this is just due 
to not updating i_disksize under open journal handle.


So if we have a delayed buffered write to a file,
in that case we first only update inode->i_size and update
i_disksize at writeback time
(i.e. during block allocation).
In that case when we call for ext4_dio_write_iter
since offset + len > i_disksize, we call for ext4_update_i_disksize().

Now if writeback for some reason failed. And the system crashes, during 
the DIO writes, after the blocks are allocated. Then during reboot we 
may have an inconsistent inode, since we did not add the inode into the
orphan list before we updated the inode->i_disksize. And journal replay
may not succeed.

1. Can above actually happen? I am still not able to figure out the
    race/inconsistency completely.
2. Can you please help explain under what other cases
    it was necessary to call ext4_update_i_disksize() in DIO write paths?
3. When will i_disksize be out-of-sync with i_size during DIO writes?


-ritesh


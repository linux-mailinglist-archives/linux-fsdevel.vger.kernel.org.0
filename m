Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 083E2AFA63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 12:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfIKKb2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 06:31:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727137AbfIKKb2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:31:28 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8BASioj035589
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2019 06:31:27 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uxw40mdgp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2019 06:31:26 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 11 Sep 2019 11:31:24 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Sep 2019 11:31:20 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8BAVJ4x35848332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 10:31:20 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C190B4C05C;
        Wed, 11 Sep 2019 10:31:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E32C34C044;
        Wed, 11 Sep 2019 10:31:17 +0000 (GMT)
Received: from [9.199.159.54] (unknown [9.199.159.54])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 Sep 2019 10:31:17 +0000 (GMT)
Subject: Re: Odd locking pattern introduced as part of "nowait aio support"
To:     Andres Freund <andres@anarazel.de>,
        Dave Chinner <david@fromorbit.com>,
        David Sterba <dsterba@suse.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, jack@suse.com, hch@infradead.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20190910223327.mnegfoggopwqqy33@alap3.anarazel.de>
 <20190911040420.GB27547@dread.disaster.area>
 <20190911093926.pfkkx25mffzeuo32@alap3.anarazel.de>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 11 Sep 2019 16:01:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190911093926.pfkkx25mffzeuo32@alap3.anarazel.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19091110-4275-0000-0000-0000036469CA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091110-4276-0000-0000-00003876C0E5
Message-Id: <20190911103117.E32C34C044@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909110095
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 9/11/19 3:09 PM, Andres Freund wrote:
> Hi,
> 
> On 2019-09-11 14:04:20 +1000, Dave Chinner wrote:
>> On Tue, Sep 10, 2019 at 03:33:27PM -0700, Andres Freund wrote:
>>> Hi,
>>>
>>> Especially with buffered io it's fairly easy to hit contention on the
>>> inode lock, during writes. With something like io_uring, it's even
>>> easier, because it currently (but see [1]) farms out buffered writes to
>>> workers, which then can easily contend on the inode lock, even if only
>>> one process submits writes.  But I've seen it in plenty other cases too.
>>>
>>> Looking at the code I noticed that several parts of the "nowait aio
>>> support" (cf 728fbc0e10b7f3) series introduced code like:
>>>
>>> static ssize_t
>>> ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>> {
>>> ...
>>> 	if (!inode_trylock(inode)) {
>>> 		if (iocb->ki_flags & IOCB_NOWAIT)
>>> 			return -EAGAIN;
>>> 		inode_lock(inode);
>>> 	}
>>
>> The ext4 code is just buggy here - we don't support RWF_NOWAIT on
>> buffered write >
> But both buffered and non-buffered writes go through
> ext4_file_write_iter(). And there's a preceding check, at least these
> days, preventing IOCB_NOWAIT to apply to buffered writes:
> 
> 	if (!o_direct && (iocb->ki_flags & IOCB_NOWAIT))
> 		return -EOPNOTSUPP;
> 

-EOPNOTSUPP is now taken care in ext4 iomap patch series as well.


> 
> I do really wish buffered NOWAIT was supported... The overhead of having
> to do async buffered writes through the workqueue in io_uring, even if
> an already existing page is targeted, is quite noticable. Even if it
> failed with EAGAIN as soon as the buffered write's target isn't in the
> page cache, it'd be worthwhile.
> 
> 
>>> isn't trylocking and then locking in a blocking fashion an inefficient
>>> pattern? I.e. I think this should be
>>>
>>> 	if (iocb->ki_flags & IOCB_NOWAIT) {
>>> 		if (!inode_trylock(inode))
>>> 			return -EAGAIN;
>>> 	}
>>>          else
>>>          	inode_lock(inode);
>>
>> Yes, you are right.
>>
>> History: commit 91f9943e1c7b ("fs: support RWF_NOWAIT
>> for buffered reads") which introduced the first locking pattern
>> you describe in XFS.
> 
> Seems, as part of the nowait work, the pattern was introduced in ext4,
> xfs and btrfs. And fixed in xfs.
> 
> 
>> That was followed soon after by:
>>
>> commit 942491c9e6d631c012f3c4ea8e7777b0b02edeab
>> Author: Christoph Hellwig <hch@lst.de>
>> Date:   Mon Oct 23 18:31:50 2017 -0700
>>
>>      xfs: fix AIM7 regression
>>      
>>      Apparently our current rwsem code doesn't like doing the trylock, then
>>      lock for real scheme.  So change our read/write methods to just do the
>>      trylock for the RWF_NOWAIT case.  This fixes a ~25% regression in
>>      AIM7.
>>      
>>      Fixes: 91f9943e ("fs: support RWF_NOWAIT for buffered reads")
>>      Reported-by: kernel test robot <xiaolong.ye@intel.com>
>>      Signed-off-by: Christoph Hellwig <hch@lst.de>
>>      Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
>>      Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
>>
>> Which changed all the trylock/eagain/lock patterns to the second
>> form you quote. None of the other filesystems had AIM7 regressions
>> reported against them, so nobody changed them....
> 
> :(
> 
> 
>>> Obviously this isn't going to improve scalability to a very significant
>>> degree. But not unnecessarily doing two atomic ops on a contended lock
>>> can't hurt scalability either. Also, the current code just seems
>>> confusing.
>>>
>>> Am I missing something?
>>
>> Just that the sort of performance regression testing that uncovers
>> this sort of thing isn't widely done, and most filesystems are
>> concurrency limited in some way before they hit inode lock
>> scalability issues. Hence filesystem concurrency foccussed
>> benchmarks that could uncover it (like aim7) won't because the inode
>> locks don't end up stressed enough to make a difference to
>> benchmark performance.
> 
> Ok.  Goldwyn, do you want to write a patch, or do you want me to write
> one up?

I am anyways looking into ext4 performance issue of mixed parallel DIO 
workload. This will require some new APIs for inode locking similar to
that of XFS.
In that I can take care of this symantics reported here by you (which is 
taken care by XFS in above patch) for ext4.


Thanks
-ritesh

> 
> 
> Greetings,
> 
> Andres Freund
> 


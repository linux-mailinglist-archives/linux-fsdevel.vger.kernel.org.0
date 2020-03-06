Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 415FE17C4E0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 18:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgCFRto (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 12:49:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725935AbgCFRto (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:49:44 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026Hj3rE113584
        for <linux-fsdevel@vger.kernel.org>; Fri, 6 Mar 2020 12:49:43 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yj4q41pry-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2020 12:49:42 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Fri, 6 Mar 2020 17:49:40 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Mar 2020 17:49:35 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 026HnZUB37945624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Mar 2020 17:49:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CB2A4C044;
        Fri,  6 Mar 2020 17:49:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D81D4C04E;
        Fri,  6 Mar 2020 17:49:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.85.14])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Mar 2020 17:49:32 +0000 (GMT)
Subject: Re: [PATCHv5 3/6] ext4: Move ext4 bmap to use iomap infrastructure.
To:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, cmaiolino@redhat.com, david@fromorbit.com
References: <cover.1582880246.git.riteshh@linux.ibm.com>
 <8bbd53bd719d5ccfecafcce93f2bf1d7955a44af.1582880246.git.riteshh@linux.ibm.com>
 <20200228152524.GE8036@magnolia>
 <20200302085840.A41E3A4053@d06av23.portsmouth.uk.ibm.com>
 <20200303154709.GB8037@magnolia> <20200304124211.GC21048@quack2.suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri, 6 Mar 2020 23:19:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200304124211.GC21048@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20030617-4275-0000-0000-000003A90CA5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030617-4276-0000-0000-000038BE1FF8
Message-Id: <20200306174932.9D81D4C04E@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_06:2020-03-06,2020-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060113
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/4/20 6:12 PM, Jan Kara wrote:
> On Tue 03-03-20 07:47:09, Darrick J. Wong wrote:
>> On Mon, Mar 02, 2020 at 02:28:39PM +0530, Ritesh Harjani wrote:
>>>
>>>
>>> On 2/28/20 8:55 PM, Darrick J. Wong wrote:
>>>> On Fri, Feb 28, 2020 at 02:56:56PM +0530, Ritesh Harjani wrote:
>>>>> ext4_iomap_begin is already implemented which provides ext4_map_blocks,
>>>>> so just move the API from generic_block_bmap to iomap_bmap for iomap
>>>>> conversion.
>>>>>
>>>>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>>>>> Reviewed-by: Jan Kara <jack@suse.cz>
>>>>> ---
>>>>>    fs/ext4/inode.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>>>>> index 6cf3b969dc86..81fccbae0aea 100644
>>>>> --- a/fs/ext4/inode.c
>>>>> +++ b/fs/ext4/inode.c
>>>>> @@ -3214,7 +3214,7 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
>>>>>    			return 0;
>>>>>    	}
>>>>> -	return generic_block_bmap(mapping, block, ext4_get_block);
>>>>> +	return iomap_bmap(mapping, block, &ext4_iomap_ops);
>>>>
>>>> /me notes that iomap_bmap will filemap_write_and_wait for you, so one
>>>> could optimize ext4_bmap to avoid the double-flush by moving the
>>>> filemap_write_and_wait at the top of the function into the JDATA state
>>>> clearing block.
>>>
>>> IIUC, delalloc and data=journal mode are both mutually exclusive.
>>> So we could get rid of calling filemap_write_and_wait() all together
>>> from ext4_bmap().
>>> And as you pointed filemap_write_and_wait() is called by default in
>>> iomap_bmap which should cover for delalloc case.
>>>
>>>
>>> @Jan/Darrick,
>>> Could you check if the attached patch looks good. If yes then
>>> will add your Reviewed-by and send a v6.
>>>
>>> Thanks for the review!!
>>>
>>> -ritesh
>>>
>>>
>>
>>>  From 93f560d9a483b4f389056e543012d0941734a8f4 Mon Sep 17 00:00:00 2001
>>> From: Ritesh Harjani <riteshh@linux.ibm.com>
>>> Date: Tue, 20 Aug 2019 18:36:33 +0530
>>> Subject: [PATCH 3/6] ext4: Move ext4 bmap to use iomap infrastructure.
>>>
>>> ext4_iomap_begin is already implemented which provides ext4_map_blocks,
>>> so just move the API from generic_block_bmap to iomap_bmap for iomap
>>> conversion.
>>>
>>> Also no need to call for filemap_write_and_wait() any more in ext4_bmap
>>> since data=journal mode anyway doesn't support delalloc and for all other
>>> cases iomap_bmap() anyway calls the same function, so no need for doing
>>> it twice.
>>>
>>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>>
>> Hmmm.  I don't recall how jdata actually works, but I get the impression
>> here that we're trying to flush dirty data out to the journal and then
>> out to disk, and then drop the JDATA state from the inode.  This
>> mechanism exists (I guess?) so that dirty file pages get checkpointed
>> out of jbd2 back into the filesystem so that bmap() returns meaningful
>> results to lilo.
> 
> Exactly. E.g. when we are journalling data, we fill hole through mmap, we will
> have block allocated as unwritten and we need to write it out so that the
> data gets to the journal and then do journal flush to get the data to disk

So in data=journal case in ext4_page_mkwrite the data buffer will also
be marked as, to be journalled. So does jbd2_journal_flush() itself
don't take care of writing back any dirty page cache before it commit
that transaction? and after then checkpoint it?

Sorry my knowledge about jbd2 is very naive.

> so that lilo can read it from the devices. So removing
> filemap_write_and_wait() when journalling data is wrong.

Sure I understand this part. But was just curious on above query.
Otherwise, IIUC, we will have to add
filemap_write_and_wait() for JDATA case as well before calling
for jbd2_journal_flush(). Will add this as a separate patch.


-ritesh

> 
>> This makes me wonder if you still need the filemap_write_and_wait in the
>> JDATA case because otherwise the journal flush won't have the effect of
>> writing all the dirty pagecache back to the filesystem?  OTOH I suppose
>> the implicit write-and-wait call after we clear JDATA will not be
>> writing to the journal.
>>
>> Even more weirdly, the FIEMAP code doesn't drop JDATA at all...?
> 
> Yeah, it should do that but that's only performance optimization so that we
> bother with journal flushing only when someone uses block mapping call on
> a file with journalled dirty data. So you can hardly notice the bug by
> testing...
> 
> 								Honza
> 


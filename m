Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18C5610C68E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 11:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfK1KUn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 05:20:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbfK1KUm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:20:42 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xASAHaeD119980
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2019 05:20:42 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2whcxrwbt2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2019 05:20:42 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 28 Nov 2019 10:20:39 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Nov 2019 10:20:36 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xASAKZFA66322460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Nov 2019 10:20:35 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6525152054;
        Thu, 28 Nov 2019 10:20:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.87.233])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6085952057;
        Thu, 28 Nov 2019 10:20:32 +0000 (GMT)
Subject: Re: [PATCH] f2fs: Fix direct IO handling
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Javier Gonzalez <javier@javigon.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20191126075719.1046485-1-damien.lemoal@wdc.com>
 <20191126083443.F1FD5A405B@b06wcsmtp001.portsmouth.uk.ibm.com>
 <BYAPR04MB5816C82F708612381216895BE7470@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 28 Nov 2019 15:50:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816C82F708612381216895BE7470@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19112810-4275-0000-0000-0000038770F9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112810-4276-0000-0000-0000389B0254
Message-Id: <20191128102033.6085952057@d06av21.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_01:2019-11-28,2019-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911280089
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11/28/19 7:40 AM, Damien Le Moal wrote:
> On 2019/11/26 17:34, Ritesh Harjani wrote:
>> Hello Damien,
>>
>> IIUC, you are trying to fix a stale data read by DIO read for the case
>> you explained in your patch w.r.t. DIO-write forced to write as buffIO.
>>
>> Coincidentally I was just looking at the same code path just now.
>> So I do have a query to you/f2fs group. Below could be silly one, as I
>> don't understand F2FS in great detail.
>>
>> How is the stale data by DIO read, is protected against a mmap
>> writes via f2fs_vm_page_mkwrite?
>>
>> f2fs_vm_page_mkwrite()		 f2fs_direct_IO (read)
>> 					filemap_write_and_wait_range()
>> 	-> f2fs_get_blocks()				
>> 					 -> submit_bio()
>>
>> 	-> set_page_dirty()
>>
>> Is above race possible with current f2fs code?
>> i.e. f2fs_direct_IO could read the stale data from the blocks
>> which were allocated due to mmap fault?
> 
> The faulted page is locked until the fault is fully processed so direct
> IO has to wait for that to complete first.

How about below parallelism?

  f2fs_vm_page_mkwrite()		 f2fs_direct_IO (read)
  					filemap_write_and_wait_range()
	-> down_read(->i_mmap_sem);
	-> lock_page()
	-> f2fs_get_blocks()				
  					 -> submit_bio()

  	-> set_page_dirty()

Can above DIO read not expose the stale data from block which was
allocated in f2fs_vm_page_mkwrite path?


> 
>>
>> Am I missing something here?
>>
>> -ritesh
>>
>> On 11/26/19 1:27 PM, Damien Le Moal wrote:
>>> f2fs_preallocate_blocks() identifies direct IOs using the IOCB_DIRECT
>>> flag for a kiocb structure. However, the file system direct IO handler
>>> function f2fs_direct_IO() may have decided that a direct IO has to be
>>> exececuted as a buffered IO using the function f2fs_force_buffered_io().
>>> This is the case for instance for volumes including zoned block device
>>> and for unaligned write IOs with LFS mode enabled.
>>>
>>> These 2 different methods of identifying direct IOs can result in
>>> inconsistencies generating stale data access for direct reads after a
>>> direct IO write that is treated as a buffered write. Fix this
>>> inconsistency by combining the IOCB_DIRECT flag test with the result
>>> of f2fs_force_buffered_io().
>>>
>>> Reported-by: Javier Gonzalez <javier@javigon.com>
>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>>> ---
>>>    fs/f2fs/data.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 5755e897a5f0..8ac2d3b70022 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -1073,6 +1073,8 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>>>    	int flag;
>>>    	int err = 0;
>>>    	bool direct_io = iocb->ki_flags & IOCB_DIRECT;
>>> +	bool do_direct_io = direct_io &&
>>> +		!f2fs_force_buffered_io(inode, iocb, from);
>>>    
>>>    	/* convert inline data for Direct I/O*/
>>>    	if (direct_io) {
>>> @@ -1081,7 +1083,7 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>>>    			return err;
>>>    	}
>>>    
>>> -	if (direct_io && allow_outplace_dio(inode, iocb, from))
>>> +	if (do_direct_io && allow_outplace_dio(inode, iocb, from))
>>>    		return 0;
>>>    
>>>    	if (is_inode_flag_set(inode, FI_NO_PREALLOC))
>>>
>>
>>
> 
> 


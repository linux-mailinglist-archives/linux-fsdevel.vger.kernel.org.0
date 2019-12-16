Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA5C5121979
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 19:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfLPSyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 13:54:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48590 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfLPSyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:54:15 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBGIsBej116227;
        Mon, 16 Dec 2019 18:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Zr1Ys6wLJXMuo5RPFk2kTjXtL/EnbGaUDqDyN4n4WLM=;
 b=LHME5wFqcWajLm2nNFUe5OjpogDZMUVtSmJDBq34Phci9ijAtDq01rZotPUygx0sJSCE
 tczITez6lP5YZAZbQIZK5zcPiarZ2+x+w4uYWlSEqV054v9xgtBn0hj7SXniOWzJOgto
 qIvMObXeflDQ8GtikZIs6TaRi04R+uBQpDDz7e4IZEOl1JK06pjgO1u7HjKWzFvbwvPc
 GyUMqbQ10ywo/5uJ/vX2yI/RXsZWwvL/uQykbNSn2L//UGWNMiFdQXZvMXIE4Xenf7LM
 PZ6VlDxV4sZNO82LefJIaQRV/Rf/oxK0Zfp3AjUCi1chfFSJA5qF6znrcvVkqm7rSd1r jg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wvq5u9jkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Dec 2019 18:54:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBGIrwCk172530;
        Mon, 16 Dec 2019 18:54:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2ww9vpth07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Dec 2019 18:54:05 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBGIrgES009699;
        Mon, 16 Dec 2019 18:53:42 GMT
Received: from Junxiaos-MacBook-Pro.local (/10.11.16.208)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Dec 2019 10:53:42 -0800
Subject: Re: [PATCH] vfs: stop shrinker while fs is freezed
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
References: <20191213222440.11519-1-junxiao.bi@oracle.com>
 <20191216040909.GJ19213@dread.disaster.area>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <be71cf40-0ecc-5e25-08b7-e4ec6208abd2@oracle.com>
Date:   Mon, 16 Dec 2019 10:53:37 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191216040909.GJ19213@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9473 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912160160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9473 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912160160
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

On 12/15/19 8:09 PM, Dave Chinner wrote:
> On Fri, Dec 13, 2019 at 02:24:40PM -0800, Junxiao Bi wrote:
>> Shrinker could be blocked by freeze while dropping the last reference of
>> some inode that had been removed. As "s_umount" lock was acquired by the
>> Shrinker before blocked, the thaw will hung by this lock. This caused a
>> deadlock.
>>
>>   crash7latest> set 132
>>       PID: 132
>>   COMMAND: "kswapd0:0"
>>      TASK: ffff9cdc9dfb5f00  [THREAD_INFO: ffff9cdc9dfb5f00]
>>       CPU: 6
>>     STATE: TASK_UNINTERRUPTIBLE
>>   crash7latest> bt
>>   PID: 132    TASK: ffff9cdc9dfb5f00  CPU: 6   COMMAND: "kswapd0:0"
>>    #0 [ffffaa5d075bf900] __schedule at ffffffff8186487c
>>    #1 [ffffaa5d075bf998] schedule at ffffffff81864e96
>>    #2 [ffffaa5d075bf9b0] rwsem_down_read_failed at ffffffff818689ee
>>    #3 [ffffaa5d075bfa40] call_rwsem_down_read_failed at ffffffff81859308
>>    #4 [ffffaa5d075bfa90] __percpu_down_read at ffffffff810ebd38
>>    #5 [ffffaa5d075bfab0] __sb_start_write at ffffffff812859ef
>>    #6 [ffffaa5d075bfad0] xfs_trans_alloc at ffffffffc07ebe9c [xfs]
>>    #7 [ffffaa5d075bfb18] xfs_free_eofblocks at ffffffffc07c39d1 [xfs]
>>    #8 [ffffaa5d075bfb80] xfs_inactive at ffffffffc07de878 [xfs]
>>    #9 [ffffaa5d075bfba0] __dta_xfs_fs_destroy_inode_3543 at ffffffffc07e885e [xfs]
>>   #10 [ffffaa5d075bfbd0] destroy_inode at ffffffff812a25de
>>   #11 [ffffaa5d075bfbe8] evict at ffffffff812a2b73
>>   #12 [ffffaa5d075bfc10] dispose_list at ffffffff812a2c1d
>>   #13 [ffffaa5d075bfc38] prune_icache_sb at ffffffff812a421a
>>   #14 [ffffaa5d075bfc70] super_cache_scan at ffffffff812870a1
>>   #15 [ffffaa5d075bfcc8] shrink_slab at ffffffff811eebb3
>>   #16 [ffffaa5d075bfdb0] shrink_node at ffffffff811f4788
>>   #17 [ffffaa5d075bfe38] kswapd at ffffffff811f58c3
>>   #18 [ffffaa5d075bff08] kthread at ffffffff810b75d5
>>   #19 [ffffaa5d075bff50] ret_from_fork at ffffffff81a0035e
> How did you get a file that needed EOF block trimming to be disposed
> of when the filesystem is frozen?
>
> Part of freezing the filesystem is tossing all the reclaimable
> inodes out of the cache, which means all the inodes that might
> require EOF block trimming should have already been removed from the
> cache before the freeze goes into effect....

This issue happened only once, don't know how it was triggered.

I am not xfs developer, don't know what EOF block mean. But this seemed 
a generic issue, destroy inode will engage the transaction on non-EOF 
blocks?

>
>>   crash7latest> set 31060
>>       PID: 31060
>>   COMMAND: "safefreeze"
>>      TASK: ffff9cd292868000  [THREAD_INFO: ffff9cd292868000]
>>       CPU: 2
>>     STATE: TASK_UNINTERRUPTIBLE
>>   crash7latest> bt
>>   PID: 31060  TASK: ffff9cd292868000  CPU: 2   COMMAND: "safefreeze"
>>    #0 [ffffaa5d10047c90] __schedule at ffffffff8186487c
>>    #1 [ffffaa5d10047d28] schedule at ffffffff81864e96
>>    #2 [ffffaa5d10047d40] rwsem_down_write_failed at ffffffff81868f18
>>    #3 [ffffaa5d10047dd8] call_rwsem_down_write_failed at ffffffff81859367
>>    #4 [ffffaa5d10047e20] down_write at ffffffff81867cfd
>>    #5 [ffffaa5d10047e38] thaw_super at ffffffff81285d2d
>>    #6 [ffffaa5d10047e60] do_vfs_ioctl at ffffffff81299566
>>    #7 [ffffaa5d10047ee8] sys_ioctl at ffffffff81299709
>>    #8 [ffffaa5d10047f28] do_syscall_64 at ffffffff81003949
>>    #9 [ffffaa5d10047f50] entry_SYSCALL_64_after_hwframe at ffffffff81a001ad
>>       RIP: 0000000000453d67  RSP: 00007ffff9c1ce78  RFLAGS: 00000206
>>       RAX: ffffffffffffffda  RBX: 0000000001cbe92c  RCX: 0000000000453d67
>>       RDX: 0000000000000000  RSI: 00000000c0045878  RDI: 0000000000000014
>>       RBP: 00007ffff9c1cf80   R8: 0000000000000000   R9: 0000000000000012
>>       R10: 0000000000000008  R11: 0000000000000206  R12: 0000000000401fb0
>>       R13: 0000000000402040  R14: 0000000000000000  R15: 0000000000000000
>>       ORIG_RAX: 0000000000000010  CS: 0033  SS: 002b
>>
>> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
>> ---
>>   fs/super.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/super.c b/fs/super.c
>> index cfadab2cbf35..adc18652302b 100644
>> --- a/fs/super.c
>> +++ b/fs/super.c
>> @@ -80,6 +80,11 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
>>   	if (!trylock_super(sb))
>>   		return SHRINK_STOP;
>>   
>> +	if (sb->s_writers.frozen != SB_UNFROZEN) {
>> +		up_read(&sb->s_umount);
>> +		return SHRINK_STOP;
>> +	}
> Ah, no. Now go run a filesystem traversal over a filesystem with a
> few tens of million files in it while the filesystem is frozen, and
> what the dentry and inode cache grow and grow until you run out of
> memory....
Yea, this is an issue.
>
> THe shrinker *needs* to run while the filesystem is frozen, but it
> should not be tripping over files that need modification on
> eviction. Working out how we got a file that required truncation
> during eviction is the first thing to do here so we can then
> determine if a) we should have caught it at freeze time, b) whether
> it can be caught at freeze time, c) whether it can safely be skipped
> during a freeze, or d) something else....

will think about it, thank you.

Thanks,

Junxiao.

>
> Cheers,
>
> Dave.

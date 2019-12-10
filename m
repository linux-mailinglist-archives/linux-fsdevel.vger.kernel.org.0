Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED745118F4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 18:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfLJRuF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 12:50:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727520AbfLJRuE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:50:04 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBAHklIH085364
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 12:50:03 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wtcd0m25g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 12:50:02 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Tue, 10 Dec 2019 17:50:01 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Dec 2019 17:49:57 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBAHnvL941943230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Dec 2019 17:49:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6B4FA4054;
        Tue, 10 Dec 2019 17:49:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E667A405B;
        Tue, 10 Dec 2019 17:49:56 +0000 (GMT)
Received: from oc5311105230.ibm.com (unknown [9.152.224.131])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Dec 2019 17:49:56 +0000 (GMT)
Subject: Re: memory leak in fasync_helper
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+4b1fe8105f8044a26162@syzkaller.appspotmail.com>,
        bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        Karsten Graul <kgraul@linux.ibm.com>
References: <00000000000023dba505992ac8aa@google.com>
 <50681a5e-96e1-da38-e936-f817389c8b65@gmail.com>
From:   Ursula Braun <ubraun@linux.ibm.com>
Date:   Tue, 10 Dec 2019 18:49:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <50681a5e-96e1-da38-e936-f817389c8b65@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121017-0008-0000-0000-0000033F8DD7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121017-0009-0000-0000-00004A5EC01C
Message-Id: <3a02c6c1-78f6-327f-2eee-93436eced18f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_05:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912100151
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 12/8/19 6:51 AM, Eric Dumazet wrote:
> 
> 
> On 12/7/19 9:45 PM, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    bf929479 Merge branch 'for-linus' of git://git.kernel.org/..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=123e91e2e00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=874c75a332209d41
>> dashboard link: https://syzkaller.appspot.com/bug?extid=4b1fe8105f8044a26162
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120faee2e00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178a0ef6e00000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+4b1fe8105f8044a26162@syzkaller.appspotmail.com
>>
>> BUG: memory leak
>> unreferenced object 0xffff88812a4082a0 (size 48):
>>   comm "syz-executor670", pid 6989, jiffies 4294952355 (age 19.520s)
>>   hex dump (first 32 bytes):
>>     00 00 00 00 00 00 00 00 01 46 00 00 03 00 00 00  .........F......
>>     00 00 00 00 00 00 00 00 00 6b 05 1f 81 88 ff ff  .........k......
>>   backtrace:
>>     [<000000002a74b343>] kmemleak_alloc_recursive include/linux/kmemleak.h:43 [inline]
>>     [<000000002a74b343>] slab_post_alloc_hook mm/slab.h:586 [inline]
>>     [<000000002a74b343>] slab_alloc mm/slab.c:3319 [inline]
>>     [<000000002a74b343>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>>     [<00000000fa370506>] fasync_alloc fs/fcntl.c:895 [inline]
>>     [<00000000fa370506>] fasync_add_entry fs/fcntl.c:953 [inline]
>>     [<00000000fa370506>] fasync_helper+0x37/0xa9 fs/fcntl.c:982
>>     [<000000006c3eaaf1>] sock_fasync+0x4d/0xa0 net/socket.c:1293
>>     [<0000000098076f55>] ioctl_fioasync fs/ioctl.c:550 [inline]
>>     [<0000000098076f55>] do_vfs_ioctl+0x409/0x810 fs/ioctl.c:655
>>     [<00000000df24d2b9>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
>>     [<000000003fec9c80>] __do_sys_ioctl fs/ioctl.c:720 [inline]
>>     [<000000003fec9c80>] __se_sys_ioctl fs/ioctl.c:718 [inline]
>>     [<000000003fec9c80>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
>>     [<000000002bebbfe6>] do_syscall_64+0x73/0x1f0 arch/x86/entry/common.c:290
>>     [<00000000722d8431>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff888128cdf240 (size 48):
>>   comm "syz-executor670", pid 6990, jiffies 4294952942 (age 13.650s)
>>   hex dump (first 32 bytes):
>>     00 00 00 00 00 00 00 00 01 46 00 00 03 00 00 00  .........F......
>>     00 00 00 00 00 00 00 00 00 d8 02 19 81 88 ff ff  ................
>>   backtrace:
>>     [<000000002a74b343>] kmemleak_alloc_recursive include/linux/kmemleak.h:43 [inline]
>>     [<000000002a74b343>] slab_post_alloc_hook mm/slab.h:586 [inline]
>>     [<000000002a74b343>] slab_alloc mm/slab.c:3319 [inline]
>>     [<000000002a74b343>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>>     [<00000000fa370506>] fasync_alloc fs/fcntl.c:895 [inline]
>>     [<00000000fa370506>] fasync_add_entry fs/fcntl.c:953 [inline]
>>     [<00000000fa370506>] fasync_helper+0x37/0xa9 fs/fcntl.c:982
>>     [<000000006c3eaaf1>] sock_fasync+0x4d/0xa0 net/socket.c:1293
>>     [<0000000098076f55>] ioctl_fioasync fs/ioctl.c:550 [inline]
>>     [<0000000098076f55>] do_vfs_ioctl+0x409/0x810 fs/ioctl.c:655
>>     [<00000000df24d2b9>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
>>     [<000000003fec9c80>] __do_sys_ioctl fs/ioctl.c:720 [inline]
>>     [<000000003fec9c80>] __se_sys_ioctl fs/ioctl.c:718 [inline]
>>     [<000000003fec9c80>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
>>     [<000000002bebbfe6>] do_syscall_64+0x73/0x1f0 arch/x86/entry/common.c:290
>>     [<00000000722d8431>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff888128cdff60 (size 48):
>>   comm "syz-executor670", pid 6991, jiffies 4294953529 (age 7.780s)
>>   hex dump (first 32 bytes):
>>     00 00 00 00 00 00 00 00 01 46 00 00 03 00 00 00  .........F......
>>     00 00 00 00 00 00 00 00 00 63 05 1f 81 88 ff ff  .........c......
>>   backtrace:
>>     [<000000002a74b343>] kmemleak_alloc_recursive include/linux/kmemleak.h:43 [inline]
>>     [<000000002a74b343>] slab_post_alloc_hook mm/slab.h:586 [inline]
>>     [<000000002a74b343>] slab_alloc mm/slab.c:3319 [inline]
>>     [<000000002a74b343>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>>     [<00000000fa370506>] fasync_alloc fs/fcntl.c:895 [inline]
>>     [<00000000fa370506>] fasync_add_entry fs/fcntl.c:953 [inline]
>>     [<00000000fa370506>] fasync_helper+0x37/0xa9 fs/fcntl.c:982
>>     [<000000006c3eaaf1>] sock_fasync+0x4d/0xa0 net/socket.c:1293
>>     [<0000000098076f55>] ioctl_fioasync fs/ioctl.c:550 [inline]
>>     [<0000000098076f55>] do_vfs_ioctl+0x409/0x810 fs/ioctl.c:655
>>     [<00000000df24d2b9>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
>>     [<000000003fec9c80>] __do_sys_ioctl fs/ioctl.c:720 [inline]
>>     [<000000003fec9c80>] __se_sys_ioctl fs/ioctl.c:718 [inline]
>>     [<000000003fec9c80>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
>>     [<000000002bebbfe6>] do_syscall_64+0x73/0x1f0 arch/x86/entry/common.c:290
>>     [<00000000722d8431>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>>
>>
>> ---
>> This bug is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this bug report. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> syzbot can test patches for this bug, for details see:
>> https://goo.gl/tpsmEJ#testing-patche
> 
> 
> AF_SMC bug it seems....
> 
> Repro does essentially :
> 
> socket(AF_SMC, SOCK_STREAM, SMCPROTO_SMC) = 3
> ioctl(3, FIOASYNC, [-1])   = 0
> sendmsg(3, {msg_name=NULL, msg_namelen=0, msg_iov=NULL, msg_iovlen=0, msg_controllen=0, msg_flags=0}, MSG_FASTOPEN)
> 
> 
> console logs :
> 
> __sock_release: fasync list not empty!
> 
> 

Indeed, it's an SMC-problem. We will take care about it. Thanks, Eric!

Regards, Ursula Braun


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAA37A0C09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 19:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbjINRyy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 13:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjINRyy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:54:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112A61FF5;
        Thu, 14 Sep 2023 10:54:50 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EHZeVT020819;
        Thu, 14 Sep 2023 17:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=clb7TlznKAbJtmsPbR7sVkoUXoel+CH7JV0yl1Yvn1U=;
 b=Oy8+Y8ZK2ykwdIUCFCzJhXsIcTiNUi1d0G7WP1exXcsYbDeM2uHGJx5y25ECm0JPbfT5
 rWA2TA0UEauBkn2J8fHA9f2wd/7ebMCwkmZwZct0zI6tPpu3q7ekRauT9rVRUaHZk7vS
 MoXeylR64CWm/V8EBPa2Thq1pTluA3qY/jVQYJorYg+tLpAeIhqbd/hFGCK7AUCNSbhB
 UAEB2MkDRliEyAX4gkkzuHoGnrxJ39/ek+voQ7qNIHMu8Ry33ofv3JLFLMQyhXsKJrpx
 rZh9xS9LKmmtsfQL6U/yXNs4Zr7zINv5ASjprD7TfjmEfp7q4hH8KH8JhyOMBZb94iwU og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t46ca163m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 17:54:36 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38EHqbwL002176;
        Thu, 14 Sep 2023 17:54:36 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t46ca1635-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 17:54:35 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38EHeke6012151;
        Thu, 14 Sep 2023 17:54:34 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t13e04yhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 17:54:34 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38EHsXRh39911882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 17:54:34 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A931058054;
        Thu, 14 Sep 2023 17:54:33 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A987F5804E;
        Thu, 14 Sep 2023 17:54:32 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.110.230])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 14 Sep 2023 17:54:32 +0000 (GMT)
Message-ID: <873204f28bb74add80cc5969f68f6a2840e8d41b.camel@linux.ibm.com>
Subject: Re: [syzbot] [integrity] [overlayfs] general protection fault in
 d_path
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     syzbot <syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com>,
        amir73il@gmail.com, brauner@kernel.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
Date:   Thu, 14 Sep 2023 13:54:32 -0400
In-Reply-To: <0000000000004e08ee060539e0a2@google.com>
References: <0000000000004e08ee060539e0a2@google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RZBcBve9bpcH1JOf_SvpJiiWbIe5jsuy
X-Proofpoint-GUID: dSNcNa5JUxghVdSaIGl8qkOGat00-LVV
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 mlxlogscore=856 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140152
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-09-13 at 02:06 -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> general protection fault in d_path

Is an IMA policy being loaded?  Please include the boot command line.


> general protection fault, probably for non-canonical address 0xdffffc0000000009: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
> CPU: 0 PID: 5465 Comm: syz-executor.0 Not tainted 6.6.0-rc1-syzkaller-00004-g965067e2f71e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
> RIP: 0010:__seqprop_spinlock_sequence include/linux/seqlock.h:275 [inline]
> RIP: 0010:get_fs_root_rcu fs/d_path.c:244 [inline]
> RIP: 0010:d_path+0x2f0/0x6e0 fs/d_path.c:286
> Code: 30 00 74 08 48 89 df e8 be 20 e1 ff 4c 8b 23 4d 8d 6c 24 48 49 81 c4 88 00 00 00 4c 89 eb 48 c1 eb 03 4c 89 ef e8 00 1e 00 00 <42> 0f b6 04 33 84 c0 0f 85 89 00 00 00 45 8b 7d 00 44 89 fe 83 e6
> RSP: 0018:ffffc90005056ec0 EFLAGS: 00010246
> RAX: be27ea831a7ad800 RBX: 0000000000000009 RCX: ffff88801c713b80
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc90005056fd0 R08: ffffffff82068d08 R09: 1ffffffff1d34ccd
> R10: dffffc0000000000 R11: fffffbfff1d34cce R12: 0000000000000088
> R13: 0000000000000048 R14: dffffc0000000000 R15: ffff888076dcc000
> FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f4b67d70420 CR3: 0000000016f66000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  audit_log_d_path+0xd3/0x310 kernel/audit.c:2138
>  dump_common_audit_data security/lsm_audit.c:224 [inline]
>  common_lsm_audit+0x7cf/0x1a90 security/lsm_audit.c:458
>  smack_log+0x421/0x540 security/smack/smack_access.c:383
>  smk_tskacc+0x2ff/0x360 security/smack/smack_access.c:253
>  smack_inode_getattr+0x203/0x270 security/smack/smack_lsm.c:1271
>  security_inode_getattr+0xd3/0x120 security/security.c:2153
>  vfs_getattr+0x2a/0x3a0 fs/stat.c:206
>  ovl_getattr+0x1b1/0xf70 fs/overlayfs/inode.c:174
>  ima_check_last_writer security/integrity/ima/ima_main.c:171 [inline]
>  ima_file_free+0x2c3/0x560 security/integrity/ima/ima_main.c:203
>  __fput+0x36a/0x910 fs/file_table.c:378
>  task_work_run+0x24a/0x300 kernel/task_work.c:179
>  exit_task_work include/linux/task_work.h:38 [inline]
>  do_exit+0x68f/0x2290 kernel/exit.c:874
>  do_group_exit+0x206/0x2c0 kernel/exit.c:1024
>  get_signal+0x175d/0x1840 kernel/signal.c:2892
>  arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:309
>  exit_to_user_mode_loop+0x6a/0x100 kernel/entry/common.c:168
>  exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
>  syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:296
>  do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f2a67a7cae9
> Code: Unable to access opcode bytes at 0x7f2a67a7cabf.
> RSP: 002b:00007f2a6875c178 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: 0000000000000001 RBX: 00007f2a67b9bf88 RCX: 00007f2a67a7cae9
> RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007f2a67b9bf8c
> RBP: 00007f2a67b9bf80 R08: 00007fffba3690b0 R09: 00007f2a6875c6c0
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2a67b9bf8c
> R13: 000000000000000b R14: 00007fffba21b880 R15: 00007fffba21b968
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__seqprop_spinlock_sequence include/linux/seqlock.h:275 [inline]
> RIP: 0010:get_fs_root_rcu fs/d_path.c:244 [inline]
> RIP: 0010:d_path+0x2f0/0x6e0 fs/d_path.c:286
> Code: 30 00 74 08 48 89 df e8 be 20 e1 ff 4c 8b 23 4d 8d 6c 24 48 49 81 c4 88 00 00 00 4c 89 eb 48 c1 eb 03 4c 89 ef e8 00 1e 00 00 <42> 0f b6 04 33 84 c0 0f 85 89 00 00 00 45 8b 7d 00 44 89 fe 83 e6
> RSP: 0018:ffffc90005056ec0 EFLAGS: 00010246
> RAX: be27ea831a7ad800 RBX: 0000000000000009 RCX: ffff88801c713b80
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc90005056fd0 R08: ffffffff82068d08 R09: 1ffffffff1d34ccd
> R10: dffffc0000000000 R11: fffffbfff1d34cce R12: 0000000000000088
> R13: 0000000000000048 R14: dffffc0000000000 R15: ffff888076dcc000
> FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f4b67d70420 CR3: 0000000016f66000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	30 00                	xor    %al,(%rax)
>    2:	74 08                	je     0xc
>    4:	48 89 df             	mov    %rbx,%rdi
>    7:	e8 be 20 e1 ff       	call   0xffe120ca
>    c:	4c 8b 23             	mov    (%rbx),%r12
>    f:	4d 8d 6c 24 48       	lea    0x48(%r12),%r13
>   14:	49 81 c4 88 00 00 00 	add    $0x88,%r12
>   1b:	4c 89 eb             	mov    %r13,%rbx
>   1e:	48 c1 eb 03          	shr    $0x3,%rbx
>   22:	4c 89 ef             	mov    %r13,%rdi
>   25:	e8 00 1e 00 00       	call   0x1e2a
> * 2a:	42 0f b6 04 33       	movzbl (%rbx,%r14,1),%eax <-- trapping instruction
>   2f:	84 c0                	test   %al,%al
>   31:	0f 85 89 00 00 00    	jne    0xc0
>   37:	45 8b 7d 00          	mov    0x0(%r13),%r15d
>   3b:	44 89 fe             	mov    %r15d,%esi
>   3e:	83                   	.byte 0x83
>   3f:	e6                   	.byte 0xe6
> 
> 
> Tested on:
> 
> commit:         965067e2 ima: fix wrong dereferences of file->f_path
> git tree:       https://github.com/amir73il/linux ima-ovl-fix
> console output: https://syzkaller.appspot.com/x/log.txt?x=109b00e8680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122
> dashboard link: https://syzkaller.appspot.com/bug?extid=a67fc5321ffb4b311c98
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Note: no patches were applied.



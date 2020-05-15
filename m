Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6964C1D5426
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 17:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgEOPSz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 11:18:55 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59415 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgEOPSz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 11:18:55 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04FFI6fi099445;
        Sat, 16 May 2020 00:18:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp);
 Sat, 16 May 2020 00:18:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04FFI5l1099429
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 16 May 2020 00:18:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: linux-next boot error: general protection fault in
 tomoyo_get_local_path
To:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <0000000000002f0c7505a5b0e04c@google.com>
Cc:     syzbot <syzbot+c1af344512918c61362c@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-security-module@vger.kernel.org,
        serge@hallyn.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c3461e26-1407-2262-c709-dac0df3da2d0@i-love.sakura.ne.jp>
Date:   Sat, 16 May 2020 00:18:00 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <0000000000002f0c7505a5b0e04c@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is

        if (sb->s_magic == PROC_SUPER_MAGIC && *pos == '/') {
                char *ep;
                const pid_t pid = (pid_t) simple_strtoul(pos + 1, &ep, 10);
                struct pid_namespace *proc_pidns = proc_pid_ns(d_inode(dentry)); // <= here

                if (*ep == '/' && pid && pid ==
                    task_tgid_nr_ns(current, proc_pidns)) {

which was added by commit c59f415a7cb6e1e1 ("Use proc_pid_ns() to get pid_namespace from the proc superblock").

@@ -161,9 +162,10 @@ static char *tomoyo_get_local_path(struct dentry *dentry, char * const buffer,
        if (sb->s_magic == PROC_SUPER_MAGIC && *pos == '/') {
                char *ep;
                const pid_t pid = (pid_t) simple_strtoul(pos + 1, &ep, 10);
+               struct pid_namespace *proc_pidns = proc_pid_ns(d_inode(dentry));

                if (*ep == '/' && pid && pid ==
-                   task_tgid_nr_ns(current, sb->s_fs_info)) {
+                   task_tgid_nr_ns(current, proc_pidns)) {
                        pos = ep - 5;
                        if (pos < buffer)
                                goto out;

Alexey and Eric, any clue?

On 2020/05/15 23:46, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    bdecf38f Add linux-next specific files for 20200515
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=155a43b2100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=27a5e30c87a59937
> dashboard link: https://syzkaller.appspot.com/bug?extid=c1af344512918c61362c
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c1af344512918c61362c@syzkaller.appspotmail.com
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
> CPU: 0 PID: 6698 Comm: sshd Not tainted 5.7.0-rc5-next-20200515-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:tomoyo_get_local_path+0x450/0x800 security/tomoyo/realpath.c:165
> Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b4 03 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 7f 60 49 8d 7f 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 87 03 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
> RSP: 0018:ffffc900063d7450 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: ffff88809975c000 RCX: ffffffff8363deda
> RDX: 0000000000000005 RSI: ffffffff8363dee8 RDI: 0000000000000028
> RBP: 1ffff92000c7ae8b R08: ffff8880a47644c0 R09: fffffbfff155a0a2
> R10: ffffffff8aad050f R11: fffffbfff155a0a1 R12: ffff88809df3cfea
> R13: ffff88809df3c000 R14: 0000000000001a2a R15: 0000000000000000
> FS:  00007efe13ce28c0(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055e78cf578f5 CR3: 00000000987ed000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  tomoyo_realpath_from_path+0x393/0x620 security/tomoyo/realpath.c:282
>  tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
>  tomoyo_path_number_perm+0x1c2/0x4d0 security/tomoyo/file.c:723
>  tomoyo_path_mknod+0x10d/0x190 security/tomoyo/tomoyo.c:246
>  security_path_mknod+0x116/0x180 security/security.c:1072
>  may_o_create fs/namei.c:2905 [inline]
>  lookup_open+0x5ae/0x1320 fs/namei.c:3046
>  open_last_lookups fs/namei.c:3155 [inline]
>  path_openat+0x93c/0x27f0 fs/namei.c:3343
>  do_filp_open+0x192/0x260 fs/namei.c:3373
>  do_sys_openat2+0x585/0x7d0 fs/open.c:1179
>  do_sys_open+0xc3/0x140 fs/open.c:1195
>  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
>  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> RIP: 0033:0x7efe11e4b6f0
> Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 83 3d 19 30 2c 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 fe 9d 01 00 48 89 04 24
> RSP: 002b:00007ffc3d0894d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 000055e78f0bc110 RCX: 00007efe11e4b6f0
> RDX: 00000000000001b6 RSI: 0000000000000241 RDI: 000055e78cf578f5
> RBP: 0000000000000004 R08: 0000000000000004 R09: 0000000000000001
> R10: 0000000000000240 R11: 0000000000000246 R12: 000055e78cf2851e
> R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace 0a58064de06d50f4 ]---
> RIP: 0010:tomoyo_get_local_path+0x450/0x800 security/tomoyo/realpath.c:165
> Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b4 03 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 7f 60 49 8d 7f 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 87 03 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
> RSP: 0018:ffffc900063d7450 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: ffff88809975c000 RCX: ffffffff8363deda
> RDX: 0000000000000005 RSI: ffffffff8363dee8 RDI: 0000000000000028
> RBP: 1ffff92000c7ae8b R08: ffff8880a47644c0 R09: fffffbfff155a0a2
> R10: ffffffff8aad050f R11: fffffbfff155a0a1 R12: ffff88809df3cfea
> R13: ffff88809df3c000 R14: 0000000000001a2a R15: 0000000000000000
> FS:  00007efe13ce28c0(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055dfe16c15f8 CR3: 00000000987ed000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 


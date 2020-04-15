Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772C91AB0BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 20:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416789AbgDOSbc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 14:31:32 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:38740 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416785AbgDOSb1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:31:27 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jOmon-0007m4-6E; Wed, 15 Apr 2020 12:31:25 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jOmom-0006UO-2C; Wed, 15 Apr 2020 12:31:24 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     syzbot <syzbot+d9ae59d4662c941e39c6@syzkaller.appspotmail.com>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org, avagin@gmail.com,
        bernd.edlinger@hotmail.de, christian@brauner.io, guro@fb.com,
        kent.overstreet@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <0000000000001c5eaa05a357f2e1@google.com>
Date:   Wed, 15 Apr 2020 13:28:24 -0500
In-Reply-To: <0000000000001c5eaa05a357f2e1@google.com> (syzbot's message of
        "Wed, 15 Apr 2020 10:50:02 -0700")
Message-ID: <878siwioxj.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jOmom-0006UO-2C;;;mid=<878siwioxj.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18kv7/zTOHseDqGZuNDRRZg/nbyEXbjBWg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01 autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;syzbot <syzbot+d9ae59d4662c941e39c6@syzkaller.appspotmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 675 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.2 (0.6%), b_tie_ro: 2.8 (0.4%), parse: 1.22
        (0.2%), extract_message_metadata: 17 (2.5%), get_uri_detail_list: 3.1
        (0.5%), tests_pri_-1000: 13 (1.9%), tests_pri_-950: 1.06 (0.2%),
        tests_pri_-900: 0.81 (0.1%), tests_pri_-90: 298 (44.1%), check_bayes:
        285 (42.2%), b_tokenize: 8 (1.2%), b_tok_get_all: 125 (18.6%),
        b_comp_prob: 3.3 (0.5%), b_tok_touch_all: 145 (21.5%), b_finish: 0.78
        (0.1%), tests_pri_0: 330 (48.9%), check_dkim_signature: 0.40 (0.1%),
        check_dkim_adsp: 2.0 (0.3%), poll_dns_idle: 0.52 (0.1%), tests_pri_10:
        1.72 (0.3%), tests_pri_500: 5 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] proc: Handle umounts cleanly
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot writes:
> KASAN: use-after-free Read in dput (2)
>
> proc_fill_super: allocate dentry failed
> ==================================================================
> BUG: KASAN: use-after-free in fast_dput fs/dcache.c:727 [inline]
> BUG: KASAN: use-after-free in dput+0x53e/0xdf0 fs/dcache.c:846
> Read of size 4 at addr ffff88808a618cf0 by task syz-executor.0/8426
>
> CPU: 0 PID: 8426 Comm: syz-executor.0 Not tainted 5.6.0-next-20200412-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x188/0x20d lib/dump_stack.c:118
>  print_address_description.constprop.0.cold+0xd3/0x315 mm/kasan/report.c:382
>  __kasan_report.cold+0x35/0x4d mm/kasan/report.c:511
>  kasan_report+0x33/0x50 mm/kasan/common.c:625
>  fast_dput fs/dcache.c:727 [inline]
>  dput+0x53e/0xdf0 fs/dcache.c:846
>  proc_kill_sb+0x73/0xf0 fs/proc/root.c:195
>  deactivate_locked_super+0x8c/0xf0 fs/super.c:335
>  vfs_get_super+0x258/0x2d0 fs/super.c:1212
>  vfs_get_tree+0x89/0x2f0 fs/super.c:1547
>  do_new_mount fs/namespace.c:2813 [inline]
>  do_mount+0x1306/0x1b30 fs/namespace.c:3138
>  __do_sys_mount fs/namespace.c:3347 [inline]
>  __se_sys_mount fs/namespace.c:3324 [inline]
>  __x64_sys_mount+0x18f/0x230 fs/namespace.c:3324
>  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
>  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> RIP: 0033:0x45c889
> Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffc1930ec48 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000001324914 RCX: 000000000045c889
> RDX: 0000000020000140 RSI: 0000000020000040 RDI: 0000000000000000
> RBP: 000000000076bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
> R13: 0000000000000749 R14: 00000000004ca15a R15: 0000000000000013

Looking at the code now that it the internal mount of proc is no
longer used it is possible to unmount proc.   If proc is unmounted
the fields of the pid namespace that were used for filesystem
specific state are not reinitialized.

Which means that proc_self and proc_thread_self can be pointers to
already freed dentries.

The reported user after free appears to be from mounting and
unmounting proc followed by mounting proc again and using error
injection to cause the new root dentry allocation to fail.  This in
turn results in proc_kill_sb running with proc_self and
proc_thread_self still retaining their values from the previous mount
of proc.  Then calling dput on either proc_self of proc_thread_self
will result in double put.  Which KASAN sees as a use after free.

Solve this by always reinitializing the filesystem state stored
in the struct pid_namespace, when proc is unmounted.

Reported-by: syzbot+72868dd424eb66c6b95f@syzkaller.appspotmail.com
Fixes: 69879c01a0c3 ("proc: Remove the now unnecessary internal mount of proc")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/proc/root.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index 2633f10446c3..fbf084a7d14c 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -196,6 +196,13 @@ static void proc_kill_sb(struct super_block *sb)
 	if (ns->proc_thread_self)
 		dput(ns->proc_thread_self);
 	kill_anon_super(sb);
+
+	/* Make the pid namespace safe for a new mount of proc */
+	ns->proc_self = NULL;
+	ns->proc_thread_self = NULL;
+	ns->pid_gid = GLOBAL_ROOT_GID;
+	ns->hide_pid = 0;
+
 	put_pid_ns(ns);
 }
 
-- 
2.20.1

This should fix the reported syzbot failure.

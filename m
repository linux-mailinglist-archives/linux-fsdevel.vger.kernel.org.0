Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43E63369D3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 04:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfFFCI7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 22:08:59 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59224 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfFFCI6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 22:08:58 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x5628UTB064831;
        Thu, 6 Jun 2019 11:08:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Thu, 06 Jun 2019 11:08:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x5628TDc064823;
        Thu, 6 Jun 2019 11:08:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x5628T0g064822;
        Thu, 6 Jun 2019 11:08:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201906060208.x5628T0g064822@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: KASAN: use-after-free Read in =?ISO-2022-JP?B?dG9tb3lvX3JlYWxwYXRo?=
 =?ISO-2022-JP?B?X2Zyb21fcGF0aA==?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     syzbot <syzbot+0341f6a4d729d4e0acf1@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp
MIME-Version: 1.0
Date:   Thu, 06 Jun 2019 11:08:29 +0900
References: <0000000000004f43fa058a97f4d3@google.com>
In-Reply-To: <0000000000004f43fa058a97f4d3@google.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here is a reproducer.

The problem is that TOMOYO is accessing already freed socket from security_file_open()
which later fails with -ENXIO (because we can't get file descriptor of sockets via
/proc/pid/fd/n interface), and the file descriptor is getting released before
security_file_open() completes because we do not raise "struct file"->f_count of
the file which is accessible via /proc/pid/fd/n interface. We can avoid this problem
if we can avoid calling security_file_open() which after all fails with -ENXIO.
How should we handle this race? Let LSM modules check if security_file_open() was
called on a socket?

----------------------------------------
diff --git a/fs/open.c b/fs/open.c
index b5b80469b93d..995ffcb37128 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -765,6 +765,12 @@ static int do_dentry_open(struct file *f,
 	error = security_file_open(f);
 	if (error)
 		goto cleanup_all;
+	if (!strcmp(current->comm, "a.out") &&
+	    f->f_path.dentry->d_sb->s_magic == SOCKFS_MAGIC) {
+		printk("Start open(socket) delay\n");
+		schedule_timeout_killable(HZ * 5);
+		printk("End open(socket) delay\n");
+	}
 
 	error = break_lease(locks_inode(f), f->f_flags);
 	if (error)
----------------------------------------

----------------------------------------
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/socket.h>

int main(int argc, char *argv[])
{
	pid_t pid = getpid();
	int fd = socket(AF_ISDN, SOCK_RAW, 0);
	char buffer[128] = { };
	if (fork() == 0) {
		close(fd);
		snprintf(buffer, sizeof(buffer) - 1, "/proc/%u/fd/%u", pid, fd);
		open(buffer, 3);
		_exit(0);
	}
	sleep(2);
	close(fd);
	return 0;
}
----------------------------------------

----------------------------------------
getpid()                                = 32504
socket(AF_ISDN, SOCK_RAW, 0)            = 3
clone(strace: Process 32505 attached
child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7efea30dda10) = 32505
[pid 32504] rt_sigprocmask(SIG_BLOCK, [CHLD],  <unfinished ...>
[pid 32505] close(3 <unfinished ...>
[pid 32504] <... rt_sigprocmask resumed> [], 8) = 0
[pid 32505] <... close resumed> )       = 0
[pid 32504] rt_sigaction(SIGCHLD, NULL, {SIG_DFL, [], 0}, 8) = 0
[pid 32505] open("/proc/32504/fd/3", O_ACCMODE <unfinished ...>
[pid 32504] rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
[pid 32504] nanosleep({2, 0}, 0x7ffd3c608150) = 0
[pid 32504] close(3)                    = 0
[pid 32504] exit_group(0)               = ?
[pid 32504] +++ exited with 0 +++
<... open resumed> )                    = -1 ENXIO (No such device or address)
exit_group(0)                           = ?
----------------------------------------

----------------------------------------
[   95.109628] Start open(socket) delay
[   97.113150] base_sock_release(00000000506a3239) sk=00000000016d0ceb
[  100.142235] End open(socket) delay
----------------------------------------

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7579E36B7B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 07:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfFFFVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 01:21:05 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52220 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFFVF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 01:21:05 -0400
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x565KdJh017988;
        Thu, 6 Jun 2019 14:20:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp);
 Thu, 06 Jun 2019 14:20:39 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x565KdJL017984;
        Thu, 6 Jun 2019 14:20:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x565Kd8j017983;
        Thu, 6 Jun 2019 14:20:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201906060520.x565Kd8j017983@www262.sakura.ne.jp>
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
Date:   Thu, 06 Jun 2019 14:20:39 +0900
References: <0000000000004f43fa058a97f4d3@google.com> 
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tetsuo Handa wrote:
> The problem is that TOMOYO is accessing already freed socket from security_file_open()
> which later fails with -ENXIO (because we can't get file descriptor of sockets via
> /proc/pid/fd/n interface), and the file descriptor is getting released before
> security_file_open() completes because we do not raise "struct file"->f_count of
> the file which is accessible via /proc/pid/fd/n interface. We can avoid this problem
> if we can avoid calling security_file_open() which after all fails with -ENXIO.
> How should we handle this race? Let LSM modules check if security_file_open() was
> called on a socket?

Well, just refusing security_file_open() is not sufficient, for open(O_PATH) allows installing
file descriptor where SOCKET_I(inode)->sk can change at any moment, and TOMOYO cannot tell
whether it is safe to access SOCKET_I(inode)->sk from security_inode_getattr().

But refusing open(O_PATH) as well might break userspace programs. Oh, no...

----------------------------------------
diff --git a/fs/open.c b/fs/open.c
index b5b80469b93d..ea69668e2cd8 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -728,6 +728,16 @@ static int do_dentry_open(struct file *f,
 	/* Ensure that we skip any errors that predate opening of the file */
 	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
 
+	/*
+	 * Sockets must not be opened via /proc/pid/fd/n, even with O_PATH,
+	 * for SOCKET_I(inode)->sk can be kfree()d at any moment after a file
+	 * descriptor obtained by opening /proc/pid/fd/n was installed.
+	 */
+	if (unlikely(S_ISSOCK(inode->i_mode))) {
+		error = (f->f_flags & O_PATH) ? -ENOENT : -ENXIO;
+		goto cleanup_file;
+	}
+
 	if (unlikely(f->f_flags & O_PATH)) {
 		f->f_mode = FMODE_PATH | FMODE_OPENED;
 		f->f_op = &empty_fops;
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
        int fd = socket(AF_INET, SOCK_STREAM, 0);
        char buffer[128] = { };
        if (fork() == 0) {
                struct stat buf = { };
                close(fd);
                snprintf(buffer, sizeof(buffer) - 1, "/proc/%u/fd/%u", pid, fd);
                fd = open(buffer, __O_PATH);
                sleep(5);
                fstat(fd, &buf);
                _exit(0);
        }
        sleep(2);
        close(fd);
        return 0;
}
----------------------------------------

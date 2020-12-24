Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A18C2E2620
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Dec 2020 12:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgLXLQn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Dec 2020 06:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbgLXLQm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:16:42 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B34CC061794;
        Thu, 24 Dec 2020 03:16:02 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 190so1313603wmz.0;
        Thu, 24 Dec 2020 03:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CirzsjrDi6dx5tYSd15ZDh8C9gtBGUsMQg6r5WY8wv4=;
        b=tget8qBV0JAHWPO6rLwJ8m4w95G9QFH1cPmN3iqpM4n/KZ5YCryp7lluFWVZCzks2+
         m8//j2RH9E7So+qrEHEPFtDPRW1bWkpk3bE8K67J/yD/frebIJERVlsGcJF9M3sqkM1v
         xwxCWiFR0a0P+97CZh0OtK7OpPp4IF5W+Y8B66mE00SMLwq0P4R04Az94ARPQpp7/bXF
         X9VaaV4X8Ydqi3uWmnEvvSIno632xEzXTcm/42QByebVVOFTsmmYbWGnmhSdi24GHq9x
         iSyLXVNZ2WawrCcpkhGGMDXvBR2FimdG6297/5GUAjPgu/qom9XQ9n6P83/7yWZt7vOz
         6qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CirzsjrDi6dx5tYSd15ZDh8C9gtBGUsMQg6r5WY8wv4=;
        b=h5t0yN1gWVi+AFSI41O44j2GGo8NX6hI7hJG4Lqq3XESnllSO9ouF3wPBfFx7vQmNY
         zn9DwgIM979d6f/GaYoHzlgVpfFnKxKcPItUxzJlk+dpaRQCvvHira/XdpAPkFUL0wdo
         CT7T3RSTSTjn3zITY1aZCM4i6J+Ta6Xwu8noD+AFIqFdhci4x9kVhJiErho/+DCRFoiA
         rf9txCR1CE1Su+bpnrSaZiVHjeVMM8KbjEdeQTbvOKitPySODFW+hWeR86xw+UOMtGZC
         x72mxxPzcjIdfmAxBzSAHGkslEUw07/qsBjPJmKXYuQkgphwV++9bo3Xs5OD/QG5f5zS
         0knQ==
X-Gm-Message-State: AOAM530kAfLqwq2y8VLlzEDNtFz7MKWfET4O4EyqH6W4qesCwMsX8cng
        KNVIwYmXWCJNvo/kJx26Wqw=
X-Google-Smtp-Source: ABdhPJy9ZkGk1TgUFquJmfDoXgtw8fCP8SzWOSvkyjyqFnnb7sCTmhAGiWZnO3A2+AfBM009khTQHA==
X-Received: by 2002:a1c:e342:: with SMTP id a63mr4047991wmh.64.1608808561148;
        Thu, 24 Dec 2020 03:16:01 -0800 (PST)
Received: from localhost.localdomain (bzq-79-176-17-5.red.bezeqint.net. [79.176.17.5])
        by smtp.googlemail.com with ESMTPSA id g191sm3320837wmg.39.2020.12.24.03.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Dec 2020 03:16:00 -0800 (PST)
From:   Lior Ribak <liorribak@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        liorribak@gmail.com
Subject: [PATCH] binfmt_misc: Fix possible deadlock in bm_register_write
Date:   Thu, 24 Dec 2020 13:15:33 +0200
Message-Id: <20201224111533.24719-1-liorribak@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a deadlock in bm_register_write:
First, in the beggining of the function, a lock is taken on the
binfmt_misc root inode with inode_lock(d_inode(root))
Then, if the user used the MISC_FMT_OPEN_FILE flag, the function will
call open_exec on the user-provided interpreter.
open_exec will call a path lookup, and if the path lookup process
includes the root of binfmt_misc, it will try to take a shared lock
on its inode again, but it is already locked, and the code will
get stuck in a deadlock

To reproduce the bug:
$ echo ":iiiii:E::ii::/proc/sys/fs/binfmt_misc/bla:F" > /proc/sys/fs/binfmt_misc/register

backtrace of where the lock occurs (#5):
0  schedule () at ./arch/x86/include/asm/current.h:15
1  0xffffffff81b51237 in rwsem_down_read_slowpath (sem=0xffff888003b202e0, count=<optimized out>, state=state@entry=2) at kernel/locking/rwsem.c:992
2  0xffffffff81b5150a in __down_read_common (state=2, sem=<optimized out>) at kernel/locking/rwsem.c:1213
3  __down_read (sem=<optimized out>) at kernel/locking/rwsem.c:1222
4  down_read (sem=<optimized out>) at kernel/locking/rwsem.c:1355
5  0xffffffff811ee22a in inode_lock_shared (inode=<optimized out>) at ./include/linux/fs.h:783
6  open_last_lookups (op=0xffffc9000022fe34, file=0xffff888004098600, nd=0xffffc9000022fd10) at fs/namei.c:3177
7  path_openat (nd=nd@entry=0xffffc9000022fd10, op=op@entry=0xffffc9000022fe34, flags=flags@entry=65) at fs/namei.c:3366
8  0xffffffff811efe1c in do_filp_open (dfd=<optimized out>, pathname=pathname@entry=0xffff8880031b9000, op=op@entry=0xffffc9000022fe34) at fs/namei.c:3396
9  0xffffffff811e493f in do_open_execat (fd=fd@entry=-100, name=name@entry=0xffff8880031b9000, flags=<optimized out>, flags@entry=0) at fs/exec.c:913
10 0xffffffff811e4a92 in open_exec (name=<optimized out>) at fs/exec.c:948
11 0xffffffff8124aa84 in bm_register_write (file=<optimized out>, buffer=<optimized out>, count=19, ppos=<optimized out>) at fs/binfmt_misc.c:682
12 0xffffffff811decd2 in vfs_write (file=file@entry=0xffff888004098500, buf=buf@entry=0xa758d0 ":iiiii:E::ii::i:CF\n", count=count@entry=19, pos=pos@entry=0xffffc9000022ff10) at fs/read_write.c:603
13 0xffffffff811defda in ksys_write (fd=<optimized out>, buf=0xa758d0 ":iiiii:E::ii::i:CF\n", count=19) at fs/read_write.c:658
14 0xffffffff81b49813 in do_syscall_64 (nr=<optimized out>, regs=0xffffc9000022ff58) at arch/x86/entry/common.c:46
15 0xffffffff81c0007c in entry_SYSCALL_64 () at arch/x86/entry/entry_64.S:120

To solve the issue, the open_exec call is moved to before the write
lock is taken by bm_register_write

Signed-off-by: Lior Ribak <liorribak@gmail.com>
---
 fs/binfmt_misc.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 3880a82da1dc..5f8f34c8a053 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -647,12 +647,23 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 	struct super_block *sb = file_inode(file)->i_sb;
 	struct dentry *root = sb->s_root, *dentry;
 	int err = 0;
+	struct file *f = NULL;
 
 	e = create_entry(buffer, count);
 
 	if (IS_ERR(e))
 		return PTR_ERR(e);
 
+	if (e->flags & MISC_FMT_OPEN_FILE) {
+		f = open_exec(e->interpreter);
+		if (IS_ERR(f)) {
+			pr_notice("register: failed to install interpreter file %s\n",
+				 e->interpreter);
+			return PTR_ERR(f);
+		}
+		e->interp_file = f;
+	}
+
 	inode_lock(d_inode(root));
 	dentry = lookup_one_len(e->name, root, strlen(e->name));
 	err = PTR_ERR(dentry);
@@ -676,21 +687,6 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 		goto out2;
 	}
 
-	if (e->flags & MISC_FMT_OPEN_FILE) {
-		struct file *f;
-
-		f = open_exec(e->interpreter);
-		if (IS_ERR(f)) {
-			err = PTR_ERR(f);
-			pr_notice("register: failed to install interpreter file %s\n", e->interpreter);
-			simple_release_fs(&bm_mnt, &entry_count);
-			iput(inode);
-			inode = NULL;
-			goto out2;
-		}
-		e->interp_file = f;
-	}
-
 	e->dentry = dget(dentry);
 	inode->i_private = e;
 	inode->i_fop = &bm_entry_operations;
@@ -707,6 +703,8 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 	inode_unlock(d_inode(root));
 
 	if (err) {
+		if (f)
+			filp_close(f, NULL);
 		kfree(e);
 		return err;
 	}
-- 
2.17.1


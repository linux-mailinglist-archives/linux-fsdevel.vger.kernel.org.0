Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3903274F7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Feb 2021 23:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhB1Wrg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Feb 2021 17:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhB1Wrf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Feb 2021 17:47:35 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4442BC06174A;
        Sun, 28 Feb 2021 14:46:55 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d11so14139553wrj.7;
        Sun, 28 Feb 2021 14:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xhlwoHgoag22c/OnIU6YItPlWONw4dkAGC1UA9P8T10=;
        b=M7wYrEpHzgUhKnL7QGtlmkVRzWmFYqwsPKbfTczjC4CKEmW26ZcWShCny9xmZVzkCZ
         MozteBv53jCFTB2EXnvFIRm8DNuCGDZeDIUGCMBi2aod+HkRtPWt+WOABXfxEevbJxTG
         ZWpN2xW5GGh7+cnQ4/lCUmon0N9mosnuxVfg7vCgcKU7kmO5G6uuK4gDhoQxFherbIii
         Ce3FmyhQVw/efkcbp57L8aiO9wYlSXh7Igs4IjxT+AEWdFJo/eTvRNcSKP41J0+adi1f
         cG6RgTRmhuKsxXXx3cuFNzbFYA/BmoyzKnweYU5YhSi6OlCKGclay0NqhVTn9or1CJWy
         +Vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xhlwoHgoag22c/OnIU6YItPlWONw4dkAGC1UA9P8T10=;
        b=MEQDxN3d954mBG1c8DluR2918SSh1295rxZHaz8izVZcwOcIiArmUJ4oqCvtTCbcC9
         53Bb8NjHdyCwgDbbsh43esn1VJNCm+jHn3Zs42yxHWKvBpDX/WizaSm83Xf/MkCF0MOa
         RZmWA6qzuneiQAabqVX0OSK7WClAQDfb8goF9iJvyBY2BHsS4+AwCRssD2VofkaeiRTG
         +BFzYFqZW4TD07ry15NS7UI6J9FHBfJuHAWpXaeTK0z6p2UeM9zAir4uBtZyEIM7dDcb
         jp6ZpMoXKXWjZ6hUTb5OhqDfyurBaKzKtZL589ZF8jvsnQSBBLxnccYRWReClQx7xDcM
         JdxQ==
X-Gm-Message-State: AOAM530S2H9DzR/0FA9L9wAy4ajfgsU1A/we+t3wuVaZVdo+UqYv2oeh
        Gg10+CWtA4IkR1oNVsoYyxc=
X-Google-Smtp-Source: ABdhPJwUypNba/VOBHgduU8n6jQ2BNqZPYLWgh9k9kJ0vLFVQtfTOQiJgXq32o+a0x9V5c+lQuyN8Q==
X-Received: by 2002:a5d:54c4:: with SMTP id x4mr6815832wrv.329.1614552414077;
        Sun, 28 Feb 2021 14:46:54 -0800 (PST)
Received: from localhost.localdomain (bzq-79-179-86-219.red.bezeqint.net. [79.179.86.219])
        by smtp.googlemail.com with ESMTPSA id h22sm22965134wmb.36.2021.02.28.14.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 14:46:53 -0800 (PST)
From:   Lior Ribak <liorribak@gmail.com>
To:     akpm@linux-foundation.org, deller@gmx.de, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        liorribak@gmail.com
Subject: [PATCH v2] binfmt_misc: Fix possible deadlock in bm_register_write
Date:   Sun, 28 Feb 2021 14:44:14 -0800
Message-Id: <20210228224414.95962-1-liorribak@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201224111533.24719-1-liorribak@gmail.com>
References: <20201224111533.24719-1-liorribak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
v2: Added "kfree(e)" above "return PTR_ERR(f)"

 fs/binfmt_misc.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index c457334de43f..e1eae7ea823a 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -649,12 +649,24 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
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
+			kfree(e);
+			return PTR_ERR(f);
+		}
+		e->interp_file = f;
+	}
+
 	inode_lock(d_inode(root));
 	dentry = lookup_one_len(e->name, root, strlen(e->name));
 	err = PTR_ERR(dentry);
@@ -678,21 +690,6 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
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
@@ -709,6 +706,8 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 	inode_unlock(d_inode(root));
 
 	if (err) {
+		if (f)
+			filp_close(f, NULL);
 		kfree(e);
 		return err;
 	}
-- 
2.25.1


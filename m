Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9050B592062
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Aug 2022 17:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiHNPXc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Aug 2022 11:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiHNPXb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Aug 2022 11:23:31 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1901665E4
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Aug 2022 08:23:30 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id h1so2821864wmd.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Aug 2022 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=pPw4Ay6ix9/eCcBaT6rrH+j4UzvjvTst3e2q4diDqB8=;
        b=R/ApWPVU6x1FDa84JH+pv0uZhk50E1Twe92ZPKDivFlZvQnoGKTNXvvmyvCyTeUGt+
         cqe9zyjfRsGQW2ChorUdg1e2/5SbV238WkUawOUF/1J/4CV3g0WvuNQTVuKzkSlcshJs
         Yqq1WMyIFy4SoudDr4XjqdjIS03GAgM0EISFAg82kNkkUCK+fJU+uHdpY11roDfyRD8t
         3g5/S3VPGGiZqiDBQl6bX2FtFcbELmNnRxZq76gzMeEmkicq1z7qFSWX7Pm828o+miLs
         R2w1NgmZknFqhP6ap9hvZGsXa8YL1a4JcSJFS+FTe/k2/bU3oXQVNp1+YeLbA9dMuusR
         8HAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=pPw4Ay6ix9/eCcBaT6rrH+j4UzvjvTst3e2q4diDqB8=;
        b=IdlUVH6sKxNpLV7HAJdHDvzvC/ojZupHtQORUatS7GQSw8GbCS/PjDDFxHFhGAV/IW
         93+XIQQzAwhlH4OtdYBonbqhV2FzK3wHvzm7CwDt7l5TJn8YatfJsSIyaAGAwq3LYst/
         Ua0UA2iD6MVit49XNmaHAEvRas4Siaq+YLPOUEe3eNXP/U9TO4zSlaAoiisxt7RQp9Q/
         HHvjLb4Fo3e+vGIz0WIceeHXEhxN3gXZOMHT+c+0bCjD/4/ZwIp7bt4OVaA84oFqno0N
         eOlj5RYSnqFhpAvSMOWhV93kXtESFhzvD+jkIo32Ap5V9zAvOW1rsN6Usuo283HDxdC0
         zGRA==
X-Gm-Message-State: ACgBeo3/4Bl7BtknbVmnGYIXMsD+MUbTDoa7IE1w+Wyz2XmSd8b+8ybl
        M7OSlwv1jRPHUSxqGBN3RryDdV16dps=
X-Google-Smtp-Source: AA6agR6Go3Bo/fEIuv6rhPtUeTVky+EuJigBJ4kcDoQlHTCkMulOMx2iFUqReaxSFirGqis5SohzyA==
X-Received: by 2002:a1c:cc04:0:b0:3a5:3f8e:d2a with SMTP id h4-20020a1ccc04000000b003a53f8e0d2amr7936557wmb.138.1660490608470;
        Sun, 14 Aug 2022 08:23:28 -0700 (PDT)
Received: from localhost.localdomain ([5.29.8.191])
        by smtp.gmail.com with ESMTPSA id co26-20020a0560000a1a00b0021e2fccea97sm4762690wrb.64.2022.08.14.08.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 08:23:27 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] locks: fix TOCTOU race when granting write lease
Date:   Sun, 14 Aug 2022 18:23:22 +0300
Message-Id: <20220814152322.569296-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thread A trying to acquire a write lease checks the value of i_readcount
and i_writecount in check_conflicting_open() to verify that its own fd
is the only fd referencing the file.

Thread B trying to open the file for read will call break_lease() in
do_dentry_open() before incrementing i_readcount, which leaves a small
window where thread A can acquire the write lease and then thread B
completes the open of the file for read without breaking the write lease
that was acquired by thread A.

Fix this race by incrementing i_readcount before checking for existing
leases, same as the case with i_writecount.

Use a helper put_file_access() to decrement i_readcount or i_writecount
in do_dentry_open() and __fput().

Fixes: 387e3746d01c ("locks: eliminate false positive conflicts for write lease")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Jeff,

This fixes a race I found during code audit - I do not have a reproducer
for it.

I ran the fstests I found for locks and leases:
generic/131 generic/478 generic/504 generic/571
and the LTP fcntl tests.

Encountered this warning with generic/131, but I also see it on
current master:

 =============================
 WARNING: suspicious RCU usage
 5.19.0-xfstests-14277-gbd6ab3ef4e93 #966 Not tainted
 -----------------------------
 include/net/sock.h:592 suspicious rcu_dereference_check() usage!

 other info that might help us debug this:


 rcu_scheduler_active = 2, debug_locks = 1
 5 locks held by locktest/3996:
  #0: ffff88800be1d7a0 (&sb->s_type->i_mutex_key#8){+.+.}-{3:3}, at: __sock_release+0x25/0x97
  #1: ffff88800909ce00 (sk_lock-AF_INET){+.+.}-{0:0}, at: tcp_close+0x14/0x60
  #2: ffff888006847cc8 (&h->lhash2[i].lock){+.+.}-{2:2}, at: inet_unhash+0x3a/0xcf
  #3: ffffffff82a8ac18 (reuseport_lock){+...}-{2:2}, at: reuseport_detach_sock+0x17/0xb8
  #4: ffff88800909d0b0 (clock-AF_INET){++..}-{2:2}, at: bpf_sk_reuseport_detach+0x1b/0x85

 stack backtrace:
 CPU: 1 PID: 3996 Comm: locktest Not tainted 5.19.0-xfstests-14277-gbd6ab3ef4e93 #966
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x45/0x5d
  bpf_sk_reuseport_detach+0x5c/0x85
  reuseport_detach_sock+0x65/0xb8
  inet_unhash+0x55/0xcf
  tcp_set_state+0xb3/0x10d
  ? mark_lock.part.0+0x30/0x101
  __tcp_close+0x26/0x32d
  tcp_close+0x20/0x60
  inet_release+0x50/0x64
  __sock_release+0x32/0x97
  sock_close+0x14/0x1b
  __fput+0x118/0x1eb


Let me know what you think.

Thanks,
Amir.

 fs/file_table.c    |  7 +------
 fs/open.c          | 11 ++++-------
 include/linux/fs.h | 10 ++++++++++
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 99c6796c9f28..dd88701e54a9 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -324,12 +324,7 @@ static void __fput(struct file *file)
 	}
 	fops_put(file->f_op);
 	put_pid(file->f_owner.pid);
-	if ((mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)
-		i_readcount_dec(inode);
-	if (mode & FMODE_WRITER) {
-		put_write_access(inode);
-		__mnt_drop_write(mnt);
-	}
+	put_file_access(file);
 	dput(dentry);
 	if (unlikely(mode & FMODE_NEED_UNMOUNT))
 		dissolve_on_fput(mnt);
diff --git a/fs/open.c b/fs/open.c
index 8a813fa5ca56..a98572585815 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -840,7 +840,9 @@ static int do_dentry_open(struct file *f,
 		return 0;
 	}
 
-	if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
+	if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ) {
+		i_readcount_inc(inode);
+	} else if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
 		error = get_write_access(inode);
 		if (unlikely(error))
 			goto cleanup_file;
@@ -880,8 +882,6 @@ static int do_dentry_open(struct file *f,
 			goto cleanup_all;
 	}
 	f->f_mode |= FMODE_OPENED;
-	if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)
-		i_readcount_inc(inode);
 	if ((f->f_mode & FMODE_READ) &&
 	     likely(f->f_op->read || f->f_op->read_iter))
 		f->f_mode |= FMODE_CAN_READ;
@@ -935,10 +935,7 @@ static int do_dentry_open(struct file *f,
 	if (WARN_ON_ONCE(error > 0))
 		error = -EINVAL;
 	fops_put(f->f_op);
-	if (f->f_mode & FMODE_WRITER) {
-		put_write_access(inode);
-		__mnt_drop_write(f->f_path.mnt);
-	}
+	put_file_access(f);
 cleanup_file:
 	path_put(&f->f_path);
 	f->f_path.mnt = NULL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9eced4cc286e..8bc04852c3da 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3000,6 +3000,16 @@ static inline void i_readcount_inc(struct inode *inode)
 	return;
 }
 #endif
+static inline void put_file_access(struct file *file)
+{
+	if ((file->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ) {
+		i_readcount_dec(file->f_inode);
+	} else if (file->f_mode & FMODE_WRITER) {
+		put_write_access(file->f_inode);
+		__mnt_drop_write(file->f_path.mnt);
+	}
+}
+
 extern int do_pipe_flags(int *, int);
 
 extern ssize_t kernel_read(struct file *, void *, size_t, loff_t *);
-- 
2.25.1


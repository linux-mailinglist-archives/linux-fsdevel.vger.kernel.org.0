Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD92577449
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Jul 2022 06:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiGQEgU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Jul 2022 00:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGQEgS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Jul 2022 00:36:18 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BAA20F59
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Jul 2022 21:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1658032579; x=1689568579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZSprJ0SPuxg8XyYLSn8PWRBO9nsALsvxRTVl4LRzvZA=;
  b=T4FK9bzt6ZbVtPGgFGMHJIm/5txerlj+z97MISAhfnbgmn2QU+Hz+VCW
   N23prZUmPCQZ/FPHOmVcGdM5QSY8F3yV2tw8Uf9fW6kr4RiSEoIDgHV6i
   clSlnM5z42mZ8/CxZMvuBg3QIYNv30PZwmY59gblgKUbhf4T/vsOOkvlR
   M=;
X-IronPort-AV: E=Sophos;i="5.92,278,1650931200"; 
   d="scan'208";a="219194447"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-7d0c7241.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 17 Jul 2022 04:36:17 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-7d0c7241.us-west-2.amazon.com (Postfix) with ESMTPS id 1D42743F9E;
        Sun, 17 Jul 2022 04:36:16 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Sun, 17 Jul 2022 04:36:15 +0000
Received: from 88665a182662.ant.amazon.com (10.43.162.124) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.9;
 Sun, 17 Jul 2022 04:36:13 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
CC:     Kuniyuki Iwashima <kuniyu@amazon.com>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v3 2/2] fs/lock: Rearrange ops in flock syscall.
Date:   Sat, 16 Jul 2022 21:35:32 -0700
Message-ID: <20220717043532.35821-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220717043532.35821-1-kuniyu@amazon.com>
References: <20220717043532.35821-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.162.124]
X-ClientProxiedBy: EX13d09UWC001.ant.amazon.com (10.43.162.60) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The previous patch added flock_translate_cmd() in flock syscall.
The test and the other one for LOCK_MAND do not depend on struct
fd and are cheaper, so we can put them at the top and defer
fdget() after that.

Also, we can remove the unlock variable and use type instead.
While at it, we fix this checkpatch error.

  CHECK: spaces preferred around that '|' (ctx:VxV)
  #45: FILE: fs/locks.c:2099:
  +	if (type != F_UNLCK && !(f.file->f_mode & (FMODE_READ|FMODE_WRITE)))
   	                                                     ^

Finally, we can move the can_sleep part just before we use it.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 fs/locks.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index b134eaefd7d6..c266cfdc3291 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2083,20 +2083,9 @@ EXPORT_SYMBOL(locks_lock_inode_wait);
  */
 SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 {
-	int can_sleep, error, unlock, type;
-	struct fd f = fdget(fd);
+	int can_sleep, error, type;
 	struct file_lock fl;
-
-	error = -EBADF;
-	if (!f.file)
-		goto out;
-
-	can_sleep = !(cmd & LOCK_NB);
-	cmd &= ~LOCK_NB;
-	unlock = (cmd == LOCK_UN);
-
-	if (!unlock && !(f.file->f_mode & (FMODE_READ|FMODE_WRITE)))
-		goto out_putf;
+	struct fd f;
 
 	/*
 	 * LOCK_MAND locks were broken for a long time in that they never
@@ -2108,35 +2097,41 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 	 */
 	if (cmd & LOCK_MAND) {
 		pr_warn_once("Attempt to set a LOCK_MAND lock via flock(2). This support has been removed and the request ignored.\n");
-		error = 0;
-		goto out_putf;
+		return 0;
 	}
 
-	type = flock_translate_cmd(cmd);
-	if (type < 0) {
-		error = type;
+	type = flock_translate_cmd(cmd & ~LOCK_NB);
+	if (type < 0)
+		return type;
+
+	error = -EBADF;
+	f = fdget(fd);
+	if (!f.file)
+		return error;
+
+	if (type != F_UNLCK && !(f.file->f_mode & (FMODE_READ | FMODE_WRITE)))
 		goto out_putf;
-	}
 
 	flock_make_lock(f.file, &fl, type);
 
-	if (can_sleep)
-		fl.fl_flags |= FL_SLEEP;
-
 	error = security_file_lock(f.file, fl.fl_type);
 	if (error)
 		goto out_putf;
 
+	can_sleep = !(cmd & LOCK_NB);
+	if (can_sleep)
+		fl.fl_flags |= FL_SLEEP;
+
 	if (f.file->f_op->flock)
 		error = f.file->f_op->flock(f.file,
-					  (can_sleep) ? F_SETLKW : F_SETLK,
+					    (can_sleep) ? F_SETLKW : F_SETLK,
 					    &fl);
 	else
 		error = locks_lock_file_wait(f.file, &fl);
 
  out_putf:
 	fdput(f);
- out:
+
 	return error;
 }
 
-- 
2.30.2


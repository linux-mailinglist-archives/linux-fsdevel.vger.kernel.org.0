Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F0A577276
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Jul 2022 01:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbiGPXej (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Jul 2022 19:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiGPXeg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:34:36 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D740564E2
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Jul 2022 16:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1658014476; x=1689550476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TiVc2FfVoxMDOEPXuBluzujyVpf8iXfn8wlqW8JcGnA=;
  b=X9WYjbmhiYt6hXsiVv7ksQtD5uwZ+basicdmiORPIroAXm9tCtPdmHqm
   Wdgi7jAKGv5fqhgck9ofCfMqcUPj0hJnr0gAwcrSyL+83OHiAZdg56+ii
   MDU252gH2PS79hJrd50Ygcc0x+bnByY1ULAZir9yYAxkqg+3VDw0T13Cr
   o=;
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-828bd003.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 16 Jul 2022 23:34:35 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-828bd003.us-east-1.amazon.com (Postfix) with ESMTPS id EBDDD80F5B;
        Sat, 16 Jul 2022 23:34:34 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Sat, 16 Jul 2022 23:34:34 +0000
Received: from 88665a182662.ant.amazon.com (10.43.162.124) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.9;
 Sat, 16 Jul 2022 23:34:32 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
CC:     Kuniyuki Iwashima <kuniyu@amazon.com>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2 2/2] fs/lock: Rearrange ops in flock syscall.
Date:   Sat, 16 Jul 2022 16:33:43 -0700
Message-ID: <20220716233343.22106-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220716233343.22106-1-kuniyu@amazon.com>
References: <20220716233343.22106-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.162.124]
X-ClientProxiedBy: EX13D03UWA003.ant.amazon.com (10.43.160.39) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The previous patch added flock_translate_cmd() in flock syscall.
The test does not depend on struct fd and the cheapest, so we can
put it at the top and defer fdget() after that.

Also, we can remove the unlock variable and use type instead.
As a bonus, we fix this checkpatch error.

  CHECK: spaces preferred around that '|' (ctx:VxV)
  #45: FILE: fs/locks.c:2099:
  +	if (type != F_UNLCK && !(f.file->f_mode & (FMODE_READ|FMODE_WRITE)))
   	                                                     ^

Finally, we can move the can_sleep part just before we use it.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 fs/locks.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index b134eaefd7d6..97581678c4d4 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2083,19 +2083,20 @@ EXPORT_SYMBOL(locks_lock_inode_wait);
  */
 SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 {
-	int can_sleep, error, unlock, type;
-	struct fd f = fdget(fd);
+	int can_sleep, error, type;
 	struct file_lock fl;
+	struct fd f;
+
+	type = flock_translate_cmd(cmd & ~LOCK_NB);
+	if (type < 0)
+		return type;
 
 	error = -EBADF;
+	f = fdget(fd);
 	if (!f.file)
-		goto out;
-
-	can_sleep = !(cmd & LOCK_NB);
-	cmd &= ~LOCK_NB;
-	unlock = (cmd == LOCK_UN);
+		return error;
 
-	if (!unlock && !(f.file->f_mode & (FMODE_READ|FMODE_WRITE)))
+	if (type != F_UNLCK && !(f.file->f_mode & (FMODE_READ | FMODE_WRITE)))
 		goto out_putf;
 
 	/*
@@ -2112,31 +2113,26 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 		goto out_putf;
 	}
 
-	type = flock_translate_cmd(cmd);
-	if (type < 0) {
-		error = type;
-		goto out_putf;
-	}
-
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


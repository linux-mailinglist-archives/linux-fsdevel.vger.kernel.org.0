Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB36754CF7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jul 2023 03:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjGPBH1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jul 2023 21:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGPBH0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jul 2023 21:07:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2878271E;
        Sat, 15 Jul 2023 18:07:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A29D60C50;
        Sun, 16 Jul 2023 01:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263FBC433C7;
        Sun, 16 Jul 2023 01:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689469644;
        bh=mhbeZbmJ8cgRm2S2OrbZPpndTJoUeLfpEMLdIjnkKcs=;
        h=From:To:Cc:Subject:Date:From;
        b=O6yNQy7Y6D9tnpWIsEoDvSwfK+5MzF4ll6vYZTe2H7TpjDMb0wwM9RDUVdGJraXH7
         ZvOE4MFGJs2n/MGTeD1KYEzqiGFVwqW1Va/acg/VsNPUmnexarZNTeW9V9uodFxuAZ
         lc9I21QX5O4ANB4QV85Bso2fcl0Rwhins8w9SUrmHzUwNDo/i7pOe907KKPE3Elb2N
         1fKUPy9fXgO5IPnQc62zSdY8xSri+3Jfw9vb8+IcQJ/YaKr1K/a2TPFL0F+qW4CESh
         LiHWONGDEfD5ffA43uw4RvOQlKEYgaZOzOAGNJ1U5OsgGhWgqdfHSuU4Hceb9Nujaz
         W4JGvWGss+qjw==
From:   Chao Yu <chao@kernel.org>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] fs: select: reduce stack usage in do_select()
Date:   Sun, 16 Jul 2023 09:07:13 +0800
Message-Id: <20230716010714.3009192-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

struct poll_wqueues table caused the stack usage of do_select() to
grow beyond the warning limit on 32-bit architectures w/ gcc.

fs/select.c: In function ‘do_select’:
fs/select.c:615:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Allocating dynamic memory in do_select() to fix this issue.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/select.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 0ee55af1a55c..1b729494b4e9 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -479,23 +479,29 @@ static inline void wait_key_set(poll_table *wait, unsigned long in,
 static int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
 {
 	ktime_t expire, *to = NULL;
-	struct poll_wqueues table;
+	struct poll_wqueues *table;
 	poll_table *wait;
 	int retval, i, timed_out = 0;
 	u64 slack = 0;
 	__poll_t busy_flag = net_busy_loop_on() ? POLL_BUSY_LOOP : 0;
 	unsigned long busy_start = 0;
 
+	table = kmalloc(sizeof(struct poll_wqueues), GFP_KERNEL);
+	if (!table)
+		return -ENOMEM;
+
 	rcu_read_lock();
 	retval = max_select_fd(n, fds);
 	rcu_read_unlock();
 
-	if (retval < 0)
+	if (retval < 0) {
+		kfree(table);
 		return retval;
+	}
 	n = retval;
 
-	poll_initwait(&table);
-	wait = &table.pt;
+	poll_initwait(table);
+	wait = &table->pt;
 	if (end_time && !end_time->tv_sec && !end_time->tv_nsec) {
 		wait->_qproc = NULL;
 		timed_out = 1;
@@ -578,8 +584,8 @@ static int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
 		wait->_qproc = NULL;
 		if (retval || timed_out || signal_pending(current))
 			break;
-		if (table.error) {
-			retval = table.error;
+		if (table->error) {
+			retval = table->error;
 			break;
 		}
 
@@ -604,12 +610,14 @@ static int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
 			to = &expire;
 		}
 
-		if (!poll_schedule_timeout(&table, TASK_INTERRUPTIBLE,
+		if (!poll_schedule_timeout(table, TASK_INTERRUPTIBLE,
 					   to, slack))
 			timed_out = 1;
 	}
 
-	poll_freewait(&table);
+	poll_freewait(table);
+
+	kfree(table);
 
 	return retval;
 }
-- 
2.40.1


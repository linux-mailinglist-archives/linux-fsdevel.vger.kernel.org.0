Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6ACE754CF9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jul 2023 03:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjGPBHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jul 2023 21:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGPBH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jul 2023 21:07:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1E8271E;
        Sat, 15 Jul 2023 18:07:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8F0A60C50;
        Sun, 16 Jul 2023 01:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03522C433CB;
        Sun, 16 Jul 2023 01:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689469646;
        bh=mYsvDnuYu9s9yALvnpDkUlPCe+7dcYo5xFfiL+crFXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AdrJCcpssaAJtAZTtodt2ryfuwedIZee7+9LQyol9T+AjjpMF9dEARwRVvU37wZi2
         A9HE3B09Sd1gjWkRA1XvTKeulG1DQlYrClBZTIcDeCQFYWqFj3i/DjX8mm5f+/q14V
         eKDEmSLRzsykMWFSXRVQClTn5+ESxubHTExHwqjBUHxEI8Y8kD/9W8htIrRjFGU7WV
         QGaa+xMn8RJV+574xS+32IW+IeRrcs3EBCTuk8eB+Sm4gBfeXtC6wopnttOdBeYW53
         fkYKSGR/6VFgTL1h03RjpRk/jaRipjUXV9vYhkzpfacPF3KCSsPbH2cdEHcfLm4yZo
         6eDm6G0hwYGsw==
From:   Chao Yu <chao@kernel.org>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] fs: select: reduce stack usage in do_sys_poll()
Date:   Sun, 16 Jul 2023 09:07:14 +0800
Message-Id: <20230716010714.3009192-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230716010714.3009192-1-chao@kernel.org>
References: <20230716010714.3009192-1-chao@kernel.org>
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

struct poll_wqueues table caused the stack usage of do_sys_poll() to
grow beyond the warning limit on 32-bit architectures w/ gcc.

fs/select.c: In function ‘do_sys_poll’:
fs/select.c:1053:1: warning: the frame size of 1328 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Allocating dynamic memory in do_sys_poll() to fix this issue.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/select.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 1b729494b4e9..2b9db5c938d9 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -982,7 +982,7 @@ static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
 static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
 		struct timespec64 *end_time)
 {
-	struct poll_wqueues table;
+	struct poll_wqueues *table;
 	int err = -EFAULT, fdcount, len;
 	/* Allocate small arguments on the stack to save memory and be
 	   faster - use long to make sure the buffer is aligned properly
@@ -992,8 +992,14 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
  	struct poll_list *walk = head;
  	unsigned long todo = nfds;
 
-	if (nfds > rlimit(RLIMIT_NOFILE))
-		return -EINVAL;
+	table = kmalloc(sizeof(struct poll_wqueues), GFP_KERNEL);
+	if (!table)
+		return -ENOMEM;
+
+	if (nfds > rlimit(RLIMIT_NOFILE)) {
+		err = -EINVAL;
+		goto out_table;
+	}
 
 	len = min_t(unsigned int, nfds, N_STACK_PPS);
 	for (;;) {
@@ -1019,9 +1025,9 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
 		}
 	}
 
-	poll_initwait(&table);
-	fdcount = do_poll(head, &table, end_time);
-	poll_freewait(&table);
+	poll_initwait(table);
+	fdcount = do_poll(head, table, end_time);
+	poll_freewait(table);
 
 	if (!user_write_access_begin(ufds, nfds * sizeof(*ufds)))
 		goto out_fds;
@@ -1043,7 +1049,8 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
 		walk = walk->next;
 		kfree(pos);
 	}
-
+out_table:
+	kfree(table);
 	return err;
 
 Efault:
-- 
2.40.1


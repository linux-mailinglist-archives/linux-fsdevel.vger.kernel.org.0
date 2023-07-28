Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C05B766DFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 15:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbjG1NWE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 09:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjG1NWD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:22:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D6A19BF;
        Fri, 28 Jul 2023 06:22:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F180962111;
        Fri, 28 Jul 2023 13:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E324DC433C8;
        Fri, 28 Jul 2023 13:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690550521;
        bh=BWNdvlVBxmTX4HBWkWikwKLite/l018JUea+q9vpOSQ=;
        h=From:Date:Subject:To:Cc:From;
        b=kYddY89bwLAsJQiGEn5hhVv85YkfB+CGBmvDTiEJTSkdA/3X8O+cqMTqaieD+nDj4
         KZnMv9ZKIZabaeqvqNDJfUpHChEkybeyP5o5UHI6Lib9qVjaVdX3+kuIo8U1S5d3TN
         54YtON/Mdwu1ZZnQP1wbNEv89PHHVJUmxE3hTcMJBerCetDhsxK8ER0ojlVMG0hGrR
         r9ybvsUbCB6fdZd8yWXAq6SVbVUVay2gBhYZJtZPvS52xDAckHQyfwIiEGW5Ax1Vbg
         PzZPdMDsRU24fTZjpsd0iBhZlfEKW1jf4rK7/KK4SvbA5Y9SJ60SSMHO1msNOk3ajZ
         y/On6r8CFbW2A==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Fri, 28 Jul 2023 09:21:37 -0400
Subject: [PATCH] fs: compare truncated timestamps in current_mgtime
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230728-mgctime-v1-1-5b0ddc5df08e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAODAw2QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDcyML3dz05JLM3FRd01SD1GSDVAvLJAMTJaDqgqLUtMwKsEnRsbW1ALW
 sMS9ZAAAA
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2038; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=BWNdvlVBxmTX4HBWkWikwKLite/l018JUea+q9vpOSQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBkw8D4pJpahgkJEeHFHsp7WsETMNpKt8cmCmLD4
 lPCyeqLnkCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZMPA+AAKCRAADmhBGVaC
 Fbp4D/0X9Sp659D5Gk0EPTxpKwy/cyKLhgFyxaBzwDzmC10iZc2wUZaFJr1vJek24dsGIVwQG6o
 eNTMPNx5XhZw5jWqnMJj21ovegpjRC36bd6F4jgIfHTvlizeAQqHKgdL+IYT+2c4wfaMoDwrDKR
 vlUPL8mNrEKa/pwxk1GPg8BFfbQoJARLLgfQVo0I8bKAtGxPzEVD/yRAVnPQHTIl1RPktax9BFr
 vAyc6r0dsRYIyBXikuWoqFqj6ISdjpkI3xlOLdZd2cvYO4LbaXM9Qj557rX3DUKHdszLs/P5BAy
 jElWM9LwJD0CPl7kG200wKV391b7eC1MNV8ochZB67v/2hU5NSCQmZAgv7qp0rCfXJa7rgDALMk
 IdrFPLJJtRxPAdj/oIJyLwuO4qI6MheuMM9cKfmUBXrp+4X3vlTWDSYmkGfZ6Xjks5qKSQDquHH
 JrL1S+t+2dAXC82MBO+XFv0baCr4JVMtewklsccXw0iH1VbmmUeU4Onn+tSfLbIIElCV4Ni9erS
 BdREuq3Xs/cdnitOqYQidCn+DVVyaqnUVL7oIU1QQ/UbnmLAswYNOBZIPxRl+DSSZeiTuDjS/gy
 NH+QY9IgI+1Rj5E5jIgK1runNp2244/w4J0UFmwYPS8lgonRvHbvhFdbSEwfth2wUcPOJNzY2Bd
 8GDGTrsApahU+/Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

current_mgtime compares the ctime (which has already been truncated) to
the value from ktime_get_coarse_real_ts64 (which has not). All of the
existing filesystems that enable mgtime have 1ns granularity, so this is
not a problem today, but it is more correct to compare truncated
timestamps instead.

Do the truncate earlier, so we're comparing like things.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 369621e7faf5..8199d0e02cce 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2097,28 +2097,28 @@ EXPORT_SYMBOL(file_remove_privs);
  */
 static struct timespec64 current_mgtime(struct inode *inode)
 {
-	struct timespec64 now;
+	struct timespec64 now, ctime;
 	atomic_long_t *pnsec = (atomic_long_t *)&inode->__i_ctime.tv_nsec;
 	long nsec = atomic_long_read(pnsec);
 
 	if (nsec & I_CTIME_QUERIED) {
 		ktime_get_real_ts64(&now);
-	} else {
-		struct timespec64 ctime;
+		return timestamp_truncate(now, inode);
+	}
 
-		ktime_get_coarse_real_ts64(&now);
+	ktime_get_coarse_real_ts64(&now);
+	now = timestamp_truncate(now, inode);
 
-		/*
-		 * If we've recently fetched a fine-grained timestamp
-		 * then the coarse-grained one may still be earlier than the
-		 * existing one. Just keep the existing ctime if so.
-		 */
-		ctime = inode_get_ctime(inode);
-		if (timespec64_compare(&ctime, &now) > 0)
-			now = ctime;
-	}
+	/*
+	 * If we've recently fetched a fine-grained timestamp
+	 * then the coarse-grained one may still be earlier than the
+	 * existing ctime. Just keep the existing value if so.
+	 */
+	ctime = inode_get_ctime(inode);
+	if (timespec64_compare(&ctime, &now) > 0)
+		now = ctime;
 
-	return timestamp_truncate(now, inode);
+	return now;
 }
 
 /**

---
base-commit: 4ce0966ed7c04881c5f352e0bb53af9b38f94253
change-id: 20230728-mgctime-5e0ec0e89b04

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658897A69AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 19:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjISRfV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 13:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjISRfU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:35:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34536A6;
        Tue, 19 Sep 2023 10:35:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5297CC433C8;
        Tue, 19 Sep 2023 17:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695144914;
        bh=buIiKDmPcBdHJjlDhXrf/70sfOuxVlPTssagt+Ng5L8=;
        h=From:Date:Subject:To:Cc:From;
        b=nU4dg3ppyNiwRzStDv0igVykhehDpZfiC1nCSk+eqGpTzHh2IhPpyaKC4t7+gCtAB
         NZjTNBbe0ZBDgDY4GNSnMpwOPqGII39GgLCsYt+q2gGEshQsx5OMUcTRn0XYoLFuP2
         tddIpnq0d+7B9j9h2f3dCWU9+p27FLTrieO3o+piX+d4/iB3XN+a6RPl0VJOdCSTXL
         TYKRdsD8k2MmIq9FO6nyHeupZlq3hok3zbo51e5BvTZ56wb0gmsKOx3FBepw1bbKvk
         sbzHCZgY7w8xbVunOyzgmw35coPaPQS7OzdKszfhguCcSbFzxx+NC9qrT4hacRscAb
         Q67GYTYxAJ81g==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Tue, 19 Sep 2023 13:35:11 -0400
Subject: [PATCH] fs: add bounds checking when updating ctime
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-ctime-v1-1-97b3da92f504@kernel.org>
X-B4-Tracking: v=1; b=H4sIAM7bCWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDS0NL3eSSzNxUXUOTxBQDE0MLS+O0JCWg2oKi1LTMCrA50bG1tQDcfEH
 uVwAAAA==
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2284; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=buIiKDmPcBdHJjlDhXrf/70sfOuxVlPTssagt+Ng5L8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlCdvSP2lqIz9HmK1OuN14Ts0NWqv8wkW+XeUY/
 X0EyrQc+iuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZQnb0gAKCRAADmhBGVaC
 FXmDEACA5G1nfl+pr2KRX9lVf5noAgkEZ8s8QCZt6sqWnHCnuA+LCVWFmYezIPAuH9sJAO3zJ2G
 IAK6L8FuueWQZHeujiqyl2/S/WA/aTh4J3qWgI7aCqiEy9uU3v1ws6/IHvloxYOAXJfyKnfKtVy
 PlgQafMrPFshObdFU5mjWgjQ1IueOD2+JQzMzc8hCbYInHR7+8gG/mGuqsh+CF2QlKNomBdK1lh
 wB+4fh4kKmBOFcem1Pnb4htPhE3JCSgGlJLo6DvLKGpxbTzEdaREXQtbf6cIapcDT10N1/2LENZ
 F4ud38DMguzd+UvkT0C3AUlGsZ7gjT3cJQdxCeqjGBYNVLa+nRTEFKbgQ28FIg6Zf1f3UfNS+Pn
 z46uKLbluCGqqc9q4Sy2M9X4dhhfQqKg8AkvKIiMk2KjvRvljFiW7i4MON3FBNnG2nbjyKXrKtm
 N6GivAm2pXyEswuKcPXR1SayTG9engN3xwbF3GWTABnkDbqgNbW4ilSeFdrVf8WKSNmffuH8GjT
 Eo6O2/1ThnbeXJ76CNkl+mJBxFSmK+PM66aWqDf7Fv5K6xSW5o5kDxKlc9XNxeSlNdS11sRt8v+
 02ab1TcAccCRkFoVVB9T9XkPNaEjT28WSPtYYhSK7oSnApvyi7sBBkfjdw3cJuu42FWcX+kv3wf
 U5sDV0lNKsYLLZw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

During some discussion around another patch, Linus pointed out that
we don't want to skip updating the ctime unless the current coarse
time is in a reasonable range.

When updating the ctime on a multigrain filesystem, only keep the
current ctime if the coarse time is less than 2 jiffies earlier.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
While we're still discussing whether to keep this series in, here's the
fix for the issue that Linus identified yesterday, basically that a
large clock jump backward could result in the m/ctime not being updated
properly.
---
 fs/inode.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 54237f4242ff..f3d68e4b8df7 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2571,6 +2571,13 @@ struct timespec64 current_time(struct inode *inode)
 }
 EXPORT_SYMBOL(current_time);
 
+/*
+ * Coarse timer ticks happen (roughly) every jiffy. If we see a coarse time
+ * more than 2 jiffies earlier than the current ctime, then we need to
+ * update it. This is the max delta allowed (in ns).
+ */
+#define COARSE_TIME_MAX_DELTA (2 / HZ * NSEC_PER_SEC)
+
 /**
  * inode_set_ctime_current - set the ctime to current_time
  * @inode: inode
@@ -2599,8 +2606,19 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 		 * existing ctime. Just keep the existing value if so.
 		 */
 		ctime.tv_sec = inode->__i_ctime.tv_sec;
-		if (timespec64_compare(&ctime, &now) > 0)
-			return ctime;
+		if (timespec64_compare(&ctime, &now) > 0) {
+			struct timespec64	limit = now;
+
+			/*
+			 * If the current coarse-grained clock is earlier than
+			 * it should be, then that's an indication that there
+			 * may have been a backward clock jump, and that the
+			 * update should not be skipped.
+			 */
+			timespec64_add_ns(&limit, COARSE_TIME_MAX_DELTA);
+			if (timespec64_compare(&ctime, &limit) < 0)
+				return ctime;
+		}
 
 		/*
 		 * Ctime updates are usually protected by the inode_lock, but

---
base-commit: 0b4cbb6924ecf459c12b2b5ff4370ae29a276fee
change-id: 20230919-ctime-14ad041893fb

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


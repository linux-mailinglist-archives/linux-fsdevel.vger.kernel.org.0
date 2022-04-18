Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B08505F69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 23:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiDRVkI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Apr 2022 17:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiDRVkD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:40:03 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C974F2E9FB
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Apr 2022 14:37:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 721EB1F41D3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650317842;
        bh=zfBsf2RUnAkmYRtu6lmk/b8dTq1cQYpREmaCwhUzUEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WAWUs7vw4rAUaK44h9j1spxZtioK1PD5dBNKcpMrBFLUfZtnXiyERNuSmsGNTgifP
         qXynn0eWhQhDs6NqUV1p/vW3vZTm6MsMKpZEGWXERcAiHNf+HTmsdVfjUn4WqC4QcM
         8wGPp5ECkEQiq1QbyZnqu8NPoSsGr8GZauB/p9I7NyYyB5+8uat2QvFKDFofKiss4Q
         vC/B3RIy8nxVLuLa9SviblUvj9vHucP8c8PBoa0WIVJpUFUodYw3JVxgJY4rGcwI4M
         5W8ALr9v1cClZWFab9exNQ/FDKFXXMAshyWEb/2aqVcWfojuOs0d8/wgeRyvpAUYF6
         VBWTg6uDa9D5w==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     hughd@google.com, akpm@linux-foundation.org, amir73il@gmail.com
Cc:     viro@zeniv.linux.org.uk,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v3 1/3] shmem: Keep track of out-of-memory and out-of-space errors
Date:   Mon, 18 Apr 2022 17:37:11 -0400
Message-Id: <20220418213713.273050-2-krisman@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418213713.273050-1-krisman@collabora.com>
References: <20220418213713.273050-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Keep a per-sb counter of failed shmem allocations for ENOMEM/ENOSPC to
be reported on sysfs.  The sysfs support is done separately on a later
patch.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 include/linux/shmem_fs.h | 3 +++
 mm/shmem.c               | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index e65b80ed09e7..1a7cd9ea9107 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -44,6 +44,9 @@ struct shmem_sb_info {
 	spinlock_t shrinklist_lock;   /* Protects shrinklist */
 	struct list_head shrinklist;  /* List of shinkable inodes */
 	unsigned long shrinklist_len; /* Length of shrinklist */
+
+	unsigned long acct_errors;
+	unsigned long space_errors;
 };
 
 static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
diff --git a/mm/shmem.c b/mm/shmem.c
index a09b29ec2b45..c350fa0a0fff 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -212,8 +212,10 @@ static inline bool shmem_inode_acct_block(struct inode *inode, long pages)
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 
-	if (shmem_acct_block(info->flags, pages))
+	if (shmem_acct_block(info->flags, pages)) {
+		sbinfo->acct_errors += 1;
 		return false;
+	}
 
 	if (sbinfo->max_blocks) {
 		if (percpu_counter_compare(&sbinfo->used_blocks,
@@ -225,6 +227,7 @@ static inline bool shmem_inode_acct_block(struct inode *inode, long pages)
 	return true;
 
 unacct:
+	sbinfo->space_errors += 1;
 	shmem_unacct_blocks(info->flags, pages);
 	return false;
 }
-- 
2.35.1


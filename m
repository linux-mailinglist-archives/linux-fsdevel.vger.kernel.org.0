Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1167A4F163B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 15:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357237AbiDDNnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 09:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357002AbiDDNns (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:43:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6229BBCB3
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Apr 2022 06:41:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 139EE1F44928
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649079710;
        bh=zfBsf2RUnAkmYRtu6lmk/b8dTq1cQYpREmaCwhUzUEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AnT/UR63cC5l6sLe3j41I1/03cTiqLpPv7znsIhGOe3hKFamGkleq6DNScyLfjqvf
         SyKdvOC82qGsZcSQ2BibFMuSzE8RavVYPz+B8VhcunTKJxz9r642l4IElNR3h83I3Z
         f3L8O+hwmVdgzuEbYGlUmPY1CjOwIk0Byap/OWuBSzB5val0kPi2pTQ9SJsoSG4Ciw
         oLmShkblV58QDu5s3ahSNCPjhViEXGLZN8SsRgLpcOTqbOWHOLRaY1m3nmsljzb6/F
         IROTEnz06yLmIuVGDVoQnAXZtg0JlEPID8QyoQSB9FoQwRJ/w2Z8H2aInLrskXhrDW
         XTvPBLzHEt3TA==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH RESEND 1/3] shmem: Keep track of out-of-memory and out-of-space errors
Date:   Mon,  4 Apr 2022 09:41:35 -0400
Message-Id: <20220404134137.26284-2-krisman@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220404134137.26284-1-krisman@collabora.com>
References: <20220404134137.26284-1-krisman@collabora.com>
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


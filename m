Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB444102AD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 03:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbhIRBcZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 21:32:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235000AbhIRBcY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 21:32:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 819776112E;
        Sat, 18 Sep 2021 01:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631928661;
        bh=hQ4c0bPf57fHRzGGgP77lvdFuE58UvQxRXy7RrfWhWs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MZsnr/s72Hhb9qBgsrjbJK8aPteYizYSeSWskfFH2V/BJjx0xvbrwuL4D2mE0Gv9g
         0WE/A+igxDGxOqHChZ5LLvf1BKEFSJzRkharPAc9x4PiatyZXEpRiMSgipfuT2VEFw
         O8vIpPd5gn7/HymjoVrGhQueEXea9Q/HfsjoXV7I47n/i7cNFaHebQMQtocRONSaXj
         h4cMdi6cidnz/Wy7ytADqyOFYWTSFzqDcNG4c3kb0XWN6MT7Rn9R8LRarzOYJIt9RR
         9GMECYHZVQs0Aag/BfvDurgw49lBgnCiRpxCjc6/RqhxttUCqFmnI+U2pLaUI+kO0e
         gbLK/F1+a4/yA==
Subject: [PATCH 3/5] vfs: add a zero-initialization mode to fallocate
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org, jane.chu@oracle.com
Cc:     linux-xfs@vger.kernel.org, hch@infradead.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org
Date:   Fri, 17 Sep 2021 18:31:01 -0700
Message-ID: <163192866125.417973.7293598039998376121.stgit@magnolia>
In-Reply-To: <163192864476.417973.143014658064006895.stgit@magnolia>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Add a new mode to fallocate to zero-initialize all the storage backing a
file.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/open.c                   |    5 +++++
 include/linux/falloc.h      |    1 +
 include/uapi/linux/falloc.h |    9 +++++++++
 3 files changed, 15 insertions(+)


diff --git a/fs/open.c b/fs/open.c
index daa324606a41..230220b8f67a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -256,6 +256,11 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	    (mode & ~FALLOC_FL_INSERT_RANGE))
 		return -EINVAL;
 
+	/* Zeroinit should only be used by itself and keep size must be set. */
+	if ((mode & FALLOC_FL_ZEROINIT_RANGE) &&
+	    (mode != (FALLOC_FL_ZEROINIT_RANGE | FALLOC_FL_KEEP_SIZE)))
+		return -EINVAL;
+
 	/* Unshare range should only be used with allocate mode. */
 	if ((mode & FALLOC_FL_UNSHARE_RANGE) &&
 	    (mode & ~(FALLOC_FL_UNSHARE_RANGE | FALLOC_FL_KEEP_SIZE)))
diff --git a/include/linux/falloc.h b/include/linux/falloc.h
index f3f0b97b1675..4597b416667b 100644
--- a/include/linux/falloc.h
+++ b/include/linux/falloc.h
@@ -29,6 +29,7 @@ struct space_resv {
 					 FALLOC_FL_PUNCH_HOLE |		\
 					 FALLOC_FL_COLLAPSE_RANGE |	\
 					 FALLOC_FL_ZERO_RANGE |		\
+					 FALLOC_FL_ZEROINIT_RANGE |	\
 					 FALLOC_FL_INSERT_RANGE |	\
 					 FALLOC_FL_UNSHARE_RANGE)
 
diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
index 51398fa57f6c..8144403b6102 100644
--- a/include/uapi/linux/falloc.h
+++ b/include/uapi/linux/falloc.h
@@ -77,4 +77,13 @@
  */
 #define FALLOC_FL_UNSHARE_RANGE		0x40
 
+/*
+ * FALLOC_FL_ZEROINIT_RANGE is used to reinitialize storage backing a file by
+ * writing zeros to it.  Subsequent read and writes should not fail due to any
+ * previous media errors.  Blocks must be not be shared or require copy on
+ * write.  Holes and unwritten extents are left untouched.  This mode must be
+ * used with FALLOC_FL_KEEP_SIZE.
+ */
+#define FALLOC_FL_ZEROINIT_RANGE	0x80
+
 #endif /* _UAPI_FALLOC_H_ */


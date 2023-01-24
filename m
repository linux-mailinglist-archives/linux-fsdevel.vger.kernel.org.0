Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594F567A2C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 20:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjAXTam (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 14:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbjAXTah (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:30:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8874DBDB;
        Tue, 24 Jan 2023 11:30:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8FC8B816AC;
        Tue, 24 Jan 2023 19:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922E9C433D2;
        Tue, 24 Jan 2023 19:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674588631;
        bh=yV3t1oc2mIc6UQl4grQoFozaSbqgHuC2qyMyJ9ivPAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QKajcuifCAg51Up9S3ifMhx72LK+AgoAV1YWzhuUijPZWXHqy0T8ENQ2itgt9RkEO
         7LZbHaiO8ClQPdfCMbRtDTbnKiSO4ymH9SiL0+eFtpUtb4pIosuTDRRbUTDj01/EAs
         o92msCtTjV65+0+JvCMiva9v0C+gYzd64TbM1j10bjcq8f7IIRVw2+KfW02vvep2CU
         xST6f0H4ZeqxKPQWfYtDfBp995d963U1si+A+CTLF2qDxiTQvDA1NTVBBfosbltpHb
         z/tSIbhJauoc5gE/0a2Olb3rmDz2IIaJ2ubfRHX9JX8+Dr+eVkJMNHYFdHKrWLwUiM
         fq/i9WVj+ry2A==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH v8 RESEND 1/8] fs: uninline inode_query_iversion
Date:   Tue, 24 Jan 2023 14:30:18 -0500
Message-Id: <20230124193025.185781-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230124193025.185781-1-jlayton@kernel.org>
References: <20230124193025.185781-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reviewed-by: NeilBrown <neilb@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/libfs.c               | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/iversion.h | 38 ++------------------------------------
 2 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index aada4e7c8713..17ecc47696e1 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1582,3 +1582,39 @@ bool inode_maybe_inc_iversion(struct inode *inode, bool force)
 	return true;
 }
 EXPORT_SYMBOL(inode_maybe_inc_iversion);
+
+/**
+ * inode_query_iversion - read i_version for later use
+ * @inode: inode from which i_version should be read
+ *
+ * Read the inode i_version counter. This should be used by callers that wish
+ * to store the returned i_version for later comparison. This will guarantee
+ * that a later query of the i_version will result in a different value if
+ * anything has changed.
+ *
+ * In this implementation, we fetch the current value, set the QUERIED flag and
+ * then try to swap it into place with a cmpxchg, if it wasn't already set. If
+ * that fails, we try again with the newly fetched value from the cmpxchg.
+ */
+u64 inode_query_iversion(struct inode *inode)
+{
+	u64 cur, new;
+
+	cur = inode_peek_iversion_raw(inode);
+	do {
+		/* If flag is already set, then no need to swap */
+		if (cur & I_VERSION_QUERIED) {
+			/*
+			 * This barrier (and the implicit barrier in the
+			 * cmpxchg below) pairs with the barrier in
+			 * inode_maybe_inc_iversion().
+			 */
+			smp_mb();
+			break;
+		}
+
+		new = cur | I_VERSION_QUERIED;
+	} while (!atomic64_try_cmpxchg(&inode->i_version, &cur, new));
+	return cur >> I_VERSION_QUERIED_SHIFT;
+}
+EXPORT_SYMBOL(inode_query_iversion);
diff --git a/include/linux/iversion.h b/include/linux/iversion.h
index e27bd4f55d84..6755d8b4f20b 100644
--- a/include/linux/iversion.h
+++ b/include/linux/iversion.h
@@ -234,42 +234,6 @@ inode_peek_iversion(const struct inode *inode)
 	return inode_peek_iversion_raw(inode) >> I_VERSION_QUERIED_SHIFT;
 }
 
-/**
- * inode_query_iversion - read i_version for later use
- * @inode: inode from which i_version should be read
- *
- * Read the inode i_version counter. This should be used by callers that wish
- * to store the returned i_version for later comparison. This will guarantee
- * that a later query of the i_version will result in a different value if
- * anything has changed.
- *
- * In this implementation, we fetch the current value, set the QUERIED flag and
- * then try to swap it into place with a cmpxchg, if it wasn't already set. If
- * that fails, we try again with the newly fetched value from the cmpxchg.
- */
-static inline u64
-inode_query_iversion(struct inode *inode)
-{
-	u64 cur, new;
-
-	cur = inode_peek_iversion_raw(inode);
-	do {
-		/* If flag is already set, then no need to swap */
-		if (cur & I_VERSION_QUERIED) {
-			/*
-			 * This barrier (and the implicit barrier in the
-			 * cmpxchg below) pairs with the barrier in
-			 * inode_maybe_inc_iversion().
-			 */
-			smp_mb();
-			break;
-		}
-
-		new = cur | I_VERSION_QUERIED;
-	} while (!atomic64_try_cmpxchg(&inode->i_version, &cur, new));
-	return cur >> I_VERSION_QUERIED_SHIFT;
-}
-
 /*
  * For filesystems without any sort of change attribute, the best we can
  * do is fake one up from the ctime:
@@ -283,6 +247,8 @@ static inline u64 time_to_chattr(struct timespec64 *t)
 	return chattr;
 }
 
+u64 inode_query_iversion(struct inode *inode);
+
 /**
  * inode_eq_iversion_raw - check whether the raw i_version counter has changed
  * @inode: inode to check
-- 
2.39.1


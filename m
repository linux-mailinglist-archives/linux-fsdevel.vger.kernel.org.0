Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F0760778F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 15:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiJUNGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 09:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiJUNGK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:06:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0779E4E854;
        Fri, 21 Oct 2022 06:06:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99EB761D11;
        Fri, 21 Oct 2022 13:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251D1C43470;
        Fri, 21 Oct 2022 13:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666357568;
        bh=tc1RUm4guOoZTsO0VdPQH+XnxC1sMtsO6DtotD5Lcrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eAhmr9yWeS0wVEiVIgOWu1jlRYjG0WT5NB1ecC/uQxCrIfhjwPSsIUbf/tXfO3unE
         e0r32nDpuAZBm2Lop8vuIwFPI1Vu4ZtCzZErW16ygMxndEcmdWUD7xcbH8+RSOuWHB
         vbjv+2g0BW9bN052u7XJGnXbsFjzt8s1pPgNSITv5ezyP38rqsZ6oXhh9bQNyhEWvq
         /8aPUz2dUVAIjZ+JRXPCcyyTRgRJXyH/34pvoqmRLDbFcyfY4rwRbPoXR7Di581w/6
         9p67AFlGaMiVsx5GqUjXNpFTm/3/gRaX+eu2ibO8xgOw+GSqs6BrjwgqwBPpxd/4Bq
         kc+5i0Af2xq7A==
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
Subject: [PATCH v8 1/8] fs: uninline inode_query_iversion
Date:   Fri, 21 Oct 2022 09:05:55 -0400
Message-Id: <20221021130602.99099-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221021130602.99099-1-jlayton@kernel.org>
References: <20221021130602.99099-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 682d56345a1c..5ae81466a422 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1566,3 +1566,39 @@ bool inode_maybe_inc_iversion(struct inode *inode, bool force)
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
2.37.3


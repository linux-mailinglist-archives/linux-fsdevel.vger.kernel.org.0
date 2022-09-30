Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037FE5F0A26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 13:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiI3L05 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 07:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiI3L02 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:26:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D3929378;
        Fri, 30 Sep 2022 04:18:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1731B8280C;
        Fri, 30 Sep 2022 11:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA6AC43470;
        Fri, 30 Sep 2022 11:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664536726;
        bh=S/Dx1SlVR4nhbzfbebAjqPJrTxRJSD7/7YKwODgznpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qqhBm8i+JoI2zMoaavTiAn1oZA2BRa2zQ73rhoHUGNk2X16KSZTAPGBSp45NIvjov
         sPmWO0td/2BEU9CvBurIUiLAmE0gfKdkstk5LGPWvCSUsvyTz7qMr1aCwoQcJU6K6J
         bXSLl771ipnsemKit3USDA8GfYnigLhyirbjYZ3yMXTWFfViPZiNUu+aMtwVfhDrMC
         elCka/qE+claAKyQDuyP4+xRHOCgTxrlM+gTI4bdzoVuKEBkUtpUvSq7H2N2lpRm0s
         7V0DUa82mgFAwJt5InCu2EVTFKfpd+/o+dcLP5dieoaNLOyu3NZDhlR08hlA2JsR7h
         YM9w3zRGytFhQ==
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
Subject: [PATCH v6 1/9] iversion: move inode_query_iversion to libfs.c
Date:   Fri, 30 Sep 2022 07:18:32 -0400
Message-Id: <20220930111840.10695-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930111840.10695-1-jlayton@kernel.org>
References: <20220930111840.10695-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There's no need to have such a large function forcibly inlined.

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


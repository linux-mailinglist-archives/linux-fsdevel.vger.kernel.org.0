Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0213D78DE33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 21:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbjH3S65 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240565AbjH3Slq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 14:41:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA1FA3;
        Wed, 30 Aug 2023 11:28:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 436F0612AF;
        Wed, 30 Aug 2023 18:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37208C433C9;
        Wed, 30 Aug 2023 18:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693420130;
        bh=rEAPvYU4MwSkvBKxGKCKmGZYh4Dc+YPUfa1bf0LFA0o=;
        h=From:Date:Subject:To:Cc:From;
        b=Mxdgfg0Szuu03us5SXGBsvD07gbRBlbelfO7aFFQghkUSPEDfZDoq+EASq3WUNzrg
         YB5QyBFnEc1Crzr4Vk71HsP84y0pb9E7hIvWLdGatIrHn80CbRp4MIWp9lG4jlA4h7
         3qN4pxztaw6oR6EZqaYKiWWko8ot+OVvAwJCcml1D9vg0syXsN56qKU9B3k06sg7Vz
         QL0OXOmZdD8+PmA4Gw32p1rVFnyVoJDPjq2yV/H5DCq6ge2G1ftMyIB18vL6iG4Abn
         PUpewXcBLkJkjyNgSQ2rD1u2VRFKdJJmwMidUIzLZauq0DF2mrqbPnUGiGNnh0GF3M
         7zR7W2E+dAI2A==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Wed, 30 Aug 2023 14:28:43 -0400
Subject: [PATCH] fs: have setattr_copy handle multigrain timestamps
 appropriately
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230830-kdevops-v1-1-ef2be57755dd@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFqK72QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDC2MD3eyU1LL8gmJdozRDUxMTY5O0tBRjJaDqgqLUtMwKsEnRsbW1AFL
 BCm9ZAAAA
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3444; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rEAPvYU4MwSkvBKxGKCKmGZYh4Dc+YPUfa1bf0LFA0o=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk74phUaUcOMlN97H0RCFi/ryQ91nTIjRDD69NV
 EurUnmIW52JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZO+KYQAKCRAADmhBGVaC
 FcKMD/487xVSNRPFtmh3BuR09cvDvXHJx4dJiKTbFFTu2MbN2Wzh9poD7WyfGic+a8uKu+OnFRK
 1t7EFIpu1s+OyBtreAq328cQFCUa3XcZ6GR4u6NMPlnks8jP1miLGcBlIbqo0wrEggD9biFBFh7
 Z5+2bxt4UwWaJZVhkhZhJe/wk+6oPsuR3VkUEKNnkk/VbimkwdSiqugN+TZIvgNCsZkHHVxJPnx
 bnHDSZFCn0OaB6HTKU7L4ydbkUBT4HNTorXrDC38lqNBeCCeJhtY5FAyrJIZ3GPYYX+vlqXcFvF
 eBybPuyTrFdKEp9VWDMqhrljDj40N8acbummVQ8QFDQhTCEO9cuUMr/xjBaPzOPBx+ji2Sa/31s
 C/Y5TOsMKxMb6lbqU2PUTfmeiAUYo10P46i+NIpATGopl5NFVxAFR8AD9YYbAowHCJg05jsuzAZ
 K2XIFDtbsE53tzZnjfYh+vyIw0evBTBc34jHKnnJsUU2YnkncSlt3xxVTKj+Bex/Tl3VMG94+5B
 oKnaedfnVVKWddQbJlZd5+EJJcF1v4TeJYsdDse80XJnuRIIjqw9bh2ZzzQOxDgtl5hqOo6N00b
 w2kmjhF92ZC41AGsHCO3DieMXblw1lBrR9Pn9XU1qtbo3spgRg0bJGnCOCJ4PWHs0PlpH5ERB+T
 CuknfDNbR3np6tw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The setattr codepath is still using coarse-grained timestamps, even on
multigrain filesystems. To fix this, we need to fetch the timestamp for
ctime updates later, at the point where the assignment occurs in
setattr_copy.

On a multigrain inode, ignore the ia_ctime in the attrs, and always
update the ctime to the current clock value. Update the atime and mtime
with the same value (if needed) unless they are being set to other
specific values, a'la utimes().

Note that we don't want to do this universally however, as some
filesystems (e.g. most networked fs) want to do an explicit update
elsewhere before updating the local inode.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/attr.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index a8ae5f6d9b16..8ba330e6a582 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -275,6 +275,42 @@ int inode_newsize_ok(const struct inode *inode, loff_t offset)
 }
 EXPORT_SYMBOL(inode_newsize_ok);
 
+/**
+ * setattr_copy_mgtime - update timestamps for mgtime inodes
+ * @inode: inode timestamps to be updated
+ * @attr: attrs for the update
+ *
+ * With multigrain timestamps, we need to take more care to prevent races
+ * when updating the ctime. Always update the ctime to the very latest
+ * using the standard mechanism, and use that to populate the atime and
+ * mtime appropriately (unless we're setting those to specific values).
+ */
+static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
+{
+	unsigned int ia_valid = attr->ia_valid;
+	struct timespec64 now;
+
+	/*
+	 * If the ctime isn't being updated then nothing else should be
+	 * either.
+	 */
+	if (!(ia_valid & ATTR_CTIME)) {
+		WARN_ON_ONCE(ia_valid & (ATTR_ATIME|ATTR_MTIME));
+		return;
+	}
+
+	now = inode_set_ctime_current(inode);
+	if (ia_valid & ATTR_ATIME_SET)
+		inode->i_atime = attr->ia_atime;
+	else if (ia_valid & ATTR_ATIME)
+		inode->i_atime = now;
+
+	if (ia_valid & ATTR_MTIME_SET)
+		inode->i_mtime = attr->ia_mtime;
+	else if (ia_valid & ATTR_MTIME)
+		inode->i_mtime = now;
+}
+
 /**
  * setattr_copy - copy simple metadata updates into the generic inode
  * @idmap:	idmap of the mount the inode was found from
@@ -307,12 +343,6 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 
 	i_uid_update(idmap, attr, inode);
 	i_gid_update(idmap, attr, inode);
-	if (ia_valid & ATTR_ATIME)
-		inode->i_atime = attr->ia_atime;
-	if (ia_valid & ATTR_MTIME)
-		inode->i_mtime = attr->ia_mtime;
-	if (ia_valid & ATTR_CTIME)
-		inode_set_ctime_to_ts(inode, attr->ia_ctime);
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
 		if (!in_group_or_capable(idmap, inode,
@@ -320,6 +350,16 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 			mode &= ~S_ISGID;
 		inode->i_mode = mode;
 	}
+
+	if (is_mgtime(inode))
+		return setattr_copy_mgtime(inode, attr);
+
+	if (ia_valid & ATTR_ATIME)
+		inode->i_atime = attr->ia_atime;
+	if (ia_valid & ATTR_MTIME)
+		inode->i_mtime = attr->ia_mtime;
+	if (ia_valid & ATTR_CTIME)
+		inode_set_ctime_to_ts(inode, attr->ia_ctime);
 }
 EXPORT_SYMBOL(setattr_copy);
 

---
base-commit: c5d9e87c18026d4caee80cd60a143f2b6564d446
change-id: 20230830-kdevops-2f154434ffd3

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


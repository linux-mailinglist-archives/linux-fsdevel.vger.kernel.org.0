Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D86B5A4C78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 14:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiH2MxE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 08:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiH2Mwh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:52:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8857D7675E
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 05:41:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D34B611F3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 12:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E949EC433D6;
        Mon, 29 Aug 2022 12:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661776903;
        bh=vjGqbCCXUIFNVTNgCUrBsO6db1shv6TTvtB+oM3m9nA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c1aXy135sYLm1E41NUWbHxHRUaauZNmc/YeNhPzb56vrRBPMQja9pV7+j3UigoZLO
         XReJ8JwKAh/VSlBIDRnaW4Kh8cULOxaWh5tPi8apvYDkT9JU3VjzfCT1gj7PFJr+4e
         QwN/wQvC/G30p3ny1DjlP6YbMI2IKQaKMEPvIvzNpjwdG25EETaTvJjx0uZbW+8s7s
         4YmSNeWs0zZiH2qOCnxM+S9y0lHvfTVIlmYCCuk4MExwl4z23n+t1mmbHh2Z8Na+g/
         7b7LDATQD5AXcK5K3m4IBh6IMH8lfjMC3P9WJBDkLpNXGvm5CoR7MntsGoFEqmPHYE
         8VmMVCnR4MyIw==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>
Subject: [PATCH 2/6] acl: return EOPNOTSUPP in posix_acl_fix_xattr_common()
Date:   Mon, 29 Aug 2022 14:38:41 +0200
Message-Id: <20220829123843.1146874-3-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220829123843.1146874-1-brauner@kernel.org>
References: <20220829123843.1146874-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790; i=brauner@kernel.org; h=from:subject; bh=vjGqbCCXUIFNVTNgCUrBsO6db1shv6TTvtB+oM3m9nA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTzbPodw8l035phSeYpTa+DUzb7rPtklGxxVMX+0r/fnk7C s7vlOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyczcjw6Hj/++c0atgPX9d75qwld GPaU8dLPe+z2nnvtodn7c3OZaRoXtDXNqfogffnQ8ektr0ucM66qPgyuLln2Jrq5L+vQy6zAUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Return EOPNOTSUPP when the POSIX ACL version doesn't match and zero if
there are no entries. This will allow us to reuse the helper in
posix_acl_from_xattr(). This change will have no user visible effects.

Fixes: 0c5fd887d2bb ("acl: move idmapped mount fixup into vfs_{g,s}etxattr()")
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/posix_acl.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 5af33800743e..abe387700ba9 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -710,9 +710,9 @@ EXPORT_SYMBOL(posix_acl_update_mode);
 /*
  * Fix up the uids and gids in posix acl extended attributes in place.
  */
-static int posix_acl_fix_xattr_common(void *value, size_t size)
+static int posix_acl_fix_xattr_common(const void *value, size_t size)
 {
-	struct posix_acl_xattr_header *header = value;
+	const struct posix_acl_xattr_header *header = value;
 	int count;
 
 	if (!header)
@@ -720,13 +720,13 @@ static int posix_acl_fix_xattr_common(void *value, size_t size)
 	if (size < sizeof(struct posix_acl_xattr_header))
 		return -EINVAL;
 	if (header->a_version != cpu_to_le32(POSIX_ACL_XATTR_VERSION))
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	count = posix_acl_xattr_count(size);
 	if (count < 0)
 		return -EINVAL;
 	if (count == 0)
-		return -EINVAL;
+		return 0;
 
 	return count;
 }
@@ -748,7 +748,7 @@ void posix_acl_getxattr_idmapped_mnt(struct user_namespace *mnt_userns,
 		return;
 
 	count = posix_acl_fix_xattr_common(value, size);
-	if (count < 0)
+	if (count <= 0)
 		return;
 
 	for (end = entry + count; entry != end; entry++) {
@@ -788,7 +788,7 @@ void posix_acl_setxattr_idmapped_mnt(struct user_namespace *mnt_userns,
 		return;
 
 	count = posix_acl_fix_xattr_common(value, size);
-	if (count < 0)
+	if (count <= 0)
 		return;
 
 	for (end = entry + count; entry != end; entry++) {
@@ -822,7 +822,7 @@ static void posix_acl_fix_xattr_userns(
 	kgid_t gid;
 
 	count = posix_acl_fix_xattr_common(value, size);
-	if (count < 0)
+	if (count <= 0)
 		return;
 
 	for (end = entry + count; entry != end; entry++) {
@@ -870,16 +870,9 @@ posix_acl_from_xattr(struct user_namespace *user_ns,
 	struct posix_acl *acl;
 	struct posix_acl_entry *acl_e;
 
-	if (!value)
-		return NULL;
-	if (size < sizeof(struct posix_acl_xattr_header))
-		 return ERR_PTR(-EINVAL);
-	if (header->a_version != cpu_to_le32(POSIX_ACL_XATTR_VERSION))
-		return ERR_PTR(-EOPNOTSUPP);
-
-	count = posix_acl_xattr_count(size);
+	count = posix_acl_fix_xattr_common(value, size);
 	if (count < 0)
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(count);
 	if (count == 0)
 		return NULL;
 	
-- 
2.34.1


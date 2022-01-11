Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945FC48B6C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350642AbiAKTQt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:16:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60804 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350571AbiAKTQa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:16:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FF2EB81D24;
        Tue, 11 Jan 2022 19:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63073C36AEF;
        Tue, 11 Jan 2022 19:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928587;
        bh=BUNGqy1GSjznvymdULOfn/2cdfR9XlWeBe0mBbHN5BQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=box4Xy9Ie3TA/XpluZmx5PrWFxUoAuJ4p5GkRwQeFyfFupP6PO5mh4laWr+6dPqqk
         nzpfKKCurOUiH6plgCM0yfncsCg6JbcxjgWRNZd8/dIVF5dCua/BkUUWspa5gz8Zfg
         UxvdbFL9w98YT1u7n4wa1rxWYysZ1THBHJMamjqRcVNaJ1SUPFNeqtGbCOQC4CyqoR
         xXJrSNc7M7r2Hu/f32gqe1Vcpa7peIWpwguxCGwBSKWJrwlC947NZT9tiGHvgdiTYM
         T5969eN39vp8qZX61kii0I5IVWAw9rHNw5IsENnIfXqYLSm3b/rP5eBzH/xglGarQl
         /V5JgK8yzZAqA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 24/48] ceph: add a new ceph.fscrypt.auth vxattr
Date:   Tue, 11 Jan 2022 14:15:44 -0500
Message-Id: <20220111191608.88762-25-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Give the client a way to get at the xattr from userland, mostly for
future debugging purposes.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/xattr.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 5e3522457deb..b872673a16a9 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -352,6 +352,23 @@ static ssize_t ceph_vxattrcb_auth_mds(struct ceph_inode_info *ci,
 	return ret;
 }
 
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
+static bool ceph_vxattrcb_fscrypt_auth_exists(struct ceph_inode_info *ci)
+{
+	return ci->fscrypt_auth_len;
+}
+
+static ssize_t ceph_vxattrcb_fscrypt_auth(struct ceph_inode_info *ci, char *val, size_t size)
+{
+	if (size) {
+		if (size < ci->fscrypt_auth_len)
+			return -ERANGE;
+		memcpy(val, ci->fscrypt_auth, ci->fscrypt_auth_len);
+	}
+	return ci->fscrypt_auth_len;
+}
+#endif /* CONFIG_FS_ENCRYPTION */
+
 #define CEPH_XATTR_NAME(_type, _name)	XATTR_CEPH_PREFIX #_type "." #_name
 #define CEPH_XATTR_NAME2(_type, _name, _name2)	\
 	XATTR_CEPH_PREFIX #_type "." #_name "." #_name2
@@ -492,6 +509,15 @@ static struct ceph_vxattr ceph_common_vxattrs[] = {
 		.exists_cb = NULL,
 		.flags = VXATTR_FLAG_READONLY,
 	},
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
+	{
+		.name = "ceph.fscrypt.auth",
+		.name_size = sizeof("ceph.fscrypt.auth"),
+		.getxattr_cb = ceph_vxattrcb_fscrypt_auth,
+		.exists_cb = ceph_vxattrcb_fscrypt_auth_exists,
+		.flags = VXATTR_FLAG_READONLY,
+	},
+#endif /* CONFIG_FS_ENCRYPTION */
 	{ .name = NULL, 0 }	/* Required table terminator */
 };
 
-- 
2.34.1


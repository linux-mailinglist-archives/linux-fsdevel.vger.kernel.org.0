Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3BC46EBC2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 16:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240541AbhLIPlJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 10:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240250AbhLIPko (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:40:44 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7530C0698CC;
        Thu,  9 Dec 2021 07:37:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3EF08CE2686;
        Thu,  9 Dec 2021 15:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71883C004DD;
        Thu,  9 Dec 2021 15:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639064226;
        bh=PgHfU4eYPR4RT5+xulbMIdqnUDbE+1bZyCsQKAULszw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tWPZKmjTWOz1kBvX9qv5o2XYCFbFHOz16GPEb5IkbqJ48rxcPURNa5r7qulFg6yuT
         MnYS4B4J3YIku8aAaNg+RjXIjSCfUxsfWLd2GJpqOC65e0LlRTiCITmDNys3TWjkD5
         nDo27QIsHbtlabR3e8Q+R9unYh4KET3o8USeh4ryfoJuKAuqrO1Oe58+QsCD2TWxc/
         HNa+VRJOPHr6QcKrsTeM7EjqU/cxUb97FiGj48dVuCFlakCkBot3hhdmxgfpTeHic9
         ab/SwNzr5ILmRhlmodgk9LhmmIV8C7iFV+1yC7l46NMsPMQm1n12cGw+KXnozSkzzF
         9939c78fUrtpA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 25/36] ceph: add a new ceph.fscrypt.auth vxattr
Date:   Thu,  9 Dec 2021 10:36:36 -0500
Message-Id: <20211209153647.58953-26-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211209153647.58953-1-jlayton@kernel.org>
References: <20211209153647.58953-1-jlayton@kernel.org>
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
2.33.1


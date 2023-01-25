Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428B267B147
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 12:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbjAYLaR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 06:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbjAYL3v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:29:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ADA22A18
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 03:29:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0811B81990
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 11:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A178AC433A1;
        Wed, 25 Jan 2023 11:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674646187;
        bh=IOzssTgtK++UqVcJ5HUSWWFIaDrn43ndUjBrAjyFiaU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=dJV9+p9ePI3jx5JC9RvTtdzmW1bNqW1rsHe0cmGA6kJs92nv9sD5fIBkqleTFMBLj
         mYd6bQ6V/xxr3LaywZ7SXG2zALJFaZukjVImD/7wVfnjG/oHG1hUJ4FxL4k/PPJtGN
         ZlLquvMiwjZi1Rx/MZjfUORVlg9e76o1yEwZN4k0HhhmRzpUYrRJ1hIoLt7/xAmahk
         hTxcE2F3jcshpf4F97YK4cxgJOsvnvTFiZOW4ejFP3SkOum4XQHFhZpc0AU0sylydp
         AnvzLQ/MHW4pyUCigmxXVlRhUgbUs0uxvYsE7SyfhrbLF/zwI0PtZpNpGfJttcKN0j
         bQe613ufERfrw==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 25 Jan 2023 12:28:55 +0100
Subject: [PATCH 10/12] ocfs2: drop posix acl handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v1-10-6cf155b492b6@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        ocfs2-devel@oss.oracle.com
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2847; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IOzssTgtK++UqVcJ5HUSWWFIaDrn43ndUjBrAjyFiaU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRfFJr0gc14+e+JtjaTM+wZKpOMl6zUZWGsmHtpcsAxZ8v9
 ibETO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyTI3hf/2SS7sUq53Ft1/Yxb13td
 diR/E923/qrJ5telPw8MfzLNGMDK+KzdrWei9Iapx3QbfIZhNvzxudhO6W5ROs2t/9r/0rxg8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Last cycle we introduced a new posix acl api. Filesystems now only need
to implement the inode operations for posix acls. The generic xattr
handlers aren't used anymore by the vfs and will be completely removed.
Keeping the handler around is confusing and gives the false impression
that the xattr infrastructure of the vfs is used to interact with posix
acls when it really isn't anymore.

For this to work we simply rework the ->listxattr() inode operation to
not rely on the generix posix acl handlers anymore.

Cc: <ocfs2-devel@oss.oracle.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/ocfs2/xattr.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 95d0611c5fc7..e55cd11d72fc 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -89,23 +89,11 @@ static struct ocfs2_xattr_def_value_root def_xv = {
 
 const struct xattr_handler *ocfs2_xattr_handlers[] = {
 	&ocfs2_xattr_user_handler,
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
 	&ocfs2_xattr_trusted_handler,
 	&ocfs2_xattr_security_handler,
 	NULL
 };
 
-static const struct xattr_handler *ocfs2_xattr_handler_map[OCFS2_XATTR_MAX] = {
-	[OCFS2_XATTR_INDEX_USER]	= &ocfs2_xattr_user_handler,
-	[OCFS2_XATTR_INDEX_POSIX_ACL_ACCESS]
-					= &posix_acl_access_xattr_handler,
-	[OCFS2_XATTR_INDEX_POSIX_ACL_DEFAULT]
-					= &posix_acl_default_xattr_handler,
-	[OCFS2_XATTR_INDEX_TRUSTED]	= &ocfs2_xattr_trusted_handler,
-	[OCFS2_XATTR_INDEX_SECURITY]	= &ocfs2_xattr_security_handler,
-};
-
 struct ocfs2_xattr_info {
 	int		xi_name_index;
 	const char	*xi_name;
@@ -528,13 +516,34 @@ static int ocfs2_read_xattr_block(struct inode *inode, u64 xb_blkno,
 	return rc;
 }
 
-static inline const char *ocfs2_xattr_prefix(int name_index)
+static const char *ocfs2_xattr_prefix(int xattr_index)
 {
+	const char *name = NULL;
 	const struct xattr_handler *handler = NULL;
 
-	if (name_index > 0 && name_index < OCFS2_XATTR_MAX)
-		handler = ocfs2_xattr_handler_map[name_index];
-	return handler ? xattr_prefix(handler) : NULL;
+	switch (xattr_index) {
+	case OCFS2_XATTR_INDEX_USER:
+		handler = &ocfs2_xattr_user_handler;
+		break;
+	case OCFS2_XATTR_INDEX_TRUSTED:
+		handler = &ocfs2_xattr_trusted_handler;
+		break;
+	case OCFS2_XATTR_INDEX_SECURITY:
+		handler = &ocfs2_xattr_security_handler;
+		break;
+	case OCFS2_XATTR_INDEX_POSIX_ACL_ACCESS:
+		name = XATTR_NAME_POSIX_ACL_ACCESS;
+		break;
+	case OCFS2_XATTR_INDEX_POSIX_ACL_DEFAULT:
+		name = XATTR_NAME_POSIX_ACL_DEFAULT;
+		break;
+	default:
+		return NULL;
+	}
+
+	name = xattr_prefix(handler);
+
+	return name;
 }
 
 static u32 ocfs2_xattr_name_hash(struct inode *inode,

-- 
2.34.1


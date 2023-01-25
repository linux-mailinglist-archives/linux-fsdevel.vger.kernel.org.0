Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533DA67B13E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 12:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbjAYLaC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 06:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbjAYL3d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:29:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3342E9EF8
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 03:29:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8450DB81990
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 11:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB980C433EF;
        Wed, 25 Jan 2023 11:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674646169;
        bh=nkbD/SyQZs2afsrS0O87QOkz8HvG7my1dcjAzjSGdM0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ao+xx+xXSdkn8MoxnZ+apBo4CN0hlga/fGnjsIWr+Lca+8C2TJCZy+H65pExpzxt7
         1clG/5W2eyzl+QyrtxsN+mAePj/s2BGxdrAvpLEEnAorVuPxvkaeemUevU7EfvGFV7
         D/rnU9WuMdpcykBtAB9OdQIgraUKjOr+kZRJNaQJBaUej7/f92muFMh96tyd9P2BYX
         moNzpIzkOtVrPy9CKKbjAH+diA/lIubBnYbyDyyHmGVrl4YFZhvA5ET1R8KVbPg4ye
         AQvUSsb1HONAubrJ5us7YT/+VwY+aR1sGCfuyTsZAytZtyoAd4V8rBfd0eFXEX0HuL
         9k1DgcWL2+CSw==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 25 Jan 2023 12:28:47 +0100
Subject: [PATCH 02/12] xattr, posix acl: add listxattr helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v1-2-6cf155b492b6@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1470; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nkbD/SyQZs2afsrS0O87QOkz8HvG7my1dcjAzjSGdM0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRfFJpoJdxya7Zg8BeXY4kHYtZmCl/zf7u+53Tuv4Bvs/8b
 z09k6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIjwcjw4Q2xuN31JY8443ojK5WX3
 cjjt3KQfHvG/8znyMMW7rM+RgZNp06+KM75LByZ83a1HqOtncr55yaft3mZFpBhOi6aXIWLAA=
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

Add two tiny helpers to determine whether a given dentry supports
listing the requested xattr or posix acl. We will use this helper in
various filesystems in later commits.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 include/linux/posix_acl_xattr.h | 5 +++++
 include/linux/xattr.h           | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/posix_acl_xattr.h b/include/linux/posix_acl_xattr.h
index 54cd7a14330d..905d532ccd6e 100644
--- a/include/linux/posix_acl_xattr.h
+++ b/include/linux/posix_acl_xattr.h
@@ -68,6 +68,11 @@ static inline int posix_acl_type(const char *name)
 	return -1;
 }
 
+static inline bool posix_acl_dentry_list(struct dentry *dentry)
+{
+	return IS_POSIXACL(d_backing_inode(dentry));
+}
+
 extern const struct xattr_handler posix_acl_access_xattr_handler;
 extern const struct xattr_handler posix_acl_default_xattr_handler;
 
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 2e7dd44926e4..d1150b7ba8d0 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -47,6 +47,12 @@ struct xattr_handler {
 		   size_t size, int flags);
 };
 
+static inline bool xattr_dentry_list(const struct xattr_handler *handler,
+				     struct dentry *dentry)
+{
+	return handler && (!handler->list || handler->list(dentry));
+}
+
 const char *xattr_full_name(const struct xattr_handler *, const char *);
 
 struct xattr {

-- 
2.34.1


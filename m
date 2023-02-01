Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED0768668E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 14:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjBANPv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 08:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjBANPl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:15:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796A0646B4
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Feb 2023 05:15:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27CE7B82188
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Feb 2023 13:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A720C4339B;
        Wed,  1 Feb 2023 13:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675257336;
        bh=jc1BW0NwOPMWrIp7tfjqC0oVawr/Zb6F58fK/G3LZYE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=GcuaV8HDYQMD7DflNQK/QxWH877qLIa30FAJDLcgLtDYO4+uhIExfRTqIv7mpxK8e
         amwxxRQeDgeh5sjefXRmnBawteu8lJzL1G9ZgniudZnP+VvMrXmwyGnecdYZytqH7E
         qp6GamySjj2KqpGsQHkVMvzWJ30/fFgPClpj20JjQ9dB/Uf5iA8NhiKiGiJBJFYKCA
         ef2/8oG3sEVrFMCDwYnFWGtwR3e41B4pWPn6ZeAyGRwi0XMTYiMyRjQvjRuXlwOzai
         nXJ0C439bbLBwcHjF6uaYdVdnniTFHFuXy7vJ45Oj0mvE25Dp6cFt+63mFI1KxqSKl
         3b5+LX19OA8CA==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 01 Feb 2023 14:14:53 +0100
Subject: [PATCH v3 02/10] xattr: add listxattr helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v3-2-f760cc58967d@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1467; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jc1BW0NwOPMWrIp7tfjqC0oVawr/Zb6F58fK/G3LZYE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTfSv2o8q7k0La5EgvvXqt5fSJVaSPj1Vuei0I51kborP1Q
 VLr2R0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEPt5i+MNlmnv3+6q6vZ4H7m21XS
 G344n+xOeO8mZXX0gInm6rkXBlZLg8q9hLdOY11T9xs2Qs1/68aSvOdE9W9oygV23ySqv8bzwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a tiny helper to determine whether an xattr handler given a specific
dentry supports listing the requested xattr. We will use this helper in
various filesystems in later commits.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
Changes in v3:
  - Patch unchanged.

Changes in v2:
- Remove second helper after architectural changes in the series.
- Christoph Hellwig <hch@lst.de>:
  - Renamed helper to xattr_handler_can_list().
---
 include/linux/xattr.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 74b7770880a7..39c496510a26 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -47,6 +47,22 @@ struct xattr_handler {
 		   size_t size, int flags);
 };
 
+/**
+ * xattr_handler_can_list - check whether xattr can be listed
+ * @handler: handler for this type of xattr
+ * @dentry: dentry whose inode xattr to list
+ *
+ * Determine whether the xattr associated with @dentry can be listed given
+ * @handler.
+ *
+ * Return: true if xattr can be listed, false if not.
+ */
+static inline bool xattr_handler_can_list(const struct xattr_handler *handler,
+					  struct dentry *dentry)
+{
+	return handler && (!handler->list || handler->list(dentry));
+}
+
 const char *xattr_full_name(const struct xattr_handler *, const char *);
 
 struct xattr {

-- 
2.34.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53BF6816A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 17:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbjA3QmU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 11:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237421AbjA3QmQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:42:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5494343477
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 08:42:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E078D611DD
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 16:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224BEC433D2;
        Mon, 30 Jan 2023 16:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675096934;
        bh=d0zpxb3OVZwE0d1bdSfNoqcFRxY2w1WVbkL7Pxrp1zE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=vQFPQPJs492TQ8ODyrHJsC6CLCiSpnFg3YbOjAeVj20OxRZRFNMG+CQbxWjoWeJoC
         RREOgtJ3tqwgS6yK+dQcC5YN44XHeD+w+qq80yCBm0PSBxInpgMq2tfw/ajLCJ9oLy
         BoE6/nrqh6whpG/6nbmagGw2xfdvbXNbkB8I7KNDDFh0VCrmgZg1EfA5YibzL5yjar
         iaAOWZ6XACE/+RWCGD8aE1W8RDMeSOrDCYZi0ApaK04PMcCyGcU+QRhf+yVwXc4guX
         t2jH1QaI15gfTdMHii8xOs3iiPSMcthGO3DwTWwhdtFKFjAsai/do6xzl0CztEeTAC
         dn5T4N7aMMZGQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Mon, 30 Jan 2023 17:41:59 +0100
Subject: [PATCH v2 3/8] xattr: add listxattr helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v2-3-214cfb88bb56@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v2-0-214cfb88bb56@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v2-0-214cfb88bb56@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1382; i=brauner@kernel.org;
 h=from:subject:message-id; bh=d0zpxb3OVZwE0d1bdSfNoqcFRxY2w1WVbkL7Pxrp1zE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRf/xw7/TrL3727Ph88u+TCdZ3j5rc02cUsQ3JmNa6x7p98
 y+3Zp45SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJFGQwMnzfc9FJ7sbUDwsqtPy+5T
 x9yR2XkP1thrPHr6UJX/JEb9cyMkz/XPhmwbGkBZa+zwKym6vytuwUNSiK2sh7f9J+z3//GngA
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

Add a tiny helper to determine whether an xattr handler given a specific
dentry supports listing the requested xattr. We will use this helper in
various filesystems in later commits.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
Changes in v2:
- Remove second helper after architectural changes in the series.
- Christoph Hellwig <hch@lst.de>:
  - Renamed helper to xattr_handler_can_list().
---
 include/linux/xattr.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index db022d6548fb..91d5b9de933a 100644
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


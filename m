Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFD2704E01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 14:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjEPMrC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 08:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbjEPMrB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 08:47:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF6FBA;
        Tue, 16 May 2023 05:46:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18F0C63631;
        Tue, 16 May 2023 12:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEDEC433EF;
        Tue, 16 May 2023 12:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684241217;
        bh=7tar1xhhDTSs/JYBfwXYakQ+Ax7bdebO3jwrH6Q86kU=;
        h=From:To:Cc:Subject:Date:From;
        b=ATK+FmjXrL9rZieU1j+umoCAKGK7jxm4u3zP96tWdasjKZJM9JzbSPlge+Zeunrcz
         ecHh+lE0gASxbUEThWfddrKj5Mz5tzveDSfQwTWnJNjqU/8+X4U7llBKckx9fxfBHl
         Jk6i8ZPj6Q2DKL1qcLbwaXl7KBatKbjLm8QITR+sYl3xFzx6R2KHLkD3go/9v/tZSn
         1jqjvuJxlSTwg99EYBmNnZHiWJVeMyMu2lm/5Qb6vBDQs2O0sDnW0ZBm9A8r5Dcnaj
         oBZERYIbc0FcBkURip8R6MavTKvlfCoOFnFJWpz8tYRx/2+i7iFKO5+YeNymr6f/uK
         H6OJDQdhRQ4BQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     trondmy@hammerspace.com, eggert@cs.ucla.edu, bruno@clisp.org,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: don't call posix_acl_listxattr in generic_listxattr
Date:   Tue, 16 May 2023 08:46:54 -0400
Message-Id: <20230516124655.82283-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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

Commit f2620f166e2a caused the kernel to start emitting POSIX ACL xattrs
for NFSv4 inodes, which it doesn't support. The only other user of
generic_listxattr is HFS (classic) and it doesn't support POSIX ACLs
either.

Fixes: f2620f166e2a xattr: simplify listxattr helpers
Reported-by: Ondrej Valousek <ondrej.valousek.xm@renesas.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/xattr.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index fcf67d80d7f9..e7bbb7f57557 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -985,9 +985,16 @@ int xattr_list_one(char **buffer, ssize_t *remaining_size, const char *name)
 	return 0;
 }
 
-/*
+/**
+ * generic_listxattr - run through a dentry's xattr list() operations
+ * @dentry: dentry to list the xattrs
+ * @buffer: result buffer
+ * @buffer_size: size of @buffer
+ *
  * Combine the results of the list() operation from every xattr_handler in the
- * list.
+ * xattr_handler stack.
+ *
+ * Note that this will not include the entries for POSIX ACLs.
  */
 ssize_t
 generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
@@ -996,10 +1003,6 @@ generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 	ssize_t remaining_size = buffer_size;
 	int err = 0;
 
-	err = posix_acl_listxattr(d_inode(dentry), &buffer, &remaining_size);
-	if (err)
-		return err;
-
 	for_each_xattr_handler(handlers, handler) {
 		if (!handler->name || (handler->list && !handler->list(dentry)))
 			continue;
-- 
2.40.1


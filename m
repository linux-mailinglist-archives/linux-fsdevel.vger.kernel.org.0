Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB9D602AF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 14:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiJRMAl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 08:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJRL7f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:59:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8A3BE2EA;
        Tue, 18 Oct 2022 04:58:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4919B614C5;
        Tue, 18 Oct 2022 11:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC811C433C1;
        Tue, 18 Oct 2022 11:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666094306;
        bh=OQp6zgEJEYC3GPKa+bOlffEJkgDJk9Mgdne9iliqX28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vO4PHHFEKygKtMsOxzZdXvgGWB4HZIcTNQt6YGTGvmrLHwCJ2hq+yDE+r2Or9UAZZ
         /HM1OJN2aF5A/erNigSe8i62zT2k3Xm7JwG+5LkA0ZrxDbXK85s6VTNJp0rxz/puGv
         vclKd70Rs+dMB4zh/9jHZcRpYXNGrBOj0/WnHP1xnrkRKcgiQq/wANc8Kbmg/gRpuj
         fE+R6armHt9ZZBVTpDa4EiCUGvJrwLLT8YF8i1OsECom8ujmWWQY85svTilsZgIuMY
         +Lp28guSDcEdixO4gGGafMneOYrhMwj3+4QWxG5YpISDF5ZZGSXXDbwx0YuYCs3xs2
         JwpTsrVEePwoA==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v5 26/30] ecryptfs: use stub posix acl handlers
Date:   Tue, 18 Oct 2022 13:56:56 +0200
Message-Id: <20221018115700.166010-27-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018115700.166010-1-brauner@kernel.org>
References: <20221018115700.166010-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=brauner@kernel.org; h=from:subject; bh=OQp6zgEJEYC3GPKa+bOlffEJkgDJk9Mgdne9iliqX28=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7TdH8L3/+aMS1VA+rybEzTiclJLpYvDnwOuTPIeeE+W9e 6K6621HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR2zWMDBf0FjyPbFwb8LxJiL9q3s 8vU3xL1nGZPo8XrW8Q71HmuMbwP7dbSVsx8P71JUd+HJ9y+YeAsMc6uWeZGpvm7MnxDHHy5QMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that ecryptfs supports the get and set acl inode operations and the
vfs has been switched to the new posi api, ecryptfs can simply rely on
the stub posix acl handlers.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged
    
    /* v3 */
    unchanged
    
    /* v4 */
    "Sedat Dilek (DHL Supply Chain)" <sedat.dilek@dhl.com>:
    - s/CONFIG_XFS_POSIX_ACL/CONFIG_FS_POSIX_ACL/
    
    /* v5 */
    unchanged

 fs/ecryptfs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 5802b93b2cda..f3cd00fac9c3 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1210,6 +1210,10 @@ static const struct xattr_handler ecryptfs_xattr_handler = {
 };
 
 const struct xattr_handler *ecryptfs_xattr_handlers[] = {
+#ifdef CONFIG_FS_POSIX_ACL
+	&posix_acl_access_xattr_handler,
+	&posix_acl_default_xattr_handler,
+#endif
 	&ecryptfs_xattr_handler,
 	NULL
 };
-- 
2.34.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A7568669D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 14:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjBANQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 08:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjBANQL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:16:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C880C65361;
        Wed,  1 Feb 2023 05:15:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D655B82047;
        Wed,  1 Feb 2023 13:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB81DC433D2;
        Wed,  1 Feb 2023 13:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675257350;
        bh=oOb2WwfkSlMYs2GkWe6tjGYStBX7QYMnhtKI6bUUbus=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=MqwjoI17Qv/ckbHtRdUOOHGsOCriTsUg/m0zANXOejRPjZ+IAfXmOUL03EzEho0wF
         93ybStNtqUo4YbDYDXlpPYKtfHI81kpsSltlsN6ZpQ53AL9GicqPp4MPWEamYSuo1e
         1rdIgc/VXNk1Mc0beKLGwgLC7EISlNmGnBnOsUkbK1tkEd350xAu0xOwqW/hpg9+0P
         LZ+jNbM8V+NbwBHVHATmq4bjIDuNbcbqBYUxaJE5l5L6sZPWY2LlJ9uKhEHagfTUo0
         ojHDFccXYLZexl9EOzeNQ6EGwjoFgAlGeqOipHvvtE7iCh8w00cARb6s3HB3rpZvKT
         DevDGZO5NPD+A==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 01 Feb 2023 14:15:00 +0100
Subject: [PATCH v3 09/10] ovl: check for ->listxattr() support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v3-9-f760cc58967d@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        linux-unionfs@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=909; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oOb2WwfkSlMYs2GkWe6tjGYStBX7QYMnhtKI6bUUbus=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTfSv3UbSAyw/+iudL8iKKv5893/n1weQOXvvcZ8Q/1W4/K
 LWn81lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARoa+MDD2K6n9YZ15o+jf7Rs+/CP
 Ng5TlirY1MZjOdnA6Im9+tW8fwV+rYi30cU49eTZb7wLTCP7zA5sqC8j0vfZuLHtr8vhZ6jRMA
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

We have decoupled vfs_listxattr() from IOP_XATTR. Instead we just need
to check whether inode->i_op->listxattr is implemented.

Cc: linux-unionfs@vger.kernel.org
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
Changes in v3:
- Patch introduced.
---
 fs/overlayfs/copy_up.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index c14e90764e35..f658cc8ea492 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -81,8 +81,7 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
 	int error = 0;
 	size_t slen;
 
-	if (!(old->d_inode->i_opflags & IOP_XATTR) ||
-	    !(new->d_inode->i_opflags & IOP_XATTR))
+	if (!old->d_inode->i_op->listxattr || !new->d_inode->i_op->listxattr)
 		return 0;
 
 	list_size = vfs_listxattr(old, NULL, 0);

-- 
2.34.1


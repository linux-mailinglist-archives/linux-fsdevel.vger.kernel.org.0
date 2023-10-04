Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8317B8CD6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245351AbjJDTBJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 15:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245244AbjJDS7U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:59:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140E510D9;
        Wed,  4 Oct 2023 11:55:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F738C433C7;
        Wed,  4 Oct 2023 18:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445730;
        bh=CrI2oE9zvS7rLm3o68ETT7yHLDkYN2B8nD8SI4vNyfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mj23CMF1wPG5z6bEMvvYf+X6rPahpOrgAsQU5jbz4pVIXc6QGhXgd1Ej9CoclvQfG
         zqg3Gv/qCiVvi4w8LOEzHJDS9o18NAokf23yk1cuVPRGiIwZtfI3Fwx6aW/FkBxPD3
         ig2WakoncNMFhlEzh5Dj4AuyaBYePBslTp6RVsPqP4Dtx4RVaEgXRf50pPpqqjf8vh
         ngkQxmeeLVADAKSN/oMmyw6A1mk9UcNJEKTDIxiEP3j39K5Z+zLYQ2txRZeDIY2DIT
         S8vLeFRncvS3GXwPZsAtV31xssViXmbWDzusPv6eoGQ36h0GuKhYudDbB8rxq7xLBF
         +H9+ji+iezkyQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 86/89] security: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:53:11 -0400
Message-ID: <20231004185347.80880-84-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert to using the new inode timestamp accessor functions.

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 security/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/inode.c b/security/inode.c
index 3aa75fffa8c9..9e7cde913667 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -145,7 +145,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 
 	inode->i_ino = get_next_ino();
 	inode->i_mode = mode;
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	inode->i_private = data;
 	if (S_ISDIR(mode)) {
 		inode->i_op = &simple_dir_inode_operations;
-- 
2.41.0


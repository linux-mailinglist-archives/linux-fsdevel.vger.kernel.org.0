Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A625EE18F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 18:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbiI1QQy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 12:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbiI1QO7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:14:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15872E11ED;
        Wed, 28 Sep 2022 09:13:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 53389CE1C78;
        Wed, 28 Sep 2022 16:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96D5C43141;
        Wed, 28 Sep 2022 16:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664381633;
        bh=H09RefG949umehebmHtne7EuOdbPisUUfcRyHIDEvgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Px3wx+4bWT1f8AOnfNgkysq3+Ee8cp09OvAztbGXiqpYCP9XiBe9MCmaJbkxZPkFC
         egvS7D9d/l/6EquT/U+Q08KFmc7vxHXPqlevNe8e1H8vXd74X+TkpC55jftF/cVYbm
         dOXua7KmRhNDTi7da+hEwKKAGaSxn9N1TJWl4IMaCQnG4mqwoVHnDkUn2v60Cd2d9j
         bH4Noz1cl4SLKYlAq0DeLiVlQoi4gGyUtiEz0+Em+pXSVVYn5RPj21yV4ryRgcEHeQ
         cRVAmC8cB7+rRxZNHfM72Nb1gzenRf2h9fVDPFBe9zTL2g5n0rqQw03Xmxr9qaAjDz
         zoYab/MKgsBlg==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 25/29] ecryptfs: use stub posix acl handlers
Date:   Wed, 28 Sep 2022 18:08:39 +0200
Message-Id: <20220928160843.382601-26-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928160843.382601-1-brauner@kernel.org>
References: <20220928160843.382601-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=862; i=brauner@kernel.org; h=from:subject; bh=H09RefG949umehebmHtne7EuOdbPisUUfcRyHIDEvgU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSbFNZ/Ftt7feM2rz9hm1VMNKuW75v0NzBUstT7a5r+0wjb pBXVHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM58Jfhr2Dyuw+2L5b0MPWkcUu8ET JapliiMbVa++hvqQlTxffeucjwP2Jt/K8gMeZv88oKmy8uivxxMCv+9xK/IIGvLS0XziyQ5AMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

 fs/ecryptfs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index c3d1ae688a19..bd6ae2582cd6 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1210,6 +1210,10 @@ static const struct xattr_handler ecryptfs_xattr_handler = {
 };
 
 const struct xattr_handler *ecryptfs_xattr_handlers[] = {
+#ifdef CONFIG_XFS_POSIX_ACL
+	&posix_acl_access_xattr_handler,
+	&posix_acl_default_xattr_handler,
+#endif
 	&ecryptfs_xattr_handler,
 	NULL
 };
-- 
2.34.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256A05EF918
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 17:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiI2Pet (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 11:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbiI2Pc6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:32:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD99177344;
        Thu, 29 Sep 2022 08:32:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D052C6124B;
        Thu, 29 Sep 2022 15:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F066C433D7;
        Thu, 29 Sep 2022 15:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664465521;
        bh=M3o2DhXJUhl9HNUcFD7wKHHEVp59KyZu7j7jaoJO+sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QuOaoY4r8VKWCDedkmSvHbUk5s6GWklvQdnzWs/ysf6Es3VdPpBzOZBNX8Wn0g/3G
         WZCltopF/MwXHxvuGjBn1KYkjoqh8Eq3vc3hFu5QPJx9/NUEu8Tufs76wN7Y8cplWf
         QlVGoyrfdnK7jxunW6/y76DUwDqh0en2m+PUE2djNToPjibM2pArZSl+CHBFe75iVd
         qG8mznvbQo5REZw8uztRlSPo3JQTeKQoUfKEwFZBwW/CL0MfOZ/l8h5taoc5tiVmUd
         40h4g4Xh3Bgawhfe+85GRe1+lt0qN/hDtGjBdHEuH6EGSxrPdnT5+91kIQRmXi97XT
         nrNdb6v7TY7Vw==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v4 26/30] ecryptfs: use stub posix acl handlers
Date:   Thu, 29 Sep 2022 17:30:36 +0200
Message-Id: <20220929153041.500115-27-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929153041.500115-1-brauner@kernel.org>
References: <20220929153041.500115-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=993; i=brauner@kernel.org; h=from:subject; bh=M3o2DhXJUhl9HNUcFD7wKHHEVp59KyZu7j7jaoJO+sc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSb7hLrX6M5r/dP+fTYOrv7ju6Zx4wCTjx886pDat+dZS0q mQYeHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM59I+R4cG7ymsn9rKlT6x3W2PS4r ZfT0BzwrSG6cz79Rd9u6q7oJiR4W8x/4LnU5RYgnkSl72XnRNa2CCQa8sZfeSI+A6vX396OAE=
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
    
    /* v4 */
    "Sedat Dilek (DHL Supply Chain)" <sedat.dilek@dhl.com>:
    - s/CONFIG_XFS_POSIX_ACL/CONFIG_FS_POSIX_ACL/

 fs/ecryptfs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index c3d1ae688a19..931eaaeb03b7 100644
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


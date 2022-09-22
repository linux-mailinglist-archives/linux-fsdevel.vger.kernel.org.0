Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CAE5E66D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 17:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiIVPTR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 11:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbiIVPSn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:18:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A381AEF08F;
        Thu, 22 Sep 2022 08:18:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41DD6635D8;
        Thu, 22 Sep 2022 15:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D81C433B5;
        Thu, 22 Sep 2022 15:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663859921;
        bh=vjtzaI6fQogsoDW17FlX5AgCfjQQ175EgJ3HMzyUBXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XXokH8ZH+JxH+G1+lckiQpjJ08UAqlUbAA9olUw/bjcXIj3womNBXprh/mpPd8rE7
         atU6rZ990EwPicAo3tn/yLhQ1v/8soRtNxRDpLjSlHxdAqEL61OM0pc2H71eJ5dxNt
         du2BDw1dBKYuqK3CrYSfsT5BZ6t3y5JpXZ5hhdyMwCBipgPMn1SgHr6uargvgomaq7
         +WA1s61Fir/YytFIM0FxNX/TYOpsdVRoaMQGq9BkhgOIJvuUvhJfhgaaEs5oCKvm4o
         MOaNmb9QoIRpKwErnh2+PS2XG8ukZJ4JILISRX2dGUXN+8UZlxynRA51becQyJoNVT
         waVEeqsGmdRDw==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org
Subject: [PATCH 25/29] ecryptfs: use stub posix acl handlers
Date:   Thu, 22 Sep 2022 17:17:23 +0200
Message-Id: <20220922151728.1557914-26-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922151728.1557914-1-brauner@kernel.org>
References: <20220922151728.1557914-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=786; i=brauner@kernel.org; h=from:subject; bh=vjtzaI6fQogsoDW17FlX5AgCfjQQ175EgJ3HMzyUBXw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTr1NS8XdzOfZ1Bcc+sWXtblryuCgprE2WIDH9zRvjPKs/g H9U1HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOJ2cLIcPt8leRRJ67Fi3UVnjPMOd S52lmU2/DnU43akuvx0yP/rmRk6Ejeop9sNztL0sKi30HaTnv9u92/KgPKxIKz9lnuvGvHCAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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


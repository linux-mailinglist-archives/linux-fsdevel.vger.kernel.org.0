Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBC872E62F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 16:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242745AbjFMOtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 10:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242656AbjFMOtf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:49:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B861BC6;
        Tue, 13 Jun 2023 07:49:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2BC263640;
        Tue, 13 Jun 2023 14:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F8DC433F0;
        Tue, 13 Jun 2023 14:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686667773;
        bh=2SpQOuQjIqP4mY71XZvOryMwD2mX4CVEV9PM1I4GpgU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=fV6+aUd0jMyX7iUSCa7YtHIRPJ4UN9iwQh84M2QjASbRMzv8zJItHdWmS1tvOVtil
         9RPTzY6/fl7RZmbRCc3MDuGniV9dY2/3pxV0+0U7CI6vkFg7/QShMQlrPwOIgb5CKT
         Ff23Dr39miGOmiCJOw16u5mPpO4fs4LL0I68L6rrTsD/BD7ypRs2HIh3Nqpiv6xlSM
         iPn3d0FTsI3qCqaoPryToRj9h4C8wxAFgQkn35ljAiS0E8DSjn+3Izhwhme91SNaOa
         CmT/5a6ODVjn6V6fetyXwIPB5zmJWQi3jP7JMl76s+JgxwLSPsbZf7Tcxl6F9wyyQ+
         B8Kmk7M3RwNwQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Tue, 13 Jun 2023 16:49:16 +0200
Subject: [PATCH v3 1/3] ovl: check type and offset of struct vfsmount in
 ovl_entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230605-fs-overlayfs-mount_api-v3-1-730d9646b27d@kernel.org>
References: <20230605-fs-overlayfs-mount_api-v3-0-730d9646b27d@kernel.org>
In-Reply-To: <20230605-fs-overlayfs-mount_api-v3-0-730d9646b27d@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=1749; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2SpQOuQjIqP4mY71XZvOryMwD2mX4CVEV9PM1I4GpgU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR0NP76Z3zR8CV/xlWtSeuTC5cet8x5scjAIEuo40Esl+dK
 59jbHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOx7GFkmKWgl2H0pTLm8OdPMwoMvo
 Ulx/1fHuHz7sW1GYt7nf5Y3GJkuFrtnMjea7CCZ293ecr3mWmPLC6uP25qEPq4Jc6udY0hIwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Porting overlayfs to the new amount api I started experiencing random
crashes that couldn't be explained easily. So after much debugging and
reasoning it became clear that struct ovl_entry requires the point to
struct vfsmount to be the first member and of type struct vfsmount.

During the port I added a new member at the beginning of struct
ovl_entry which broke all over the place in the form of random crashes
and cache corruptions. While there's a comment in ovl_free_fs() to the
effect of "Hack! Reuse ofs->layers as a vfsmount array before freeing
it" there's no such comment on struct ovl_entry which makes this easy to
trip over.

Add a comment and two static asserts for both the offset and the type of
pointer in struct ovl_entry.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/ovl_entry.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index c6c7d09b494e..e5207c4bf5b8 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -32,6 +32,7 @@ struct ovl_sb {
 };
 
 struct ovl_layer {
+	/* ovl_free_fs() relies on @mnt being the first member! */
 	struct vfsmount *mnt;
 	/* Trap in ovl inode cache */
 	struct inode *trap;
@@ -42,6 +43,14 @@ struct ovl_layer {
 	int fsid;
 };
 
+/*
+ * ovl_free_fs() relies on @mnt being the first member when unmounting
+ * the private mounts created for each layer. Let's check both the
+ * offset and type.
+ */
+static_assert(offsetof(struct ovl_layer, mnt) == 0);
+static_assert(__same_type(typeof_member(struct ovl_layer, mnt), struct vfsmount *));
+
 struct ovl_path {
 	const struct ovl_layer *layer;
 	struct dentry *dentry;

-- 
2.34.1


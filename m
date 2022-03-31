Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8812B4EDCF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 17:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbiCaPdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 11:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238345AbiCaPd3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:33:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369772220D5;
        Thu, 31 Mar 2022 08:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C342B61AE9;
        Thu, 31 Mar 2022 15:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6C9C3410F;
        Thu, 31 Mar 2022 15:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740701;
        bh=ZlSAF2g/jFdM0Gslti0+ZT4S3XmrsdOutUvnZ2ojXOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CU4vtp4uPrPyGXWBFFZKYRicCyOG1iBh6je3ZemHnz1BOjfABDpEJPoGZIEVtBtCD
         lq81jdZkZAgPUgy6v8A/uLw267ayPztUlNSEydW8ZHOJkGQ/+YAOVkbrtOmKcjv3qH
         CyL+KnGQW6WGszBjLyWU6cMIiO1goK+0LgNT/LEndALDgdSHiPMTyffuXyatituNEH
         emXUDrFdInH4mC1ZdaECwT5cYzzqqd7lUvHaWSvoYMHcfTYlKzDz+3w6yVKuNevXM1
         L1ihhNaWaxuKBwVFQeQuVDvjYFjRYymUWpD/tcQl330dKTXucQEUnYnyyjw6Eo/hJc
         12GZOssy/Hwrw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, lhenriques@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 09/54] ceph: ensure that we accept a new context from MDS for new inodes
Date:   Thu, 31 Mar 2022 11:30:45 -0400
Message-Id: <20220331153130.41287-10-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331153130.41287-1-jlayton@kernel.org>
References: <20220331153130.41287-1-jlayton@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/inode.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 216e90779a55..bceb46568da3 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -943,6 +943,17 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 	__ceph_update_quota(ci, iinfo->max_bytes, iinfo->max_files);
 
+#ifdef CONFIG_FS_ENCRYPTION
+	if (iinfo->fscrypt_auth_len && (inode->i_state & I_NEW)) {
+		kfree(ci->fscrypt_auth);
+		ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
+		ci->fscrypt_auth = iinfo->fscrypt_auth;
+		iinfo->fscrypt_auth = NULL;
+		iinfo->fscrypt_auth_len = 0;
+		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
+	}
+#endif
+
 	if ((new_version || (new_issued & CEPH_CAP_AUTH_SHARED)) &&
 	    (issued & CEPH_CAP_AUTH_EXCL) == 0) {
 		inode->i_mode = mode;
@@ -1032,16 +1043,6 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		xattr_blob = NULL;
 	}
 
-#ifdef CONFIG_FS_ENCRYPTION
-	if (iinfo->fscrypt_auth_len && !ci->fscrypt_auth) {
-		ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
-		ci->fscrypt_auth = iinfo->fscrypt_auth;
-		iinfo->fscrypt_auth = NULL;
-		iinfo->fscrypt_auth_len = 0;
-		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
-	}
-#endif
-
 	/* finally update i_version */
 	if (le64_to_cpu(info->version) > ci->i_version)
 		ci->i_version = le64_to_cpu(info->version);
-- 
2.35.1


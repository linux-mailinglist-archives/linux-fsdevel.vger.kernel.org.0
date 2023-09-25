Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612C97AD87D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 15:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjIYNAy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 09:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjIYNAv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:00:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1768C6
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 06:00:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B04C433C8;
        Mon, 25 Sep 2023 13:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695646845;
        bh=reFxIxJ/cc8CrZYXJP/XVOwnb4thMaUkOuEp1b22Rx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gv+nLcYjKlTFP7kqippP4Q/xdHaYkOglXZqYvGPfRE+KrxAanPKyAD+G4ZJHijSdl
         Gtp4KuEjqsfF3n5aENyPA082thyBfeRnwkS2fRnoaux9Qobi6qnj9tmYnYi4uXwFqa
         pYqumFZALR1IEKOeqeoT77gVqIgfTNfWlpIAqmbyw+scuathuaIkYcYa0+rL4KKoh/
         Bk9D5u8skGG7rdGUaGGCbEYNOLKzsTmL31KY9WCpwb+9OewpcAnd66sVrJaiH3AnPv
         g+i1bupfDkFpNpskE2feO5sJXX5GgPgEBzYDJHnfn+EaunTv6DIoETjItwKM4er6KB
         F38/P9TdP4pvA==
From:   cem@kernel.org
To:     linux-fsdevel@vger.kernel.org
Cc:     hughd@google.com, brauner@kernel.org, jack@suse.cz
Subject: [PATCH 3/3] tmpfs: Add project quota interface support for get/set attr
Date:   Mon, 25 Sep 2023 15:00:28 +0200
Message-Id: <20230925130028.1244740-4-cem@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925130028.1244740-1-cem@kernel.org>
References: <20230925130028.1244740-1-cem@kernel.org>
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

From: Carlos Maiolino <cem@kernel.org>

Not project quota support is in place, enable users to use it.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 mm/shmem.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 4d2b713bff06..744a39251a31 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3571,6 +3571,23 @@ static int shmem_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 
 	fileattr_fill_flags(fa, info->fsflags & SHMEM_FL_USER_VISIBLE);
 
+	fa->fsx_projid = (u32)from_kprojid(&init_user_ns, info->i_projid);
+	return 0;
+}
+
+static int shmem_set_project(struct inode *inode, __u32 projid)
+{
+	int err = -EOPNOTSUPP;
+	kprojid_t kprojid = make_kprojid(&init_user_ns, (projid_t)projid);
+
+	if (projid_eq(kprojid, SHMEM_I(inode)->i_projid))
+		return 0;
+
+	err = dquot_initialize(inode);
+	if (err)
+		return err;
+
+	SHMEM_I(inode)->i_projid = kprojid;
 	return 0;
 }
 
@@ -3579,19 +3596,29 @@ static int shmem_fileattr_set(struct mnt_idmap *idmap,
 {
 	struct inode *inode = d_inode(dentry);
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	int err = -EOPNOTSUPP;
+
+	if (fa->fsx_valid &&
+	   ((fa->fsx_xflags & ~FS_XFLAG_COMMON) ||
+	   fa->fsx_extsize != 0 || fa->fsx_cowextsize != 0))
+		goto out;
 
-	if (fileattr_has_fsx(fa))
-		return -EOPNOTSUPP;
 	if (fa->flags & ~SHMEM_FL_USER_MODIFIABLE)
-		return -EOPNOTSUPP;
+		goto out;
 
 	info->fsflags = (info->fsflags & ~SHMEM_FL_USER_MODIFIABLE) |
 		(fa->flags & SHMEM_FL_USER_MODIFIABLE);
 
 	shmem_set_inode_flags(inode, info->fsflags);
+	err = shmem_set_project(inode, fa->fsx_projid);
+		if (err)
+			goto out;
+
 	inode_set_ctime_current(inode);
 	inode_inc_iversion(inode);
-	return 0;
+
+out:
+	return err;
 }
 
 /*
-- 
2.39.2


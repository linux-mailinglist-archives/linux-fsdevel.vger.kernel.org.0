Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D56609FFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 13:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJXLNo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 07:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJXLNe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:13:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FF258178;
        Mon, 24 Oct 2022 04:13:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B85EB810FA;
        Mon, 24 Oct 2022 11:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CCAC433D6;
        Mon, 24 Oct 2022 11:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666609992;
        bh=SWVSQUQLuSItHvMK+ocRmWESELtEJtixCBVdU2/ksMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p7dYgKrGdPHeysiadgY8YP/SNhUIpFsWRJ88XfUMgPgA5VsbSF3xwT6wZEodIjTuK
         JnyIK855frRZs8WkkUrQdHR7xOwB+Dw5hnDbVjzgsJ6lbBJh8Mn4ipLyNCmRXMkjEP
         0zNnOr/GCdoxo7JduDWstW5aZsNLf78dlLx316Ub2EEsGPVwrCguK8AxgI1B+ad2vl
         9yRhl/R/+X9G6QxufpVuHBTWfY1ClL6z3OGnfiJWjKrA5Js9HWgyfIUm+MhUZ0fXt9
         9Y8Dr5HpwsqVo2gev7o+PtQxmE7Qa96By2jfmBPanci3ku4T4ve5WcZFV+NbQr1dfZ
         5H8AMCmOpijsA==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-unionfs@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 7/8] ovl: port to vfs{g,u}id_t and associated helpers
Date:   Mon, 24 Oct 2022 13:12:48 +0200
Message-Id: <20221024111249.477648-8-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221024111249.477648-1-brauner@kernel.org>
References: <20221024111249.477648-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645; i=brauner@kernel.org; h=from:subject; bh=SWVSQUQLuSItHvMK+ocRmWESELtEJtixCBVdU2/ksMc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSHFeu9L1r6Y+nG0OSHj8/sZhdinfXJwD0m3uQs58YU0w1e qcrtHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPRVWT477P90DW/hzdXvJiVbpowvz CWe+ax8leKGYoang27RG5y+jD8T51eqxYlyhdzeecRUdGeWMY4Yc+ND38vSrje1nD50IF3TAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A while ago we introduced a dedicated vfs{g,u}id_t type in commit
1e5267cd0895 ("mnt_idmapping: add vfs{g,u}id_t"). We already switched
over a good part of the VFS. Ultimately we will remove all legacy
idmapped mount helpers that operate only on k{g,u}id_t in favor of the
new type safe helpers that operate on vfs{g,u}id_t.

Cc: Seth Forshee (Digital Ocean) <sforshee@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    Note that this patch is currently also in Miklos tree.

 fs/overlayfs/util.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 81a57a8d80d9..c0c20d33691b 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1104,13 +1104,18 @@ void ovl_copyattr(struct inode *inode)
 	struct path realpath;
 	struct inode *realinode;
 	struct user_namespace *real_mnt_userns;
+	vfsuid_t vfsuid;
+	vfsgid_t vfsgid;
 
 	ovl_i_path_real(inode, &realpath);
 	realinode = d_inode(realpath.dentry);
 	real_mnt_userns = mnt_user_ns(realpath.mnt);
 
-	inode->i_uid = i_uid_into_mnt(real_mnt_userns, realinode);
-	inode->i_gid = i_gid_into_mnt(real_mnt_userns, realinode);
+	vfsuid = i_uid_into_vfsuid(real_mnt_userns, realinode);
+	vfsgid = i_gid_into_vfsgid(real_mnt_userns, realinode);
+
+	inode->i_uid = vfsuid_into_kuid(vfsuid);
+	inode->i_gid = vfsgid_into_kgid(vfsgid);
 	inode->i_mode = realinode->i_mode;
 	inode->i_atime = realinode->i_atime;
 	inode->i_mtime = realinode->i_mtime;
-- 
2.34.1


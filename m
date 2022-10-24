Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EFC609FF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 13:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJXLN0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 07:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJXLNW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:13:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEE9558F6
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 04:13:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA6E061224
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 11:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D77EC433D6;
        Mon, 24 Oct 2022 11:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666609986;
        bh=U/MR4S3d1G/fMQx2qZaaQBWPeLpOTt983a8nCbJ9f04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rNPDSwmbihqEzZHeD56l0skzhpxDidlx+8XoWwo5W0gddUvEhL4suAoFNYihzzNh1
         AtjK6/HbYgPfLvpIA6GoB+sqKFS0Qnx4UvKa5X7Z4R4AgLbNcYJrCnOycHi3Y0LTb8
         Svj/6bvVgFs62+QChOMGUxh2M4XaQV3MDRgJW/yfAdoWv55qaCqdk/tR11OWkOobiv
         Jak0jFgjQiwAA0g3oZkRghwaP0htvvBLOzFcwCMXnT8cNU79eNkSqIKBExRmrSsrAt
         6rJx8pBcyxSU4hUOT854ILSBIzzBOry7TrNKArbK6j83R3/ujJtMm1jytdrtTaXejv
         dJD3PRHyh/oWQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, apparmor@lists.ubuntu.com
Subject: [PATCH 4/8] apparmor: use type safe idmapping helpers
Date:   Mon, 24 Oct 2022 13:12:45 +0200
Message-Id: <20221024111249.477648-5-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221024111249.477648-1-brauner@kernel.org>
References: <20221024111249.477648-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5125; i=brauner@kernel.org; h=from:subject; bh=U/MR4S3d1G/fMQx2qZaaQBWPeLpOTt983a8nCbJ9f04=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSHFeuud9dWMwltkXSW9E73WfLJX+npC5H/egYzc0rD7I3v yL7vKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmIhbC8N/93/f5y/PlkuI2t9wao7yxy Xrtuf0Fdi8055uZHWrd8ZaNUaGSUwmPhf49xxIZ6x6Pt36yK2uPSkrt3974/Dpnt/yg55bOAE=
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

We already ported most parts and filesystems over for v6.0 to the new
vfs{g,u}id_t type and associated helpers for v6.0. Convert the remaining
places so we can remove all the old helpers.
This is a non-functional change.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:

 security/apparmor/domain.c |  8 ++++----
 security/apparmor/file.c   |  4 +++-
 security/apparmor/lsm.c    | 24 ++++++++++++++++--------
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 91689d34d281..7bafb4c4767c 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -859,10 +859,10 @@ int apparmor_bprm_creds_for_exec(struct linux_binprm *bprm)
 	const char *info = NULL;
 	int error = 0;
 	bool unsafe = false;
-	kuid_t i_uid = i_uid_into_mnt(file_mnt_user_ns(bprm->file),
-				      file_inode(bprm->file));
+	vfsuid_t vfsuid = i_uid_into_vfsuid(file_mnt_user_ns(bprm->file),
+					    file_inode(bprm->file));
 	struct path_cond cond = {
-		i_uid,
+		vfsuid_into_kuid(vfsuid),
 		file_inode(bprm->file)->i_mode
 	};
 
@@ -970,7 +970,7 @@ int apparmor_bprm_creds_for_exec(struct linux_binprm *bprm)
 	error = fn_for_each(label, profile,
 			aa_audit_file(profile, &nullperms, OP_EXEC, MAY_EXEC,
 				      bprm->filename, NULL, new,
-				      i_uid, info, error));
+				      vfsuid_into_kuid(vfsuid), info, error));
 	aa_put_label(new);
 	goto done;
 }
diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index e1b7e93602e4..d43679894d23 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -510,8 +510,10 @@ static int __file_path_perm(const char *op, struct aa_label *label,
 {
 	struct aa_profile *profile;
 	struct aa_perms perms = {};
+	vfsuid_t vfsuid = i_uid_into_vfsuid(file_mnt_user_ns(file),
+					    file_inode(file));
 	struct path_cond cond = {
-		.uid = i_uid_into_mnt(file_mnt_user_ns(file), file_inode(file)),
+		.uid = vfsuid_into_kuid(vfsuid),
 		.mode = file_inode(file)->i_mode
 	};
 	char *buffer;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index f56070270c69..cab55e25b4e3 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -225,8 +225,10 @@ static int common_perm(const char *op, const struct path *path, u32 mask,
 static int common_perm_cond(const char *op, const struct path *path, u32 mask)
 {
 	struct user_namespace *mnt_userns = mnt_user_ns(path->mnt);
+	vfsuid_t vfsuid = i_uid_into_vfsuid(mnt_userns,
+					    d_backing_inode(path->dentry));
 	struct path_cond cond = {
-		i_uid_into_mnt(mnt_userns, d_backing_inode(path->dentry)),
+		vfsuid_into_kuid(vfsuid),
 		d_backing_inode(path->dentry)->i_mode
 	};
 
@@ -270,11 +272,12 @@ static int common_perm_rm(const char *op, const struct path *dir,
 	struct inode *inode = d_backing_inode(dentry);
 	struct user_namespace *mnt_userns = mnt_user_ns(dir->mnt);
 	struct path_cond cond = { };
+	vfsuid_t vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
 
 	if (!inode || !path_mediated_fs(dentry))
 		return 0;
 
-	cond.uid = i_uid_into_mnt(mnt_userns, inode);
+	cond.uid = vfsuid_into_kuid(vfsuid);
 	cond.mode = inode->i_mode;
 
 	return common_perm_dir_dentry(op, dir, dentry, mask, &cond);
@@ -368,20 +371,23 @@ static int apparmor_path_rename(const struct path *old_dir, struct dentry *old_d
 	label = begin_current_label_crit_section();
 	if (!unconfined(label)) {
 		struct user_namespace *mnt_userns = mnt_user_ns(old_dir->mnt);
+		vfsuid_t vfsuid;
 		struct path old_path = { .mnt = old_dir->mnt,
 					 .dentry = old_dentry };
 		struct path new_path = { .mnt = new_dir->mnt,
 					 .dentry = new_dentry };
 		struct path_cond cond = {
-			i_uid_into_mnt(mnt_userns, d_backing_inode(old_dentry)),
-			d_backing_inode(old_dentry)->i_mode
+			.mode = d_backing_inode(old_dentry)->i_mode
 		};
+		vfsuid = i_uid_into_vfsuid(mnt_userns, d_backing_inode(old_dentry));
+		cond.uid = vfsuid_into_kuid(vfsuid);
 
 		if (flags & RENAME_EXCHANGE) {
 			struct path_cond cond_exchange = {
-				i_uid_into_mnt(mnt_userns, d_backing_inode(new_dentry)),
-				d_backing_inode(new_dentry)->i_mode
+				.mode = d_backing_inode(new_dentry)->i_mode,
 			};
+			vfsuid = i_uid_into_vfsuid(mnt_userns, d_backing_inode(old_dentry));
+			cond_exchange.uid = vfsuid_into_kuid(vfsuid);
 
 			error = aa_path_perm(OP_RENAME_SRC, label, &new_path, 0,
 					     MAY_READ | AA_MAY_GETATTR | MAY_WRITE |
@@ -447,10 +453,12 @@ static int apparmor_file_open(struct file *file)
 	if (!unconfined(label)) {
 		struct user_namespace *mnt_userns = file_mnt_user_ns(file);
 		struct inode *inode = file_inode(file);
+		vfsuid_t vfsuid;
 		struct path_cond cond = {
-			i_uid_into_mnt(mnt_userns, inode),
-			inode->i_mode
+			.mode = inode->i_mode,
 		};
+		vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
+		cond.uid = vfsuid_into_kuid(vfsuid);
 
 		error = aa_path_perm(OP_OPEN, label, &file->f_path, 0,
 				     aa_map_file_to_perms(file), &cond);
-- 
2.34.1


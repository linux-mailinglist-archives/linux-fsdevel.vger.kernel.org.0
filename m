Return-Path: <linux-fsdevel+bounces-3422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C41E7F4688
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292E21F21CF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 12:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8373AC29;
	Wed, 22 Nov 2023 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkXobvd6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088314D10B
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 12:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0859C433C7;
	Wed, 22 Nov 2023 12:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700657094;
	bh=bh+RhuUSY0u6U+8qlDB7mjHHPW8EueOuRxZPnyhYibc=;
	h=From:Date:Subject:References:In-Reply-To:To:From;
	b=EkXobvd6+XGKRu54sXwZZZZFgRelQjWH+YiEgKpfpRHcIiw14C37/273itgDknhH4
	 TFjMATCRqQED5iMMx88QoQROLnd3DcNI+0nNvQ9F28d5j2nSvrVn8dVSgFI0HXdeoV
	 mr0aBOsDABtZzmnuvYTg8fXrSFrIw7CvYToXMUGAMGBxqSGuOnITBYDDoDNdBQoPk+
	 amKZAFoHILv8qtUr72WirGyeF+yPTp26j+/wxwEmYjPCcz1jM+AOi/B2lceMqFt7BH
	 U37MUeKLrW6q+Veqr4QIRJiOXjlDHWQiubn9wVJPGBRX4Jq9z+RJmU8H3rPT0TZugD
	 sUziyaif57FHg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Nov 2023 13:44:37 +0100
Subject: [PATCH 1/4] mnt_idmapping: remove check_fsmapping()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-vfs-mnt_idmap-v1-1-dae4abdde5bd@kernel.org>
References: <20231122-vfs-mnt_idmap-v1-0-dae4abdde5bd@kernel.org>
In-Reply-To: <20231122-vfs-mnt_idmap-v1-0-dae4abdde5bd@kernel.org>
To: linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=openpgp-sha256; l=2388; i=brauner@kernel.org;
 h=from:subject:message-id; bh=bh+RhuUSY0u6U+8qlDB7mjHHPW8EueOuRxZPnyhYibc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTGfj/88nD9/WNBZWmnS66zrLp0/8Yxm58Ce8OvOP306
 PXcJlkxq6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiFyYyMnR1CPOy8Knqf7SN
 E+zSKWe/9TuJ68KydQLrvrwX3nTtHgsjw7R2w9P1DV33u54xflQ/UZJfEPrmeJvFh/dzYn6suBl
 3lA8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The helper is a bit pointless. Just open-code the check.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/mnt_idmapping.c            | 17 ++---------------
 fs/namespace.c                |  2 +-
 include/linux/mnt_idmapping.h |  3 ---
 3 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
index 57d1dedf3f8f..2674942311c3 100644
--- a/fs/mnt_idmapping.c
+++ b/fs/mnt_idmapping.c
@@ -25,19 +25,6 @@ struct mnt_idmap nop_mnt_idmap = {
 };
 EXPORT_SYMBOL_GPL(nop_mnt_idmap);
 
-/**
- * check_fsmapping - check whether an mount idmapping is allowed
- * @idmap: idmap of the relevent mount
- * @sb:    super block of the filesystem
- *
- * Return: true if @idmap is allowed, false if not.
- */
-bool check_fsmapping(const struct mnt_idmap *idmap,
-		     const struct super_block *sb)
-{
-	return idmap->owner != sb->s_user_ns;
-}
-
 /**
  * initial_idmapping - check whether this is the initial mapping
  * @ns: idmapping to check
@@ -94,8 +81,8 @@ static inline bool no_idmapping(const struct user_namespace *mnt_userns,
  */
 
 vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
-				   struct user_namespace *fs_userns,
-				   kuid_t kuid)
+		     struct user_namespace *fs_userns,
+		     kuid_t kuid)
 {
 	uid_t uid;
 	struct user_namespace *mnt_userns = idmap->owner;
diff --git a/fs/namespace.c b/fs/namespace.c
index fbf0e596fcd3..736baf07115c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4288,7 +4288,7 @@ static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
 	 * Creating an idmapped mount with the filesystem wide idmapping
 	 * doesn't make sense so block that. We don't allow mushy semantics.
 	 */
-	if (!check_fsmapping(kattr->mnt_idmap, m->mnt_sb))
+	if (kattr->mnt_userns == m->mnt_sb->s_user_ns)
 		return -EINVAL;
 
 	/*
diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index b8da2db4ecd2..cd4d5c8781f5 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -244,7 +244,4 @@ static inline kgid_t mapped_fsgid(struct mnt_idmap *idmap,
 	return from_vfsgid(idmap, fs_userns, VFSGIDT_INIT(current_fsgid()));
 }
 
-bool check_fsmapping(const struct mnt_idmap *idmap,
-		     const struct super_block *sb);
-
 #endif /* _LINUX_MNT_IDMAPPING_H */

-- 
2.42.0



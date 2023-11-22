Return-Path: <linux-fsdevel+bounces-3423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5EC7F4689
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4692810C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 12:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEE23D3A9;
	Wed, 22 Nov 2023 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQahI3T8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452C64D10B
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 12:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04915C433C9;
	Wed, 22 Nov 2023 12:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700657095;
	bh=JwWBrAaZpvHJTpdhGpdS9t7GETXOmA8d0qV90iLlbSg=;
	h=From:Date:Subject:References:In-Reply-To:To:From;
	b=fQahI3T8oG+OG9IW///0Ux/6vVKTrKlNelWCKgUzlPHKGZSFdjZxWJFlIp0KckBSo
	 9oYjcbIwMXQG5JdLURr7axl2E7dQYJkwGVvvQ2vO0cM12dAxLK5PWo4AoJIR62VTq1
	 uLt4ekebML/DFagoAchCtpXeKqAUqSDmM5CnlpxSaiaqVJvWZ9QYMigwfbk3AW1bmt
	 Rn2RSh8cLnvLdCSyNUot7f++A3T/90pui9WcvaBcL+lOmZ3a/uAWjZJI9sfP4/+Pi8
	 PrEej/OgZwNyu53PWcx4FFdCppvaHEiONmHBKfW8G/G+I7P2X4L1VlNg1m0yb9FqGe
	 rUo1yjP3vYgLA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Nov 2023 13:44:38 +0100
Subject: [PATCH 2/4] mnt_idmapping: remove nop check
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-vfs-mnt_idmap-v1-2-dae4abdde5bd@kernel.org>
References: <20231122-vfs-mnt_idmap-v1-0-dae4abdde5bd@kernel.org>
In-Reply-To: <20231122-vfs-mnt_idmap-v1-0-dae4abdde5bd@kernel.org>
To: linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=openpgp-sha256; l=4252; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JwWBrAaZpvHJTpdhGpdS9t7GETXOmA8d0qV90iLlbSg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTGfj98ateVo0IzWc6dZ+R51yLYUy20a329cto/0UsXd
 mxd23LqekcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEnvcyMizOlu9qNE58rfVD
 /Jz/H1YOfrUT2sfmycvOr9+VtkSOKY3hD6/TJgnrwN8yxdMqRJTusfw+Ozf6uRKDhrF4cL6JmOx
 HfgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

All mounts default to nop_mnt_idmap and we don't allow creating idmapped
mounts that reuse the idmapping of the filesystem. So unless someone
passes a non-superblock namespace to these helpers this check will
always be false. Remove it and replace it with a simple check for
nop_mnt_idmap.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/mnt_idmapping.c | 36 ++++++++----------------------------
 1 file changed, 8 insertions(+), 28 deletions(-)

diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
index 2674942311c3..35d78cb3c38a 100644
--- a/fs/mnt_idmapping.c
+++ b/fs/mnt_idmapping.c
@@ -39,26 +39,6 @@ static inline bool initial_idmapping(const struct user_namespace *ns)
 	return ns == &init_user_ns;
 }
 
-/**
- * no_idmapping - check whether we can skip remapping a kuid/gid
- * @mnt_userns: the mount's idmapping
- * @fs_userns: the filesystem's idmapping
- *
- * This function can be used to check whether a remapping between two
- * idmappings is required.
- * An idmapped mount is a mount that has an idmapping attached to it that
- * is different from the filsystem's idmapping and the initial idmapping.
- * If the initial mapping is used or the idmapping of the mount and the
- * filesystem are identical no remapping is required.
- *
- * Return: true if remapping can be skipped, false if not.
- */
-static inline bool no_idmapping(const struct user_namespace *mnt_userns,
-				const struct user_namespace *fs_userns)
-{
-	return initial_idmapping(mnt_userns) || mnt_userns == fs_userns;
-}
-
 /**
  * make_vfsuid - map a filesystem kuid according to an idmapping
  * @idmap: the mount's idmapping
@@ -68,8 +48,8 @@ static inline bool no_idmapping(const struct user_namespace *mnt_userns,
  * Take a @kuid and remap it from @fs_userns into @idmap. Use this
  * function when preparing a @kuid to be reported to userspace.
  *
- * If no_idmapping() determines that this is not an idmapped mount we can
- * simply return @kuid unchanged.
+ * If initial_idmapping() determines that this is not an idmapped mount
+ * we can simply return @kuid unchanged.
  * If initial_idmapping() tells us that the filesystem is not mounted with an
  * idmapping we know the value of @kuid won't change when calling
  * from_kuid() so we can simply retrieve the value via __kuid_val()
@@ -87,7 +67,7 @@ vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
 	uid_t uid;
 	struct user_namespace *mnt_userns = idmap->owner;
 
-	if (no_idmapping(mnt_userns, fs_userns))
+	if (idmap == &nop_mnt_idmap)
 		return VFSUIDT_INIT(kuid);
 	if (initial_idmapping(fs_userns))
 		uid = __kuid_val(kuid);
@@ -108,8 +88,8 @@ EXPORT_SYMBOL_GPL(make_vfsuid);
  * Take a @kgid and remap it from @fs_userns into @idmap. Use this
  * function when preparing a @kgid to be reported to userspace.
  *
- * If no_idmapping() determines that this is not an idmapped mount we can
- * simply return @kgid unchanged.
+ * If initial_idmapping() determines that this is not an idmapped mount
+ * we can simply return @kgid unchanged.
  * If initial_idmapping() tells us that the filesystem is not mounted with an
  * idmapping we know the value of @kgid won't change when calling
  * from_kgid() so we can simply retrieve the value via __kgid_val()
@@ -125,7 +105,7 @@ vfsgid_t make_vfsgid(struct mnt_idmap *idmap,
 	gid_t gid;
 	struct user_namespace *mnt_userns = idmap->owner;
 
-	if (no_idmapping(mnt_userns, fs_userns))
+	if (idmap == &nop_mnt_idmap)
 		return VFSGIDT_INIT(kgid);
 	if (initial_idmapping(fs_userns))
 		gid = __kgid_val(kgid);
@@ -154,7 +134,7 @@ kuid_t from_vfsuid(struct mnt_idmap *idmap,
 	uid_t uid;
 	struct user_namespace *mnt_userns = idmap->owner;
 
-	if (no_idmapping(mnt_userns, fs_userns))
+	if (idmap == &nop_mnt_idmap)
 		return AS_KUIDT(vfsuid);
 	uid = from_kuid(mnt_userns, AS_KUIDT(vfsuid));
 	if (uid == (uid_t)-1)
@@ -182,7 +162,7 @@ kgid_t from_vfsgid(struct mnt_idmap *idmap,
 	gid_t gid;
 	struct user_namespace *mnt_userns = idmap->owner;
 
-	if (no_idmapping(mnt_userns, fs_userns))
+	if (idmap == &nop_mnt_idmap)
 		return AS_KGIDT(vfsgid);
 	gid = from_kgid(mnt_userns, AS_KGIDT(vfsgid));
 	if (gid == (gid_t)-1)

-- 
2.42.0



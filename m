Return-Path: <linux-fsdevel+bounces-68318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E17DC58EDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23391420C4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B791B368271;
	Thu, 13 Nov 2025 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mpwb/QMB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CD735B157;
	Thu, 13 Nov 2025 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051896; cv=none; b=fJe3Q70Vkeuj/Pk0IVxNt5RE6z6w0aS8eWW4M5oEXHMwWpYiR5JG/jhYKed9NUfuexkLkKM7HpQYF/eJO4kmztMgNI5DIlVDvYyxPXoF8+9HV0cDxfR4vLVcTBVFhqtY0k8WdzRSCN457qa6EQf7nu+E7CUAFMT5MOj7vf5EXAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051896; c=relaxed/simple;
	bh=dj1XRW+4Kkl1W7CgCO4zU5/WJJlsm+DBcVy3ZBeFwEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tl4tnE8Od0B4ZdX7EhyMcfabRKZTRcjsX++bpb99pba898d4Niaf6o/z0dk/iuOeLohFsQiM4CjqmzGmNRzczhFB7aIkodxHDY28KDP0Fjw/bZE2IwGxYrU7Awf7D2C7nvepeqdYZWLIZVQYDS2zcJx12Qexqa0V/Y3onqA2ZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mpwb/QMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9386EC4CEF7;
	Thu, 13 Nov 2025 16:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051895;
	bh=dj1XRW+4Kkl1W7CgCO4zU5/WJJlsm+DBcVy3ZBeFwEg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Mpwb/QMBkwO22RB03IZ9ApL8BEiCFBw1ZxW+U6eSUQOiwv6ZXMiOmCHdt0diaArto
	 rkidiA7nc+nGle1dTHwxjwgU2mAHeDOpnTgihVu+AEflUhA0GWg9m+TShjHMeLlSlF
	 uoLkmOtYKQT35GeJQMxWWPD/zGTBjN6qZlQZiqkghqFP3yMtZF/gRjuFGHoOmmiEsr
	 pwnKP31ZUh9DprPiwBg8L782p0ONWNPMccm7948yPJYPwA8AEzvXCthB6EbZv5uPXr
	 xwqAAQTbtuRFS6EJWpAnJMvKGMpbXPPvgxQICWkZ9oOH2dGgHIuKn4+7I3p9n/3sIF
	 QrTx47JXez5Eg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:30 +0100
Subject: [PATCH v2 25/42] ovl: refactor ovl_iterate() and port to cred
 guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-25-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3477; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MRZWyvfD++Sf+fpZNl8APK+aEWUhKOZC6q9ykprqDaI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbpzf7wXpJUbpWc5T0kkdfLDPEm7VINXIdMP8a+dY
 hzYsm9eRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERKWxj+x7/fn7z+2/F4/pIy
 KfkpYvN//u/Z9vDAj8U/50ov+PvK9xjDP+uwv617Shsb1Ms4GwVXtfG37cn35M6q3KdSpMl9d9k
 2BgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

From: Amir Goldstein <amir73il@gmail.com>

factor out ovl_iterate_merged() and move some code into
ovl_iterate_real() for easier use of the scoped ovl cred guard.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/readdir.c | 60 +++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 12f0bb1480d7..dd76186ae739 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -804,6 +804,18 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 		.xinowarn = ovl_xino_warn(ofs),
 	};
 
+	/*
+	 * With xino, we need to adjust d_ino of lower entries.
+	 * On same fs, if parent is merge, then need to adjust d_ino for '..',
+	 * and if dir is impure then need to adjust d_ino for copied up entries.
+	 * Otherwise, we can iterate the real dir directly.
+	 */
+	if (!ovl_xino_bits(ofs) &&
+	    !(ovl_same_fs(ofs) &&
+	      (ovl_is_impure_dir(file) ||
+	       OVL_TYPE_MERGE(ovl_path_type(dir->d_parent)))))
+		return iterate_dir(od->realfile, ctx);
+
 	if (rdt.xinobits && lower_layer)
 		rdt.fsid = lower_layer->fsid;
 
@@ -832,44 +844,20 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 	return err;
 }
 
-
-static int ovl_iterate(struct file *file, struct dir_context *ctx)
+static int ovl_iterate_merged(struct file *file, struct dir_context *ctx)
 {
 	struct ovl_dir_file *od = file->private_data;
 	struct dentry *dentry = file->f_path.dentry;
-	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct ovl_cache_entry *p;
-	const struct cred *old_cred;
 	int err;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	if (!ctx->pos)
-		ovl_dir_reset(file);
-
-	if (od->is_real) {
-		/*
-		 * If parent is merge, then need to adjust d_ino for '..', if
-		 * dir is impure then need to adjust d_ino for copied up
-		 * entries.
-		 */
-		if (ovl_xino_bits(ofs) ||
-		    (ovl_same_fs(ofs) &&
-		     (ovl_is_impure_dir(file) ||
-		      OVL_TYPE_MERGE(ovl_path_type(dentry->d_parent))))) {
-			err = ovl_iterate_real(file, ctx);
-		} else {
-			err = iterate_dir(od->realfile, ctx);
-		}
-		goto out;
-	}
-
 	if (!od->cache) {
 		struct ovl_dir_cache *cache;
 
 		cache = ovl_cache_get(dentry);
 		err = PTR_ERR(cache);
 		if (IS_ERR(cache))
-			goto out;
+			return err;
 
 		od->cache = cache;
 		ovl_seek_cursor(od, ctx->pos);
@@ -881,7 +869,7 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 			if (!p->ino || p->check_xwhiteout) {
 				err = ovl_cache_update(&file->f_path, p, !p->ino);
 				if (err)
-					goto out;
+					return err;
 			}
 		}
 		/* ovl_cache_update() sets is_whiteout on stale entry */
@@ -892,12 +880,24 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 		od->cursor = p->l_node.next;
 		ctx->pos++;
 	}
-	err = 0;
-out:
-	ovl_revert_creds(old_cred);
 	return err;
 }
 
+static int ovl_iterate(struct file *file, struct dir_context *ctx)
+{
+	struct ovl_dir_file *od = file->private_data;
+
+	if (!ctx->pos)
+		ovl_dir_reset(file);
+
+	with_ovl_creds(file_dentry(file)->d_sb) {
+		if (od->is_real)
+			return ovl_iterate_real(file, ctx);
+
+		return ovl_iterate_merged(file, ctx);
+	}
+}
+
 static loff_t ovl_dir_llseek(struct file *file, loff_t offset, int origin)
 {
 	loff_t res;

-- 
2.47.3



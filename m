Return-Path: <linux-fsdevel+bounces-68243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B717CC578FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 42AA2355904
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120A8354ADB;
	Thu, 13 Nov 2025 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j08GYB3x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6364135471E;
	Thu, 13 Nov 2025 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038998; cv=none; b=m3UbocYoXEKtH5N5PG14x79qf4UzFPB4nZaHAIvBMMbVy9/ZwaIHCc0Z8hoE+OgZV094phYd+R7JP64Ou6A1u2Ae76LYwZW1xaBEOBJfiJity/k9cC81An9xKpjwyeOxbkJCOqXXf3jKg2+Q8295HxmgBOC6dWO7DCOepoVv4/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038998; c=relaxed/simple;
	bh=3gSp8SxkLCba71BuwpvIpLjwnADbSfxK9ilRgAovfQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DsLBlY8tdkSrIkekQx22jbl+w5IaLFfox9sd7k/JNaE2hzPHDZtl4L9YHsueucD5m9fJX7YBhxr9CDJcgwKlXUraW3MFmatUU5k7+63UJzvYgWQ9URiHuLePuOTCi0qqRv0nOHVJGmdQI0kolJlsCGEkjOKo+FJR9Cgo8s6xPA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j08GYB3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6530C116D0;
	Thu, 13 Nov 2025 13:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038998;
	bh=3gSp8SxkLCba71BuwpvIpLjwnADbSfxK9ilRgAovfQE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j08GYB3xFWSsmnDDZsuI6VdiTf+9lSOos8pDy56B/8/9hS4us2MvokBodHQX73vok
	 lw6eC7CRzGyBHkQXw2scrvm6Ln3mv/trXwIPbo8RZr4siMSrblth68RdWUx3/DJNgt
	 8gBvAZVohEK5f90B5OodWYTQ/tYO9ixsNQpxXqK5e0/WUBjsi/4rty5nEQGn9VAwAX
	 BGvRpR8hpLaMeHKTXmeD0Maaki/xJTnTieZKhaiiDe4cqjXGnbgm8P7WD1onrzC5sm
	 lYc43PvQvWmyhXe8RotJ4ykyIE16uXTb2bthGYMH7j0JaQI0SEKNiIdAmrhVIntOcW
	 yn/djBmvSnTHg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:46 +0100
Subject: [PATCH RFC 26/42] ovl: port ovl_iterate() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-26-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3250; i=brauner@kernel.org;
 h=from:subject:message-id; bh=3gSp8SxkLCba71BuwpvIpLjwnADbSfxK9ilRgAovfQE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnv8xuC851351qwZ//d3SawsKH1xiTU5IeNqytkWk
 wXrBaPtO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYibsnI8OTI601S2ZdN1xet
 bN+esEh2Qv/U+5oSxR1X9n5qePnnmyQjw5XtE1Wv/7t0amlUw7uw7BwD7jyjsqK6ySp1GYY6dju
 ruQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/readdir.c | 83 +++++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 45 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index ba345ceb4559..389f83aca57b 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -841,62 +841,55 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	struct dentry *dentry = file->f_path.dentry;
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct ovl_cache_entry *p;
-	const struct cred *old_cred;
 	int err;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	if (!ctx->pos)
-		ovl_dir_reset(file);
+	with_ovl_creds(dentry->d_sb) {
+		if (!ctx->pos)
+			ovl_dir_reset(file);
 
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
+		if (od->is_real) {
+			/*
+			 * If parent is merge, then need to adjust d_ino for '..', if
+			 * dir is impure then need to adjust d_ino for copied up
+			 * entries.
+			 */
+			if (ovl_xino_bits(ofs) || (ovl_same_fs(ofs) &&
+			    (ovl_is_impure_dir(file) || OVL_TYPE_MERGE(ovl_path_type(dentry->d_parent)))))
+				return ovl_iterate_real(file, ctx);
+
+			return iterate_dir(od->realfile, ctx);
 		}
-		goto out;
-	}
 
-	if (!od->cache) {
-		struct ovl_dir_cache *cache;
+		if (!od->cache) {
+			struct ovl_dir_cache *cache;
 
-		cache = ovl_cache_get(dentry);
-		err = PTR_ERR(cache);
-		if (IS_ERR(cache))
-			goto out;
+			cache = ovl_cache_get(dentry);
+			if (IS_ERR(cache))
+				return PTR_ERR(cache);
 
-		od->cache = cache;
-		ovl_seek_cursor(od, ctx->pos);
-	}
+			od->cache = cache;
+			ovl_seek_cursor(od, ctx->pos);
+		}
 
-	while (od->cursor != &od->cache->entries) {
-		p = list_entry(od->cursor, struct ovl_cache_entry, l_node);
-		if (!p->is_whiteout) {
-			if (!p->ino || p->check_xwhiteout) {
-				err = ovl_cache_update(&file->f_path, p, !p->ino);
-				if (err)
-					goto out;
+		while (od->cursor != &od->cache->entries) {
+			p = list_entry(od->cursor, struct ovl_cache_entry, l_node);
+			if (!p->is_whiteout) {
+				if (!p->ino || p->check_xwhiteout) {
+					err = ovl_cache_update(&file->f_path, p, !p->ino);
+					if (err)
+						return err;
+				}
 			}
+			/* ovl_cache_update() sets is_whiteout on stale entry */
+			if (!p->is_whiteout) {
+				if (!dir_emit(ctx, p->name, p->len, p->ino, p->type))
+					break;
+			}
+			od->cursor = p->l_node.next;
+			ctx->pos++;
 		}
-		/* ovl_cache_update() sets is_whiteout on stale entry */
-		if (!p->is_whiteout) {
-			if (!dir_emit(ctx, p->name, p->len, p->ino, p->type))
-				break;
-		}
-		od->cursor = p->l_node.next;
-		ctx->pos++;
+		err = 0;
 	}
-	err = 0;
-out:
-	ovl_revert_creds(old_cred);
 	return err;
 }
 

-- 
2.47.3



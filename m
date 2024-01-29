Return-Path: <linux-fsdevel+bounces-9447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 685B7841493
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 21:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9291C23FAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 20:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D98158D96;
	Mon, 29 Jan 2024 20:44:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C2B22F0F;
	Mon, 29 Jan 2024 20:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561045; cv=none; b=KOPGMmi2ogDCqWUuF8PhxJsO9CrOFE9YYyx0es6KO6v87N8OMlsJJ3JI3FfyBlgQpbVtW+6pTv/Vww9JzpwRi40GuZSvthIHseSS7yotaHoP1prIZd1ObmCumdZsVAdNIYWMC+6r6tYh56upV92DfRCS1bXKktWBGlAsvmDmBJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561045; c=relaxed/simple;
	bh=FmV9PYU+Vs8p31SgzrMt6ta1G9gbvcToq7AVmgSPrR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4BL9uM3OCeKwoUiTdOQ38zPrbWsBuZDap9fovin9jAwxaaNPMfiSYjrpM6o9a23hM/LXfYaTRs6MzXX1TgqzAtyapqGbI+E97hCVGtfWepmMAIvr7QmmGjb6A+3vfMVpCiSBV3opzL3uuzCHr4EL3WWesqdbXYnXL+TOO67u0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 576FF22076;
	Mon, 29 Jan 2024 20:44:02 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE9EA12FF7;
	Mon, 29 Jan 2024 20:44:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5s6HGBEOuGXsDAAAD6G6ig
	(envelope-from <krisman@suse.de>); Mon, 29 Jan 2024 20:44:01 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: ebiggers@kernel.org,
	viro@zeniv.linux.org.uk,
	jaegeuk@kernel.org,
	tytso@mit.edu
Cc: amir73il@gmail.com,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v5 07/12] libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
Date: Mon, 29 Jan 2024 17:43:25 -0300
Message-ID: <20240129204330.32346-8-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129204330.32346-1-krisman@suse.de>
References: <20240129204330.32346-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 576FF22076
X-Spam-Flag: NO

In preparation to get case-insensitive dentry operations from
sb->s_d_op again, use the same structure for case-insensitive
filesystems with and without fscrypt.

This means that on a casefolded filesystem without fscrypt, we end up
having to call fscrypt_d_revalidate once per dentry, which does the
function call extra cost.  We could avoid it by calling
d_set_always_valid in generic_set_encrypted_ci_d_ops, but this entire
function will go away in the following patches, and it is not worth the
extra complexity. Also, since the first fscrypt_d_revalidate will call
d_set_always_valid for us, we'll only have only pay the cost once, and
not per-lookup.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

---
Changes since v1:
  - fix header guard (eric)
---
 fs/libfs.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index c2aa6fd4795c..c4be0961faf0 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1776,19 +1776,14 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 static const struct dentry_operations generic_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
-};
-#endif
-
 #ifdef CONFIG_FS_ENCRYPTION
-static const struct dentry_operations generic_encrypted_dentry_ops = {
 	.d_revalidate = fscrypt_d_revalidate,
+#endif
 };
 #endif
 
-#if defined(CONFIG_FS_ENCRYPTION) && IS_ENABLED(CONFIG_UNICODE)
-static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
-	.d_hash = generic_ci_d_hash,
-	.d_compare = generic_ci_d_compare,
+#ifdef CONFIG_FS_ENCRYPTION
+static const struct dentry_operations generic_encrypted_dentry_ops = {
 	.d_revalidate = fscrypt_d_revalidate,
 };
 #endif
@@ -1809,38 +1804,21 @@ static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
  * Encryption works differently in that the only dentry operation it needs is
  * d_revalidate, which it only needs on dentries that have the no-key name flag.
  * The no-key flag can't be set "later", so we don't have to worry about that.
- *
- * Finally, to maximize compatibility with overlayfs (which isn't compatible
- * with certain dentry operations) and to avoid taking an unnecessary
- * performance hit, we use custom dentry_operations for each possible
- * combination rather than always installing all operations.
  */
 void generic_set_encrypted_ci_d_ops(struct dentry *dentry)
 {
-#ifdef CONFIG_FS_ENCRYPTION
-	bool needs_encrypt_ops = dentry->d_flags & DCACHE_NOKEY_NAME;
-#endif
 #if IS_ENABLED(CONFIG_UNICODE)
-	bool needs_ci_ops = dentry->d_sb->s_encoding;
-#endif
-#if defined(CONFIG_FS_ENCRYPTION) && IS_ENABLED(CONFIG_UNICODE)
-	if (needs_encrypt_ops && needs_ci_ops) {
-		d_set_d_op(dentry, &generic_encrypted_ci_dentry_ops);
+	if (dentry->d_sb->s_encoding) {
+		d_set_d_op(dentry, &generic_ci_dentry_ops);
 		return;
 	}
 #endif
 #ifdef CONFIG_FS_ENCRYPTION
-	if (needs_encrypt_ops) {
+	if (dentry->d_flags & DCACHE_NOKEY_NAME) {
 		d_set_d_op(dentry, &generic_encrypted_dentry_ops);
 		return;
 	}
 #endif
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (needs_ci_ops) {
-		d_set_d_op(dentry, &generic_ci_dentry_ops);
-		return;
-	}
-#endif
 }
 EXPORT_SYMBOL(generic_set_encrypted_ci_d_ops);
 
-- 
2.43.0



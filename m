Return-Path: <linux-fsdevel+bounces-12286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FE585E42E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 18:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC1A4B225C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 17:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB5283CC3;
	Wed, 21 Feb 2024 17:14:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD12083A0C;
	Wed, 21 Feb 2024 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535665; cv=none; b=o0h0Eydgse6t4e2Z0+doT2FV4USd4JPi+y1yyDid8foEGr8j9L2QudjB/SfAaxYpAXhOGnkHWYz4QlhykCLwJx584J3ypWctEROcpCeyFqOa1v6WP2MO7PeVog0LNMhcrJfRE5DN0yGOysty5hqsagC2YiycKHKWmrRtK5MxOpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535665; c=relaxed/simple;
	bh=ci4udrYSI2ZBQ9lChkVvuCgFLpRgRhVSO4IQ3mQ/k0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YST+nq4MCL4hrWzG3pH9MogtC6v/iUGOwzHV0hNITakhy3yLovSel72DfnMj9CxOTX92oEZV3OQXKM5sv+pMT7aLV+tKjaPPxrVG6JtLeTuhXYM4zoXzbXQWEELUksMloLHbAWgtJJf/c+WaHVzFVu4XR4kljjUDQStJOghZ/QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2FEB21FB6B;
	Wed, 21 Feb 2024 17:14:22 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA557139D0;
	Wed, 21 Feb 2024 17:14:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SZ0oM20v1mVTKgAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 21 Feb 2024 17:14:21 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: ebiggers@kernel.org,
	viro@zeniv.linux.org.uk,
	jaegeuk@kernel.org
Cc: tytso@mit.edu,
	amir73il@gmail.com,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v7 02/10] fscrypt: Factor out a helper to configure the lookup dentry
Date: Wed, 21 Feb 2024 12:14:04 -0500
Message-ID: <20240221171412.10710-3-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221171412.10710-1-krisman@suse.de>
References: <20240221171412.10710-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2FEB21FB6B
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

Both fscrypt_prepare_lookup_partial and fscrypt_prepare_lookup will set
DCACHE_NOKEY_NAME for dentries when the key is not available. Extract
out a helper to set this flag in a single place, in preparation to also
add the optimization that will disable ->d_revalidate if possible.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

---
changes since v7
  - Fix function names in commit message (Eric)
  - Have a stub for the CONFIG_FS_ENCRYPTION=n case (Eric)
changes since v6
  - Use inline comparison for is_nokey_name (eric)
  - rename fscrypt_prepare_lookup_dentry->fscrypt_prepare_dentry (eric)
---
 fs/crypto/hooks.c       | 15 +++++----------
 include/linux/fscrypt.h | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 52504dd478d3..104771c3d3f6 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -102,11 +102,8 @@ int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
 	if (err && err != -ENOENT)
 		return err;
 
-	if (fname->is_nokey_name) {
-		spin_lock(&dentry->d_lock);
-		dentry->d_flags |= DCACHE_NOKEY_NAME;
-		spin_unlock(&dentry->d_lock);
-	}
+	fscrypt_prepare_dentry(dentry, fname->is_nokey_name);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(__fscrypt_prepare_lookup);
@@ -131,12 +128,10 @@ EXPORT_SYMBOL_GPL(__fscrypt_prepare_lookup);
 int fscrypt_prepare_lookup_partial(struct inode *dir, struct dentry *dentry)
 {
 	int err = fscrypt_get_encryption_info(dir, true);
+	bool is_nokey_name = (!err && !fscrypt_has_encryption_key(dir));
+
+	fscrypt_prepare_dentry(dentry, is_nokey_name);
 
-	if (!err && !fscrypt_has_encryption_key(dir)) {
-		spin_lock(&dentry->d_lock);
-		dentry->d_flags |= DCACHE_NOKEY_NAME;
-		spin_unlock(&dentry->d_lock);
-	}
 	return err;
 }
 EXPORT_SYMBOL_GPL(fscrypt_prepare_lookup_partial);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 12f9e455d569..c76f859cf019 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -261,6 +261,16 @@ static inline bool fscrypt_is_nokey_name(const struct dentry *dentry)
 	return dentry->d_flags & DCACHE_NOKEY_NAME;
 }
 
+static inline void fscrypt_prepare_dentry(struct dentry *dentry,
+					  bool is_nokey_name)
+{
+	if (is_nokey_name) {
+		spin_lock(&dentry->d_lock);
+		dentry->d_flags |= DCACHE_NOKEY_NAME;
+		spin_unlock(&dentry->d_lock);
+	}
+}
+
 /* crypto.c */
 void fscrypt_enqueue_decrypt_work(struct work_struct *);
 
@@ -425,6 +435,11 @@ static inline bool fscrypt_is_nokey_name(const struct dentry *dentry)
 	return false;
 }
 
+static inline void fscrypt_prepare_dentry(struct dentry *dentry,
+					  bool is_nokey_name)
+{
+}
+
 /* crypto.c */
 static inline void fscrypt_enqueue_decrypt_work(struct work_struct *work)
 {
-- 
2.43.0



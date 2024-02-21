Return-Path: <linux-fsdevel+bounces-12288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013A685E437
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 18:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36E37B2166E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 17:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F63D83CB7;
	Wed, 21 Feb 2024 17:14:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9F61DA32;
	Wed, 21 Feb 2024 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535676; cv=none; b=DFMQ5AE6w8mK/dqp1SLe1U34frNZ/leAfCrYJCRTqZt4ufdehWD84pW4oEuWEMM7y6cTLlxvs3UVneYb2Wo2+btBTJ4KK/6icix6+OoyJzSgXUAOrpBs97Kjq4BzOKCdWU5MgF8LTKEsUdcFo/GkOPjx7p1ETVvoets24061ctc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535676; c=relaxed/simple;
	bh=Lak0M/CWc3JPAJCepAJRloxebxmRCtcKsG9GXiBonXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tEF9VQTZ/6XoIJye3kK7H+ZCZq6VCyfXnICb2Y+MJ5mtjAk9SQDhxW/wxVSsy/XWCwj8c1iP1M5i7Hd5/sfVvInaHlrhn2/HwuTRUVIZMAuOGhE0f3X/jufhf8t+o11+xheuM9JS/XOvUAGxCXjYdAs4Y8wEUdgEL7tRIiMgQ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 688EC1FB6A;
	Wed, 21 Feb 2024 17:14:33 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DBD3139D0;
	Wed, 21 Feb 2024 17:14:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tsbUBHkv1mVfKgAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 21 Feb 2024 17:14:33 +0000
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
Subject: [PATCH v7 04/10] fscrypt: Drop d_revalidate once the key is added
Date: Wed, 21 Feb 2024 12:14:06 -0500
Message-ID: <20240221171412.10710-5-krisman@suse.de>
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
X-Rspamd-Queue-Id: 688EC1FB6A
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

When a key is added, existing directory dentries in the
DCACHE_NOKEY_NAME form are moved by the VFS to the plaintext version.
But, since they have the DCACHE_OP_REVALIDATE flag set, revalidation
will be done at each lookup only to return immediately, since plaintext
dentries can't go stale until eviction.  This patch optimizes this case,
by dropping the flag once the nokey_name dentry becomes plain-text.
Note that non-directory dentries are not moved this way, so they won't
be affected.

Of course, this can only be done if fscrypt is the only thing requiring
revalidation for a dentry.  For this reason, we only disable
d_revalidate if the .d_revalidate hook is fscrypt_d_revalidate itself.

It is safe to do it here because when moving the dentry to the
plain-text version, we are holding the d_lock.  We might race with a
concurrent RCU lookup but this is harmless because, at worst, we will
get an extra d_revalidate on the keyed dentry, which will still find the
dentry to be valid.

Finally, now that we do more than just clear the DCACHE_NOKEY_NAME in
fscrypt_handle_d_move, skip it entirely for plaintext dentries, to avoid
extra costs.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

---
Changes since v6:
  - mention this is only for directory dentries in the commit msg(eric)
Changes since v5:
  - Merge with another patch(eric)
  - revert conditional check (eric)
  - drop comment (eric)
Changes since v3:
  - Fix null-ptr-deref for filesystems that don't support fscrypt (ktr)
Changes since v2:
  - Do it when moving instead of when revalidating the dentry. (me)
Changes since v1:
  - Improve commit message (Eric)
  - Drop & in function comparison (Eric)
---
 include/linux/fscrypt.h | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 78af02b35bd9..772f822dc6b8 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -192,6 +192,8 @@ struct fscrypt_operations {
 					     unsigned int *num_devs);
 };
 
+int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags);
+
 static inline struct fscrypt_inode_info *
 fscrypt_get_inode_info(const struct inode *inode)
 {
@@ -221,15 +223,29 @@ static inline bool fscrypt_needs_contents_encryption(const struct inode *inode)
 }
 
 /*
- * When d_splice_alias() moves a directory's no-key alias to its plaintext alias
- * as a result of the encryption key being added, DCACHE_NOKEY_NAME must be
- * cleared.  Note that we don't have to support arbitrary moves of this flag
- * because fscrypt doesn't allow no-key names to be the source or target of a
- * rename().
+ * When d_splice_alias() moves a directory's no-key alias to its
+ * plaintext alias as a result of the encryption key being added,
+ * DCACHE_NOKEY_NAME must be cleared and there might be an opportunity
+ * to disable d_revalidate.  Note that we don't have to support the
+ * inverse operation because fscrypt doesn't allow no-key names to be
+ * the source or target of a rename().
  */
 static inline void fscrypt_handle_d_move(struct dentry *dentry)
 {
-	dentry->d_flags &= ~DCACHE_NOKEY_NAME;
+	/*
+	 * VFS calls fscrypt_handle_d_move even for non-fscrypt
+	 * filesystems.
+	 */
+	if (dentry->d_flags & DCACHE_NOKEY_NAME) {
+		dentry->d_flags &= ~DCACHE_NOKEY_NAME;
+
+		/*
+		 * Other filesystem features might be handling dentry
+		 * revalidation, in which case it cannot be disabled.
+		 */
+		if (dentry->d_op->d_revalidate == fscrypt_d_revalidate)
+			dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
+	}
 }
 
 /**
@@ -397,7 +413,6 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 bool fscrypt_match_name(const struct fscrypt_name *fname,
 			const u8 *de_name, u32 de_name_len);
 u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name);
-int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags);
 
 /* bio.c */
 bool fscrypt_decrypt_bio(struct bio *bio);
-- 
2.43.0



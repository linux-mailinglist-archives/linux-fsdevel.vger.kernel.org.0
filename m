Return-Path: <linux-fsdevel+bounces-9445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E46B084148D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 21:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E27281F76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 20:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B181586ED;
	Mon, 29 Jan 2024 20:43:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1961B156967;
	Mon, 29 Jan 2024 20:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561037; cv=none; b=kvApLIY69Hz0e2lH1ERXoAhtb8ueSRvM2CKpz7qM0Fk51pWJZAfos9e+HeE5gx18yGP+Mzw8A8aDjCs5YPeCMjRBQhGdtXxhyNylN9hUUrb+NGLCpWoVEq2oMMTkC5mYJ3jx/Tyx4R0j1EwpbEgP7/Uqi65cZd0/clvNlCj/1WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561037; c=relaxed/simple;
	bh=mjhq8Ydo934T4ky79O6NVA6saVt9Qh6FavIF4018Pxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xqa3xU8G2vUzQYD95NdW0mFVCJyZjChOhkA4F337UGP/zVO9uAS8Z9jwjjBR+liGD5TvKvWtVFtbPqy+GAmZn5q6WlegtjV7+h4Ik5fqpovM4U/2f8/izhLRHFDXnhYhgTCCS6wOW9aiTWz2689hUPKN7d6IhuDCa1TjECxkai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 74F661F7F9;
	Mon, 29 Jan 2024 20:43:54 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB98812FF7;
	Mon, 29 Jan 2024 20:43:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F30VIAkOuGXYDAAAD6G6ig
	(envelope-from <krisman@suse.de>); Mon, 29 Jan 2024 20:43:53 +0000
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
Subject: [PATCH v5 05/12] fscrypt: Drop d_revalidate once the key is added
Date: Mon, 29 Jan 2024 17:43:23 -0300
Message-ID: <20240129204330.32346-6-krisman@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 74F661F7F9
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

From fscrypt perspective, once the key is available, the dentry will
remain valid until evicted for other reasons, since keyed dentries don't
require revalidation and, if the key is removed, the dentry is
forcefully evicted.  Therefore, we don't need to keep revalidating them
repeatedly.

Obviously, we can only do this if fscrypt is the only thing requiring
revalidation for a dentry.  For this reason, we only disable
d_revalidate if the .d_revalidate hook is fscrypt_d_revalidate itself.

It is safe to do it here because when moving the dentry to the
plain-text version, we are holding the d_lock.  We might race with a
concurrent RCU lookup but this is harmless because, at worst, we will
get an extra d_revalidate on the keyed dentry, which is will find the
dentry is valid.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

---
Changes since v3:
  - Fix null-ptr-deref for filesystems that don't support fscrypt (ktr)
Changes since v2:
  - Do it when moving instead of when revalidating the dentry. (me)

Changes since v1:
  - Improve commit message (Eric)
  - Drop & in function comparison (Eric)
---
 include/linux/fscrypt.h | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index a22997b9f35c..c1e285053b3e 100644
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
@@ -221,15 +223,24 @@ static inline bool fscrypt_needs_contents_encryption(const struct inode *inode)
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
 	dentry->d_flags &= ~DCACHE_NOKEY_NAME;
+
+	/*
+	 * Save the d_revalidate call cost during VFS operations.  We
+	 * can do it because, when the key is available, the dentry
+	 * can't go stale and the key won't go away without eviction.
+	 */
+	if (dentry->d_op && dentry->d_op->d_revalidate == fscrypt_d_revalidate)
+		dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
 }
 
 /**
@@ -368,7 +379,6 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 bool fscrypt_match_name(const struct fscrypt_name *fname,
 			const u8 *de_name, u32 de_name_len);
 u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name);
-int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags);
 
 /* bio.c */
 bool fscrypt_decrypt_bio(struct bio *bio);
-- 
2.43.0



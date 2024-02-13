Return-Path: <linux-fsdevel+bounces-11283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DE785275E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 03:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778501F2516B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 02:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56E17494;
	Tue, 13 Feb 2024 02:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1Z32cxd8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4APgVAjm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1Z32cxd8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4APgVAjm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880566FB9;
	Tue, 13 Feb 2024 02:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707790429; cv=none; b=reJpu8f8zlojpj4JDeF186Pxozm8OFqR62ZX5tSVjbg2bUIyneadpU7faum4W4q4Covs1B2phcYJk8fcI5YCC/8Wc4/dymPkI6eUA3s7I3VJC+QXYCLDV7aL7Xbba2Twzv2nu8KfGwkloQ11NySplCkkNpxWjE42XnHA7hzf05w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707790429; c=relaxed/simple;
	bh=PKONHcLKPKyHeHapaNkgMU67kg3Y/dJxUwnrhno6NkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmbwprfWIk3DeduTx18W3FMqUoBrQvU6Nol3CqPKnZe5gsHFcfZVZXgHbT4X7KGncWx48yFF3uFPTlOHc+9FNoN1byueImg5Ki0tb99ScZ6iCgawmHhQxyMBfiq5yfDpRfTNQry3jWnmNyPhz9lg9W8RuuUpXPHkwCct7ZxKEyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1Z32cxd8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4APgVAjm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1Z32cxd8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4APgVAjm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AB7FD1F79F;
	Tue, 13 Feb 2024 02:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707790425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ANW8B9RIeMJUznRh/VeZEY4kmqBgs00QkLzBAummj/Q=;
	b=1Z32cxd8TOXAdilHx97H5lDWfIQe5sOJP2dvXXOqA5mLuCH8POdTZ0BJ3pqCfK7saC0jKK
	2nPpzzgUJlaXfOieqpHzoqbtNDI8Wv0fxD61aXlnEJwvjQVDWlrymFs05KruuxHsPt18rG
	FK3eoS3yyV9ZSkQFeUetRBNGDUvjGig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707790425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ANW8B9RIeMJUznRh/VeZEY4kmqBgs00QkLzBAummj/Q=;
	b=4APgVAjmly2LTil9VnN9dK8CM5E9UkEud/8wIp9GyZVMZYCDA4tNl1YooKhqW5MPkwAJsj
	QMYcxPfYTIVG8QAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707790425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ANW8B9RIeMJUznRh/VeZEY4kmqBgs00QkLzBAummj/Q=;
	b=1Z32cxd8TOXAdilHx97H5lDWfIQe5sOJP2dvXXOqA5mLuCH8POdTZ0BJ3pqCfK7saC0jKK
	2nPpzzgUJlaXfOieqpHzoqbtNDI8Wv0fxD61aXlnEJwvjQVDWlrymFs05KruuxHsPt18rG
	FK3eoS3yyV9ZSkQFeUetRBNGDUvjGig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707790425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ANW8B9RIeMJUznRh/VeZEY4kmqBgs00QkLzBAummj/Q=;
	b=4APgVAjmly2LTil9VnN9dK8CM5E9UkEud/8wIp9GyZVMZYCDA4tNl1YooKhqW5MPkwAJsj
	QMYcxPfYTIVG8QAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7285913A4B;
	Tue, 13 Feb 2024 02:13:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7YjMFVnQymUZeAAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 13 Feb 2024 02:13:45 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: ebiggers@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jaegeuk@kernel.org,
	tytso@mit.edu,
	amir73il@gmail.com,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v6 04/10] fscrypt: Drop d_revalidate once the key is added
Date: Mon, 12 Feb 2024 21:13:15 -0500
Message-ID: <20240213021321.1804-5-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213021321.1804-1-krisman@suse.de>
References: <20240213021321.1804-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1Z32cxd8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4APgVAjm
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[kernel.org,mit.edu,gmail.com,vger.kernel.org,lists.sourceforge.net,suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: AB7FD1F79F
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

Finally, now that we do more than just clear the DCACHE_NOKEY_NAME in
fscrypt_handle_d_move, skip it entirely for plaintext dentries, to avoid
extra costs.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

---
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
index d1f17b90c30f..4283997c1bfd 100644
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
@@ -368,7 +384,6 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 bool fscrypt_match_name(const struct fscrypt_name *fname,
 			const u8 *de_name, u32 de_name_len);
 u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name);
-int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags);
 
 /* bio.c */
 bool fscrypt_decrypt_bio(struct bio *bio);
-- 
2.43.0



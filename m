Return-Path: <linux-fsdevel+bounces-9145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8066883E80B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 01:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C09CB27A6E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 00:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6400E567E;
	Sat, 27 Jan 2024 00:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rOd0RT5a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uTRFmr5I";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rOd0RT5a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uTRFmr5I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCFF5686;
	Sat, 27 Jan 2024 00:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314248; cv=none; b=GE9197BEGSnsyjuEFZCfwyntWakbK1nVJrpf26Z9vm/xjGBQJDNjop2Du0dVt26ByORNKcTkWQTjjaRQOFFltgJpPuMKOjJr6KB36VJqqlmpwaYHumw9DBI7SGxd1xuspcEKwCDYzmpjtYbxEeQrATcztcEhvhlxuk4dHMiTDx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314248; c=relaxed/simple;
	bh=FmV9PYU+Vs8p31SgzrMt6ta1G9gbvcToq7AVmgSPrR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnpi23CrQ7F5jYufij9HMUqLPvE3BCDJ7CPEwIh5JJzqTgAuzRX1PxMURYwbuNOnIZkBXksySiahDg9YWBeuACz46VpWCNOXSRtXV0EjXODnqfb65/4QgfCyhLJQEPpIz0pBKE8DXms3MJ3EgGXRuzKzgcg6FqWBghOwWKUD/Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rOd0RT5a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uTRFmr5I; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rOd0RT5a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uTRFmr5I; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6AF6C1FDBF;
	Sat, 27 Jan 2024 00:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706314245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LTCLhiM/0w+aHgqPUYmBgmxvsiEHxwft6QE+saHzb8=;
	b=rOd0RT5aGCRyQaOlICkvD9rOUc93c3pJSS+xIP0tkInYpohTaMe/FArbqzp4iIpvlxXXnL
	qz4CsRsBRBRJc5AXX6oy16bndjekN4OZr74BrSi9YpbrBc1LOn6oCAfGXnPxesLJcW/28x
	H8LAu8GSq32pMMHGpjEKXh/YMmAiU/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706314245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LTCLhiM/0w+aHgqPUYmBgmxvsiEHxwft6QE+saHzb8=;
	b=uTRFmr5IlfKiW5D/uPp5kSZFfn/I8a0J2bcBI7Nd2UFo/XwhEDSxRdC7mBtMvA0E0rCqWY
	fUsicKxLEwsddbAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706314245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LTCLhiM/0w+aHgqPUYmBgmxvsiEHxwft6QE+saHzb8=;
	b=rOd0RT5aGCRyQaOlICkvD9rOUc93c3pJSS+xIP0tkInYpohTaMe/FArbqzp4iIpvlxXXnL
	qz4CsRsBRBRJc5AXX6oy16bndjekN4OZr74BrSi9YpbrBc1LOn6oCAfGXnPxesLJcW/28x
	H8LAu8GSq32pMMHGpjEKXh/YMmAiU/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706314245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LTCLhiM/0w+aHgqPUYmBgmxvsiEHxwft6QE+saHzb8=;
	b=uTRFmr5IlfKiW5D/uPp5kSZFfn/I8a0J2bcBI7Nd2UFo/XwhEDSxRdC7mBtMvA0E0rCqWY
	fUsicKxLEwsddbAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D741813998;
	Sat, 27 Jan 2024 00:10:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QPC3JQRKtGVwEQAAD6G6ig
	(envelope-from <krisman@suse.de>); Sat, 27 Jan 2024 00:10:44 +0000
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
Subject: [PATCH v4 07/12] libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
Date: Fri, 26 Jan 2024 21:10:07 -0300
Message-ID: <20240127001013.2845-8-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127001013.2845-1-krisman@suse.de>
References: <20240127001013.2845-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.sourceforge.net,suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: ****
X-Spam-Score: 4.90
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



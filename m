Return-Path: <linux-fsdevel+bounces-8332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F75A832F23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 19:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EC62B23FDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 18:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABA956778;
	Fri, 19 Jan 2024 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LeSRtMVG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aRI5dUQ3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LeSRtMVG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aRI5dUQ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B542755E63;
	Fri, 19 Jan 2024 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705690105; cv=none; b=pwAPd8MftETE7hcGfaPu87YECjMxiaESDhT2h0Asurwf2xPXqWEMzE9YRKZCuRMcn/yLKdM+wHdHzEQavU0sEF/oVJgBH0QwuQLlEct5yBuxJATcYknqz7XrHU9k6qATcc9P+9diarn3BAgnW2zNgas7POb8tLWCDgPSN/z2q4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705690105; c=relaxed/simple;
	bh=FmV9PYU+Vs8p31SgzrMt6ta1G9gbvcToq7AVmgSPrR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7cE4enHXUJ8dYHJXgLXtfkaR9M5v1Nuh7tSHvEIMqsLNc8Po59KbYSupO9fKoOwBZh76ZZ4Rhhneusg8eLqi8Dn6l4IHwhAgM3E0dbPvr/3tvPLBSOb7AME5k06at664HKv8omn6iGLIfKqz9vxRqeVmwGDTtMqDMKH7jrqCkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LeSRtMVG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aRI5dUQ3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LeSRtMVG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aRI5dUQ3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 15BD421FDD;
	Fri, 19 Jan 2024 18:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705690102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LTCLhiM/0w+aHgqPUYmBgmxvsiEHxwft6QE+saHzb8=;
	b=LeSRtMVGvoGbCIrCAGZK2JrZ14/aLP6YMBSbhg8w2mdgKgMiD6YhOOiFLEmhN7CCFmZhks
	I+1Kun2EMzHnGaEu6IutB5Jwi4XigAslMn+KWUaKvoPpWgn4nOn+JnRdUkV/QRL4Swj88N
	EOF/+djple1/qBoYRvr2AP4FIJDKou0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705690102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LTCLhiM/0w+aHgqPUYmBgmxvsiEHxwft6QE+saHzb8=;
	b=aRI5dUQ3PGv3C+h/oVP+bBzHv7VwEjOK9F+xhdgaDXQxEQ+uogRufmU/oNIbWKijeTZf3g
	aQ4SNzqqdLHJE3Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705690102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LTCLhiM/0w+aHgqPUYmBgmxvsiEHxwft6QE+saHzb8=;
	b=LeSRtMVGvoGbCIrCAGZK2JrZ14/aLP6YMBSbhg8w2mdgKgMiD6YhOOiFLEmhN7CCFmZhks
	I+1Kun2EMzHnGaEu6IutB5Jwi4XigAslMn+KWUaKvoPpWgn4nOn+JnRdUkV/QRL4Swj88N
	EOF/+djple1/qBoYRvr2AP4FIJDKou0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705690102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LTCLhiM/0w+aHgqPUYmBgmxvsiEHxwft6QE+saHzb8=;
	b=aRI5dUQ3PGv3C+h/oVP+bBzHv7VwEjOK9F+xhdgaDXQxEQ+uogRufmU/oNIbWKijeTZf3g
	aQ4SNzqqdLHJE3Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 820A4136F5;
	Fri, 19 Jan 2024 18:48:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HYwBD/XDqmVZDAAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 19 Jan 2024 18:48:21 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk,
	ebiggers@kernel.org,
	jaegeuk@kernel.org,
	tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v3 05/10] libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
Date: Fri, 19 Jan 2024 15:47:37 -0300
Message-ID: <20240119184742.31088-6-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119184742.31088-1-krisman@suse.de>
References: <20240119184742.31088-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

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



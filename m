Return-Path: <linux-fsdevel+bounces-12289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7DD85E439
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 18:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21B81C229A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 17:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60E884037;
	Wed, 21 Feb 2024 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GzS85U4X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UORXpuIh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GzS85U4X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UORXpuIh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FCF83A10;
	Wed, 21 Feb 2024 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535678; cv=none; b=OJ3MB+84RHUFdYKIZ601buO7sVvYDu435rBbkxH4nmLO2D/TqJSH+A7RafFl48LgOWoHQv2+z1EUnGKXqkvylAd1UKcQPw5zNSbevc321MDyDWg5mc8SScW1+dF6QxuvWncN99jXI1hq3jgJpwc5kXnpDgHXzT6IaL7tgAVQYYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535678; c=relaxed/simple;
	bh=PXtiL6C2nV59CWvIs6rcclrlqY5sfi2s/kdOktmFk58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7O1lgoj9+inUatvEWmacrEPgi2p8UPXGNm1DGbfUubGmxj9tDZPXJ9Z1oWMIBwqDRXlfxTG4AAkPTbFlww+j22aLcNPbl40XaPO8w9BIQyXGxKkq1dHbGEK0/WJO63/qIem8XDQmyIdJto1d3TZJal4UKVp+MWXXsZWxLe4cgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GzS85U4X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UORXpuIh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GzS85U4X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UORXpuIh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 020981FB6E;
	Wed, 21 Feb 2024 17:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708535675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ndF6V3SsLiNbHHQyhRWSN0rON3hSgfDFtfJaeKlRqQ=;
	b=GzS85U4XkXWwwj3i4mD2dPjc2f+aF7rlVeyLRADTO5/4r+/8N8y49GYh7G19JSiNjqQGpK
	QVwKQg86ZlE31tecpFnunLcmItr/UnO1CYtYc0gOx/ibMWWx41daZBTyCBrg+EUOent5l3
	+vZDfsCQpqy3iVnL85V1v5QjtIW7cag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708535675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ndF6V3SsLiNbHHQyhRWSN0rON3hSgfDFtfJaeKlRqQ=;
	b=UORXpuIhNjKfIazNqmcmoFbUertfP2K/sfrtbyxWL8IPJdNcNCrM+wzmP7d7a0YERZfKrc
	fPqXs/SfLSMvnzBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708535675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ndF6V3SsLiNbHHQyhRWSN0rON3hSgfDFtfJaeKlRqQ=;
	b=GzS85U4XkXWwwj3i4mD2dPjc2f+aF7rlVeyLRADTO5/4r+/8N8y49GYh7G19JSiNjqQGpK
	QVwKQg86ZlE31tecpFnunLcmItr/UnO1CYtYc0gOx/ibMWWx41daZBTyCBrg+EUOent5l3
	+vZDfsCQpqy3iVnL85V1v5QjtIW7cag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708535675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ndF6V3SsLiNbHHQyhRWSN0rON3hSgfDFtfJaeKlRqQ=;
	b=UORXpuIhNjKfIazNqmcmoFbUertfP2K/sfrtbyxWL8IPJdNcNCrM+wzmP7d7a0YERZfKrc
	fPqXs/SfLSMvnzBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDD40139D0;
	Wed, 21 Feb 2024 17:14:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id opJQKHov1mViKgAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 21 Feb 2024 17:14:34 +0000
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
Subject: [PATCH v7 05/10] libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
Date: Wed, 21 Feb 2024 12:14:07 -0500
Message-ID: <20240221171412.10710-6-krisman@suse.de>
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
X-Spam-Level: 
X-Spam-Score: -0.45
X-Spamd-Result: default: False [-0.45 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[mit.edu,gmail.com,vger.kernel.org,lists.sourceforge.net,kernel.org,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.15)[68.52%]
X-Spam-Flag: NO

In preparation to get case-insensitive dentry operations from sb->s_d_op
again, use the same structure with and without fscrypt.

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



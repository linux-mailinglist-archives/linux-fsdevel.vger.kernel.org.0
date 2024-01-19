Return-Path: <linux-fsdevel+bounces-8337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C698D832F32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 19:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E861F263EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 18:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A105647D;
	Fri, 19 Jan 2024 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tE9psFBD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5RSmKEq6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tE9psFBD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5RSmKEq6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87B75674C;
	Fri, 19 Jan 2024 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705690132; cv=none; b=FmWIGbYmhyPqteV/BxJ57dLaa3WBW0FQl2BTUOEK6CGgrzjpNL0rGMo5Kc1Q44H2ww2EU9t1JBj4Zkf7du0wZObUOce6bkWoPLEprZIuP1qgOuu1i42/+4bJSQj2orIaJZ/XFdRZW+pJeTy/gWR+pPgr5027v1+jH4TF1onw1hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705690132; c=relaxed/simple;
	bh=Kj5D36lqEJ+u6O/TSFro1d3U+G77/yBKoYveG/26XpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBvXF33mC+U0ULDpT7fXo7P1kFBJbvAhHA/TmU9rBD3HkcvK6BHmLWqbbTadJ5gc0YIuKCuxgvpStCWjr1ktsay0tnZXgGNVNGV3b+fxUMHFxz83SerBjtCEXyatjzB0y+OfucXQy6V1Ywv/Kkv9eq5m6sGKfTVYkOlbXNRdxrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tE9psFBD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5RSmKEq6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tE9psFBD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5RSmKEq6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2389D1FD1A;
	Fri, 19 Jan 2024 18:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705690129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=krPNAWpEhdO9kMaWrWqIUhp9mxXxNNl19QSIc2wCsrs=;
	b=tE9psFBDtpm9LAE8wt8mo6BXItPt2sDmagaIsQEAQLakn3yqE57HcRt2jRVbPYJRRMVPf8
	3/TbDvEoP6IdVudPVQ3BHEy4YUU5FZymJvpi81VcIlDFIfhKd2n7+h3ZKIahGrcxNligRY
	Mc9c9NBeuxNxws6k42/mZltArIVQB04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705690129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=krPNAWpEhdO9kMaWrWqIUhp9mxXxNNl19QSIc2wCsrs=;
	b=5RSmKEq6JqBqmAsHWoX3BJyhmY0FpZ6zphEu9XoVLdyBO538r7P42ebgDi/oBOZtcPePv2
	Mg0KCniogrvCL2BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705690129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=krPNAWpEhdO9kMaWrWqIUhp9mxXxNNl19QSIc2wCsrs=;
	b=tE9psFBDtpm9LAE8wt8mo6BXItPt2sDmagaIsQEAQLakn3yqE57HcRt2jRVbPYJRRMVPf8
	3/TbDvEoP6IdVudPVQ3BHEy4YUU5FZymJvpi81VcIlDFIfhKd2n7+h3ZKIahGrcxNligRY
	Mc9c9NBeuxNxws6k42/mZltArIVQB04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705690129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=krPNAWpEhdO9kMaWrWqIUhp9mxXxNNl19QSIc2wCsrs=;
	b=5RSmKEq6JqBqmAsHWoX3BJyhmY0FpZ6zphEu9XoVLdyBO538r7P42ebgDi/oBOZtcPePv2
	Mg0KCniogrvCL2BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7128C136F5;
	Fri, 19 Jan 2024 18:48:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bOvFChDEqmV5DAAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 19 Jan 2024 18:48:48 +0000
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
Subject: [PATCH v3 10/10] libfs: Drop generic_set_encrypted_ci_d_ops
Date: Fri, 19 Jan 2024 15:47:42 -0300
Message-ID: <20240119184742.31088-11-krisman@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
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
	 R_RATELIMIT(0.00)[to_ip_from(RLzk7q5dcbbphp39zi8hi5jhbt)];
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

No filesystems depend on it anymore, and it is generally a bad idea.
Since all dentries should have the same set of dentry operations in
case-insensitive filesystems, it should be propagated through ->s_d_op.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/libfs.c         | 34 ----------------------------------
 include/linux/fs.h |  1 -
 2 files changed, 35 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 9cd4df6969d2..c5c92ac76ba7 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1788,40 +1788,6 @@ static const struct dentry_operations generic_encrypted_dentry_ops = {
 };
 #endif
 
-/**
- * generic_set_encrypted_ci_d_ops - helper for setting d_ops for given dentry
- * @dentry:	dentry to set ops on
- *
- * Casefolded directories need d_hash and d_compare set, so that the dentries
- * contained in them are handled case-insensitively.  Note that these operations
- * are needed on the parent directory rather than on the dentries in it, and
- * while the casefolding flag can be toggled on and off on an empty directory,
- * dentry_operations can't be changed later.  As a result, if the filesystem has
- * casefolding support enabled at all, we have to give all dentries the
- * casefolding operations even if their inode doesn't have the casefolding flag
- * currently (and thus the casefolding ops would be no-ops for now).
- *
- * Encryption works differently in that the only dentry operation it needs is
- * d_revalidate, which it only needs on dentries that have the no-key name flag.
- * The no-key flag can't be set "later", so we don't have to worry about that.
- */
-void generic_set_encrypted_ci_d_ops(struct dentry *dentry)
-{
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (dentry->d_sb->s_encoding) {
-		d_set_d_op(dentry, &generic_ci_dentry_ops);
-		return;
-	}
-#endif
-#ifdef CONFIG_FS_ENCRYPTION
-	if (dentry->d_flags & DCACHE_NOKEY_NAME) {
-		d_set_d_op(dentry, &generic_encrypted_dentry_ops);
-		return;
-	}
-#endif
-}
-EXPORT_SYMBOL(generic_set_encrypted_ci_d_ops);
-
 /**
  * generic_set_sb_d_ops - helper for choosing the set of
  * filesystem-wide dentry operations for the enabled features
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c985d9392b61..c0cfc53f95bb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3201,7 +3201,6 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 
 extern int generic_check_addressable(unsigned, u64);
 
-extern void generic_set_encrypted_ci_d_ops(struct dentry *dentry);
 extern void generic_set_sb_d_ops(struct super_block *sb);
 
 static inline bool sb_has_encoding(const struct super_block *sb)
-- 
2.43.0



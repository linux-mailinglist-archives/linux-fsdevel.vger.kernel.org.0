Return-Path: <linux-fsdevel+bounces-12290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D3185E43C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 18:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094CE1F2582C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 17:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5694083CC1;
	Wed, 21 Feb 2024 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vroX+M9e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LC4YD44f";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vroX+M9e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LC4YD44f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383561DA32;
	Wed, 21 Feb 2024 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535683; cv=none; b=HPMpKHOZxGEMVhvpWr0NgElDFy0qx1xoNyK6ek+K3PcuVMFId5EZjbMYu4fvBW/4hTF8g/IZjfh1dGrvSWAnspvUTmYO9vycAZ/NR4RRdJx5p5zSngDFG0R91NXbDxHyj5AF2imenHa+KTNRWlF/o2mBPZSHiACdpAaXUMBTVcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535683; c=relaxed/simple;
	bh=8KvF2pTb3E+igBwE1A5eAT6de1YY3lOPRIH1gV1BZRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVlzNdhmISjRjNjUgiRj1Jb43XhGBPICQzMCUUOjvYPcq1WDrMJFA+lRGOPeYitiuGGtb/77yeBhPGuSkjk/5LOJ+9Bp/IHkmY7Mu0RnonT7B35gwm3YDdaTXS/Ojvy3KcX2W2RAINxtG/RCt7coZmZg0FMc+tevA3s/2ZXyNBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vroX+M9e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LC4YD44f; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vroX+M9e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LC4YD44f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8CC1A21DC8;
	Wed, 21 Feb 2024 17:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708535680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7ZNiObuWDS9LBRJ78fuLAlJGd+uQndWdyw51G7pKEU=;
	b=vroX+M9eWVEC+BMI4lef7/fkcVx3XMMbAfBv4K5jTSwXOxiZCoHYjbqeNARYtZIjLKKE31
	9PkXrg2yeljAY1Ss+V/dt5Fe+bfIqAea1Xl/1J89TaEypqt5PQcEF6BMKw+LUHyx9xN5Rc
	Yjo9m4xTt2FLG76XlY89lkfTeEBa8lo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708535680;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7ZNiObuWDS9LBRJ78fuLAlJGd+uQndWdyw51G7pKEU=;
	b=LC4YD44f750zHoezml6rAHh9Ug+undgo8yI5X9vqtnbkfOWR4e6MllBOQS4MkgnrXdvSyJ
	JYY1tJkGT5JHcODg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708535680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7ZNiObuWDS9LBRJ78fuLAlJGd+uQndWdyw51G7pKEU=;
	b=vroX+M9eWVEC+BMI4lef7/fkcVx3XMMbAfBv4K5jTSwXOxiZCoHYjbqeNARYtZIjLKKE31
	9PkXrg2yeljAY1Ss+V/dt5Fe+bfIqAea1Xl/1J89TaEypqt5PQcEF6BMKw+LUHyx9xN5Rc
	Yjo9m4xTt2FLG76XlY89lkfTeEBa8lo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708535680;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7ZNiObuWDS9LBRJ78fuLAlJGd+uQndWdyw51G7pKEU=;
	b=LC4YD44f750zHoezml6rAHh9Ug+undgo8yI5X9vqtnbkfOWR4e6MllBOQS4MkgnrXdvSyJ
	JYY1tJkGT5JHcODg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 534DF139D0;
	Wed, 21 Feb 2024 17:14:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JFRgDoAv1mVyKgAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 21 Feb 2024 17:14:40 +0000
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
Subject: [PATCH v7 06/10] libfs: Add helper to choose dentry operations at mount-time
Date: Wed, 21 Feb 2024 12:14:08 -0500
Message-ID: <20240221171412.10710-7-krisman@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.86 / 50.00];
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
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[mit.edu,gmail.com,vger.kernel.org,lists.sourceforge.net,kernel.org,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.04)[57.87%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.86

In preparation to drop the similar helper that sets d_op at lookup time,
add a version to set the right d_op filesystem-wide, through sb->s_d_op.
The operations structures are shared across filesystems supporting
fscrypt and/or casefolding, therefore we can keep it in common libfs
code.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

---
changes since v3:
  - Fix typo in comment (Eric)
---
 fs/libfs.c         | 28 ++++++++++++++++++++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index c4be0961faf0..0aa388ee82ff 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1822,6 +1822,34 @@ void generic_set_encrypted_ci_d_ops(struct dentry *dentry)
 }
 EXPORT_SYMBOL(generic_set_encrypted_ci_d_ops);
 
+/**
+ * generic_set_sb_d_ops - helper for choosing the set of
+ * filesystem-wide dentry operations for the enabled features
+ * @sb: superblock to be configured
+ *
+ * Filesystems supporting casefolding and/or fscrypt can call this
+ * helper at mount-time to configure sb->s_d_op to best set of dentry
+ * operations required for the enabled features. The helper must be
+ * called after these have been configured, but before the root dentry
+ * is created.
+ */
+void generic_set_sb_d_ops(struct super_block *sb)
+{
+#if IS_ENABLED(CONFIG_UNICODE)
+	if (sb->s_encoding) {
+		sb->s_d_op = &generic_ci_dentry_ops;
+		return;
+	}
+#endif
+#ifdef CONFIG_FS_ENCRYPTION
+	if (sb->s_cop) {
+		sb->s_d_op = &generic_encrypted_dentry_ops;
+		return;
+	}
+#endif
+}
+EXPORT_SYMBOL(generic_set_sb_d_ops);
+
 /**
  * inode_maybe_inc_iversion - increments i_version
  * @inode: inode with the i_version that should be updated
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e6667ece5e64..c985d9392b61 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3202,6 +3202,7 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 extern int generic_check_addressable(unsigned, u64);
 
 extern void generic_set_encrypted_ci_d_ops(struct dentry *dentry);
+extern void generic_set_sb_d_ops(struct super_block *sb);
 
 static inline bool sb_has_encoding(const struct super_block *sb)
 {
-- 
2.43.0



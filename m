Return-Path: <linux-fsdevel+bounces-6234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F3F8151CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 22:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6299B286DC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F8E49F74;
	Fri, 15 Dec 2023 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uHpAeEOV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TisYrlla";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uHpAeEOV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TisYrlla"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFFD49F61;
	Fri, 15 Dec 2023 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 573B31F867;
	Fri, 15 Dec 2023 21:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702674988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ukGIZU8SjDCjm+5RFEuvLetuIyhrzB5yLu8+TLHYt4c=;
	b=uHpAeEOVQfYVN6npn6Ox1wYzLw9nlq9Vq2mcQBjfYmElyvENCy0kSzbeUss3chRItchHth
	mTfumbNOR/3rlj5Bo7MQI2cipHyDmlzGOBrtsonXc1RXu+psJEIA3k5Rw3ACDORLDYyvsH
	wUQs12tQrxTN0n93mHI1IRWYLO79bBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702674988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ukGIZU8SjDCjm+5RFEuvLetuIyhrzB5yLu8+TLHYt4c=;
	b=TisYrllaZ3zck7CfP/s+m9iqnLiVXDhuT/h7lUN2YAevAdJTDbBA9M4vjQtaKb0lM6fW7G
	3DMx245OFhHxy8Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702674988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ukGIZU8SjDCjm+5RFEuvLetuIyhrzB5yLu8+TLHYt4c=;
	b=uHpAeEOVQfYVN6npn6Ox1wYzLw9nlq9Vq2mcQBjfYmElyvENCy0kSzbeUss3chRItchHth
	mTfumbNOR/3rlj5Bo7MQI2cipHyDmlzGOBrtsonXc1RXu+psJEIA3k5Rw3ACDORLDYyvsH
	wUQs12tQrxTN0n93mHI1IRWYLO79bBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702674988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ukGIZU8SjDCjm+5RFEuvLetuIyhrzB5yLu8+TLHYt4c=;
	b=TisYrllaZ3zck7CfP/s+m9iqnLiVXDhuT/h7lUN2YAevAdJTDbBA9M4vjQtaKb0lM6fW7G
	3DMx245OFhHxy8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16DFE137D4;
	Fri, 15 Dec 2023 21:16:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lN9VOivCfGWUOQAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 15 Dec 2023 21:16:27 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk,
	ebiggers@kernel.org,
	jaegeuk@kernel.org,
	tytso@mit.edu
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v2 5/8] ext4: Set the case-insensitive dentry operations through ->s_d_op
Date: Fri, 15 Dec 2023 16:16:05 -0500
Message-ID: <20231215211608.6449-6-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215211608.6449-1-krisman@suse.de>
References: <20231215211608.6449-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linux.org.uk:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[12.94%]
X-Spam-Flag: NO

All dentries in a case-insensitive filesystem have the same set of
dentry operations.  Therefore, we should let VFS propagate them from
sb->s_d_op d_alloc instead of setting at lookup time.

This was already the case before commit bb9cd9106b22 ("fscrypt: Have
filesystems handle their d_ops"), but it was changed to set at
lookup-time to facilitate the integration with fscrypt.  But it's a
problem because dentries that don't get created through ->lookup() won't
have any visibility of the operations.  Let's revert to the previous
implementation.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

---
changes since v1:
  - Fix CONFIG_UNICODE=n build (lkp)
---
 fs/ext4/namei.c | 6 +++++-
 fs/ext4/super.c | 5 +++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index d252935f9c8a..463e73fb5bf0 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1762,7 +1762,11 @@ static struct buffer_head *ext4_lookup_entry(struct inode *dir,
 	struct buffer_head *bh;
 
 	err = ext4_fname_prepare_lookup(dir, dentry, &fname);
-	generic_set_encrypted_ci_d_ops(dentry);
+
+	/* Case-insensitive volumes set dentry ops through sb->s_d_op. */
+	if (!dir->i_sb->s_d_op)
+		generic_set_encrypted_ci_d_ops(dentry);
+
 	if (err == -ENOENT)
 		return NULL;
 	if (err)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c5fcf377ab1f..e0680d0641aa 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5493,6 +5493,11 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		goto failed_mount4;
 	}
 
+#if IS_ENABLED(CONFIG_UNICODE)
+	if (sb->s_encoding)
+		sb->s_d_op = &generic_ci_dentry_ops;
+#endif
+
 	sb->s_root = d_make_root(root);
 	if (!sb->s_root) {
 		ext4_msg(sb, KERN_ERR, "get root dentry failed");
-- 
2.43.0



Return-Path: <linux-fsdevel+bounces-6235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706B78151D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 22:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39671C23E9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A9F49F81;
	Fri, 15 Dec 2023 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Os5wdbIC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MhiXQQVZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Os5wdbIC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MhiXQQVZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C9B49F70;
	Fri, 15 Dec 2023 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A6B41F855;
	Fri, 15 Dec 2023 21:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702674990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zHvzCVpUzO/WVW65Ji92QCoBmB2JO4/PTv0toH5FDE=;
	b=Os5wdbIC5gYaOirMLKX+gCH+nu5THrpihNWYVA8KvupCnmrEuuiSQM3PtN+cAfqFuVcn8e
	x2gNDKFH5XCwSWbRY25C7bEGLp9fAW4bug64Wtg1DTfcXOsXQyZ39RSMYFwJEfTp7vPqn8
	jcH5gxdAIMtrgDNvS/zP6OO7iVWL4zM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702674990;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zHvzCVpUzO/WVW65Ji92QCoBmB2JO4/PTv0toH5FDE=;
	b=MhiXQQVZnxYArrFmeb+U6p/dOGV4IYWP8+6eAh/6xi0jKWwZbTLKgoyg+DcOlJolkPrl4N
	4J0CGNm19jaiQeDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702674990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zHvzCVpUzO/WVW65Ji92QCoBmB2JO4/PTv0toH5FDE=;
	b=Os5wdbIC5gYaOirMLKX+gCH+nu5THrpihNWYVA8KvupCnmrEuuiSQM3PtN+cAfqFuVcn8e
	x2gNDKFH5XCwSWbRY25C7bEGLp9fAW4bug64Wtg1DTfcXOsXQyZ39RSMYFwJEfTp7vPqn8
	jcH5gxdAIMtrgDNvS/zP6OO7iVWL4zM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702674990;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zHvzCVpUzO/WVW65Ji92QCoBmB2JO4/PTv0toH5FDE=;
	b=MhiXQQVZnxYArrFmeb+U6p/dOGV4IYWP8+6eAh/6xi0jKWwZbTLKgoyg+DcOlJolkPrl4N
	4J0CGNm19jaiQeDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA379137D4;
	Fri, 15 Dec 2023 21:16:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2hsBLi3CfGWaOQAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 15 Dec 2023 21:16:29 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk,
	ebiggers@kernel.org,
	jaegeuk@kernel.org,
	tytso@mit.edu
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v2 6/8] f2fs: Set the case-insensitive dentry operations through ->s_d_op
Date: Fri, 15 Dec 2023 16:16:06 -0500
Message-ID: <20231215211608.6449-7-krisman@suse.de>
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.69
X-Spamd-Bar: ++++
X-Spam-Flag: NO
X-Spamd-Result: default: False [4.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,linux.org.uk:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[13.47%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Os5wdbIC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MhiXQQVZ
X-Spam-Level: ****
X-Rspamd-Queue-Id: 2A6B41F855

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
 fs/f2fs/namei.c | 6 +++++-
 fs/f2fs/super.c | 5 +++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index d0053b0284d8..6aec21f0b5d6 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -532,7 +532,11 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	}
 
 	err = f2fs_prepare_lookup(dir, dentry, &fname);
-	generic_set_encrypted_ci_d_ops(dentry);
+
+	/* Case-insensitive volumes set dentry ops through sb->s_d_op. */
+	if (!dir->i_sb->s_d_op)
+		generic_set_encrypted_ci_d_ops(dentry);
+
 	if (err == -ENOENT)
 		goto out_splice;
 	if (err)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 033af907c3b1..8d1abd7f3a6f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4663,6 +4663,11 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_node_inode;
 	}
 
+#if IS_ENABLED(CONFIG_UNICODE)
+	if (sb->s_encoding)
+		sb->s_d_op = &generic_ci_dentry_ops;
+#endif
+
 	sb->s_root = d_make_root(root); /* allocate root dentry */
 	if (!sb->s_root) {
 		err = -ENOMEM;
-- 
2.43.0



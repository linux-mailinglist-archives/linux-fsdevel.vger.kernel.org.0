Return-Path: <linux-fsdevel+bounces-6023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A6381235A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 00:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3901F21A26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 23:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6206779474;
	Wed, 13 Dec 2023 23:41:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7FA326C;
	Wed, 13 Dec 2023 15:41:02 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F4B322315;
	Wed, 13 Dec 2023 23:40:53 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4532B1377F;
	Wed, 13 Dec 2023 23:40:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7iDFCgVBemVzPgAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 13 Dec 2023 23:40:53 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk,
	ebiggers@kernel.org,
	jaegeuk@kernel.org,
	tytso@mit.edu
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH 6/8] f2fs: Set the case-insensitive dentry operations through ->s_d_op
Date: Wed, 13 Dec 2023 18:40:29 -0500
Message-ID: <20231213234031.1081-7-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213234031.1081-1-krisman@suse.de>
References: <20231213234031.1081-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 7F4B322315
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
 fs/f2fs/namei.c | 6 +++++-
 fs/f2fs/super.c | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index d0053b0284d8..4053846e2cd3 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -532,7 +532,11 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	}
 
 	err = f2fs_prepare_lookup(dir, dentry, &fname);
-	generic_set_encrypted_ci_d_ops(dentry);
+
+	/* Case-insensitive volumes set dentry ops through sb->s_d_op. */
+	if (!dir->i_sb->s_encoding)
+		generic_set_encrypted_ci_d_ops(dentry);
+
 	if (err == -ENOENT)
 		goto out_splice;
 	if (err)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 033af907c3b1..0a199eb5b01e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4663,6 +4663,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_node_inode;
 	}
 
+	if (sb->s_encoding)
+		sb->s_d_op = &generic_ci_dentry_ops;
+
 	sb->s_root = d_make_root(root); /* allocate root dentry */
 	if (!sb->s_root) {
 		err = -ENOMEM;
-- 
2.43.0



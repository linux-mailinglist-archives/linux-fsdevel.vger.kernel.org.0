Return-Path: <linux-fsdevel+bounces-6027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9469812366
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 00:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263BA1C213C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 23:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D263B79E11;
	Wed, 13 Dec 2023 23:41:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3658F1BE3;
	Wed, 13 Dec 2023 15:41:03 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 115201F792;
	Wed, 13 Dec 2023 23:40:55 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC26A1377F;
	Wed, 13 Dec 2023 23:40:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g8DAKwZBemV6PgAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 13 Dec 2023 23:40:54 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk,
	ebiggers@kernel.org,
	jaegeuk@kernel.org,
	tytso@mit.edu
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH 7/8] libfs: Don't support setting casefold operations during lookup
Date: Wed, 13 Dec 2023 18:40:30 -0500
Message-ID: <20231213234031.1081-8-krisman@suse.de>
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
X-Spam-Flag: NO
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 115201F792
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]

No filesystems depend on it anymore, and it is generally a bad idea.
Since all dentries should have the same set of dentry operations in
case-insensitive filesystems, it should be configured through ->s_d_op.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/libfs.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index b8ecada3a5b2..41c02c003265 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1784,27 +1784,12 @@ static const struct dentry_operations generic_encrypted_dentry_ops = {
  * generic_set_encrypted_ci_d_ops - helper for setting d_ops for given dentry
  * @dentry:	dentry to set ops on
  *
- * Casefolded directories need d_hash and d_compare set, so that the dentries
- * contained in them are handled case-insensitively.  Note that these operations
- * are needed on the parent directory rather than on the dentries in it, and
- * while the casefolding flag can be toggled on and off on an empty directory,
- * dentry_operations can't be changed later.  As a result, if the filesystem has
- * casefolding support enabled at all, we have to give all dentries the
- * casefolding operations even if their inode doesn't have the casefolding flag
- * currently (and thus the casefolding ops would be no-ops for now).
- *
  * Encryption works differently in that the only dentry operation it needs is
  * d_revalidate, which it only needs on dentries that have the no-key name flag.
  * The no-key flag can't be set "later", so we don't have to worry about that.
  */
 void generic_set_encrypted_ci_d_ops(struct dentry *dentry)
 {
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (dentry->d_sb->s_encoding) {
-		d_set_d_op(dentry, &generic_ci_dentry_ops);
-		return;
-	}
-#endif
 #ifdef CONFIG_FS_ENCRYPTION
 	if (dentry->d_flags & DCACHE_NOKEY_NAME) {
 		d_set_d_op(dentry, &generic_encrypted_dentry_ops);
-- 
2.43.0



Return-Path: <linux-fsdevel+bounces-43440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00180A56AB7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 15:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CEA716E915
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 14:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A10621C185;
	Fri,  7 Mar 2025 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ig1xhsre";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nT/DxXqZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ig1xhsre";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nT/DxXqZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389AB21ABC3
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358616; cv=none; b=jyT7syuQbDWNqPLU78qhgxtsc1MScbmQ2+U2XlPM+1XpTFKIzmSkEgQwjGZbvoYSl58eyyQ3KUpDEA0cBH31vT4cxEzh6X0a9xg029D5U+IZ7iEjknblHA+VZpGc84gFSVKXDxMewnPvlTBbvCiKzycflh1RpQH/XkDISg5yFq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358616; c=relaxed/simple;
	bh=LtTJQvneGUIv6+J0NB9j/Nasj0jr25DMUz3el7RKkLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dM/PGCbdsvFSI+hl+rjMHJrapi3dhYwCaoaE5KmagTeJZULCksd29zetbgRpremK9dxlAtk3FxxuI9x/QNOnVeNFSxFoFzDBnkbl7vLFBTT9DfXAdIwm1oiyw/j0iRTy7qCqaPpK6wml0UvPQLKLR1OSMa3TiRPWFWfAnyylWJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ig1xhsre; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nT/DxXqZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ig1xhsre; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nT/DxXqZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 631E121186;
	Fri,  7 Mar 2025 14:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741358613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AxjF2KvYOHWDrhe34VUsxz93LKURJVjrw31QG0JOUuA=;
	b=ig1xhsre0iR5baBNFiZJBVR/YJC5T/YBT2PaqkIzPcuA5fBojSbG0rOtJgxFLIpp8mmUVO
	4kCqfo4Z/IiexFrF1MFXXvriikpACIJ5q9wt2p4BCfYFqPXBL6v3Y/dLi/m/RcwUfSTioX
	ewKYRe2EK0C5874NjaysLiak9fCK3Bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741358613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AxjF2KvYOHWDrhe34VUsxz93LKURJVjrw31QG0JOUuA=;
	b=nT/DxXqZU1f8+8jdo7Lb8r0sEzKI+noxu39vGdVN0arQh4VwPWgL+ZVYf3y6pZ0iTS1vF7
	7z6fFJasPvBucjBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741358613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AxjF2KvYOHWDrhe34VUsxz93LKURJVjrw31QG0JOUuA=;
	b=ig1xhsre0iR5baBNFiZJBVR/YJC5T/YBT2PaqkIzPcuA5fBojSbG0rOtJgxFLIpp8mmUVO
	4kCqfo4Z/IiexFrF1MFXXvriikpACIJ5q9wt2p4BCfYFqPXBL6v3Y/dLi/m/RcwUfSTioX
	ewKYRe2EK0C5874NjaysLiak9fCK3Bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741358613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AxjF2KvYOHWDrhe34VUsxz93LKURJVjrw31QG0JOUuA=;
	b=nT/DxXqZU1f8+8jdo7Lb8r0sEzKI+noxu39vGdVN0arQh4VwPWgL+ZVYf3y6pZ0iTS1vF7
	7z6fFJasPvBucjBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AFA013939;
	Fri,  7 Mar 2025 14:43:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NVkxFhUGy2f1MAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 07 Mar 2025 14:43:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1CBA7A087F; Fri,  7 Mar 2025 15:43:33 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] vfs: Remove invalidate_inodes()
Date: Fri,  7 Mar 2025 15:43:19 +0100
Message-ID: <20250307144318.28120-2-jack@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3374; i=jack@suse.cz; h=from:subject; bh=LtTJQvneGUIv6+J0NB9j/Nasj0jr25DMUz3el7RKkLo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBnywYGzxh9UXQN4vWPI6MQqZu3J2xCJom60zujTbFD aFWtciGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZ8sGBgAKCRCcnaoHP2RA2dm6B/ 9PLZYpH8acnHLsznFyqEqpK7EW+uGaLdONB7A1evfh6t2ytHdetI1vFy6T+ASWj22ATvlJk5ZwWCkG yO3euYkQdl/n+PVEv01NYZPpZcSvyf/seczyv03Wq+uGYVNunPyUPpXlsJ/nlc1Q/AgrauJ+zkRySE 0KV9OeMApqsBB9jLJH11hfdQxpyWSieRwhdcfSwYiRcqrvWSeS1IPwXXfGHI7Xnjawt+q8mOus+S+D axDR0yg4lFAvmOOBq6F9IG/Vz53ACuZcLGOO2ei6IcfnTexLEpjA2ztPUcw++WME+Ir6OoP20GgeO2 rx4vfAXNGy55lo2WEyNNxJ8I3Epys+
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The function is exactly the same as evict_inodes() and has only one
user.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/inode.c             | 40 ----------------------------------------
 fs/internal.h          |  1 -
 fs/smb/client/file.c   |  2 +-
 fs/super.c             |  2 +-
 security/landlock/fs.c |  2 +-
 5 files changed, 3 insertions(+), 44 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 5587aabdaa5e..2e32df15748a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -900,46 +900,6 @@ void evict_inodes(struct super_block *sb)
 }
 EXPORT_SYMBOL_GPL(evict_inodes);
 
-/**
- * invalidate_inodes	- attempt to free all inodes on a superblock
- * @sb:		superblock to operate on
- *
- * Attempts to free all inodes (including dirty inodes) for a given superblock.
- */
-void invalidate_inodes(struct super_block *sb)
-{
-	struct inode *inode, *next;
-	LIST_HEAD(dispose);
-
-again:
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
-		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		if (atomic_read(&inode->i_count)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-
-		inode->i_state |= I_FREEING;
-		inode_lru_list_del(inode);
-		spin_unlock(&inode->i_lock);
-		list_add(&inode->i_lru, &dispose);
-		if (need_resched()) {
-			spin_unlock(&sb->s_inode_list_lock);
-			cond_resched();
-			dispose_list(&dispose);
-			goto again;
-		}
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-
-	dispose_list(&dispose);
-}
-
 /*
  * Isolate the inode from the LRU in preparation for freeing it.
  *
diff --git a/fs/internal.h b/fs/internal.h
index e7f02ae1e098..7cb515cede3f 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -207,7 +207,6 @@ bool in_group_or_capable(struct mnt_idmap *idmap,
  * fs-writeback.c
  */
 extern long get_nr_dirty_inodes(void);
-void invalidate_inodes(struct super_block *sb);
 
 /*
  * dcache.c
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 8582cf61242c..9e4f7378f30f 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -388,7 +388,7 @@ cifs_mark_open_files_invalid(struct cifs_tcon *tcon)
 	spin_unlock(&tcon->tc_lock);
 
 	/*
-	 * BB Add call to invalidate_inodes(sb) for all superblocks mounted
+	 * BB Add call to evict_inodes(sb) for all superblocks mounted
 	 * to this tcon.
 	 */
 }
diff --git a/fs/super.c b/fs/super.c
index 5a7db4a556e3..5b38d2d92252 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1417,7 +1417,7 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
 	if (!surprise)
 		sync_filesystem(sb);
 	shrink_dcache_sb(sb);
-	invalidate_inodes(sb);
+	evict_inodes(sb);
 	if (sb->s_op->shutdown)
 		sb->s_op->shutdown(sb);
 
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 71b9dc331aae..582769ae830e 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1216,7 +1216,7 @@ static void hook_inode_free_security_rcu(void *inode_security)
 /*
  * Release the inodes used in a security policy.
  *
- * Cf. fsnotify_unmount_inodes() and invalidate_inodes()
+ * Cf. fsnotify_unmount_inodes() and evict_inodes()
  */
 static void hook_sb_delete(struct super_block *const sb)
 {
-- 
2.43.0



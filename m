Return-Path: <linux-fsdevel+bounces-79156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA2tN6S6pmkPTQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:40:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AFB1ECD57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 601CD30FED7D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5217C388E62;
	Tue,  3 Mar 2026 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K3uKLL8z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="exZfjXTJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K3uKLL8z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="exZfjXTJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863223822B5
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534137; cv=none; b=uCJsj1GgLmwgfCGrFh/18nXChvOLoJTHHEXTNcw4cEG45uZ5QAnrfTyEu7hLTy9Praa9DA1X2f7+a7JRsWGLyQBVesVG60LpBEWzngwrOugqN+OdxCM9hxq8ZMACR8b6AWXyZfOTsAa+pmdqkx9w8fa7E/Q2Tu6F7cDrx3X3Axk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534137; c=relaxed/simple;
	bh=UrmjGTMvHvZZjH02z1XUu785Sp5RrC55KME1GrjfSwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqDU+gqNtE3JgsbLzljc0dBUWGrb/us7cxjaEtXLcheYjQ2jJHVKd9EFYJbDYTpCC48goAjgwVhu048zATpeOGX8fU6gR43UwsY6nAmPk9dC55TCwTR+JBdoJ7qGIpKXvRqYdeOK5lvJKvRrF1mJYP0k2sgmDYfbci79OT/sJrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K3uKLL8z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=exZfjXTJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K3uKLL8z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=exZfjXTJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5171E5BE29;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwONbQuYabmzMkw0cd9UbHOf/oS9F5yVQbeTnfT5C4E=;
	b=K3uKLL8z1VISPzpfs+FsumelIjhVeEpjLWyZAEMOw8WHCSxFNUI/GW+f8F8Woyw2KIn4ku
	Al3Uxq2gSFf8X8fOf93zKgl14HsGoS8fBDd1FayJZD2pVuAG4qATYKlcVF2q3teI9Sbl2O
	U4WExvLMAj8RjSyONfYlvl4+L0cLA+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwONbQuYabmzMkw0cd9UbHOf/oS9F5yVQbeTnfT5C4E=;
	b=exZfjXTJy3my1djHhStLbKl9ZZrdwkZz3Wno2MndXxN1RvdPaiTN3zRhHsMCrxYYkSFZ+b
	+nbisNz9uDSLWiCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwONbQuYabmzMkw0cd9UbHOf/oS9F5yVQbeTnfT5C4E=;
	b=K3uKLL8z1VISPzpfs+FsumelIjhVeEpjLWyZAEMOw8WHCSxFNUI/GW+f8F8Woyw2KIn4ku
	Al3Uxq2gSFf8X8fOf93zKgl14HsGoS8fBDd1FayJZD2pVuAG4qATYKlcVF2q3teI9Sbl2O
	U4WExvLMAj8RjSyONfYlvl4+L0cLA+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwONbQuYabmzMkw0cd9UbHOf/oS9F5yVQbeTnfT5C4E=;
	b=exZfjXTJy3my1djHhStLbKl9ZZrdwkZz3Wno2MndXxN1RvdPaiTN3zRhHsMCrxYYkSFZ+b
	+nbisNz9uDSLWiCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4735A3EA69;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k9BhEUW5pmmNFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0FC8EA0B74; Tue,  3 Mar 2026 11:34:41 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	<linux-ext4@vger.kernel.org>,
	Ted Tso <tytso@mit.edu>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	David Sterba <dsterba@suse.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	linux-mm@kvack.org,
	linux-aio@kvack.org,
	Benjamin LaHaise <bcrl@kvack.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 23/32] ext2: Track metadata bhs in fs-private inode part
Date: Tue,  3 Mar 2026 11:34:12 +0100
Message-ID: <20260303103406.4355-55-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3405; i=jack@suse.cz; h=from:subject; bh=UrmjGTMvHvZZjH02z1XUu785Sp5RrC55KME1GrjfSwI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpprkxPTIrpOhxsJb9ZsjxKcs4IrTg4qj8j1Vyv zpv74Q/WN6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaa5MQAKCRCcnaoHP2RA 2QVyB/9KEXW0GTRN0Ow40ppibeT21iam+b4Y5r/71K/luqeJNO+H9cf4SQ1qz10s2xadiQw9ZNw OsTk48Ll5MKrWuhQxKeRbJx2AqqownV2pBkWvI0tsoFscexzQlu3CDOotHIjaVNPEGY9TLgO6IL S4dcwnVSrvKRmsXV4ve19WLysXS4MwffK/EYT7eHOKTQjvO480pSSMa9tsrKXEx0bJt+itH0OAH lhy6/CvzsFb7Qd8IP2O07qZ6ekVgA1UJrboT5K6jOTk4JUVqbfOGibE//wK4JFv8K8sZTzTlA9A Axg+6m5JBTJJQF83OXHr+OA2wWHVojl9YHU63B1ST9u/vI07
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -5.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 68AFB1ECD57
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-79156-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ZenIV.linux.org.uk,vger.kernel.org,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org,suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Track metadata bhs for an inode in fs-private part of the inode.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/ext2.h    | 2 ++
 fs/ext2/file.c    | 1 +
 fs/ext2/namei.c   | 2 ++
 fs/ext2/super.c   | 6 ++++++
 fs/ext2/symlink.c | 2 ++
 5 files changed, 13 insertions(+)

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 5e0c6c5fcb6c..2b6593ba107f 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -676,6 +676,7 @@ struct ext2_inode_info {
 #ifdef CONFIG_QUOTA
 	struct dquot __rcu *i_dquot[MAXQUOTAS];
 #endif
+	struct mapping_metadata_bhs i_metadata_bhs;
 };
 
 /*
@@ -766,6 +767,7 @@ void ext2_msg(struct super_block *, const char *, const char *, ...);
 extern void ext2_update_dynamic_rev (struct super_block *sb);
 extern void ext2_sync_super(struct super_block *sb, struct ext2_super_block *es,
 			    int wait);
+struct mapping_metadata_bhs *ext2_get_metadata_bhs(struct inode *inode);
 
 /*
  * Inodes and files operations
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index ebe356a38b18..2dbf3e7c2e9c 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -338,4 +338,5 @@ const struct inode_operations ext2_file_inode_operations = {
 	.fiemap		= ext2_fiemap,
 	.fileattr_get	= ext2_fileattr_get,
 	.fileattr_set	= ext2_fileattr_set,
+	.get_metadata_bhs = ext2_get_metadata_bhs,
 };
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index bde617a66cec..70c94adce837 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -422,6 +422,7 @@ const struct inode_operations ext2_dir_inode_operations = {
 	.tmpfile	= ext2_tmpfile,
 	.fileattr_get	= ext2_fileattr_get,
 	.fileattr_set	= ext2_fileattr_set,
+	.get_metadata_bhs = ext2_get_metadata_bhs,
 };
 
 const struct inode_operations ext2_special_inode_operations = {
@@ -430,4 +431,5 @@ const struct inode_operations ext2_special_inode_operations = {
 	.setattr	= ext2_setattr,
 	.get_inode_acl	= ext2_get_acl,
 	.set_acl	= ext2_set_acl,
+	.get_metadata_bhs = ext2_get_metadata_bhs,
 };
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 603f2641fe10..503c25cae27c 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -215,6 +215,7 @@ static struct inode *ext2_alloc_inode(struct super_block *sb)
 #ifdef CONFIG_QUOTA
 	memset(&ei->i_dquot, 0, sizeof(ei->i_dquot));
 #endif
+	mmb_init(&ei->i_metadata_bhs);
 
 	return &ei->vfs_inode;
 }
@@ -259,6 +260,11 @@ static void destroy_inodecache(void)
 	kmem_cache_destroy(ext2_inode_cachep);
 }
 
+struct mapping_metadata_bhs *ext2_get_metadata_bhs(struct inode *inode)
+{
+	return &EXT2_I(inode)->i_metadata_bhs;
+}
+
 static int ext2_show_options(struct seq_file *seq, struct dentry *root)
 {
 	struct super_block *sb = root->d_sb;
diff --git a/fs/ext2/symlink.c b/fs/ext2/symlink.c
index 948d3a441403..c82a15d28772 100644
--- a/fs/ext2/symlink.c
+++ b/fs/ext2/symlink.c
@@ -26,6 +26,7 @@ const struct inode_operations ext2_symlink_inode_operations = {
 	.getattr	= ext2_getattr,
 	.setattr	= ext2_setattr,
 	.listxattr	= ext2_listxattr,
+	.get_metadata_bhs = ext2_get_metadata_bhs,
 };
  
 const struct inode_operations ext2_fast_symlink_inode_operations = {
@@ -33,4 +34,5 @@ const struct inode_operations ext2_fast_symlink_inode_operations = {
 	.getattr	= ext2_getattr,
 	.setattr	= ext2_setattr,
 	.listxattr	= ext2_listxattr,
+	.get_metadata_bhs = ext2_get_metadata_bhs,
 };
-- 
2.51.0



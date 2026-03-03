Return-Path: <linux-fsdevel+bounces-79170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOyREUS6pmn2TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:39:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B03721ECCAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0128330584FE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1913B38229F;
	Tue,  3 Mar 2026 10:36:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AB53822B5
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534194; cv=none; b=VWJoVa5ILig0ApAP8Yt55K4tHnebMPd2z2QS8K/P0M2GRN/Pni/JxKnMLNsIF4chHTclo8igGVy8PifhtORMlXaMwZ9bZPnbGFqTJ0ZZd4mvkPD/UbClufbHwUC57SmC0dJ8yQ/DA65enjoyRDgVlbofFeObITDdYTb03JQqQBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534194; c=relaxed/simple;
	bh=glK5IwI5bzBvc6wGANg8E++2uCF5SfKIYMDofG/EJec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhhoRje/r9qCbOuXwa1rk/Gun99gRENUoWfBC9gUoxUcQFLYuAwQL6i0LP/UP6cc0vqXA7Mf+FrbdM6IJXL0YgIeTYqWF+fPDLPXkDRvs8vpaaQqnere6gsuL6PoccBx76QgnJJNUZcfmeUaUt+S9ZL7Bv2asIGhwmXY/RUFoj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7CFE03F8F3;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67C213EA69;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wgBcGUW5pmmdFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3E25DA0B7E; Tue,  3 Mar 2026 11:34:41 +0100 (CET)
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
Subject: [PATCH 29/32] ext4: Track metadata bhs in fs-private inode part
Date: Tue,  3 Mar 2026 11:34:18 +0100
Message-ID: <20260303103406.4355-61-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4816; i=jack@suse.cz; h=from:subject; bh=glK5IwI5bzBvc6wGANg8E++2uCF5SfKIYMDofG/EJec=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpprk2eXk3gBLtLKTK6vnw0UxDVHoLdffj9Gncu VMs27zm3eaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaa5NgAKCRCcnaoHP2RA 2eMXCACdnE5C1+/lCrGBS99f+cu5Lf4A/gsWSmltB4nZv30ejF4l0epIRPudvmCG0shOIBrkbop +Agkd5u6WzuU/wwY9G/tkZ1vHkxjclfBkREyGftqS6GlfgCwB/PyG+2We/pB1jI0jLriALb3I+w PiKUunQNDYy0QCSziRKPT1DMJSZZcC50ZNQ2e5Kyu9+5AN+kc2WyzJN8T8E6YHunCupUbJ6xgI6 2SvnkBVq2TB6QhV8RybU+648wxdMqHNHcEblqWitBWiXlJGiUX6TwmVNFws9q/avHoDE/zOyKCq 3aRO0APtNPg5S0P2XTORKdcfJTlGHrcnT92ouNVEFoHOJhxr
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: B03721ECCAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79170-lists,linux-fsdevel=lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,ZenIV.linux.org.uk,vger.kernel.org,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org,suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.860];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Track metadata bhs for an inode in fs-private part of the inode. We need
the tracking only for nojournal mode so this is somewhat wasteful. We
can relatively easily make the mapping_metadata_bhs struct dynamically
allocated similarly to how we treat jbd2_inode but let's leave that for
ext4 specific series once the dust settles a bit.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h    | 4 +++-
 fs/ext4/file.c    | 1 +
 fs/ext4/inode.c   | 2 +-
 fs/ext4/namei.c   | 2 ++
 fs/ext4/super.c   | 6 ++++++
 fs/ext4/symlink.c | 3 +++
 6 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 293f698b7042..a829e5da67af 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1121,6 +1121,7 @@ struct ext4_inode_info {
 	struct rw_semaphore i_data_sem;
 	struct inode vfs_inode;
 	struct jbd2_inode *jinode;
+	struct mapping_metadata_bhs i_metadata_bhs;
 
 	/*
 	 * File creation time. Its function is same as that of
@@ -3203,8 +3204,9 @@ extern void ext4_mark_group_bitmap_corrupted(struct super_block *sb,
 					     unsigned int flags);
 extern unsigned int ext4_num_base_meta_blocks(struct super_block *sb,
 					      ext4_group_t block_group);
-extern void print_daily_error_info(struct timer_list *t);
+struct mapping_metadata_bhs *ext4_get_metadata_bhs(struct inode *inode);
 
+extern void print_daily_error_info(struct timer_list *t);
 extern __printf(7, 8)
 void __ext4_error(struct super_block *, const char *, unsigned int, bool,
 		  int, __u64, const char *, ...);
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index f1dc5ce791a7..3d433f50524b 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -987,5 +987,6 @@ const struct inode_operations ext4_file_inode_operations = {
 	.fiemap		= ext4_fiemap,
 	.fileattr_get	= ext4_fileattr_get,
 	.fileattr_set	= ext4_fileattr_set,
+	.get_metadata_bhs = ext4_get_metadata_bhs,
 };
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 011cb2eb16a2..eead6c5c2366 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3436,7 +3436,7 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
 	}
 
 	/* Any metadata buffers to write? */
-	if (mmb_has_buffers(&inode->i_mapping->i_metadata_bhs))
+	if (mmb_has_buffers(&EXT4_I(inode)->i_metadata_bhs))
 		return true;
 	return inode_state_read_once(inode) & I_DIRTY_DATASYNC;
 }
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index c4b5e252af0e..4d2cae140b71 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -4228,6 +4228,7 @@ const struct inode_operations ext4_dir_inode_operations = {
 	.fiemap         = ext4_fiemap,
 	.fileattr_get	= ext4_fileattr_get,
 	.fileattr_set	= ext4_fileattr_set,
+	.get_metadata_bhs = ext4_get_metadata_bhs,
 };
 
 const struct inode_operations ext4_special_inode_operations = {
@@ -4236,4 +4237,5 @@ const struct inode_operations ext4_special_inode_operations = {
 	.listxattr	= ext4_listxattr,
 	.get_inode_acl	= ext4_get_acl,
 	.set_acl	= ext4_set_acl,
+	.get_metadata_bhs = ext4_get_metadata_bhs,
 };
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ea827b0ecc8d..4b9eb86b03e2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1428,6 +1428,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
 	ext4_fc_init_inode(&ei->vfs_inode);
 	spin_lock_init(&ei->i_fc_lock);
+	mmb_init(&ei->i_metadata_bhs);
 	return &ei->vfs_inode;
 }
 
@@ -1521,6 +1522,11 @@ static void destroy_inodecache(void)
 	kmem_cache_destroy(ext4_inode_cachep);
 }
 
+struct mapping_metadata_bhs *ext4_get_metadata_bhs(struct inode *inode)
+{
+	return &EXT4_I(inode)->i_metadata_bhs;
+}
+
 void ext4_clear_inode(struct inode *inode)
 {
 	ext4_fc_del(inode);
diff --git a/fs/ext4/symlink.c b/fs/ext4/symlink.c
index 645240cc0229..53ec8daf4cae 100644
--- a/fs/ext4/symlink.c
+++ b/fs/ext4/symlink.c
@@ -119,6 +119,7 @@ const struct inode_operations ext4_encrypted_symlink_inode_operations = {
 	.setattr	= ext4_setattr,
 	.getattr	= ext4_encrypted_symlink_getattr,
 	.listxattr	= ext4_listxattr,
+	.get_metadata_bhs = ext4_get_metadata_bhs,
 };
 
 const struct inode_operations ext4_symlink_inode_operations = {
@@ -126,6 +127,7 @@ const struct inode_operations ext4_symlink_inode_operations = {
 	.setattr	= ext4_setattr,
 	.getattr	= ext4_getattr,
 	.listxattr	= ext4_listxattr,
+	.get_metadata_bhs = ext4_get_metadata_bhs,
 };
 
 const struct inode_operations ext4_fast_symlink_inode_operations = {
@@ -133,4 +135,5 @@ const struct inode_operations ext4_fast_symlink_inode_operations = {
 	.setattr	= ext4_setattr,
 	.getattr	= ext4_getattr,
 	.listxattr	= ext4_listxattr,
+	.get_metadata_bhs = ext4_get_metadata_bhs,
 };
-- 
2.51.0



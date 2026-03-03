Return-Path: <linux-fsdevel+bounces-79163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIEjJsW6pmkPTQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:41:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F7F1ECD7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 307C53069AC6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C062139D6C9;
	Tue,  3 Mar 2026 10:35:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D890C39D6CA
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534157; cv=none; b=pLyogjbxNeKYL05n44ymY3PT+z4ivlyOOpyl9j4UMMuRB4LXVz4N6egBGvuG1EkFfCwiXfz0M2yIHQ6tvdPRHQbzhEoJIL5oxOIkp/RxnBbOznkSjiaBAac8J2LJfDDuhSbrZX5i4WHAtTyhKsD5ayb85ysMK50puv6Db2tC/Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534157; c=relaxed/simple;
	bh=B8ZzDQ9fbRZLJZF8E2c6y+7UuxwL5O2XEv5hv9QeeYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZial+ZY6jXqVAE4wTQFTOy6GnqFtlIWo/Nig1mmIp3Oi+7PU7R1ps1XRaDHiNoR7kcMb0RNqM4U3QI9eQ7gY/kBAB21FH8/Lb9r8rNVAXkGEvAlb7ceG3jB6AL01KrgBudWGFS827LzMXMG8FJjFxtOzXgOq7EHtoO+HbbmNv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4281F3F935;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 261373EA6F;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F9RKCUW5pmmAFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D8E20A0B60; Tue,  3 Mar 2026 11:34:40 +0100 (CET)
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
Subject: [PATCH 18/32] fs: Provide operation for fetching mapping_metadata_bhs
Date: Tue,  3 Mar 2026 11:34:07 +0100
Message-ID: <20260303103406.4355-50-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4099; i=jack@suse.cz; h=from:subject; bh=B8ZzDQ9fbRZLJZF8E2c6y+7UuxwL5O2XEv5hv9QeeYs=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpprkt8oRjrNW6Mstokzx9e88TZxMQExL4YrLsU 0p7NbpL1lKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaa5LQAKCRCcnaoHP2RA 2fpiCAC/Cyr1/g1WcjrqVOY1eyJVU9N21shLEK5PL6oHJcDd4EbB2dbTyICrINur7AQIJbVbhKL 6uvymE/zjF+cDiCNrx2rRy7zz+TnSWSfzTvo+430/I+nkN/5UsRKGRflBFEPItTcE9188XUlC3U fv9qefNBvocLUJJz4Dq+DR/UESRjZLCg1dT2QSmiQLhwvW86xwMPw27YDk4t/TIxve2l7z5DT57 f2LVhAbHvrsuPIfToabtCEJH6AbZI4ArlLrrr8ZZ82Ed5bDOPBgZhvhikL89CkVcdkiW8RlfQxu JCh0fP1EjfPvT0hO66Z/NArYeRSbtxuJyD3ZVSj6A57R+ZP0
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 38F7F1ECD7D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79163-lists,linux-fsdevel=lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,ZenIV.linux.org.uk,vger.kernel.org,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org,suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.858];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

When we move mapping_metadata_bhs to fs-private part of an inode the
generic code will need a way to get to this struct from general struct
inode. Add inode operation for this similarly to operation for grabbing
offset_ctx.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/buffer.c                 | 35 +++++++++++++++++++++++++----------
 include/linux/buffer_head.h |  1 +
 include/linux/fs.h          |  1 +
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index d39ae6581c26..d7a1d72302da 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -492,6 +492,20 @@ EXPORT_SYMBOL(mark_buffer_async_write);
  * b_inode back.
  */
 
+void mmb_init(struct mapping_metadata_bhs *mmb)
+{
+	spin_lock_init(&mmb->lock);
+	INIT_LIST_HEAD(&mmb->list);
+}
+EXPORT_SYMBOL(mmb_init);
+
+static struct mapping_metadata_bhs *inode_get_metadata_bhs(struct inode *inode)
+{
+	if (inode->i_op->get_metadata_bhs)
+		return inode->i_op->get_metadata_bhs(inode);
+	return &inode->i_mapping->i_metadata_bhs;
+}
+
 static void __remove_assoc_queue(struct mapping_metadata_bhs *mmb,
 			         struct buffer_head *bh)
 {
@@ -518,7 +532,7 @@ static void remove_assoc_queue(struct buffer_head *bh)
 		rcu_read_lock();
 		mapping = READ_ONCE(bh->b_assoc_map);
 		if (mapping) {
-			mmb = &mapping->i_metadata_bhs;
+			mmb = inode_get_metadata_bhs(mapping->host);
 			spin_lock(&mmb->lock);
 			if (bh->b_assoc_map == mapping)
 				__remove_assoc_queue(mmb, bh);
@@ -557,7 +571,8 @@ EXPORT_SYMBOL_GPL(inode_has_buffers);
  */
 int sync_mapping_buffers(struct address_space *mapping)
 {
-	struct mapping_metadata_bhs *mmb = &mapping->i_metadata_bhs;
+	struct mapping_metadata_bhs *mmb =
+					inode_get_metadata_bhs(mapping->host);
 	struct buffer_head *bh;
 	int err = 0;
 	struct blk_plug plug;
@@ -721,15 +736,15 @@ void write_boundary_block(struct block_device *bdev,
 
 void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
 {
-	struct address_space *mapping = inode->i_mapping;
-
 	mark_buffer_dirty(bh);
 	if (!bh->b_assoc_map) {
-		spin_lock(&mapping->i_metadata_bhs.lock);
-		list_move_tail(&bh->b_assoc_buffers,
-				&mapping->i_metadata_bhs.list);
-		bh->b_assoc_map = mapping;
-		spin_unlock(&mapping->i_metadata_bhs.lock);
+		struct mapping_metadata_bhs *mmb;
+
+		mmb = inode_get_metadata_bhs(inode);
+		spin_lock(&mmb->lock);
+		list_move_tail(&bh->b_assoc_buffers, &mmb->list);
+		bh->b_assoc_map = inode->i_mapping;
+		spin_unlock(&mmb->lock);
 	}
 }
 EXPORT_SYMBOL(mark_buffer_dirty_inode);
@@ -806,7 +821,7 @@ EXPORT_SYMBOL(block_dirty_folio);
 void invalidate_inode_buffers(struct inode *inode)
 {
 	if (inode_has_buffers(inode)) {
-		struct mapping_metadata_bhs *mmb = &inode->i_data.i_metadata_bhs;
+		struct mapping_metadata_bhs *mmb = inode_get_metadata_bhs(inode);
 
 		spin_lock(&mmb->lock);
 		while (!list_empty(&mmb->list))
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 631bf971efc0..623ee66d41a8 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -515,6 +515,7 @@ bool block_dirty_folio(struct address_space *mapping, struct folio *folio);
 
 void buffer_init(void);
 bool try_to_free_buffers(struct folio *folio);
+void mmb_init(struct mapping_metadata_bhs *mmb);
 int inode_has_buffers(struct inode *inode);
 void invalidate_inode_buffers(struct inode *inode);
 int sync_mapping_buffers(struct address_space *mapping);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 64771a55adc5..b4d9be1fefa4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2046,6 +2046,7 @@ struct inode_operations {
 			    struct dentry *dentry, struct file_kattr *fa);
 	int (*fileattr_get)(struct dentry *dentry, struct file_kattr *fa);
 	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
+	struct mapping_metadata_bhs *(*get_metadata_bhs)(struct inode *inode);
 } ____cacheline_aligned;
 
 /* Did the driver provide valid mmap hook configuration? */
-- 
2.51.0



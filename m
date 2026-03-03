Return-Path: <linux-fsdevel+bounces-79159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPCjOPS6pmk7TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:41:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 485C81ECDA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 412313055102
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DDA39D6CD;
	Tue,  3 Mar 2026 10:35:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA07382383
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534145; cv=none; b=CeRgMHI5BohKG24fTXU4mbSYlKjUhSTodTVYxYAvPpGE3cA8a/meNRvGzMLP6ewHNjY74jvNilvWX8UT9aNhCY+Of/nvNASCAZksDW/mzCob2A/bvNfmoI164HlmpHGSwVbT1x4e5ugDnR+v3DaKITjJ3WjDlbV8tbEzzB/UvIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534145; c=relaxed/simple;
	bh=PsrYbjQYy+JKPN4ylXgRqTH/Kampp8KKAcnDVbtwug4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuRhIWabtLDxSHX4n/jD8ArRjjngamlVsA87/Jhh0T7HKLW1ZAmlnOfnhwMK/dxpbnMGvr52VCPpzq8uFhFtBptz6L3Ku1qtNFoYCYS61s3QDjbUAkfT0rV4iJ4Nnytc4LyCV2TlGSuOPXHXVmcEEd//u45lg4pUQJ3DRR71ipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 36A103F931;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29D2F3EA70;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6DIxCkW5pmmCFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D0F7DA0B57; Tue,  3 Mar 2026 11:34:40 +0100 (CET)
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
Subject: [PATCH 17/32] fs: Move metadata bhs tracking to a separate struct
Date: Tue,  3 Mar 2026 11:34:06 +0100
Message-ID: <20260303103406.4355-49-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11918; i=jack@suse.cz; h=from:subject; bh=PsrYbjQYy+JKPN4ylXgRqTH/Kampp8KKAcnDVbtwug4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpprksE5Lx4epWwB/e0YNwgGWaQ2b2qYcKQL6e0 TTshDb9OKaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaa5LAAKCRCcnaoHP2RA 2SALB/4iCUL7ofPmwRscjLvD6emQ+2yb5k2ZJg5EBrxKR9QVhQhpNXSS0EDgwZAYB7lKjmISlbM 7mlsLXf0E2jlET13UShCUd/rsjArlSFpsgXv/de/0fo9faADMhxYOVyWRrpd9OqwfsM22Pwzxjp bbgsh0Ru3198i+V0pgYb+scgS+3+A7Lh89nU/xdomdL0Mbw3mYEkD3ing6QS/X+0QlsJKg2xlGM GFjb3qPRCQJHfvamjryw2kTGcaWCGqrIZcvRvKHU71QUxOtJ2+G+98r1VOxL0Y8XB2DEP3xbKCI 4NDsTXrL/0dA9Q+1kaRz6AX47mu+X2KUtmp/0tCgf07LGS6I
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
X-Rspamd-Queue-Id: 485C81ECDA3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79159-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.848];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Instead of tracking metadata bhs for a mapping using i_private_list and
i_private_lock we create a dedicated mapping_metadata_bhs struct for it.
So far this struct is embedded in address_space but that will be
switched for per-fs private inode parts later in the series. This also
changes the locking from bdev mapping's i_private_lock to lock embedded
in mapping_metadata_bhs to untangle the i_private_lock locking for
maintaining lists of metadata bhs and the locking for looking up /
reclaiming bdev's buffer heads. The locking in remove_assoc_map()
gets more complex due to this but overall this looks like a reasonable
tradeoff.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/buffer.c        | 138 +++++++++++++++++++++------------------------
 fs/inode.c         |   2 +
 include/linux/fs.h |   7 +++
 3 files changed, 74 insertions(+), 73 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 18012afb8289..d39ae6581c26 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -469,30 +469,13 @@ EXPORT_SYMBOL(mark_buffer_async_write);
  *
  * The functions mark_buffer_dirty_inode(), fsync_inode_buffers(),
  * inode_has_buffers() and invalidate_inode_buffers() are provided for the
- * management of a list of dependent buffers at ->i_mapping->i_private_list.
- *
- * Locking is a little subtle: try_to_free_buffers() will remove buffers
- * from their controlling inode's queue when they are being freed.  But
- * try_to_free_buffers() will be operating against the *blockdev* mapping
- * at the time, not against the S_ISREG file which depends on those buffers.
- * So the locking for i_private_list is via the i_private_lock in the address_space
- * which backs the buffers.  Which is different from the address_space 
- * against which the buffers are listed.  So for a particular address_space,
- * mapping->i_private_lock does *not* protect mapping->i_private_list!  In fact,
- * mapping->i_private_list will always be protected by the backing blockdev's
- * ->i_private_lock.
- *
- * Which introduces a requirement: all buffers on an address_space's
- * ->i_private_list must be from the same address_space: the blockdev's.
- *
- * address_spaces which do not place buffers at ->i_private_list via these
- * utility functions are free to use i_private_lock and i_private_list for
- * whatever they want.  The only requirement is that list_empty(i_private_list)
- * be true at clear_inode() time.
- *
- * FIXME: clear_inode should not call invalidate_inode_buffers().  The
- * filesystems should do that.  invalidate_inode_buffers() should just go
- * BUG_ON(!list_empty).
+ * management of a list of dependent buffers in mapping_metadata_bhs struct.
+ *
+ * The locking is a little subtle: The list of buffer heads is protected by
+ * the lock in mapping_metadata_bhs so functions coming from bdev mapping
+ * (such as try_to_free_buffers()) need to safely get to mapping_metadata_bhs
+ * using RCU, grab the lock, verify we didn't race with somebody detaching the
+ * bh / moving it to different inode and only then proceeding.
  *
  * FIXME: mark_buffer_dirty_inode() is a data-plane operation.  It should
  * take an address_space, not an inode.  And it should be called
@@ -509,19 +492,45 @@ EXPORT_SYMBOL(mark_buffer_async_write);
  * b_inode back.
  */
 
-/*
- * The buffer's backing address_space's i_private_lock must be held
- */
-static void __remove_assoc_queue(struct buffer_head *bh)
+static void __remove_assoc_queue(struct mapping_metadata_bhs *mmb,
+			         struct buffer_head *bh)
 {
+	lockdep_assert_held(&mmb->lock);
 	list_del_init(&bh->b_assoc_buffers);
 	WARN_ON(!bh->b_assoc_map);
 	bh->b_assoc_map = NULL;
 }
 
+static void remove_assoc_queue(struct buffer_head *bh)
+{
+	struct address_space *mapping;
+	struct mapping_metadata_bhs *mmb;
+
+	/*
+	 * The locking dance is ugly here. We need to acquire lock
+	 * protecting metadata bh list while possibly racing with bh
+	 * being removed from the list or moved to a different one.  We
+	 * use RCU to pin mapping_metadata_bhs in memory to
+	 * opportunistically acquire the lock and then recheck the bh
+	 * didn't move under us.
+	 */
+	while (bh->b_assoc_map) {
+		rcu_read_lock();
+		mapping = READ_ONCE(bh->b_assoc_map);
+		if (mapping) {
+			mmb = &mapping->i_metadata_bhs;
+			spin_lock(&mmb->lock);
+			if (bh->b_assoc_map == mapping)
+				__remove_assoc_queue(mmb, bh);
+			spin_unlock(&mmb->lock);
+		}
+		rcu_read_unlock();
+	}
+}
+
 int inode_has_buffers(struct inode *inode)
 {
-	return !list_empty(&inode->i_data.i_private_list);
+	return !list_empty(&inode->i_data.i_metadata_bhs.list);
 }
 EXPORT_SYMBOL_GPL(inode_has_buffers);
 
@@ -529,7 +538,7 @@ EXPORT_SYMBOL_GPL(inode_has_buffers);
  * sync_mapping_buffers - write out & wait upon a mapping's "associated" buffers
  * @mapping: the mapping which wants those buffers written
  *
- * Starts I/O against the buffers at mapping->i_private_list, and waits upon
+ * Starts I/O against the buffers at mapping->i_metadata_bhs and waits upon
  * that I/O. Basically, this is a convenience function for fsync().  @mapping
  * is a file or directory which needs those buffers to be written for a
  * successful fsync().
@@ -548,23 +557,22 @@ EXPORT_SYMBOL_GPL(inode_has_buffers);
  */
 int sync_mapping_buffers(struct address_space *mapping)
 {
-	struct address_space *buffer_mapping =
-				mapping->host->i_sb->s_bdev->bd_mapping;
+	struct mapping_metadata_bhs *mmb = &mapping->i_metadata_bhs;
 	struct buffer_head *bh;
 	int err = 0;
 	struct blk_plug plug;
 	LIST_HEAD(tmp);
 
-	if (list_empty(&mapping->i_private_list))
+	if (list_empty(&mmb->list))
 		return 0;
 
 	blk_start_plug(&plug);
 
-	spin_lock(&buffer_mapping->i_private_lock);
-	while (!list_empty(&mapping->i_private_list)) {
-		bh = BH_ENTRY(list->next);
+	spin_lock(&mmb->lock);
+	while (!list_empty(&mmb->list)) {
+		bh = BH_ENTRY(mmb->list.next);
 		WARN_ON_ONCE(bh->b_assoc_map != mapping);
-		__remove_assoc_queue(bh);
+		__remove_assoc_queue(mmb, bh);
 		/* Avoid race with mark_buffer_dirty_inode() which does
 		 * a lockless check and we rely on seeing the dirty bit */
 		smp_mb();
@@ -573,7 +581,7 @@ int sync_mapping_buffers(struct address_space *mapping)
 			bh->b_assoc_map = mapping;
 			if (buffer_dirty(bh)) {
 				get_bh(bh);
-				spin_unlock(&buffer_mapping->i_private_lock);
+				spin_unlock(&mmb->lock);
 				/*
 				 * Ensure any pending I/O completes so that
 				 * write_dirty_buffer() actually writes the
@@ -590,35 +598,34 @@ int sync_mapping_buffers(struct address_space *mapping)
 				 * through sync_buffer().
 				 */
 				brelse(bh);
-				spin_lock(&buffer_mapping->i_private_lock);
+				spin_lock(&mmb->lock);
 			}
 		}
 	}
 
-	spin_unlock(&buffer_mapping->i_private_lock);
+	spin_unlock(&mmb->lock);
 	blk_finish_plug(&plug);
-	spin_lock(&buffer_mapping->i_private_lock);
+	spin_lock(&mmb->lock);
 
 	while (!list_empty(&tmp)) {
 		bh = BH_ENTRY(tmp.prev);
 		get_bh(bh);
-		__remove_assoc_queue(bh);
+		__remove_assoc_queue(mmb, bh);
 		/* Avoid race with mark_buffer_dirty_inode() which does
 		 * a lockless check and we rely on seeing the dirty bit */
 		smp_mb();
 		if (buffer_dirty(bh)) {
-			list_add(&bh->b_assoc_buffers,
-				 &mapping->i_private_list);
+			list_add(&bh->b_assoc_buffers, &mmb->list);
 			bh->b_assoc_map = mapping;
 		}
-		spin_unlock(&buffer_mapping->i_private_lock);
+		spin_unlock(&mmb->lock);
 		wait_on_buffer(bh);
 		if (!buffer_uptodate(bh))
 			err = -EIO;
 		brelse(bh);
-		spin_lock(&buffer_mapping->i_private_lock);
+		spin_lock(&mmb->lock);
 	}
-	spin_unlock(&buffer_mapping->i_private_lock);
+	spin_unlock(&mmb->lock);
 	return err;
 }
 EXPORT_SYMBOL(sync_mapping_buffers);
@@ -715,15 +722,14 @@ void write_boundary_block(struct block_device *bdev,
 void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
 {
 	struct address_space *mapping = inode->i_mapping;
-	struct address_space *buffer_mapping = bh->b_folio->mapping;
 
 	mark_buffer_dirty(bh);
 	if (!bh->b_assoc_map) {
-		spin_lock(&buffer_mapping->i_private_lock);
+		spin_lock(&mapping->i_metadata_bhs.lock);
 		list_move_tail(&bh->b_assoc_buffers,
-				&mapping->i_private_list);
+				&mapping->i_metadata_bhs.list);
 		bh->b_assoc_map = mapping;
-		spin_unlock(&buffer_mapping->i_private_lock);
+		spin_unlock(&mapping->i_metadata_bhs.lock);
 	}
 }
 EXPORT_SYMBOL(mark_buffer_dirty_inode);
@@ -796,22 +802,16 @@ EXPORT_SYMBOL(block_dirty_folio);
  * Invalidate any and all dirty buffers on a given inode.  We are
  * probably unmounting the fs, but that doesn't mean we have already
  * done a sync().  Just drop the buffers from the inode list.
- *
- * NOTE: we take the inode's blockdev's mapping's i_private_lock.  Which
- * assumes that all the buffers are against the blockdev.
  */
 void invalidate_inode_buffers(struct inode *inode)
 {
 	if (inode_has_buffers(inode)) {
-		struct address_space *mapping = &inode->i_data;
-		struct list_head *list = &mapping->i_private_list;
-		struct address_space *buffer_mapping =
-				mapping->host->i_sb->s_bdev->bd_mapping;
-
-		spin_lock(&buffer_mapping->i_private_lock);
-		while (!list_empty(list))
-			__remove_assoc_queue(BH_ENTRY(list->next));
-		spin_unlock(&buffer_mapping->i_private_lock);
+		struct mapping_metadata_bhs *mmb = &inode->i_data.i_metadata_bhs;
+
+		spin_lock(&mmb->lock);
+		while (!list_empty(&mmb->list))
+			__remove_assoc_queue(mmb, BH_ENTRY(mmb->list.next));
+		spin_unlock(&mmb->lock);
 	}
 }
 EXPORT_SYMBOL(invalidate_inode_buffers);
@@ -1155,14 +1155,7 @@ EXPORT_SYMBOL(__brelse);
 void __bforget(struct buffer_head *bh)
 {
 	clear_buffer_dirty(bh);
-	if (bh->b_assoc_map) {
-		struct address_space *buffer_mapping = bh->b_folio->mapping;
-
-		spin_lock(&buffer_mapping->i_private_lock);
-		list_del_init(&bh->b_assoc_buffers);
-		bh->b_assoc_map = NULL;
-		spin_unlock(&buffer_mapping->i_private_lock);
-	}
+	remove_assoc_queue(bh);
 	__brelse(bh);
 }
 EXPORT_SYMBOL(__bforget);
@@ -2810,8 +2803,7 @@ drop_buffers(struct folio *folio, struct buffer_head **buffers_to_free)
 	do {
 		struct buffer_head *next = bh->b_this_page;
 
-		if (bh->b_assoc_map)
-			__remove_assoc_queue(bh);
+		remove_assoc_queue(bh);
 		bh = next;
 	} while (bh != head);
 	*buffers_to_free = head;
diff --git a/fs/inode.c b/fs/inode.c
index d5774e627a9c..393f586d050a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -483,6 +483,8 @@ static void __address_space_init_once(struct address_space *mapping)
 	init_rwsem(&mapping->i_mmap_rwsem);
 	INIT_LIST_HEAD(&mapping->i_private_list);
 	spin_lock_init(&mapping->i_private_lock);
+	spin_lock_init(&mapping->i_metadata_bhs.lock);
+	INIT_LIST_HEAD(&mapping->i_metadata_bhs.list);
 	mapping->i_mmap = RB_ROOT_CACHED;
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 10b96eb5391d..64771a55adc5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -445,6 +445,12 @@ struct address_space_operations {
 
 extern const struct address_space_operations empty_aops;
 
+/* Structure for tracking metadata buffer heads associated with the mapping */
+struct mapping_metadata_bhs {
+	spinlock_t lock;	/* Lock protecting bh list */
+	struct list_head list;	/* The list of bhs (b_assoc_buffers) */
+};
+
 /**
  * struct address_space - Contents of a cacheable, mappable object.
  * @host: Owner, either the inode or the block_device.
@@ -484,6 +490,7 @@ struct address_space {
 	errseq_t		wb_err;
 	spinlock_t		i_private_lock;
 	struct list_head	i_private_list;
+	struct mapping_metadata_bhs i_metadata_bhs;
 	struct rw_semaphore	i_mmap_rwsem;
 } __attribute__((aligned(sizeof(long)))) __randomize_layout;
 	/*
-- 
2.51.0



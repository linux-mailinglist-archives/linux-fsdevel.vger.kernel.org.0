Return-Path: <linux-fsdevel+bounces-79154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGrNMpy6pmk7TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:40:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ED41ECD41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B9E030E6FFD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8A925DB12;
	Tue,  3 Mar 2026 10:35:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89E839D6CB
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534131; cv=none; b=m0MtfwiTaFKjIKMgCor+JnZaGIsJ8Dw84G1mvitgpNBY1GXvwX3DnwKILitXc8euudUmnUyNCyEbM5SKpKm1uZOn+JGpodJy6342ijlIZlfXYaQoB7m/waKIObQ+s4EFfGtRm9OmXZQOxy29UA5rZj8MZDM2U5skN04gVYD7Gew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534131; c=relaxed/simple;
	bh=h0e6MIg5l952kKWgsDkEqfN2Mt10ryaKvGQbfI027K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TY9q5FZTzrhsIgx7rKIXkJ7XYzZT5mwmmQsFiRKAW0Og5txHWSSCftUJbmXoKXFCY1OFGLenaGtXWxDb6buIMtwCQNtvGjyaFtH85hdp9anVGAYxr1GOOKGpC0fdEn+X9BLEGBuKm8LAbPicCqjOasYEO/DfBe1GpkdZhVZTRgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 49C2A5BE26;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E0493EA6C;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ixYeD0W5pmmLFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 068E6A0B73; Tue,  3 Mar 2026 11:34:41 +0100 (CET)
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
Subject: [PATCH 22/32] fs: Switch inode_has_buffers() to take mapping_metadata_bhs
Date: Tue,  3 Mar 2026 11:34:11 +0100
Message-ID: <20260303103406.4355-54-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3341; i=jack@suse.cz; h=from:subject; bh=h0e6MIg5l952kKWgsDkEqfN2Mt10ryaKvGQbfI027K0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpprkwiZ1a8GXqSyp+bg1UghDh217roqsu+Pqts 3l7xohlZBqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaa5MAAKCRCcnaoHP2RA 2VsCCACymLlBzpHgLUzLMLNGiTzCzJYKtadD8BzeD3oIfJpU55WORZv8s9WWKnJx0DuugeHHYaJ /dABsPjGb7ZAJqvnvJD7vTxnH4Ripsn5ClgKEzseSezvzeoYc9f4NK1wcxE8xOaqC3p+GixOn2w 3IX5XdJqLGfPwlrOlmS2qYNCfgFGg7GWJqyaQGY5/dpiO0ypa5pUcBUryqcmYIZNBl9t6MceMcu wEHO808n6FSVwuQHghWYooFwiF8jYx6uFn2AFYTGpVofVdn+MVLqXE0jQoU+bZRVsOP8rAexQrR f+VIdfVyuHdnurySWXk+Kfo33m+PVmSNN6koXlwWEdP3RwC1
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
X-Rspamd-Queue-Id: 32ED41ECD41
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
	TAGGED_FROM(0.00)[bounces-79154-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.863];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

inode_has_buffers() is also used internally and it is trivial so it's
pointless to grab mapping_metadata_bhs for each invocation. Just let
that function take mapping_metadata_bhs struct instead and rename the
function to mmb_has_buffers().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/buffer.c                 | 14 +++++++-------
 fs/ext4/inode.c             |  2 +-
 include/linux/buffer_head.h |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index d7a1d72302da..096a8d9e3280 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -468,7 +468,7 @@ EXPORT_SYMBOL(mark_buffer_async_write);
  * written back and waited upon before fsync() returns.
  *
  * The functions mark_buffer_dirty_inode(), fsync_inode_buffers(),
- * inode_has_buffers() and invalidate_inode_buffers() are provided for the
+ * mmb_has_buffers() and invalidate_inode_buffers() are provided for the
  * management of a list of dependent buffers in mapping_metadata_bhs struct.
  *
  * The locking is a little subtle: The list of buffer heads is protected by
@@ -542,11 +542,11 @@ static void remove_assoc_queue(struct buffer_head *bh)
 	}
 }
 
-int inode_has_buffers(struct inode *inode)
+bool mmb_has_buffers(struct mapping_metadata_bhs *mmb)
 {
-	return !list_empty(&inode->i_data.i_metadata_bhs.list);
+	return !list_empty(&mmb->list);
 }
-EXPORT_SYMBOL_GPL(inode_has_buffers);
+EXPORT_SYMBOL_GPL(mmb_has_buffers);
 
 /**
  * sync_mapping_buffers - write out & wait upon a mapping's "associated" buffers
@@ -578,7 +578,7 @@ int sync_mapping_buffers(struct address_space *mapping)
 	struct blk_plug plug;
 	LIST_HEAD(tmp);
 
-	if (list_empty(&mmb->list))
+	if (!mmb_has_buffers(mmb))
 		return 0;
 
 	blk_start_plug(&plug);
@@ -820,9 +820,9 @@ EXPORT_SYMBOL(block_dirty_folio);
  */
 void invalidate_inode_buffers(struct inode *inode)
 {
-	if (inode_has_buffers(inode)) {
-		struct mapping_metadata_bhs *mmb = inode_get_metadata_bhs(inode);
+	struct mapping_metadata_bhs *mmb = inode_get_metadata_bhs(inode);
 
+	if (mmb_has_buffers(mmb)) {
 		spin_lock(&mmb->lock);
 		while (!list_empty(&mmb->list))
 			__remove_assoc_queue(mmb, BH_ENTRY(mmb->list.next));
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 6f892abef003..011cb2eb16a2 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3436,7 +3436,7 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
 	}
 
 	/* Any metadata buffers to write? */
-	if (inode_has_buffers(inode))
+	if (mmb_has_buffers(&inode->i_mapping->i_metadata_bhs))
 		return true;
 	return inode_state_read_once(inode) & I_DIRTY_DATASYNC;
 }
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 623ee66d41a8..ebbd73c45e63 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -516,7 +516,7 @@ bool block_dirty_folio(struct address_space *mapping, struct folio *folio);
 void buffer_init(void);
 bool try_to_free_buffers(struct folio *folio);
 void mmb_init(struct mapping_metadata_bhs *mmb);
-int inode_has_buffers(struct inode *inode);
+bool mmb_has_buffers(struct mapping_metadata_bhs *mmb);
 void invalidate_inode_buffers(struct inode *inode);
 int sync_mapping_buffers(struct address_space *mapping);
 void invalidate_bh_lrus(void);
-- 
2.51.0



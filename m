Return-Path: <linux-fsdevel+bounces-79161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBnfDvi5pmn2TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:37:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A81891ECC0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 960563097231
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E444B386C2C;
	Tue,  3 Mar 2026 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CyzlAe4L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DvK+DTiT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CyzlAe4L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DvK+DTiT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126AB39B950
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534151; cv=none; b=ixT7aBTF3xlMqTnvP2YelyUPmE2qnLCHmfXg8bjt+mf3mlu7GpOJcbzTY+D7XpmDmi63y6MTbrvw0EKBEVq/3rAxmj2rVBJ3pLMb/ufLygPrkrK1hvlJzPUicY8ecCFctKJHiDRt3EXfHVDncDNqQlv3H2r96z4vPHg5HZSHB9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534151; c=relaxed/simple;
	bh=iAQYf1Qy8SGxN1+aEnxN/hmRSnVqswowuoNdYM87ou8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1PGNP/MEIQUO0Fm2nl3tsLEb8Xa5ZwkLMRZ/UlhU2+ymUaI2E438cQurdkgb03OOVmsFAWkffUTPDUNyYZEG9SDT5oyD1hBfNzFwRiJwbrOtYZLWV4NFvnis27pohqaojXEzwtp0GVO2NKJq5FO1qiFaYrAnH1dzhYIpFaYZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CyzlAe4L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DvK+DTiT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CyzlAe4L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DvK+DTiT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F9D23F929;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayutdjATkfIJsyi9w7bhVOmHaFZZfPEvqi93VrREg+I=;
	b=CyzlAe4L3HqgIZiyZrYlmfOTNprQP6+SvArWyc9E5oQFYf012FxA3BtI1HbO45NcH/L2ti
	d2/+6Kunl7+ts64jGrCfrGhzzoI1bWSmGAMdgak8DlIiv9YmTX6kd7Y3ymHAHpfuNzBJs5
	OPoacYYPQnXACdBGf/mI1J14tfYVrO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayutdjATkfIJsyi9w7bhVOmHaFZZfPEvqi93VrREg+I=;
	b=DvK+DTiTmQkSAKFjj2D2jqh/HRRXgvMyfCseBN8se/zRRqAnWTsBztdOnq2FD/y1CtToCZ
	9fPpL595ZYW++fAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayutdjATkfIJsyi9w7bhVOmHaFZZfPEvqi93VrREg+I=;
	b=CyzlAe4L3HqgIZiyZrYlmfOTNprQP6+SvArWyc9E5oQFYf012FxA3BtI1HbO45NcH/L2ti
	d2/+6Kunl7+ts64jGrCfrGhzzoI1bWSmGAMdgak8DlIiv9YmTX6kd7Y3ymHAHpfuNzBJs5
	OPoacYYPQnXACdBGf/mI1J14tfYVrO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayutdjATkfIJsyi9w7bhVOmHaFZZfPEvqi93VrREg+I=;
	b=DvK+DTiTmQkSAKFjj2D2jqh/HRRXgvMyfCseBN8se/zRRqAnWTsBztdOnq2FD/y1CtToCZ
	9fPpL595ZYW++fAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22E653EA69;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8yqECEW5pml9FQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C8F9DA0AE1; Tue,  3 Mar 2026 11:34:40 +0100 (CET)
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
Subject: [PATCH 16/32] fs: Fold fsync_buffers_list() into sync_mapping_buffers()
Date: Tue,  3 Mar 2026 11:34:05 +0100
Message-ID: <20260303103406.4355-48-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7504; i=jack@suse.cz; h=from:subject; bh=iAQYf1Qy8SGxN1+aEnxN/hmRSnVqswowuoNdYM87ou8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpprkret9/c1xpxPu/HVbqz9oF76wD6wt3S0VAk fZSs6HxtgCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaa5KwAKCRCcnaoHP2RA 2aDRB/9ONHR3CHXaC9Dt8EF2Alucrv+2KoC6QvP67hC5JUwzvTa04STNFTHTv7npgR30ioCCpK+ 7zu9PYgTPbCFxHvL/sswxIxHIFcUWDC30dN3vJ64bCztTB8UpfvcMKi4XlhX8oWbG4XXVDXyxb/ Y05ivmiBrVYouoa6YO1dSos2EL3Rx0cldyxvOaGh+78+gB6EX9EVOyTSrRECvHRNg+X044PWRbn TwWWZea+fqAt1U0FRMJP0o2FxOdEg+Rj+pl9QA9CO8A8eoI+bhK/MEnbkzZ+oklCkKxGYoTHEbf joYLTGBG6fqUxjxIJRqHZgbA+0IWj5gArfSKoTAX85VsJ1EW
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.30
X-Spam-Level: 
X-Rspamd-Queue-Id: A81891ECC0E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-79161-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ZenIV.linux.org.uk,vger.kernel.org,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org,suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

There's only single caller of fsync_buffers_list() so untangle the code
a bit by folding fsync_buffers_list() into sync_mapping_buffers(). Also
merge the comments and update them to reflect current state of code.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/buffer.c | 180 +++++++++++++++++++++++-----------------------------
 1 file changed, 80 insertions(+), 100 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 1c0e7c81a38b..18012afb8289 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -54,7 +54,6 @@
 
 #include "internal.h"
 
-static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
 static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 			  enum rw_hint hint, struct writeback_control *wbc);
 
@@ -531,22 +530,96 @@ EXPORT_SYMBOL_GPL(inode_has_buffers);
  * @mapping: the mapping which wants those buffers written
  *
  * Starts I/O against the buffers at mapping->i_private_list, and waits upon
- * that I/O.
+ * that I/O. Basically, this is a convenience function for fsync().  @mapping
+ * is a file or directory which needs those buffers to be written for a
+ * successful fsync().
  *
- * Basically, this is a convenience function for fsync().
- * @mapping is a file or directory which needs those buffers to be written for
- * a successful fsync().
+ * We have conflicting pressures: we want to make sure that all
+ * initially dirty buffers get waited on, but that any subsequently
+ * dirtied buffers don't.  After all, we don't want fsync to last
+ * forever if somebody is actively writing to the file.
+ *
+ * Do this in two main stages: first we copy dirty buffers to a
+ * temporary inode list, queueing the writes as we go. Then we clean
+ * up, waiting for those writes to complete. mark_buffer_dirty_inode()
+ * doesn't touch b_assoc_buffers list if b_assoc_map is not NULL so we
+ * are sure the buffer stays on our list until IO completes (at which point
+ * it can be reaped).
  */
 int sync_mapping_buffers(struct address_space *mapping)
 {
 	struct address_space *buffer_mapping =
 				mapping->host->i_sb->s_bdev->bd_mapping;
+	struct buffer_head *bh;
+	int err = 0;
+	struct blk_plug plug;
+	LIST_HEAD(tmp);
 
 	if (list_empty(&mapping->i_private_list))
 		return 0;
 
-	return fsync_buffers_list(&buffer_mapping->i_private_lock,
-					&mapping->i_private_list);
+	blk_start_plug(&plug);
+
+	spin_lock(&buffer_mapping->i_private_lock);
+	while (!list_empty(&mapping->i_private_list)) {
+		bh = BH_ENTRY(list->next);
+		WARN_ON_ONCE(bh->b_assoc_map != mapping);
+		__remove_assoc_queue(bh);
+		/* Avoid race with mark_buffer_dirty_inode() which does
+		 * a lockless check and we rely on seeing the dirty bit */
+		smp_mb();
+		if (buffer_dirty(bh) || buffer_locked(bh)) {
+			list_add(&bh->b_assoc_buffers, &tmp);
+			bh->b_assoc_map = mapping;
+			if (buffer_dirty(bh)) {
+				get_bh(bh);
+				spin_unlock(&buffer_mapping->i_private_lock);
+				/*
+				 * Ensure any pending I/O completes so that
+				 * write_dirty_buffer() actually writes the
+				 * current contents - it is a noop if I/O is
+				 * still in flight on potentially older
+				 * contents.
+				 */
+				write_dirty_buffer(bh, REQ_SYNC);
+
+				/*
+				 * Kick off IO for the previous mapping. Note
+				 * that we will not run the very last mapping,
+				 * wait_on_buffer() will do that for us
+				 * through sync_buffer().
+				 */
+				brelse(bh);
+				spin_lock(&buffer_mapping->i_private_lock);
+			}
+		}
+	}
+
+	spin_unlock(&buffer_mapping->i_private_lock);
+	blk_finish_plug(&plug);
+	spin_lock(&buffer_mapping->i_private_lock);
+
+	while (!list_empty(&tmp)) {
+		bh = BH_ENTRY(tmp.prev);
+		get_bh(bh);
+		__remove_assoc_queue(bh);
+		/* Avoid race with mark_buffer_dirty_inode() which does
+		 * a lockless check and we rely on seeing the dirty bit */
+		smp_mb();
+		if (buffer_dirty(bh)) {
+			list_add(&bh->b_assoc_buffers,
+				 &mapping->i_private_list);
+			bh->b_assoc_map = mapping;
+		}
+		spin_unlock(&buffer_mapping->i_private_lock);
+		wait_on_buffer(bh);
+		if (!buffer_uptodate(bh))
+			err = -EIO;
+		brelse(bh);
+		spin_lock(&buffer_mapping->i_private_lock);
+	}
+	spin_unlock(&buffer_mapping->i_private_lock);
+	return err;
 }
 EXPORT_SYMBOL(sync_mapping_buffers);
 
@@ -719,99 +792,6 @@ bool block_dirty_folio(struct address_space *mapping, struct folio *folio)
 }
 EXPORT_SYMBOL(block_dirty_folio);
 
-/*
- * Write out and wait upon a list of buffers.
- *
- * We have conflicting pressures: we want to make sure that all
- * initially dirty buffers get waited on, but that any subsequently
- * dirtied buffers don't.  After all, we don't want fsync to last
- * forever if somebody is actively writing to the file.
- *
- * Do this in two main stages: first we copy dirty buffers to a
- * temporary inode list, queueing the writes as we go.  Then we clean
- * up, waiting for those writes to complete.
- * 
- * During this second stage, any subsequent updates to the file may end
- * up refiling the buffer on the original inode's dirty list again, so
- * there is a chance we will end up with a buffer queued for write but
- * not yet completed on that list.  So, as a final cleanup we go through
- * the osync code to catch these locked, dirty buffers without requeuing
- * any newly dirty buffers for write.
- */
-static int fsync_buffers_list(spinlock_t *lock, struct list_head *list)
-{
-	struct buffer_head *bh;
-	struct address_space *mapping;
-	int err = 0;
-	struct blk_plug plug;
-	LIST_HEAD(tmp);
-
-	blk_start_plug(&plug);
-
-	spin_lock(lock);
-	while (!list_empty(list)) {
-		bh = BH_ENTRY(list->next);
-		mapping = bh->b_assoc_map;
-		__remove_assoc_queue(bh);
-		/* Avoid race with mark_buffer_dirty_inode() which does
-		 * a lockless check and we rely on seeing the dirty bit */
-		smp_mb();
-		if (buffer_dirty(bh) || buffer_locked(bh)) {
-			list_add(&bh->b_assoc_buffers, &tmp);
-			bh->b_assoc_map = mapping;
-			if (buffer_dirty(bh)) {
-				get_bh(bh);
-				spin_unlock(lock);
-				/*
-				 * Ensure any pending I/O completes so that
-				 * write_dirty_buffer() actually writes the
-				 * current contents - it is a noop if I/O is
-				 * still in flight on potentially older
-				 * contents.
-				 */
-				write_dirty_buffer(bh, REQ_SYNC);
-
-				/*
-				 * Kick off IO for the previous mapping. Note
-				 * that we will not run the very last mapping,
-				 * wait_on_buffer() will do that for us
-				 * through sync_buffer().
-				 */
-				brelse(bh);
-				spin_lock(lock);
-			}
-		}
-	}
-
-	spin_unlock(lock);
-	blk_finish_plug(&plug);
-	spin_lock(lock);
-
-	while (!list_empty(&tmp)) {
-		bh = BH_ENTRY(tmp.prev);
-		get_bh(bh);
-		mapping = bh->b_assoc_map;
-		__remove_assoc_queue(bh);
-		/* Avoid race with mark_buffer_dirty_inode() which does
-		 * a lockless check and we rely on seeing the dirty bit */
-		smp_mb();
-		if (buffer_dirty(bh)) {
-			list_add(&bh->b_assoc_buffers,
-				 &mapping->i_private_list);
-			bh->b_assoc_map = mapping;
-		}
-		spin_unlock(lock);
-		wait_on_buffer(bh);
-		if (!buffer_uptodate(bh))
-			err = -EIO;
-		brelse(bh);
-		spin_lock(lock);
-	}
-	
-	spin_unlock(lock);
-	return err;
-}
-
 /*
  * Invalidate any and all dirty buffers on a given inode.  We are
  * probably unmounting the fs, but that doesn't mean we have already
-- 
2.51.0



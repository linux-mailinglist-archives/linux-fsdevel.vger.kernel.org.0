Return-Path: <linux-fsdevel+bounces-79150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JccIW+6pmk7TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:39:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6F91ECCFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 547DD3158BA6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7434039D6CB;
	Tue,  3 Mar 2026 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M7DXaxKW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+K0D+oFG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M7DXaxKW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+K0D+oFG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A4838836B
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534119; cv=none; b=iZkB+aEA2P91ue5GlLI5AzhNXTJcopBIFORNOw73duPrHUfoRZ1SLngfZs14cy5D2MqOfGvS60f53kWqyAEPLjcvqHCmTk/z1agIzF4tIyh0I8PqtgPa/mzjRX/NsFuqMUJLHo2PfsymtqmtzjgrLeOJPJijbpJS6EmFbPJmh+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534119; c=relaxed/simple;
	bh=1NKDncz6Z7546ej0732+hXSWl17G06Ctb725RLacGIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7nJUMkpN3Jij4ZVYGXulPX6aLIFjDRIRH4s0v9JiDFadvT+AvXUW8iMtFK2e+qbmXFsUsehQ6TEG7ocxxw5s6EU6dAul+RbQQqsz//CEAycua1l3P9qsRsVqOK3gn3RmkWdAi/sJcQXjXCQbHt9KUxdVKH1qC9W89E61DpfQqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M7DXaxKW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+K0D+oFG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M7DXaxKW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+K0D+oFG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0AF845BE0C;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CT96S4tH9al06cTh68ySZsyxIYDQSszZc+Xp6SlwUwA=;
	b=M7DXaxKWtMRyhYr4MXQXP6J3y/jaodo/RheHYfA9UHSGBscRpU2T6OFDkfXtPOyUvefgOO
	y+Ix/lBY2xPeEip8z8yCGhYlfG7fAzWQ+QGzK/GK8j8jXpvWjLvL5d9Chr6PpH0PKDTYUT
	5tASa3cjE12uvVtXdGmB2eVWl21HXJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CT96S4tH9al06cTh68ySZsyxIYDQSszZc+Xp6SlwUwA=;
	b=+K0D+oFGYJj9IebSkPj92AyGF7Sa266jNkXcYqZh4jtDIc+G5TeW9Zfhm83n4LkSEpz5Fw
	Ka1HufVb7leimkAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CT96S4tH9al06cTh68ySZsyxIYDQSszZc+Xp6SlwUwA=;
	b=M7DXaxKWtMRyhYr4MXQXP6J3y/jaodo/RheHYfA9UHSGBscRpU2T6OFDkfXtPOyUvefgOO
	y+Ix/lBY2xPeEip8z8yCGhYlfG7fAzWQ+QGzK/GK8j8jXpvWjLvL5d9Chr6PpH0PKDTYUT
	5tASa3cjE12uvVtXdGmB2eVWl21HXJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CT96S4tH9al06cTh68ySZsyxIYDQSszZc+Xp6SlwUwA=;
	b=+K0D+oFGYJj9IebSkPj92AyGF7Sa266jNkXcYqZh4jtDIc+G5TeW9Zfhm83n4LkSEpz5Fw
	Ka1HufVb7leimkAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6CB93EA6E;
	Tue,  3 Mar 2026 10:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tOBXOES5pmlpFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 90541A0B3E; Tue,  3 Mar 2026 11:34:40 +0100 (CET)
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
Subject: [PATCH 09/32] fs: Ignore inode metadata buffers in inode_lru_isolate()
Date: Tue,  3 Mar 2026 11:33:58 +0100
Message-ID: <20260303103406.4355-41-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4530; i=jack@suse.cz; h=from:subject; bh=1NKDncz6Z7546ej0732+hXSWl17G06Ctb725RLacGIs=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpprklnMMCriSqYDkQ+rIxKnPPuxayrxzgjDtg5 Npw+AarQEuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaa5JQAKCRCcnaoHP2RA 2a3/CACPcN2MGI8XOdNvj6lYNDpYzIauPZkNrq3/RzSFXGzTPqgxcnHr8X34xE8anKLvRxDYgAG 5LUHHGutowHrO5P9h6RAn14sQhLuiJzxtPXOPD5lAdeblGtEuj4UyuBpTWMzJjI95nrkck7by0j DLk75DjlyAL2z8O1ejUazo1fzJzOe4hr6icYFpKeen+EpjxOYfEtTEBt4IlmwmsV9SZvrSxh3yK /BIxxSzQESb/o8dlFAbOGyejp0bZIFGBu7dudmhFrXiEMSZ1F1j3MA8lIHtpYoa6HNhhMO2BKc2 HRYgo9twZh6ov2fh07w+a3GI3PDO+Uz2QTgR7+sOZdkIc3mT
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -5.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: DE6F91ECCFC
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
	TAGGED_FROM(0.00)[bounces-79150-lists,linux-fsdevel=lfdr.de];
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

There are only a few filesystems that use generic tracking of inode
metadata buffer heads. As such it is mostly pointless to verify such
attached buffer heads during inode reclaim. Drop the handling from
inode_lru_isolate().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/buffer.c                 | 29 -----------------------------
 fs/inode.c                  | 21 +++++++++------------
 include/linux/buffer_head.h |  3 ---
 3 files changed, 9 insertions(+), 44 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 1bc0f22f3cc2..bd48644e1bf8 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -878,35 +878,6 @@ void invalidate_inode_buffers(struct inode *inode)
 }
 EXPORT_SYMBOL(invalidate_inode_buffers);
 
-/*
- * Remove any clean buffers from the inode's buffer list.  This is called
- * when we're trying to free the inode itself.  Those buffers can pin it.
- *
- * Returns true if all buffers were removed.
- */
-int remove_inode_buffers(struct inode *inode)
-{
-	int ret = 1;
-
-	if (inode_has_buffers(inode)) {
-		struct address_space *mapping = &inode->i_data;
-		struct list_head *list = &mapping->i_private_list;
-		struct address_space *buffer_mapping = mapping->i_private_data;
-
-		spin_lock(&buffer_mapping->i_private_lock);
-		while (!list_empty(list)) {
-			struct buffer_head *bh = BH_ENTRY(list->next);
-			if (buffer_dirty(bh)) {
-				ret = 0;
-				break;
-			}
-			__remove_assoc_queue(bh);
-		}
-		spin_unlock(&buffer_mapping->i_private_lock);
-	}
-	return ret;
-}
-
 /*
  * Create the appropriate buffers when given a folio for data area and
  * the size of each buffer.. Use the bh->b_this_page linked list to
diff --git a/fs/inode.c b/fs/inode.c
index cc12b68e021b..4f98a5f04bbd 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -17,7 +17,6 @@
 #include <linux/fsverity.h>
 #include <linux/mount.h>
 #include <linux/posix_acl.h>
-#include <linux/buffer_head.h> /* for inode_has_buffers */
 #include <linux/ratelimit.h>
 #include <linux/list_lru.h>
 #include <linux/iversion.h>
@@ -367,7 +366,6 @@ struct inode *alloc_inode(struct super_block *sb)
 
 void __destroy_inode(struct inode *inode)
 {
-	BUG_ON(inode_has_buffers(inode));
 	inode_detach_wb(inode);
 	security_inode_free(inode);
 	fsnotify_inode_delete(inode);
@@ -994,19 +992,18 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	 * page cache in order to free up struct inodes: lowmem might
 	 * be under pressure before the cache inside the highmem zone.
 	 */
-	if (inode_has_buffers(inode) || !mapping_empty(&inode->i_data)) {
+	if (!mapping_empty(&inode->i_data)) {
+		unsigned long reap;
+
 		inode_pin_lru_isolating(inode);
 		spin_unlock(&inode->i_lock);
 		spin_unlock(&lru->lock);
-		if (remove_inode_buffers(inode)) {
-			unsigned long reap;
-			reap = invalidate_mapping_pages(&inode->i_data, 0, -1);
-			if (current_is_kswapd())
-				__count_vm_events(KSWAPD_INODESTEAL, reap);
-			else
-				__count_vm_events(PGINODESTEAL, reap);
-			mm_account_reclaimed_pages(reap);
-		}
+		reap = invalidate_mapping_pages(&inode->i_data, 0, -1);
+		if (current_is_kswapd())
+			__count_vm_events(KSWAPD_INODESTEAL, reap);
+		else
+			__count_vm_events(PGINODESTEAL, reap);
+		mm_account_reclaimed_pages(reap);
 		inode_unpin_lru_isolating(inode);
 		return LRU_RETRY;
 	}
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index b16b88bfbc3e..631bf971efc0 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -517,7 +517,6 @@ void buffer_init(void);
 bool try_to_free_buffers(struct folio *folio);
 int inode_has_buffers(struct inode *inode);
 void invalidate_inode_buffers(struct inode *inode);
-int remove_inode_buffers(struct inode *inode);
 int sync_mapping_buffers(struct address_space *mapping);
 void invalidate_bh_lrus(void);
 void invalidate_bh_lrus_cpu(void);
@@ -528,9 +527,7 @@ extern int buffer_heads_over_limit;
 
 static inline void buffer_init(void) {}
 static inline bool try_to_free_buffers(struct folio *folio) { return true; }
-static inline int inode_has_buffers(struct inode *inode) { return 0; }
 static inline void invalidate_inode_buffers(struct inode *inode) {}
-static inline int remove_inode_buffers(struct inode *inode) { return 1; }
 static inline int sync_mapping_buffers(struct address_space *mapping) { return 0; }
 static inline void invalidate_bh_lrus(void) {}
 static inline void invalidate_bh_lrus_cpu(void) {}
-- 
2.51.0



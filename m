Return-Path: <linux-fsdevel+bounces-79167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBUzIQ67pmk7TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:42:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECEB1ECDC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC5283178DBB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60643947A0;
	Tue,  3 Mar 2026 10:36:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AC839A07C
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534177; cv=none; b=s/PJdWY5GP4i6HtvqyyoFgQ9unUfng0wtC1aeW75XcCHHCxTYeTnN62JrNp+TbSpNIYUJQqdOjPfUOYuCv26WemyfbScczNGe3T6U+eS6l3snsRQX+2WK+at6dvxfAdfSC7SW4nCxt6NFqh4MMUgHh+1LHrRxaQkU9K5krhgWz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534177; c=relaxed/simple;
	bh=6dajYHiVjkSm4ZzODgwKbSVFHrCgzhJerabocNYVVjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ie9bzJlPICX0/cKuO3RoB+KAOED7beHwExKwKuJ9kgZ0WvdZfEqc9btEE3MvBamMZZVTrk182+sSL6LVFVeoYQ2xQxFL1t0whZM1Qod2kRuq2uQN7xa5R5F2DWuETICefEGTxSvB/QzdrRTp6N2Z4EIZtZcg2lmuNKqHpOe4Oes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 679EE3F942;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D4CA3EA70;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MJjFFkW5pmmaFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2DFBCA0B7C; Tue,  3 Mar 2026 11:34:41 +0100 (CET)
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
Subject: [PATCH 27/32] udf: Track metadata bhs in fs-private inode part
Date: Tue,  3 Mar 2026 11:34:16 +0100
Message-ID: <20260303103406.4355-59-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3179; i=jack@suse.cz; h=from:subject; bh=6dajYHiVjkSm4ZzODgwKbSVFHrCgzhJerabocNYVVjI=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGDKX7TSNVF2nFX9t9eJp3/xFZxwqlHLYuD4v9YTc8g0Hj GrKGYKXdzIaszAwcjDIiimyrI68qH1tnlHX1lANGZhBrEwgUxi4OAVgIswR7P9sYsP4Fh5busqz eYuDDMe1jyoLrX++8O22yWSqvZq5QnLLB70ey6O7Yx+8aDMIN2nc4WTWrSMnGBI1RWDVrNY/E1a kxYvkWPdcNbsYGWnOUO7Td/Jo9xvOVWuXrS1m6z8a82kFq8kh67XaDBt1NOv9t+grab8TsjR8Lc O3KDaJa4onyyPHzFhhge6++qKSi1obd3sHPd/T+TqjfdfBAy23t7JMdN3N8m7n3/y6dyY8rBnO9 +60xc44KbZcK9rCJsW5tq6iUmbRhAaB2EqnxHIN+8uP/5bK9+/Y4GBrV9RUdXlq8eKly/WChS5u UP92OK691OjtjZV+4sx/jn5Ptyo0m3e51yf+YQfzZ6tMAA==
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
X-Rspamd-Queue-Id: 2ECEB1ECDC0
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
	TAGGED_FROM(0.00)[bounces-79167-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.862];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Track metadata bhs for an inode in fs-private part of the inode.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/file.c    | 1 +
 fs/udf/namei.c   | 1 +
 fs/udf/super.c   | 6 ++++++
 fs/udf/symlink.c | 1 +
 fs/udf/udf_i.h   | 1 +
 fs/udf/udfdecl.h | 1 +
 6 files changed, 11 insertions(+)

diff --git a/fs/udf/file.c b/fs/udf/file.c
index 32ae7cfd72c5..8d51313173f3 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -251,4 +251,5 @@ static int udf_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 const struct inode_operations udf_file_inode_operations = {
 	.setattr		= udf_setattr,
+	.get_metadata_bhs	= udf_get_metadata_bhs,
 };
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 5f2e9a892bff..ef9eadb96f4e 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1025,4 +1025,5 @@ const struct inode_operations udf_dir_inode_operations = {
 	.mknod				= udf_mknod,
 	.rename				= udf_rename,
 	.tmpfile			= udf_tmpfile,
+	.get_metadata_bhs		= udf_get_metadata_bhs,
 };
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 27f463fd1d89..eb62972c9fda 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -166,6 +166,7 @@ static struct inode *udf_alloc_inode(struct super_block *sb)
 	ei->cached_extent.lstart = -1;
 	spin_lock_init(&ei->i_extent_cache_lock);
 	inode_set_iversion(&ei->vfs_inode, 1);
+	mmb_init(&ei->i_metadata_bhs);
 
 	return &ei->vfs_inode;
 }
@@ -205,6 +206,11 @@ static void destroy_inodecache(void)
 	kmem_cache_destroy(udf_inode_cachep);
 }
 
+struct mapping_metadata_bhs *udf_get_metadata_bhs(struct inode *inode)
+{
+	return &UDF_I(inode)->i_metadata_bhs;
+}
+
 /* Superblock operations */
 static const struct super_operations udf_sb_ops = {
 	.alloc_inode	= udf_alloc_inode,
diff --git a/fs/udf/symlink.c b/fs/udf/symlink.c
index fe03745d09b1..56c860a10b91 100644
--- a/fs/udf/symlink.c
+++ b/fs/udf/symlink.c
@@ -168,4 +168,5 @@ const struct address_space_operations udf_symlink_aops = {
 const struct inode_operations udf_symlink_inode_operations = {
 	.get_link	= page_get_link,
 	.getattr	= udf_symlink_getattr,
+	.get_metadata_bhs	= udf_get_metadata_bhs,
 };
diff --git a/fs/udf/udf_i.h b/fs/udf/udf_i.h
index 312b7c9ef10e..fdaa88c49c2b 100644
--- a/fs/udf/udf_i.h
+++ b/fs/udf/udf_i.h
@@ -50,6 +50,7 @@ struct udf_inode_info {
 	struct kernel_lb_addr	i_locStreamdir;
 	__u64			i_lenStreams;
 	struct rw_semaphore	i_data_sem;
+	struct mapping_metadata_bhs i_metadata_bhs;
 	struct udf_ext_cache cached_extent;
 	/* Spinlock for protecting extent cache */
 	spinlock_t i_extent_cache_lock;
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index d159f20d61e8..db2b92217bf5 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -126,6 +126,7 @@ static inline void udf_updated_lvid(struct super_block *sb)
 extern u64 lvid_get_unique_id(struct super_block *sb);
 struct inode *udf_find_metadata_inode_efe(struct super_block *sb,
 					u32 meta_file_loc, u32 partition_num);
+struct mapping_metadata_bhs *udf_get_metadata_bhs(struct inode *inode);
 
 /* namei.c */
 static inline unsigned int udf_dir_entry_len(struct fileIdentDesc *cfi)
-- 
2.51.0



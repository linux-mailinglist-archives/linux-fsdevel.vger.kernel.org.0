Return-Path: <linux-fsdevel+bounces-79166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGyPEQy7pmk7TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:42:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D611ECDB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB086310B6C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCB339A04F;
	Tue,  3 Mar 2026 10:36:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B3F39D6D4
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534170; cv=none; b=u0JPzf4C3LdxkZ8ZrxzNE3Yy11gD3xG2dZwB/S+5M+i8TBgknPUQypACr0yPJdgI5Vuh2UBlV+TsG0ooFKJ/wf/r94T5NVjdhYcX4RM98aeJM5FBnAnstnjidCAeuCQttKBSGq5rgVpIaCeZbgAnUprn/rIty4CV/unD7KIxS3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534170; c=relaxed/simple;
	bh=9mjhfCWoeJv6I1ItfFebb5usm5NcNzQ2umKz8lNEm4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l13NBqtJLJdGBt+vKucmfQA32edaWpzsCarP+teraHRSWOruyRInTWmdrNZa8qoZcOs0zcLIlmEDbLPZU46saTefpqrbJM2mWpVC0ushaepbazeEabt2N3qaUTWDBUqBuxJhPmLNhtPXZgWypNO1juoDmlD9yVveBCJDlyqhjvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5DDFB3F8EA;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 516C53EA6C;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id noLoE0W5pmmUFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1F1A2A0B7A; Tue,  3 Mar 2026 11:34:41 +0100 (CET)
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
Subject: [PATCH 25/32] bfs: Track metadata bhs in fs-private inode part
Date: Tue,  3 Mar 2026 11:34:14 +0100
Message-ID: <20260303103406.4355-57-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2544; i=jack@suse.cz; h=from:subject; bh=9mjhfCWoeJv6I1ItfFebb5usm5NcNzQ2umKz8lNEm4E=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpprkzm+CXPHG9qbKxLBWqWfD9bfsr1e7/r+Z0e 3i6Z9c2uGeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaa5MwAKCRCcnaoHP2RA 2U37CADBuxAkezEybmQ0+5cu0HE2PB14rqomXTSB64cI4hA4RYjEtXYMq6ndBH7EUmG/Typj0mb Z+WqgD1gdRE03UGv21Xr+V9XaKUCmZ1hItLRnX5SJL5Gz1FmWkRbc1ON5e00Ua9lI4KfwaWjLgq wcJocR12a0aQuW7rn3OXkZ+GLDTO0+MU3QXQleblPeAR0/U9Q4Zj7r66v2vf9KL98RlA/rrf8cb /b5AcHHZK0G9fsiDIdW+V39fgNxI3zkNeHtwENm+KTHC8LLeZ5uzEKdOgDnRvFZhajvwiEpelUK S2R4MKTBLxLRbKF//3ybdddGqVpwdMi46ZjPt7CTgfL0wxDI
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
X-Rspamd-Queue-Id: E5D611ECDB9
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
	TAGGED_FROM(0.00)[bounces-79166-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.864];
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
 fs/bfs/bfs.h   | 2 ++
 fs/bfs/dir.c   | 1 +
 fs/bfs/file.c  | 4 +++-
 fs/bfs/inode.c | 7 +++++++
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/bfs/bfs.h b/fs/bfs/bfs.h
index 606f9378b2f0..5fadb6e860f1 100644
--- a/fs/bfs/bfs.h
+++ b/fs/bfs/bfs.h
@@ -35,6 +35,7 @@ struct bfs_inode_info {
 	unsigned long i_dsk_ino; /* inode number from the disk, can be 0 */
 	unsigned long i_sblock;
 	unsigned long i_eblock;
+	struct mapping_metadata_bhs i_metadata_bhs;
 	struct inode vfs_inode;
 };
 
@@ -55,6 +56,7 @@ static inline struct bfs_inode_info *BFS_I(struct inode *inode)
 /* inode.c */
 extern struct inode *bfs_iget(struct super_block *sb, unsigned long ino);
 extern void bfs_dump_imap(const char *, struct super_block *);
+struct mapping_metadata_bhs *bfs_get_metadata_bhs(struct inode *inode);
 
 /* file.c */
 extern const struct inode_operations bfs_file_inops;
diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
index c375e22c4c0c..30529f476582 100644
--- a/fs/bfs/dir.c
+++ b/fs/bfs/dir.c
@@ -262,6 +262,7 @@ const struct inode_operations bfs_dir_inops = {
 	.link			= bfs_link,
 	.unlink			= bfs_unlink,
 	.rename			= bfs_rename,
+	.get_metadata_bhs	= bfs_get_metadata_bhs,
 };
 
 static int bfs_add_entry(struct inode *dir, const struct qstr *child, int ino)
diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index d33d6bde992b..335ab07e37fe 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -200,4 +200,6 @@ const struct address_space_operations bfs_aops = {
 	.bmap		= bfs_bmap,
 };
 
-const struct inode_operations bfs_file_inops;
+const struct inode_operations bfs_file_inops = {
+	.get_metadata_bhs = bfs_get_metadata_bhs,
+};
diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index e0e50a9dbe9c..f1a392394a23 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -259,6 +259,8 @@ static struct inode *bfs_alloc_inode(struct super_block *sb)
 	bi = alloc_inode_sb(sb, bfs_inode_cachep, GFP_KERNEL);
 	if (!bi)
 		return NULL;
+	mmb_init(&bi->i_metadata_bhs);
+
 	return &bi->vfs_inode;
 }
 
@@ -296,6 +298,11 @@ static void destroy_inodecache(void)
 	kmem_cache_destroy(bfs_inode_cachep);
 }
 
+struct mapping_metadata_bhs *bfs_get_metadata_bhs(struct inode *inode)
+{
+	return &BFS_I(inode)->i_metadata_bhs;
+}
+
 static const struct super_operations bfs_sops = {
 	.alloc_inode	= bfs_alloc_inode,
 	.free_inode	= bfs_free_inode,
-- 
2.51.0



Return-Path: <linux-fsdevel+bounces-79157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PmNENm5pmn2TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:37:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FC61ECBE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B3553090D2B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE75139D6CE;
	Tue,  3 Mar 2026 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jtt/X+Ov";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EMkHO91R";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jtt/X+Ov";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EMkHO91R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC63391518
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534138; cv=none; b=OcisE2uCfT/vZQPz1xKfihdYG9VXJ/l6PIPRn5N3CfB0cWNmv7y0gwgzy9GA7pgwGZi2t1OOEBU4zJJ7CpVQp3BA13D1Y4ScRHaBF6cb8jIaZru4aCiGIHZ8WYanpgehPkVOF9jzvy8gWBqgFS3qFTLZJzBalr9HzZr2i23ir54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534138; c=relaxed/simple;
	bh=mdP2kASBf0yhnD0I35SUu4LGJDwskVC25FLk12a/mT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAbjAztJehSX3NC8mnhM3u5OL6nA0DoDvPRfeFGESTZgXV+g2Y0xOZAru7yA9ug1QsD0D+Eu0P0HnZIcjIUCUsWDNE2E3CBxdnvRAOPsLxJnDJEVra7ZGmh8AHqnA8yizBvg4d/yhR9XBls1ilaQ0R9Rfv558bKwKrhkX+Ydzg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jtt/X+Ov; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EMkHO91R; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jtt/X+Ov; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EMkHO91R; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 224ED3F91D;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X/R3AGN6dIap1MXQgjeMm6isvpHyScocBtEis1Qb+TE=;
	b=jtt/X+OvIvVdUwKgh4xL9YMut+xDZKuIZtEun+84g+PdWambqB5wsvhS1yuwy140SEbKwd
	pmYPWXo9PVcYcMrjf1ri+Ic5X81lFQ8aW7H+7LVEbGKOzajngf06OtUCtiotuNpYBmWt6f
	ujK78jaX6vPeqcHdOzbprEs3H/oPSuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X/R3AGN6dIap1MXQgjeMm6isvpHyScocBtEis1Qb+TE=;
	b=EMkHO91R02qtxca70SAyvWqsQfbUkL+kwwvnUNtngPhUR/ktaM1jB/eEvdk/hzG8cEdSIO
	lEtUGv0YJBhjfmCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X/R3AGN6dIap1MXQgjeMm6isvpHyScocBtEis1Qb+TE=;
	b=jtt/X+OvIvVdUwKgh4xL9YMut+xDZKuIZtEun+84g+PdWambqB5wsvhS1yuwy140SEbKwd
	pmYPWXo9PVcYcMrjf1ri+Ic5X81lFQ8aW7H+7LVEbGKOzajngf06OtUCtiotuNpYBmWt6f
	ujK78jaX6vPeqcHdOzbprEs3H/oPSuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X/R3AGN6dIap1MXQgjeMm6isvpHyScocBtEis1Qb+TE=;
	b=EMkHO91R02qtxca70SAyvWqsQfbUkL+kwwvnUNtngPhUR/ktaM1jB/eEvdk/hzG8cEdSIO
	lEtUGv0YJBhjfmCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0840B3EA6D;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id psQCAkW5pml3FQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B18C3A0A1B; Tue,  3 Mar 2026 11:34:40 +0100 (CET)
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
Subject: [PATCH 13/32] aio: Stop using i_private_data and i_private_lock
Date: Tue,  3 Mar 2026 11:34:02 +0100
Message-ID: <20260303103406.4355-45-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4888; i=jack@suse.cz; h=from:subject; bh=mdP2kASBf0yhnD0I35SUu4LGJDwskVC25FLk12a/mT4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpprkpGGJT8GdQ+e+wtuFtTkXrw0gaAb7TMpeEt l5v77h9SHyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaa5KQAKCRCcnaoHP2RA 2aTrB/9cnXJIMvdimpOkyXF/Xu8esspG7p2Aqqbjb7vY+uDFQBpeazoobimlSn4T58sY/qKLVtR KguGgxbpJ+jBL8kZySyIV6xuoQBfW2uAtQMJOpwZUEy93PUsqIza42+evISAIYTwPrFmyNI21PA 5ORjSmMd47aR/Mkt1hvr6uD+NRbQuACWHGNeAbFnzcJfBY6aUVt/wlk7ILAkqlKH2JPNdGEVj6t 6ZrJ5EoMme75AROWoVpjwy9Z81RPwKeErABqEO4bGBzlswivLN8Zmo2flBeHAiOSMNwqngRWD0g N0ZKu/GYb5smtDSyZB486GaUWKLR5XX/GJ4+jXodaTd/C2R+
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.30
X-Spam-Level: 
X-Rspamd-Queue-Id: 00FC61ECBE3
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
	TAGGED_FROM(0.00)[bounces-79157-lists,linux-fsdevel=lfdr.de];
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

Instead of using i_private_data and i_private_lock, just create aio
inodes with appropriate necessary fields.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/aio.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 66 insertions(+), 12 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index a07bdd1aaaa6..ba9b9fa2446b 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -218,6 +218,17 @@ struct aio_kiocb {
 	struct eventfd_ctx	*ki_eventfd;
 };
 
+struct aio_inode_info {
+	struct inode vfs_inode;
+	spinlock_t migrate_lock;
+	struct kioctx *ctx;
+};
+
+static inline struct aio_inode_info *AIO_I(struct inode *inode)
+{
+	return container_of(inode, struct aio_inode_info, vfs_inode);
+}
+
 /*------ sysctl variables----*/
 static DEFINE_SPINLOCK(aio_nr_lock);
 static unsigned long aio_nr;		/* current system wide number of aio requests */
@@ -251,6 +262,7 @@ static void __init aio_sysctl_init(void)
 
 static struct kmem_cache	*kiocb_cachep;
 static struct kmem_cache	*kioctx_cachep;
+static struct kmem_cache	*aio_inode_cachep;
 
 static struct vfsmount *aio_mnt;
 
@@ -261,11 +273,12 @@ static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
 {
 	struct file *file;
 	struct inode *inode = alloc_anon_inode(aio_mnt->mnt_sb);
+
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
 	inode->i_mapping->a_ops = &aio_ctx_aops;
-	inode->i_mapping->i_private_data = ctx;
+	AIO_I(inode)->ctx = ctx;
 	inode->i_size = PAGE_SIZE * nr_pages;
 
 	file = alloc_file_pseudo(inode, aio_mnt, "[aio]",
@@ -275,14 +288,49 @@ static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
 	return file;
 }
 
+static struct inode *aio_alloc_inode(struct super_block *sb)
+{
+	struct aio_inode_info *ai;
+
+	ai = alloc_inode_sb(sb, aio_inode_cachep, GFP_KERNEL);
+	if (!ai)
+		return NULL;
+	ai->ctx = NULL;
+
+	return &ai->vfs_inode;
+}
+
+static void aio_free_inode(struct inode *inode)
+{
+	kmem_cache_free(aio_inode_cachep, AIO_I(inode));
+}
+
+static const struct super_operations aio_super_operations = {
+	.alloc_inode	= aio_alloc_inode,
+	.free_inode	= aio_free_inode,
+	.statfs		= simple_statfs,
+};
+
 static int aio_init_fs_context(struct fs_context *fc)
 {
-	if (!init_pseudo(fc, AIO_RING_MAGIC))
+	struct pseudo_fs_context *pfc;
+
+	pfc = init_pseudo(fc, AIO_RING_MAGIC);
+	if (!pfc)
 		return -ENOMEM;
 	fc->s_iflags |= SB_I_NOEXEC;
+	pfc->ops = &aio_super_operations;
 	return 0;
 }
 
+static void init_once(void *obj)
+{
+	struct aio_inode_info *ai = obj;
+
+	inode_init_once(&ai->vfs_inode);
+	spin_lock_init(&ai->migrate_lock);
+}
+
 /* aio_setup
  *	Creates the slab caches used by the aio routines, panic on
  *	failure as this is done early during the boot sequence.
@@ -294,6 +342,11 @@ static int __init aio_setup(void)
 		.init_fs_context = aio_init_fs_context,
 		.kill_sb	= kill_anon_super,
 	};
+
+	aio_inode_cachep = kmem_cache_create("aio_inode_cache",
+				sizeof(struct aio_inode_info), 0,
+				(SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_ACCOUNT),
+				init_once);
 	aio_mnt = kern_mount(&aio_fs);
 	if (IS_ERR(aio_mnt))
 		panic("Failed to create aio fs mount.");
@@ -308,17 +361,17 @@ __initcall(aio_setup);
 static void put_aio_ring_file(struct kioctx *ctx)
 {
 	struct file *aio_ring_file = ctx->aio_ring_file;
-	struct address_space *i_mapping;
 
 	if (aio_ring_file) {
-		truncate_setsize(file_inode(aio_ring_file), 0);
+		struct inode *inode = file_inode(aio_ring_file);
+
+		truncate_setsize(inode, 0);
 
 		/* Prevent further access to the kioctx from migratepages */
-		i_mapping = aio_ring_file->f_mapping;
-		spin_lock(&i_mapping->i_private_lock);
-		i_mapping->i_private_data = NULL;
+		spin_lock(&AIO_I(inode)->migrate_lock);
+		AIO_I(inode)->ctx = NULL;
 		ctx->aio_ring_file = NULL;
-		spin_unlock(&i_mapping->i_private_lock);
+		spin_unlock(&AIO_I(inode)->migrate_lock);
 
 		fput(aio_ring_file);
 	}
@@ -408,13 +461,14 @@ static int aio_migrate_folio(struct address_space *mapping, struct folio *dst,
 			struct folio *src, enum migrate_mode mode)
 {
 	struct kioctx *ctx;
+	struct aio_inode_info *ai = AIO_I(mapping->host);
 	unsigned long flags;
 	pgoff_t idx;
 	int rc = 0;
 
-	/* mapping->i_private_lock here protects against the kioctx teardown.  */
-	spin_lock(&mapping->i_private_lock);
-	ctx = mapping->i_private_data;
+	/* ai->migrate_lock here protects against the kioctx teardown.  */
+	spin_lock(&ai->migrate_lock);
+	ctx = ai->ctx;
 	if (!ctx) {
 		rc = -EINVAL;
 		goto out;
@@ -467,7 +521,7 @@ static int aio_migrate_folio(struct address_space *mapping, struct folio *dst,
 out_unlock:
 	mutex_unlock(&ctx->ring_lock);
 out:
-	spin_unlock(&mapping->i_private_lock);
+	spin_unlock(&ai->migrate_lock);
 	return rc;
 }
 #else
-- 
2.51.0



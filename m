Return-Path: <linux-fsdevel+bounces-46300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECF5A864EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 19:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2870C460CAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 17:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9293D23BCFA;
	Fri, 11 Apr 2025 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYykWba3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0021E0DD9
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744393146; cv=none; b=Sjwuq0W/94prDRdlAhK9B04Btjum7Hx4a7/qeGW/knMXH7Hgr0i6y+SWXPEGta69F0AjZf0xSOH+7TA5lgJPIB/8NMZwlW70vvVX92oKN4dtDpWtxU9Q11MxPYFWyGbuq2YRvooC+VHo9lBgO4sejFJy/hTsrCwxNlf++TcG4ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744393146; c=relaxed/simple;
	bh=KOybpz4+bqIwvbCqCpRnHVcMviIFd9U+fxuWZlR5ppU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9/rA11vId40FggUbBzCY3hk3QKf8nqBIkuF+8noU7Xi5JgFZmrVzgzUoIctywCEuF7UEP2+J5bnPzD+2V6qecTrVMsk3/1HP6SrvvfKKq+UQunmasp+SK0/8mzMKYyrxuYliH904Gebh+Mobbj/cqc+J8MWilcsRGrYYaz01Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KYykWba3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744393143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QNBxZedSjhHVlSQxr3A8upwLJJB050Uqni5aWTM+brw=;
	b=KYykWba3+nwcVr5Ltl5h+44hk8KsHK7uL1+6hSXJw+6lSde8IFgNGvCTT6exNLcvfBRQ54
	jeu8c7f0++F7f0j9dWCHnTLVZAYD+pRD8uEfeZTKiRASYI28jwgavr3enPDiFbKBveB466
	3a4RQnZqYzJkfZBTPX9duwya1nJgzw8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-F-rfohG5M1SYsq6T2vNaaQ-1; Fri,
 11 Apr 2025 13:38:59 -0400
X-MC-Unique: F-rfohG5M1SYsq6T2vNaaQ-1
X-Mimecast-MFC-AGG-ID: F-rfohG5M1SYsq6T2vNaaQ_1744393138
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8F6F19560BD;
	Fri, 11 Apr 2025 17:38:57 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.37])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A92101955BC2;
	Fri, 11 Apr 2025 17:38:54 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: cgroups@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Jan Kara <jack@suse.cz>,
	Rafael Aquini <aquini@redhat.com>,
	gfs2@lists.linux.dev,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] gfs2: replace sd_aspace with sd_inode
Date: Fri, 11 Apr 2025 19:38:46 +0200
Message-ID: <20250411173848.3755912-2-agruenba@redhat.com>
In-Reply-To: <20250411173848.3755912-1-agruenba@redhat.com>
References: <20250411173848.3755912-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Currently, sdp->sd_aspace and the per-inode metadata address spaces use
sb->s_bdev->bd_mapping->host as their ->host; folios in those address
spaces will thus appear to be on bdev rather than on gfs2 filesystems.
This is a problem because gfs2 doesn't support cgroup writeback
(SB_I_CGROUPWB), but bdev does.

Fix that by using a "dummy" gfs2 inode as ->host in those address
spaces.  When coming from a folio, folio->mapping->host->i_sb will then
be a gfs2 super block and the SB_I_CGROUPWB flag will not be set in
sb->s_iflags.

Based on a previous version from Bob Peterson from several years ago.
Thanks to Tetsuo Handa, Jan Kara, and Rafael Aquini for helping me
figure this out.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c      |  3 +--
 fs/gfs2/glops.c      |  4 ++--
 fs/gfs2/incore.h     |  9 ++++++++-
 fs/gfs2/meta_io.c    |  2 +-
 fs/gfs2/meta_io.h    |  4 +---
 fs/gfs2/ops_fstype.c | 31 ++++++++++++++++++-------------
 fs/gfs2/super.c      |  2 +-
 7 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index d7220a6fe8f5..ba25b884169e 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1166,7 +1166,6 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
 		   const struct gfs2_glock_operations *glops, int create,
 		   struct gfs2_glock **glp)
 {
-	struct super_block *s = sdp->sd_vfs;
 	struct lm_lockname name = { .ln_number = number,
 				    .ln_type = glops->go_type,
 				    .ln_sbd = sdp };
@@ -1229,7 +1228,7 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
 	mapping = gfs2_glock2aspace(gl);
 	if (mapping) {
                 mapping->a_ops = &gfs2_meta_aops;
-		mapping->host = s->s_bdev->bd_mapping->host;
+		mapping->host = sdp->sd_inode;
 		mapping->flags = 0;
 		mapping_set_gfp_mask(mapping, GFP_NOFS);
 		mapping->i_private_data = NULL;
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index eb4714f299ef..116efe335c32 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -168,7 +168,7 @@ void gfs2_ail_flush(struct gfs2_glock *gl, bool fsync)
 static int gfs2_rgrp_metasync(struct gfs2_glock *gl)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
-	struct address_space *metamapping = &sdp->sd_aspace;
+	struct address_space *metamapping = gfs2_aspace(sdp);
 	struct gfs2_rgrpd *rgd = gfs2_glock2rgrp(gl);
 	const unsigned bsize = sdp->sd_sb.sb_bsize;
 	loff_t start = (rgd->rd_addr * bsize) & PAGE_MASK;
@@ -225,7 +225,7 @@ static int rgrp_go_sync(struct gfs2_glock *gl)
 static void rgrp_go_inval(struct gfs2_glock *gl, int flags)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
-	struct address_space *mapping = &sdp->sd_aspace;
+	struct address_space *mapping = gfs2_aspace(sdp);
 	struct gfs2_rgrpd *rgd = gfs2_glock2rgrp(gl);
 	const unsigned bsize = sdp->sd_sb.sb_bsize;
 	loff_t start, end;
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 74abbd4970f8..0a41c4e76b32 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -795,7 +795,7 @@ struct gfs2_sbd {
 
 	/* Log stuff */
 
-	struct address_space sd_aspace;
+	struct inode *sd_inode;
 
 	spinlock_t sd_log_lock;
 
@@ -851,6 +851,13 @@ struct gfs2_sbd {
 	unsigned long sd_glock_dqs_held;
 };
 
+#define GFS2_BAD_INO 1
+
+static inline struct address_space *gfs2_aspace(struct gfs2_sbd *sdp)
+{
+	return sdp->sd_inode->i_mapping;
+}
+
 static inline void gfs2_glstats_inc(struct gfs2_glock *gl, int which)
 {
 	gl->gl_stats.stats[which]++;
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 198cc7056637..9dc8885c95d0 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -132,7 +132,7 @@ struct buffer_head *gfs2_getbuf(struct gfs2_glock *gl, u64 blkno, int create)
 	unsigned int bufnum;
 
 	if (mapping == NULL)
-		mapping = &sdp->sd_aspace;
+		mapping = gfs2_aspace(sdp);
 
 	shift = PAGE_SHIFT - sdp->sd_sb.sb_bsize_shift;
 	index = blkno >> shift;             /* convert block to page */
diff --git a/fs/gfs2/meta_io.h b/fs/gfs2/meta_io.h
index 831d988c2ceb..b7c8a6684d02 100644
--- a/fs/gfs2/meta_io.h
+++ b/fs/gfs2/meta_io.h
@@ -44,9 +44,7 @@ static inline struct gfs2_sbd *gfs2_mapping2sbd(struct address_space *mapping)
 		struct gfs2_glock_aspace *gla =
 			container_of(mapping, struct gfs2_glock_aspace, mapping);
 		return gla->glock.gl_name.ln_sbd;
-	} else if (mapping->a_ops == &gfs2_rgrp_aops)
-		return container_of(mapping, struct gfs2_sbd, sd_aspace);
-	else
+	} else
 		return inode->i_sb->s_fs_info;
 }
 
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index e83d293c3614..dbd6f76bfa2b 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -72,7 +72,6 @@ void free_sbd(struct gfs2_sbd *sdp)
 static struct gfs2_sbd *init_sbd(struct super_block *sb)
 {
 	struct gfs2_sbd *sdp;
-	struct address_space *mapping;
 
 	sdp = kzalloc(sizeof(struct gfs2_sbd), GFP_KERNEL);
 	if (!sdp)
@@ -109,16 +108,6 @@ static struct gfs2_sbd *init_sbd(struct super_block *sb)
 
 	INIT_LIST_HEAD(&sdp->sd_sc_inodes_list);
 
-	mapping = &sdp->sd_aspace;
-
-	address_space_init_once(mapping);
-	mapping->a_ops = &gfs2_rgrp_aops;
-	mapping->host = sb->s_bdev->bd_mapping->host;
-	mapping->flags = 0;
-	mapping_set_gfp_mask(mapping, GFP_NOFS);
-	mapping->i_private_data = NULL;
-	mapping->writeback_index = 0;
-
 	spin_lock_init(&sdp->sd_log_lock);
 	atomic_set(&sdp->sd_log_pinned, 0);
 	INIT_LIST_HEAD(&sdp->sd_log_revokes);
@@ -1135,6 +1124,7 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	int silent = fc->sb_flags & SB_SILENT;
 	struct gfs2_sbd *sdp;
 	struct gfs2_holder mount_gh;
+	struct address_space *mapping;
 	int error;
 
 	sdp = init_sbd(sb);
@@ -1156,6 +1146,19 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_flags |= SB_NOSEC;
 	sb->s_magic = GFS2_MAGIC;
 	sb->s_op = &gfs2_super_ops;
+
+	/* Set up an address space for metadata writes */
+	sdp->sd_inode = new_inode(sb);
+	error = -ENOMEM;
+	if (!sdp->sd_inode)
+		goto fail_free;
+	sdp->sd_inode->i_ino = GFS2_BAD_INO;
+	sdp->sd_inode->i_size = OFFSET_MAX;
+
+	mapping = gfs2_aspace(sdp);
+	mapping->a_ops = &gfs2_rgrp_aops;
+	mapping_set_gfp_mask(mapping, GFP_NOFS);
+
 	sb->s_d_op = &gfs2_dops;
 	sb->s_export_op = &gfs2_export_ops;
 	sb->s_qcop = &gfs2_quotactl_ops;
@@ -1183,7 +1186,7 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	error = init_names(sdp, silent);
 	if (error)
-		goto fail_free;
+		goto fail_iput;
 
 	snprintf(sdp->sd_fsname, sizeof(sdp->sd_fsname), "%s", sdp->sd_table_name);
 
@@ -1192,7 +1195,7 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 			WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_FREEZABLE, 0,
 			sdp->sd_fsname);
 	if (!sdp->sd_glock_wq)
-		goto fail_free;
+		goto fail_iput;
 
 	sdp->sd_delete_wq = alloc_workqueue("gfs2-delete/%s",
 			WQ_MEM_RECLAIM | WQ_FREEZABLE, 0, sdp->sd_fsname);
@@ -1309,6 +1312,8 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 fail_glock_wq:
 	if (sdp->sd_glock_wq)
 		destroy_workqueue(sdp->sd_glock_wq);
+fail_iput:
+	iput(sdp->sd_inode);
 fail_free:
 	free_sbd(sdp);
 	sb->s_fs_info = NULL;
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 44e5658b896c..4529b7dda8ca 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -648,7 +648,7 @@ static void gfs2_put_super(struct super_block *sb)
 	gfs2_jindex_free(sdp);
 	/*  Take apart glock structures and buffer lists  */
 	gfs2_gl_hash_clear(sdp);
-	truncate_inode_pages_final(&sdp->sd_aspace);
+	iput(sdp->sd_inode);
 	gfs2_delete_debugfs_file(sdp);
 
 	gfs2_sys_fs_del(sdp);
-- 
2.48.1



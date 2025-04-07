Return-Path: <linux-fsdevel+bounces-45908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A07A7EBA9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 20:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D041899BDE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 18:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABBF259CBB;
	Mon,  7 Apr 2025 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJYiYp/P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1AD259C9E
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050078; cv=none; b=d4C0gpI8Bl8PCoMO8VO2MXn7e0xKuezVRK8xHWxehVFHU1FtgqNLKGh/uFXgaq3PeGdOJrWZjCdq/eIZRPnwpf9XmvluC0BZMBZJQVEk1eY8oP/fQwysX7g6IoxX85HCE6+IaW8mcvLAKE9IaSv9sVXfaYrfKIGqh7YZ/VkGtE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050078; c=relaxed/simple;
	bh=Fz/XDtdulRxQ3oKljNvKc4VMr4rk0YKdQk3hA5O+D7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=if3jhG/V3Eobq9d3nxbIR1Mc09+onJx1Ug5gVxXONMlBXUKT2iCLw0Bzl3vc6TmFCJScSARLeeUvudFyqv0dUnu3QNPYCGp4iKo1+0t2vO/bmNfKbrDuGsKoI64U/FxjJgPau/Kgs/38WL43xRX+oJrEeKQTL/bw3BbnuPJ814w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QJYiYp/P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744050075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AKqSZoUpU0uzACYZM5pmj6GRgcBtXZsWwsDTZhVURtA=;
	b=QJYiYp/PrR1Ih+EB6SFdtsff044sebim0BXh51+uhAfan3O8sG9QU07SOCB+2oi8w0X2rz
	K6Sylz+tCTw4FhnBsIyzyMs+rHFLIYD5UUJWwEURn2qtIDik7YgqqdWzUPUOewB0VCpNXf
	7BDgrq7dvrvVHnUkQRMD5IRROaFvFBE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-_jQ5k9ceMQ6hbE5jbl7neQ-1; Mon,
 07 Apr 2025 14:21:14 -0400
X-MC-Unique: _jQ5k9ceMQ6hbE5jbl7neQ-1
X-Mimecast-MFC-AGG-ID: _jQ5k9ceMQ6hbE5jbl7neQ_1744050073
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2EBA19560BC;
	Mon,  7 Apr 2025 18:21:12 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.15])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 86B0D180A803;
	Mon,  7 Apr 2025 18:21:09 +0000 (UTC)
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
Subject: [RFC 1/2] gfs2: replace sd_aspace with sd_inode
Date: Mon,  7 Apr 2025 20:21:01 +0200
Message-ID: <20250407182104.716631-2-agruenba@redhat.com>
In-Reply-To: <20250407182104.716631-1-agruenba@redhat.com>
References: <20250407182104.716631-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Use a dummy inode as mapping->host of the address spaces for global as
well as per-inode metadata.  The global metadata address space is now
accessed as gfs2_aspace(sdp) instead of sdp->sd_aspace.  The per-inode
metadata address spaces are still accessed as
gfs2_glock2aspace(GFS2_I(inode)->i_gl).

Based on a previous version from Bob Peterson from several years ago.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c      |  3 +--
 fs/gfs2/glops.c      |  4 ++--
 fs/gfs2/incore.h     |  9 ++++++++-
 fs/gfs2/meta_io.c    |  2 +-
 fs/gfs2/meta_io.h    |  4 +---
 fs/gfs2/ops_fstype.c | 24 +++++++++++++-----------
 fs/gfs2/super.c      |  2 +-
 7 files changed, 27 insertions(+), 21 deletions(-)

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
index e83d293c3614..ce6ee494ffc4 100644
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
@@ -1156,6 +1146,18 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_flags |= SB_NOSEC;
 	sb->s_magic = GFS2_MAGIC;
 	sb->s_op = &gfs2_super_ops;
+
+	/* Set up an address space for metadata writes */
+	sdp->sd_inode = new_inode(sb);
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



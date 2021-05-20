Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6695A38AE2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 14:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbhETM2X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 08:28:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233653AbhETM1Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 08:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621513555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2c2jw50qd2fCeI4RwK6TC+NJCCNrz2KKMYGOCwuAm3M=;
        b=Za9jOvN6szuYS62d5+OXIRBKr3VItYVvRXNIWdGLs7aU0v7ptIjKnAsb1jCSTvDC8ySWpn
        i2Cifb3IG+VhmsrvkWMzptk26qM5jEHxnvBwIhtSMVbbkeJDQLKKyGmPXLf6mELD9PdCKD
        PVOgymky1dt6U6uCVB0RjH5sWM6V2kE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-RmNTZks4MnuVQnz1OAkuxA-1; Thu, 20 May 2021 08:25:50 -0400
X-MC-Unique: RmNTZks4MnuVQnz1OAkuxA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85C638049CA;
        Thu, 20 May 2021 12:25:49 +0000 (UTC)
Received: from max.com (unknown [10.40.195.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D00D760C04;
        Thu, 20 May 2021 12:25:47 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>, cluster-devel@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Jan Kara <jack@suse.cz>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 3/6] gfs2: Add wrappers for accessing journal_info
Date:   Thu, 20 May 2021 14:25:33 +0200
Message-Id: <20210520122536.1596602-4-agruenba@redhat.com>
In-Reply-To: <20210520122536.1596602-1-agruenba@redhat.com>
References: <20210520122536.1596602-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No longer access current->journal_info directly.  We'll use that to
encode additional information in current->journal_info later.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/aops.c    |  6 +++---
 fs/gfs2/bmap.c    | 28 ++++++++++++++--------------
 fs/gfs2/incore.h  | 10 ++++++++++
 fs/gfs2/inode.c   |  2 +-
 fs/gfs2/log.c     |  4 ++--
 fs/gfs2/lops.c    |  2 +-
 fs/gfs2/meta_io.c |  6 +++---
 fs/gfs2/super.c   |  2 +-
 fs/gfs2/trans.c   | 16 ++++++++--------
 9 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 23b5be3db044..50dd1771d00c 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -95,7 +95,7 @@ static int gfs2_writepage(struct page *page, struct writeback_control *wbc)
 
 	if (gfs2_assert_withdraw(sdp, gfs2_glock_is_held_excl(ip->i_gl)))
 		goto out;
-	if (current->journal_info)
+	if (current_trans())
 		goto redirty;
 	return iomap_writepage(page, wbc, &wpc, &gfs2_writeback_ops);
 
@@ -182,7 +182,7 @@ static int gfs2_jdata_writepage(struct page *page, struct writeback_control *wbc
 
 	if (gfs2_assert_withdraw(sdp, gfs2_glock_is_held_excl(ip->i_gl)))
 		goto out;
-	if (PageChecked(page) || current->journal_info)
+	if (PageChecked(page) || current_trans())
 		goto out_ignore;
 	return __gfs2_jdata_writepage(page, wbc);
 
@@ -620,7 +620,7 @@ void adjust_fs_space(struct inode *inode)
  
 static int jdata_set_page_dirty(struct page *page)
 {
-	if (current->journal_info)
+	if (current_trans())
 		SetPageChecked(page);
 	return __set_page_dirty_buffers(page);
 }
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 0bcf11a9987b..2ff501c413f4 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1016,7 +1016,7 @@ static void gfs2_iomap_page_done(struct inode *inode, loff_t pos,
 				 unsigned copied, struct page *page,
 				 struct iomap *iomap)
 {
-	struct gfs2_trans *tr = current->journal_info;
+	struct gfs2_trans *tr = current_trans();
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 
@@ -1099,7 +1099,7 @@ static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
 			}
 		}
 
-		tr = current->journal_info;
+		tr = current_trans();
 		if (tr->tr_num_buf_new)
 			__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
 
@@ -1347,7 +1347,7 @@ int gfs2_alloc_extent(struct inode *inode, u64 lblock, u64 *dblock,
 static int gfs2_block_zero_range(struct inode *inode, loff_t from,
 				 unsigned int length)
 {
-	BUG_ON(current->journal_info);
+	BUG_ON(current_trans());
 	return iomap_zero_range(inode, from, length, NULL, &gfs2_iomap_ops);
 }
 
@@ -1386,7 +1386,7 @@ static int gfs2_journaled_truncate(struct inode *inode, u64 oldsize, u64 newsize
 		truncate_pagecache(inode, oldsize - chunk);
 		oldsize -= chunk;
 
-		tr = current->journal_info;
+		tr = current_trans();
 		if (!test_bit(TR_TOUCHED, &tr->tr_flags))
 			continue;
 
@@ -1447,7 +1447,7 @@ static int trunc_start(struct inode *inode, u64 newsize)
 
 out:
 	brelse(dibh);
-	if (current->journal_info)
+	if (current_trans())
 		gfs2_trans_end(sdp);
 	return error;
 }
@@ -1555,7 +1555,7 @@ static int sweep_bh_for_rgrps(struct gfs2_inode *ip, struct gfs2_holder *rd_gh,
 		   the rgrp. So we estimate. We know it can't be more than
 		   the dinode's i_blocks and we don't want to exceed the
 		   journal flush threshold, sd_log_thresh2. */
-		if (current->journal_info == NULL) {
+		if (!current_trans()) {
 			unsigned int jblocks_rqsted, revokes;
 
 			jblocks_rqsted = rgd->rd_length + RES_DINODE +
@@ -1577,7 +1577,7 @@ static int sweep_bh_for_rgrps(struct gfs2_inode *ip, struct gfs2_holder *rd_gh,
 			down_write(&ip->i_rw_mutex);
 		}
 		/* check if we will exceed the transaction blocks requested */
-		tr = current->journal_info;
+		tr = current_trans();
 		if (tr->tr_num_buf_new + RES_STATFS +
 		    RES_QUOTA >= atomic_read(&sdp->sd_log_thresh2)) {
 			/* We set blks_outside_rgrp to ensure the loop will
@@ -1625,7 +1625,7 @@ static int sweep_bh_for_rgrps(struct gfs2_inode *ip, struct gfs2_holder *rd_gh,
 	if (!ret && blks_outside_rgrp) { /* If buffer still has non-zero blocks
 					    outside the rgrp we just processed,
 					    do it all over again. */
-		if (current->journal_info) {
+		if (current_trans()) {
 			struct buffer_head *dibh;
 
 			ret = gfs2_meta_inode_buffer(ip, &dibh);
@@ -1991,7 +1991,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	}
 
 	if (btotal) {
-		if (current->journal_info == NULL) {
+		if (!current_trans()) {
 			ret = gfs2_trans_begin(sdp, RES_DINODE + RES_STATFS +
 					       RES_QUOTA, 0);
 			if (ret)
@@ -2011,7 +2011,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 out:
 	if (gfs2_holder_initialized(&rd_gh))
 		gfs2_glock_dq_uninit(&rd_gh);
-	if (current->journal_info) {
+	if (current_trans()) {
 		up_write(&ip->i_rw_mutex);
 		gfs2_trans_end(sdp);
 		cond_resched();
@@ -2436,7 +2436,7 @@ static int gfs2_journaled_truncate_range(struct inode *inode, loff_t offset,
 		offset += chunk;
 		length -= chunk;
 
-		tr = current->journal_info;
+		tr = current_trans();
 		if (!test_bit(TR_TOUCHED, &tr->tr_flags))
 			continue;
 
@@ -2501,7 +2501,7 @@ int __gfs2_punch_hole(struct file *file, loff_t offset, loff_t length)
 	}
 
 	if (gfs2_is_jdata(ip)) {
-		BUG_ON(!current->journal_info);
+		BUG_ON(!current_trans());
 		gfs2_journaled_truncate_range(inode, offset, length);
 	} else
 		truncate_pagecache_range(inode, offset, offset + length - 1);
@@ -2509,14 +2509,14 @@ int __gfs2_punch_hole(struct file *file, loff_t offset, loff_t length)
 	file_update_time(file);
 	mark_inode_dirty(inode);
 
-	if (current->journal_info)
+	if (current_trans())
 		gfs2_trans_end(sdp);
 
 	if (!gfs2_is_stuffed(ip))
 		error = punch_hole(ip, offset, length);
 
 out:
-	if (current->journal_info)
+	if (current_trans())
 		gfs2_trans_end(sdp);
 	return error;
 }
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index e6f820f146cb..aa8d1a23132d 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -871,5 +871,15 @@ static inline unsigned gfs2_max_stuffed_size(const struct gfs2_inode *ip)
 	return GFS2_SB(&ip->i_inode)->sd_sb.sb_bsize - sizeof(struct gfs2_dinode);
 }
 
+static inline struct gfs2_trans *current_trans(void)
+{
+	return current->journal_info;
+}
+
+static inline void set_current_trans(struct gfs2_trans *tr)
+{
+	current->journal_info = tr;
+}
+
 #endif /* __INCORE_DOT_H__ */
 
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 6e15434b23ac..1b94cbdc00cc 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1883,7 +1883,7 @@ static int gfs2_setattr_simple(struct inode *inode, struct iattr *attr)
 {
 	int error;
 
-	if (current->journal_info)
+	if (current_trans())
 		return __gfs2_setattr_simple(inode, attr);
 
 	error = gfs2_trans_begin(GFS2_SB(inode), RES_DINODE, 0);
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 42c15cfc0821..3ee29045ab90 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -204,7 +204,7 @@ void gfs2_ail1_flush(struct gfs2_sbd *sdp, struct writeback_control *wbc)
 	ret = 0;
 	if (time_after(jiffies, flush_start + (HZ * 600))) {
 		fs_err(sdp, "Error: In %s for ten minutes! t=%d\n",
-		       __func__, current->journal_info ? 1 : 0);
+		       __func__, current_trans() ? 1 : 0);
 		dump_ail_list(sdp);
 		goto out;
 	}
@@ -971,7 +971,7 @@ static void empty_ail1_list(struct gfs2_sbd *sdp)
 	for (;;) {
 		if (time_after(jiffies, start + (HZ * 600))) {
 			fs_err(sdp, "Error: In %s for 10 minutes! t=%d\n",
-			       __func__, current->journal_info ? 1 : 0);
+			       __func__, current_trans() ? 1 : 0);
 			dump_ail_list(sdp);
 			return;
 		}
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 8ee05d25dfa6..9bd080e5db43 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -43,7 +43,7 @@ void gfs2_pin(struct gfs2_sbd *sdp, struct buffer_head *bh)
 {
 	struct gfs2_bufdata *bd;
 
-	BUG_ON(!current->journal_info);
+	BUG_ON(!current_trans());
 
 	clear_buffer_dirty(bh);
 	if (test_set_buffer_pinned(bh))
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index d68184ebbfdd..f5622393de63 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -294,7 +294,7 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 	bh = *bhp;
 	wait_on_buffer(bh);
 	if (unlikely(!buffer_uptodate(bh))) {
-		struct gfs2_trans *tr = current->journal_info;
+		struct gfs2_trans *tr = current_trans();
 		if (tr && test_bit(TR_TOUCHED, &tr->tr_flags))
 			gfs2_io_error_bh_wd(sdp, bh);
 		brelse(bh);
@@ -321,7 +321,7 @@ int gfs2_meta_wait(struct gfs2_sbd *sdp, struct buffer_head *bh)
 	wait_on_buffer(bh);
 
 	if (!buffer_uptodate(bh)) {
-		struct gfs2_trans *tr = current->journal_info;
+		struct gfs2_trans *tr = current_trans();
 		if (tr && test_bit(TR_TOUCHED, &tr->tr_flags))
 			gfs2_io_error_bh_wd(sdp, bh);
 		return -EIO;
@@ -337,7 +337,7 @@ void gfs2_remove_from_journal(struct buffer_head *bh, int meta)
 	struct address_space *mapping = bh->b_page->mapping;
 	struct gfs2_sbd *sdp = gfs2_mapping2sbd(mapping);
 	struct gfs2_bufdata *bd = bh->b_private;
-	struct gfs2_trans *tr = current->journal_info;
+	struct gfs2_trans *tr = current_trans();
 	int was_pinned = 0;
 
 	if (test_clear_buffer_pinned(bh)) {
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 4d4ceb0b6903..5cb823e58d01 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -557,7 +557,7 @@ static void gfs2_dirty_inode(struct inode *inode, int flags)
 	} else if (WARN_ON_ONCE(ip->i_gl->gl_state != LM_ST_EXCLUSIVE))
 		return;
 
-	if (current->journal_info == NULL) {
+	if (!current_trans()) {
 		ret = gfs2_trans_begin(sdp, RES_DINODE, 0);
 		if (ret) {
 			fs_err(sdp, "dirty_inode: gfs2_trans_begin %d\n", ret);
diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index 63fec11ef2ce..7681fbb12050 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -43,8 +43,8 @@ int __gfs2_trans_begin(struct gfs2_trans *tr, struct gfs2_sbd *sdp,
 {
 	unsigned int extra_revokes;
 
-	if (current->journal_info) {
-		gfs2_print_trans(sdp, current->journal_info);
+	if (current_trans()) {
+		gfs2_print_trans(sdp, current_trans());
 		BUG();
 	}
 	BUG_ON(blocks == 0 && revokes == 0);
@@ -101,7 +101,7 @@ int __gfs2_trans_begin(struct gfs2_trans *tr, struct gfs2_sbd *sdp,
 		return -EROFS;
 	}
 
-	current->journal_info = tr;
+	set_current_trans(tr);
 
 	return 0;
 }
@@ -123,10 +123,10 @@ int gfs2_trans_begin(struct gfs2_sbd *sdp, unsigned int blocks,
 
 void gfs2_trans_end(struct gfs2_sbd *sdp)
 {
-	struct gfs2_trans *tr = current->journal_info;
+	struct gfs2_trans *tr = current_trans();
 	s64 nbuf;
 
-	current->journal_info = NULL;
+	set_current_trans(NULL);
 
 	if (!test_bit(TR_TOUCHED, &tr->tr_flags)) {
 		gfs2_log_release_revokes(sdp, tr->tr_revokes);
@@ -191,7 +191,7 @@ static struct gfs2_bufdata *gfs2_alloc_bufdata(struct gfs2_glock *gl,
  */
 void gfs2_trans_add_data(struct gfs2_glock *gl, struct buffer_head *bh)
 {
-	struct gfs2_trans *tr = current->journal_info;
+	struct gfs2_trans *tr = current_trans();
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
 	struct gfs2_bufdata *bd;
 
@@ -232,7 +232,7 @@ void gfs2_trans_add_meta(struct gfs2_glock *gl, struct buffer_head *bh)
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
 	struct gfs2_bufdata *bd;
 	struct gfs2_meta_header *mh;
-	struct gfs2_trans *tr = current->journal_info;
+	struct gfs2_trans *tr = current_trans();
 	enum gfs2_freeze_state state = atomic_read(&sdp->sd_freeze_state);
 
 	lock_buffer(bh);
@@ -288,7 +288,7 @@ void gfs2_trans_add_meta(struct gfs2_glock *gl, struct buffer_head *bh)
 
 void gfs2_trans_add_revoke(struct gfs2_sbd *sdp, struct gfs2_bufdata *bd)
 {
-	struct gfs2_trans *tr = current->journal_info;
+	struct gfs2_trans *tr = current_trans();
 
 	BUG_ON(!list_empty(&bd->bd_list));
 	gfs2_add_revoke(sdp, bd);
-- 
2.26.3


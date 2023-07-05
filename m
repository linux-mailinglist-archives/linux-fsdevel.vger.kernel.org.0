Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3C4748D27
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjGETH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjGETGa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:06:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79731BEB;
        Wed,  5 Jul 2023 12:04:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88B1E616F5;
        Wed,  5 Jul 2023 19:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331F8C433C7;
        Wed,  5 Jul 2023 19:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583868;
        bh=2TryOk3H01wwKrfbnwqW6IB135YzidSv2NOVrbNXzZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fRUV8hWxJX1yjZ8Zl6BLM4mVDeoIWXgGzp8E1qb/9iLbvK9RfgfSuW305nFZX0DXN
         wxdn8wRuV9dAWghkTs8WQEcYL0BMeg8eXkDi2TrsK+Q8qU0n2PX27QbkloTS0AZ344
         770Ra/iYPlHIyJED/d0TQil+avuL40nnhfYNauXmLSIuQYj2jO6l4Azl946vMBNqe1
         BVg5Ao0HxfFYW4TxCKRBQWyqiUsp8JxbHjFpFJEUMvm1mKka6vfMfoCK8ox8H+1Agj
         tt1EZfrf86yRz1ra2douP46OqDOMpDmOtLr2pUxj/nk6bhOVel9Me0suOXrq3hbpGv
         VSPhKWEGTqZ6Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cluster-devel@redhat.com
Subject: [PATCH v2 47/92] gfs2: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:12 -0400
Message-ID: <20230705190309.579783-45-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/gfs2/acl.c   |  2 +-
 fs/gfs2/bmap.c  | 11 +++++------
 fs/gfs2/dir.c   | 15 ++++++++-------
 fs/gfs2/file.c  |  2 +-
 fs/gfs2/glops.c |  4 ++--
 fs/gfs2/inode.c |  8 ++++----
 fs/gfs2/super.c |  4 ++--
 fs/gfs2/xattr.c |  8 ++++----
 8 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/fs/gfs2/acl.c b/fs/gfs2/acl.c
index a392aa0f041d..443640e6fb9c 100644
--- a/fs/gfs2/acl.c
+++ b/fs/gfs2/acl.c
@@ -142,7 +142,7 @@ int gfs2_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	ret = __gfs2_set_acl(inode, acl, type);
 	if (!ret && mode != inode->i_mode) {
-		inode->i_ctime = current_time(inode);
+		inode_set_ctime_current(inode);
 		inode->i_mode = mode;
 		mark_inode_dirty(inode);
 	}
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 8d611fbcf0bd..45ea63f7167d 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1386,7 +1386,7 @@ static int trunc_start(struct inode *inode, u64 newsize)
 		ip->i_diskflags |= GFS2_DIF_TRUNC_IN_PROG;
 
 	i_size_write(inode, newsize);
-	ip->i_inode.i_mtime = ip->i_inode.i_ctime = current_time(&ip->i_inode);
+	ip->i_inode.i_mtime = inode_set_ctime_current(&ip->i_inode);
 	gfs2_dinode_out(ip, dibh->b_data);
 
 	if (journaled)
@@ -1583,8 +1583,7 @@ static int sweep_bh_for_rgrps(struct gfs2_inode *ip, struct gfs2_holder *rd_gh,
 
 			/* Every transaction boundary, we rewrite the dinode
 			   to keep its di_blocks current in case of failure. */
-			ip->i_inode.i_mtime = ip->i_inode.i_ctime =
-				current_time(&ip->i_inode);
+			ip->i_inode.i_mtime = inode_set_ctime_current(&ip->i_inode);
 			gfs2_trans_add_meta(ip->i_gl, dibh);
 			gfs2_dinode_out(ip, dibh->b_data);
 			brelse(dibh);
@@ -1950,7 +1949,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 		gfs2_statfs_change(sdp, 0, +btotal, 0);
 		gfs2_quota_change(ip, -(s64)btotal, ip->i_inode.i_uid,
 				  ip->i_inode.i_gid);
-		ip->i_inode.i_mtime = ip->i_inode.i_ctime = current_time(&ip->i_inode);
+		ip->i_inode.i_mtime = inode_set_ctime_current(&ip->i_inode);
 		gfs2_trans_add_meta(ip->i_gl, dibh);
 		gfs2_dinode_out(ip, dibh->b_data);
 		up_write(&ip->i_rw_mutex);
@@ -1993,7 +1992,7 @@ static int trunc_end(struct gfs2_inode *ip)
 		gfs2_buffer_clear_tail(dibh, sizeof(struct gfs2_dinode));
 		gfs2_ordered_del_inode(ip);
 	}
-	ip->i_inode.i_mtime = ip->i_inode.i_ctime = current_time(&ip->i_inode);
+	ip->i_inode.i_mtime = inode_set_ctime_current(&ip->i_inode);
 	ip->i_diskflags &= ~GFS2_DIF_TRUNC_IN_PROG;
 
 	gfs2_trans_add_meta(ip->i_gl, dibh);
@@ -2094,7 +2093,7 @@ static int do_grow(struct inode *inode, u64 size)
 		goto do_end_trans;
 
 	truncate_setsize(inode, size);
-	ip->i_inode.i_mtime = ip->i_inode.i_ctime = current_time(&ip->i_inode);
+	ip->i_inode.i_mtime = inode_set_ctime_current(&ip->i_inode);
 	gfs2_trans_add_meta(ip->i_gl, dibh);
 	gfs2_dinode_out(ip, dibh->b_data);
 	brelse(dibh);
diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 54a6d17b8c25..1a2afa88f8be 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -130,7 +130,7 @@ static int gfs2_dir_write_stuffed(struct gfs2_inode *ip, const char *buf,
 	memcpy(dibh->b_data + offset + sizeof(struct gfs2_dinode), buf, size);
 	if (ip->i_inode.i_size < offset + size)
 		i_size_write(&ip->i_inode, offset + size);
-	ip->i_inode.i_mtime = ip->i_inode.i_ctime = current_time(&ip->i_inode);
+	ip->i_inode.i_mtime = inode_set_ctime_current(&ip->i_inode);
 	gfs2_dinode_out(ip, dibh->b_data);
 
 	brelse(dibh);
@@ -227,7 +227,7 @@ static int gfs2_dir_write_data(struct gfs2_inode *ip, const char *buf,
 
 	if (ip->i_inode.i_size < offset + copied)
 		i_size_write(&ip->i_inode, offset + copied);
-	ip->i_inode.i_mtime = ip->i_inode.i_ctime = current_time(&ip->i_inode);
+	ip->i_inode.i_mtime = inode_set_ctime_current(&ip->i_inode);
 
 	gfs2_trans_add_meta(ip->i_gl, dibh);
 	gfs2_dinode_out(ip, dibh->b_data);
@@ -1814,7 +1814,7 @@ int gfs2_dir_add(struct inode *inode, const struct qstr *name,
 			gfs2_inum_out(nip, dent);
 			dent->de_type = cpu_to_be16(IF2DT(nip->i_inode.i_mode));
 			dent->de_rahead = cpu_to_be16(gfs2_inode_ra_len(nip));
-			tv = current_time(&ip->i_inode);
+			tv = inode_set_ctime_current(&ip->i_inode);
 			if (ip->i_diskflags & GFS2_DIF_EXHASH) {
 				leaf = (struct gfs2_leaf *)bh->b_data;
 				be16_add_cpu(&leaf->lf_entries, 1);
@@ -1825,7 +1825,7 @@ int gfs2_dir_add(struct inode *inode, const struct qstr *name,
 			da->bh = NULL;
 			brelse(bh);
 			ip->i_entries++;
-			ip->i_inode.i_mtime = ip->i_inode.i_ctime = tv;
+			ip->i_inode.i_mtime = tv;
 			if (S_ISDIR(nip->i_inode.i_mode))
 				inc_nlink(&ip->i_inode);
 			mark_inode_dirty(inode);
@@ -1876,7 +1876,7 @@ int gfs2_dir_del(struct gfs2_inode *dip, const struct dentry *dentry)
 	const struct qstr *name = &dentry->d_name;
 	struct gfs2_dirent *dent, *prev = NULL;
 	struct buffer_head *bh;
-	struct timespec64 tv = current_time(&dip->i_inode);
+	struct timespec64 tv;
 
 	/* Returns _either_ the entry (if its first in block) or the
 	   previous entry otherwise */
@@ -1896,6 +1896,7 @@ int gfs2_dir_del(struct gfs2_inode *dip, const struct dentry *dentry)
 	}
 
 	dirent_del(dip, bh, prev, dent);
+	tv = inode_set_ctime_current(&dip->i_inode);
 	if (dip->i_diskflags & GFS2_DIF_EXHASH) {
 		struct gfs2_leaf *leaf = (struct gfs2_leaf *)bh->b_data;
 		u16 entries = be16_to_cpu(leaf->lf_entries);
@@ -1910,7 +1911,7 @@ int gfs2_dir_del(struct gfs2_inode *dip, const struct dentry *dentry)
 	if (!dip->i_entries)
 		gfs2_consist_inode(dip);
 	dip->i_entries--;
-	dip->i_inode.i_mtime = dip->i_inode.i_ctime = tv;
+	dip->i_inode.i_mtime =  tv;
 	if (d_is_dir(dentry))
 		drop_nlink(&dip->i_inode);
 	mark_inode_dirty(&dip->i_inode);
@@ -1951,7 +1952,7 @@ int gfs2_dir_mvino(struct gfs2_inode *dip, const struct qstr *filename,
 	dent->de_type = cpu_to_be16(new_type);
 	brelse(bh);
 
-	dip->i_inode.i_mtime = dip->i_inode.i_ctime = current_time(&dip->i_inode);
+	dip->i_inode.i_mtime = inode_set_ctime_current(&dip->i_inode);
 	mark_inode_dirty_sync(&dip->i_inode);
 	return 0;
 }
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 1bf3c4453516..ecbfbc6df621 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -260,7 +260,7 @@ static int do_gfs2_set_flags(struct inode *inode, u32 reqflags, u32 mask)
 	error = gfs2_meta_inode_buffer(ip, &bh);
 	if (error)
 		goto out_trans_end;
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	gfs2_trans_add_meta(ip->i_gl, bh);
 	ip->i_diskflags = new_flags;
 	gfs2_dinode_out(ip, bh->b_data);
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 54319328b16b..aecdac3cfbe1 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -437,8 +437,8 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 		inode->i_atime = atime;
 	inode->i_mtime.tv_sec = be64_to_cpu(str->di_mtime);
 	inode->i_mtime.tv_nsec = be32_to_cpu(str->di_mtime_nsec);
-	inode->i_ctime.tv_sec = be64_to_cpu(str->di_ctime);
-	inode->i_ctime.tv_nsec = be32_to_cpu(str->di_ctime_nsec);
+	inode_set_ctime(inode, be64_to_cpu(str->di_ctime),
+			be32_to_cpu(str->di_ctime_nsec));
 
 	ip->i_goal = be64_to_cpu(str->di_goal_meta);
 	ip->i_generation = be64_to_cpu(str->di_generation);
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 17c994a0c0d0..2ded6c813f20 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -690,7 +690,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	set_nlink(inode, S_ISDIR(mode) ? 2 : 1);
 	inode->i_rdev = dev;
 	inode->i_size = size;
-	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 	munge_mode_uid_gid(dip, inode);
 	check_and_update_goal(dip);
 	ip->i_goal = dip->i_goal;
@@ -1029,7 +1029,7 @@ static int gfs2_link(struct dentry *old_dentry, struct inode *dir,
 
 	gfs2_trans_add_meta(ip->i_gl, dibh);
 	inc_nlink(&ip->i_inode);
-	ip->i_inode.i_ctime = current_time(&ip->i_inode);
+	inode_set_ctime_current(&ip->i_inode);
 	ihold(inode);
 	d_instantiate(dentry, inode);
 	mark_inode_dirty(inode);
@@ -1114,7 +1114,7 @@ static int gfs2_unlink_inode(struct gfs2_inode *dip,
 		return error;
 
 	ip->i_entries = 0;
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	if (S_ISDIR(inode->i_mode))
 		clear_nlink(inode);
 	else
@@ -1371,7 +1371,7 @@ static int update_moved_ino(struct gfs2_inode *ip, struct gfs2_inode *ndip,
 	if (dir_rename)
 		return gfs2_dir_mvino(ip, &gfs2_qdotdot, ndip, DT_DIR);
 
-	ip->i_inode.i_ctime = current_time(&ip->i_inode);
+	inode_set_ctime_current(&ip->i_inode);
 	mark_inode_dirty_sync(&ip->i_inode);
 	return 0;
 }
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 9f4d5d6549ee..ec0296b35dfe 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -412,7 +412,7 @@ void gfs2_dinode_out(const struct gfs2_inode *ip, void *buf)
 	str->di_blocks = cpu_to_be64(gfs2_get_inode_blocks(inode));
 	str->di_atime = cpu_to_be64(inode->i_atime.tv_sec);
 	str->di_mtime = cpu_to_be64(inode->i_mtime.tv_sec);
-	str->di_ctime = cpu_to_be64(inode->i_ctime.tv_sec);
+	str->di_ctime = cpu_to_be64(inode_get_ctime(inode).tv_sec);
 
 	str->di_goal_meta = cpu_to_be64(ip->i_goal);
 	str->di_goal_data = cpu_to_be64(ip->i_goal);
@@ -429,7 +429,7 @@ void gfs2_dinode_out(const struct gfs2_inode *ip, void *buf)
 	str->di_eattr = cpu_to_be64(ip->i_eattr);
 	str->di_atime_nsec = cpu_to_be32(inode->i_atime.tv_nsec);
 	str->di_mtime_nsec = cpu_to_be32(inode->i_mtime.tv_nsec);
-	str->di_ctime_nsec = cpu_to_be32(inode->i_ctime.tv_nsec);
+	str->di_ctime_nsec = cpu_to_be32(inode_get_ctime(inode).tv_nsec);
 }
 
 /**
diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index 93b36d026bb4..4fea70c0fe3d 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -311,7 +311,7 @@ static int ea_dealloc_unstuffed(struct gfs2_inode *ip, struct buffer_head *bh,
 		ea->ea_num_ptrs = 0;
 	}
 
-	ip->i_inode.i_ctime = current_time(&ip->i_inode);
+	inode_set_ctime_current(&ip->i_inode);
 	__mark_inode_dirty(&ip->i_inode, I_DIRTY_DATASYNC);
 
 	gfs2_trans_end(sdp);
@@ -763,7 +763,7 @@ static int ea_alloc_skeleton(struct gfs2_inode *ip, struct gfs2_ea_request *er,
 	if (error)
 		goto out_end_trans;
 
-	ip->i_inode.i_ctime = current_time(&ip->i_inode);
+	inode_set_ctime_current(&ip->i_inode);
 	__mark_inode_dirty(&ip->i_inode, I_DIRTY_DATASYNC);
 
 out_end_trans:
@@ -888,7 +888,7 @@ static int ea_set_simple_noalloc(struct gfs2_inode *ip, struct buffer_head *bh,
 	if (es->es_el)
 		ea_set_remove_stuffed(ip, es->es_el);
 
-	ip->i_inode.i_ctime = current_time(&ip->i_inode);
+	inode_set_ctime_current(&ip->i_inode);
 	__mark_inode_dirty(&ip->i_inode, I_DIRTY_DATASYNC);
 
 	gfs2_trans_end(GFS2_SB(&ip->i_inode));
@@ -1106,7 +1106,7 @@ static int ea_remove_stuffed(struct gfs2_inode *ip, struct gfs2_ea_location *el)
 		ea->ea_type = GFS2_EATYPE_UNUSED;
 	}
 
-	ip->i_inode.i_ctime = current_time(&ip->i_inode);
+	inode_set_ctime_current(&ip->i_inode);
 	__mark_inode_dirty(&ip->i_inode, I_DIRTY_DATASYNC);
 
 	gfs2_trans_end(GFS2_SB(&ip->i_inode));
-- 
2.41.0


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B58F7B19F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjI1LHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjI1LFo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:05:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8751C1712;
        Thu, 28 Sep 2023 04:04:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A16C433CA;
        Thu, 28 Sep 2023 11:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899099;
        bh=pl32liCrwkmVuPM2owBmJWkMCk7GZeKtnHRbBp5Lo/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VAFuf/Misyc0YMMydNEaWArEJTkw1IagAmZgBgYRh1x/3fc+m17Gu5lsLBT5ItjHt
         k11vJ15aA/JPXWYBh3dQkiXn4f0jkvkY2Guue18UndWxmU187oM6TCwLRXKjLtc8AR
         lEV+phJcSI7abESMU2UrkzwxF5chFXvUYSG2Jjml/IXTiu4eICIsuJyB9JY1ly9fK3
         /rGqj3z5J97GRYyyf8GiNc3k+ZsqRwKddG9uIgIaqbiuA7KalhPSUJ9RMsKwW0i9CW
         UtKIhLeamE9wvNMIuNUpKyYN8+lOj439DLcL0sgZeboL8Ls1Mju8GliIT+39gfVh3O
         iFwQRrU1dgVTA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gfs2@lists.linux.dev
Subject: [PATCH 39/87] fs/gfs2: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:48 -0400
Message-ID: <20230928110413.33032-38-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/gfs2/bmap.c  | 10 +++++-----
 fs/gfs2/dir.c   | 10 +++++-----
 fs/gfs2/glops.c | 11 ++++++-----
 fs/gfs2/inode.c |  7 ++++---
 fs/gfs2/quota.c |  2 +-
 fs/gfs2/super.c |  8 ++++----
 6 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index ef7017fb6951..011cd992e0e6 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1386,7 +1386,7 @@ static int trunc_start(struct inode *inode, u64 newsize)
 		ip->i_diskflags |= GFS2_DIF_TRUNC_IN_PROG;
 
 	i_size_write(inode, newsize);
-	ip->i_inode.i_mtime = inode_set_ctime_current(&ip->i_inode);
+	inode_set_mtime_to_ts(&ip->i_inode, inode_set_ctime_current(&ip->i_inode));
 	gfs2_dinode_out(ip, dibh->b_data);
 
 	if (journaled)
@@ -1583,7 +1583,7 @@ static int sweep_bh_for_rgrps(struct gfs2_inode *ip, struct gfs2_holder *rd_gh,
 
 			/* Every transaction boundary, we rewrite the dinode
 			   to keep its di_blocks current in case of failure. */
-			ip->i_inode.i_mtime = inode_set_ctime_current(&ip->i_inode);
+			inode_set_mtime_to_ts(&ip->i_inode, inode_set_ctime_current(&ip->i_inode));
 			gfs2_trans_add_meta(ip->i_gl, dibh);
 			gfs2_dinode_out(ip, dibh->b_data);
 			brelse(dibh);
@@ -1949,7 +1949,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 		gfs2_statfs_change(sdp, 0, +btotal, 0);
 		gfs2_quota_change(ip, -(s64)btotal, ip->i_inode.i_uid,
 				  ip->i_inode.i_gid);
-		ip->i_inode.i_mtime = inode_set_ctime_current(&ip->i_inode);
+		inode_set_mtime_to_ts(&ip->i_inode, inode_set_ctime_current(&ip->i_inode));
 		gfs2_trans_add_meta(ip->i_gl, dibh);
 		gfs2_dinode_out(ip, dibh->b_data);
 		up_write(&ip->i_rw_mutex);
@@ -1992,7 +1992,7 @@ static int trunc_end(struct gfs2_inode *ip)
 		gfs2_buffer_clear_tail(dibh, sizeof(struct gfs2_dinode));
 		gfs2_ordered_del_inode(ip);
 	}
-	ip->i_inode.i_mtime = inode_set_ctime_current(&ip->i_inode);
+	inode_set_mtime_to_ts(&ip->i_inode, inode_set_ctime_current(&ip->i_inode));
 	ip->i_diskflags &= ~GFS2_DIF_TRUNC_IN_PROG;
 
 	gfs2_trans_add_meta(ip->i_gl, dibh);
@@ -2093,7 +2093,7 @@ static int do_grow(struct inode *inode, u64 size)
 		goto do_end_trans;
 
 	truncate_setsize(inode, size);
-	ip->i_inode.i_mtime = inode_set_ctime_current(&ip->i_inode);
+	inode_set_mtime_to_ts(&ip->i_inode, inode_set_ctime_current(&ip->i_inode));
 	gfs2_trans_add_meta(ip->i_gl, dibh);
 	gfs2_dinode_out(ip, dibh->b_data);
 	brelse(dibh);
diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 1a2afa88f8be..61ddd03ea111 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -130,7 +130,7 @@ static int gfs2_dir_write_stuffed(struct gfs2_inode *ip, const char *buf,
 	memcpy(dibh->b_data + offset + sizeof(struct gfs2_dinode), buf, size);
 	if (ip->i_inode.i_size < offset + size)
 		i_size_write(&ip->i_inode, offset + size);
-	ip->i_inode.i_mtime = inode_set_ctime_current(&ip->i_inode);
+	inode_set_mtime_to_ts(&ip->i_inode, inode_set_ctime_current(&ip->i_inode));
 	gfs2_dinode_out(ip, dibh->b_data);
 
 	brelse(dibh);
@@ -227,7 +227,7 @@ static int gfs2_dir_write_data(struct gfs2_inode *ip, const char *buf,
 
 	if (ip->i_inode.i_size < offset + copied)
 		i_size_write(&ip->i_inode, offset + copied);
-	ip->i_inode.i_mtime = inode_set_ctime_current(&ip->i_inode);
+	inode_set_mtime_to_ts(&ip->i_inode, inode_set_ctime_current(&ip->i_inode));
 
 	gfs2_trans_add_meta(ip->i_gl, dibh);
 	gfs2_dinode_out(ip, dibh->b_data);
@@ -1825,7 +1825,7 @@ int gfs2_dir_add(struct inode *inode, const struct qstr *name,
 			da->bh = NULL;
 			brelse(bh);
 			ip->i_entries++;
-			ip->i_inode.i_mtime = tv;
+			inode_set_mtime_to_ts(&ip->i_inode, tv);
 			if (S_ISDIR(nip->i_inode.i_mode))
 				inc_nlink(&ip->i_inode);
 			mark_inode_dirty(inode);
@@ -1911,7 +1911,7 @@ int gfs2_dir_del(struct gfs2_inode *dip, const struct dentry *dentry)
 	if (!dip->i_entries)
 		gfs2_consist_inode(dip);
 	dip->i_entries--;
-	dip->i_inode.i_mtime =  tv;
+	inode_set_mtime_to_ts(&dip->i_inode, tv);
 	if (d_is_dir(dentry))
 		drop_nlink(&dip->i_inode);
 	mark_inode_dirty(&dip->i_inode);
@@ -1952,7 +1952,7 @@ int gfs2_dir_mvino(struct gfs2_inode *dip, const struct qstr *filename,
 	dent->de_type = cpu_to_be16(new_type);
 	brelse(bh);
 
-	dip->i_inode.i_mtime = inode_set_ctime_current(&dip->i_inode);
+	inode_set_mtime_to_ts(&dip->i_inode, inode_set_ctime_current(&dip->i_inode));
 	mark_inode_dirty_sync(&dip->i_inode);
 	return 0;
 }
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index f41ca89d216b..e7d334c277a1 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -403,7 +403,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	const struct gfs2_dinode *str = buf;
-	struct timespec64 atime;
+	struct timespec64 atime, iatime;
 	u16 height, depth;
 	umode_t mode = be32_to_cpu(str->di_mode);
 	struct inode *inode = &ip->i_inode;
@@ -433,10 +433,11 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	gfs2_set_inode_blocks(inode, be64_to_cpu(str->di_blocks));
 	atime.tv_sec = be64_to_cpu(str->di_atime);
 	atime.tv_nsec = be32_to_cpu(str->di_atime_nsec);
-	if (timespec64_compare(&inode->i_atime, &atime) < 0)
-		inode->i_atime = atime;
-	inode->i_mtime.tv_sec = be64_to_cpu(str->di_mtime);
-	inode->i_mtime.tv_nsec = be32_to_cpu(str->di_mtime_nsec);
+	iatime = inode_get_atime(inode);
+	if (timespec64_compare(&iatime, &atime) < 0)
+		inode_set_atime_to_ts(inode, atime);
+	inode_set_mtime(inode, be64_to_cpu(str->di_mtime),
+			be32_to_cpu(str->di_mtime_nsec));
 	inode_set_ctime(inode, be64_to_cpu(str->di_ctime),
 			be32_to_cpu(str->di_ctime_nsec));
 
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 0eac04507904..6d15868fcd48 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -185,8 +185,9 @@ struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned int type,
 		set_bit(GLF_INSTANTIATE_NEEDED, &ip->i_gl->gl_flags);
 
 		/* Lowest possible timestamp; will be overwritten in gfs2_dinode_in. */
-		inode->i_atime.tv_sec = 1LL << (8 * sizeof(inode->i_atime.tv_sec) - 1);
-		inode->i_atime.tv_nsec = 0;
+		inode_set_atime(inode,
+				1LL << (8 * sizeof(inode_get_atime(inode).tv_sec) - 1),
+				0);
 
 		glock_set_object(ip->i_gl, ip);
 
@@ -696,7 +697,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	set_nlink(inode, S_ISDIR(mode) ? 2 : 1);
 	inode->i_rdev = dev;
 	inode->i_size = size;
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	munge_mode_uid_gid(dip, inode);
 	check_and_update_goal(dip);
 	ip->i_goal = dip->i_goal;
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 171b2713d2e5..d9854aece15b 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -886,7 +886,7 @@ static int gfs2_adjust_quota(struct gfs2_sbd *sdp, loff_t loc,
 		size = loc + sizeof(struct gfs2_quota);
 		if (size > inode->i_size)
 			i_size_write(inode, size);
-		inode->i_mtime = inode_set_ctime_current(inode);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 		mark_inode_dirty(inode);
 		set_bit(QDF_REFRESH, &qd->qd_flags);
 	}
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 02d93da21b2b..f5ee6c451bef 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -410,8 +410,8 @@ void gfs2_dinode_out(const struct gfs2_inode *ip, void *buf)
 	str->di_nlink = cpu_to_be32(inode->i_nlink);
 	str->di_size = cpu_to_be64(i_size_read(inode));
 	str->di_blocks = cpu_to_be64(gfs2_get_inode_blocks(inode));
-	str->di_atime = cpu_to_be64(inode->i_atime.tv_sec);
-	str->di_mtime = cpu_to_be64(inode->i_mtime.tv_sec);
+	str->di_atime = cpu_to_be64(inode_get_atime(inode).tv_sec);
+	str->di_mtime = cpu_to_be64(inode_get_mtime(inode).tv_sec);
 	str->di_ctime = cpu_to_be64(inode_get_ctime(inode).tv_sec);
 
 	str->di_goal_meta = cpu_to_be64(ip->i_goal);
@@ -427,8 +427,8 @@ void gfs2_dinode_out(const struct gfs2_inode *ip, void *buf)
 	str->di_entries = cpu_to_be32(ip->i_entries);
 
 	str->di_eattr = cpu_to_be64(ip->i_eattr);
-	str->di_atime_nsec = cpu_to_be32(inode->i_atime.tv_nsec);
-	str->di_mtime_nsec = cpu_to_be32(inode->i_mtime.tv_nsec);
+	str->di_atime_nsec = cpu_to_be32(inode_get_atime(inode).tv_nsec);
+	str->di_mtime_nsec = cpu_to_be32(inode_get_mtime(inode).tv_nsec);
 	str->di_ctime_nsec = cpu_to_be32(inode_get_ctime(inode).tv_nsec);
 }
 
-- 
2.41.0


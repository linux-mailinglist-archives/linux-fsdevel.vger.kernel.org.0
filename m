Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68041772F7F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 21:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjHGTlk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 15:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjHGTl3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:41:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8AC1BEF;
        Mon,  7 Aug 2023 12:40:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2408621D2;
        Mon,  7 Aug 2023 19:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BF7C433AB;
        Mon,  7 Aug 2023 19:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691437179;
        bh=gkJEj5WuPn1YoOjO7KBBeS926Ai36nzHHhtaOzFOExo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=U2JE3yj2BX8fXCafrlPQzZGpZMFLvsLj/nn7ICNmsgrPM7QZrw5TLTAnaVR7hmLoH
         Mqs2TOutOSYI+v9pyOyXDdyU760Pk+U02cOhgUyiCh7url+3MQ0QkTU4AuU3dzY8fa
         3RLxbiFfjYOsn2+T9i2DWYM2K5U7AGf40Yaek2aXt8ITKeSyrh20YZZqYJmLXly09C
         IWckTDcl+oOGYnBZhbvvXv9p7UjkoCMqCrBBMrYU6aDD2LawVk1w7p1wXo1Ft5/CJB
         So0jmwYkrWnpNrCfQf/c7Ox7yZWzXX2gR7j77bPsx2Z5zIKPFT7kvupiuKamNcu8a9
         ryH8lhnB4ROeA==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Mon, 07 Aug 2023 15:38:39 -0400
Subject: [PATCH v7 08/13] fs: drop the timespec64 argument from update_time
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mgctime-v7-8-d1dec143a704@kernel.org>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
In-Reply-To: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Tyler Hicks <code@tyhicks.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Hans de Goede <hdegoede@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mtd@lists.infradead.org, linux-mm@kvack.org,
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11305; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=gkJEj5WuPn1YoOjO7KBBeS926Ai36nzHHhtaOzFOExo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk0Ug+GjxPCaxOL3/Hh96G4qx6En6kK7pSs7PBS
 +qgeev2ZmKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZNFIPgAKCRAADmhBGVaC
 FfZlD/wOK+NhIWXwGOoqV8eNwYf9Z6j7FOlM9B23dAE8nfaM0JHbFLI/5nyNdIbKZZKU+qm4VpQ
 00Hq8dO4sLmPsk/onWXDmVdxXxHL0hmWQGSodM0gZOX1/lJaOPFNw+XSeywsA8zlk2RJR0dFYWH
 assHOlJf81I9YqU0qjocYICQm6WqeZGM0o3GKsTI3V+qEVtWfPG7VRzFqdye2m6aMwQeFPldshG
 Jpo2sVNKdT3qfXPhBOGnKPSijwMqE41+bfnRLhWInom7CUN6L8nXjXUlDBBhTSareLtKc+aurKB
 27qlSHIt85hqAtN03DN/caRLKX17nBDRrO0ZzK0Fp4oZMh6LGKd/c1R9FQQFmAD/TjabTb+l/3b
 eU7MkNi9FnnByp8BadvQSVTMySrQKtWKKwzPflPPX1N5Djtt1EfNT3peRZ3dsZWOqfig+H3fRnF
 hsU9zK1WZhl2YNdHupE3VVziL+vU1Bl3eXxZk6V8mbe2PChqgJWPERKEaLcSSYFNbPfk14kPh3M
 56gMDOEvkXdddTr+aVR5PSe5qGDiCmmIsHUlGqDjctg2SBYuP6UVUV2fB1JGrgWc4FH20rmX3Hb
 dkC163IAkUr2yHQJKFcsCOltGpKMq9EpVmQAeNqKANIzTLbXmslUphOJvQ5ITe7grLXOMRlm6Vz
 YQKDvW2mH8JkK4A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that all of the update_time operations are prepared for it, we can
drop the timespec64 argument from the update_time operation. Do that and
remove it from some associated functions like inode_update_time and
inode_needs_update_time.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/bad_inode.c           |  3 +--
 fs/btrfs/inode.c         |  3 +--
 fs/btrfs/volumes.c       |  4 +---
 fs/fat/fat.h             |  3 +--
 fs/fat/misc.c            |  2 +-
 fs/gfs2/inode.c          |  3 +--
 fs/inode.c               | 30 +++++++++++++-----------------
 fs/overlayfs/inode.c     |  2 +-
 fs/overlayfs/overlayfs.h |  2 +-
 fs/ubifs/file.c          |  3 +--
 fs/ubifs/ubifs.h         |  2 +-
 fs/xfs/xfs_iops.c        |  1 -
 include/linux/fs.h       |  4 ++--
 13 files changed, 25 insertions(+), 37 deletions(-)

diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 6e21f7412a85..83f9566c973b 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -133,8 +133,7 @@ static int bad_inode_fiemap(struct inode *inode,
 	return -EIO;
 }
 
-static int bad_inode_update_time(struct inode *inode, struct timespec64 *time,
-				 int flags)
+static int bad_inode_update_time(struct inode *inode, int flags)
 {
 	return -EIO;
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d52e7d64570a..0964c66411a1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6059,8 +6059,7 @@ static int btrfs_dirty_inode(struct btrfs_inode *inode)
  * This is a copy of file_update_time.  We need this so we can return error on
  * ENOSPC for updating the inode in the case of file write and mmap writes.
  */
-static int btrfs_update_time(struct inode *inode, struct timespec64 *now,
-			     int flags)
+static int btrfs_update_time(struct inode *inode, int flags)
 {
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	bool dirty = flags & ~S_VERSION;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 73f9ea7672db..264c71590370 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1917,15 +1917,13 @@ static int btrfs_add_dev_item(struct btrfs_trans_handle *trans,
 static void update_dev_time(const char *device_path)
 {
 	struct path path;
-	struct timespec64 now;
 	int ret;
 
 	ret = kern_path(device_path, LOOKUP_FOLLOW, &path);
 	if (ret)
 		return;
 
-	now = current_time(d_inode(path.dentry));
-	inode_update_time(d_inode(path.dentry), &now, S_MTIME | S_CTIME | S_VERSION);
+	inode_update_time(d_inode(path.dentry), S_MTIME | S_CTIME | S_VERSION);
 	path_put(&path);
 }
 
diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index e3b690b48e3e..66cf4778cf3b 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -460,8 +460,7 @@ extern struct timespec64 fat_truncate_mtime(const struct msdos_sb_info *sbi,
 					    const struct timespec64 *ts);
 extern int fat_truncate_time(struct inode *inode, struct timespec64 *now,
 			     int flags);
-extern int fat_update_time(struct inode *inode, struct timespec64 *now,
-			   int flags);
+extern int fat_update_time(struct inode *inode, int flags);
 extern int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs);
 
 int fat_cache_init(void);
diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index 8cab87145d63..080a5035483f 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -339,7 +339,7 @@ int fat_truncate_time(struct inode *inode, struct timespec64 *now, int flags)
 }
 EXPORT_SYMBOL_GPL(fat_truncate_time);
 
-int fat_update_time(struct inode *inode, struct timespec64 *now, int flags)
+int fat_update_time(struct inode *inode, int flags)
 {
 	int dirty_flags = 0;
 
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index f1f04557aa21..a21ac41d6669 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2139,8 +2139,7 @@ loff_t gfs2_seek_hole(struct file *file, loff_t offset)
 	return vfs_setpos(file, ret, inode->i_sb->s_maxbytes);
 }
 
-static int gfs2_update_time(struct inode *inode, struct timespec64 *time,
-			    int flags)
+static int gfs2_update_time(struct inode *inode, int flags)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_glock *gl = ip->i_gl;
diff --git a/fs/inode.c b/fs/inode.c
index e07e45f6cd01..e50d94a136fe 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1958,10 +1958,10 @@ EXPORT_SYMBOL(generic_update_time);
  * This does the actual work of updating an inodes time or version.  Must have
  * had called mnt_want_write() before calling this.
  */
-int inode_update_time(struct inode *inode, struct timespec64 *time, int flags)
+int inode_update_time(struct inode *inode, int flags)
 {
 	if (inode->i_op->update_time)
-		return inode->i_op->update_time(inode, time, flags);
+		return inode->i_op->update_time(inode, flags);
 	generic_update_time(inode, flags);
 	return 0;
 }
@@ -2015,7 +2015,6 @@ void touch_atime(const struct path *path)
 {
 	struct vfsmount *mnt = path->mnt;
 	struct inode *inode = d_inode(path->dentry);
-	struct timespec64 now;
 
 	if (!atime_needs_update(path, inode))
 		return;
@@ -2034,8 +2033,7 @@ void touch_atime(const struct path *path)
 	 * We may also fail on filesystems that have the ability to make parts
 	 * of the fs read only, e.g. subvolumes in Btrfs.
 	 */
-	now = current_time(inode);
-	inode_update_time(inode, &now, S_ATIME);
+	inode_update_time(inode, S_ATIME);
 	__mnt_drop_write(mnt);
 skip_update:
 	sb_end_write(inode->i_sb);
@@ -2120,20 +2118,21 @@ int file_remove_privs(struct file *file)
 }
 EXPORT_SYMBOL(file_remove_privs);
 
-static int inode_needs_update_time(struct inode *inode, struct timespec64 *now)
+static int inode_needs_update_time(struct inode *inode)
 {
 	int sync_it = 0;
+	struct timespec64 now = current_time(inode);
 	struct timespec64 ctime;
 
 	/* First try to exhaust all avenues to not sync */
 	if (IS_NOCMTIME(inode))
 		return 0;
 
-	if (!timespec64_equal(&inode->i_mtime, now))
+	if (!timespec64_equal(&inode->i_mtime, &now))
 		sync_it = S_MTIME;
 
 	ctime = inode_get_ctime(inode);
-	if (!timespec64_equal(&ctime, now))
+	if (!timespec64_equal(&ctime, &now))
 		sync_it |= S_CTIME;
 
 	if (IS_I_VERSION(inode) && inode_iversion_need_inc(inode))
@@ -2142,15 +2141,14 @@ static int inode_needs_update_time(struct inode *inode, struct timespec64 *now)
 	return sync_it;
 }
 
-static int __file_update_time(struct file *file, struct timespec64 *now,
-			int sync_mode)
+static int __file_update_time(struct file *file, int sync_mode)
 {
 	int ret = 0;
 	struct inode *inode = file_inode(file);
 
 	/* try to update time settings */
 	if (!__mnt_want_write_file(file)) {
-		ret = inode_update_time(inode, now, sync_mode);
+		ret = inode_update_time(inode, sync_mode);
 		__mnt_drop_write_file(file);
 	}
 
@@ -2175,13 +2173,12 @@ int file_update_time(struct file *file)
 {
 	int ret;
 	struct inode *inode = file_inode(file);
-	struct timespec64 now = current_time(inode);
 
-	ret = inode_needs_update_time(inode, &now);
+	ret = inode_needs_update_time(inode);
 	if (ret <= 0)
 		return ret;
 
-	return __file_update_time(file, &now, ret);
+	return __file_update_time(file, ret);
 }
 EXPORT_SYMBOL(file_update_time);
 
@@ -2204,7 +2201,6 @@ static int file_modified_flags(struct file *file, int flags)
 {
 	int ret;
 	struct inode *inode = file_inode(file);
-	struct timespec64 now = current_time(inode);
 
 	/*
 	 * Clear the security bits if the process is not being run by root.
@@ -2217,13 +2213,13 @@ static int file_modified_flags(struct file *file, int flags)
 	if (unlikely(file->f_mode & FMODE_NOCMTIME))
 		return 0;
 
-	ret = inode_needs_update_time(inode, &now);
+	ret = inode_needs_update_time(inode);
 	if (ret <= 0)
 		return ret;
 	if (flags & IOCB_NOWAIT)
 		return -EAGAIN;
 
-	return __file_update_time(file, &now, ret);
+	return __file_update_time(file, ret);
 }
 
 /**
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index a63e57447be9..f22e27b78025 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -693,7 +693,7 @@ int ovl_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 }
 #endif
 
-int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags)
+int ovl_update_time(struct inode *inode, int flags)
 {
 	if (flags & S_ATIME) {
 		struct ovl_fs *ofs = inode->i_sb->s_fs_info;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 9402591f12aa..8bbe6173bef4 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -665,7 +665,7 @@ static inline struct posix_acl *ovl_get_acl_path(const struct path *path,
 }
 #endif
 
-int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags);
+int ovl_update_time(struct inode *inode, int flags);
 bool ovl_is_private_xattr(struct super_block *sb, const char *name);
 
 struct ovl_inode_params {
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 2d0178922e19..eae4001ac92f 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1378,8 +1378,7 @@ static inline int mctime_update_needed(const struct inode *inode,
  *
  * This function updates time of the inode.
  */
-int ubifs_update_time(struct inode *inode, struct timespec64 *time,
-			     int flags)
+int ubifs_update_time(struct inode *inode, int flags)
 {
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 4c36044140e7..ebb3ad6b5e7e 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -2027,7 +2027,7 @@ int ubifs_calc_dark(const struct ubifs_info *c, int spc);
 int ubifs_fsync(struct file *file, loff_t start, loff_t end, int datasync);
 int ubifs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *attr);
-int ubifs_update_time(struct inode *inode, struct timespec64 *time, int flags);
+int ubifs_update_time(struct inode *inode, int flags);
 
 /* dir.c */
 struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 72d18e7840f5..c73529f77bac 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1029,7 +1029,6 @@ xfs_vn_setattr(
 STATIC int
 xfs_vn_update_time(
 	struct inode		*inode,
-	struct timespec64	*now,
 	int			flags)
 {
 	struct xfs_inode	*ip = XFS_I(inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bb3c2c4f871f..a83313f90fe3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1887,7 +1887,7 @@ struct inode_operations {
 	ssize_t (*listxattr) (struct dentry *, char *, size_t);
 	int (*fiemap)(struct inode *, struct fiemap_extent_info *, u64 start,
 		      u64 len);
-	int (*update_time)(struct inode *, struct timespec64 *, int);
+	int (*update_time)(struct inode *, int);
 	int (*atomic_open)(struct inode *, struct dentry *,
 			   struct file *, unsigned open_flag,
 			   umode_t create_mode);
@@ -2237,7 +2237,7 @@ enum file_time_flags {
 
 extern bool atime_needs_update(const struct path *, struct inode *);
 extern void touch_atime(const struct path *);
-int inode_update_time(struct inode *inode, struct timespec64 *time, int flags);
+int inode_update_time(struct inode *inode, int flags);
 
 static inline void file_accessed(struct file *file)
 {

-- 
2.41.0


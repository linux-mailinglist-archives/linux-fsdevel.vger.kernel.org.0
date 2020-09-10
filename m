Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6288E2651CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 23:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgIJVCd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 17:02:33 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:23583 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731145AbgIJOjx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599748793; x=1631284793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WEuMgO7oA901+riDQM55eHZey7VpL5WGiX8ND1wzHgA=;
  b=XVXUa/blq93D8diVUsMQ3vdSHlDQ1bd73GFudxnqR7kNaNUiFvn3Ywh0
   /abkXLtkuomtXzdn4cXAmV0JTTv5xpRgcMxCLDtWZRgQoB+vfO0kryhnN
   jcAYdxrK+d1gb5e7ktBKazc/U6pM2GiqA2KM3a6uJvqiVdw77K3v31tnR
   1hfA7dxobGDDAMwqX+gCKrAhDJy251n7jsciLiAUkbbhmQeV8ihfLnF47
   zkxOI1RPHzVrzz2TRNFeNdFlTdGuS0xND4wbq6TCXxCwl2BOjSjGTHxGV
   j3fvGYY4fXUbNc8TY/LZ470KvJmEw1Br0ZPjQmtdDYlYEAriaAuxonbib
   A==;
IronPort-SDR: u+j0cp8123SgxmdQ12jwCLBbVIg1H7QtyPYDpTj6n9nRLRzl+sLeFzP/LfwG1s2d8q0iMkDYpc
 f1tQ4DnhYtreuyRiNX0U4+Ky2ycS4vlwsM3GE9HlhkuVAMJ6AWVsjCYzxj/xxyEAv/vo5MCbIH
 7v4g1IkbUH2MZHXF59M4jIml8CDjfO5qDvqv+Nzeaxg3MkLQYYV5thSVc6r6GR6o5C2YBT+tFo
 jWiFiXQG8+x40P76REg3rzBhOe7wpKkYiD3neVv/r6FbeeTYoeL7pmTbkYMywkl0w5nxMwkz4w
 HeY=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; 
   d="scan'208";a="148261189"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2020 22:37:53 +0800
IronPort-SDR: VJLRCHYUXzUGYe8M3nGyah4/fPnMAzqDx7UGTzQRxF5AihCGCn6xywL2aRRauR9GJ48XK7Wn1h
 yg+m6/knJ2sQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 07:24:16 -0700
IronPort-SDR: ODNy4SQnhMXsPnu2l1QyABGR+2Xrdc6Ljea2lFyvtodHIiR7YL6kBMNVGdifXtDO34W0Tuq4KE
 chAoAD2CYnGg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Sep 2020 07:37:52 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 3/4] zonefs: open/close zone on file open/close
Date:   Thu, 10 Sep 2020 23:37:43 +0900
Message-Id: <20200910143744.17295-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910143744.17295-1-johannes.thumshirn@wdc.com>
References: <20200910143744.17295-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NVMe Zoned Namespace introduced the concept of active zones, which are
zones in the implicit open, explicit open or closed condition. Drives may
have a limit on the number of zones that can be simultaneously active.
This potential limitation translate into a risk for applications to see
write IO errors due to this limit if the zone of a file being written to is
not already active when a write request is issued.

To avoid these potential errors, the zone of a file can explicitly be made
active using an open zone command when the file is open for the first
time. If the zone open command succeeds, the application is then
guaranteed that write requests can be processed. This indirect management
of active zones relies on the maximum number of open zones of a drive,
which is always lower or equal to the maximum number of active zones.

On the first open of a sequential zone file, send a REQ_OP_ZONE_OPEN
command to the block device. Conversely, on the last release of a zone
file and send a REQ_OP_ZONE_CLOSE to the device if the zone is not full or
empty.

As truncating a zone file to 0 or max can deactivate a zone as well, we
need to serialize against truncates and also be careful not to close a
zone as the file may still be open for writing, e.g. the user called
ftruncate(). If the zone file is not open and a process does a truncate(),
then no close operation is needed.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Changes to v2:
- Clear open flag on error (Damien)
---
 fs/zonefs/super.c  | 187 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/zonefs/zonefs.h |  10 +++
 2 files changed, 193 insertions(+), 4 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 3db28a06e1a2..0b266b4212df 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -44,6 +44,19 @@ static inline int zonefs_zone_mgmt(struct inode *inode,
 	return 0;
 }
 
+static inline void zonefs_i_size_write(struct inode *inode, loff_t isize)
+{
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+
+	i_size_write(inode, isize);
+	/*
+	 * A full zone is no longer open/active and does not need
+	 * explicit closing.
+	 */
+	if (isize >= zi->i_max_size)
+		zi->i_flags &= ~ZONEFS_ZONE_OPEN;
+}
+
 static int zonefs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			      unsigned int flags, struct iomap *iomap,
 			      struct iomap *srcmap)
@@ -321,6 +334,17 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 		}
 	}
 
+	/*
+	 * If the filesystem is mounted with the explicit-open mount option, we
+	 * need to clear the ZONEFS_ZONE_OPEN flag if the zone transitioned to
+	 * the read-only or offline condition, to avoid attempting an explicit
+	 * close of the zone when the inode file is closed.
+	 */
+	if ((sbi->s_mount_opts & ZONEFS_MNTOPT_EXPLICIT_OPEN) &&
+	    (zone->cond == BLK_ZONE_COND_OFFLINE ||
+	     zone->cond == BLK_ZONE_COND_READONLY))
+		zi->i_flags &= ~ZONEFS_ZONE_OPEN;
+
 	/*
 	 * If error=remount-ro was specified, any error result in remounting
 	 * the volume as read-only.
@@ -335,7 +359,7 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 	 * invalid data.
 	 */
 	zonefs_update_stats(inode, data_size);
-	i_size_write(inode, data_size);
+	zonefs_i_size_write(inode, data_size);
 	zi->i_wpoffset = data_size;
 
 	return 0;
@@ -426,6 +450,25 @@ static int zonefs_file_truncate(struct inode *inode, loff_t isize)
 	if (ret)
 		goto unlock;
 
+	/*
+	 * If the mount option ZONEFS_MNTOPT_EXPLICIT_OPEN is set,
+	 * take care of open zones.
+	 */
+	if (zi->i_flags & ZONEFS_ZONE_OPEN) {
+		/*
+		 * Truncating a zone to EMPTY or FULL is the equivalent of
+		 * closing the zone. For a truncation to 0, we need to
+		 * re-open the zone to ensure new writes can be processed.
+		 * For a truncation to the maximum file size, the zone is
+		 * closed and writes cannot be accepted anymore, so clear
+		 * the open flag.
+		 */
+		if (!isize)
+			ret = zonefs_zone_mgmt(inode, REQ_OP_ZONE_OPEN);
+		else
+			zi->i_flags &= ~ZONEFS_ZONE_OPEN;
+	}
+
 	zonefs_update_stats(inode, isize);
 	truncate_setsize(inode, isize);
 	zi->i_wpoffset = isize;
@@ -604,7 +647,7 @@ static int zonefs_file_write_dio_end_io(struct kiocb *iocb, ssize_t size,
 		mutex_lock(&zi->i_truncate_mutex);
 		if (i_size_read(inode) < iocb->ki_pos + size) {
 			zonefs_update_stats(inode, iocb->ki_pos + size);
-			i_size_write(inode, iocb->ki_pos + size);
+			zonefs_i_size_write(inode, iocb->ki_pos + size);
 		}
 		mutex_unlock(&zi->i_truncate_mutex);
 	}
@@ -885,8 +928,132 @@ static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return ret;
 }
 
+static inline bool zonefs_file_use_exp_open(struct inode *inode, struct file *file)
+{
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+	struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
+
+	if (!(sbi->s_mount_opts & ZONEFS_MNTOPT_EXPLICIT_OPEN))
+		return false;
+
+	if (zi->i_ztype != ZONEFS_ZTYPE_SEQ)
+		return false;
+
+	if (!(file->f_mode & FMODE_WRITE))
+		return false;
+
+	return true;
+}
+
+static int zonefs_open_zone(struct inode *inode)
+{
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+	struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
+	int ret = 0;
+
+	mutex_lock(&zi->i_truncate_mutex);
+
+	zi->i_wr_refcnt++;
+	if (zi->i_wr_refcnt == 1) {
+
+		if (atomic_inc_return(&sbi->s_open_zones) > sbi->s_max_open_zones) {
+			atomic_dec(&sbi->s_open_zones);
+			ret = -EBUSY;
+			goto unlock;
+		}
+
+		if (i_size_read(inode) < zi->i_max_size) {
+			ret = zonefs_zone_mgmt(inode, REQ_OP_ZONE_OPEN);
+			if (ret) {
+				zi->i_wr_refcnt--;
+				atomic_dec(&sbi->s_open_zones);
+				goto unlock;
+			}
+			zi->i_flags |= ZONEFS_ZONE_OPEN;
+		}
+	}
+
+unlock:
+	mutex_unlock(&zi->i_truncate_mutex);
+
+	return ret;
+}
+
+static int zonefs_file_open(struct inode *inode, struct file *file)
+{
+	int ret;
+
+	ret = generic_file_open(inode, file);
+	if (ret)
+		return ret;
+
+	if (zonefs_file_use_exp_open(inode, file))
+		return zonefs_open_zone(inode);
+
+	return 0;
+}
+
+static void zonefs_close_zone(struct inode *inode)
+{
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+	int ret = 0;
+
+	mutex_lock(&zi->i_truncate_mutex);
+	zi->i_wr_refcnt--;
+	if (!zi->i_wr_refcnt) {
+		struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
+		struct super_block *sb = inode->i_sb;
+
+		/*
+		 * If the file zone is full, it is not open anymore and we only
+		 * need to decrement the open count.
+		 */
+		if (!(zi->i_flags & ZONEFS_ZONE_OPEN))
+			goto dec;
+
+		ret = zonefs_zone_mgmt(inode, REQ_OP_ZONE_CLOSE);
+		if (ret) {
+			__zonefs_io_error(inode, false);
+			/*
+			 * If the zone open flag is still set, it means that
+			 * the zone is neither read-only nor offline now. This
+			 * can only happen if sending the REQ_OP_ZONE_CLOSE
+			 * request to the drive failed, for whatever reasons.
+			 *
+			 * It's better to mark the FS read-only (if
+			 * __zonefs_io_error hasn't done that already) than to
+			 * loose any data.
+			 */
+			if (zi->i_flags & ZONEFS_ZONE_OPEN &&
+			    !(sb->s_flags & SB_RDONLY)) {
+				zonefs_warn(sb, "closing zone failed, remounting filesystem read-only\n");
+				sb->s_flags |= SB_RDONLY;
+			}
+		}
+		zi->i_flags &= ~ZONEFS_ZONE_OPEN;
+dec:
+		atomic_dec(&sbi->s_open_zones);
+	}
+	mutex_unlock(&zi->i_truncate_mutex);
+}
+
+static int zonefs_file_release(struct inode *inode, struct file *file)
+{
+	/*
+	 * If we explicitly open a zone we must close it again as well, but the
+	 * zone management operation can fail (either due to an IO error or as
+	 * the zone has gone offline or read-only). Make sure we don't fail the
+	 * close(2) for user-space.
+	 */
+	if (zonefs_file_use_exp_open(inode, file))
+		zonefs_close_zone(inode);
+
+	return 0;
+}
+
 static const struct file_operations zonefs_file_operations = {
-	.open		= generic_file_open,
+	.open		= zonefs_file_open,
+	.release	= zonefs_file_release,
 	.fsync		= zonefs_file_fsync,
 	.mmap		= zonefs_file_mmap,
 	.llseek		= zonefs_file_llseek,
@@ -910,6 +1077,7 @@ static struct inode *zonefs_alloc_inode(struct super_block *sb)
 	inode_init_once(&zi->i_vnode);
 	mutex_init(&zi->i_truncate_mutex);
 	init_rwsem(&zi->i_mmap_sem);
+	zi->i_wr_refcnt = 0;
 
 	return &zi->i_vnode;
 }
@@ -960,7 +1128,7 @@ static int zonefs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 enum {
 	Opt_errors_ro, Opt_errors_zro, Opt_errors_zol, Opt_errors_repair,
-	Opt_err,
+	Opt_explicit_open, Opt_err,
 };
 
 static const match_table_t tokens = {
@@ -968,6 +1136,7 @@ static const match_table_t tokens = {
 	{ Opt_errors_zro,	"errors=zone-ro"},
 	{ Opt_errors_zol,	"errors=zone-offline"},
 	{ Opt_errors_repair,	"errors=repair"},
+	{ Opt_explicit_open,	"explicit-open" },
 	{ Opt_err,		NULL}
 };
 
@@ -1004,6 +1173,9 @@ static int zonefs_parse_options(struct super_block *sb, char *options)
 			sbi->s_mount_opts &= ~ZONEFS_MNTOPT_ERRORS_MASK;
 			sbi->s_mount_opts |= ZONEFS_MNTOPT_ERRORS_REPAIR;
 			break;
+		case Opt_explicit_open:
+			sbi->s_mount_opts |= ZONEFS_MNTOPT_EXPLICIT_OPEN;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -1423,6 +1595,13 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->s_gid = GLOBAL_ROOT_GID;
 	sbi->s_perm = 0640;
 	sbi->s_mount_opts = ZONEFS_MNTOPT_ERRORS_RO;
+	sbi->s_max_open_zones = bdev_max_open_zones(sb->s_bdev);
+	atomic_set(&sbi->s_open_zones, 0);
+	if (!sbi->s_max_open_zones &&
+	    sbi->s_mount_opts & ZONEFS_MNTOPT_EXPLICIT_OPEN) {
+		zonefs_info(sb, "No open zones limit. Ignoring explicit_open mount option\n");
+		sbi->s_mount_opts &= ~ZONEFS_MNTOPT_EXPLICIT_OPEN;
+	}
 
 	ret = zonefs_read_super(sb);
 	if (ret)
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 55b39970acb2..51141907097c 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -38,6 +38,8 @@ static inline enum zonefs_ztype zonefs_zone_type(struct blk_zone *zone)
 	return ZONEFS_ZTYPE_SEQ;
 }
 
+#define ZONEFS_ZONE_OPEN	(1 << 0)
+
 /*
  * In-memory inode data.
  */
@@ -74,6 +76,10 @@ struct zonefs_inode_info {
 	 */
 	struct mutex		i_truncate_mutex;
 	struct rw_semaphore	i_mmap_sem;
+
+	/* guarded by i_truncate_mutex */
+	unsigned int		i_wr_refcnt;
+	unsigned int		i_flags;
 };
 
 static inline struct zonefs_inode_info *ZONEFS_I(struct inode *inode)
@@ -154,6 +160,7 @@ enum zonefs_features {
 #define ZONEFS_MNTOPT_ERRORS_MASK	\
 	(ZONEFS_MNTOPT_ERRORS_RO | ZONEFS_MNTOPT_ERRORS_ZRO | \
 	 ZONEFS_MNTOPT_ERRORS_ZOL | ZONEFS_MNTOPT_ERRORS_REPAIR)
+#define ZONEFS_MNTOPT_EXPLICIT_OPEN	(1 << 4) /* Explicit open/close of zones on open/close */
 
 /*
  * In-memory Super block information.
@@ -175,6 +182,9 @@ struct zonefs_sb_info {
 
 	loff_t			s_blocks;
 	loff_t			s_used_blocks;
+
+	unsigned int		s_max_open_zones;
+	atomic_t		s_open_zones;
 };
 
 static inline struct zonefs_sb_info *ZONEFS_SB(struct super_block *sb)
-- 
2.26.2


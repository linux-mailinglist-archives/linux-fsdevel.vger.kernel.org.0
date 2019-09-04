Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6A2A787A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 04:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfIDCKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 22:10:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5743 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727949AbfIDCKm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:10:42 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B5D8EB7704581B3E7437;
        Wed,  4 Sep 2019 10:10:40 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019
 10:10:29 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 22/25] erofs: rename errln/infoln/debugln to erofs_{err,info,dbg}
Date:   Wed, 4 Sep 2019 10:09:09 +0800
Message-ID: <20190904020912.63925-23-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904020912.63925-1-gaoxiang25@huawei.com>
References: <20190901055130.30572-1-hsiangkao@aol.com>
 <20190904020912.63925-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add prefix "erofs_" to these functions and print
sb->s_id as a prefix to erofs_{err, info} so that
the user knows which file system is affected.

Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/data.c         | 10 +++--
 fs/erofs/decompressor.c |  5 +--
 fs/erofs/dir.c          | 17 +++++----
 fs/erofs/inode.c        | 31 ++++++++-------
 fs/erofs/internal.h     | 14 +++++--
 fs/erofs/namei.c        |  9 +++--
 fs/erofs/super.c        | 83 +++++++++++++++++++++++++++--------------
 fs/erofs/xattr.c        |  8 ++--
 fs/erofs/zdata.c        | 13 ++++---
 fs/erofs/zdata.h        |  2 +-
 fs/erofs/zmap.c         | 37 ++++++++++--------
 11 files changed, 139 insertions(+), 90 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index b5f5b8592d14..eb7bbae89ed0 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -137,8 +137,9 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 
 		/* inline data should be located in one meta block */
 		if (erofs_blkoff(map->m_pa) + map->m_plen > PAGE_SIZE) {
-			errln("inline data cross block boundary @ nid %llu",
-			      vi->nid);
+			erofs_err(inode->i_sb,
+				  "inline data cross block boundary @ nid %llu",
+				  vi->nid);
 			DBG_BUGON(1);
 			err = -EFSCORRUPTED;
 			goto err_out;
@@ -146,8 +147,9 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 
 		map->m_flags |= EROFS_MAP_META;
 	} else {
-		errln("internal error @ nid: %llu (size %llu), m_la 0x%llx",
-		      vi->nid, inode->i_size, map->m_la);
+		erofs_err(inode->i_sb,
+			  "internal error @ nid: %llu (size %llu), m_la 0x%llx",
+			  vi->nid, inode->i_size, map->m_la);
 		DBG_BUGON(1);
 		err = -EIO;
 		goto err_out;
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 37177d49d125..19f89f9fb10c 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -161,9 +161,8 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 					  inlen, rq->outputsize,
 					  rq->outputsize);
 	if (ret < 0) {
-		errln("%s, failed to decompress, in[%p, %u, %u] out[%p, %u]",
-		      __func__, src + inputmargin, inlen, inputmargin,
-		      out, rq->outputsize);
+		erofs_err(rq->sb, "failed to decompress, in[%u, %u] out[%u]",
+			  inlen, inputmargin, rq->outputsize);
 		WARN_ON(1);
 		print_hex_dump(KERN_DEBUG, "[ in]: ", DUMP_PREFIX_OFFSET,
 			       16, 1, src + inputmargin, inlen, true);
diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index a032c8217071..d28c623dfef9 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -16,8 +16,8 @@ static void debug_one_dentry(unsigned char d_type, const char *de_name,
 	memcpy(dbg_namebuf, de_name, de_namelen);
 	dbg_namebuf[de_namelen] = '\0';
 
-	debugln("found dirent %s de_len %u d_type %d", dbg_namebuf,
-		de_namelen, d_type);
+	erofs_dbg("found dirent %s de_len %u d_type %d", dbg_namebuf,
+		  de_namelen, d_type);
 #endif
 }
 
@@ -47,7 +47,8 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 		/* a corrupted entry is found */
 		if (nameoff + de_namelen > maxsize ||
 		    de_namelen > EROFS_NAME_LEN) {
-			errln("bogus dirent @ nid %llu", EROFS_I(dir)->nid);
+			erofs_err(dir->i_sb, "bogus dirent @ nid %llu",
+				  EROFS_I(dir)->nid);
 			DBG_BUGON(1);
 			return -EFSCORRUPTED;
 		}
@@ -84,8 +85,9 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 			err = -ENOMEM;
 			break;
 		} else if (IS_ERR(dentry_page)) {
-			errln("fail to readdir of logical block %u of nid %llu",
-			      i, EROFS_I(dir)->nid);
+			erofs_err(dir->i_sb,
+				  "fail to readdir of logical block %u of nid %llu",
+				  i, EROFS_I(dir)->nid);
 			err = -EFSCORRUPTED;
 			break;
 		}
@@ -96,8 +98,9 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 
 		if (nameoff < sizeof(struct erofs_dirent) ||
 		    nameoff >= PAGE_SIZE) {
-			errln("%s, invalid de[0].nameoff %u @ nid %llu",
-			      __func__, nameoff, EROFS_I(dir)->nid);
+			erofs_err(dir->i_sb,
+				  "invalid de[0].nameoff %u @ nid %llu",
+				  nameoff, EROFS_I(dir)->nid);
 			err = -EFSCORRUPTED;
 			goto skip_this;
 		}
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 5a6d3282fefb..a0cec3c754cd 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -22,8 +22,8 @@ static int erofs_read_inode(struct inode *inode, void *data)
 	vi->datalayout = erofs_inode_datalayout(ifmt);
 
 	if (vi->datalayout >= EROFS_INODE_DATALAYOUT_MAX) {
-		errln("unsupported datalayout %u of nid %llu",
-		      vi->datalayout, vi->nid);
+		erofs_err(inode->i_sb, "unsupported datalayout %u of nid %llu",
+			  vi->datalayout, vi->nid);
 		DBG_BUGON(1);
 		return -EOPNOTSUPP;
 	}
@@ -108,8 +108,9 @@ static int erofs_read_inode(struct inode *inode, void *data)
 			nblks = le32_to_cpu(dic->i_u.compressed_blocks);
 		break;
 	default:
-		errln("unsupported on-disk inode version %u of nid %llu",
-		      erofs_inode_version(ifmt), vi->nid);
+		erofs_err(inode->i_sb,
+			  "unsupported on-disk inode version %u of nid %llu",
+			  erofs_inode_version(ifmt), vi->nid);
 		DBG_BUGON(1);
 		return -EOPNOTSUPP;
 	}
@@ -122,7 +123,8 @@ static int erofs_read_inode(struct inode *inode, void *data)
 	return 0;
 
 bogusimode:
-	errln("bogus i_mode (%o) @ nid %llu", inode->i_mode, vi->nid);
+	erofs_err(inode->i_sb, "bogus i_mode (%o) @ nid %llu",
+		  inode->i_mode, vi->nid);
 	DBG_BUGON(1);
 	return -EFSCORRUPTED;
 }
@@ -148,8 +150,9 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
 	/* inline symlink data shouldn't cross page boundary as well */
 	if (m_pofs + inode->i_size > PAGE_SIZE) {
 		kfree(lnk);
-		errln("inline data cross block boundary @ nid %llu",
-		      vi->nid);
+		erofs_err(inode->i_sb,
+			  "inline data cross block boundary @ nid %llu",
+			  vi->nid);
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
 	}
@@ -164,7 +167,7 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
 
 static int erofs_fill_inode(struct inode *inode, int isdir)
 {
-	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
+	struct super_block *sb = inode->i_sb;
 	struct erofs_inode *vi = EROFS_I(inode);
 	struct page *page;
 	void *data;
@@ -174,18 +177,18 @@ static int erofs_fill_inode(struct inode *inode, int isdir)
 	erofs_off_t inode_loc;
 
 	trace_erofs_fill_inode(inode, isdir);
-	inode_loc = iloc(sbi, vi->nid);
+	inode_loc = iloc(EROFS_SB(sb), vi->nid);
 	blkaddr = erofs_blknr(inode_loc);
 	ofs = erofs_blkoff(inode_loc);
 
-	debugln("%s, reading inode nid %llu at %u of blkaddr %u",
-		__func__, vi->nid, ofs, blkaddr);
+	erofs_dbg("%s, reading inode nid %llu at %u of blkaddr %u",
+		  __func__, vi->nid, ofs, blkaddr);
 
-	page = erofs_get_meta_page(inode->i_sb, blkaddr);
+	page = erofs_get_meta_page(sb, blkaddr);
 
 	if (IS_ERR(page)) {
-		errln("failed to get inode (nid: %llu) page, err %ld",
-		      vi->nid, PTR_ERR(page));
+		erofs_err(sb, "failed to get inode (nid: %llu) page, err %ld",
+			  vi->nid, PTR_ERR(page));
 		return PTR_ERR(page);
 	}
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index d659c1941f93..544a453f3076 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -22,13 +22,19 @@
 #undef pr_fmt
 #define pr_fmt(fmt) "erofs: " fmt
 
-#define errln(x, ...)   pr_err(x "\n", ##__VA_ARGS__)
-#define infoln(x, ...)  pr_info(x "\n", ##__VA_ARGS__)
+__printf(3, 4) void _erofs_err(struct super_block *sb,
+			       const char *function, const char *fmt, ...);
+#define erofs_err(sb, fmt, ...)	\
+	_erofs_err(sb, __func__, fmt "\n", ##__VA_ARGS__)
+__printf(3, 4) void _erofs_info(struct super_block *sb,
+			       const char *function, const char *fmt, ...);
+#define erofs_info(sb, fmt, ...) \
+	_erofs_info(sb, __func__, fmt "\n", ##__VA_ARGS__)
 #ifdef CONFIG_EROFS_FS_DEBUG
-#define debugln(x, ...) pr_debug(x "\n", ##__VA_ARGS__)
+#define erofs_dbg(x, ...)       pr_debug(x "\n", ##__VA_ARGS__)
 #define DBG_BUGON               BUG_ON
 #else
-#define debugln(x, ...)         ((void)0)
+#define erofs_dbg(x, ...)       ((void)0)
 #define DBG_BUGON(x)            ((void)(x))
 #endif	/* !CONFIG_EROFS_FS_DEBUG */
 
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index 6debc1d88282..3abbecbf73de 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -116,8 +116,9 @@ static struct page *find_target_block_classic(struct inode *dir,
 			if (!ndirents) {
 				kunmap_atomic(de);
 				put_page(page);
-				errln("corrupted dir block %d @ nid %llu",
-				      mid, EROFS_I(dir)->nid);
+				erofs_err(dir->i_sb,
+					  "corrupted dir block %d @ nid %llu",
+					  mid, EROFS_I(dir)->nid);
 				DBG_BUGON(1);
 				page = ERR_PTR(-EFSCORRUPTED);
 				goto out;
@@ -233,8 +234,8 @@ static struct dentry *erofs_lookup(struct inode *dir,
 	} else if (err) {
 		inode = ERR_PTR(err);
 	} else {
-		debugln("%s, %s (nid %llu) found, d_type %u", __func__,
-			dentry->d_name.name, nid, d_type);
+		erofs_dbg("%s, %s (nid %llu) found, d_type %u", __func__,
+			  dentry->d_name.name, nid, d_type);
 		inode = erofs_iget(dir->i_sb, nid, d_type == FT_DIR);
 	}
 	return d_splice_alias(inode, dentry);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 407c95854be1..1d9880195ef0 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -16,6 +16,36 @@
 
 static struct kmem_cache *erofs_inode_cachep __read_mostly;
 
+void _erofs_err(struct super_block *sb, const char *function,
+		const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	pr_err("(device %s): %s: %pV", sb->s_id, function, &vaf);
+	va_end(args);
+}
+
+void _erofs_info(struct super_block *sb, const char *function,
+		 const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	pr_info("(device %s): %pV", sb->s_id, &vaf);
+	va_end(args);
+}
+
 static void erofs_inode_init_once(void *ptr)
 {
 	struct erofs_inode *vi = ptr;
@@ -57,8 +87,9 @@ static bool check_layout_compatibility(struct super_block *sb,
 
 	/* check if current kernel meets all mandatory requirements */
 	if (feature & (~EROFS_ALL_FEATURE_INCOMPAT)) {
-		errln("unidentified incompatible feature %x, please upgrade kernel version",
-		      feature & ~EROFS_ALL_FEATURE_INCOMPAT);
+		erofs_err(sb,
+			  "unidentified incompatible feature %x, please upgrade kernel version",
+			   feature & ~EROFS_ALL_FEATURE_INCOMPAT);
 		return false;
 	}
 	return true;
@@ -75,7 +106,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	bh = sb_bread(sb, 0);
 
 	if (!bh) {
-		errln("cannot read erofs superblock");
+		erofs_err(sb, "cannot read erofs superblock");
 		return -EIO;
 	}
 
@@ -84,15 +115,15 @@ static int erofs_read_superblock(struct super_block *sb)
 
 	ret = -EINVAL;
 	if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
-		errln("cannot find valid erofs superblock");
+		erofs_err(sb, "cannot find valid erofs superblock");
 		goto out;
 	}
 
 	blkszbits = dsb->blkszbits;
 	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
 	if (blkszbits != LOG_BLOCK_SIZE) {
-		errln("blksize %u isn't supported on this platform",
-		      1 << blkszbits);
+		erofs_err(sb, "blksize %u isn't supported on this platform",
+			  1 << blkszbits);
 		goto out;
 	}
 
@@ -116,7 +147,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	ret = strscpy(sbi->volume_name, dsb->volume_name,
 		      sizeof(dsb->volume_name));
 	if (ret < 0) {	/* -E2BIG */
-		errln("bad volume name without NIL terminator");
+		erofs_err(sb, "bad volume name without NIL terminator");
 		ret = -EFSCORRUPTED;
 		goto out;
 	}
@@ -127,14 +158,15 @@ static int erofs_read_superblock(struct super_block *sb)
 }
 
 #ifdef CONFIG_EROFS_FS_ZIP
-static int erofs_build_cache_strategy(struct erofs_sb_info *sbi,
+static int erofs_build_cache_strategy(struct super_block *sb,
 				      substring_t *args)
 {
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	const char *cs = match_strdup(args);
 	int err = 0;
 
 	if (!cs) {
-		errln("Not enough memory to store cache strategy");
+		erofs_err(sb, "Not enough memory to store cache strategy");
 		return -ENOMEM;
 	}
 
@@ -145,17 +177,17 @@ static int erofs_build_cache_strategy(struct erofs_sb_info *sbi,
 	} else if (!strcmp(cs, "readaround")) {
 		sbi->cache_strategy = EROFS_ZIP_CACHE_READAROUND;
 	} else {
-		errln("Unrecognized cache strategy \"%s\"", cs);
+		erofs_err(sb, "Unrecognized cache strategy \"%s\"", cs);
 		err = -EINVAL;
 	}
 	kfree(cs);
 	return err;
 }
 #else
-static int erofs_build_cache_strategy(struct erofs_sb_info *sbi,
+static int erofs_build_cache_strategy(struct super_block *sb,
 				      substring_t *args)
 {
-	infoln("EROFS compression is disabled, so cache strategy is ignored");
+	erofs_info(sb, "EROFS compression is disabled, so cache strategy is ignored");
 	return 0;
 }
 #endif
@@ -221,10 +253,10 @@ static int erofs_parse_options(struct super_block *sb, char *options)
 			break;
 #else
 		case Opt_user_xattr:
-			infoln("user_xattr options not supported");
+			erofs_info(sb, "user_xattr options not supported");
 			break;
 		case Opt_nouser_xattr:
-			infoln("nouser_xattr options not supported");
+			erofs_info(sb, "nouser_xattr options not supported");
 			break;
 #endif
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
@@ -236,19 +268,19 @@ static int erofs_parse_options(struct super_block *sb, char *options)
 			break;
 #else
 		case Opt_acl:
-			infoln("acl options not supported");
+			erofs_info(sb, "acl options not supported");
 			break;
 		case Opt_noacl:
-			infoln("noacl options not supported");
+			erofs_info(sb, "noacl options not supported");
 			break;
 #endif
 		case Opt_cache_strategy:
-			err = erofs_build_cache_strategy(EROFS_SB(sb), args);
+			err = erofs_build_cache_strategy(sb, args);
 			if (err)
 				return err;
 			break;
 		default:
-			errln("Unrecognized mount option \"%s\" or missing value", p);
+			erofs_err(sb, "Unrecognized mount option \"%s\" or missing value", p);
 			return -EINVAL;
 		}
 	}
@@ -323,7 +355,7 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_magic = EROFS_SUPER_MAGIC;
 
 	if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
-		errln("failed to set erofs blksize");
+		erofs_err(sb, "failed to set erofs blksize");
 		return -EINVAL;
 	}
 
@@ -367,8 +399,8 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 		return PTR_ERR(inode);
 
 	if (!S_ISDIR(inode->i_mode)) {
-		errln("rootino(nid %llu) is not a directory(i_mode %o)",
-		      ROOT_NID(sbi), inode->i_mode);
+		erofs_err(sb, "rootino(nid %llu) is not a directory(i_mode %o)",
+			  ROOT_NID(sbi), inode->i_mode);
 		iput(inode);
 		return -EINVAL;
 	}
@@ -383,9 +415,8 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 	if (err)
 		return err;
 
-	if (!silent)
-		infoln("mounted on %s with opts: %s, root inode @ nid %llu.",
-		       sb->s_id, (char *)data, ROOT_NID(sbi));
+	erofs_info(sb, "mounted with opts: %s, root inode @ nid %llu.",
+		   (char *)data, ROOT_NID(sbi));
 	return 0;
 }
 
@@ -404,7 +435,6 @@ static void erofs_kill_sb(struct super_block *sb)
 	struct erofs_sb_info *sbi;
 
 	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
-	infoln("unmounting for %s", sb->s_id);
 
 	kill_block_super(sb);
 
@@ -443,7 +473,6 @@ static int __init erofs_module_init(void)
 	int err;
 
 	erofs_check_ondisk_layout_definitions();
-	infoln("initializing erofs " EROFS_VERSION);
 
 	erofs_inode_cachep = kmem_cache_create("erofs_inode",
 					       sizeof(struct erofs_inode), 0,
@@ -466,7 +495,6 @@ static int __init erofs_module_init(void)
 	if (err)
 		goto fs_err;
 
-	infoln("successfully to initialize erofs");
 	return 0;
 
 fs_err:
@@ -488,7 +516,6 @@ static void __exit erofs_module_exit(void)
 	/* Ensure all RCU free inodes are safe before cache is destroyed. */
 	rcu_barrier();
 	kmem_cache_destroy(erofs_inode_cachep);
-	infoln("successfully finalize erofs");
 }
 
 /* get filesystem statistics */
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index dd445c81c41f..a13a78725c57 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -67,13 +67,15 @@ static int init_inode_xattrs(struct inode *inode)
 	 *    undefined right now (maybe use later with some new sb feature).
 	 */
 	if (vi->xattr_isize == sizeof(struct erofs_xattr_ibody_header)) {
-		errln("xattr_isize %d of nid %llu is not supported yet",
-		      vi->xattr_isize, vi->nid);
+		erofs_err(inode->i_sb,
+			  "xattr_isize %d of nid %llu is not supported yet",
+			  vi->xattr_isize, vi->nid);
 		ret = -EOPNOTSUPP;
 		goto out_unlock;
 	} else if (vi->xattr_isize < sizeof(struct erofs_xattr_ibody_header)) {
 		if (vi->xattr_isize) {
-			errln("bogus xattr ibody @ nid %llu", vi->nid);
+			erofs_err(inode->i_sb,
+				  "bogus xattr ibody @ nid %llu", vi->nid);
 			DBG_BUGON(1);
 			ret = -EFSCORRUPTED;
 			goto out_unlock;	/* xattr ondisk layout error */
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index ff8ab444172d..96e34c90f814 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -600,7 +600,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	}
 
 	/* go ahead the next map_blocks */
-	debugln("%s: [out-of-range] pos %llu", __func__, offset + cur);
+	erofs_dbg("%s: [out-of-range] pos %llu", __func__, offset + cur);
 
 	if (z_erofs_collector_end(clt))
 		fe->backmost = false;
@@ -680,8 +680,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 out:
 	z_erofs_onlinepage_endio(page);
 
-	debugln("%s, finish page: %pK spiltted: %u map->m_llen %llu",
-		__func__, page, spiltted, map->m_llen);
+	erofs_dbg("%s, finish page: %pK spiltted: %u map->m_llen %llu",
+		  __func__, page, spiltted, map->m_llen);
 	return err;
 
 	/* if some error occurred while processing this page */
@@ -1340,7 +1340,7 @@ static int z_erofs_vle_normalaccess_readpage(struct file *file,
 	z_erofs_submit_and_unzip(inode->i_sb, &f.clt, &pagepool, true);
 
 	if (err)
-		errln("%s, failed to read, err [%d]", __func__, err);
+		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
 
 	if (f.map.mpage)
 		put_page(f.map.mpage);
@@ -1406,8 +1406,9 @@ static int z_erofs_vle_normalaccess_readpages(struct file *filp,
 
 		err = z_erofs_do_read_page(&f, page, &pagepool);
 		if (err)
-			errln("%s, readahead error at page %lu of nid %llu",
-			      __func__, page->index, EROFS_I(inode)->nid);
+			erofs_err(inode->i_sb,
+				  "readahead error at page %lu @ nid %llu",
+				  page->index, EROFS_I(inode)->nid);
 		put_page(page);
 	}
 
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index 4fc547bc01f9..faf950189bd7 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -182,7 +182,7 @@ static inline void z_erofs_onlinepage_endio(struct page *page)
 			SetPageUptodate(page);
 		unlock_page(page);
 	}
-	debugln("%s, page %p value %x", __func__, page, atomic_read(u.o));
+	erofs_dbg("%s, page %p value %x", __func__, page, atomic_read(u.o));
 }
 
 #define Z_EROFS_VMAP_ONSTACK_PAGES	\
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 9c141f145508..6a26c293ae2d 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -64,8 +64,8 @@ static int fill_inode_lazy(struct inode *inode)
 	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
 
 	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
-		errln("unknown compression format %u for nid %llu, please upgrade kernel",
-		      vi->z_algorithmtype[0], vi->nid);
+		erofs_err(sb, "unknown compression format %u for nid %llu, please upgrade kernel",
+			  vi->z_algorithmtype[0], vi->nid);
 		err = -EOPNOTSUPP;
 		goto unmap_done;
 	}
@@ -75,8 +75,8 @@ static int fill_inode_lazy(struct inode *inode)
 					((h->h_clusterbits >> 3) & 3);
 
 	if (vi->z_physical_clusterbits[0] != LOG_BLOCK_SIZE) {
-		errln("unsupported physical clusterbits %u for nid %llu, please upgrade kernel",
-		      vi->z_physical_clusterbits[0], vi->nid);
+		erofs_err(sb, "unsupported physical clusterbits %u for nid %llu, please upgrade kernel",
+			  vi->z_physical_clusterbits[0], vi->nid);
 		err = -EOPNOTSUPP;
 		goto unmap_done;
 	}
@@ -335,7 +335,8 @@ static int vle_extent_lookback(struct z_erofs_maprecorder *m,
 	int err;
 
 	if (lcn < lookback_distance) {
-		errln("bogus lookback distance @ nid %llu", vi->nid);
+		erofs_err(m->inode->i_sb,
+			  "bogus lookback distance @ nid %llu", vi->nid);
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
 	}
@@ -349,8 +350,9 @@ static int vle_extent_lookback(struct z_erofs_maprecorder *m,
 	switch (m->type) {
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		if (!m->delta[0]) {
-			errln("invalid lookback distance 0 at nid %llu",
-			      vi->nid);
+			erofs_err(m->inode->i_sb,
+				  "invalid lookback distance 0 @ nid %llu",
+				  vi->nid);
 			DBG_BUGON(1);
 			return -EFSCORRUPTED;
 		}
@@ -362,8 +364,9 @@ static int vle_extent_lookback(struct z_erofs_maprecorder *m,
 		map->m_la = (lcn << lclusterbits) | m->clusterofs;
 		break;
 	default:
-		errln("unknown type %u at lcn %lu of nid %llu",
-		      m->type, lcn, vi->nid);
+		erofs_err(m->inode->i_sb,
+			  "unknown type %u @ lcn %lu of nid %llu",
+			  m->type, lcn, vi->nid);
 		DBG_BUGON(1);
 		return -EOPNOTSUPP;
 	}
@@ -421,8 +424,9 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 		}
 		/* m.lcn should be >= 1 if endoff < m.clusterofs */
 		if (!m.lcn) {
-			errln("invalid logical cluster 0 at nid %llu",
-			      vi->nid);
+			erofs_err(inode->i_sb,
+				  "invalid logical cluster 0 at nid %llu",
+				  vi->nid);
 			err = -EFSCORRUPTED;
 			goto unmap_out;
 		}
@@ -437,8 +441,9 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 			goto unmap_out;
 		break;
 	default:
-		errln("unknown type %u at offset %llu of nid %llu",
-		      m.type, ofs, vi->nid);
+		erofs_err(inode->i_sb,
+			  "unknown type %u @ offset %llu of nid %llu",
+			  m.type, ofs, vi->nid);
 		err = -EOPNOTSUPP;
 		goto unmap_out;
 	}
@@ -453,9 +458,9 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 		kunmap_atomic(m.kaddr);
 
 out:
-	debugln("%s, m_la %llu m_pa %llu m_llen %llu m_plen %llu m_flags 0%o",
-		__func__, map->m_la, map->m_pa,
-		map->m_llen, map->m_plen, map->m_flags);
+	erofs_dbg("%s, m_la %llu m_pa %llu m_llen %llu m_plen %llu m_flags 0%o",
+		  __func__, map->m_la, map->m_pa,
+		  map->m_llen, map->m_plen, map->m_flags);
 
 	trace_z_erofs_map_blocks_iter_exit(inode, map, flags, err);
 
-- 
2.17.1


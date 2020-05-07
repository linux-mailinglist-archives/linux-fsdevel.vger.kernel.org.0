Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CAA1C7F4F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgEGArO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:47:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50480 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgEGArM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:47:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470bnDF064643;
        Thu, 7 May 2020 00:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=/lxtQPQEJy/i6bq6Gkbeub+HXra5DA0A1T4/mDiNDwQ=;
 b=h1LKJ3LUEY0GzjoeFRGdnXzI83/MGmn9S0Qlo9pDOKJbAgdU1TICVVVqQQGl+VJRUl1w
 of02eBMZ2tKwoG8Ry08iUmg8/4gNoE4ZyuapGq5O8VT5NM77O+vKgJpWScnEq4BF9vkR
 ITLGKCFl31k6bHl8bSrWFIgNdNW61TNy/G365kbX97hZbfxOba/XZ61oPLN0m01xiPV7
 IOhKwwiybcewZqDm0LzTIm+OEkldwuMHUva5coCmkRCik0vjvuPY8BPwVDt9V7csYfFh
 Y1GJFiVrcFgssrSY1STowI8j7TIQVQ890SMwZbv9JMRqF5Ci74Jsh8QeOPE8DEauiQQc 6Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30s09rdfg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:45:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0470asAl170896;
        Thu, 7 May 2020 00:43:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30us7p2ne6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 00:43:59 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0470ht0u025953;
        Thu, 7 May 2020 00:43:56 GMT
Received: from ayz-linux.localdomain (/68.7.158.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 17:43:55 -0700
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@linux.ibm.com, akpm@linux-foundation.org, hughd@google.com,
        ebiederm@xmission.com, masahiroy@kernel.org, ardb@kernel.org,
        ndesaulniers@google.com, dima@golovin.in, daniel.kiper@oracle.com,
        nivedita@alum.mit.edu, rafael.j.wysocki@intel.com,
        dan.j.williams@intel.com, zhenzhong.duan@oracle.com,
        jroedel@suse.de, bhe@redhat.com, guro@fb.com,
        Thomas.Lendacky@amd.com, andriy.shevchenko@linux.intel.com,
        keescook@chromium.org, hannes@cmpxchg.org, minchan@kernel.org,
        mhocko@kernel.org, ying.huang@intel.com,
        yang.shi@linux.alibaba.com, gustavo@embeddedor.com,
        ziqian.lzq@antfin.com, vdavydov.dev@gmail.com,
        jason.zeng@intel.com, kevin.tian@intel.com, zhiyuan.lv@intel.com,
        lei.l.li@intel.com, paul.c.lai@intel.com, ashok.raj@intel.com,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org
Subject: [RFC 23/43] mm: shmem: enable saving to PKRAM
Date:   Wed,  6 May 2020 17:41:49 -0700
Message-Id: <1588812129-8596-24-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=2
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=2
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch illustrates how the PKRAM API can be used for preserving tmpfs.
Two options are added to tmpfs:
    The 'pkram=' option specifies the PKRAM node to load/save the
    filesystem tree from/to.
    The 'preserve' option initiates preservation of a read-only
    filesystem tree.

If the 'pkram=' options is passed on mount, shmem will look for the
corresponding PKRAM node and load the FS tree from it.

If the 'pkram=' options was passed on mount and the 'preserve' option is
passed on remount and the filesystem is read-only, shmem will save the
FS tree to the PKRAM node.

A typical usage scenario looks like:

 # mount -t tmpfs -o pkram=mytmpfs none /mnt
 # echo something > /mnt/smth
 # mount -o remount ro,preserve /mnt
 <possibly kexec>
 # mount -t tmpfs -o pkram=mytmpfs none /mnt
 # cat /mnt/smth

Each FS tree is saved into a PKRAM node, and each file is saved into a
PKRAM object. A byte stream written to the object is used for saving file
metadata (name, permissions, etc) while the page stream written to
the object accommodates file content pages and their offsets.

This implementation serves as a demonstration and therefore is
simplified: it supports only regular files in the root directory without
multiple hard links, and it does not save swapped out files and aborts if
any are found. However, it can be elaborated to fully support tmpfs.

Originally-by: Vladimir Davydov <vdavydov@parallels.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h    |   1 +
 include/linux/shmem_fs.h |  24 +++
 mm/Makefile              |   2 +-
 mm/shmem.c               |  66 ++++++++
 mm/shmem_pkram.c         | 381 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 473 insertions(+), 1 deletion(-)
 create mode 100644 mm/shmem_pkram.c

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 1cd518843d7a..b47b3aef16e3 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -17,6 +17,7 @@ struct pkram_stream {
 	unsigned int entry_idx;		/* next entry in link */
 
 	unsigned long next_index;
+	struct address_space *mapping;
 
 	/* byte data */
 	struct page *data_page;
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 688b92cd4ec7..f2ce9937a8f2 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -26,6 +26,11 @@ struct shmem_inode_info {
 	struct inode		vfs_inode;
 };
 
+#define SHMEM_PKRAM_NAME_MAX	128
+struct shmem_pkram_info {
+	char name[SHMEM_PKRAM_NAME_MAX];
+};
+
 struct shmem_sb_info {
 	unsigned long max_blocks;   /* How many blocks are allowed */
 	struct percpu_counter used_blocks;  /* How many are allocated */
@@ -40,6 +45,8 @@ struct shmem_sb_info {
 	spinlock_t shrinklist_lock;   /* Protects shrinklist */
 	struct list_head shrinklist;  /* List of shinkable inodes */
 	unsigned long shrinklist_len; /* Length of shrinklist */
+	struct shmem_pkram_info *pkram;
+	bool preserve;		    /* PKRAM-enabled data is preserved */
 };
 
 static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
@@ -99,6 +106,23 @@ extern int shmem_getpage(struct inode *inode, pgoff_t index,
 extern int shmem_insert_page(struct mm_struct *mm, struct inode *inode,
 		pgoff_t index, struct page *page);
 
+#ifdef CONFIG_PKRAM
+extern int shmem_parse_pkram(const char *str, struct shmem_pkram_info **pkram);
+extern void shmem_show_pkram(struct seq_file *seq, struct shmem_pkram_info *pkram,
+			bool preserve);
+extern int shmem_save_pkram(struct super_block *sb);
+extern void shmem_load_pkram(struct super_block *sb);
+extern int shmem_release_pkram(struct super_block *sb);
+#else
+static inline int shmem_parse_pkram(const char *str,
+			struct shmem_pkram_info **pkram) { return 1; }
+static inline void shmem_show_pkram(struct seq_file *seq,
+			struct shmem_pkram_info *pkram, bool preserve) { }
+static inline int shmem_save_pkram(struct super_block *sb) { return 0; }
+static inline void shmem_load_pkram(struct super_block *sb) { }
+static inline int shmem_release_pkram(struct super_block *sb) { return 0; }
+#endif
+
 static inline struct page *shmem_read_mapping_page(
 				struct address_space *mapping, pgoff_t index)
 {
diff --git a/mm/Makefile b/mm/Makefile
index c4ad1c56e237..5c07ecaa5a38 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -112,4 +112,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
-obj-$(CONFIG_PKRAM) += pkram.o pkram_pagetable.o
+obj-$(CONFIG_PKRAM) += pkram.o pkram_pagetable.o shmem_pkram.o
diff --git a/mm/shmem.c b/mm/shmem.c
index 0a9a2166e51f..9c28ef657cd1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -112,14 +112,18 @@ struct shmem_options {
 	unsigned long long blocks;
 	unsigned long long inodes;
 	struct mempolicy *mpol;
+	struct shmem_pkram_info *pkram;
 	kuid_t uid;
 	kgid_t gid;
 	umode_t mode;
 	int huge;
+	bool preserve;
 	int seen;
 #define SHMEM_SEEN_BLOCKS 1
 #define SHMEM_SEEN_INODES 2
 #define SHMEM_SEEN_HUGE 4
+#define SHMEM_SEEN_PKRAM 8
+#define SHMEM_SEEN_PRESERVE 16
 };
 
 #ifdef CONFIG_TMPFS
@@ -3467,6 +3471,8 @@ enum shmem_param {
 	Opt_mpol,
 	Opt_nr_blocks,
 	Opt_nr_inodes,
+	Opt_pkram,
+	Opt_preserve,
 	Opt_size,
 	Opt_uid,
 };
@@ -3486,6 +3492,8 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
 	fsparam_string("mpol",		Opt_mpol),
 	fsparam_string("nr_blocks",	Opt_nr_blocks),
 	fsparam_string("nr_inodes",	Opt_nr_inodes),
+	fsparam_string("pkram",		Opt_pkram),
+	fsparam_flag_no("preserve",	Opt_preserve),
 	fsparam_string("size",		Opt_size),
 	fsparam_u32   ("uid",		Opt_uid),
 	{}
@@ -3557,6 +3565,22 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 			if (mpol_parse_str(param->string, &ctx->mpol))
 				goto bad_value;
 			break;
+		} else
+			goto unsupported_parameter;
+	case Opt_pkram:
+		if (IS_ENABLED(CONFIG_PKRAM)) {
+			kfree(ctx->pkram);
+			if (shmem_parse_pkram(param->string, &ctx->pkram))
+				goto bad_value;
+			ctx->seen |= SHMEM_SEEN_PKRAM;
+			break;
+		}
+		goto unsupported_parameter;
+	case Opt_preserve:
+		if (IS_ENABLED(CONFIG_PKRAM)) {
+			ctx->preserve = result.boolean;
+			ctx->seen |= SHMEM_SEEN_PRESERVE;
+			break;
 		}
 		goto unsupported_parameter;
 	}
@@ -3650,6 +3674,42 @@ static int shmem_reconfigure(struct fs_context *fc)
 		}
 	}
 
+	if (ctx->seen & SHMEM_SEEN_PRESERVE) {
+		if (!sbinfo->pkram && !(ctx->seen & SHMEM_SEEN_PKRAM)) {
+			err = "Cannot set preserve/nopreserve. Not enabled for PKRAM";
+			goto out;
+		}
+		if (ctx->preserve && !(fc->sb_flags & SB_RDONLY)) {
+			err = "Cannot preserve. Filesystem must be read-only";
+			goto out;
+		}
+	}
+
+	if (ctx->pkram) {
+		kfree(sbinfo->pkram);
+		sbinfo->pkram = ctx->pkram;
+	}
+
+	if (ctx->seen & SHMEM_SEEN_PRESERVE) {
+		int error;
+
+		if (!sbinfo->preserve && ctx->preserve) {
+			error = shmem_save_pkram(fc->root->d_sb);
+			if (error) {
+				err = "Failed to preserve";
+				goto out;
+			}
+			sbinfo->preserve = true;
+		} else if (sbinfo->preserve && !ctx->preserve) {
+			error = shmem_release_pkram(fc->root->d_sb);
+			if (error) {
+				err = "Failed to unpreserve";
+				goto out;
+			}
+			sbinfo->preserve = false;
+		}
+	}
+
 	if (ctx->seen & SHMEM_SEEN_HUGE)
 		sbinfo->huge = ctx->huge;
 	if (ctx->seen & SHMEM_SEEN_BLOCKS)
@@ -3667,6 +3727,7 @@ static int shmem_reconfigure(struct fs_context *fc)
 		sbinfo->mpol = ctx->mpol;	/* transfers initial ref */
 		ctx->mpol = NULL;
 	}
+
 	spin_unlock(&sbinfo->stat_lock);
 	return 0;
 out:
@@ -3697,6 +3758,7 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",huge=%s", shmem_format_huge(sbinfo->huge));
 #endif
 	shmem_show_mpol(seq, sbinfo->mpol);
+	shmem_show_pkram(seq, sbinfo->pkram, sbinfo->preserve);
 	return 0;
 }
 
@@ -3708,6 +3770,7 @@ static void shmem_put_super(struct super_block *sb)
 
 	percpu_counter_destroy(&sbinfo->used_blocks);
 	mpol_put(sbinfo->mpol);
+	kfree(sbinfo->pkram);
 	kfree(sbinfo);
 	sb->s_fs_info = NULL;
 }
@@ -3754,6 +3817,8 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbinfo->huge = ctx->huge;
 	sbinfo->mpol = ctx->mpol;
 	ctx->mpol = NULL;
+	sbinfo->pkram = ctx->pkram;
+	ctx->pkram = NULL;
 
 	spin_lock_init(&sbinfo->stat_lock);
 	if (percpu_counter_init(&sbinfo->used_blocks, 0, GFP_KERNEL))
@@ -3783,6 +3848,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_root = d_make_root(inode);
 	if (!sb->s_root)
 		goto failed;
+	shmem_load_pkram(sb);
 	return 0;
 
 failed:
diff --git a/mm/shmem_pkram.c b/mm/shmem_pkram.c
new file mode 100644
index 000000000000..3fa9cfbe0003
--- /dev/null
+++ b/mm/shmem_pkram.c
@@ -0,0 +1,381 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/crash_dump.h>
+#include <linux/dcache.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/gfp.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/mount.h>
+#include <linux/mutex.h>
+#include <linux/namei.h>
+#include <linux/pagemap.h>
+#include <linux/pagevec.h>
+#include <linux/pkram.h>
+#include <linux/seq_file.h>
+#include <linux/shmem_fs.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/time.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+
+struct file_header {
+	__u32	mode;
+	kuid_t	uid;
+	kgid_t	gid;
+	__u32	namelen;
+	__u64	size;
+	__u64	atime;
+	__u64	mtime;
+	__u64	ctime;
+};
+
+int shmem_parse_pkram(const char *str, struct shmem_pkram_info **pkram)
+{
+	struct shmem_pkram_info *new;
+	size_t len;
+
+	len = strlen(str);
+	if (!len || len >= SHMEM_PKRAM_NAME_MAX)
+		return 1;
+	new = kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return 1;
+	strcpy(new->name, str);
+	*pkram = new;
+	return 0;
+}
+
+void shmem_show_pkram(struct seq_file *seq, struct shmem_pkram_info *pkram, bool preserve)
+{
+	if (pkram) {
+		seq_printf(seq, ",pkram=%s", pkram->name);
+		seq_printf(seq, ",%s", preserve ? "preserve" : "nopreserve");
+	}
+}
+
+static int shmem_pkram_name(char *buf, size_t bufsize,
+			   struct shmem_sb_info *sbinfo)
+{
+	if (snprintf(buf, bufsize, "shmem-%s", sbinfo->pkram->name) >= bufsize)
+		return -ENAMETOOLONG;
+	return 0;
+}
+
+static int save_page(struct page *page, struct pkram_stream *ps)
+{
+	int err = 0;
+
+	if (page)
+		err = pkram_save_page(ps, page, 0);
+
+	return err;
+}
+
+static int save_file_content(struct pkram_stream *ps)
+{
+	struct pagevec pvec;
+	pgoff_t indices[PAGEVEC_SIZE];
+	pgoff_t index = 0;
+	struct page *page;
+	int i, err = 0;
+
+	pagevec_init(&pvec);
+	for ( ; ; ) {
+		pvec.nr = find_get_entries(ps->mapping, index, PAGEVEC_SIZE,
+				pvec.pages, indices);
+		if (!pvec.nr)
+			break;
+		for (i = 0; i < pagevec_count(&pvec); i++) {
+			page = pvec.pages[i];
+			index = indices[i];
+
+			if (WARN_ON_ONCE(xa_is_value(page))) {
+				err = -EINVAL;
+				break;
+			}
+
+			lock_page(page);
+
+			if (PageTransTail(page)) {
+				WARN_ONCE(1, "PageTransTail returned true\n");
+				unlock_page(page);
+				continue;
+			}
+
+			BUG_ON(page->mapping != ps->mapping);
+			err = save_page(page, ps);
+
+			i += compound_nr(page) - 1;
+			index += compound_nr(page) - 1;
+
+			unlock_page(page);
+			if (err)
+				break;
+		}
+		pagevec_remove_exceptionals(&pvec);
+		pagevec_release(&pvec);
+		if (err)
+			break;
+		cond_resched();
+		index++;
+	}
+
+	return err;
+}
+
+static int save_file(struct dentry *dentry, struct pkram_stream *ps)
+{
+	struct inode *inode = dentry->d_inode;
+	umode_t mode = inode->i_mode;
+	struct file_header hdr;
+	ssize_t ret;
+
+	if (WARN_ON_ONCE(!S_ISREG(mode)))
+		return -EINVAL;
+	if (WARN_ON_ONCE(inode->i_nlink > 1))
+		return -EINVAL;
+
+	hdr.mode = mode;
+	hdr.uid = inode->i_uid;
+	hdr.gid = inode->i_gid;
+	hdr.namelen = dentry->d_name.len;
+	hdr.size = i_size_read(inode);
+	hdr.atime = timespec64_to_ns(&inode->i_atime);
+	hdr.mtime = timespec64_to_ns(&inode->i_mtime);
+	hdr.ctime = timespec64_to_ns(&inode->i_ctime);
+
+	ret = pkram_write(ps, &hdr, sizeof(hdr));
+	if (ret < 0)
+		return ret;
+	ret = pkram_write(ps, dentry->d_name.name, dentry->d_name.len);
+	if (ret < 0)
+		return ret;
+
+	ps->mapping = inode->i_mapping;
+	return save_file_content(ps);
+}
+
+static int save_tree(struct super_block *sb, struct pkram_stream *ps)
+{
+	struct dentry *dentry, *root = sb->s_root;
+	int err = 0;
+
+	inode_lock(d_inode(root));
+	spin_lock(&root->d_lock);
+	list_for_each_entry(dentry, &root->d_subdirs, d_child) {
+		if (d_unhashed(dentry) || !dentry->d_inode)
+			continue;
+		dget(dentry);
+		spin_unlock(&root->d_lock);
+
+		err = pkram_prepare_save_obj(ps);
+		if (!err)
+			err = save_file(dentry, ps);
+		if (!err)
+			pkram_finish_save_obj(ps);
+		spin_lock(&root->d_lock);
+		dput(dentry);
+		if (err)
+			break;
+	}
+	spin_unlock(&root->d_lock);
+	inode_unlock(d_inode(root));
+
+	return err;
+}
+
+int shmem_save_pkram(struct super_block *sb)
+{
+	struct shmem_sb_info *sbinfo = sb->s_fs_info;
+	struct pkram_stream psobj;
+	char *buf;
+	int err = -ENOMEM;
+
+	if (!sbinfo || !sbinfo->pkram || is_kdump_kernel())
+		return 0;
+
+	buf = (void *)__get_free_page(GFP_KERNEL);
+	if (!buf)
+		goto out;
+
+	err = shmem_pkram_name(buf, PAGE_SIZE, sbinfo);
+	if (!err)
+		err = pkram_prepare_save(&psobj, buf, GFP_KERNEL);
+	if (err)
+		goto out_free_buf;
+
+	err = save_tree(sb, &psobj);
+	if (err)
+		goto out_discard_save;
+
+	pkram_finish_save(&psobj);
+	goto out_free_buf;
+
+out_discard_save:
+	pkram_discard_save(&psobj);
+out_free_buf:
+	free_page((unsigned long)buf);
+out:
+	if (err)
+		pr_err("SHMEM: PKRAM save failed: %d\n", err);
+
+	return err;
+}
+
+static int load_file_content(struct pkram_stream *ps)
+{
+	unsigned long index;
+	struct page *page;
+	int err = 0;
+
+	do {
+		page = pkram_load_page(ps, &index, NULL);
+		if (!page)
+			break;
+
+		err = shmem_insert_page(current->mm, ps->mapping->host, index, page);
+		put_page(page);
+	} while (!err);
+
+	return err;
+}
+
+static int load_file(struct dentry *parent, struct pkram_stream *ps,
+		     char *buf, size_t bufsize)
+{
+	struct dentry *dentry;
+	struct inode *inode;
+	struct file_header hdr;
+	size_t ret;
+	umode_t mode;
+	int namelen;
+	int err = 0;
+
+	ret = pkram_read(ps, &hdr, sizeof(hdr));
+	if (ret != sizeof(hdr))
+		return -EINVAL;
+
+	mode = hdr.mode;
+	namelen = hdr.namelen;
+	if (!S_ISREG(mode) || namelen > bufsize)
+		return -EINVAL;
+	if (pkram_read(ps, buf, namelen) != namelen)
+		return -EINVAL;
+
+	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
+
+	dentry = lookup_one_len(buf, parent, namelen);
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
+		goto out_unlock;
+	}
+
+	err = vfs_create(parent->d_inode, dentry, mode, NULL);
+	dput(dentry); /* on success shmem pinned it */
+	if (err)
+		goto out_unlock;
+
+	inode = dentry->d_inode;
+	inode->i_mode = mode;
+	inode->i_uid = hdr.uid;
+	inode->i_gid = hdr.gid;
+	inode->i_atime = ns_to_timespec64(hdr.atime);
+	inode->i_mtime = ns_to_timespec64(hdr.mtime);
+	inode->i_ctime = ns_to_timespec64(hdr.ctime);
+	i_size_write(inode, hdr.size);
+
+	ps->mapping = inode->i_mapping;
+	err = load_file_content(ps);
+out_unlock:
+	inode_unlock(d_inode(parent));
+
+	return err;
+}
+
+static int load_tree(struct super_block *sb, struct pkram_stream *ps,
+		     char *buf, size_t bufsize)
+{
+	int err;
+
+	do {
+		err = pkram_prepare_load_obj(ps);
+		if (err) {
+			if (err == -ENODATA)
+				err = 0;
+			break;
+		}
+		err = load_file(sb->s_root, ps, buf, PAGE_SIZE);
+		pkram_finish_load_obj(ps);
+	} while (!err);
+
+	return err;
+}
+
+void shmem_load_pkram(struct super_block *sb)
+{
+	struct shmem_sb_info *sbinfo = sb->s_fs_info;
+	struct pkram_stream psobj;
+	char *buf;
+	int err = -ENOMEM;
+
+	if (!sbinfo->pkram)
+		return;
+
+	buf = (void *)__get_free_page(GFP_KERNEL);
+	if (!buf)
+		goto out;
+
+	err = shmem_pkram_name(buf, PAGE_SIZE, sbinfo);
+	if (!err)
+		err = pkram_prepare_load(&psobj, buf);
+	if (err) {
+		if (err == -ENOENT)
+			err = 0;
+		goto out_free_buf;
+	}
+
+	err = load_tree(sb, &psobj, buf, PAGE_SIZE);
+
+	pkram_finish_load(&psobj);
+out_free_buf:
+	free_page((unsigned long)buf);
+out:
+	if (err)
+		pr_err("SHMEM: PKRAM load failed: %d\n", err);
+}
+
+int shmem_release_pkram(struct super_block *sb)
+{
+	struct shmem_sb_info *sbinfo = sb->s_fs_info;
+	struct pkram_stream psobj;
+	char *buf;
+	int err = -ENOMEM;
+
+	if (!sbinfo->pkram)
+		return 0;
+
+	buf = (void *)__get_free_page(GFP_KERNEL);
+	if (!buf)
+		goto out;
+
+	err = shmem_pkram_name(buf, PAGE_SIZE, sbinfo);
+	if (!err)
+		err = pkram_prepare_load(&psobj, buf);
+	if (err) {
+		if (err == -ENOENT)
+			err = 0;
+		goto out_free_buf;
+	}
+
+	pkram_finish_load(&psobj);
+out_free_buf:
+	free_page((unsigned long)buf);
+out:
+	if (err)
+		pr_err("SHMEM: PKRAM load failed: %d\n", err);
+
+	return err;
+}
-- 
2.13.3


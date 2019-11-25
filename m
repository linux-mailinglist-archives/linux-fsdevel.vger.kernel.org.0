Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFEAC1085CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 01:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfKYAGh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 19:06:37 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:49551 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfKYAGg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 19:06:36 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191125000632epoutp02f3cb2f5d491553ab925feeb09e4b0f32~aPxgCrBy_1374113741epoutp02B
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2019 00:06:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191125000632epoutp02f3cb2f5d491553ab925feeb09e4b0f32~aPxgCrBy_1374113741epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574640392;
        bh=tj72o4SYi10gjxwtCov2JL2H4XpN3zlzHb+zXv/4528=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=himWZPBCUZsjSS8wERw7yjbG5FItA8ARuQsMq3Y0t8Oec6MCNIctDOJd72ZojIMum
         BWL3dtX/8vIagiR+V2ua/uTG4rmme6A12WH7hE4acpXSrqBDDgFy33PFTOzGKUHvQH
         w82ZtzYsTng7TxufzrBEiTEC10VvwPAsui5Bwuss=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191125000631epcas1p28000a0634d668505e5ec87e751f6fbce~aPxfgmnG10613906139epcas1p2t;
        Mon, 25 Nov 2019 00:06:31 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47LnPy2drBzMqYm6; Mon, 25 Nov
        2019 00:06:30 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.F3.51241.60B1BDD5; Mon, 25 Nov 2019 09:06:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191125000630epcas1p23c2ac4216a044a19916f6aeb99166fde~aPxeIPHUo0156901569epcas1p2D;
        Mon, 25 Nov 2019 00:06:30 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191125000630epsmtrp1b28575ea4b506cfa03d928bcc7c30a4a~aPxeHYG2I2803928039epsmtrp1R;
        Mon, 25 Nov 2019 00:06:30 +0000 (GMT)
X-AuditID: b6c32a39-14bff7000001c829-a0-5ddb1b062e67
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.11.06569.50B1BDD5; Mon, 25 Nov 2019 09:06:29 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191125000629epsmtip286aa2a9facea1fddd8ea3a633a809296~aPxd9aohH2000420004epsmtip2N;
        Mon, 25 Nov 2019 00:06:29 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de, nborisov@suse.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v5 04/13] exfat: add directory operations
Date:   Sun, 24 Nov 2019 19:03:17 -0500
Message-Id: <20191125000326.24561-5-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191125000326.24561-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmri6b9O1Yg3szRC0OP57EbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyf9ZzV4sf0eov/b1pYLLb8O8Jqcen9BxYHbo+ds+6y
        e+yfu4bdY/fNBjaPvi2rGD3Wb7nK4rH5dLXH501yHoe2v2HzuP1sG0sAZ1SOTUZqYkpqkUJq
        XnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QsUoKZYk5pUChgMTiYiV9
        O5ui/NKSVIWM/OISW6XUgpScAkODAr3ixNzi0rx0veT8XCtDAwMjU6DKhJyMGb872ArutTNV
        HL+5n72BccM5xi5GTg4JAROJnu4uIJuLQ0hgB6PEjMnNTCAJIYFPjBIPJ2tA2N8YJd5drYZp
        +H/8DTNEw15GiVP/tkE5QA3r/9wEcjg42AS0Jf5sEQVpEBGwl9g8+wALSA2zwHVGiWe3ZrCC
        JIQFLCU+/H3NAmKzCKhKfO39ygxi8wrYSMy+0c4EsU1eYvWGA2BxTgFbiROnIJZJCNxmk9j9
        aCErRJGLxMUvP9khbGGJV8e3QNlSEi/729hBDpIQqJb4uJ8ZItzBKPHiuy2EbSxxc/0GVpAS
        ZgFNifW79CHCihI7f88FhxCzAJ/Eu689rBBTeCU62oQgSlQl+i4dhrpSWqKr/QPUUg+JOQfu
        QYNkAqPEtxsLWCcwys1C2LCAkXEVo1hqQXFuemqxYYEpcoxtYgSnRi3LHYzHzvkcYhTgYFTi
        4d2w9lasEGtiWXFl7iFGCQ5mJRFet7M3YoV4UxIrq1KL8uOLSnNSiw8xmgIDciKzlGhyPjBt
        55XEG5oaGRsbW5iYmZuZGiuJ83L8uBgrJJCeWJKanZpakFoE08fEwSnVwGgf/Ora7CW/RYKT
        nM55XeqRC+6bNOm6tJdAtPjsqLnBQnU69aE+XWYrs6vU1Bi/1BRdnRv7zeV5ee5Ji4mdbdJR
        rxIflO54M//Wq9Yg/7oHNfq+p5Rezgs+8nmexVy10Mo4y8Ua5quyfzYtr2x/sOzgk2aXwt15
        ywJawxhfNOj8Mvn8j6t6ihJLcUaioRZzUXEiAJUyL1OjAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSvC6r9O1Yg92LrS0OP57EbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyf9ZzV4sf0eov/b1pYLLb8O8Jqcen9BxYHbo+ds+6y
        e+yfu4bdY/fNBjaPvi2rGD3Wb7nK4rH5dLXH501yHoe2v2HzuP1sG0sAZxSXTUpqTmZZapG+
        XQJXxozfHWwF99qZKo7f3M/ewLjhHGMXIyeHhICJxP/jb5i7GLk4hAR2M0o0btzMDJGQljh2
        4gyQzQFkC0scPlwMUfOBUaJz8yQWkDibgLbEny2iIOUiAo4SvbsOs4DUMAs8ZpQ4cf4J2AJh
        AUuJD39fs4DYLAKqEl97v4LN5xWwkZh9o50JYpe8xOoNB8DinAK2EidObQOzhYBq2g8dZZvA
        yLeAkWEVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwEGtp7WA8cSL+EKMAB6MSDy/H
        hluxQqyJZcWVuYcYJTiYlUR43c7eiBXiTUmsrEotyo8vKs1JLT7EKM3BoiTOK59/LFJIID2x
        JDU7NbUgtQgmy8TBKdXAWCU68YWc8Ew5d+uV+VZtXCc3rCk6v/DZl7DaVuMglu/X251fZrOs
        2mfkVTItcLnoxbVHemJumN+qOuGm+eyRePm96SuOvNxx4enNWM44hVfP3sev2Gzdt+nwz9uJ
        hdJHxHkDlOqP9SoETQ+VmqjZaf1m6yRvAx9OuWeftKT5i9sVp796c774qhJLcUaioRZzUXEi
        APu3OOheAgAA
X-CMS-MailID: 20191125000630epcas1p23c2ac4216a044a19916f6aeb99166fde
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191125000630epcas1p23c2ac4216a044a19916f6aeb99166fde
References: <20191125000326.24561-1-namjae.jeon@samsung.com>
        <CGME20191125000630epcas1p23c2ac4216a044a19916f6aeb99166fde@epcas1p2.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of directory operations for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/dir.c | 1307 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1307 insertions(+)
 create mode 100644 fs/exfat/dir.c

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
new file mode 100644
index 000000000000..3d9fb71d4e3a
--- /dev/null
+++ b/fs/exfat/dir.c
@@ -0,0 +1,1307 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/slab.h>
+#include <linux/bio.h>
+#include <linux/buffer_head.h>
+
+#include "exfat_raw.h"
+#include "exfat_fs.h"
+
+/* read a directory entry from the opened directory */
+static int exfat_readdir(struct inode *inode, struct exfat_dir_entry *dir_entry)
+{
+	int i, dentries_per_clu, dentries_per_clu_bits = 0;
+	unsigned int type, clu_offset;
+	sector_t sector;
+	struct exfat_chain dir, clu;
+	struct exfat_uni_name uni_name;
+	struct exfat_timestamp tm;
+	struct exfat_dentry *ep;
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+	unsigned int dentry = ei->rwoffset & 0xFFFFFFFF;
+	struct buffer_head *bh;
+
+	/* check if the given file ID is opened */
+	if (ei->type != TYPE_DIR)
+		return -EPERM;
+
+	if (ei->entry == -1)
+		exfat_chain_set(&dir, sbi->root_dir, 0, ALLOC_FAT_CHAIN);
+	else
+		exfat_chain_set(&dir, ei->start_clu,
+			EXFAT_B_TO_CLU(i_size_read(inode), sbi), ei->flags);
+
+	dentries_per_clu = sbi->dentries_per_clu;
+	dentries_per_clu_bits = ilog2(dentries_per_clu);
+
+	clu_offset = dentry >> dentries_per_clu_bits;
+	exfat_chain_dup(&clu, &dir);
+
+	if (clu.flags == ALLOC_NO_FAT_CHAIN) {
+		clu.dir += clu_offset;
+		clu.size -= clu_offset;
+	} else {
+		/* hint_information */
+		if (clu_offset > 0 && ei->hint_bmap.off != EOF_CLUSTER &&
+		    ei->hint_bmap.off > 0 && clu_offset >= ei->hint_bmap.off) {
+			clu_offset -= ei->hint_bmap.off;
+			clu.dir = ei->hint_bmap.clu;
+		}
+
+		while (clu_offset > 0) {
+			if (exfat_get_next_cluster(sb, &(clu.dir)))
+				return -EIO;
+
+			clu_offset--;
+		}
+	}
+
+	while (clu.dir != EOF_CLUSTER) {
+		i = dentry & (dentries_per_clu - 1);
+
+		for ( ; i < dentries_per_clu; i++, dentry++) {
+			ep = exfat_get_dentry(sb, &clu, i, &bh, &sector);
+			if (!ep)
+				return -EIO;
+
+			type = exfat_get_entry_type(ep);
+			if (type == TYPE_UNUSED) {
+				brelse(bh);
+				break;
+			}
+
+			if (type != TYPE_FILE && type != TYPE_DIR) {
+				brelse(bh);
+				continue;
+			}
+
+			dir_entry->attr = le16_to_cpu(ep->file_attr);
+
+			exfat_get_entry_time(ep, &tm, TM_CREATE);
+			dir_entry->create_timestamp.year = tm.year;
+			dir_entry->create_timestamp.month = tm.mon;
+			dir_entry->create_timestamp.day = tm.day;
+			dir_entry->create_timestamp.hour = tm.hour;
+			dir_entry->create_timestamp.minute = tm.min;
+			dir_entry->create_timestamp.second = tm.sec;
+			dir_entry->create_timestamp.milli_second = 0;
+
+			exfat_get_entry_time(ep, &tm, TM_MODIFY);
+			dir_entry->modify_timestamp.year = tm.year;
+			dir_entry->modify_timestamp.month = tm.mon;
+			dir_entry->modify_timestamp.day = tm.day;
+			dir_entry->modify_timestamp.hour = tm.hour;
+			dir_entry->modify_timestamp.minute = tm.min;
+			dir_entry->modify_timestamp.second = tm.sec;
+			dir_entry->modify_timestamp.milli_second = 0;
+
+			memset(&dir_entry->access_timestamp, 0,
+				sizeof(struct exfat_date_time));
+
+			*uni_name.name = 0x0;
+			exfat_get_uniname_from_ext_entry(sb, &dir, dentry,
+				uni_name.name);
+			exfat_nls_uni16s_to_vfsname(sb, &uni_name,
+				dir_entry->namebuf.lfn,
+				dir_entry->namebuf.lfnbuf_len);
+			brelse(bh);
+
+			ep = exfat_get_dentry(sb, &clu, i + 1, &bh, NULL);
+			if (!ep)
+				return -EIO;
+			dir_entry->size = le64_to_cpu(ep->stream_valid_size);
+			brelse(bh);
+
+			ei->hint_bmap.off = dentry >> dentries_per_clu_bits;
+			ei->hint_bmap.clu = clu.dir;
+
+			ei->rwoffset = ++dentry;
+			return 0;
+		}
+
+		if (clu.flags == ALLOC_NO_FAT_CHAIN) {
+			if (--clu.size > 0)
+				clu.dir++;
+			else
+				clu.dir = EOF_CLUSTER;
+		} else {
+			if (exfat_get_next_cluster(sb, &(clu.dir)))
+				return -EIO;
+		}
+	}
+
+	dir_entry->namebuf.lfn[0] = '\0';
+	ei->rwoffset = dentry;
+	return 0;
+}
+
+static void exfat_init_namebuf(struct exfat_dentry_namebuf *nb)
+{
+	nb->lfn = NULL;
+	nb->lfnbuf_len = 0;
+}
+
+static int exfat_alloc_namebuf(struct exfat_dentry_namebuf *nb)
+{
+	nb->lfn = __getname();
+	if (!nb->lfn)
+		return -ENOMEM;
+	nb->lfnbuf_len = MAX_VFSNAME_BUF_SIZE;
+	return 0;
+}
+
+static void exfat_free_namebuf(struct exfat_dentry_namebuf *nb)
+{
+	if (!nb->lfn)
+		return;
+
+	__putname(nb->lfn);
+	exfat_init_namebuf(nb);
+}
+
+/* skip iterating emit_dots when dir is empty */
+#define ITER_POS_FILLED_DOTS    (2)
+static int exfat_iterate(struct file *filp, struct dir_context *ctx)
+{
+	struct inode *inode = filp->f_path.dentry->d_inode;
+	struct super_block *sb = inode->i_sb;
+	struct inode *tmp;
+	struct exfat_dir_entry de;
+	struct exfat_dentry_namebuf *nb = &(de.namebuf);
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+	unsigned long inum;
+	loff_t cpos, i_pos;
+	int err = 0, fake_offset = 0;
+
+	exfat_init_namebuf(nb);
+	mutex_lock(&EXFAT_SB(sb)->s_lock);
+
+	cpos = ctx->pos;
+	if (!dir_emit_dots(filp, ctx))
+		goto unlock;
+
+	if (ctx->pos == ITER_POS_FILLED_DOTS) {
+		cpos = 0;
+		fake_offset = 1;
+	}
+
+	if (cpos & (DENTRY_SIZE - 1)) {
+		err = -ENOENT;
+		goto unlock;
+	}
+
+	/* name buffer should be allocated before use */
+	err = exfat_alloc_namebuf(nb);
+	if (err)
+		goto unlock;
+get_new:
+	ei->rwoffset = EXFAT_B_TO_DEN(cpos);
+
+	if (cpos >= i_size_read(inode))
+		goto end_of_dir;
+
+	err = exfat_readdir(inode, &de);
+	if (err) {
+		/*
+		 * At least we tried to read a sector.  Move cpos to next sector
+		 * position (should be aligned).
+		 */
+		if (err == -EIO) {
+			cpos += 1 << (sb->s_blocksize_bits);
+			cpos &= ~(sb->s_blocksize - 1);
+		}
+
+		err = -EIO;
+		goto end_of_dir;
+	}
+
+	cpos = EXFAT_DEN_TO_B(ei->rwoffset);
+
+	if (!nb->lfn[0])
+		goto end_of_dir;
+
+	i_pos = ((loff_t)ei->start_clu << 32) |
+		((ei->rwoffset - 1) & 0xffffffff);
+	tmp = exfat_iget(sb, i_pos);
+	if (tmp) {
+		inum = tmp->i_ino;
+		iput(tmp);
+	} else {
+		inum = iunique(sb, EXFAT_ROOT_INO);
+	}
+
+	/*
+	 * Before calling dir_emit(), sb_lock should be released.
+	 * Because page fault can occur in dir_emit() when the size
+	 * of buffer given from user is larger than one page size.
+	 */
+	mutex_unlock(&EXFAT_SB(sb)->s_lock);
+	if (!dir_emit(ctx, nb->lfn, strlen(nb->lfn), inum,
+			(de.attr & ATTR_SUBDIR) ? DT_DIR : DT_REG))
+		goto out_unlocked;
+	mutex_lock(&EXFAT_SB(sb)->s_lock);
+	ctx->pos = cpos;
+	goto get_new;
+
+end_of_dir:
+	if (!cpos && fake_offset)
+		cpos = ITER_POS_FILLED_DOTS;
+	ctx->pos = cpos;
+unlock:
+	mutex_unlock(&EXFAT_SB(sb)->s_lock);
+out_unlocked:
+	/*
+	 * To improve performance, free namebuf after unlock sb_lock.
+	 * If namebuf is not allocated, this function do nothing
+	 */
+	exfat_free_namebuf(nb);
+	return err;
+}
+
+const struct file_operations exfat_dir_operations = {
+	.llseek		= generic_file_llseek,
+	.read		= generic_read_dir,
+	.iterate	= exfat_iterate,
+	.fsync		= generic_file_fsync,
+};
+
+int exfat_alloc_new_dir(struct inode *inode, struct exfat_chain *clu)
+{
+	int ret;
+
+	exfat_chain_set(clu, EOF_CLUSTER, 0, ALLOC_NO_FAT_CHAIN);
+
+	ret = exfat_alloc_cluster(inode, 1, clu);
+	if (ret)
+		return ret;
+
+	return exfat_zeroed_cluster(inode, clu->dir);
+}
+
+static int exfat_calc_num_entries(struct exfat_uni_name *p_uniname)
+{
+	int len;
+
+	len = p_uniname->name_len;
+	if (len == 0)
+		return 0;
+
+	/* 1 file entry + 1 stream entry + name entries */
+	return ((len - 1) / 15 + 3);
+}
+
+/*
+ * input  : dir, uni_name
+ * output : num_of_entry
+ */
+int exfat_get_num_entries(struct exfat_uni_name *p_uniname)
+{
+	int num_entries;
+
+	num_entries = exfat_calc_num_entries(p_uniname);
+	if (num_entries == 0)
+		return -EINVAL;
+
+	return num_entries;
+}
+
+unsigned int exfat_get_entry_type(struct exfat_dentry *ep)
+{
+	if (ep->type == EXFAT_UNUSED)
+		return TYPE_UNUSED;
+	if (IS_EXFAT_DELETED(ep->type))
+		return TYPE_DELETED;
+	if (ep->type == EXFAT_INVAL)
+		return TYPE_INVALID;
+	if (ep->type < 0xA0) {
+		if (ep->type == EXFAT_BITMAP)
+			return TYPE_BITMAP;
+		if (ep->type == EXFAT_UPCASE)
+			return TYPE_UPCASE;
+		if (ep->type == EXFAT_VOLUME)
+			return TYPE_VOLUME;
+		if (ep->type == EXFAT_FILE) {
+			if (le16_to_cpu(ep->file_attr) & ATTR_SUBDIR)
+				return TYPE_DIR;
+			return TYPE_FILE;
+		}
+		return TYPE_CRITICAL_PRI;
+	}
+	if (ep->type < 0xC0) {
+		if (ep->type == EXFAT_GUID)
+			return TYPE_GUID;
+		if (ep->type == EXFAT_PADDING)
+			return TYPE_PADDING;
+		if (ep->type == EXFAT_ACLTAB)
+			return TYPE_ACLTAB;
+		return TYPE_BENIGN_PRI;
+	}
+	if (ep->type < 0xE0) {
+		if (ep->type == EXFAT_STREAM)
+			return TYPE_STREAM;
+		if (ep->type == EXFAT_NAME)
+			return TYPE_EXTEND;
+		if (ep->type == EXFAT_ACL)
+			return TYPE_ACL;
+		return TYPE_CRITICAL_SEC;
+	}
+	return TYPE_BENIGN_SEC;
+}
+
+static void exfat_set_entry_type(struct exfat_dentry *ep, unsigned int type)
+{
+	if (type == TYPE_UNUSED) {
+		ep->type = EXFAT_UNUSED;
+	} else if (type == TYPE_DELETED) {
+		ep->type &= EXFAT_DELETE;
+	} else if (type == TYPE_STREAM) {
+		ep->type = EXFAT_STREAM;
+	} else if (type == TYPE_EXTEND) {
+		ep->type = EXFAT_NAME;
+	} else if (type == TYPE_BITMAP) {
+		ep->type = EXFAT_BITMAP;
+	} else if (type == TYPE_UPCASE) {
+		ep->type = EXFAT_UPCASE;
+	} else if (type == TYPE_VOLUME) {
+		ep->type = EXFAT_VOLUME;
+	} else if (type == TYPE_DIR) {
+		ep->type = EXFAT_FILE;
+		ep->file_attr = ATTR_SUBDIR_LE;
+	} else if (type == TYPE_FILE) {
+		ep->type = EXFAT_FILE;
+		ep->file_attr = ATTR_ARCHIVE_LE;
+	}
+}
+
+void exfat_get_entry_time(struct exfat_dentry *ep, struct exfat_timestamp *tp,
+		unsigned char mode)
+{
+	unsigned short t = 0x00, d = 0x21;
+
+	switch (mode) {
+	case TM_CREATE:
+		t = le16_to_cpu(ep->file_create_time);
+		d = le16_to_cpu(ep->file_create_date);
+		break;
+	case TM_MODIFY:
+		t = le16_to_cpu(ep->file_modify_time);
+		d = le16_to_cpu(ep->file_modify_date);
+		break;
+	case TM_ACCESS:
+		t = le16_to_cpu(ep->file_access_time);
+		d = le16_to_cpu(ep->file_access_date);
+		break;
+	}
+
+	tp->sec  = (t & 0x001F) << 1;
+	tp->min  = (t >> 5) & 0x003F;
+	tp->hour = (t >> 11);
+	tp->day  = (d & 0x001F);
+	tp->mon  = (d >> 5) & 0x000F;
+	tp->year = (d >> 9);
+}
+
+void exfat_set_entry_time(struct exfat_dentry *ep,
+		struct exfat_timestamp *tp, unsigned char mode)
+{
+	unsigned short t, d;
+
+	t = (tp->hour << 11) | (tp->min << 5) | (tp->sec >> 1);
+	d = (tp->year <<  9) | (tp->mon << 5) |  tp->day;
+
+	switch (mode) {
+	case TM_CREATE:
+		ep->file_create_time = cpu_to_le16(t);
+		ep->file_create_date = cpu_to_le16(d);
+		break;
+	case TM_MODIFY:
+		ep->file_modify_time = cpu_to_le16(t);
+		ep->file_modify_date = cpu_to_le16(d);
+		break;
+	case TM_ACCESS:
+		ep->file_access_time = cpu_to_le16(t);
+		ep->file_access_date = cpu_to_le16(d);
+		break;
+	}
+}
+
+static void exfat_init_file_entry(struct super_block *sb,
+		struct exfat_dentry *ep, unsigned int type)
+{
+	struct exfat_timestamp tm, *tp;
+
+	exfat_set_entry_type(ep, type);
+
+	tp = exfat_tm_now(EXFAT_SB(sb), &tm);
+	exfat_set_entry_time(ep, tp, TM_CREATE);
+	exfat_set_entry_time(ep, tp, TM_MODIFY);
+	exfat_set_entry_time(ep, tp, TM_ACCESS);
+	ep->file_create_time_ms = 0;
+	ep->file_modify_time_ms = 0;
+	ep->file_access_time_ms = 0;
+}
+
+static void exfat_init_stream_entry(struct exfat_dentry *ep,
+		unsigned char flags, unsigned int start_clu,
+		unsigned long long size)
+{
+	exfat_set_entry_type(ep, TYPE_STREAM);
+	ep->stream_flags = flags;
+	ep->stream_start_clu = cpu_to_le32(start_clu);
+	ep->stream_valid_size = cpu_to_le64(size);
+	ep->stream_size = cpu_to_le64(size);
+}
+
+static void exfat_init_name_entry(struct exfat_dentry *ep,
+		unsigned short *uniname)
+{
+	int i;
+
+	exfat_set_entry_type(ep, TYPE_EXTEND);
+	ep->name_flags = 0x0;
+
+	for (i = 0; i < 15; i++) {
+		ep->name_unicode[i] = cpu_to_le16(*uniname);
+		if (*uniname == 0x0)
+			break;
+		uniname++;
+	}
+}
+
+int exfat_init_dir_entry(struct inode *inode, struct exfat_chain *p_dir,
+		int entry, unsigned int type, unsigned int start_clu,
+		unsigned long long size)
+{
+	struct super_block *sb = inode->i_sb;
+	sector_t sector;
+	unsigned char flags;
+	struct exfat_dentry *ep;
+	struct buffer_head *bh;
+	int sync = IS_DIRSYNC(inode);
+
+	flags = (type == TYPE_FILE) ? ALLOC_FAT_CHAIN : ALLOC_NO_FAT_CHAIN;
+
+	/*
+	 * We cannot use exfat_get_dentry_set here because file ep is not
+	 * initialized yet.
+	 */
+	ep = exfat_get_dentry(sb, p_dir, entry, &bh, &sector);
+	if (!ep)
+		return -EIO;
+
+	exfat_init_file_entry(sb, ep, type);
+	exfat_update_bh(sb, bh, sync);
+	brelse(bh);
+
+	ep = exfat_get_dentry(sb, p_dir, entry + 1, &bh, &sector);
+	if (!ep)
+		return -EIO;
+
+	exfat_init_stream_entry(ep, flags, start_clu, size);
+	exfat_update_bh(sb, bh, sync);
+	brelse(bh);
+
+	return 0;
+}
+
+int update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
+		int entry)
+{
+	struct super_block *sb = inode->i_sb;
+	int ret = 0;
+	int i, num_entries;
+	sector_t sector;
+	unsigned short chksum;
+	struct exfat_dentry *ep, *fep;
+	struct buffer_head *fbh, *bh;
+
+	fep = exfat_get_dentry(sb, p_dir, entry, &fbh, &sector);
+	if (!fep)
+		return -EIO;
+
+	num_entries = fep->file_num_ext + 1;
+	chksum = exfat_calc_chksum_2byte(fep, DENTRY_SIZE, 0, CS_DIR_ENTRY);
+
+	for (i = 1; i < num_entries; i++) {
+		ep = exfat_get_dentry(sb, p_dir, entry + i, &bh, NULL);
+		if (!ep) {
+			ret = -EIO;
+			goto release_fbh;
+		}
+		chksum = exfat_calc_chksum_2byte(ep, DENTRY_SIZE, chksum,
+				CS_DEFAULT);
+		brelse(bh);
+	}
+
+	fep->file_checksum = cpu_to_le16(chksum);
+	exfat_update_bh(sb, fbh, IS_DIRSYNC(inode));
+release_fbh:
+	brelse(fbh);
+	return ret;
+}
+
+int exfat_init_ext_entry(struct inode *inode, struct exfat_chain *p_dir,
+		int entry, int num_entries, struct exfat_uni_name *p_uniname)
+{
+	struct super_block *sb = inode->i_sb;
+	int i;
+	sector_t sector;
+	unsigned short *uniname = p_uniname->name;
+	struct exfat_dentry *ep;
+	struct buffer_head *bh;
+	int sync = IS_DIRSYNC(inode);
+
+	ep = exfat_get_dentry(sb, p_dir, entry, &bh, &sector);
+	if (!ep)
+		return -EIO;
+
+	ep->file_num_ext = (unsigned char)(num_entries - 1);
+	exfat_update_bh(sb, bh, sync);
+	brelse(bh);
+
+	ep = exfat_get_dentry(sb, p_dir, entry + 1, &bh, &sector);
+	if (!ep)
+		return -EIO;
+
+	ep->stream_name_len = p_uniname->name_len;
+	ep->stream_name_hash = cpu_to_le16(p_uniname->name_hash);
+	exfat_update_bh(sb, bh, sync);
+	brelse(bh);
+
+	for (i = 2; i < num_entries; i++) {
+		ep = exfat_get_dentry(sb, p_dir, entry + i, &bh, &sector);
+		if (!ep)
+			return -EIO;
+
+		exfat_init_name_entry(ep, uniname);
+		exfat_update_bh(sb, bh, sync);
+		brelse(bh);
+		uniname += 15;
+	}
+
+	update_dir_chksum(inode, p_dir, entry);
+	return 0;
+}
+
+int exfat_remove_entries(struct inode *inode, struct exfat_chain *p_dir,
+		int entry, int order, int num_entries)
+{
+	struct super_block *sb = inode->i_sb;
+	int i;
+	sector_t sector;
+	struct exfat_dentry *ep;
+	struct buffer_head *bh;
+
+	for (i = order; i < num_entries; i++) {
+		ep = exfat_get_dentry(sb, p_dir, entry + i, &bh, &sector);
+		if (!ep)
+			return -EIO;
+
+		exfat_set_entry_type(ep, TYPE_DELETED);
+		exfat_update_bh(sb, bh, IS_DIRSYNC(inode));
+		brelse(bh);
+	}
+
+	return 0;
+}
+
+int exfat_update_dir_chksum_with_entry_set(struct super_block *sb,
+		struct exfat_entry_set_cache *es, int sync)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct buffer_head *bh;
+	sector_t sec = es->sector;
+	unsigned int off = es->offset;
+	int chksum_type = CS_DIR_ENTRY, i, num_entries = es->num_entries;
+	unsigned int buf_off = (off - es->offset);
+	unsigned int remaining_byte_in_sector, copy_entries, clu;
+	unsigned short chksum = 0;
+
+	for (i = 0; i < num_entries; i++) {
+		chksum = exfat_calc_chksum_2byte(&es->entries[i], DENTRY_SIZE,
+			chksum, chksum_type);
+		chksum_type = CS_DEFAULT;
+	}
+
+	es->entries[0].file_checksum = cpu_to_le16(chksum);
+
+	while (num_entries) {
+		/* write per sector base */
+		remaining_byte_in_sector = (1 << sb->s_blocksize_bits) - off;
+		copy_entries = min_t(int,
+			EXFAT_B_TO_DEN(remaining_byte_in_sector),
+			num_entries);
+		bh = sb_bread(sb, sec);
+		if (!bh)
+			goto err_out;
+		memcpy(bh->b_data + off,
+			(unsigned char *)&es->entries[0] + buf_off,
+			EXFAT_DEN_TO_B(copy_entries));
+		exfat_update_bh(sb, bh, sync);
+		brelse(bh);
+		num_entries -= copy_entries;
+
+		if (num_entries) {
+			/* get next sector */
+			if (exfat_is_last_sector_in_cluster(sbi, sec)) {
+				clu = exfat_sector_to_cluster(sbi, sec);
+				if (es->alloc_flag == ALLOC_NO_FAT_CHAIN)
+					clu++;
+				else if (exfat_get_next_cluster(sb, &clu))
+					goto err_out;
+				sec = exfat_cluster_to_sector(sbi, clu);
+			} else {
+				sec++;
+			}
+			off = 0;
+			buf_off += EXFAT_DEN_TO_B(copy_entries);
+		}
+	}
+
+	return 0;
+err_out:
+	return -EIO;
+}
+
+static int exfat_walk_fat_chain(struct super_block *sb,
+		struct exfat_chain *p_dir, unsigned int byte_offset,
+		unsigned int *clu)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	unsigned int clu_offset;
+	unsigned int cur_clu;
+
+	clu_offset = EXFAT_B_TO_CLU(byte_offset, sbi);
+	cur_clu = p_dir->dir;
+
+	if (p_dir->flags == ALLOC_NO_FAT_CHAIN) {
+		cur_clu += clu_offset;
+	} else {
+		while (clu_offset > 0) {
+			if (exfat_get_next_cluster(sb, &cur_clu))
+				return -EIO;
+			if (cur_clu == EOF_CLUSTER) {
+				exfat_fs_error(sb,
+					"invalid dentry access beyond EOF (clu : %u, eidx : %d)",
+					p_dir->dir,
+					EXFAT_B_TO_DEN(byte_offset));
+				return -EIO;
+			}
+			clu_offset--;
+		}
+	}
+
+	*clu = cur_clu;
+	return 0;
+}
+
+int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir,
+		int entry, sector_t *sector, int *offset)
+{
+	int ret;
+	unsigned int off, clu = 0;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	off = EXFAT_DEN_TO_B(entry);
+
+	ret = exfat_walk_fat_chain(sb, p_dir, off, &clu);
+	if (ret)
+		return ret;
+
+	/* byte offset in cluster */
+	off = EXFAT_CLU_OFFSET(off, sbi);
+
+	/* byte offset in sector    */
+	*offset = EXFAT_BLK_OFFSET(off, sb);
+
+	/* sector offset in cluster */
+	*sector = EXFAT_B_TO_BLK(off, sb);
+	*sector += exfat_cluster_to_sector(sbi, clu);
+	return 0;
+}
+
+#define EXFAT_MAX_RA_SIZE     (128*1024)
+static int exfat_dir_readahead(struct super_block *sb, sector_t sec)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct buffer_head *bh;
+	unsigned int max_ra_count = EXFAT_MAX_RA_SIZE >> sb->s_blocksize_bits;
+	unsigned int page_ra_count = PAGE_SIZE >> sb->s_blocksize_bits;
+	unsigned int adj_ra_count = max(sbi->sect_per_clus, page_ra_count);
+	unsigned int ra_count = min(adj_ra_count, max_ra_count);
+
+	/* Read-ahead is not required */
+	if (sbi->sect_per_clus == 1)
+		return 0;
+
+	if (sec < sbi->data_start_sector) {
+		exfat_msg(sb, KERN_ERR,
+			"requested sector is invalid(sect:%llu, root:%llu)",
+			sec, sbi->data_start_sector);
+		return -EIO;
+	}
+
+	/* Not sector aligned with ra_count, resize ra_count to page size */
+	if ((sec - sbi->data_start_sector) & (ra_count - 1))
+		ra_count = page_ra_count;
+
+	bh = sb_find_get_block(sb, sec);
+	if (!bh || !buffer_uptodate(bh)) {
+		unsigned int i;
+
+		for (i = 0; i < ra_count; i++)
+			sb_breadahead(sb, (sector_t)(sec + i));
+	}
+	brelse(bh);
+	return 0;
+}
+
+struct exfat_dentry *exfat_get_dentry(struct super_block *sb,
+		struct exfat_chain *p_dir, int entry, struct buffer_head **bh,
+		sector_t *sector)
+{
+	unsigned int dentries_per_page = EXFAT_B_TO_DEN(PAGE_SIZE);
+	int off;
+	sector_t sec;
+
+	if (p_dir->dir == DIR_DELETED) {
+		exfat_msg(sb, KERN_ERR, "abnormal access to deleted dentry\n");
+		return NULL;
+	}
+
+	if (exfat_find_location(sb, p_dir, entry, &sec, &off))
+		return NULL;
+
+	if (p_dir->dir != FREE_CLUSTER &&
+			!(entry & (dentries_per_page - 1)))
+		exfat_dir_readahead(sb, sec);
+
+	*bh = sb_bread(sb, sec);
+	if (!*bh)
+		return NULL;
+
+	if (sector)
+		*sector = sec;
+	return (struct exfat_dentry *)((*bh)->b_data + off);
+}
+
+enum exfat_validate_dentry_mode {
+	ES_MODE_STARTED,
+	ES_MODE_GET_FILE_ENTRY,
+	ES_MODE_GET_STRM_ENTRY,
+	ES_MODE_GET_NAME_ENTRY,
+	ES_MODE_GET_CRITICAL_SEC_ENTRY,
+};
+
+static bool exfat_validate_entry(unsigned int type,
+		enum exfat_validate_dentry_mode *mode)
+{
+	if (type == TYPE_UNUSED || type == TYPE_DELETED)
+		return false;
+
+	switch (*mode) {
+	case ES_MODE_STARTED:
+		if  (type != TYPE_FILE && type != TYPE_DIR)
+			return false;
+		*mode = ES_MODE_GET_FILE_ENTRY;
+		return true;
+	case ES_MODE_GET_FILE_ENTRY:
+		if (type != TYPE_STREAM)
+			return false;
+		*mode = ES_MODE_GET_STRM_ENTRY;
+		return true;
+	case ES_MODE_GET_STRM_ENTRY:
+		if (type != TYPE_EXTEND)
+			return false;
+		*mode = ES_MODE_GET_NAME_ENTRY;
+		return true;
+	case ES_MODE_GET_NAME_ENTRY:
+		if (type == TYPE_STREAM)
+			return false;
+		if (type != TYPE_EXTEND) {
+			if (!(type & TYPE_CRITICAL_SEC))
+				return false;
+			*mode = ES_MODE_GET_CRITICAL_SEC_ENTRY;
+		}
+		return true;
+	case ES_MODE_GET_CRITICAL_SEC_ENTRY:
+		if (type == TYPE_EXTEND || type == TYPE_STREAM)
+			return false;
+		if ((type & TYPE_CRITICAL_SEC) != TYPE_CRITICAL_SEC)
+			return false;
+		return true;
+	default:
+		WARN_ON_ONCE(1);
+		return false;
+	}
+}
+
+/*
+ * Returns a set of dentries for a file or dir.
+ *
+ * Note that this is a copy (dump) of dentries so that user should
+ * call write_entry_set() to apply changes made in this entry set
+ * to the real device.
+ *
+ * in:
+ *   sb+p_dir+entry: indicates a file/dir
+ *   type:  specifies how many dentries should be included.
+ * out:
+ *   file_ep: will point the first dentry(= file dentry) on success
+ * return:
+ *   pointer of entry set on success,
+ *   NULL on failure.
+ */
+struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
+		struct exfat_chain *p_dir, int entry, unsigned int type,
+		struct exfat_dentry **file_ep)
+{
+	int ret;
+	unsigned int off, byte_offset, clu = 0;
+	unsigned int entry_type;
+	sector_t sec;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_entry_set_cache *es;
+	struct exfat_dentry *ep, *pos;
+	unsigned char num_entries;
+	enum exfat_validate_dentry_mode mode = ES_MODE_STARTED;
+	struct buffer_head *bh;
+
+	if (p_dir->dir == DIR_DELETED) {
+		exfat_msg(sb, KERN_ERR, "access to deleted dentry\n");
+		return NULL;
+	}
+
+	byte_offset = EXFAT_DEN_TO_B(entry);
+	ret = exfat_walk_fat_chain(sb, p_dir, byte_offset, &clu);
+	if (ret)
+		return NULL;
+
+	/* byte offset in cluster */
+	byte_offset = EXFAT_CLU_OFFSET(byte_offset, sbi);
+
+	/* byte offset in sector */
+	off = EXFAT_BLK_OFFSET(byte_offset, sb);
+
+	/* sector offset in cluster */
+	sec = EXFAT_B_TO_BLK(byte_offset, sb);
+	sec += exfat_cluster_to_sector(sbi, clu);
+
+	bh = sb_bread(sb, sec);
+	if (!bh)
+		return NULL;
+
+	ep = (struct exfat_dentry *)(bh->b_data + off);
+	entry_type = exfat_get_entry_type(ep);
+
+	if (entry_type != TYPE_FILE && entry_type != TYPE_DIR)
+		goto release_bh;
+
+	num_entries = type == ES_ALL_ENTRIES ? ep->file_num_ext + 1 : type;
+	es = kmalloc(struct_size(es, entries, num_entries), GFP_KERNEL);
+	if (!es)
+		goto release_bh;
+
+	es->num_entries = num_entries;
+	es->sector = sec;
+	es->offset = off;
+	es->alloc_flag = p_dir->flags;
+
+	pos = &es->entries[0];
+
+	while (num_entries) {
+		if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
+			goto free_es;
+
+		/* copy dentry */
+		memcpy(pos, ep, sizeof(struct exfat_dentry));
+
+		if (--num_entries == 0)
+			break;
+
+		if (((off + DENTRY_SIZE) & (sb->s_blocksize - 1)) <
+		    (off & (sb->s_blocksize - 1))) {
+			/* get the next sector */
+			if (exfat_is_last_sector_in_cluster(sbi, sec)) {
+				if (es->alloc_flag == ALLOC_NO_FAT_CHAIN)
+					clu++;
+				else if (exfat_get_next_cluster(sb, &clu))
+					goto free_es;
+				sec = exfat_cluster_to_sector(sbi, clu);
+			} else {
+				sec++;
+			}
+
+			brelse(bh);
+			bh = sb_bread(sb, sec);
+			if (!bh)
+				goto free_es;
+			off = 0;
+			ep = (struct exfat_dentry *)bh->b_data;
+		} else {
+			ep++;
+			off += DENTRY_SIZE;
+		}
+		pos++;
+	}
+
+	if (file_ep)
+		*file_ep = &es->entries[0];
+	brelse(bh);
+	return es;
+
+free_es:
+	kfree(es);
+release_bh:
+	brelse(bh);
+	return NULL;
+}
+
+static int exfat_extract_uni_name(struct exfat_dentry *ep,
+		unsigned short *uniname)
+{
+	int i, len = 0;
+
+	for (i = 0; i < 15; i++) {
+		*uniname = le16_to_cpu(ep->name_unicode[i]);
+		if (*uniname == 0x0)
+			return len;
+		uniname++;
+		len++;
+	}
+
+	*uniname = 0x0;
+	return len;
+
+}
+
+enum {
+	DIRENT_STEP_FILE,
+	DIRENT_STEP_STRM,
+	DIRENT_STEP_NAME,
+	DIRENT_STEP_SECD,
+};
+
+/*
+ * return values:
+ *   >= 0	: return dir entiry position with the name in dir
+ *   -EEXIST	: (root dir, ".") it is the root dir itself
+ *   -ENOENT	: entry with the name does not exist
+ *   -EIO	: I/O error
+ */
+int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
+		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
+		int num_entries, unsigned int type)
+{
+	int i, rewind = 0, dentry = 0, end_eidx = 0, num_ext = 0, len;
+	int order, step, name_len = 0;
+	int dentries_per_clu, num_empty = 0;
+	unsigned int entry_type;
+	unsigned short entry_uniname[16], *uniname = NULL, unichar;
+	struct exfat_chain clu;
+	struct exfat_dentry *ep;
+	struct exfat_hint *hint_stat = &ei->hint_stat;
+	struct exfat_hint_femp candi_empty;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct buffer_head *bh = NULL;
+
+	dentries_per_clu = sbi->dentries_per_clu;
+
+	exfat_chain_dup(&clu, p_dir);
+
+	if (hint_stat->eidx) {
+		clu.dir = hint_stat->clu;
+		dentry = hint_stat->eidx;
+		end_eidx = dentry;
+	}
+
+	candi_empty.eidx = EXFAT_HINT_NONE;
+rewind:
+	order = 0;
+	step = DIRENT_STEP_FILE;
+	while (clu.dir != EOF_CLUSTER) {
+		i = dentry & (dentries_per_clu - 1);
+		for (; i < dentries_per_clu; i++, dentry++) {
+			if (rewind && dentry == end_eidx)
+				goto not_found;
+
+			ep = exfat_get_dentry(sb, &clu, i, &bh, NULL);
+			if (!ep)
+				return -EIO;
+
+			entry_type = exfat_get_entry_type(ep);
+
+			if (entry_type == TYPE_UNUSED ||
+			    entry_type == TYPE_DELETED) {
+				step = DIRENT_STEP_FILE;
+
+				num_empty++;
+				if (candi_empty.eidx == EXFAT_HINT_NONE &&
+						num_empty == 1) {
+					exfat_chain_set(&candi_empty.cur,
+						clu.dir, clu.size, clu.flags);
+				}
+
+				if (candi_empty.eidx == EXFAT_HINT_NONE &&
+						num_empty >= num_entries) {
+					candi_empty.eidx =
+						dentry - (num_empty - 1);
+					WARN_ON(candi_empty.eidx < 0);
+					candi_empty.count = num_empty;
+
+					if (ei->hint_femp.eidx ==
+							EXFAT_HINT_NONE ||
+						candi_empty.eidx <=
+							 ei->hint_femp.eidx) {
+						memcpy(&ei->hint_femp,
+							&candi_empty,
+							sizeof(candi_empty));
+					}
+				}
+
+				brelse(bh);
+				if (entry_type == TYPE_UNUSED)
+					goto not_found;
+				continue;
+			}
+
+			num_empty = 0;
+			candi_empty.eidx = EXFAT_HINT_NONE;
+
+			if (entry_type == TYPE_FILE || entry_type == TYPE_DIR) {
+				step = DIRENT_STEP_FILE;
+				if (type == TYPE_ALL || type == entry_type) {
+					num_ext = ep->file_num_ext;
+					step = DIRENT_STEP_STRM;
+				}
+				brelse(bh);
+				continue;
+			}
+
+			if (entry_type == TYPE_STREAM) {
+				unsigned short name_hash;
+
+				if (step != DIRENT_STEP_STRM) {
+					step = DIRENT_STEP_FILE;
+					brelse(bh);
+					continue;
+				}
+				step = DIRENT_STEP_FILE;
+				name_hash = le16_to_cpu(ep->stream_name_hash);
+				if (p_uniname->name_hash == name_hash &&
+				    p_uniname->name_len ==
+						ep->stream_name_len) {
+					step = DIRENT_STEP_NAME;
+					order = 1;
+					name_len = 0;
+				}
+				brelse(bh);
+				continue;
+			}
+
+			brelse(bh);
+			if (entry_type == TYPE_EXTEND) {
+				if (step != DIRENT_STEP_NAME) {
+					step = DIRENT_STEP_FILE;
+					continue;
+				}
+
+				if (++order == 2)
+					uniname = p_uniname->name;
+				else
+					uniname += 15;
+
+				len = exfat_extract_uni_name(
+						ep, entry_uniname);
+				name_len += len;
+
+				unichar = *(uniname+len);
+				*(uniname+len) = 0x0;
+
+				if (exfat_nls_cmp_uniname(sb, uniname,
+							entry_uniname)) {
+					step = DIRENT_STEP_FILE;
+				} else if (name_len == p_uniname->name_len) {
+					if (order == num_ext)
+						goto found;
+					step = DIRENT_STEP_SECD;
+				}
+
+				*(uniname+len) = unichar;
+				continue;
+			}
+
+			if (entry_type &
+					(TYPE_CRITICAL_SEC | TYPE_BENIGN_SEC)) {
+				if (step == DIRENT_STEP_SECD) {
+					if (++order == num_ext)
+						goto found;
+					continue;
+				}
+			}
+			step = DIRENT_STEP_FILE;
+		}
+
+		if (clu.flags == ALLOC_NO_FAT_CHAIN) {
+			if (--clu.size > 0)
+				clu.dir++;
+			else
+				clu.dir = EOF_CLUSTER;
+		} else {
+			if (exfat_get_next_cluster(sb, &clu.dir))
+				return -EIO;
+		}
+	}
+
+not_found:
+	/*
+	 * We started at not 0 index,so we should try to find target
+	 * from 0 index to the index we started at.
+	 */
+	if (!rewind && end_eidx) {
+		rewind = 1;
+		dentry = 0;
+		clu.dir = p_dir->dir;
+		/* reset empty hint */
+		num_empty = 0;
+		candi_empty.eidx = EXFAT_HINT_NONE;
+		goto rewind;
+	}
+
+	/* initialized hint_stat */
+	hint_stat->clu = p_dir->dir;
+	hint_stat->eidx = 0;
+	return -ENOENT;
+
+found:
+	/* next dentry we'll find is out of this cluster */
+	if (!((dentry + 1) & (dentries_per_clu - 1))) {
+		int ret = 0;
+
+		if (clu.flags == ALLOC_NO_FAT_CHAIN) {
+			if (--clu.size > 0)
+				clu.dir++;
+			else
+				clu.dir = EOF_CLUSTER;
+		} else {
+			ret = exfat_get_next_cluster(sb, &clu.dir);
+		}
+
+		if (ret || clu.dir != EOF_CLUSTER) {
+			/* just initialized hint_stat */
+			hint_stat->clu = p_dir->dir;
+			hint_stat->eidx = 0;
+			return (dentry - num_ext);
+		}
+	}
+
+	hint_stat->clu = clu.dir;
+	hint_stat->eidx = dentry + 1;
+	return dentry - num_ext;
+}
+
+int exfat_count_ext_entries(struct super_block *sb, struct exfat_chain *p_dir,
+		int entry, struct exfat_dentry *ep)
+{
+	int i, count = 0;
+	unsigned int type;
+	struct exfat_dentry *ext_ep;
+	struct buffer_head *bh;
+
+	for (i = 0, entry++; i < ep->file_num_ext; i++, entry++) {
+		ext_ep = exfat_get_dentry(sb, p_dir, entry, &bh, NULL);
+		if (!ext_ep)
+			return -EIO;
+
+		type = exfat_get_entry_type(ext_ep);
+		brelse(bh);
+		if (type == TYPE_EXTEND || type == TYPE_STREAM)
+			count++;
+		else
+			break;
+	}
+	return count;
+}
+
+void exfat_get_uniname_from_ext_entry(struct super_block *sb,
+		struct exfat_chain *p_dir, int entry, unsigned short *uniname)
+{
+	int i;
+	struct exfat_dentry *ep;
+	struct exfat_entry_set_cache *es;
+
+	es = exfat_get_dentry_set(sb, p_dir, entry, ES_ALL_ENTRIES, &ep);
+	if (!es)
+		return;
+
+	if (es->num_entries < 3)
+		goto free_es;
+
+	ep += 2;
+
+	/*
+	 * First entry  : file entry
+	 * Second entry : stream-extension entry
+	 * Third entry  : first file-name entry
+	 * So, the index of first file-name dentry should start from 2.
+	 */
+	for (i = 2; i < es->num_entries; i++, ep++) {
+		/* end of name entry */
+		if (exfat_get_entry_type(ep) != TYPE_EXTEND)
+			goto free_es;
+
+		exfat_extract_uni_name(ep, uniname);
+		uniname += 15;
+	}
+
+free_es:
+	kfree(es);
+}
+
+int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir)
+{
+	int i, count = 0;
+	int dentries_per_clu;
+	unsigned int entry_type;
+	struct exfat_chain clu;
+	struct exfat_dentry *ep;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct buffer_head *bh;
+
+	dentries_per_clu = sbi->dentries_per_clu;
+
+	exfat_chain_dup(&clu, p_dir);
+
+	while (clu.dir != EOF_CLUSTER) {
+		for (i = 0; i < dentries_per_clu; i++) {
+			ep = exfat_get_dentry(sb, &clu, i, &bh, NULL);
+			if (!ep)
+				return -EIO;
+			entry_type = exfat_get_entry_type(ep);
+			brelse(bh);
+
+			if (entry_type == TYPE_UNUSED)
+				return count;
+			if (entry_type != TYPE_DIR)
+				continue;
+			count++;
+		}
+
+		if (clu.flags == ALLOC_NO_FAT_CHAIN) {
+			if (--clu.size > 0)
+				clu.dir++;
+			else
+				clu.dir = EOF_CLUSTER;
+		} else {
+			if (exfat_get_next_cluster(sb, &(clu.dir)))
+				return -EIO;
+		}
+	}
+
+	return count;
+}
-- 
2.17.1


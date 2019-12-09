Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D35C11671B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 07:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfLIGzH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 01:55:07 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:35909 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfLIGzF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:55:05 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191209065500epoutp0314c32e0a0c1536f4f01118e39db02d1c~eoYI4pRDt2191521915epoutp030
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2019 06:55:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191209065500epoutp0314c32e0a0c1536f4f01118e39db02d1c~eoYI4pRDt2191521915epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575874500;
        bh=xHz1N4TniWzPLhUURd9bvlsxiaV9eXS9PErbbEyaTWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YDF2wWxWMA6inyKTEoT7z31/5wpoPtxaIrgBjn5fFIVPWsXobMaLE48tl2jeEmzBK
         l0bbq3/AxnjlWT1oo8BtwPy3TRM+EykCG929qCLcTjmjilYAlIJSR12YiLe+FxXSHO
         T87fddb6YKOKFg1emcx0jc/okZwte3Cf3lrBBDJg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191209065459epcas1p43b2e125e52747b78c0e1dedebf99f5ba~eoYIlknY-1130311303epcas1p4o;
        Mon,  9 Dec 2019 06:54:59 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.162]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47WYpq07KFzMqYkv; Mon,  9 Dec
        2019 06:54:59 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.87.48019.2CFEDED5; Mon,  9 Dec 2019 15:54:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191209065458epcas1p1104c7fa3f7a34164a0b51d902b78af0e~eoYHPe8520411704117epcas1p1M;
        Mon,  9 Dec 2019 06:54:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191209065458epsmtrp2beba265be88c1e0e220535d900a173fb~eoYHO2w-e2760127601epsmtrp2d;
        Mon,  9 Dec 2019 06:54:58 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-8d-5dedefc2cbfe
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        83.48.10238.2CFEDED5; Mon,  9 Dec 2019 15:54:58 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191209065458epsmtip15b6c8dae86f856e97072f024cbc83929~eoYHFWVvo1817618176epsmtip1_;
        Mon,  9 Dec 2019 06:54:58 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v6 02/13] exfat: add super block operations
Date:   Mon,  9 Dec 2019 01:51:37 -0500
Message-Id: <20191209065149.2230-3-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209065149.2230-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmnu6h929jDe7ftrFoXryezWLl6qNM
        Fnv2nmSxuLxrDpvFj+n1Flv+HWG1uPT+A4sDu8f+uWvYPXbfbGDz6NuyitHj8yY5j0Pb37AF
        sEbl2GSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAXaGk
        UJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTA0KNArTswtLs1L10vOz7UyNDAwMgWq
        TMjJuHSgm73gxjzGiq7uj0wNjD3NjF2MnBwSAiYSje9XsnUxcnEICexglGjafJwNJCEk8IlR
        4vdLc4jEN0aJJSvOwXVM3D6HGaJoL6PEuWl+EEVADctX3AdKcHCwCWhL/NkiClIjImAvsXn2
        ARaQGmaBFkaJBad/gDULC1hLNJz9yQJiswioSqx78Y4JpJcXKL7higXELnmJ1RsOgJVzCthI
        vOk5yAQyR0JgAZvE+eZuNogiF4n5b/6wQtjCEq+Ob2GHsKUkPr/bywYyU0KgWuLjfmaIcAej
        xIvvthC2scTN9RtYQUqYBTQl1u/ShwgrSuz8PRfsXWYBPol3X3tYIabwSnS0CUGUqEr0XTrM
        BGFLS3S1f4Ba6iGx4fVXZkiI9DNKHH44lWkCo9wshA0LGBlXMYqlFhTnpqcWGxaYIEfYJkZw
        KtOy2MG455zPIUYBDkYlHl4Fq7exQqyJZcWVuYcYJTiYlUR4l0x8FSvEm5JYWZValB9fVJqT
        WnyI0RQYjhOZpUST84FpNq8k3tDUyNjY2MLEzNzM1FhJnJfjx8VYIYH0xJLU7NTUgtQimD4m
        Dk6pBsaG23qXHL40TFSVn8334EzFY80T3fdnidh+sdz1ZWUHd3fU0gO7TO+w76kQ5y75UnCw
        etfl+a+XJsnOsfggURk6cUHcs3VSplUtD9Z98wt3OtO26OWTDZtiOwMZFN6FCqX1zHsf8bxt
        jbVOGJvDm+DJbeHFe3e79U2PeLvHtEawzfq3/yldgdNKLMUZiYZazEXFiQDpQm7dewMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELMWRmVeSWpSXmKPExsWy7bCSnO6h929jDRYckbFoXryezWLl6qNM
        Fnv2nmSxuLxrDpvFj+n1Flv+HWG1uPT+A4sDu8f+uWvYPXbfbGDz6NuyitHj8yY5j0Pb37AF
        sEZx2aSk5mSWpRbp2yVwZVw60M1ecGMeY0VX90emBsaeZsYuRk4OCQETiYnb5zCD2EICuxkl
        7s1nhohLSxw7cQbI5gCyhSUOHy7uYuQCKvnAKLH34lR2kDibgLbEny2iIOUiAo4SvbsOs4DU
        MAt0MUo8avoGNkdYwFqi4exPFhCbRUBVYt2Ld0wgvbxA8Q1XLCBWyUus3nAArJxTwEbiTc9B
        JohzrCWuvlzKOIGRbwEjwypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOCQ09LcwXh5
        SfwhRgEORiUe3gqbt7FCrIllxZW5hxglOJiVRHiXTHwVK8SbklhZlVqUH19UmpNafIhRmoNF
        SZz3ad6xSCGB9MSS1OzU1ILUIpgsEwenVAPjQos5fDPSPazLBc4c7C5z3BnO3Oj47bugKJNu
        5+G45R6Zv7wXrn61u2CNJeMng/tp56s+Xuu233EyTvXqE868L5u/6K8+9OvO5XcXbD9d6I7+
        HaPwxmb22+hfZ0/IJs9/vJl5Wlmcgu/piTEaXKGq4vueNs+LnrH+x/Lij8Xa8zQZvV+eY5yx
        VYmlOCPRUIu5qDgRAEzI51A1AgAA
X-CMS-MailID: 20191209065458epcas1p1104c7fa3f7a34164a0b51d902b78af0e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191209065458epcas1p1104c7fa3f7a34164a0b51d902b78af0e
References: <20191209065149.2230-1-namjae.jeon@samsung.com>
        <CGME20191209065458epcas1p1104c7fa3f7a34164a0b51d902b78af0e@epcas1p1.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of superblock operations for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/super.c | 738 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 738 insertions(+)
 create mode 100644 fs/exfat/super.c

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
new file mode 100644
index 000000000000..f5d5144bd72a
--- /dev/null
+++ b/fs/exfat/super.c
@@ -0,0 +1,738 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/time.h>
+#include <linux/mount.h>
+#include <linux/cred.h>
+#include <linux/statfs.h>
+#include <linux/seq_file.h>
+#include <linux/blkdev.h>
+#include <linux/fs_struct.h>
+#include <linux/iversion.h>
+#include <linux/nls.h>
+#include <linux/buffer_head.h>
+
+#include "exfat_raw.h"
+#include "exfat_fs.h"
+
+static char exfat_default_iocharset[] = CONFIG_EXFAT_FS_DEFAULT_IOCHARSET;
+static const char exfat_iocharset_with_utf8[] = "iso8859-1";
+static struct kmem_cache *exfat_inode_cachep;
+
+static void exfat_free_iocharset(struct exfat_sb_info *sbi)
+{
+	if (sbi->options.iocharset != exfat_default_iocharset)
+		kfree(sbi->options.iocharset);
+}
+
+static void exfat_put_super(struct super_block *sb)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	mutex_lock(&sbi->s_lock);
+	if (test_and_clear_bit(EXFAT_SB_DIRTY, &sbi->s_state))
+		sync_blockdev(sb->s_bdev);
+	exfat_set_vol_flags(sb, VOL_CLEAN);
+	exfat_free_upcase_table(sb);
+	exfat_free_bitmap(sb);
+	mutex_unlock(&sbi->s_lock);
+
+	if (sbi->nls_io) {
+		unload_nls(sbi->nls_io);
+		sbi->nls_io = NULL;
+	}
+	exfat_free_iocharset(sbi);
+	sb->s_fs_info = NULL;
+	kfree(sbi);
+}
+
+static int exfat_sync_fs(struct super_block *sb, int wait)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	int err = 0;
+
+	/* If there are some dirty buffers in the bdev inode */
+	mutex_lock(&sbi->s_lock);
+	if (test_and_clear_bit(EXFAT_SB_DIRTY, &sbi->s_state)) {
+		sync_blockdev(sb->s_bdev);
+		if (exfat_set_vol_flags(sb, VOL_CLEAN))
+			err = -EIO;
+	}
+	mutex_unlock(&sbi->s_lock);
+	return err;
+}
+
+static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
+{
+	struct super_block *sb = dentry->d_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	unsigned long long id = huge_encode_dev(sb->s_bdev->bd_dev);
+
+	if (sbi->used_clusters == ~0u) {
+		mutex_lock(&sbi->s_lock);
+		if (exfat_count_used_clusters(sb, &sbi->used_clusters)) {
+			mutex_unlock(&sbi->s_lock);
+			return -EIO;
+		}
+		mutex_unlock(&sbi->s_lock);
+	}
+
+	buf->f_type = sb->s_magic;
+	buf->f_bsize = sbi->cluster_size;
+	buf->f_blocks = sbi->num_clusters - 2; /* clu 0 & 1 */
+	buf->f_bfree = buf->f_blocks - sbi->used_clusters;
+	buf->f_bavail = buf->f_bfree;
+	buf->f_fsid.val[0] = (unsigned int)id;
+	buf->f_fsid.val[1] = (unsigned int)(id >> 32);
+	buf->f_namelen = 260;
+	return 0;
+}
+
+static int __exfat_set_vol_flags(struct super_block *sb,
+		unsigned short new_flag, int always_sync)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct pbr64 *bpb;
+	int sync = 0;
+
+	/* flags are not changed */
+	if (sbi->vol_flag == new_flag)
+		return 0;
+
+	sbi->vol_flag = new_flag;
+
+	/* skip updating volume dirty flag,
+	 * if this volume has been mounted with read-only
+	 */
+	if (sb_rdonly(sb))
+		return 0;
+
+	if (!sbi->pbr_bh) {
+		sbi->pbr_bh = sb_bread(sb, 0);
+		if (!sbi->pbr_bh) {
+			exfat_msg(sb, KERN_ERR, "failed to read boot sector");
+			return -ENOMEM;
+		}
+	}
+
+	bpb = (struct pbr64 *)sbi->pbr_bh->b_data;
+	bpb->bsx.vol_flags = cpu_to_le16(new_flag);
+
+	if (always_sync)
+		sync = 1;
+	else if ((new_flag == VOL_DIRTY) && (!buffer_dirty(sbi->pbr_bh)))
+		sync = 1;
+	else
+		sync = 0;
+
+	set_buffer_uptodate(sbi->pbr_bh);
+	mark_buffer_dirty(sbi->pbr_bh);
+
+	if (sync)
+		sync_dirty_buffer(sbi->pbr_bh);
+	return 0;
+}
+
+int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
+{
+	return __exfat_set_vol_flags(sb, new_flag, 0);
+}
+
+static int exfat_show_options(struct seq_file *m, struct dentry *root)
+{
+	struct super_block *sb = root->d_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_mount_options *opts = &sbi->options;
+
+	/* Show partition info */
+	if (!uid_eq(opts->fs_uid, GLOBAL_ROOT_UID))
+		seq_printf(m, ",uid=%u",
+				from_kuid_munged(&init_user_ns, opts->fs_uid));
+	if (!gid_eq(opts->fs_gid, GLOBAL_ROOT_GID))
+		seq_printf(m, ",gid=%u",
+				from_kgid_munged(&init_user_ns, opts->fs_gid));
+	seq_printf(m, ",fmask=%04o,dmask=%04o", opts->fs_fmask, opts->fs_dmask);
+	if (opts->allow_utime)
+		seq_printf(m, ",allow_utime=%04o", opts->allow_utime);
+	if (sbi->nls_io)
+		seq_printf(m, ",iocharset=%s", sbi->nls_io->charset);
+	if (opts->utf8)
+		seq_puts(m, ",utf8");
+	seq_printf(m, ",case_sensitive=%u", opts->case_sensitive);
+	if (opts->tz_utc)
+		seq_puts(m, ",tz=UTC");
+	seq_printf(m, ",bps=%ld", sb->s_blocksize);
+	if (opts->errors == EXFAT_ERRORS_CONT)
+		seq_puts(m, ",errors=continue");
+	else if (opts->errors == EXFAT_ERRORS_PANIC)
+		seq_puts(m, ",errors=panic");
+	else
+		seq_puts(m, ",errors=remount-ro");
+	if (opts->discard)
+		seq_puts(m, ",discard");
+	return 0;
+}
+
+static struct inode *exfat_alloc_inode(struct super_block *sb)
+{
+	struct exfat_inode_info *ei;
+
+	ei = kmem_cache_alloc(exfat_inode_cachep, GFP_NOFS);
+	if (!ei)
+		return NULL;
+
+	init_rwsem(&ei->truncate_lock);
+	return &ei->vfs_inode;
+}
+
+static void exfat_destroy_inode(struct inode *inode)
+{
+	kmem_cache_free(exfat_inode_cachep, EXFAT_I(inode));
+}
+
+static const struct super_operations exfat_sops = {
+	.alloc_inode   = exfat_alloc_inode,
+	.destroy_inode = exfat_destroy_inode,
+	.write_inode   = exfat_write_inode,
+	.evict_inode  = exfat_evict_inode,
+	.put_super     = exfat_put_super,
+	.sync_fs       = exfat_sync_fs,
+	.statfs        = exfat_statfs,
+	.show_options  = exfat_show_options,
+};
+
+enum {
+	Opt_uid,
+	Opt_gid,
+	Opt_umask,
+	Opt_dmask,
+	Opt_fmask,
+	Opt_allow_utime,
+	Opt_charset,
+	Opt_utf8,
+	Opt_case_sensitive,
+	Opt_tz,
+	Opt_errors,
+	Opt_discard,
+};
+
+static const struct fs_parameter_spec exfat_param_specs[] = {
+	fsparam_u32("uid",			Opt_uid),
+	fsparam_u32("gid",			Opt_gid),
+	fsparam_u32oct("umask",			Opt_umask),
+	fsparam_u32oct("dmask",			Opt_dmask),
+	fsparam_u32oct("fmask",			Opt_fmask),
+	fsparam_u32oct("allow_utime",		Opt_allow_utime),
+	fsparam_string("iocharset",		Opt_charset),
+	fsparam_flag("utf8",			Opt_utf8),
+	fsparam_flag("case_sensitive",		Opt_case_sensitive),
+	fsparam_string("tz",			Opt_tz),
+	fsparam_enum("errors",			Opt_errors),
+	fsparam_flag("discard",			Opt_discard),
+	{}
+};
+
+static const struct fs_parameter_enum exfat_param_enums[] = {
+	{ Opt_errors,	"continue",		EXFAT_ERRORS_CONT },
+	{ Opt_errors,	"panic",		EXFAT_ERRORS_PANIC },
+	{ Opt_errors,	"remount-ro",		EXFAT_ERRORS_RO },
+	{}
+};
+
+static const struct fs_parameter_description exfat_parameters = {
+	.name		= "exfat",
+	.specs		= exfat_param_specs,
+	.enums		= exfat_param_enums,
+};
+
+static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct exfat_sb_info *sbi = fc->s_fs_info;
+	struct exfat_mount_options *opts = &sbi->options;
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, &exfat_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_uid:
+		opts->fs_uid = make_kuid(current_user_ns(), result.uint_32);
+		break;
+	case Opt_gid:
+		opts->fs_gid = make_kgid(current_user_ns(), result.uint_32);
+		break;
+	case Opt_umask:
+		opts->fs_fmask = result.uint_32;
+		opts->fs_dmask = result.uint_32;
+		break;
+	case Opt_dmask:
+		opts->fs_dmask = result.uint_32;
+		break;
+	case Opt_fmask:
+		opts->fs_fmask = result.uint_32;
+		break;
+	case Opt_allow_utime:
+		opts->allow_utime = result.uint_32 & 0022;
+		break;
+	case Opt_charset:
+		exfat_free_iocharset(sbi);
+		opts->iocharset = kstrdup(param->string, GFP_KERNEL);
+		if (!opts->iocharset)
+			return -ENOMEM;
+		break;
+	case Opt_case_sensitive:
+		opts->case_sensitive = 1;
+		break;
+	case Opt_utf8:
+		opts->utf8 = 1;
+		break;
+	case Opt_tz:
+		if (!strcmp(param->string, "UTC"))
+			opts->tz_utc = 1;
+		break;
+	case Opt_errors:
+		opts->errors = result.uint_32;
+		break;
+	case Opt_discard:
+		opts->discard = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void exfat_hash_init(struct super_block *sb)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	int i;
+
+	spin_lock_init(&sbi->inode_hash_lock);
+	for (i = 0; i < EXFAT_HASH_SIZE; i++)
+		INIT_HLIST_HEAD(&sbi->inode_hashtable[i]);
+}
+
+static int exfat_read_root(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+	struct exfat_chain cdir;
+	int num_subdirs, num_clu = 0;
+
+	exfat_chain_set(&ei->dir, sbi->root_dir, 0, ALLOC_FAT_CHAIN);
+	ei->entry = -1;
+	ei->start_clu = sbi->root_dir;
+	ei->flags = ALLOC_FAT_CHAIN;
+	ei->type = TYPE_DIR;
+	ei->version = 0;
+	ei->rwoffset = 0;
+	ei->hint_bmap.off = EOF_CLUSTER;
+	ei->hint_stat.eidx = 0;
+	ei->hint_stat.clu = sbi->root_dir;
+	ei->hint_femp.eidx = EXFAT_HINT_NONE;
+
+	exfat_chain_set(&cdir, sbi->root_dir, 0, ALLOC_FAT_CHAIN);
+	if (exfat_count_num_clusters(sb, &cdir, &num_clu))
+		return -EIO;
+	i_size_write(inode, num_clu << sbi->cluster_size_bits);
+
+	num_subdirs = exfat_count_dir_entries(sb, &cdir);
+	if (num_subdirs < 0)
+		return -EIO;
+	set_nlink(inode, num_subdirs + EXFAT_MIN_SUBDIR);
+
+	inode->i_uid = sbi->options.fs_uid;
+	inode->i_gid = sbi->options.fs_gid;
+	inode_inc_iversion(inode);
+	inode->i_generation = 0;
+	inode->i_mode = exfat_make_mode(sbi, ATTR_SUBDIR, 0777);
+	inode->i_op = &exfat_dir_inode_operations;
+	inode->i_fop = &exfat_dir_operations;
+
+	inode->i_blocks = ((i_size_read(inode) + (sbi->cluster_size - 1))
+			& ~(sbi->cluster_size - 1)) >> inode->i_blkbits;
+	EXFAT_I(inode)->i_pos = ((loff_t)sbi->root_dir << 32) | 0xffffffff;
+	EXFAT_I(inode)->i_size_aligned = i_size_read(inode);
+	EXFAT_I(inode)->i_size_ondisk = i_size_read(inode);
+
+	exfat_save_attr(inode, ATTR_SUBDIR);
+	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	exfat_cache_init_inode(inode);
+	return 0;
+}
+
+static bool is_exfat(struct pbr *pbr)
+{
+	int i = 53;
+
+	do {
+		if (pbr->bpb.f64.res_zero[i - 1])
+			break;
+	} while (--i);
+	return i ? false : true;
+}
+
+static struct pbr *exfat_read_pbr_with_logical_sector(struct super_block *sb,
+		struct buffer_head **prev_bh)
+{
+	struct pbr *p_pbr = (struct pbr *) (*prev_bh)->b_data;
+	unsigned short logical_sect = 0;
+
+	logical_sect = 1 << p_pbr->bsx.f64.sect_size_bits;
+
+	if (!is_power_of_2(logical_sect) ||
+	    logical_sect < 512 || logical_sect > 4096) {
+		exfat_msg(sb, KERN_ERR, "bogus logical sector size %u",
+				logical_sect);
+		return NULL;
+	}
+
+	if (logical_sect < sb->s_blocksize) {
+		exfat_msg(sb, KERN_ERR,
+			"logical sector size too small for device (logical sector size = %u)",
+			logical_sect);
+		return NULL;
+	}
+
+	if (logical_sect > sb->s_blocksize) {
+		struct buffer_head *bh = NULL;
+
+		__brelse(*prev_bh);
+		*prev_bh = NULL;
+
+		if (!sb_set_blocksize(sb, logical_sect)) {
+			exfat_msg(sb, KERN_ERR,
+				"unable to set blocksize %u", logical_sect);
+			return NULL;
+		}
+		bh = sb_bread(sb, 0);
+		if (!bh) {
+			exfat_msg(sb, KERN_ERR,
+				"unable to read boot sector (logical sector size = %lu)",
+				sb->s_blocksize);
+			return NULL;
+		}
+
+		*prev_bh = bh;
+		p_pbr = (struct pbr *) bh->b_data;
+	}
+	return p_pbr;
+}
+
+/* mount the file system volume */
+static int __exfat_fill_super(struct super_block *sb)
+{
+	int ret;
+	struct pbr *p_pbr;
+	struct pbr64 *p_bpb;
+	struct buffer_head *bh;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	/* set block size to read super block */
+	sb_min_blocksize(sb, 512);
+
+	/* read boot sector */
+	bh = sb_bread(sb, 0);
+	if (!bh) {
+		exfat_msg(sb, KERN_ERR, "unable to read boot sector");
+		return -EIO;
+	}
+
+	/* PRB is read */
+	p_pbr = (struct pbr *)bh->b_data;
+
+	/* check the validity of PBR */
+	if (le16_to_cpu((p_pbr->signature)) != PBR_SIGNATURE) {
+		exfat_msg(sb, KERN_ERR, "invalid boot record signature");
+		ret = -EINVAL;
+		goto free_bh;
+	}
+
+
+	/* check logical sector size */
+	p_pbr = exfat_read_pbr_with_logical_sector(sb, &bh);
+	if (!p_pbr) {
+		ret = -EIO;
+		goto free_bh;
+	}
+
+	if (!is_exfat(p_pbr)) {
+		ret = -EINVAL;
+		goto free_bh;
+	}
+
+	/* set maximum file size for exFAT */
+	sb->s_maxbytes = 0x7fffffffffffffffLL;
+
+	p_bpb = (struct pbr64 *)p_pbr;
+	if (!p_bpb->bsx.num_fats) {
+		exfat_msg(sb, KERN_ERR, "bogus number of FAT structure");
+		ret = -EINVAL;
+		goto free_bh;
+	}
+
+	sbi->sect_per_clus = 1 << p_bpb->bsx.sect_per_clus_bits;
+	sbi->sect_per_clus_bits = p_bpb->bsx.sect_per_clus_bits;
+	sbi->cluster_size_bits = sbi->sect_per_clus_bits + sb->s_blocksize_bits;
+	sbi->cluster_size = 1 << sbi->cluster_size_bits;
+	sbi->num_FAT_sectors = le32_to_cpu(p_bpb->bsx.fat_length);
+	sbi->FAT1_start_sector = le32_to_cpu(p_bpb->bsx.fat_offset);
+	sbi->FAT2_start_sector = p_bpb->bsx.num_fats == 1 ?
+		sbi->FAT1_start_sector :
+			sbi->FAT1_start_sector + sbi->num_FAT_sectors;
+	sbi->root_start_sector = le32_to_cpu(p_bpb->bsx.clu_offset);
+	sbi->data_start_sector = sbi->root_start_sector;
+	sbi->num_sectors = le64_to_cpu(p_bpb->bsx.vol_length);
+	/* because the cluster index starts with 2 */
+	sbi->num_clusters = le32_to_cpu(p_bpb->bsx.clu_count) + 2;
+
+	sbi->vol_id = le32_to_cpu(p_bpb->bsx.vol_serial);
+	sbi->root_dir = le32_to_cpu(p_bpb->bsx.root_cluster);
+	sbi->dentries_in_root = 0;
+	sbi->dentries_per_clu = 1 <<
+		(sbi->cluster_size_bits - DENTRY_SIZE_BITS);
+
+	sbi->vol_flag = le16_to_cpu(p_bpb->bsx.vol_flags);
+	sbi->clu_srch_ptr = BASE_CLUSTER;
+	sbi->used_clusters = ~0u;
+
+	if (le16_to_cpu(p_bpb->bsx.vol_flags) & VOL_DIRTY) {
+		sbi->vol_flag |= VOL_DIRTY;
+		exfat_msg(sb, KERN_WARNING,
+			"Volume was not properly unmounted. Some data may be corrupt. Please run fsck.");
+	}
+
+	ret = exfat_create_upcase_table(sb);
+	if (ret) {
+		exfat_msg(sb, KERN_ERR, "failed to load upcase table");
+		goto free_bh;
+	}
+
+	/* allocate-bitmap is only for exFAT */
+	ret = exfat_load_bitmap(sb);
+	if (ret) {
+		exfat_msg(sb, KERN_ERR, "failed to load alloc-bitmap");
+		goto free_upcase_table;
+	}
+
+	ret = exfat_count_used_clusters(sb, &sbi->used_clusters);
+	if (ret) {
+		exfat_msg(sb, KERN_ERR, "failed to scan clusters");
+		goto free_alloc_bitmap;
+	}
+
+	return 0;
+
+free_alloc_bitmap:
+	exfat_free_bitmap(sb);
+free_upcase_table:
+	exfat_free_upcase_table(sb);
+free_bh:
+	brelse(bh);
+	return ret;
+}
+
+static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct exfat_sb_info *sbi = sb->s_fs_info;
+	struct exfat_mount_options *opts = &sbi->options;
+	struct inode *root_inode;
+	int err;
+
+	if (opts->allow_utime == (unsigned short)-1)
+		opts->allow_utime = ~opts->fs_dmask & 0022;
+
+	if (opts->utf8 && strcmp(opts->iocharset, exfat_iocharset_with_utf8)) {
+		exfat_msg(sb, KERN_WARNING,
+			"utf8 enabled, \"iocharset=%s\" is recommended",
+			exfat_iocharset_with_utf8);
+	}
+
+	if (opts->discard) {
+		struct request_queue *q = bdev_get_queue(sb->s_bdev);
+
+		if (!blk_queue_discard(q))
+			exfat_msg(sb, KERN_WARNING,
+				"mounting with \"discard\" option, but the device does not support discard");
+		opts->discard = 0;
+	}
+
+	sb->s_flags |= SB_NODIRATIME;
+	sb->s_magic = EXFAT_SUPER_MAGIC;
+	sb->s_op = &exfat_sops;
+
+	sb->s_d_op = EXFAT_SB(sb)->options.case_sensitive ?
+			&exfat_dentry_ops : &exfat_ci_dentry_ops;
+
+	err = __exfat_fill_super(sb);
+	if (err) {
+		exfat_msg(sb, KERN_ERR, "failed to recognize exfat type");
+		goto check_nls_io;
+	}
+
+	/* set up enough so that it can read an inode */
+	exfat_hash_init(sb);
+
+	sbi->nls_io = load_nls(sbi->options.iocharset);
+	if (!sbi->nls_io) {
+		exfat_msg(sb, KERN_ERR, "IO charset %s not found",
+				sbi->options.iocharset);
+		err = -EINVAL;
+		goto free_table;
+	}
+
+	root_inode = new_inode(sb);
+	if (!root_inode) {
+		exfat_msg(sb, KERN_ERR, "failed to allocate root inode.");
+		err = -ENOMEM;
+		goto free_table;
+	}
+
+	root_inode->i_ino = EXFAT_ROOT_INO;
+	inode_set_iversion(root_inode, 1);
+	err = exfat_read_root(root_inode);
+	if (err) {
+		exfat_msg(sb, KERN_ERR, "failed to initialize root inode.");
+		goto put_inode;
+	}
+
+	exfat_hash_inode(root_inode, EXFAT_I(root_inode)->i_pos);
+	insert_inode_hash(root_inode);
+
+	sb->s_root = d_make_root(root_inode);
+	if (!sb->s_root) {
+		exfat_msg(sb, KERN_ERR, "failed to get the root dentry");
+		err = -ENOMEM;
+		goto put_inode;
+	}
+
+	return 0;
+
+put_inode:
+	iput(root_inode);
+	sb->s_root = NULL;
+
+free_table:
+	exfat_free_upcase_table(sb);
+	exfat_free_bitmap(sb);
+
+check_nls_io:
+	if (sbi->nls_io)
+		unload_nls(sbi->nls_io);
+	exfat_free_iocharset(sbi);
+	sb->s_fs_info = NULL;
+	kfree(sbi);
+	return err;
+}
+
+static int exfat_get_tree(struct fs_context *fc)
+{
+	return get_tree_bdev(fc, exfat_fill_super);
+}
+
+static void exfat_free(struct fs_context *fc)
+{
+	kfree(fc->s_fs_info);
+}
+
+static const struct fs_context_operations exfat_context_ops = {
+	.parse_param	= exfat_parse_param,
+	.get_tree	= exfat_get_tree,
+	.free		= exfat_free,
+};
+
+static int exfat_init_fs_context(struct fs_context *fc)
+{
+	struct exfat_sb_info *sbi;
+
+	sbi = kzalloc(sizeof(struct exfat_sb_info), GFP_KERNEL);
+	if (!sbi)
+		return -ENOMEM;
+
+	mutex_init(&sbi->s_lock);
+	ratelimit_state_init(&sbi->ratelimit, DEFAULT_RATELIMIT_INTERVAL,
+			DEFAULT_RATELIMIT_BURST);
+
+	sbi->options.fs_uid = current_uid();
+	sbi->options.fs_gid = current_gid();
+	sbi->options.fs_fmask = current->fs->umask;
+	sbi->options.fs_dmask = current->fs->umask;
+	sbi->options.allow_utime = -1;
+	sbi->options.iocharset = exfat_default_iocharset;
+	sbi->options.errors = EXFAT_ERRORS_RO;
+
+	fc->s_fs_info = sbi;
+	fc->ops = &exfat_context_ops;
+	return 0;
+}
+
+static struct file_system_type exfat_fs_type = {
+	.owner			= THIS_MODULE,
+	.name			= "exfat",
+	.init_fs_context	= exfat_init_fs_context,
+	.parameters		= &exfat_parameters,
+	.kill_sb		= kill_block_super,
+	.fs_flags		= FS_REQUIRES_DEV,
+};
+
+static void exfat_inode_init_once(void *foo)
+{
+	struct exfat_inode_info *ei = (struct exfat_inode_info *)foo;
+
+	INIT_HLIST_NODE(&ei->i_hash_fat);
+	inode_init_once(&ei->vfs_inode);
+}
+
+static int __init init_exfat_fs(void)
+{
+	int err;
+
+	err = exfat_cache_init();
+	if (err)
+		return err;
+
+	exfat_inode_cachep = kmem_cache_create("exfat_inode_cache",
+			sizeof(struct exfat_inode_info),
+			0, SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD,
+			exfat_inode_init_once);
+	if (!exfat_inode_cachep) {
+		err = -ENOMEM;
+		goto shutdown_cache;
+	}
+
+	err = register_filesystem(&exfat_fs_type);
+	if (err)
+		goto destroy_cache;
+
+	return 0;
+
+destroy_cache:
+	kmem_cache_destroy(exfat_inode_cachep);
+shutdown_cache:
+	exfat_cache_shutdown();
+	return err;
+}
+
+static void __exit exit_exfat_fs(void)
+{
+	kmem_cache_destroy(exfat_inode_cachep);
+	unregister_filesystem(&exfat_fs_type);
+	exfat_cache_shutdown();
+}
+
+module_init(init_exfat_fs);
+module_exit(exit_exfat_fs);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("exFAT filesystem support");
+MODULE_AUTHOR("Samsung Electronics Co., Ltd.");
-- 
2.17.1


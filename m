Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2642B8A3B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 18:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfHLQsh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 12:48:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44586 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfHLQsd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:48:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so105156469wrf.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 09:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UczqfH4bYOE65pbXyRKO1bR+3Ju5QKOC02d244sFq8o=;
        b=MkfhYJgzt2Pm+h1eHxzprM5+BFaC8O4SmO0JyPavHVfMGhXzQPFhhvHZCnDi9S9onH
         72uOdwLNfR40tZzG1q/3YQGuVPDlIC478TUvrby0vDfzuqQ6892uYWkI4hpWBjYpsPY7
         Cwno8SgjWS2zUGE/G0s7gMp71vKIZ2G1LWzgLD1lq9IGTRyt+zWecWtAw4xl9hesh3fe
         2kZrTIkeaFbJA37h7Lzj+OIxTU6f0zq7sJJ0jTE7z+vSAh+XrnK8o2EPF9QgOyda3thF
         zpMwrVVJqK/5Pnny7P1qWWECozt3z4HGc1ZXnMBXecLei8nYgRy2mSPa3BmWCNQVxD16
         dIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UczqfH4bYOE65pbXyRKO1bR+3Ju5QKOC02d244sFq8o=;
        b=DOpLK6yoQq07q1L3NQJcdXi6F5bQO/AVQFE99Yt4nBTvZ/olSEaIe5JPruqHM/xFUP
         67KHxDri6Y/IrbUJ+UsrWHtWESQE2T9sYsjhNUJNXjjTGBKd2ADMcm4LsbbQQBzwSFHy
         gMrot+nnpQN6mMYCZjFIaLyxFDa7UwM78I5RgpK9EglubmATP0uev5JEA2C5QKJOgD66
         dR9esLq04S9UrPylfxBh5nwxnW+XaCHB/CF9Vs2Nhj8kzGqXLj0J8vjz54LpiQybutmj
         zNpmikFwxwjiNvNc45tyKxm00R+QSC7ITV7K1Ixg6VYWTjVGpW9xbPc4YzFjN2Wfulxf
         4RLA==
X-Gm-Message-State: APjAAAVlO785cXs2dwLBZd0IsQw3NB7VqcPJK8mj/ddu5m14JDvAgYbJ
        9SbtkmO4vNP3f9BXb0OgiNpM3Obeojw=
X-Google-Smtp-Source: APXvYqz1C0tmNVBUysz55dsd3g1tQ/5s7Uoq/uKOLtDYZbiqVkGfrlvweNN35gQTlGlhDw74viE6fw==
X-Received: by 2002:adf:a1de:: with SMTP id v30mr6580314wrv.138.1565628509249;
        Mon, 12 Aug 2019 09:48:29 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.211.18])
        by smtp.googlemail.com with ESMTPSA id c187sm121285wmd.39.2019.08.12.09.48.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 09:48:28 -0700 (PDT)
From:   Boaz Harrosh <boaz@plexistor.com>
X-Google-Original-From: Boaz Harrosh <boazh@netapp.com>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Amit Golander <Amit.Golander@netapp.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 07/16] zuf: mounting
Date:   Mon, 12 Aug 2019 19:47:57 +0300
Message-Id: <20190812164806.15852-8-boazh@netapp.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812164806.15852-1-boazh@netapp.com>
References: <20190812164806.15852-1-boazh@netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In this patch we already establish a mounted filesystem.

These are the steps for mounting a zufs Filesystem:

* All devices (Single or DT) are opened and established in an md
  object.

* mount_bdev is called with the main (first) device, in turn
  fill_supper is called.

* fill_supper despatches a mount_operation(register_fs_info) to the
  server with an sb_id of the newly created super_block.

*  The Server at the zus mount routine. Will first thing do
  a GRAB_PMEM(sb_id) ioctl call to establish a special filehandle
  through which it will have full access to the all of its pmem space.
  With that it will call the zusFS to continue to inspect the content
  of devices and mount the FS.

* On return from mount the zusFS returns the root inode info

* fill_supper continues to create a root vfs-inode and returns
  successfully.

* We now have a mounted super_block, with corresponding super_block
  objects in the Server.

* Also in this patch global sb operations like statfs show-options
  and remount. And the destruction of a super_block.

* There is a special support for a "private-mounting" of devices.
  private-mounting is usually used by the zusFS fschk/mkfs type
  applications that want a full access and lockdown of its multy-devices.
  But otherwise wants an exclusive access to these devices. The private
  mount exposes all the same services to the Server application. But
  there is no registered/mounted super_block in VFS.
  This is a very powerful tool for zusFS development because the same
  exact code that is used in a running FS is also used for the FS-utils.
  Infact in zus the code feels exactly the same as a live mount.
  (See the zus project for more info)

Signed-off-by: Boaz Harrosh <boazh@netapp.com>
---
 fs/zuf/Makefile   |   2 +-
 fs/zuf/_extern.h  |   7 +
 fs/zuf/inode.c    |  23 ++
 fs/zuf/super.c    | 777 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/zuf/zuf-core.c |  95 ++++++
 fs/zuf/zuf.h      | 119 +++++++
 fs/zuf/zus_api.h  |  35 +++
 7 files changed, 1055 insertions(+), 3 deletions(-)
 create mode 100644 fs/zuf/inode.c

diff --git a/fs/zuf/Makefile b/fs/zuf/Makefile
index a247bd85d9aa..a5800cad73fd 100644
--- a/fs/zuf/Makefile
+++ b/fs/zuf/Makefile
@@ -17,5 +17,5 @@ zuf-y += md.o t1.o t2.o
 zuf-y += zuf-core.o zuf-root.o
 
 # Main FS
-zuf-y += super.o
+zuf-y += super.o inode.o
 zuf-y += module.o
diff --git a/fs/zuf/_extern.h b/fs/zuf/_extern.h
index a5929d3d165c..ba6d11b509d5 100644
--- a/fs/zuf/_extern.h
+++ b/fs/zuf/_extern.h
@@ -57,6 +57,13 @@ struct dentry *zuf_mount(struct file_system_type *fs_type, int flags,
 struct super_block *zuf_sb_from_id(struct zuf_root_info *zri, __u64 sb_id,
 				   struct zus_sb_info *zus_sbi);
 
+int zuf_private_mount(struct zuf_root_info *zri, struct register_fs_info *rfi,
+		      struct zufs_mount_info *zmi, struct super_block **sb_out);
+int zuf_private_umount(struct zuf_root_info *zri, struct super_block *sb);
+
+/* inode.c */
+struct inode *zuf_iget(struct super_block *sb, struct zus_inode_info *zus_ii,
+		       zu_dpp_t _zi, bool *exist);
 /* t1.c */
 int zuf_pmem_mmap(struct file *file, struct vm_area_struct *vma);
 
diff --git a/fs/zuf/inode.c b/fs/zuf/inode.c
new file mode 100644
index 000000000000..a6115289dcda
--- /dev/null
+++ b/fs/zuf/inode.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BRIEF DESCRIPTION
+ *
+ * Inode methods (allocate/free/read/write).
+ *
+ * Copyright (c) 2018 NetApp Inc. All rights reserved.
+ *
+ * ZUFS-License: GPL-2.0. See module.c for LICENSE details.
+ *
+ * Authors:
+ *	Boaz Harrosh <boazh@netapp.com>
+ *	Sagi Manole <sagim@netapp.com>"
+ */
+
+#include "zuf.h"
+
+struct inode *zuf_iget(struct super_block *sb, struct zus_inode_info *zus_ii,
+		       zu_dpp_t _zi, bool *exist)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
diff --git a/fs/zuf/super.c b/fs/zuf/super.c
index 2248ee74e4c2..859d4e3884ec 100644
--- a/fs/zuf/super.c
+++ b/fs/zuf/super.c
@@ -18,12 +18,737 @@
 
 #include "zuf.h"
 
+static struct super_operations zuf_sops;
 static struct kmem_cache *zuf_inode_cachep;
 
+enum {
+	Opt_uid,
+	Opt_gid,
+	Opt_pedantic,
+	Opt_ephemeral,
+	Opt_dax,
+	Opt_zpmdev,
+	Opt_err
+};
+
+static const match_table_t tokens = {
+	{ Opt_pedantic,		"pedantic"		},
+	{ Opt_pedantic,		"pedantic=%d"		},
+	{ Opt_ephemeral,	"ephemeral"		},
+	{ Opt_dax,		"dax"			},
+	{ Opt_zpmdev,		ZUFS_PMDEV_OPT"=%s"	},
+	{ Opt_err,		NULL			},
+};
+
+static int _parse_options(struct zuf_sb_info *sbi, const char *data,
+			  bool remount, struct zufs_parse_options *po)
+{
+	char *orig_options, *options;
+	char *p;
+	substring_t args[MAX_OPT_ARGS];
+	int err = 0;
+	bool ephemeral = false;
+	bool silent = test_opt(sbi, SILENT);
+	size_t mount_options_len = 0;
+
+	/* no options given */
+	if (!data)
+		return 0;
+
+	options = orig_options = kstrdup(data, GFP_KERNEL);
+	if (!options) {
+		zuf_err_cnd(silent, "kstrdup => -ENOMEM\n");
+		return -ENOMEM;
+	}
+
+	while ((p = strsep(&options, ",")) != NULL) {
+		int token;
+
+		if (!*p)
+			continue;
+
+		/* Initialize args struct so we know whether arg was found */
+		args[0].to = args[0].from = NULL;
+		token = match_token(p, tokens, args);
+		switch (token) {
+		case Opt_pedantic:
+			if (!args[0].from) {
+				po->mount_flags |= ZUFS_M_PEDANTIC;
+				set_opt(sbi, PEDANTIC);
+				continue;
+			}
+			if (match_int(&args[0], &po->pedantic))
+				goto bad_opt;
+			break;
+		case Opt_ephemeral:
+			po->mount_flags |= ZUFS_M_EPHEMERAL;
+			set_opt(sbi, EPHEMERAL);
+			ephemeral = true;
+			break;
+		case Opt_dax:
+			set_opt(sbi, DAX);
+			break;
+		case Opt_zpmdev:
+			if (unlikely(!test_opt(sbi, PRIVATE)))
+				goto bad_opt;
+			sbi->pmount_dev = match_strdup(&args[0]);
+			if (sbi->pmount_dev == NULL)
+				goto no_mem;
+			break;
+		default: {
+			if (mount_options_len != 0) {
+				po->mount_options[mount_options_len] = ',';
+				mount_options_len++;
+			}
+			strcat(po->mount_options, p);
+			mount_options_len += strlen(p);
+		}
+		}
+	}
+
+	if (remount && test_opt(sbi, EPHEMERAL) && (ephemeral == false))
+		clear_opt(sbi, EPHEMERAL);
+out:
+	kfree(orig_options);
+	return err;
+
+bad_opt:
+	zuf_warn_cnd(silent, "Bad mount option: \"%s\"\n", p);
+	err = -EINVAL;
+	goto out;
+no_mem:
+	zuf_warn_cnd(silent, "Not enough memory to parse options");
+	err = -ENOMEM;
+	goto out;
+}
+
+static int _print_tier_info(struct multi_devices *md, char **buff, int start,
+			    int count, int *_space, char *str)
+{
+	int space = *_space;
+	char *b = *buff;
+	int printed;
+	int i;
+
+	printed = snprintf(b, space, str);
+	if (unlikely(printed > space))
+		return -ENOSPC;
+
+	b += printed;
+	space -= printed;
+
+	for (i = start; i < start + count; ++i) {
+		printed = snprintf(b, space, "%s%s", i == start ? "" : ",",
+				   _bdev_name(md_dev_info(md, i)->bdev));
+
+		if (unlikely(printed > space))
+			return -ENOSPC;
+
+		b += printed;
+		space -= printed;
+	}
+	*_space = space;
+	*buff = b;
+
+	return 0;
+}
+
+static void _print_mount_info(struct zuf_sb_info *sbi, char *mount_options)
+{
+	struct multi_devices *md = sbi->md;
+	char buff[992];
+	int space = sizeof(buff);
+	char *b = buff;
+	int err;
+
+	err = _print_tier_info(md, &b, 0, md->t1_count, &space, "t1=");
+	if (unlikely(err))
+		goto no_space;
+
+	if (md->t2_count == 0)
+		goto print_options;
+
+	err = _print_tier_info(md, &b, md->t1_count, md->t2_count, &space,
+			       " t2=");
+	if (unlikely(err))
+		goto no_space;
+
+print_options:
+	if (mount_options) {
+		int printed = snprintf(b, space, " -o %s", mount_options);
+
+		if (unlikely(printed > space))
+			goto no_space;
+	}
+
+print:
+	zuf_info("mounted %s (0x%lx/0x%lx)\n", buff,
+		 md_t1_blocks(sbi->md), md_t2_blocks(sbi->md));
+	return;
+
+no_space:
+	snprintf(buff + sizeof(buff) - 4, 4, "...");
+	goto print;
+}
+
+static void _sb_mwtime_now(struct super_block *sb, struct md_dev_table *zdt)
+{
+	struct timespec64 now = current_time(sb->s_root->d_inode);
+
+	timespec_to_mt(&zdt->s_mtime, &now);
+	zdt->s_wtime = zdt->s_mtime;
+	/* TOZO _persist_md(sb, &zdt->s_mtime, 2*sizeof(zdt->s_mtime)); */
+}
+
+static void _clean_bdi(struct super_block *sb)
+{
+	if (sb->s_bdi != &noop_backing_dev_info) {
+		bdi_put(sb->s_bdi);
+		sb->s_bdi = &noop_backing_dev_info;
+	}
+}
+
+static int _setup_bdi(struct super_block *sb, const char *device_name)
+{
+	const char *n = sb->s_type->name;
+	int err;
+
+	if (sb->s_bdi)
+		_clean_bdi(sb);
+
+	err = super_setup_bdi_name(sb, "%s-%s", n, device_name);
+	if (unlikely(err)) {
+		zuf_err("Failed to super_setup_bdi\n");
+		return err;
+	}
+
+	sb->s_bdi->ra_pages = ZUFS_READAHEAD_PAGES;
+	sb->s_bdi->capabilities = BDI_CAP_NO_ACCT_AND_WRITEBACK;
+	return 0;
+}
+
+static int _sb_add(struct zuf_root_info *zri, struct super_block *sb,
+		   __u64 *sb_id)
+{
+	uint i;
+	int err;
+
+	mutex_lock(&zri->sbl_lock);
+
+	if (zri->sbl.num == zri->sbl.max) {
+		struct super_block **new_array;
+
+		new_array = krealloc(zri->sbl.array,
+				  (zri->sbl.max + SBL_INC) * sizeof(*new_array),
+				  GFP_KERNEL | __GFP_ZERO);
+		if (unlikely(!new_array)) {
+			err = -ENOMEM;
+			goto out;
+		}
+		zri->sbl.max += SBL_INC;
+		zri->sbl.array = new_array;
+	}
+
+	for (i = 0; i < zri->sbl.max; ++i)
+		if (!zri->sbl.array[i])
+			break;
+
+	if (unlikely(i == zri->sbl.max)) {
+		zuf_err("!!!!! can't be! i=%d g_sbl.num=%d g_sbl.max=%d\n",
+			i, zri->sbl.num, zri->sbl.max);
+		err = -EFAULT;
+		goto out;
+	}
+
+	++zri->sbl.num;
+	zri->sbl.array[i] = sb;
+	*sb_id = i + 1;
+	err = 0;
+
+	zuf_dbg_vfs("sb_id=%lld\n", *sb_id);
+out:
+	mutex_unlock(&zri->sbl_lock);
+	return err;
+}
+
+static void _sb_remove(struct zuf_root_info *zri, struct super_block *sb)
+{
+	uint i;
+
+	mutex_lock(&zri->sbl_lock);
+
+	for (i = 0; i < zri->sbl.max; ++i)
+		if (zri->sbl.array[i] == sb)
+			break;
+	if (unlikely(i == zri->sbl.max)) {
+		zuf_err("!!!!! can't be! i=%d g_sbl.num=%d g_sbl.max=%d\n",
+			i, zri->sbl.num, zri->sbl.max);
+		goto out;
+	}
+
+	zri->sbl.array[i] = NULL;
+	--zri->sbl.num;
+out:
+	mutex_unlock(&zri->sbl_lock);
+}
+
 struct super_block *zuf_sb_from_id(struct zuf_root_info *zri, __u64 sb_id,
 				   struct zus_sb_info *zus_sbi)
 {
-	return NULL;
+	struct super_block *sb;
+
+	--sb_id;
+
+	if (zri->sbl.max <= sb_id) {
+		zuf_err("Invalid SB_ID 0x%llx\n", sb_id);
+		return NULL;
+	}
+
+	sb = zri->sbl.array[sb_id];
+	if (!sb) {
+		zuf_err("Stale SB_ID 0x%llx\n", sb_id);
+		return NULL;
+	}
+
+	return sb;
+}
+
+static void zuf_put_super(struct super_block *sb)
+{
+	struct zuf_sb_info *sbi = SBI(sb);
+
+	/* FIXME: This is because of a Kernel BUG (in v4.20) which
+	 * sometimes complains in _setup_bdi() on a recycle_mount that sysfs
+	 * bdi already exists. Cleaning here solves it.
+	 * Calling synchronize_rcu in zuf_kill_sb() after the call to
+	 * kill_block_super() does NOT solve it.
+	 */
+	_clean_bdi(sb);
+
+	if (sbi->zus_sbi) {
+		struct zufs_ioc_mount zim = {
+			.zmi.zus_sbi = sbi->zus_sbi,
+		};
+
+		zufc_dispatch_mount(ZUF_ROOT(sbi), NULL, ZUFS_M_UMOUNT, &zim);
+		sbi->zus_sbi = NULL;
+	}
+
+	/* NOTE!!! this is a HACK! we should not touch the s_umount
+	 * lock but to make lockdep happy we do that since our devices
+	 * are held exclusivly. Need to revisit every kernel version
+	 * change.
+	 */
+	if (sbi->md) {
+		up_write(&sb->s_umount);
+		md_fini(sbi->md, false);
+		down_write(&sb->s_umount);
+	}
+
+	_sb_remove(ZUF_ROOT(sbi), sb);
+	sb->s_fs_info = NULL;
+	if (!test_opt(sbi, FAILED))
+		zuf_info("unmounted /dev/%s\n", _bdev_name(sb->s_bdev));
+	kfree(sbi);
+}
+
+struct __fill_super_params {
+	struct multi_devices *md;
+	char *mount_options;
+};
+
+int zuf_private_mount(struct zuf_root_info *zri, struct register_fs_info *rfi,
+		      struct zufs_mount_info *zmi, struct super_block **sb_out)
+{
+	bool silent = zmi->po.mount_flags & ZUFS_M_SILENT;
+	char path[PATH_UUID];
+	const char *dev_path = NULL;
+	struct zuf_sb_info *sbi;
+	struct super_block *sb;
+	char *mount_options;
+	struct mdt_check mc = {
+		.alloc_mask	= ZUFS_ALLOC_MASK,
+		.major_ver	= rfi->FS_ver_major,
+		.minor_ver	= rfi->FS_ver_minor,
+		.magic		= rfi->FS_magic,
+
+		.silent = silent,
+		.private_mnt = true,
+	};
+	int err;
+
+	sb = kzalloc(sizeof(struct super_block), GFP_KERNEL);
+	if (unlikely(!sb)) {
+		zuf_err_cnd(silent, "Not enough memory to allocate sb\n");
+		return -ENOMEM;
+	}
+
+	sbi = kzalloc(sizeof(struct zuf_sb_info), GFP_KERNEL);
+	if (unlikely(!sbi)) {
+		zuf_err_cnd(silent, "Not enough memory to allocate sbi\n");
+		kfree(sb);
+		return -ENOMEM;
+	}
+
+	sb->s_fs_info = sbi;
+	sbi->sb = sb;
+
+	zmi->po.mount_flags |= ZUFS_M_PRIVATE;
+	set_opt(sbi, PRIVATE);
+
+	mount_options = kstrndup(zmi->po.mount_options,
+				 zmi->po.mount_options_len, GFP_KERNEL);
+	if (unlikely(!mount_options)) {
+		zuf_err_cnd(silent, "Not enough memory\n");
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	memset(zmi->po.mount_options, 0, zmi->po.mount_options_len);
+
+	err = _parse_options(sbi, mount_options, 0, &zmi->po);
+	if (unlikely(err)) {
+		zuf_err_cnd(silent, "option parsing failed => %d\n", err);
+		goto fail;
+	}
+
+	if (unlikely(!sbi->pmount_dev)) {
+		zuf_err_cnd(silent, "private mount missing mountdev option\n");
+		err = -EINVAL;
+		goto fail;
+	}
+
+	zmi->po.mount_options_len = strlen(zmi->po.mount_options);
+
+	mc.holder = sbi;
+	err = md_init(&sbi->md, sbi->pmount_dev, &mc, path, &dev_path);
+	if (unlikely(err)) {
+		zuf_err_cnd(silent, "md_init failed! => %d\n", err);
+		goto fail;
+	}
+
+	zuf_dbg_verbose("private mount of %s\n", dev_path);
+
+	err = _sb_add(zri, sb, &zmi->sb_id);
+	if (unlikely(err)) {
+		zuf_err_cnd(silent, "_sb_add failed => %d\n", err);
+		goto fail;
+	}
+
+	*sb_out = sb;
+	return 0;
+
+fail:
+	if (sbi->md)
+		md_fini(sbi->md, true);
+	kfree(mount_options);
+	kfree(sbi->pmount_dev);
+	kfree(sbi);
+	kfree(sb);
+
+	return err;
+}
+
+int zuf_private_umount(struct zuf_root_info *zri, struct super_block *sb)
+{
+	struct zuf_sb_info *sbi = SBI(sb);
+
+	_sb_remove(zri, sb);
+	md_fini(sbi->md, true);
+	kfree(sbi->pmount_dev);
+	kfree(sbi);
+	kfree(sb);
+
+	return 0;
+}
+
+static int zuf_fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct zuf_sb_info *sbi = NULL;
+	struct __fill_super_params *fsp = data;
+	struct zufs_ioc_mount zim = {};
+	struct zufs_ioc_mount *ioc_mount;
+	enum big_alloc_type bat;
+	struct register_fs_info *rfi;
+	struct inode *root_i;
+	size_t zim_size, mount_options_len;
+	bool exist;
+	int err;
+
+	BUILD_BUG_ON(sizeof(struct md_dev_table) > MDT_SIZE);
+	BUILD_BUG_ON(sizeof(struct zus_inode) != ZUFS_INODE_SIZE);
+
+	mount_options_len = (fsp->mount_options ?
+					strlen(fsp->mount_options) : 0) + 1;
+	zim_size = sizeof(zim) + mount_options_len;
+	ioc_mount = big_alloc(zim_size, sizeof(zim), &zim,
+			      GFP_KERNEL | __GFP_ZERO, &bat);
+	if (unlikely(!ioc_mount)) {
+		zuf_err_cnd(silent, "big_alloc(%ld) => -ENOMEM\n", zim_size);
+		return -ENOMEM;
+	}
+
+	ioc_mount->zmi.po.mount_options_len = mount_options_len;
+
+	err = _sb_add(zuf_fst(sb)->zri, sb, &ioc_mount->zmi.sb_id);
+	if (unlikely(err)) {
+		zuf_err_cnd(silent, "_sb_add failed => %d\n", err);
+		goto error;
+	}
+
+	sbi = kzalloc(sizeof(struct zuf_sb_info), GFP_KERNEL);
+	if (!sbi) {
+		zuf_err_cnd(silent, "Not enough memory to allocate sbi\n");
+		err = -ENOMEM;
+		goto error;
+	}
+	sb->s_fs_info = sbi;
+	sbi->sb = sb;
+
+	/* Initialize embedded objects */
+	spin_lock_init(&sbi->s_mmap_dirty_lock);
+	INIT_LIST_HEAD(&sbi->s_mmap_dirty);
+	if (silent) {
+		ioc_mount->zmi.po.mount_flags |= ZUFS_M_SILENT;
+		set_opt(sbi, SILENT);
+	}
+
+	sbi->md = fsp->md;
+	err = md_set_sb(sbi->md, sb->s_bdev, sb, silent);
+	if (unlikely(err))
+		goto error;
+
+	err = _parse_options(sbi, fsp->mount_options, 0, &ioc_mount->zmi.po);
+	if (err)
+		goto error;
+
+	err = _setup_bdi(sb, _bdev_name(sb->s_bdev));
+	if (err) {
+		zuf_err_cnd(silent, "Failed to setup bdi => %d\n", err);
+		goto error;
+	}
+
+	/* Tell ZUS to mount an FS for us */
+	err = zufc_dispatch_mount(ZUF_ROOT(sbi), zuf_fst(sb)->zus_zfi,
+				  ZUFS_M_MOUNT, ioc_mount);
+	if (unlikely(err)) {
+		zuf_err_cnd(silent, "zufc_dispatch_mount failed => %d\n", err);
+		goto error;
+	}
+	sbi->zus_sbi = ioc_mount->zmi.zus_sbi;
+
+	/* Init with default values */
+	sb->s_blocksize_bits = ioc_mount->zmi.s_blocksize_bits;
+	sb->s_blocksize = 1 << ioc_mount->zmi.s_blocksize_bits;
+
+	rfi = &zuf_fst(sb)->rfi;
+
+	sb->s_magic = rfi->FS_magic;
+	sb->s_time_gran = rfi->s_time_gran;
+	sb->s_maxbytes = rfi->s_maxbytes;
+	sb->s_flags |= SB_NOSEC;
+
+	sbi->fs_caps = ioc_mount->zmi.fs_caps;
+	if (sbi->fs_caps & ZUFS_FSC_ACL_ON)
+		sb->s_flags |= SB_POSIXACL;
+
+	sb->s_op = &zuf_sops;
+
+	root_i = zuf_iget(sb, ioc_mount->zmi.zus_ii, ioc_mount->zmi._zi,
+			  &exist);
+	if (IS_ERR(root_i)) {
+		err = PTR_ERR(root_i);
+		zuf_err_cnd(silent, "zuf_iget failed => %d\n", err);
+		goto error;
+	}
+	WARN_ON(exist);
+
+	sb->s_root = d_make_root(root_i);
+	if (!sb->s_root) {
+		zuf_err_cnd(silent, "d_make_root root inode failed\n");
+		iput(root_i); /* undo zuf_iget */
+		err = -ENOMEM;
+		goto error;
+	}
+
+	if (!zuf_rdonly(sb))
+		_sb_mwtime_now(sb, md_zdt(sbi->md));
+
+	mt_to_timespec(&root_i->i_ctime, &zus_zi(root_i)->i_ctime);
+	mt_to_timespec(&root_i->i_mtime, &zus_zi(root_i)->i_mtime);
+
+	_print_mount_info(sbi, fsp->mount_options);
+	clear_opt(sbi, SILENT);
+	big_free(ioc_mount, bat);
+	return 0;
+
+error:
+	zuf_warn("NOT mounting => %d\n", err);
+	if (sbi) {
+		set_opt(sbi, FAILED);
+		zuf_put_super(sb);
+	}
+	big_free(ioc_mount, bat);
+	return err;
+}
+
+static void _zst_to_kst(const struct statfs64 *zst, struct kstatfs *kst)
+{
+	kst->f_type	= zst->f_type;
+	kst->f_bsize	= zst->f_bsize;
+	kst->f_blocks	= zst->f_blocks;
+	kst->f_bfree	= zst->f_bfree;
+	kst->f_bavail	= zst->f_bavail;
+	kst->f_files	= zst->f_files;
+	kst->f_ffree	= zst->f_ffree;
+	kst->f_fsid	= zst->f_fsid;
+	kst->f_namelen	= zst->f_namelen;
+	kst->f_frsize	= zst->f_frsize;
+	kst->f_flags	= zst->f_flags;
+}
+
+static int zuf_statfs(struct dentry *d, struct kstatfs *buf)
+{
+	struct zuf_sb_info *sbi = SBI(d->d_sb);
+	struct zufs_ioc_statfs ioc_statfs = {
+		.hdr.in_len = offsetof(struct zufs_ioc_statfs, statfs_out),
+		.hdr.out_len = sizeof(ioc_statfs),
+		.hdr.operation = ZUFS_OP_STATFS,
+		.zus_sbi = sbi->zus_sbi,
+	};
+	int err;
+
+	err = zufc_dispatch(ZUF_ROOT(sbi), &ioc_statfs.hdr, NULL, 0);
+	if (unlikely(err && err != -EINTR)) {
+		zuf_err("zufc_dispatch failed op=ZUFS_OP_STATFS => %d\n", err);
+		return err;
+	}
+
+	_zst_to_kst(&ioc_statfs.statfs_out, buf);
+	return 0;
+}
+
+struct __mount_options {
+	struct zufs_ioc_mount_options imo;
+	char buf[ZUFS_MO_MAX];
+};
+
+static int zuf_show_options(struct seq_file *seq, struct dentry *root)
+{
+	struct zuf_sb_info *sbi = SBI(root->d_sb);
+	struct __mount_options mo = {
+		.imo.hdr.in_len = sizeof(mo.imo),
+		.imo.hdr.out_start = offsetof(typeof(mo.imo), buf),
+		.imo.hdr.out_len = 0,
+		.imo.hdr.out_max = sizeof(mo.buf),
+		.imo.hdr.operation = ZUFS_OP_SHOW_OPTIONS,
+		.imo.zus_sbi = sbi->zus_sbi,
+	};
+	int err;
+
+	if (test_opt(sbi, EPHEMERAL))
+		seq_puts(seq, ",ephemeral");
+	if (test_opt(sbi, DAX))
+		seq_puts(seq, ",dax");
+
+	err = zufc_dispatch(ZUF_ROOT(sbi), &mo.imo.hdr, NULL, 0);
+	if (unlikely(err)) {
+		zuf_err("zufs_dispatch failed op=ZUS_OP_SHOW_OPTIONS => %d\n",
+			err);
+		/* NOTE: if zusd crashed and we try to run 'umount', it will
+		 * SEGFAULT because zufc_dispatch will return -EFAULT.
+		 * Just return 0 as if the FS has no specific mount options.
+		 */
+		return 0;
+	}
+	seq_puts(seq, mo.buf);
+
+	return 0;
+}
+
+static int zuf_show_devname(struct seq_file *seq, struct dentry *root)
+{
+	seq_printf(seq, "/dev/%s", _bdev_name(root->d_sb->s_bdev));
+
+	return 0;
+}
+
+static int zuf_remount(struct super_block *sb, int *mntflags, char *data)
+{
+	struct zuf_sb_info *sbi = SBI(sb);
+	struct zufs_ioc_mount zim = {};
+	struct zufs_ioc_mount *ioc_mount;
+	size_t remount_options_len, zim_size;
+	enum big_alloc_type bat;
+	ulong old_mount_opt = sbi->s_mount_opt;
+	int err;
+
+	zuf_info("remount... -o %s\n", data);
+
+	remount_options_len = data ? (strlen(data) + 1) : 0;
+	zim_size = sizeof(zim) + remount_options_len;
+	ioc_mount = big_alloc(zim_size, sizeof(zim), &zim,
+			      GFP_KERNEL | __GFP_ZERO, &bat);
+	if (unlikely(!ioc_mount))
+		return -ENOMEM;
+
+	ioc_mount->zmi.zus_sbi = sbi->zus_sbi,
+	ioc_mount->zmi.remount_flags = zuf_rdonly(sb) ? ZUFS_REM_WAS_RO : 0;
+	ioc_mount->zmi.po.mount_options_len = remount_options_len;
+
+	err = _parse_options(sbi, data, 1, &ioc_mount->zmi.po);
+	if (unlikely(err))
+		goto fail;
+
+	if (*mntflags & SB_RDONLY) {
+		ioc_mount->zmi.remount_flags |= ZUFS_REM_WILL_RO;
+
+		if (!zuf_rdonly(sb))
+			_sb_mwtime_now(sb, md_zdt(sbi->md));
+	} else if (zuf_rdonly(sb)) {
+		_sb_mwtime_now(sb, md_zdt(sbi->md));
+	}
+
+	err = zufc_dispatch_mount(ZUF_ROOT(sbi), zuf_fst(sb)->zus_zfi,
+				  ZUFS_M_REMOUNT, ioc_mount);
+	if (unlikely(err))
+		goto fail;
+
+	big_free(ioc_mount, bat);
+	return 0;
+
+fail:
+	sbi->s_mount_opt = old_mount_opt;
+	big_free(ioc_mount, bat);
+	zuf_dbg_err("remount failed restore option\n");
+	return err;
+}
+
+static int zuf_update_s_wtime(struct super_block *sb)
+{
+	if (!(zuf_rdonly(sb))) {
+		struct timespec64 now = current_time(sb->s_root->d_inode);
+
+		timespec_to_mt(&md_zdt(SBI(sb)->md)->s_wtime, &now);
+	}
+	return 0;
+}
+
+static struct inode *zuf_alloc_inode(struct super_block *sb)
+{
+	struct zuf_inode_info *zii;
+
+	zii = kmem_cache_alloc(zuf_inode_cachep, GFP_NOFS);
+	if (!zii)
+		return NULL;
+
+	zii->vfs_inode.i_version.counter = 1;
+	return &zii->vfs_inode;
+}
+
+static void zuf_destroy_inode(struct inode *inode)
+{
+	kmem_cache_free(zuf_inode_cachep, ZUII(inode));
 }
 
 static void _init_once(void *foo)
@@ -31,6 +756,7 @@ static void _init_once(void *foo)
 	struct zuf_inode_info *zii = foo;
 
 	inode_init_once(&zii->vfs_inode);
+	zii->zi = NULL;
 }
 
 int __init zuf_init_inodecache(void)
@@ -52,8 +778,55 @@ void zuf_destroy_inodecache(void)
 	kmem_cache_destroy(zuf_inode_cachep);
 }
 
+static struct super_operations zuf_sops = {
+	.alloc_inode	= zuf_alloc_inode,
+	.destroy_inode	= zuf_destroy_inode,
+	.put_super	= zuf_put_super,
+	.freeze_fs	= zuf_update_s_wtime,
+	.unfreeze_fs	= zuf_update_s_wtime,
+	.statfs		= zuf_statfs,
+	.remount_fs	= zuf_remount,
+	.show_options	= zuf_show_options,
+	.show_devname	= zuf_show_devname,
+};
+
 struct dentry *zuf_mount(struct file_system_type *fs_type, int flags,
 			 const char *dev_name, void *data)
 {
-	return ERR_PTR(-ENOTSUPP);
+	int silent = flags & SB_SILENT ? 1 : 0;
+	struct __fill_super_params fsp = {
+		.mount_options = data,
+	};
+	struct zuf_fs_type *fst = ZUF_FST(fs_type);
+	struct register_fs_info *rfi = &fst->rfi;
+	struct mdt_check mc = {
+		.alloc_mask	= ZUFS_ALLOC_MASK,
+		.major_ver	= rfi->FS_ver_major,
+		.minor_ver	= rfi->FS_ver_minor,
+		.magic		= rfi->FS_magic,
+
+		.holder = fs_type,
+		.silent = silent,
+	};
+	struct dentry *ret = NULL;
+	char path[PATH_UUID];
+	const char *dev_path = NULL;
+	int err;
+
+	zuf_dbg_vfs("dev_name=%s, data=%s\n", dev_name, (const char *)data);
+
+	err = md_init(&fsp.md, dev_name, &mc, path, &dev_path);
+	if (unlikely(err)) {
+		zuf_err_cnd(silent, "md_init failed! => %d\n", err);
+		goto out;
+	}
+
+	zuf_dbg_vfs("mounting with dev_path=%s\n", dev_path);
+	ret = mount_bdev(fs_type, flags, dev_path, &fsp, zuf_fill_super);
+
+out:
+	if (unlikely(err) && fsp.md)
+		md_fini(fsp.md, true);
+
+	return err ? ERR_PTR(err) : ret;
 }
diff --git a/fs/zuf/zuf-core.c b/fs/zuf/zuf-core.c
index 8b5329632f28..301cf5058231 100644
--- a/fs/zuf/zuf-core.c
+++ b/fs/zuf/zuf-core.c
@@ -63,6 +63,8 @@ const char *zuf_op_name(enum e_zufs_operation op)
 	switch  (op) {
 		CASE_ENUM_NAME(ZUFS_OP_NULL);
 		CASE_ENUM_NAME(ZUFS_OP_BREAK);
+		CASE_ENUM_NAME(ZUFS_OP_STATFS);
+		CASE_ENUM_NAME(ZUFS_OP_SHOW_OPTIONS);
 	case ZUFS_OP_MAX_OPT:
 	default:
 		return "UNKNOWN";
@@ -289,6 +291,95 @@ static void zufc_mounter_release(struct file *f)
 	}
 }
 
+static int _zu_private_mounter_release(struct file *file)
+{
+	struct zuf_root_info *zri = ZRI(file->f_inode->i_sb);
+	struct zuf_special_file *zsf = file->private_data;
+	struct zuf_private_mount_info *zpmi;
+	int err;
+
+	zpmi = container_of(zsf, struct zuf_private_mount_info, zsf);
+
+	err = zuf_private_umount(zri, zpmi->sb);
+
+	kfree(zpmi);
+
+	return err;
+}
+
+static int _zu_private_mounter(struct file *file, void *parg)
+{
+	struct super_block *sb = file->f_inode->i_sb;
+	struct zufs_ioc_mount_private *zip = NULL;
+	struct zuf_private_mount_info *zpmi;
+	struct zuf_root_info *zri = ZRI(sb);
+	struct zufs_ioc_hdr hdr;
+	__u32 is_umount;
+	ulong cp_ret;
+	int err = 0;
+
+	get_user(is_umount,
+		 &((struct zufs_ioc_mount_private *)parg)->is_umount);
+	if (is_umount)
+		return _zu_private_mounter_release(file);
+
+	if (unlikely(file->private_data)) {
+		zuf_err("One mount per runner please..\n");
+		return -EINVAL;
+	}
+
+	zpmi = kzalloc(sizeof(*zpmi), GFP_KERNEL);
+	if (unlikely(!zpmi)) {
+		zuf_err("alloc failed\n");
+		return -ENOMEM;
+	}
+
+	zpmi->zsf.type = zlfs_e_private_mount;
+	zpmi->zsf.file = file;
+
+	cp_ret = copy_from_user(&hdr, parg, sizeof(hdr));
+	if (unlikely(cp_ret)) {
+		zuf_err("copy_from_user(hdr) => %ld\n", cp_ret);
+		err = -EFAULT;
+		goto fail;
+	}
+
+	zip = kmalloc(hdr.in_len, GFP_KERNEL);
+	if (unlikely(!zip)) {
+		zuf_err("alloc failed\n");
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	cp_ret = copy_from_user(zip, parg, hdr.in_len);
+	if (unlikely(cp_ret)) {
+		zuf_err("copy_from_user => %ld\n", cp_ret);
+		err = -EFAULT;
+		goto fail;
+	}
+
+	err = zuf_private_mount(zri, &zip->rfi, &zip->zmi, &zpmi->sb);
+	if (unlikely(err))
+		goto fail;
+
+	cp_ret = copy_to_user(parg, zip, hdr.in_len);
+	if (unlikely(cp_ret)) {
+		zuf_err("copy_to_user =>%ld\n", cp_ret);
+		err = -EFAULT;
+		goto fail;
+	}
+
+	file->private_data = &zpmi->zsf;
+
+out:
+	kfree(zip);
+	return err;
+
+fail:
+	kfree(zpmi);
+	goto out;
+}
+
 /* ~~~~ ZU_IOC_NUMA_MAP ~~~~ */
 static int _zu_numa_map(struct file *file, void *parg)
 {
@@ -959,6 +1050,8 @@ long zufc_ioctl(struct file *file, unsigned int cmd, ulong arg)
 		return _zu_wait(file, parg);
 	case ZU_IOC_ALLOC_BUFFER:
 		return _zu_ebuff_alloc(file, parg);
+	case ZU_IOC_PRIVATE_MOUNT:
+		return _zu_private_mounter(file, parg);
 	case ZU_IOC_BREAK_ALL:
 		return _zu_break(file, parg);
 	default:
@@ -981,6 +1074,8 @@ int zufc_release(struct inode *inode, struct file *file)
 	case zlfs_e_mout_thread:
 		zufc_mounter_release(file);
 		return 0;
+	case zlfs_e_private_mount:
+		_zu_private_mounter_release(file);
 	case zlfs_e_pmem:
 		/* NOTHING to clean for pmem file yet */
 		/* zuf_pmem_release(file);*/
diff --git a/fs/zuf/zuf.h b/fs/zuf/zuf.h
index 321f31124252..0192645ad49d 100644
--- a/fs/zuf/zuf.h
+++ b/fs/zuf/zuf.h
@@ -105,12 +105,33 @@ struct zuf_pmem_file {
 	struct multi_devices *md;
 };
 
+/*
+ * Private Super-block flags
+ */
+enum {
+	ZUF_MOUNT_PEDANTIC	= 0x000001,	/* Check for memory leaks */
+	ZUF_MOUNT_PEDANTIC_SHADOW = 0x00002,	/* */
+	ZUF_MOUNT_SILENT	= 0x000004,	/* verbosity is silent */
+	ZUF_MOUNT_EPHEMERAL	= 0x000008,	/* Don't persist the data */
+	ZUF_MOUNT_FAILED	= 0x000010,	/* mark a failed-mount */
+	ZUF_MOUNT_DAX		= 0x000020,	/* mounted with dax option */
+	ZUF_MOUNT_POSIXACL	= 0x000040,	/* mounted with posix acls */
+	ZUF_MOUNT_PRIVATE	= 0x000080,	/* private mount from runner */
+};
+
+#define clear_opt(sbi, opt)       (sbi->s_mount_opt &= ~ZUF_MOUNT_ ## opt)
+#define set_opt(sbi, opt)         (sbi->s_mount_opt |= ZUF_MOUNT_ ## opt)
+#define test_opt(sbi, opt)      (sbi->s_mount_opt & ZUF_MOUNT_ ## opt)
 
 /*
  * ZUF per-inode data in memory
  */
 struct zuf_inode_info {
 	struct inode		vfs_inode;
+
+	/* cookies from Server */
+	struct zus_inode	*zi;
+	struct zus_inode_info	*zus_ii;
 };
 
 static inline struct zuf_inode_info *ZUII(struct inode *inode)
@@ -163,6 +184,104 @@ static inline bool zuf_rdonly(struct super_block *sb)
 	return sb_rdonly(sb);
 }
 
+static inline bool zuf_is_nio_reads(struct inode *inode)
+{
+	return SBI(inode->i_sb)->fs_caps & ZUFS_FSC_NIO_READS;
+}
+
+static inline bool zuf_is_nio_writes(struct inode *inode)
+{
+	return SBI(inode->i_sb)->fs_caps & ZUFS_FSC_NIO_WRITES;
+}
+
+static inline struct zus_inode *zus_zi(struct inode *inode)
+{
+	return ZUII(inode)->zi;
+}
+
+/* An accessor because of the frequent use in prints */
+static inline ulong _zi_ino(struct zus_inode *zi)
+{
+	return le64_to_cpu(zi->i_ino);
+}
+
+static inline bool _zi_active(struct zus_inode *zi)
+{
+	return (zi->i_nlink || zi->i_mode);
+}
+
+static inline void mt_to_timespec(struct timespec64 *t, __le64 *mt)
+{
+	u32 nsec;
+
+	t->tv_sec = div_s64_rem(le64_to_cpu(*mt), NSEC_PER_SEC, &nsec);
+	t->tv_nsec = nsec;
+}
+
+static inline void timespec_to_mt(__le64 *mt, struct timespec64 *t)
+{
+	*mt = cpu_to_le64(t->tv_sec * NSEC_PER_SEC + t->tv_nsec);
+}
+
+static inline
+void zus_inode_cmtime_now(struct inode *inode, struct zus_inode *zi)
+{
+	inode->i_mtime = inode->i_ctime = current_time(inode);
+	timespec_to_mt(&zi->i_ctime, &inode->i_ctime);
+	zi->i_mtime = zi->i_ctime;
+}
+
+static inline
+void zus_inode_ctime_now(struct inode *inode, struct zus_inode *zi)
+{
+	inode->i_ctime = current_time(inode);
+	timespec_to_mt(&zi->i_ctime, &inode->i_ctime);
+}
+
+static inline void *zuf_dpp_t_addr(struct super_block *sb, zu_dpp_t v)
+{
+	/* TODO: Implement zufs_ioc_create_mempool already */
+	if (WARN_ON(zu_dpp_t_pool(v)))
+		return NULL;
+
+	return md_addr_verify(SBI(sb)->md, zu_dpp_t_val(v));
+}
+
+enum big_alloc_type { ba_stack, ba_kmalloc, ba_vmalloc };
+
+static inline
+void *big_alloc(uint bytes, uint local_size, void *local, gfp_t gfp,
+		enum big_alloc_type *bat)
+{
+	void *ptr;
+
+	if (bytes <= local_size) {
+		*bat = ba_stack;
+		ptr = local;
+	} else if (bytes <= PAGE_SIZE) {
+		*bat = ba_kmalloc;
+		ptr = kmalloc(bytes, gfp);
+	} else {
+		*bat = ba_vmalloc;
+		ptr = vmalloc(bytes);
+	}
+
+	return ptr;
+}
+
+static inline void big_free(void *ptr, enum big_alloc_type bat)
+{
+	switch (bat) {
+	case ba_stack:
+		break;
+	case ba_kmalloc:
+		kfree(ptr);
+		break;
+	case ba_vmalloc:
+		vfree(ptr);
+	}
+}
+
 struct zuf_dispatch_op;
 typedef int (*overflow_handler)(struct zuf_dispatch_op *zdo, void *parg,
 				ulong zt_max_bytes);
diff --git a/fs/zuf/zus_api.h b/fs/zuf/zus_api.h
index 653ca24c9c92..c7681c53700c 100644
--- a/fs/zuf/zus_api.h
+++ b/fs/zuf/zus_api.h
@@ -334,6 +334,17 @@ struct  zufs_ioc_mount {
 };
 #define ZU_IOC_MOUNT		_IOWR('Z', 11, struct zufs_ioc_mount)
 
+/* Mount locally with a zus-runner process */
+#define ZUFS_PMDEV_OPT "zpmdev"
+struct zufs_ioc_mount_private {
+	struct zufs_ioc_hdr	hdr;
+	__u32			mount_fd; /* kernel cookie */
+	__u32			is_umount; /* true or false */
+	struct register_fs_info	rfi;
+	struct zufs_mount_info	zmi; /* must be last */
+};
+#define ZU_IOC_PRIVATE_MOUNT	_IOWR('Z', 12, struct zufs_ioc_mount_private)
+
 /* pmem  */
 struct zufs_cpu_set {
 	ulong bits[16];
@@ -436,7 +447,31 @@ enum e_zufs_operation {
 	ZUFS_OP_NULL		= 0,
 	ZUFS_OP_BREAK		= 1,	/* Kernel telling Server to exit */
 
+	ZUFS_OP_STATFS		= 2,
+	ZUFS_OP_SHOW_OPTIONS	= 3,
+
 	ZUFS_OP_MAX_OPT,
 };
 
+#define ZUFS_MO_MAX	512
+
+struct zufs_ioc_mount_options {
+	struct zufs_ioc_hdr hdr;
+	/* IN */
+	struct zus_sb_info *zus_sbi;
+
+	/* OUT */
+	char	buf[0];
+};
+
+/* ZUFS_OP_STATFS */
+struct zufs_ioc_statfs {
+	struct zufs_ioc_hdr hdr;
+	/* IN */
+	struct zus_sb_info *zus_sbi;
+
+	/* OUT */
+	struct statfs64 statfs_out;
+};
+
 #endif /* _LINUX_ZUFS_API_H */
-- 
2.20.1


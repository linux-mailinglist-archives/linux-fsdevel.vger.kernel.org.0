Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 490EFBEA76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 04:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbfIZCNA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 22:13:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55775 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfIZCNA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 22:13:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id a6so727690wma.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2019 19:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gL69fGNCem1/GDwiWl3Bh15i2ZHAFAibXRT8WHa+3DA=;
        b=SaCiK8CJKwJfym6+RjbqmVt8/fOAlEPicc8c6NV4rPtZQDWA9MpE0qjamlMWqK6LxM
         SibfFtFc+nHc6En9A4YeTmYZaw7v84JYBSa7WcRNiOXqZ/oLklt/AQ1xtg1sQNZaJ1iK
         w7o9Rn1UOODlTJOEA5sxWOpO7OjeYENwl9zqIlRnDZQAMRl4F5gAyQm1r/lq1WrdGixV
         08JNDKFSY2UwyV3cK/qG4UHYFRcluDjQdg8Pktzl4nTVh22uJyzrH9NxyHAq+7FeP8jE
         O6O6MAgT2zazr6Tjprue+NWvqf9xBb8BPiaoYZ2HXS0KvLo6XVVcHPV3g2XILOYtvXfZ
         fQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gL69fGNCem1/GDwiWl3Bh15i2ZHAFAibXRT8WHa+3DA=;
        b=Jr2UjLP0WQtKUfGDP7SBA5STO8Tvt0EuhPPaT1UqimwGwi6gibvQHLzom/50yMYg+t
         cQNd8x5JHVI8SQp5F8Ig0TkJkQc3Rxe764cL75VqsJow3CwFvoENSS3EC0NKhiLwtOe3
         fxlytt/Lv9+32cYawTpQtfG4Ngh2JUS98o0YE3k7j09YRtBslj8828sUlouVo3dmMV17
         wjOMW9mWUpkRkKwTcA67KEvRgGJ3wIoLnd59PGCDh6W4qEnPf7T+7CS0Qfh52Qjdw7u3
         XfVUakRfaqFnYPYgLCIJqw9V5oUIZhnN41hoifQPwrIuTw1ckQa3S2spL3X12tY/BM1M
         9sSw==
X-Gm-Message-State: APjAAAV4xwO/CRs69zs9AqjGxtSWj5R5Us/wXwp3KhZBkamEcoCXr6h6
        DawviEXC2otEJa+4eQQiQpgT+L0/DdE=
X-Google-Smtp-Source: APXvYqyazCuEy3nZx32jTIrwkoaa6vpUdM/YqPAsUh5uuCYgRqNZd7Tq29TbvgyOqVEilhy0y9XGqQ==
X-Received: by 2002:a05:600c:24ce:: with SMTP id 14mr789418wmu.71.1569463977540;
        Wed, 25 Sep 2019 19:12:57 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id o19sm968751wro.50.2019.09.25.19.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 19:12:57 -0700 (PDT)
From:   Boaz Harrosh <boaz@plexistor.com>
X-Google-Original-From: Boaz Harrosh <boazh@netapp.com>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matt Benjamin <mbenjami@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 09/16] zuf: readdir operation
Date:   Thu, 26 Sep 2019 05:07:18 +0300
Message-Id: <20190926020725.19601-10-boazh@netapp.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926020725.19601-1-boazh@netapp.com>
References: <20190926020725.19601-1-boazh@netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implements the file_operations->iterate_shared via info
returned from Server.

Establish protocol with Server for readdir.

The Server fills a zuf allocated buffer (up to 4M at a time)
which will contain a zufs encoded dir entries. It will then
call the proper emit vector to fill the caller buffer.
The buffer is passed to Server not as part of the zufs_ioc_readdir
struct but maps this buffer directly into Server space via the
zt_map_pages facility.

[v2]
  Fix the gcc warning:
    directory.c:86:1: warning: the frame size of 8576 bytes is
		  larger than 8192 bytes
  Fix it by allocating the pages array, which was on stack
  as part of the allocation we already do for the readdir buffer
  Reported-by: kbuild test robot <lkp@intel.com>

Signed-off-by: Boaz Harrosh <boazh@netapp.com>
---
 fs/zuf/directory.c | 69 +++++++++++++++++++++++++++++++++++-
 fs/zuf/zuf-core.c  |  2 ++
 fs/zuf/zus_api.h   | 88 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+), 1 deletion(-)

diff --git a/fs/zuf/directory.c b/fs/zuf/directory.c
index 5624e05f96e5..7417aeb77773 100644
--- a/fs/zuf/directory.c
+++ b/fs/zuf/directory.c
@@ -19,7 +19,74 @@
 
 static int zuf_readdir(struct file *file, struct dir_context *ctx)
 {
-	return -ENOTSUPP;
+	struct inode *inode = file_inode(file);
+	struct super_block *sb = inode->i_sb;
+	loff_t i_size = i_size_read(inode);
+	struct zufs_ioc_readdir ioc_readdir = {
+		.hdr.in_len = sizeof(ioc_readdir),
+		.hdr.out_len = sizeof(ioc_readdir),
+		.hdr.operation = ZUFS_OP_READDIR,
+		.dir_ii = ZUII(inode)->zus_ii,
+	};
+	struct zufs_readdir_iter rdi;
+	struct page **pages;
+	struct zufs_dir_entry *zde;
+	void *addr, *__a;
+	uint nump, i;
+	int err;
+
+	if (ctx->pos && i_size <= ctx->pos)
+		return 0;
+	if (!i_size)
+		i_size = PAGE_SIZE; /* Just for the . && .. */
+	if (i_size - ctx->pos < PAGE_SIZE)
+		ioc_readdir.hdr.len = PAGE_SIZE;
+	else
+		ioc_readdir.hdr.len = min_t(loff_t, i_size - ctx->pos,
+					    ZUS_API_MAP_MAX_SIZE);
+	nump = md_o2p_up(ioc_readdir.hdr.len);
+	/* Allocating both readdir buffer and the pages-array.
+	 * Pages array is at end
+	 */
+	addr = vzalloc(md_p2o(nump) + nump * sizeof(*pages));
+	if (unlikely(!addr))
+		return -ENOMEM;
+
+	WARN_ON((ulong)addr & (PAGE_SIZE - 1));
+
+	pages = addr + md_p2o(nump);
+	__a = addr;
+	for (i = 0; i < nump; ++i) {
+		pages[i] = vmalloc_to_page(__a);
+		__a += PAGE_SIZE;
+	}
+
+more:
+	ioc_readdir.pos = ctx->pos;
+
+	err = zufc_dispatch(ZUF_ROOT(SBI(sb)), &ioc_readdir.hdr, pages, nump);
+	if (unlikely(err && err != -EINTR)) {
+		zuf_err_dispatch(sb, "zufc_dispatch failed => %d\n", err);
+		goto out;
+	}
+
+	zufs_readdir_iter_init(&rdi, &ioc_readdir, addr);
+	while ((zde = zufs_next_zde(&rdi)) != NULL) {
+		zuf_dbg_verbose("%s pos=0x%lx\n",
+				zde->zstr.name, (ulong)zde->pos);
+		ctx->pos = zde->pos;
+		if (!dir_emit(ctx, zde->zstr.name, zde->zstr.len, zde->ino,
+			      zde->type))
+			goto out;
+	}
+	ctx->pos = ioc_readdir.pos;
+	if (ioc_readdir.more) {
+		zuf_dbg_err("more\n");
+		goto more;
+	}
+out:
+	vfree(addr);
+	return err;
 }
 
 /*
diff --git a/fs/zuf/zuf-core.c b/fs/zuf/zuf-core.c
index 48dd7b665064..c0049c1d5ba3 100644
--- a/fs/zuf/zuf-core.c
+++ b/fs/zuf/zuf-core.c
@@ -74,6 +74,8 @@ const char *zuf_op_name(enum e_zufs_operation op)
 		CASE_ENUM_NAME(ZUFS_OP_ADD_DENTRY);
 		CASE_ENUM_NAME(ZUFS_OP_REMOVE_DENTRY);
 		CASE_ENUM_NAME(ZUFS_OP_RENAME);
+		CASE_ENUM_NAME(ZUFS_OP_READDIR);
+
 		CASE_ENUM_NAME(ZUFS_OP_SETATTR);
 	case ZUFS_OP_MAX_OPT:
 	default:
diff --git a/fs/zuf/zus_api.h b/fs/zuf/zus_api.h
index 9b9e97fe844e..2bdf047282e8 100644
--- a/fs/zuf/zus_api.h
+++ b/fs/zuf/zus_api.h
@@ -454,6 +454,7 @@ enum e_zufs_operation {
 	ZUFS_OP_ADD_DENTRY	= 8,
 	ZUFS_OP_REMOVE_DENTRY	= 9,
 	ZUFS_OP_RENAME		= 10,
+	ZUFS_OP_READDIR		= 11,
 
 	ZUFS_OP_SETATTR		= 19,
 
@@ -549,6 +550,93 @@ struct zufs_ioc_rename {
 	__u64 flags;
 };
 
+/* ZUFS_OP_READDIR */
+struct zufs_ioc_readdir {
+	struct zufs_ioc_hdr hdr;
+	/* IN */
+	struct zus_inode_info *dir_ii;
+	__u64 pos;
+
+	/* OUT */
+	__u8	more;
+};
+
+struct zufs_dir_entry {
+	__le64 ino;
+	struct {
+		unsigned	type	: 8;
+		ulong		pos	: 56;
+	};
+	struct zufs_str zstr;
+};
+
+struct zufs_readdir_iter {
+	void *__zde, *last;
+	struct zufs_ioc_readdir *ioc_readdir;
+};
+
+enum {E_ZDE_HDR_SIZE =
+	offsetof(struct zufs_dir_entry, zstr) + offsetof(struct zufs_str, name),
+};
+
+#ifndef __cplusplus
+static inline void zufs_readdir_iter_init(struct zufs_readdir_iter *rdi,
+					  struct zufs_ioc_readdir *ioc_readdir,
+					  void *app_ptr)
+{
+	rdi->__zde = app_ptr;
+	rdi->last = app_ptr + ioc_readdir->hdr.len;
+	rdi->ioc_readdir = ioc_readdir;
+	ioc_readdir->more = false;
+}
+
+static inline uint zufs_dir_entry_len(__u8 name_len)
+{
+	return ALIGN(E_ZDE_HDR_SIZE + name_len, sizeof(__u64));
+}
+
+static inline
+struct zufs_dir_entry *zufs_next_zde(struct zufs_readdir_iter *rdi)
+{
+	struct zufs_dir_entry *zde = rdi->__zde;
+	uint len;
+
+	if (rdi->last <= rdi->__zde + E_ZDE_HDR_SIZE)
+		return NULL;
+	if (zde->zstr.len == 0)
+		return NULL;
+	len = zufs_dir_entry_len(zde->zstr.len);
+	if (rdi->last <= rdi->__zde + len)
+		return NULL;
+
+	rdi->__zde += len;
+	return zde;
+}
+
+static inline bool zufs_zde_emit(struct zufs_readdir_iter *rdi, __u64 ino,
+				 __u8 type, __u64 pos, const char *name,
+				 __u8 len)
+{
+	struct zufs_dir_entry *zde = rdi->__zde;
+
+	if (rdi->last <= rdi->__zde + zufs_dir_entry_len(len)) {
+		rdi->ioc_readdir->more = true;
+		return false;
+	}
+
+	rdi->ioc_readdir->more = 0;
+	zde->ino = ino;
+	zde->type = type;
+	/*ASSERT(0 == (pos && (1 << 56 - 1)));*/
+	zde->pos = pos;
+	strncpy(zde->zstr.name, name, len);
+	zde->zstr.len = len;
+	zufs_next_zde(rdi);
+
+	return true;
+}
+#endif /* ndef __cplusplus */
+
 /* ZUFS_OP_SETATTR */
 struct zufs_ioc_attr {
 	struct zufs_ioc_hdr hdr;
-- 
2.21.0


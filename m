Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5B778A3B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 18:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfHLQsh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 12:48:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36540 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfHLQsh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:48:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so11433081wrt.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 09:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K4ob68OfF9Z2U2SCF65YSrHi5YdM3ajWRtG+DcxvUZE=;
        b=lfpMZjD/WKv50OV8oVhZIOK1wGiRgl70HVnmM3TRamkfiuqCzmyQJZnJzH6rbJLbCT
         nViZLyfvqnrI1cO3zsuK6mN1cU7HJlF2IeM4AQ5pfstERz/25wUvUy0oCyGvCBxAqoqt
         U2qWeBIvnmIyY01Sco8vgu8l5s2svbkblXYz8s0K4DmXTN6KS3eUEF3C/ckfLsmAnaRI
         Szz/QVOHdfrHSBne1FUq4dubFEaqpsWcri0e14EeKahZqRbIFh9JkCO0Ez9qaY/VDDuC
         W3uYlYj80Yq4mWDJ8b41VoOWTvWGdkyOo8ivrUlfoxqYZ138Yt5f/0fS6HDbjlXbCV16
         ApSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K4ob68OfF9Z2U2SCF65YSrHi5YdM3ajWRtG+DcxvUZE=;
        b=ucZ8j83E90+U1GAMC7O8QqNTgW9F14wa5bhuGTiiWFmW9KkEpSH01oHgfTcm5g3VY3
         Z0OisvDQXxbAdfkCFle//0rQZyKQvlWfckMvyXC5CQVAS2TXnHO8OHQ9l1UqDTevS6kZ
         IQwht/drI264Om9TxLuffZi25uNtivxRSDNcl4TiHC3G+ct6xzV8NxUBVGjddm8GnXcJ
         agkrkbYZ3aIq1H1C4tjkgtoEHVGrQlsLVvZuk2at7kJzPjUuYBFnEL562v7qXpxnu5DZ
         m4Z9Yfg8MjEQB9NQjvdqg37zbSNAtr7zGczFWFRhK7wm8I0AbcWJFSQNZ58/YNWYaY/b
         BnWQ==
X-Gm-Message-State: APjAAAUfrvaeg+ZZ8MY8ojkn8TcFjiymV3L2njRvX+SNmegqI/Y8xZkr
        S7DWfSTI0hYfE8pawvYbUj3fyFvg8tE=
X-Google-Smtp-Source: APXvYqx/xZtqkH2P/BeM6LDvO5/JD+ferltwJvA+7SIVE3fSUJXyMjCrFe183eBd/UNh5hKRT3fYWw==
X-Received: by 2002:a5d:528a:: with SMTP id c10mr8326469wrv.111.1565628514687;
        Mon, 12 Aug 2019 09:48:34 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.211.18])
        by smtp.googlemail.com with ESMTPSA id k13sm23813700wro.97.2019.08.12.09.48.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 09:48:34 -0700 (PDT)
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
Subject: [PATCH 09/16] zuf: readdir operation
Date:   Mon, 12 Aug 2019 19:47:59 +0300
Message-Id: <20190812164806.15852-10-boazh@netapp.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812164806.15852-1-boazh@netapp.com>
References: <20190812164806.15852-1-boazh@netapp.com>
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

Signed-off-by: Boaz Harrosh <boazh@netapp.com>
---
 fs/zuf/directory.c | 65 +++++++++++++++++++++++++++++++++-
 fs/zuf/zuf-core.c  |  2 ++
 fs/zuf/zus_api.h   | 88 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+), 1 deletion(-)

diff --git a/fs/zuf/directory.c b/fs/zuf/directory.c
index 5624e05f96e5..645dd367fd8c 100644
--- a/fs/zuf/directory.c
+++ b/fs/zuf/directory.c
@@ -19,7 +19,70 @@
 
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
+	struct page *pages[ZUS_API_MAP_MAX_PAGES];
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
+	addr = vzalloc(md_p2o(nump));
+	if (unlikely(!addr))
+		return -ENOMEM;
+
+	WARN_ON((ulong)addr & (PAGE_SIZE - 1));
+
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
+		zuf_err("zufc_dispatch failed => %d\n", err);
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
index d2a2cd28b5e3..12fff87e0b47 100644
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
index fe92471f7765..3579775b7b72 100644
--- a/fs/zuf/zus_api.h
+++ b/fs/zuf/zus_api.h
@@ -458,6 +458,7 @@ enum e_zufs_operation {
 	ZUFS_OP_ADD_DENTRY	= 8,
 	ZUFS_OP_REMOVE_DENTRY	= 9,
 	ZUFS_OP_RENAME		= 10,
+	ZUFS_OP_READDIR		= 11,
 
 	ZUFS_OP_SETATTR		= 19,
 
@@ -553,6 +554,93 @@ struct zufs_ioc_rename {
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
2.20.1


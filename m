Return-Path: <linux-fsdevel+bounces-53835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3593AF80B9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 20:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4170C189FBFC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798A22F6F8A;
	Thu,  3 Jul 2025 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5869NT3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EA12F362C;
	Thu,  3 Jul 2025 18:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568683; cv=none; b=NBxXGo7uBaAfahUAPVhY+ELJmNXdMvGRoFdYNN/s9F2T/eHjvh/8sJ77pDUIAqLbgJLgqSD/kl1DBn+zYn9F+FnuPYpjeumt19e38JkRbcZkqB6i0uBOwsPWH4TZa0po+rBo6avwqhYAgCxh6JEijBVIlwUL9NeneXJtTKCpN80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568683; c=relaxed/simple;
	bh=W6SSJ5n4WkmPzzWxMdPih1XAcuC59u2vCqd3I2mEN/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DzWuJfuRy7MvDXj5i7zYSL73troEMN0VZ0iUKUjNoxUmf4sk/Nx6KoQQixv9iX/P5oY8mou+aN+w0a9AZhQwLUVojowfQQv6YH8AWALU6kYv3ki2Wvo1PSjdd7Mi2VVJWDr+L/EsipKQllhRu7nL7EU7VN9yB9xDuwk8FDqepE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5869NT3; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2ef8dfb3742so67445fac.3;
        Thu, 03 Jul 2025 11:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751568680; x=1752173480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJKfVlCAjxcUIymiAHgKO7vuVphUoIXt4cecFTyUAAA=;
        b=P5869NT3jXSDXST5q1+w6z1d9ISMJGrnA5oNYLlUK5MQcnqB+prSHbJaFI+O6UHkkp
         YwMkBqFGgyiRDSIHRQxD8m6waADINT2VRs3mXA6VsphhgmLmDrsK2U8gEexTkgJYG4Kh
         d2TOvBfPeiGYQdsplfU3wPgJnZswcY8mIMZ80S5G7Ea3cCjgIE7cxl+uyPdAdjL8xyaN
         HlYAKaoGwJByRpuclrLMMH+f7FAYm03Sw6GoVtKqmehZA6JgJb9lbBQkZFkS6dKtegKV
         kjpgzu/GGs7mGkkRusgwYAUD874KhqUVrrXYbkCfWnrz2058SSIi80M44RaxWyImjD2q
         it0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751568680; x=1752173480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vJKfVlCAjxcUIymiAHgKO7vuVphUoIXt4cecFTyUAAA=;
        b=dxds9SkdM3amNmvlmZN00cE8cndTKBJ8Ewt9ykOeAHzQCqUPPy5TFykXNpXLHKo9nS
         rcYKxn+EuEMc1gGN0Eh8CEqF/2gXe6qBGWl0fSVfJXx1JvvPFGMb1elQ7fKaao8Zcnab
         7DEubHxuw0TQNyiQtOlT2lcbfRATJcezAoLkzv2jcmU6U36gqhrcfAN9mh1g54yIj7+6
         ovo75DjS4jrdZjhD715lcZjj9aRHLMrsgAdUvvv7uohtb81wqtMPUwLu4cItTjiD/R/L
         X/JZ149C/ZcF/6gpJOnfFohwym2DmwBV5eB0RY3LNMQGCfOZG44CN0FPbqbwL4KweM2l
         Ay9A==
X-Forwarded-Encrypted: i=1; AJvYcCVrVgjr+2WZfMHST0+ztI0BGl2GW14gEqlrLbPcTZ+zd0K7bDGJOXJE5Cu8gHZTNpHKF8tvmgTnET8=@vger.kernel.org, AJvYcCX+xX24ihWNWeKKeZnr/aDRSXeph2EEJctBmIV2EDjdUrdaZh9Qvipn5lAbvS4hem3g4WDCHdibzvfD@vger.kernel.org, AJvYcCXhnTF6c0pDLWPz4ZCrVJGuYsFGfFO5P745YertLcOMW7mdb3CNHzNTFS5W5QROCCAcEl5B22w79/b78GWhDA==@vger.kernel.org, AJvYcCXkWlgX54qs75/TEfv66B2XLUGoq62ifulkkNyJoD4aorPAwxNU3/ULQ4KC0aNChITFP3SjvozRAG6pWYl8@vger.kernel.org
X-Gm-Message-State: AOJu0YzFlZaiyEYHOUVzG7RYw2vzj5e7NZIu5NBPq5zVbDxgO/AoChRS
	Eobaxfz+3E2gER6Hd9KmxVVf2CrH0UGat/ClZVtIPvXjIaM57Z/gU8gx
X-Gm-Gg: ASbGncujaemSLvRk5AjHf62o+XVzPz8Mko8VZKWgCBz+ugyAQ6pAfaapCVmLO2UmH/n
	XarI/ACwg1kLLkMMzFIdqxlKoXtEfBuc2+zrFnvUXZH9HLXJX+Rj78gaYzjau1WMq8mE5+OVwYT
	GcntDu7qV7XqMbCaYcF62WQXdhgCDqErkV4wXjuzGKXGQ/9+ZrndxpA7iSgXX6JrhcW7YlH+Qc+
	GJZLoxRrXFVXIwSG2y+TgBREyMEyAan0OBeXjWITbu/6gGTyMDSUANr5i/xXyIkvHtrjGpfEy+W
	SJYiIPWA5aViRyi7bVCg1iClZJgvflB2S2ZCTC2ooNdLsb8pDAjUT3utyE8PZp0JN1AP3tq84Z6
	/pH87wLYx/6zxNA==
X-Google-Smtp-Source: AGHT+IHFvVcUbFzxb95rdveSXgYGAH77wTve8JwIh+zgeFvLOJRWZQ+6TNPtIGSAG50EJt081mp86g==
X-Received: by 2002:a05:6871:314b:b0:2d5:2955:aa6c with SMTP id 586e51a60fabf-2f76c9ed2cbmr3501437fac.31.1751568680025;
        Thu, 03 Jul 2025 11:51:20 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:cd4:2776:8c4a:3597])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f90d1ccsm68195a34.44.2025.07.03.11.51.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Jul 2025 11:51:19 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredb.hu>,
	Bernd Schubert <bschubert@ddn.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	John Groves <john@groves.net>
Subject: [RFC V2 12/18] famfs_fuse: Plumb the GET_FMAP message/response
Date: Thu,  3 Jul 2025 13:50:26 -0500
Message-Id: <20250703185032.46568-13-john@groves.net>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250703185032.46568-1-john@groves.net>
References: <20250703185032.46568-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upon completion of an OPEN, if we're in famfs-mode we do a GET_FMAP to
retrieve and cache up the file-to-dax map in the kernel. If this
succeeds, read/write/mmap are resolved direct-to-dax with no upcalls.

GET_FMAP has a variable-size response payload, and the allocated size
is sent in the in_args[0].size field. If the fmap would overflow the
message, the fuse server sends a reply of size 'sizeof(uint32_t)' which
specifies the size of the fmap message. Then the kernel can realloc a
large enough buffer and try again.

Signed-off-by: John Groves <john@groves.net>
---
 fs/fuse/file.c            | 84 +++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h          | 36 ++++++++++++++++-
 fs/fuse/inode.c           | 19 +++++++--
 fs/fuse/iomode.c          |  2 +-
 include/uapi/linux/fuse.h | 18 +++++++++
 5 files changed, 154 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 93b82660f0c8..8616fb0a6d61 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -230,6 +230,77 @@ static void fuse_truncate_update_attr(struct inode *inode, struct file *file)
 	fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
 }
 
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+
+#define FMAP_BUFSIZE 4096
+
+static int
+fuse_get_fmap(struct fuse_mount *fm, struct inode *inode, u64 nodeid)
+{
+	struct fuse_get_fmap_in inarg = { 0 };
+	size_t fmap_bufsize = FMAP_BUFSIZE;
+	ssize_t fmap_size;
+	int retries = 1;
+	void *fmap_buf;
+	int rc;
+
+	FUSE_ARGS(args);
+
+	fmap_buf = kcalloc(1, FMAP_BUFSIZE, GFP_KERNEL);
+	if (!fmap_buf)
+		return -EIO;
+
+ retry_once:
+	inarg.size = fmap_bufsize;
+
+	args.opcode = FUSE_GET_FMAP;
+	args.nodeid = nodeid;
+
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(inarg);
+	args.in_args[0].value = &inarg;
+
+	/* Variable-sized output buffer
+	 * this causes fuse_simple_request() to return the size of the
+	 * output payload
+	 */
+	args.out_argvar = true;
+	args.out_numargs = 1;
+	args.out_args[0].size = fmap_bufsize;
+	args.out_args[0].value = fmap_buf;
+
+	/* Send GET_FMAP command */
+	rc = fuse_simple_request(fm, &args);
+	if (rc < 0) {
+		pr_err("%s: err=%d from fuse_simple_request()\n",
+		       __func__, rc);
+		return rc;
+	}
+	fmap_size = rc;
+
+	if (retries && fmap_size == sizeof(uint32_t)) {
+		/* fmap size exceeded fmap_bufsize;
+		 * actual fmap size returned in fmap_buf;
+		 * realloc and retry once
+		 */
+		fmap_bufsize = *((uint32_t *)fmap_buf);
+
+		--retries;
+		kfree(fmap_buf);
+		fmap_buf = kcalloc(1, fmap_bufsize, GFP_KERNEL);
+		if (!fmap_buf)
+			return -EIO;
+
+		goto retry_once;
+	}
+
+	/* Will call famfs_file_init_dax() when that gets added */
+
+	kfree(fmap_buf);
+	return 0;
+}
+#endif
+
 static int fuse_open(struct inode *inode, struct file *file)
 {
 	struct fuse_mount *fm = get_fuse_mount(inode);
@@ -263,6 +334,19 @@ static int fuse_open(struct inode *inode, struct file *file)
 
 	err = fuse_do_open(fm, get_node_id(inode), file, false);
 	if (!err) {
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+		if (fm->fc->famfs_iomap) {
+			if (S_ISREG(inode->i_mode)) {
+				int rc;
+				/* Get the famfs fmap */
+				rc = fuse_get_fmap(fm, inode,
+						   get_node_id(inode));
+				if (rc)
+					pr_err("%s: fuse_get_fmap err=%d\n",
+					       __func__, rc);
+			}
+		}
+#endif
 		ff = file->private_data;
 		err = fuse_finish_open(inode, file);
 		if (err)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f4ee61046578..e01d6e5c6e93 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -193,6 +193,10 @@ struct fuse_inode {
 	/** Reference to backing file in passthrough mode */
 	struct fuse_backing *fb;
 #endif
+
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+	void *famfs_meta;
+#endif
 };
 
 /** FUSE inode state bits */
@@ -945,6 +949,8 @@ struct fuse_conn {
 #endif
 
 #if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+	struct rw_semaphore famfs_devlist_sem;
+	struct famfs_dax_devlist *dax_devlist;
 	char *shadow;
 #endif
 };
@@ -1435,11 +1441,14 @@ void fuse_free_conn(struct fuse_conn *fc);
 
 /* dax.c */
 
+static inline int fuse_file_famfs(struct fuse_inode *fi); /* forward */
+
 /* This macro is used by virtio_fs, but now it also needs to filter for
  * "not famfs"
  */
 #define FUSE_IS_VIRTIO_DAX(fuse_inode) (IS_ENABLED(CONFIG_FUSE_DAX)	\
-					&& IS_DAX(&fuse_inode->inode))
+					&& IS_DAX(&fuse_inode->inode)	\
+					&& !fuse_file_famfs(fuse_inode))
 
 ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to);
 ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from);
@@ -1550,4 +1559,29 @@ extern void fuse_sysctl_unregister(void);
 #define fuse_sysctl_unregister()	do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
+/* famfs.c */
+static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
+						       void *meta)
+{
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+	return xchg(&fi->famfs_meta, meta);
+#else
+	return NULL;
+#endif
+}
+
+static inline void famfs_meta_free(struct fuse_inode *fi)
+{
+	/* Stub wil be connected in a subsequent commit */
+}
+
+static inline int fuse_file_famfs(struct fuse_inode *fi)
+{
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+	return (READ_ONCE(fi->famfs_meta) != NULL);
+#else
+	return 0;
+#endif
+}
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index a7e1cf8257b0..b071d16f7d04 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -117,6 +117,9 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		fuse_inode_backing_set(fi, NULL);
 
+	if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
+		famfs_meta_set(fi, NULL);
+
 	return &fi->inode;
 
 out_free_forget:
@@ -138,6 +141,13 @@ static void fuse_free_inode(struct inode *inode)
 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		fuse_backing_put(fuse_inode_backing(fi));
 
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+	if (S_ISREG(inode->i_mode) && fi->famfs_meta) {
+		famfs_meta_free(fi);
+		famfs_meta_set(fi, NULL);
+	}
+#endif
+
 	kmem_cache_free(fuse_inode_cachep, fi);
 }
 
@@ -1002,6 +1012,9 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		fuse_backing_files_init(fc);
 
+	if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
+		pr_notice("%s: Kernel is FUSE_FAMFS_DAX capable\n", __func__);
+
 	INIT_LIST_HEAD(&fc->mounts);
 	list_add(&fm->fc_entry, &fc->mounts);
 	fm->fc = fc;
@@ -1036,9 +1049,8 @@ void fuse_conn_put(struct fuse_conn *fc)
 		}
 		if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 			fuse_backing_files_free(fc);
-#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
-		kfree(fc->shadow);
-#endif
+		if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
+			kfree(fc->shadow);
 		call_rcu(&fc->rcu, delayed_release);
 	}
 }
@@ -1425,6 +1437,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				 * those capabilities, they are held here).
 				 */
 				fc->famfs_iomap = 1;
+				init_rwsem(&fc->famfs_devlist_sem);
 			}
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index aec4aecb5d79..443b337b0c05 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -204,7 +204,7 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 	 * io modes are not relevant with DAX and with server that does not
 	 * implement open.
 	 */
-	if (FUSE_IS_VIRTIO_DAX(fi) || !ff->args)
+	if (FUSE_IS_VIRTIO_DAX(fi) || fuse_file_famfs(fi) || !ff->args)
 		return 0;
 
 	/*
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 6c384640c79b..dff5aa62543e 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -654,6 +654,10 @@ enum fuse_opcode {
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
 
+	/* Famfs / devdax opcodes */
+	FUSE_GET_FMAP           = 53,
+	FUSE_GET_DAXDEV         = 54,
+
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
 
@@ -888,6 +892,16 @@ struct fuse_access_in {
 	uint32_t	padding;
 };
 
+struct fuse_get_fmap_in {
+	uint32_t	size;
+	uint32_t	padding;
+};
+
+struct fuse_get_fmap_out {
+	uint32_t	size;
+	uint32_t	padding;
+};
+
 struct fuse_init_in {
 	uint32_t	major;
 	uint32_t	minor;
@@ -1284,4 +1298,8 @@ struct fuse_uring_cmd_req {
 	uint8_t padding[6];
 };
 
+/* Famfs fmap message components */
+
+#define FAMFS_FMAP_MAX 32768 /* Largest supported fmap message */
+
 #endif /* _LINUX_FUSE_H */
-- 
2.49.0



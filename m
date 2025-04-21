Return-Path: <linux-fsdevel+bounces-46753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0747A94A50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 03:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE9D3B1AE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 01:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61A01F5EA;
	Mon, 21 Apr 2025 01:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyfLxza2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DE519AD90;
	Mon, 21 Apr 2025 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745199265; cv=none; b=Zx+cHl8v1KaFVsvKG1W1Itb0lSgyBATdh73W2mlONmojt9WmMkMBwWLkLsoKmRiqlJh/XbD/Pr/HDdG65D+sDhIT9P8kxE0q1jYht6v0MlsygGdUFuOyO78xmWyKE+aUvsf7QUZSqQuCxLuEJx6lzuCbX6zWo1uJD/9xLZyYxd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745199265; c=relaxed/simple;
	bh=NBFBCMmJVtINYLC+p85CstqmUXiKs92cuvnznL6fml0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GIzCvC2TUc3MY+vz4y4Cg/TfGSiENhiZtfPSWhlwvLehqfJWwyrFmHAE4XnpFdNksY9Mxjd0DQZVpolH5XBSV60X7BUf9dimuaWWGFJrJo6SAZurVTpLT98+266L3gaLmaV4IMrFAi25599V4TgqngTMk3PY/e569h6+JSurRzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyfLxza2; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c12b7af278so2616115fac.0;
        Sun, 20 Apr 2025 18:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745199262; x=1745804062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4l0xj8nWHJ4Rf/x2g8EIw8lI123T+hiPwW7l4PX87U=;
        b=gyfLxza227j4z+2ihhUTJfzSZt4LEMGx1Sk+kuVLKpXnePC8uIx3jKoNszlLtV2Eut
         /CljHDSKYgOnvaR+WFsVSwNF0EB+KiPD/yvmCTDsTNziaasHWhfq+FRlMU4A+0hiYZHH
         YyHohiGl1irnpDtPtlxg/CwnCyC2JoYpkbZLLYoV3lXCo7OXJoimakCxLs5ixE58DFj5
         nNCnjOjlo0BIK8Kb/bz/ELeN2mudSmoSoPocCLOVIm1D++7b9TDlJCiWRRbVxA/jTr2S
         tRQNfg3Io5SRdAUjFZGzMppwZ5vNm26MPCcaVWO2RSNb7sGN5WRSwS6O2GRkoSlGDzkL
         wXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745199262; x=1745804062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S4l0xj8nWHJ4Rf/x2g8EIw8lI123T+hiPwW7l4PX87U=;
        b=i2j1vCe0xh2BuG+XyzTbKHJ3x8mQXYgGybQoqBRh3zXxf/qdy7yIYhY6fxI7rCGofU
         VKLBDgOl8ow/GP8cJzZwwV9WANftzcXrr3UZxi84IlFQVb3XwCp3gWdF2UnJxBIskuY+
         X0zP35uv7esSA1hG+0on1Y34o/ZD/3VPlOyWs7I0XGxaPoEq46AkYLUys8TFQ8fv+YuW
         B8iZMXlkT7DoEcUhPEezgQUQOsQW5t6wU/QYHCoParxiFQVV/627FZIB9qBgHHF1e/5Q
         TdTIRwmib2jqX4kILMJ9j+jciny4U8jtLhB7lDq/FWO6rW/wOK3DKZey3FXYgmt0P5Xa
         fGnw==
X-Forwarded-Encrypted: i=1; AJvYcCVrRJymvnrol8OPvoRYsD1mmazSFGyg8U1EkiuuipdVoPmXz0IeeQmPAPy+M+gcgwMn4tHr/vyg20g=@vger.kernel.org, AJvYcCVyUSAN8BYdxGF+tClIZtJjr5Iez0TJb3+eXU6saEeA5Y7L9x1F5ABY7295SqJmLnzfYSco7Wj8iv+z@vger.kernel.org, AJvYcCWhwMbf1Sx3Xa2KfA7O2sSNxSSRQHt0m+y7tTFeX0UDXbaE+CnGY1Q1sBCAAVqdBsnxH43j6jJcPsL9T4j8GQ==@vger.kernel.org, AJvYcCWlWzbPCcAGIFl+N1X2SkHbpzeyHzR8xq5eIDnErgMfHc2FyMV81D5aXYi6If51kZbP/6ENeAFMpeV5Elv2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6MFF79+8FdRk9OT7q0QINUgmyZENnNaN3SmPAUSGjRc9e/hDM
	v7BPWlzNWTNk2Iz0Md9jkTk6SSarREHCMD5ETIPPJAgjfBBpIoFL
X-Gm-Gg: ASbGncu1iJt5FL91IPrCDmhX7alxLQKIqw+G/x3wYy0I0kbVuvXwPS2R/VNJKrmjYWG
	5lkxqMN3Fj5f9useVfVIbrG7sTppECFwTXwmuhziLrshUbr0TAyS+ZA/hZ9FMEhUl10qQXJtc7i
	dVL9bjwkO+3OEQNVqlc2/15JukGOABFuKeuQ1kx561tht2uj3pTkmceVRC5LBLd015R6g0CeK+f
	5hxGy3KuDWTC4Ljcpczqf1NtP+oAv8nfI0Zmri3TDAXw5ajC3ivLupQcdLzvPI7P3ZvGs4s2Ko9
	2/dCuCs5gBok1sbw6oXHf9Cp2FN44ts3/zfY9nDDOwutRXbNLAVS2yw49jjRQ4zC/d8Ltw==
X-Google-Smtp-Source: AGHT+IH+F+vidrl3lXbIj79JZOASg2RETw/fdPHhelmpnW9w5aZoCaDED62KrXIK7M8C0GadLQoEYw==
X-Received: by 2002:a05:6871:551e:b0:2c1:2262:7941 with SMTP id 586e51a60fabf-2d5288102f8mr5483185fac.16.1745199262491;
        Sun, 20 Apr 2025 18:34:22 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a8f7:1b36:93ce:8dbf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300489cd44sm1267588a34.66.2025.04.20.18.34.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Apr 2025 18:34:22 -0700 (PDT)
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
	Luis Henriques <luis@igalia.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Petr Vorel <pvorel@suse.cz>,
	Brian Foster <bfoster@redhat.com>,
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
Subject: [RFC PATCH 09/19] famfs_fuse: Update macro s/FUSE_IS_DAX/FUSE_IS_VIRTIO_DAX/
Date: Sun, 20 Apr 2025 20:33:36 -0500
Message-Id: <20250421013346.32530-10-john@groves.net>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250421013346.32530-1-john@groves.net>
References: <20250421013346.32530-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Virtio_fs now needs to determine if an inode is DAX && not famfs.

Signed-off-by: John Groves <john@groves.net>
---
 fs/fuse/dir.c    |  2 +-
 fs/fuse/file.c   | 13 ++++++++-----
 fs/fuse/fuse_i.h |  6 +++++-
 fs/fuse/inode.c  |  2 +-
 fs/fuse/iomode.c |  2 +-
 5 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 3805f9b06c9d..bc29db0117f4 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1937,7 +1937,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		is_truncate = true;
 	}
 
-	if (FUSE_IS_DAX(inode) && is_truncate) {
+	if (FUSE_IS_VIRTIO_DAX(fi) && is_truncate) {
 		filemap_invalidate_lock(mapping);
 		fault_blocked = true;
 		err = fuse_dax_break_layouts(inode, 0, 0);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index d63e56fd3dd2..6f10ae54e710 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -239,7 +239,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 	int err;
 	bool is_truncate = (file->f_flags & O_TRUNC) && fc->atomic_o_trunc;
 	bool is_wb_truncate = is_truncate && fc->writeback_cache;
-	bool dax_truncate = is_truncate && FUSE_IS_DAX(inode);
+	bool dax_truncate = is_truncate && FUSE_IS_VIRTIO_DAX(fi);
 
 	if (fuse_is_bad(inode))
 		return -EIO;
@@ -1770,11 +1770,12 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct file *file = iocb->ki_filp;
 	struct fuse_file *ff = file->private_data;
 	struct inode *inode = file_inode(file);
+	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	if (fuse_is_bad(inode))
 		return -EIO;
 
-	if (FUSE_IS_DAX(inode))
+	if (FUSE_IS_VIRTIO_DAX(fi))
 		return fuse_dax_read_iter(iocb, to);
 
 	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
@@ -1791,11 +1792,12 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct file *file = iocb->ki_filp;
 	struct fuse_file *ff = file->private_data;
 	struct inode *inode = file_inode(file);
+	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	if (fuse_is_bad(inode))
 		return -EIO;
 
-	if (FUSE_IS_DAX(inode))
+	if (FUSE_IS_VIRTIO_DAX(fi))
 		return fuse_dax_write_iter(iocb, from);
 
 	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
@@ -2627,10 +2629,11 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = ff->fm->fc;
 	struct inode *inode = file_inode(file);
+	struct fuse_inode *fi = get_fuse_inode(inode);
 	int rc;
 
 	/* DAX mmap is superior to direct_io mmap */
-	if (FUSE_IS_DAX(inode))
+	if (FUSE_IS_VIRTIO_DAX(fi))
 		return fuse_dax_mmap(file, vma);
 
 	/*
@@ -3191,7 +3194,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 		.mode = mode
 	};
 	int err;
-	bool block_faults = FUSE_IS_DAX(inode) &&
+	bool block_faults = FUSE_IS_VIRTIO_DAX(fi) &&
 		(!(mode & FALLOC_FL_KEEP_SIZE) ||
 		 (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)));
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index fee96fe7887b..e04d160fa995 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1423,7 +1423,11 @@ void fuse_free_conn(struct fuse_conn *fc);
 
 /* dax.c */
 
-#define FUSE_IS_DAX(inode) (IS_ENABLED(CONFIG_FUSE_DAX) && IS_DAX(inode))
+/* This macro is used by virtio_fs, but now it also needs to filter for
+ * "not famfs"
+ */
+#define FUSE_IS_VIRTIO_DAX(fuse_inode) (IS_ENABLED(CONFIG_FUSE_DAX)	\
+					&& IS_DAX(&fuse_inode->inode))
 
 ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to);
 ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e9db2cb8c150..29147657a99f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -164,7 +164,7 @@ static void fuse_evict_inode(struct inode *inode)
 	if (inode->i_sb->s_flags & SB_ACTIVE) {
 		struct fuse_conn *fc = get_fuse_conn(inode);
 
-		if (FUSE_IS_DAX(inode))
+		if (FUSE_IS_VIRTIO_DAX(fi))
 			fuse_dax_inode_cleanup(inode);
 		if (fi->nlookup) {
 			fuse_queue_forget(fc, fi->forget, fi->nodeid,
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index c99e285f3183..aec4aecb5d79 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -204,7 +204,7 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 	 * io modes are not relevant with DAX and with server that does not
 	 * implement open.
 	 */
-	if (FUSE_IS_DAX(inode) || !ff->args)
+	if (FUSE_IS_VIRTIO_DAX(fi) || !ff->args)
 		return 0;
 
 	/*
-- 
2.49.0



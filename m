Return-Path: <linux-fsdevel+bounces-53832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 131B2AF80AC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 20:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354B71CA19C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637282F5471;
	Thu,  3 Jul 2025 18:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ozd2GKoJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E70E2F5321;
	Thu,  3 Jul 2025 18:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568668; cv=none; b=QSr4wFnTZMD4CIJBp2z8/y2w74FhW6YVTSY90x5p+J6/BCfIHyS3dHeb0GzHk+i3jQF/Rwy6yAuML9P24G/DygpnNEIIog4YOT8APe+dBABJeDEe2L2q+Tq3NvQJ2pXbEKZdTK9bI+4lbXOe6gCThDKab9JOjL6gQJrwjexljZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568668; c=relaxed/simple;
	bh=FwBWWFE2JodQotEAZ09YSPxNok+WslGJ0gzN2M0oH74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A+5BejKtFoZvnILbCPq6v6fB44kXAGjX8dnv5uB5cXQqitmL1L4EuEex3gH5s31q6EPZYTqM6ttmuyWYc0S5RcrrUbZZ7N41RaRqqFSbYLivEZ6KSLCDY9BFXNVGZ99AE9/SjSmti3VE84MRjYgkHxuQtaOysfA0Jes7ZzeBALs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ozd2GKoJ; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2efb0b03e40so112884fac.0;
        Thu, 03 Jul 2025 11:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751568666; x=1752173466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evCDkhJIR08sNUN0+XWT7gI7+J9O9q1SPYxnVNyV/TY=;
        b=Ozd2GKoJVH8cywxS+UqI2P8BgSxWMJelhUXfCXd2FDA7YI8EPCCUjyKMnwfuEOACbH
         clt50WP7tcy2zGhz22wQUbVo0chpMX9pnMxgkwecNZgkvum0ETQXKNOFBfsEmUsptE0j
         Z03pdCn+c+xoVQp6pp1bKHMJc/7rU0ZTB2a7H9NMJMKdVns3WcSY7c+ij/kRqAIfSSQ1
         DT5w3l4RNHa904QPIsGTcRv8SDP6uxGQUSembWUnUUXAKxocti9kq5i/uar5YYCa0D7l
         ZckhevsJ7mPd206d3cyRSZXBB4GgDfUq8QDgDVDhrNtSWU82pdqDZsGZyn9z2FcpmTSe
         NaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751568666; x=1752173466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=evCDkhJIR08sNUN0+XWT7gI7+J9O9q1SPYxnVNyV/TY=;
        b=b7XS3JVHjbZIVuklEYUbiPW0hgRfZT3uLDrk2WNRLChdX1M6rvNeVpZK6Rm9VLUsH4
         KrE4DIR4gKO/qy0LGSgWVtNjRRJB/Hze7zSRZoSiiK3fqBa6YK/dq6WjZqzWRtoZGckr
         i9t/ftcNEKvLyuGQcfiRzSOVhiHU4D9GHznj3wEj8B3W9Wggv9T2ppQPu6RA4NlEe4K/
         /o20jnZzqJe/ZSBt9n8nnEFdounAtGTWIhffiOAdCTw0rS6SVoK/48UqQamQ8KGUWQtO
         K2Y9th/rq6/B6aqgtgsClr8fKX75YlrALaFItEXzxX2c/iwOYcUBmVbSRXAVe4CEvpHY
         fkrA==
X-Forwarded-Encrypted: i=1; AJvYcCVudaXaMgP/Am1zylI+5cXIFDT4phPp+mPNMrBu61dobaHkARYHbrn0N/hiSrnu55d/YrypTdOC2njx@vger.kernel.org, AJvYcCX439xIPS2BYO2B3ayGHRdXKIvPU4/q29sbRv3Y1sBJ8vOVSXsvxhKvKk5dDXjZAMDZVMpq7wUppmb3nTHmtQ==@vger.kernel.org, AJvYcCX8zyZgfNVi+/zbmbzH6ZOo1/yVe6RT2h5wKhdNilPrBRhpdWfKsQz+8IFVOYRqTwF2BAR2CiM5aNg=@vger.kernel.org, AJvYcCXR6s4srXuwcCp8ymMwBEHi4Twgb0tmIq+Y+ZpFPSJvqfBG+8mC2Cy3BGVJB2HjHxRZIC2seKmc6XfUjVQu@vger.kernel.org
X-Gm-Message-State: AOJu0YwtZwXAI9hdtu6uoefgf8GYRBZqqac/aEA05QDBF/dbSD7LFWRi
	mH4bw2q3Rtfv2/ymFX8nSUw9EwtFdhkmOHXOrfe9/JlOqxQPZIE/eQvE
X-Gm-Gg: ASbGncu8pVVz0/gLC3W4rQtecndCCyBTpe08wkCLoX/DXZAP0fDXykNb0VDjBh89KNj
	SL7fLWjbnvlnWbYH3P6yyYBqJGTw/1rTbiAIfsmZ//W9hKkjCX1jtROCFEznuZFSDxUaSfBPzzF
	AEWzisyF8s1eizQ9II1p7ESOswIQZ+6ERrueHr4cBMFQC6whYUGS6ipZ9IcXqv5KPR+COZbaoqw
	IWx/hjDICkUjwoGkk9R6HgyATQLjZ4scPHcod3uKjb0/wOuGrgF7cJ0VctNn6lHk3qja1ksD4US
	7ZtSVfxYjzbTKq6LJgSMCqR3SmJfx0ZfIKHzUatlL7jLO1qaf7cvO+7dd7ux01Ok3PMH5HPrfvB
	0YiycILeL4qz7gQ==
X-Google-Smtp-Source: AGHT+IHyOroDuVjL8bFbm4j8Va1txfDJ2jVi74kI/xcjqq2IUD/Ra3Bu/QoyyOKZVocj62ILUhcOoA==
X-Received: by 2002:a05:6870:479b:b0:2ef:de7e:544d with SMTP id 586e51a60fabf-2f5a8cf7e46mr6599486fac.27.1751568666156;
        Thu, 03 Jul 2025 11:51:06 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:cd4:2776:8c4a:3597])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f90d1ccsm68195a34.44.2025.07.03.11.51.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Jul 2025 11:51:05 -0700 (PDT)
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
Subject: [RFC V2 09/18] famfs_fuse: Update macro s/FUSE_IS_DAX/FUSE_IS_VIRTIO_DAX/
Date: Thu,  3 Jul 2025 13:50:23 -0500
Message-Id: <20250703185032.46568-10-john@groves.net>
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
index 8f699c67561f..ad8cdf7b864a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1939,7 +1939,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		is_truncate = true;
 	}
 
-	if (FUSE_IS_DAX(inode) && is_truncate) {
+	if (FUSE_IS_VIRTIO_DAX(fi) && is_truncate) {
 		filemap_invalidate_lock(mapping);
 		fault_blocked = true;
 		err = fuse_dax_break_layouts(inode, 0, -1);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 754378dd9f71..93b82660f0c8 100644
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
index 2086dac7243b..9d87ac48d724 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1426,7 +1426,11 @@ void fuse_free_conn(struct fuse_conn *fc);
 
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



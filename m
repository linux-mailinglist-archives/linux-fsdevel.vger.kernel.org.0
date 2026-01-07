Return-Path: <linux-fsdevel+bounces-72647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8007CFFC79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 20:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A74573253F11
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 18:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C443933F4;
	Wed,  7 Jan 2026 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTSrqzPz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFA23933ED
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800056; cv=none; b=IuzH5HpD2sKAjdkSLWX/391FbjKiJZficl31HcSqSMvqSzhSrdlDrb9nnNEK+uaCOJH7HcMSPqQ6f+Tz6M2u4HEeOa+HMHPjERxxUYtEjOaTcwfLSSNnqjcrtxjWhmxrah4dXV6AKHshinMCCgTqOWrtsnZW3q1mxgbNDSDXwps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800056; c=relaxed/simple;
	bh=KDdIsA9D92H7U82UXu8uRfeAr/a85ssGj/h8ss0xZlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkgEF3WoThmNmm47NHoZniWZwBrU0KNpUlTAI8nj7QPKRd4EBVOr2lx9ApstbFVAEhi7AeAUwgNIrvPvrr/un860RZh8PCIlfI1VmeOAHFpZ7oVjx/iA7RfTpBQHkXzHUVURyJGSMv+wuYdsjGY7EK48U+UdSYOvEoZXxnMkPIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTSrqzPz; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-45392215f74so1095635b6e.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 07:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800053; x=1768404853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBLWubQyI6xZVEp0jqdiIeZ2GXSmn2JLxEmTFZ45eqM=;
        b=UTSrqzPzZsLJoa+3EZGSx8ckaD7su+jBeOoFOF6p14d2SgZ5RoXejUYiX6UK0mSaJB
         67y2EbucQNS8YGAsyOrB308ZXNrS4hkgBz/HAoKqPau76rbZDNzjbN4L9A+jub+zhAiX
         6exFP0DGunPk+pHyobmuMzRkvCDhmjOThpqlxpYrrdvUYonF88ZKCAQXgakwxWCU9B6E
         ellAT2m+voJ+F9tET8rfwhDG78Ut/+yr+zqrhZUP02bakLr9c68Zakv8YFoRCJYVMe1h
         1hwix+Hmn9E3LlLWHwbTjCP6e3CKMCL3zv0AvtUvJyGyUijG5APTE+q9HE8qtPSKSRJz
         x2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800053; x=1768404853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBLWubQyI6xZVEp0jqdiIeZ2GXSmn2JLxEmTFZ45eqM=;
        b=r0Mp0ewGBIjLyloAFFEALUP3KLhO4uWBu2z/7JpllrZlCAOf0xa/O6plspzsXPVU8O
         BsE2MyvYjv0R7O9ofKlHlMeQ0eQ4BW9/6qmbIShdbsm8biN//T4FPMx4t2QmtLVPKBaZ
         86vFMv1rDy9TsQWTCPr88I2pVoCxTMWQvIoM1NB7OR8lsj7+65Xw5L/29D0Eps9cP0vE
         +9dh/Y0kfc/OVJCqyJFpm93Hc+b4t9pfiWl0B/VQBrxSk5K650WhzBGkpAvaXF2l3W6Z
         VhDavs0bNxAZuOWHvgw9IxVVj5g0DC5nqOnzaj3xorqBpjbsSiQyqGBpxn+xWjsSC+ZI
         0MYw==
X-Forwarded-Encrypted: i=1; AJvYcCUUpjXi+eup4p4RbrNIX3rMET1mF6IJdZcOgRlDFZygLFFz7DBZV7F5ImB0KFSwSUJK6wo6dcJYEuXc8C+n@vger.kernel.org
X-Gm-Message-State: AOJu0Yw67f6bHUyJdRChv7APgpLKvCFR4/+dpp5XgxX6AjyywM6WaIdx
	5Vo7goIzZstOrgXmhQEYchGDzccM7CiM1velyis0eKkLpHdDTjtAD3Kn
X-Gm-Gg: AY/fxX41vOQK49w7XZKV10qd3EGBNfAjv2ot8AQTT5EWfdS4jyfFIq9uXyDoRyZ7D8+
	MrlgRr5n3Ym6rHdpguLHLkPzRrzJB/5u+EJ/nGsLuqmR+kYOpUGZV2qBb++HubYivtb5fZAkAte
	GNu2snG6kLqPrD30GKPO2aloL1We1JGf2nv95m405U8X0Ail1yud0RkUV47vFbh5htHFDNV8xnP
	UViS3WkqcnorLlBXo4QPhZwITOh9WL1OqtST+17HIrlG1X65CVmxP+os6O49/sPycPadZ4++GB6
	iWbDfuQ/wulBFkZpIZTF/WY1yAvGJG5rK8L5vXVdJOyUqOViG4luMvKbH419nu6o3vvBrE1JcGL
	NqxbsQTzlKNXfKKPtl3Fn2Ze3VU/oz60L1FU8KO+RcnBHqCo3LPG8dI2qZO+4ZLZXoKAB/cvzTK
	rtRwkHRVSLbJk7TRcEq3w1g9sINF/JQjgSVlJSO7NHf1wH
X-Google-Smtp-Source: AGHT+IFOd8s1wzfv2HGwBLfy7yoEMT8R9K3YpHqc6qg9LqPf5eknmZBY0Kt5yrjbMWCqtHbEQ9YNXw==
X-Received: by 2002:a05:6808:3206:b0:450:c6af:7c25 with SMTP id 5614622812f47-45a6bd8b7a2mr1331578b6e.21.1767800052873;
        Wed, 07 Jan 2026 07:34:12 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2f1de5sm2398106b6e.22.2026.01.07.07.34.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:34:12 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	John Groves <john@groves.net>
Subject: [PATCH V3 11/21] famfs_fuse: Update macro s/FUSE_IS_DAX/FUSE_IS_VIRTIO_DAX/
Date: Wed,  7 Jan 2026 09:33:20 -0600
Message-ID: <20260107153332.64727-12-john@groves.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107153332.64727-1-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
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
 fs/fuse/inode.c  |  4 ++--
 fs/fuse/iomode.c |  2 +-
 5 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4b6b3d2758ff..1400c9d733ba 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2153,7 +2153,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		is_truncate = true;
 	}
 
-	if (FUSE_IS_DAX(inode) && is_truncate) {
+	if (FUSE_IS_VIRTIO_DAX(fi) && is_truncate) {
 		filemap_invalidate_lock(mapping);
 		fault_blocked = true;
 		err = fuse_dax_break_layouts(inode, 0, -1);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 01bc894e9c2b..093569033ed1 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -252,7 +252,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 	int err;
 	bool is_truncate = (file->f_flags & O_TRUNC) && fc->atomic_o_trunc;
 	bool is_wb_truncate = is_truncate && fc->writeback_cache;
-	bool dax_truncate = is_truncate && FUSE_IS_DAX(inode);
+	bool dax_truncate = is_truncate && FUSE_IS_VIRTIO_DAX(fi);
 
 	if (fuse_is_bad(inode))
 		return -EIO;
@@ -1812,11 +1812,12 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
@@ -1833,11 +1834,12 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
@@ -2370,10 +2372,11 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
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
@@ -2934,7 +2937,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 		.mode = mode
 	};
 	int err;
-	bool block_faults = FUSE_IS_DAX(inode) &&
+	bool block_faults = FUSE_IS_VIRTIO_DAX(fi) &&
 		(!(mode & FALLOC_FL_KEEP_SIZE) ||
 		 (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)));
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7f16049387d1..17736c0a6d2f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1508,7 +1508,11 @@ void fuse_free_conn(struct fuse_conn *fc);
 
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
index 819e50d66622..ed667920997f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -162,7 +162,7 @@ static void fuse_evict_inode(struct inode *inode)
 	/* Will write inode on close/munmap and in all other dirtiers */
 	WARN_ON(inode_state_read_once(inode) & I_DIRTY_INODE);
 
-	if (FUSE_IS_DAX(inode))
+	if (FUSE_IS_VIRTIO_DAX(fi))
 		dax_break_layout_final(inode);
 
 	truncate_inode_pages_final(&inode->i_data);
@@ -170,7 +170,7 @@ static void fuse_evict_inode(struct inode *inode)
 	if (inode->i_sb->s_flags & SB_ACTIVE) {
 		struct fuse_conn *fc = get_fuse_conn(inode);
 
-		if (FUSE_IS_DAX(inode))
+		if (FUSE_IS_VIRTIO_DAX(fi))
 			fuse_dax_inode_cleanup(inode);
 		if (fi->nlookup) {
 			fuse_queue_forget(fc, fi->forget, fi->nodeid,
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index 3728933188f3..31ee7f3304c6 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -203,7 +203,7 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 	 * io modes are not relevant with DAX and with server that does not
 	 * implement open.
 	 */
-	if (FUSE_IS_DAX(inode) || !ff->args)
+	if (FUSE_IS_VIRTIO_DAX(fi) || !ff->args)
 		return 0;
 
 	/*
-- 
2.49.0



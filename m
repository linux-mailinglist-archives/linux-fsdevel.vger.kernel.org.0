Return-Path: <linux-fsdevel+bounces-53838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798A2AF80C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 20:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE961778D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98322F85D3;
	Thu,  3 Jul 2025 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYRdxbEI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D50F2F6F9E;
	Thu,  3 Jul 2025 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568693; cv=none; b=f53m+VWfnDOXOorHFgdsWH55u6xaetxhJ0LmizNGJ8nt4ivqJj/PRG5VSYk/GnleWYQJTPlUx5TYUvWCFZJmpYF3m8z+eKM9I0TxOirVAMwLHgm9muR9qVFqnVxjVC6e7qYh+cQElAw7eQtEfo/X5jGksVX8ln7OpYLlNB+R4sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568693; c=relaxed/simple;
	bh=BOJsAT5JU9yIFYDpfXEyB9+S+7Hv/3A62M+Z0QOijvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VTPjafO2x8hF5jaIJiZP6Rcr0St2zu8p1dE07u34MB1OVnZ2RQ1SNzoJ9klKOZlQiywEYqKdGnv0xxXKU6D3UMKwlIw25hsrjn7MY1bUou3YxwC9Ntme+VdtWXN3okNCxTkFWvX6rnWAgx20RqmaU5+nh6P7BlFGK/wSilXBJY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYRdxbEI; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6113f0cafb2so142458eaf.1;
        Thu, 03 Jul 2025 11:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751568689; x=1752173489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFyIPtwb+f2wfKhEolNXeubDWmjHM8QVbI6ON/boaXs=;
        b=iYRdxbEISYFe1oC4C3AO9Np85SWKm11rlYbX4X9x2gNsUj3TzOg9CZmNegVhraHgxM
         mWSpZBZzGP1/WfHaQjWs4fLxQhQr51ry9q9uw3z4sYt42U/k1+FfeymBXSqxuUGhK8FU
         kBuwHNXN2lNd1/bLSBAGYd/y1i3jR9vLU3KxXfeH4tP16N1GWULa8uHukH//FGN1ImI5
         4l/isbg6u6ibexheYaZaYJwmJgpInXhUt86AvWGHaY9FMv1SNVLRbzps1jCvgiI3+ql2
         2cGREwBXepDHqSAHuO8NNF0ji9pHVk+NcOQZtHqW0aPoidEBlYIRO5MVYMCkawNZiOgd
         uqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751568689; x=1752173489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WFyIPtwb+f2wfKhEolNXeubDWmjHM8QVbI6ON/boaXs=;
        b=ObxRVhriHer4b6RoAgYNCr3M7dTOCvF1rK7nbq3B2rChnloy4qQhs5K/02MvYlcVAH
         GDk0qUyqCw8KYIe2eJDGWwKyHbV9LmRuIQigDJ6GEOCpKwW0DsIjiVdqJpQ9LpzsIHPh
         Sann0YUkztOwafHLF2oTJw9l4W+kqCUkRgCGTC9Vbd6YDZlO15cIU24Fj3Gt3p4VGiOe
         t4pNhTZkK2AXEthv6J0ood3lrSvCC0laXGObZQs01hLA/huVjO0WDkgsPSVMrlidEY4e
         rTggvKQXmBnWjw+Dewr3IGSbxvBNZSdTf62j6iHk06xGeiG+dbSwtGGDnMv+gkPtpoWK
         BQpw==
X-Forwarded-Encrypted: i=1; AJvYcCU9FECwdlrTaUuYOM9M3ReOkqVnrJRQ7QxxKdwnzDzoInuwCsWwhIONM01CUSObtA/oPYYwE9csE+dgGLfL/A==@vger.kernel.org, AJvYcCUxIAml3xkrPKFq04HUupL57t7Qtxe/pqmwCgXwhkmG2nZDTB7VUqRVZTPPBnkx3r7B6GrbL5G3zdvz@vger.kernel.org, AJvYcCWNhoFc7OQXhGPIBSTs3ihl/1iT8tvi2Tv6WDrs1cMnspNWaebnaJ/AhrbV6dcbD0CPXXtErYkxv0hvK4Sd@vger.kernel.org, AJvYcCWt+GYkLtXMyuuCZkWsER3O2L0TBaYP4dW1+Zi+bTKJbzjT7AlmLYiYdhAmneWUUAE7xtzWTBY+2bE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhCPLFcx1S8+gnLli81pf65zlwP9IUlTzRQaOrxWSP7XkeW1Se
	mFU7gzhpRdaRKQulYOOfjpQWM7Y6W6xgP5ZqI8gbyfPauruZb1xVe7rs
X-Gm-Gg: ASbGnctFxMo1YXugbw2AnGovc0YzhhflzOdfYIwSf2h4zkzHNVo6dL4S5VL6hK4MTPl
	+DmbHYfWCHyG8XOTRyX+PZG1Z0AotjU5pSiD0xzQ3RAsrop9h/tfbn3QLPe6OGWuKQWQRvLTzki
	65fRDEEmLGGNF/7LAX9Er3HMzGmVK4OdmuCg5fq6IpT9Y8oWsdiLHzFwaHIuC3mB1awYT15BsJn
	uhQKg55zdt2So/pLc3855MVuiCmmm5Kx5nDMwjHnXTxahks7tYoEa34J7C9Nue7A3Wx14GNimur
	4RYuifYzFrUcFTV1kBDFSvKkRTC8UmsLy1pSvVVeomXG5RSdFL0kZ8o6qoOlRhIUgmGV+hEwA8j
	mJcFmEdgFFXugVQ==
X-Google-Smtp-Source: AGHT+IF4/AsU3hXYlgzsQBOZuCM/ZTnM/cRNgmQIpHz32m+WBgqaD9fRFFVAIOuVCyBfHh/4SEtLSQ==
X-Received: by 2002:a05:6820:4b17:b0:611:31a:6ff5 with SMTP id 006d021491bc7-6120116eb87mr6669807eaf.7.1751568689254;
        Thu, 03 Jul 2025 11:51:29 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:cd4:2776:8c4a:3597])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f90d1ccsm68195a34.44.2025.07.03.11.51.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Jul 2025 11:51:28 -0700 (PDT)
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
Subject: [RFC V2 15/18] famfs_fuse: Plumb dax iomap and fuse read/write/mmap
Date: Thu,  3 Jul 2025 13:50:29 -0500
Message-Id: <20250703185032.46568-16-john@groves.net>
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

This commit fills in read/write/mmap handling for famfs files. The
dev_dax_iomap interface is used - just like xfs in fs-dax mode.

Signed-off-by: John Groves <john@groves.net>
---
 fs/fuse/famfs.c  | 436 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c   |  14 ++
 fs/fuse/fuse_i.h |   3 +
 3 files changed, 453 insertions(+)

diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
index f5e01032b825..1973eb10b60b 100644
--- a/fs/fuse/famfs.c
+++ b/fs/fuse/famfs.c
@@ -585,3 +585,439 @@ famfs_file_init_dax(
 	return rc;
 }
 
+/*********************************************************************
+ * iomap_operations
+ *
+ * This stuff uses the iomap (dax-related) helpers to resolve file offsets to
+ * offsets within a dax device.
+ */
+
+static ssize_t famfs_file_bad(struct inode *inode);
+
+static int
+famfs_interleave_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
+			 loff_t file_offset, off_t len, unsigned int flags)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct famfs_file_meta *meta = fi->famfs_meta;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	loff_t local_offset = file_offset;
+	int i;
+
+	/* This function is only for extent_type INTERLEAVED_EXTENT */
+	if (meta->fm_extent_type != INTERLEAVED_EXTENT) {
+		pr_err("%s: bad extent type\n", __func__);
+		goto err_out;
+	}
+
+	if (famfs_file_bad(inode))
+		goto err_out;
+
+	iomap->offset = file_offset;
+
+	for (i = 0; i < meta->fm_niext; i++) {
+		struct famfs_meta_interleaved_ext *fei = &meta->ie[i];
+		u64 chunk_size = fei->fie_chunk_size;
+		u64 nstrips = fei->fie_nstrips;
+		u64 ext_size = fei->fie_nbytes;
+
+		ext_size = min_t(u64, ext_size, meta->file_size);
+
+		if (ext_size == 0) {
+			pr_err("%s: ext_size=%lld file_size=%ld\n",
+			       __func__, fei->fie_nbytes, meta->file_size);
+			goto err_out;
+		}
+
+		/* Is the data is in this striped extent? */
+		if (local_offset < ext_size) {
+			u64 chunk_num       = local_offset / chunk_size;
+			u64 chunk_offset    = local_offset % chunk_size;
+			u64 stripe_num      = chunk_num / nstrips;
+			u64 strip_num       = chunk_num % nstrips;
+			u64 chunk_remainder = chunk_size - chunk_offset;
+			u64 strip_offset    = chunk_offset + (stripe_num * chunk_size);
+			u64 strip_dax_ofs = fei->ie_strips[strip_num].ext_offset;
+			u64 strip_devidx = fei->ie_strips[strip_num].dev_index;
+
+			if (!fc->dax_devlist->devlist[strip_devidx].valid) {
+				pr_err("%s: daxdev=%lld invalid\n", __func__,
+					strip_devidx);
+				goto err_out;
+			}
+			iomap->addr    = strip_dax_ofs + strip_offset;
+			iomap->offset  = file_offset;
+			iomap->length  = min_t(loff_t, len, chunk_remainder);
+
+			iomap->dax_dev = fc->dax_devlist->devlist[strip_devidx].devp;
+
+			iomap->type    = IOMAP_MAPPED;
+			iomap->flags   = flags;
+
+			return 0;
+		}
+		local_offset -= ext_size; /* offset is beyond this striped extent */
+	}
+
+ err_out:
+	pr_err("%s: err_out\n", __func__);
+
+	/* We fell out the end of the extent list.
+	 * Set iomap to zero length in this case, and return 0
+	 * This just means that the r/w is past EOF
+	 */
+	iomap->addr    = 0; /* there is no valid dax device offset */
+	iomap->offset  = file_offset; /* file offset */
+	iomap->length  = 0; /* this had better result in no access to dax mem */
+	iomap->dax_dev = NULL;
+	iomap->type    = IOMAP_MAPPED;
+	iomap->flags   = flags;
+
+	return 0;
+}
+
+/**
+ * famfs_fileofs_to_daxofs() - Resolve (file, offset, len) to (daxdev, offset, len)
+ *
+ * This function is called by famfs_fuse_iomap_begin() to resolve an offset in a
+ * file to an offset in a dax device. This is upcalled from dax from calls to
+ * both  * dax_iomap_fault() and dax_iomap_rw(). Dax finishes the job resolving
+ * a fault to a specific physical page (the fault case) or doing a memcpy
+ * variant (the rw case)
+ *
+ * Pages can be PTE (4k), PMD (2MiB) or (theoretically) PuD (1GiB)
+ * (these sizes are for X86; may vary on other cpu architectures
+ *
+ * @inode:  The file where the fault occurred
+ * @iomap:       To be filled in to indicate where to find the right memory,
+ *               relative  to a dax device.
+ * @file_offset: Within the file where the fault occurred (will be page boundary)
+ * @len:         The length of the faulted mapping (will be a page multiple)
+ *               (will be trimmed in *iomap if it's disjoint in the extent list)
+ * @flags:
+ *
+ * Return values: 0. (info is returned in a modified @iomap struct)
+ */
+static int
+famfs_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
+			 loff_t file_offset, off_t len, unsigned int flags)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct famfs_file_meta *meta = fi->famfs_meta;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	loff_t local_offset = file_offset;
+	int i;
+
+	if (!fc->dax_devlist) {
+		pr_err("%s: null dax_devlist\n", __func__);
+		goto err_out;
+	}
+
+	if (famfs_file_bad(inode))
+		goto err_out;
+
+	if (meta->fm_extent_type == INTERLEAVED_EXTENT)
+		return famfs_interleave_fileofs_to_daxofs(inode, iomap,
+							  file_offset,
+							  len, flags);
+
+	iomap->offset = file_offset;
+
+	for (i = 0; i < meta->fm_nextents; i++) {
+		/* TODO: check devindex too */
+		loff_t dax_ext_offset = meta->se[i].ext_offset;
+		loff_t dax_ext_len    = meta->se[i].ext_len;
+		u64 daxdev_idx = meta->se[i].dev_index;
+
+		if ((dax_ext_offset == 0) &&
+		    (meta->file_type != FAMFS_SUPERBLOCK))
+			pr_warn("%s: zero offset on non-superblock file!!\n",
+				__func__);
+
+		/* local_offset is the offset minus the size of extents skipped
+		 * so far; If local_offset < dax_ext_len, the data of interest
+		 * starts in this extent
+		 */
+		if (local_offset < dax_ext_len) {
+			loff_t ext_len_remainder = dax_ext_len - local_offset;
+			struct famfs_daxdev *dd;
+
+			dd = &fc->dax_devlist->devlist[daxdev_idx];
+
+			if (!dd->valid || dd->error) {
+				pr_err("%s: daxdev=%lld %s\n", __func__,
+				       daxdev_idx,
+				       dd->valid ? "error" : "invalid");
+				goto err_out;
+			}
+
+			/*
+			 * OK, we found the file metadata extent where this
+			 * data begins
+			 * @local_offset      - The offset within the current
+			 *                      extent
+			 * @ext_len_remainder - Remaining length of ext after
+			 *                      skipping local_offset
+			 * Outputs:
+			 * iomap->addr:   the offset within the dax device where
+			 *                the  data starts
+			 * iomap->offset: the file offset
+			 * iomap->length: the valid length resolved here
+			 */
+			iomap->addr    = dax_ext_offset + local_offset;
+			iomap->offset  = file_offset;
+			iomap->length  = min_t(loff_t, len, ext_len_remainder);
+
+			iomap->dax_dev = fc->dax_devlist->devlist[daxdev_idx].devp;
+
+			iomap->type    = IOMAP_MAPPED;
+			iomap->flags   = flags;
+			return 0;
+		}
+		local_offset -= dax_ext_len; /* Get ready for the next extent */
+	}
+
+ err_out:
+	pr_err("%s: err_out\n", __func__);
+
+	/* We fell out the end of the extent list.
+	 * Set iomap to zero length in this case, and return 0
+	 * This just means that the r/w is past EOF
+	 */
+	iomap->addr    = 0; /* there is no valid dax device offset */
+	iomap->offset  = file_offset; /* file offset */
+	iomap->length  = 0; /* this had better result in no access to dax mem */
+	iomap->dax_dev = NULL;
+	iomap->type    = IOMAP_MAPPED;
+	iomap->flags   = flags;
+
+	return 0;
+}
+
+/**
+ * famfs_fuse_iomap_begin() - Handler for iomap_begin upcall from dax
+ *
+ * This function is pretty simple because files are
+ * * never partially allocated
+ * * never have holes (never sparse)
+ * * never "allocate on write"
+ *
+ * @inode:  inode for the file being accessed
+ * @offset: offset within the file
+ * @length: Length being accessed at offset
+ * @flags:
+ * @iomap:  iomap struct to be filled in, resolving (offset, length) to
+ *          (daxdev, offset, len)
+ * @srcmap:
+ */
+static int
+famfs_fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+		  unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct famfs_file_meta *meta = fi->famfs_meta;
+	size_t size;
+
+	size = i_size_read(inode);
+
+	WARN_ON(size != meta->file_size);
+
+	return famfs_fileofs_to_daxofs(inode, iomap, offset, length, flags);
+}
+
+/* Note: We never need a special set of write_iomap_ops because famfs never
+ * performs allocation on write.
+ */
+const struct iomap_ops famfs_iomap_ops = {
+	.iomap_begin		= famfs_fuse_iomap_begin,
+};
+
+/*********************************************************************
+ * vm_operations
+ */
+static vm_fault_t
+__famfs_fuse_filemap_fault(struct vm_fault *vmf, unsigned int pe_size,
+		      bool write_fault)
+{
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	vm_fault_t ret;
+	pfn_t pfn;
+
+	if (!IS_DAX(file_inode(vmf->vma->vm_file))) {
+		pr_err("%s: file not marked IS_DAX!!\n", __func__);
+		return VM_FAULT_SIGBUS;
+	}
+
+	if (write_fault) {
+		sb_start_pagefault(inode->i_sb);
+		file_update_time(vmf->vma->vm_file);
+	}
+
+	ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL, &famfs_iomap_ops);
+	if (ret & VM_FAULT_NEEDDSYNC)
+		ret = dax_finish_sync_fault(vmf, pe_size, pfn);
+
+	if (write_fault)
+		sb_end_pagefault(inode->i_sb);
+
+	return ret;
+}
+
+static inline bool
+famfs_is_write_fault(struct vm_fault *vmf)
+{
+	return (vmf->flags & FAULT_FLAG_WRITE) &&
+	       (vmf->vma->vm_flags & VM_SHARED);
+}
+
+static vm_fault_t
+famfs_filemap_fault(struct vm_fault *vmf)
+{
+	return __famfs_fuse_filemap_fault(vmf, 0, famfs_is_write_fault(vmf));
+}
+
+static vm_fault_t
+famfs_filemap_huge_fault(struct vm_fault *vmf, unsigned int pe_size)
+{
+	return __famfs_fuse_filemap_fault(vmf, pe_size, famfs_is_write_fault(vmf));
+}
+
+static vm_fault_t
+famfs_filemap_page_mkwrite(struct vm_fault *vmf)
+{
+	return __famfs_fuse_filemap_fault(vmf, 0, true);
+}
+
+static vm_fault_t
+famfs_filemap_pfn_mkwrite(struct vm_fault *vmf)
+{
+	return __famfs_fuse_filemap_fault(vmf, 0, true);
+}
+
+static vm_fault_t
+famfs_filemap_map_pages(struct vm_fault	*vmf, pgoff_t start_pgoff,
+			pgoff_t	end_pgoff)
+{
+	return filemap_map_pages(vmf, start_pgoff, end_pgoff);
+}
+
+const struct vm_operations_struct famfs_file_vm_ops = {
+	.fault		= famfs_filemap_fault,
+	.huge_fault	= famfs_filemap_huge_fault,
+	.map_pages	= famfs_filemap_map_pages,
+	.page_mkwrite	= famfs_filemap_page_mkwrite,
+	.pfn_mkwrite	= famfs_filemap_pfn_mkwrite,
+};
+
+/*********************************************************************
+ * file_operations
+ */
+
+/**
+ * famfs_file_bad() - Check for files that aren't in a valid state
+ *
+ * @inode - inode
+ *
+ * Returns: 0=success
+ *          -errno=failure
+ */
+static ssize_t
+famfs_file_bad(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct famfs_file_meta *meta = fi->famfs_meta;
+	size_t i_size = i_size_read(inode);
+
+	if (!meta) {
+		pr_err("%s: un-initialized famfs file\n", __func__);
+		return -EIO;
+	}
+	if (meta->error) {
+		pr_debug("%s: previously detected metadata errors\n", __func__);
+		return -EIO;
+	}
+	if (i_size != meta->file_size) {
+		pr_warn("%s: i_size overwritten from %ld to %ld\n",
+		       __func__, meta->file_size, i_size);
+		meta->error = true;
+		return -ENXIO;
+	}
+	if (!IS_DAX(inode)) {
+		pr_debug("%s: inode %llx IS_DAX is false\n", __func__, (u64)inode);
+		return -ENXIO;
+	}
+	return 0;
+}
+
+static ssize_t
+famfs_fuse_rw_prep(struct kiocb *iocb, struct iov_iter *ubuf)
+{
+	struct inode *inode = iocb->ki_filp->f_mapping->host;
+	size_t i_size = i_size_read(inode);
+	size_t count = iov_iter_count(ubuf);
+	size_t max_count;
+	ssize_t rc;
+
+	rc = famfs_file_bad(inode);
+	if (rc)
+		return rc;
+
+	max_count = max_t(size_t, 0, i_size - iocb->ki_pos);
+
+	if (count > max_count)
+		iov_iter_truncate(ubuf, max_count);
+
+	if (!iov_iter_count(ubuf))
+		return 0;
+
+	return rc;
+}
+
+ssize_t
+famfs_fuse_read_iter(struct kiocb *iocb, struct iov_iter	*to)
+{
+	ssize_t rc;
+
+	rc = famfs_fuse_rw_prep(iocb, to);
+	if (rc)
+		return rc;
+
+	if (!iov_iter_count(to))
+		return 0;
+
+	rc = dax_iomap_rw(iocb, to, &famfs_iomap_ops);
+
+	file_accessed(iocb->ki_filp);
+	return rc;
+}
+
+ssize_t
+famfs_fuse_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	ssize_t rc;
+
+	rc = famfs_fuse_rw_prep(iocb, from);
+	if (rc)
+		return rc;
+
+	if (!iov_iter_count(from))
+		return 0;
+
+	return dax_iomap_rw(iocb, from, &famfs_iomap_ops);
+}
+
+int
+famfs_fuse_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct inode *inode = file_inode(file);
+	ssize_t rc;
+
+	rc = famfs_file_bad(inode);
+	if (rc)
+		return (int)rc;
+
+	file_accessed(file);
+	vma->vm_ops = &famfs_file_vm_ops;
+	vm_flags_set(vma, VM_HUGEPAGE);
+	return 0;
+}
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5d205eadb48f..24a14b176510 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1874,6 +1874,8 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 	if (FUSE_IS_VIRTIO_DAX(fi))
 		return fuse_dax_read_iter(iocb, to);
+	if (fuse_file_famfs(fi))
+		return famfs_fuse_read_iter(iocb, to);
 
 	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
 	if (ff->open_flags & FOPEN_DIRECT_IO)
@@ -1896,6 +1898,8 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (FUSE_IS_VIRTIO_DAX(fi))
 		return fuse_dax_write_iter(iocb, from);
+	if (fuse_file_famfs(fi))
+		return famfs_fuse_write_iter(iocb, from);
 
 	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
 	if (ff->open_flags & FOPEN_DIRECT_IO)
@@ -1911,10 +1915,14 @@ static ssize_t fuse_splice_read(struct file *in, loff_t *ppos,
 				unsigned int flags)
 {
 	struct fuse_file *ff = in->private_data;
+	struct inode *inode = file_inode(in);
+	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
 	if (fuse_file_passthrough(ff) && !(ff->open_flags & FOPEN_DIRECT_IO))
 		return fuse_passthrough_splice_read(in, ppos, pipe, len, flags);
+	else if (fuse_file_famfs(fi))
+		return -EIO; /* direct I/O doesn't make sense in dax_iomap */
 	else
 		return filemap_splice_read(in, ppos, pipe, len, flags);
 }
@@ -1923,10 +1931,14 @@ static ssize_t fuse_splice_write(struct pipe_inode_info *pipe, struct file *out,
 				 loff_t *ppos, size_t len, unsigned int flags)
 {
 	struct fuse_file *ff = out->private_data;
+	struct inode *inode = file_inode(out);
+	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
 	if (fuse_file_passthrough(ff) && !(ff->open_flags & FOPEN_DIRECT_IO))
 		return fuse_passthrough_splice_write(pipe, out, ppos, len, flags);
+	else if (fuse_file_famfs(fi))
+		return -EIO; /* direct I/O doesn't make sense in dax_iomap */
 	else
 		return iter_file_splice_write(pipe, out, ppos, len, flags);
 }
@@ -2732,6 +2744,8 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 	/* DAX mmap is superior to direct_io mmap */
 	if (FUSE_IS_VIRTIO_DAX(fi))
 		return fuse_dax_mmap(file, vma);
+	if (fuse_file_famfs(fi))
+		return famfs_fuse_mmap(file, vma);
 
 	/*
 	 * If inode is in passthrough io mode, because it has some file open
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 37298551539c..3b3a1d95367f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1564,6 +1564,9 @@ extern void fuse_sysctl_unregister(void);
 int famfs_file_init_dax(struct fuse_mount *fm,
 			     struct inode *inode, void *fmap_buf,
 			     size_t fmap_size);
+ssize_t famfs_fuse_write_iter(struct kiocb *iocb, struct iov_iter *from);
+ssize_t famfs_fuse_read_iter(struct kiocb *iocb, struct iov_iter	*to);
+int famfs_fuse_mmap(struct file *file, struct vm_area_struct *vma);
 void __famfs_meta_free(void *map);
 void famfs_teardown(struct fuse_conn *fc);
 #endif
-- 
2.49.0



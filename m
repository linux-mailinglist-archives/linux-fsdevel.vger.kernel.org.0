Return-Path: <linux-fsdevel+bounces-53836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB724AF80BA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 20:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF01B188A0C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFA02F6FAC;
	Thu,  3 Jul 2025 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnuCf4qm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42832F3639;
	Thu,  3 Jul 2025 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568685; cv=none; b=QU8j0P+PoqzRkQwv/P8s+dhlICtKwfHBuneJo1oJLx37HgJcyJK9GgWRK+CQOx+5X6u4L0rTLIohZlOTpscrfuSEY+hu4HHMaYv4a01XvLMDOcKrV5YsWMkRVyMECeHu5liEl8oA114GuhcE3dtgF+t7OUmryU/cHc0FVymHtU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568685; c=relaxed/simple;
	bh=3uq435KcAdEmXJ2dEvmM663qcKbyyXlb5cIDAXxXSAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NJgH/pgRe/XsQaqoT3/G9bxwq9XLms2zGNJwmfYdLKG/AhBhJmYi97uzrGqQMcn5IaQ3UpGhgxp2KBnlP+pVfGG3oLjlCILKyvEV9LO9kNY4kHdwSvrxqNOjb6i3EiTtMQBlB2z7Zvaied572Tt8ElUYkviRFPerPL8G5n7f+nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnuCf4qm; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-72c172f1de1so146129a34.3;
        Thu, 03 Jul 2025 11:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751568683; x=1752173483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiBVfwSLB223dPTff0BfZzAs2J9PXPdtMbuyCEnzUFk=;
        b=WnuCf4qm1DOCO5+o9qsamwTczdIaBnKVQgiqWCqXySkmagYiyrtMayVo/S9PDFdB7p
         i7lxSirU/m+m1GuxpCY5IEJ9081t2wJu4+r3KXSCfnIa1TA6+uMP2Q+xaWqzLUtgk3cy
         /tyrelrl2B6TdGtznJnrAwkpTCZwxzou841DXQ2behOPcpSjha41qE91XSCFbjBsyOuf
         QaPmlLgQ93soMV3vEEB+6aHltO0d5QHLB3InC3SwqInsGdkQizI/yZmclwX+NcwkV2B6
         6PHdr2baNpUU5xb8siyx7rQvvjCxhZQq4WB3u/JFWmE8UnTYc/WszW0S/buF0U0sgwTy
         KxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751568683; x=1752173483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BiBVfwSLB223dPTff0BfZzAs2J9PXPdtMbuyCEnzUFk=;
        b=JnTGX7boThbp98iMKZGW+YXd6O4Cx/BOnXFR9qm7xAvWUA2BZciIwwJHdYFJcMfY9W
         yhRGWsjGp/OpB5y8K7Jfk+gfx9JQns4hxwWDjmaleI7K+IVDYxxqNt0T7edkJIO28Gib
         CSLG+087qC/YYT1rQ1hMBt9zIs1EciQXexfWSHiOy5cGNB5aI6dnNdiBkW1+fTr3Z1ln
         1dU6bHE/dFv0aezwfYG9OGbq/H3WwIXbazXYU1HiAxo4zVPH4cspmsW6Yn7wFoPRdYJB
         U8OajSWg3znfUgiRrQy5WhzxZlTAH2cjbo1/lrcB20lBXSbhnR7BAHe0sL+NafQa0leb
         1dqA==
X-Forwarded-Encrypted: i=1; AJvYcCULLo2MyKbnfGk7kQ9ILfXF+xZ8n4eA2R73Nrr2i1crzR2Ql+KAc1BYC1MtRVWrTWh7GwWJXTEDKIC5R3oJfQ==@vger.kernel.org, AJvYcCUvYJRAKS9+Ml94rRCAkmYlPIRuwwznFF7hcllT6QL7dRoTXtsBNAAHEiUOUYk/5i2LwXhgaKjERwXn@vger.kernel.org, AJvYcCWFBKV9I2FMoi5PUTW0xW7CJxYy1ZAkCnWr4c6yY0xo8T3/CfCMpfGlkEm0sJal6SuYHkm8jSJ/d4w=@vger.kernel.org, AJvYcCWhCbhP7VztFCEHvm4WmL7vrH3dWnskGoNYio4Y2iPMFGMNSxwQj8XrItPRdsVJzTaEZxB/NuGJUXPLFKcn@vger.kernel.org
X-Gm-Message-State: AOJu0YxkdN7f3A+kheTEM12l533yuP9DRQvxGLbPtdL8+FLLB3f22v9T
	VftXGkC1js0up8ZgA5dr80TDRfYXlphQ0O0/5poji//iPaUi0XWl1mcF
X-Gm-Gg: ASbGncsC3e04kaFOHRsmRi3DPdgKPkgDWSlGu+ziClx9lW7mCbYVBIr8trPc4O3II+X
	NnsWjZXk22K2ke/Sy70s2u22hAJ4edUdoV/h1l24lyX9pEWQ2wus0mL1JffBa3AU3B6O7yAQktP
	L5+RBoqXMiU3s99XLTMXZSboVxaIZERfLqv73vlWMrU6c3v3TTi9IamZl3hg6xvelUFB7HQSCl2
	pKIOPf0BPcpUFxwEkZTUiD+j+O1gpktMebmKlxA6C0TCbhSYMIwCKKVVdR5rTQV9PV2/tFrD3+z
	MUmHN8gMZ7qwJ7DJ2kK06xMGiDiNP+99izu5W3L8T2oFDd0aT5nLhIdFjysq9Trbaf16kufqV1m
	5Zgsgqxl5VUB6Ag==
X-Google-Smtp-Source: AGHT+IGmPzpo0HD5BF6fh2iRd9KU+SpEfPKk/EoogvAH+BoC56Diym3E75i5H5FPOtaQzBZoqTn2dw==
X-Received: by 2002:a05:6830:3151:b0:73a:9d3d:7bea with SMTP id 46e09a7af769-73b4cce14a7mr6284108a34.24.1751568682800;
        Thu, 03 Jul 2025 11:51:22 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:cd4:2776:8c4a:3597])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f90d1ccsm68195a34.44.2025.07.03.11.51.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Jul 2025 11:51:22 -0700 (PDT)
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
Subject: [RFC V2 13/18] famfs_fuse: Create files with famfs fmaps
Date: Thu,  3 Jul 2025 13:50:27 -0500
Message-Id: <20250703185032.46568-14-john@groves.net>
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

On completion of GET_FMAP message/response, setup the full famfs
metadata such that it's possible to handle read/write/mmap directly to
dax. Note that the devdax_iomap plumbing is not in yet...

Update MAINTAINERS for the new files.

Signed-off-by: John Groves <john@groves.net>
---
 MAINTAINERS               |   9 +
 fs/fuse/Makefile          |   2 +-
 fs/fuse/famfs.c           | 360 ++++++++++++++++++++++++++++++++++++++
 fs/fuse/famfs_kfmap.h     |  63 +++++++
 fs/fuse/file.c            |  15 +-
 fs/fuse/fuse_i.h          |  16 +-
 fs/fuse/inode.c           |   2 +-
 include/uapi/linux/fuse.h |  56 ++++++
 8 files changed, 518 insertions(+), 5 deletions(-)
 create mode 100644 fs/fuse/famfs.c
 create mode 100644 fs/fuse/famfs_kfmap.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c0d5232a473b..02688f27a4d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8808,6 +8808,15 @@ F:	Documentation/networking/failover.rst
 F:	include/net/failover.h
 F:	net/core/failover.c
 
+FAMFS
+M:	John Groves <jgroves@micron.com>
+M:	John Groves <John@Groves.net>
+L:	linux-cxl@vger.kernel.org
+L:	linux-fsdevel@vger.kernel.org
+S:	Supported
+F:	fs/fuse/famfs.c
+F:	fs/fuse/famfs_kfmap.h
+
 FANOTIFY
 M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 3f0f312a31c1..65a12975d734 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -16,5 +16,5 @@ fuse-$(CONFIG_FUSE_DAX) += dax.o
 fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
 fuse-$(CONFIG_SYSCTL) += sysctl.o
 fuse-$(CONFIG_FUSE_IO_URING) += dev_uring.o
-
+fuse-$(CONFIG_FUSE_FAMFS_DAX) += famfs.o
 virtiofs-y := virtio_fs.o
diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
new file mode 100644
index 000000000000..41c4d92f1451
--- /dev/null
+++ b/fs/fuse/famfs.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * famfs - dax file system for shared fabric-attached memory
+ *
+ * Copyright 2023-2025 Micron Technology, Inc.
+ *
+ * This file system, originally based on ramfs the dax support from xfs,
+ * is intended to allow multiple host systems to mount a common file system
+ * view of dax files that map to shared memory.
+ */
+
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/dax.h>
+#include <linux/iomap.h>
+#include <linux/path.h>
+#include <linux/namei.h>
+#include <linux/string.h>
+
+#include "famfs_kfmap.h"
+#include "fuse_i.h"
+
+
+void
+__famfs_meta_free(void *famfs_meta)
+{
+	struct famfs_file_meta *fmap = famfs_meta;
+
+	if (!fmap)
+		return;
+
+	if (fmap) {
+		switch (fmap->fm_extent_type) {
+		case SIMPLE_DAX_EXTENT:
+			kfree(fmap->se);
+			break;
+		case INTERLEAVED_EXTENT:
+			if (fmap->ie)
+				kfree(fmap->ie->ie_strips);
+
+			kfree(fmap->ie);
+			break;
+		default:
+			pr_err("%s: invalid fmap type\n", __func__);
+			break;
+		}
+	}
+	kfree(fmap);
+}
+
+static int
+famfs_check_ext_alignment(struct famfs_meta_simple_ext *se)
+{
+	int errs = 0;
+
+	if (se->dev_index != 0)
+		errs++;
+
+	/* TODO: pass in alignment so we can support the other page sizes */
+	if (!IS_ALIGNED(se->ext_offset, PMD_SIZE))
+		errs++;
+
+	if (!IS_ALIGNED(se->ext_len, PMD_SIZE))
+		errs++;
+
+	return errs;
+}
+
+/**
+ * famfs_fuse_meta_alloc() - Allocate famfs file metadata
+ * @metap:       Pointer to an mcache_map_meta pointer
+ * @ext_count:  The number of extents needed
+ *
+ * Returns: 0=success
+ *          -errno=failure
+ */
+static int
+famfs_fuse_meta_alloc(
+	void *fmap_buf,
+	size_t fmap_buf_size,
+	struct famfs_file_meta **metap)
+{
+	struct famfs_file_meta *meta = NULL;
+	struct fuse_famfs_fmap_header *fmh;
+	size_t extent_total = 0;
+	size_t next_offset = 0;
+	int errs = 0;
+	int i, j;
+	int rc;
+
+	fmh = (struct fuse_famfs_fmap_header *)fmap_buf;
+
+	/* Move past fmh in fmap_buf */
+	next_offset += sizeof(*fmh);
+	if (next_offset > fmap_buf_size) {
+		pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",
+		       __func__, __LINE__, next_offset, fmap_buf_size);
+		return -EINVAL;
+	}
+
+	if (fmh->nextents < 1) {
+		pr_err("%s: nextents %d < 1\n", __func__, fmh->nextents);
+		return -EINVAL;
+	}
+
+	if (fmh->nextents > FUSE_FAMFS_MAX_EXTENTS) {
+		pr_err("%s: nextents %d > max (%d) 1\n",
+		       __func__, fmh->nextents, FUSE_FAMFS_MAX_EXTENTS);
+		return -E2BIG;
+	}
+
+	meta = kzalloc(sizeof(*meta), GFP_KERNEL);
+	if (!meta)
+		return -ENOMEM;
+
+	meta->error = false;
+	meta->file_type = fmh->file_type;
+	meta->file_size = fmh->file_size;
+	meta->fm_extent_type = fmh->ext_type;
+
+	switch (fmh->ext_type) {
+	case FUSE_FAMFS_EXT_SIMPLE: {
+		struct fuse_famfs_simple_ext *se_in;
+
+		se_in = (struct fuse_famfs_simple_ext *)(fmap_buf + next_offset);
+
+		/* Move past simple extents */
+		next_offset += fmh->nextents * sizeof(*se_in);
+		if (next_offset > fmap_buf_size) {
+			pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",
+			       __func__, __LINE__, next_offset, fmap_buf_size);
+			rc = -EINVAL;
+			goto errout;
+		}
+
+		meta->fm_nextents = fmh->nextents;
+
+		meta->se = kcalloc(meta->fm_nextents, sizeof(*(meta->se)),
+				   GFP_KERNEL);
+		if (!meta->se) {
+			rc = -ENOMEM;
+			goto errout;
+		}
+
+		if ((meta->fm_nextents > FUSE_FAMFS_MAX_EXTENTS) ||
+		    (meta->fm_nextents < 1)) {
+			rc = -EINVAL;
+			goto errout;
+		}
+
+		for (i = 0; i < fmh->nextents; i++) {
+			meta->se[i].dev_index  = se_in[i].se_devindex;
+			meta->se[i].ext_offset = se_in[i].se_offset;
+			meta->se[i].ext_len    = se_in[i].se_len;
+
+			/* Record bitmap of referenced daxdev indices */
+			meta->dev_bitmap |= (1 << meta->se[i].dev_index);
+
+			errs += famfs_check_ext_alignment(&meta->se[i]);
+
+			extent_total += meta->se[i].ext_len;
+		}
+		break;
+	}
+
+	case FUSE_FAMFS_EXT_INTERLEAVE: {
+		s64 size_remainder = meta->file_size;
+		struct fuse_famfs_iext *ie_in;
+		int niext = fmh->nextents;
+
+		meta->fm_niext = niext;
+
+		/* Allocate interleaved extent */
+		meta->ie = kcalloc(niext, sizeof(*(meta->ie)), GFP_KERNEL);
+		if (!meta->ie) {
+			rc = -ENOMEM;
+			goto errout;
+		}
+
+		/*
+		 * Each interleaved extent has a simple extent list of strips.
+		 * Outer loop is over separate interleaved extents
+		 */
+		for (i = 0; i < niext; i++) {
+			u64 nstrips;
+			struct fuse_famfs_simple_ext *sie_in;
+
+			/* ie_in = one interleaved extent in fmap_buf */
+			ie_in = (struct fuse_famfs_iext *)
+				(fmap_buf + next_offset);
+
+			/* Move past one interleaved extent header in fmap_buf */
+			next_offset += sizeof(*ie_in);
+			if (next_offset > fmap_buf_size) {
+				pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",
+				       __func__, __LINE__, next_offset,
+				       fmap_buf_size);
+				rc = -EINVAL;
+				goto errout;
+			}
+
+			nstrips = ie_in->ie_nstrips;
+			meta->ie[i].fie_chunk_size = ie_in->ie_chunk_size;
+			meta->ie[i].fie_nstrips    = ie_in->ie_nstrips;
+			meta->ie[i].fie_nbytes     = ie_in->ie_nbytes;
+
+			if (!meta->ie[i].fie_nbytes) {
+				pr_err("%s: zero-length interleave!\n",
+				       __func__);
+				rc = -EINVAL;
+				goto errout;
+			}
+
+			/* sie_in = the strip extents in fmap_buf */
+			sie_in = (struct fuse_famfs_simple_ext *)
+				(fmap_buf + next_offset);
+
+			/* Move past strip extents in fmap_buf */
+			next_offset += nstrips * sizeof(*sie_in);
+			if (next_offset > fmap_buf_size) {
+				pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",
+				       __func__, __LINE__, next_offset,
+				       fmap_buf_size);
+				rc = -EINVAL;
+				goto errout;
+			}
+
+			if ((nstrips > FUSE_FAMFS_MAX_STRIPS) || (nstrips < 1)) {
+				pr_err("%s: invalid nstrips=%lld (max=%d)\n",
+				       __func__, nstrips,
+				       FUSE_FAMFS_MAX_STRIPS);
+				errs++;
+			}
+
+			/* Allocate strip extent array */
+			meta->ie[i].ie_strips = kcalloc(ie_in->ie_nstrips,
+					sizeof(meta->ie[i].ie_strips[0]),
+							GFP_KERNEL);
+			if (!meta->ie[i].ie_strips) {
+				rc = -ENOMEM;
+				goto errout;
+			}
+
+			/* Inner loop is over strips */
+			for (j = 0; j < nstrips; j++) {
+				struct famfs_meta_simple_ext *strips_out;
+				u64 devindex = sie_in[j].se_devindex;
+				u64 offset   = sie_in[j].se_offset;
+				u64 len      = sie_in[j].se_len;
+
+				strips_out = meta->ie[i].ie_strips;
+				strips_out[j].dev_index  = devindex;
+				strips_out[j].ext_offset = offset;
+				strips_out[j].ext_len    = len;
+
+				/* Record bitmap of referenced daxdev indices */
+				meta->dev_bitmap |= (1 << devindex);
+
+				extent_total += len;
+				errs += famfs_check_ext_alignment(&strips_out[j]);
+				size_remainder -= len;
+			}
+		}
+
+		if (size_remainder > 0) {
+			/* Sum of interleaved extent sizes is less than file size! */
+			pr_err("%s: size_remainder %lld (0x%llx)\n",
+			       __func__, size_remainder, size_remainder);
+			rc = -EINVAL;
+			goto errout;
+		}
+		break;
+	}
+
+	default:
+		pr_err("%s: invalid ext_type %d\n", __func__, fmh->ext_type);
+		rc = -EINVAL;
+		goto errout;
+	}
+
+	if (errs > 0) {
+		pr_err("%s: %d alignment errors found\n", __func__, errs);
+		rc = -EINVAL;
+		goto errout;
+	}
+
+	/* More sanity checks */
+	if (extent_total < meta->file_size) {
+		pr_err("%s: file size %ld larger than map size %ld\n",
+		       __func__, meta->file_size, extent_total);
+		rc = -EINVAL;
+		goto errout;
+	}
+
+	*metap = meta;
+
+	return 0;
+errout:
+	__famfs_meta_free(meta);
+	return rc;
+}
+
+/**
+ * famfs_file_init_dax() - init famfs dax file metadata
+ *
+ * @fm:        fuse_mount
+ * @inode:     the inode
+ * @fmap_buf:  fmap response message
+ * @fmap_size: Size of the fmap message
+ *
+ * Initialize famfs metadata for a file, based on the contents of the GET_FMAP
+ * response
+ *
+ * Return: 0=success
+ *          -errno=failure
+ */
+int
+famfs_file_init_dax(
+	struct fuse_mount *fm,
+	struct inode *inode,
+	void *fmap_buf,
+	size_t fmap_size)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct famfs_file_meta *meta = NULL;
+	int rc;
+
+	if (fi->famfs_meta) {
+		pr_notice("%s: i_no=%ld fmap_size=%ld ALREADY INITIALIZED\n",
+			  __func__,
+			  inode->i_ino, fmap_size);
+		return -EEXIST;
+	}
+
+	rc = famfs_fuse_meta_alloc(fmap_buf, fmap_size, &meta);
+	if (rc)
+		goto errout;
+
+	/* Publish the famfs metadata on fi->famfs_meta */
+	inode_lock(inode);
+	if (fi->famfs_meta) {
+		rc = -EEXIST; /* file already has famfs metadata */
+	} else {
+		if (famfs_meta_set(fi, meta) != NULL) {
+			pr_err("%s: file already had metadata\n", __func__);
+			rc = -EALREADY;
+			goto errout;
+		}
+		i_size_write(inode, meta->file_size);
+		inode->i_flags |= S_DAX;
+	}
+	inode_unlock(inode);
+
+ errout:
+	if (rc)
+		__famfs_meta_free(meta);
+
+	return rc;
+}
+
diff --git a/fs/fuse/famfs_kfmap.h b/fs/fuse/famfs_kfmap.h
new file mode 100644
index 000000000000..ce785d76719c
--- /dev/null
+++ b/fs/fuse/famfs_kfmap.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * famfs - dax file system for shared fabric-attached memory
+ *
+ * Copyright 2023-2025 Micron Technology, Inc.
+ */
+#ifndef FAMFS_KFMAP_H
+#define FAMFS_KFMAP_H
+
+/*
+ * These structures are the in-memory metadata format for famfs files. Metadata
+ * retrieved via the GET_FMAP response is converted to this format for use in
+ * resolving file mapping faults.
+ */
+
+enum famfs_file_type {
+	FAMFS_REG,
+	FAMFS_SUPERBLOCK,
+	FAMFS_LOG,
+};
+
+/* We anticipate the possiblity of supporting additional types of extents */
+enum famfs_extent_type {
+	SIMPLE_DAX_EXTENT,
+	INTERLEAVED_EXTENT,
+	INVALID_EXTENT_TYPE,
+};
+
+struct famfs_meta_simple_ext {
+	u64 dev_index;
+	u64 ext_offset;
+	u64 ext_len;
+};
+
+struct famfs_meta_interleaved_ext {
+	u64 fie_nstrips;
+	u64 fie_chunk_size;
+	u64 fie_nbytes;
+	struct famfs_meta_simple_ext *ie_strips;
+};
+
+/*
+ * Each famfs dax file has this hanging from its fuse_inode->famfs_meta
+ */
+struct famfs_file_meta {
+	bool                   error;
+	enum famfs_file_type   file_type;
+	size_t                 file_size;
+	enum famfs_extent_type fm_extent_type;
+	u64 dev_bitmap; /* bitmap of referenced daxdevs by index */
+	union { /* This will make code a bit more readable */
+		struct {
+			size_t         fm_nextents;
+			struct famfs_meta_simple_ext  *se;
+		};
+		struct {
+			size_t         fm_niext;
+			struct famfs_meta_interleaved_ext *ie;
+		};
+	};
+};
+
+#endif /* FAMFS_KFMAP_H */
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8616fb0a6d61..5d205eadb48f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -237,6 +237,7 @@ static void fuse_truncate_update_attr(struct inode *inode, struct file *file)
 static int
 fuse_get_fmap(struct fuse_mount *fm, struct inode *inode, u64 nodeid)
 {
+	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_get_fmap_in inarg = { 0 };
 	size_t fmap_bufsize = FMAP_BUFSIZE;
 	ssize_t fmap_size;
@@ -246,6 +247,10 @@ fuse_get_fmap(struct fuse_mount *fm, struct inode *inode, u64 nodeid)
 
 	FUSE_ARGS(args);
 
+	/* Don't retrieve if we already have the famfs metadata */
+	if (fi->famfs_meta)
+		return 0;
+
 	fmap_buf = kcalloc(1, FMAP_BUFSIZE, GFP_KERNEL);
 	if (!fmap_buf)
 		return -EIO;
@@ -285,6 +290,13 @@ fuse_get_fmap(struct fuse_mount *fm, struct inode *inode, u64 nodeid)
 		 */
 		fmap_bufsize = *((uint32_t *)fmap_buf);
 
+		if (fmap_bufsize < fmap_msg_min_size()
+		    || fmap_bufsize > FAMFS_FMAP_MAX) {
+			pr_err("%s: fmap_size=%ld out of range\n",
+			       __func__, fmap_bufsize);
+			return -EIO;
+		}
+
 		--retries;
 		kfree(fmap_buf);
 		fmap_buf = kcalloc(1, fmap_bufsize, GFP_KERNEL);
@@ -294,7 +306,8 @@ fuse_get_fmap(struct fuse_mount *fm, struct inode *inode, u64 nodeid)
 		goto retry_once;
 	}
 
-	/* Will call famfs_file_init_dax() when that gets added */
+	/* Convert fmap into in-memory format and hang from inode */
+	famfs_file_init_dax(fm, inode, fmap_buf, fmap_size);
 
 	kfree(fmap_buf);
 	return 0;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e01d6e5c6e93..fb6095655403 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1560,11 +1560,18 @@ extern void fuse_sysctl_unregister(void);
 #endif /* CONFIG_SYSCTL */
 
 /* famfs.c */
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+int famfs_file_init_dax(struct fuse_mount *fm,
+			     struct inode *inode, void *fmap_buf,
+			     size_t fmap_size);
+void __famfs_meta_free(void *map);
+#endif
+
 static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
 						       void *meta)
 {
 #if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
-	return xchg(&fi->famfs_meta, meta);
+	return cmpxchg(&fi->famfs_meta, NULL, meta);
 #else
 	return NULL;
 #endif
@@ -1572,7 +1579,12 @@ static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
 
 static inline void famfs_meta_free(struct fuse_inode *fi)
 {
-	/* Stub wil be connected in a subsequent commit */
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+	if (fi->famfs_meta != NULL) {
+		__famfs_meta_free(fi->famfs_meta);
+		famfs_meta_set(fi, NULL);
+	}
+#endif
 }
 
 static inline int fuse_file_famfs(struct fuse_inode *fi)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b071d16f7d04..1682755abf30 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -118,7 +118,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 		fuse_inode_backing_set(fi, NULL);
 
 	if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
-		famfs_meta_set(fi, NULL);
+		fi->famfs_meta = NULL; /* XXX new inodes currently not zeroed; why not? */
 
 	return &fi->inode;
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index dff5aa62543e..ecaaa62910f0 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -231,6 +231,13 @@
  *    - enum fuse_uring_cmd
  *  7.43
  *    - Add FUSE_DAX_FMAP capability - ability to handle in-kernel fsdax maps
+ *    - Add the following structures for the GET_FMAP message reply components:
+ *      - struct fuse_famfs_simple_ext
+ *      - struct fuse_famfs_iext
+ *      - struct fuse_famfs_fmap_header
+ *    - Add the following enumerated types
+ *      - enum fuse_famfs_file_type
+ *      - enum famfs_ext_type
  */
 
 #ifndef _LINUX_FUSE_H
@@ -1300,6 +1307,55 @@ struct fuse_uring_cmd_req {
 
 /* Famfs fmap message components */
 
+#define FAMFS_FMAP_VERSION 1
+
 #define FAMFS_FMAP_MAX 32768 /* Largest supported fmap message */
+#define FUSE_FAMFS_MAX_EXTENTS 32
+#define FUSE_FAMFS_MAX_STRIPS 32
+
+enum fuse_famfs_file_type {
+	FUSE_FAMFS_FILE_REG,
+	FUSE_FAMFS_FILE_SUPERBLOCK,
+	FUSE_FAMFS_FILE_LOG,
+};
+
+enum famfs_ext_type {
+	FUSE_FAMFS_EXT_SIMPLE = 0,
+	FUSE_FAMFS_EXT_INTERLEAVE = 1,
+};
+
+struct fuse_famfs_simple_ext {
+	uint32_t se_devindex;
+	uint32_t reserved;
+	uint64_t se_offset;
+	uint64_t se_len;
+};
+
+struct fuse_famfs_iext { /* Interleaved extent */
+	uint32_t ie_nstrips;
+	uint32_t ie_chunk_size;
+	uint64_t ie_nbytes; /* Total bytes for this interleaved_ext;
+			     * sum of strips may be more
+			     */
+	uint64_t reserved;
+};
+
+struct fuse_famfs_fmap_header {
+	uint8_t file_type; /* enum famfs_file_type */
+	uint8_t reserved;
+	uint16_t fmap_version;
+	uint32_t ext_type; /* enum famfs_log_ext_type */
+	uint32_t nextents;
+	uint32_t reserved0;
+	uint64_t file_size;
+	uint64_t reserved1;
+};
+
+static inline int32_t fmap_msg_min_size(void)
+{
+	/* Smallest fmap message is a header plus one simple extent */
+	return (sizeof(struct fuse_famfs_fmap_header)
+		+ sizeof(struct fuse_famfs_simple_ext));
+}
 
 #endif /* _LINUX_FUSE_H */
-- 
2.49.0



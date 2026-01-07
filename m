Return-Path: <linux-fsdevel+bounces-72651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D543CFF848
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 19:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35ED8300DBB8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 18:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A25395DA9;
	Wed,  7 Jan 2026 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpfcrFJX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4893F395268
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800069; cv=none; b=WUhOsI0bQ1ahXjTeVu5MD76hf8RbChQr2uPy/dASbhKZA/UZsU5RRMkNnBhAUhEOwbXulhJydh/GiTc2cixjOHhhCcsU2wogKx82V2TVce5CXdb77rjerY9jAcFi+QZWD+JCIxzsQTjzoH16jarzR4og+fAxfuEeacZ0aCGSb0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800069; c=relaxed/simple;
	bh=h9Sqjy47srXPlgEvqR6/9J2jNoOZTa7FEL0qXKABD2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuUuMC4WeMzPcyv7QMrYWsj3sTT6vvYrc0LJneSRIzfRLTNUcNX/VL+4FXSC/5f8L10AaOOtTDlFt/rfYQJM4RvgC8mYSPQi7zPMhcRQtIOhcXqXWD22Ma+rL/+v8ERY92iUEeuEqpoHCDSSw1eD3/ZcQV0zWtmaB6vMPKEvfs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpfcrFJX; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-45358572a11so1326214b6e.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 07:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800064; x=1768404864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lJSBmZkR9C+PpVibRCFcFXweP+k0Ln4vPDIoB1U5DA=;
        b=SpfcrFJX4wg9P1AnXM4FGaHKXJrR4NV6zRc7mKFDFUOV7IxPATooNdIV4nFWSI/lmf
         2vb8a2JehdHmDlgREyrgtORrNSXGq2piTYLrEy6YwfAgaZPHIHSv/xUcNMKe18MOqLfK
         48N5LGQ1rF7CiGQK2CfAUzY/PK3SktXpd7VCPYHvHRYvga66z8MGe2A9XD7UebGImgSv
         baoq9QPVwhAZ2G9S3lfB2L8zlB3FUkwUYwBlCeAy0U1ihQaVaI38AOcyuLv3QWJW4KTR
         s+H+qXV27128OFmUtJeBzhHpfzKMtMbXpxo2W1uTpFATrTGPhbTa6Yl/0rBNWtJ7/yog
         D1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800064; x=1768404864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+lJSBmZkR9C+PpVibRCFcFXweP+k0Ln4vPDIoB1U5DA=;
        b=FFxMPBe1WM+wHek7dWR1c+nejbMG+lfU3NWsDbLqxo7SGuNUXYoEEyxba7ZZz+xs7N
         lyGxai42CCS1/Nu+No9Sh3HVh375mpc7z4dq2GD8dW4j5JtF2pyxWebECxSuXam7uKZi
         JpIleNJctzu9hB8lBkt3m7x3AndBnWemMaVMVWtmoLrG9sY6tYrVD5tixcDsxGi5rkov
         4enbtiv4RxJ/7QJkl8owNZIH8xiQ0DZhhwAK0XJh5ovElViLkmnYW+t6MQ7JsX/8WeZe
         Wz8fkq/Jjns+rAZHO243I901ikukYDNxS3gY5NRT/UaRbJXBws4WWd2T+DHfszp4oah3
         iFWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP6p3jCqSkXN0BlDxwu3pfJIA5lfqm/5fNrY1ZM8Qw5FUjhHsc40AYih61zo1vhE4WbN9pXjdsij3dVG1D@vger.kernel.org
X-Gm-Message-State: AOJu0YxmAIiRIGB/wKC3BfwN2u2wyD5Auiu8/UBvvA2VLFnx8GaLTJuh
	jZZkd5EZVi2PUkt+OqgB5qtp4KB8Qg61dSZ8XXcB11AxxqXcv5D3DQ/E
X-Gm-Gg: AY/fxX6JRzytiOf7yYuiw3xKex9pDz2jIeqyncpvcwcJfWyC+0RP8/MZRvp7Apu8a51
	OS8ag75FSJM2B62VC9E1hy0vzT1wcU9+p+ttqRhZ6zIPPC3g+zi9jY3riD/a6CJl9N6ExGSuZSz
	P2AoZ3mDnL+HNrNi0L/nzl9tIBNVNfZkoyebEH/yzXFDLNDfXo73Ti0WrP/5y3CLcgiqGgR6xg5
	mYr9UdV24/5nWm+Pi35qiK4ncBsN95wYBb1CG+sUcK6mrPgfIC0dTFTR8kJyjxiXbLwtYzTwrim
	Wvt3H3lZk70KD2eN7TzBlL6dy7tsaDAZGKDQ+U3m84Xu+9M7NtW1/1XwV6Hysy+H5GGLpjhF3v1
	FyKmkW3HUBUZa2EfOORvtypf7769WBjfTzHs4Zt1S3oIy2Z57og+/649QiurJmH14ufMpL7zi58
	H/MtUnZghc6pNgf1PRaN6tjHX+Td1TUgdof/bBz4vox5FF
X-Google-Smtp-Source: AGHT+IHZ6YQhs0uhhFpPCmYEP9salfbJwKE+Z3jaekz2Pj+nmx8WoppnEXFheRQGdele+77MhXPwcA==
X-Received: by 2002:a05:6808:1801:b0:44f:e512:4ca2 with SMTP id 5614622812f47-45a6be7e99fmr1313009b6e.40.1767800063919;
        Wed, 07 Jan 2026 07:34:23 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2f1de5sm2398106b6e.22.2026.01.07.07.34.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:34:23 -0800 (PST)
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
Subject: [PATCH V3 15/21] famfs_fuse: Create files with famfs fmaps
Date: Wed,  7 Jan 2026 09:33:24 -0600
Message-ID: <20260107153332.64727-16-john@groves.net>
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

On completion of GET_FMAP message/response, setup the full famfs
metadata such that it's possible to handle read/write/mmap directly to
dax. Note that the devdax_iomap plumbing is not in yet...

* Add famfs_kfmap.h: in-memory structures for resolving famfs file maps
  (fmaps) to dax.
* famfs.c: allocate, initialize and free fmaps
* inode.c: only allow famfs mode if the fuse server has CAP_SYS_RAWIO
* Update MAINTAINERS for the new files.

Signed-off-by: John Groves <john@groves.net>
---
 MAINTAINERS               |   1 +
 fs/fuse/famfs.c           | 355 +++++++++++++++++++++++++++++++++++++-
 fs/fuse/famfs_kfmap.h     |  67 +++++++
 fs/fuse/fuse_i.h          |  22 ++-
 fs/fuse/inode.c           |  21 ++-
 include/uapi/linux/fuse.h |  56 ++++++
 6 files changed, 510 insertions(+), 12 deletions(-)
 create mode 100644 fs/fuse/famfs_kfmap.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 526309943026..16b0606a3b85 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10381,6 +10381,7 @@ L:	linux-cxl@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
 S:	Supported
 F:	fs/fuse/famfs.c
+F:	fs/fuse/famfs_kfmap.h
 
 FUTEX SUBSYSTEM
 M:	Thomas Gleixner <tglx@linutronix.de>
diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
index 0f7e3f00e1e7..2aabd1d589fd 100644
--- a/fs/fuse/famfs.c
+++ b/fs/fuse/famfs.c
@@ -17,9 +17,355 @@
 #include <linux/namei.h>
 #include <linux/string.h>
 
+#include "famfs_kfmap.h"
 #include "fuse_i.h"
 
 
+/***************************************************************************/
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
+	if (cmpxchg(metap, NULL, meta) != NULL) {
+		pr_debug("%s: fmap race detected\n", __func__);
+		rc = 0; /* fmap already installed */
+		goto errout;
+	}
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
+	int rc = 0;
+
+	if (fi->famfs_meta) {
+		pr_notice("%s: i_no=%ld fmap_size=%ld ALREADY INITIALIZED\n",
+			  __func__,
+			  inode->i_ino, fmap_size);
+		return 0;
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
+			pr_debug("%s: file already had metadata\n", __func__);
+			__famfs_meta_free(meta);
+			/* rc is 0 - the file is valid */
+			goto unlock_out;
+		}
+		i_size_write(inode, meta->file_size);
+		inode->i_flags |= S_DAX;
+	}
+ unlock_out:
+	inode_unlock(inode);
+
+errout:
+	if (rc)
+		__famfs_meta_free(meta);
+
+	return rc;
+}
+
 #define FMAP_BUFSIZE PAGE_SIZE
 
 int
@@ -63,12 +409,9 @@ fuse_get_fmap(struct fuse_mount *fm, struct inode *inode)
 	}
 	fmap_size = rc;
 
-	/* We retrieved the "fmap" (the file's map to memory), but
-	 * we haven't used it yet. A call to famfs_file_init_dax() will be added
-	 * here in a subsequent patch, when we add the ability to attach
-	 * fmaps to files.
-	 */
+	/* Convert fmap into in-memory format and hang from inode */
+	rc = famfs_file_init_dax(fm, inode, fmap_buf, fmap_size);
 
 	kfree(fmap_buf);
-	return 0;
+	return rc;
 }
diff --git a/fs/fuse/famfs_kfmap.h b/fs/fuse/famfs_kfmap.h
new file mode 100644
index 000000000000..058645cb10a1
--- /dev/null
+++ b/fs/fuse/famfs_kfmap.h
@@ -0,0 +1,67 @@
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
+ * The structures below are the in-memory metadata format for famfs files.
+ * Metadata retrieved via the GET_FMAP response is converted to this format
+ * for use in  resolving file mapping faults.
+ *
+ * The GET_FMAP response contains the same information, but in a more
+ * message-and-versioning-friendly format. Those structs can be found in the
+ * famfs section of include/uapi/linux/fuse.h (aka fuse_kernel.h in libfuse)
+ */
+
+enum famfs_file_type {
+	FAMFS_REG,
+	FAMFS_SUPERBLOCK,
+	FAMFS_LOG,
+};
+
+/* We anticipate the possibility of supporting additional types of extents */
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
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 691c7850cf4e..f9e920e95baf 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1658,6 +1658,12 @@ extern void fuse_sysctl_unregister(void);
 
 /* famfs.c */
 
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+int famfs_file_init_dax(struct fuse_mount *fm,
+			     struct inode *inode, void *fmap_buf,
+			     size_t fmap_size);
+void __famfs_meta_free(void *map);
+#endif
 static inline void famfs_teardown(struct fuse_conn *fc)
 {
 #if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
@@ -1665,11 +1671,18 @@ static inline void famfs_teardown(struct fuse_conn *fc)
 #endif
 }
 
+static inline void famfs_meta_init(struct fuse_inode *fi)
+{
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+	fi->famfs_meta = NULL;
+#endif
+}
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
@@ -1677,7 +1690,12 @@ static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
 
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
index 9e121a1d63b7..391ead26bfa2 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -121,7 +121,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 		fuse_inode_backing_set(fi, NULL);
 
 	if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
-		famfs_meta_set(fi, NULL);
+		famfs_meta_init(fi);
 
 	return &fi->inode;
 
@@ -1485,8 +1485,21 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				timeout = arg->request_timeout;
 
 			if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX) &&
-			    flags & FUSE_DAX_FMAP)
-				fc->famfs_iomap = 1;
+			    flags & FUSE_DAX_FMAP) {
+				/* famfs_iomap is only allowed if the fuse
+				 * server has CAP_SYS_RAWIO. This was checked
+				 * in fuse_send_init, and FUSE_DAX_IOMAP was
+				 * set in in_flags if so. Only allow enablement
+				 * if we find it there. This function is
+				 * normally not running in fuse server context,
+				 * so we can do the capability check here...
+				 */
+				u64 in_flags = ((u64)ia->in.flags2 << 32)
+						| ia->in.flags;
+
+				if (in_flags & FUSE_DAX_FMAP)
+					fc->famfs_iomap = 1;
+			}
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1548,7 +1561,7 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
 		flags |= FUSE_SUBMOUNTS;
 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		flags |= FUSE_PASSTHROUGH;
-	if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
+	if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX) && capable(CAP_SYS_RAWIO))
 		flags |= FUSE_DAX_FMAP;
 
 	/*
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index bfb92a4aa8a9..e6dd3c24bb11 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -243,6 +243,13 @@
  *
  *  7.46
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
@@ -1318,6 +1325,55 @@ struct fuse_uring_cmd_req {
 
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



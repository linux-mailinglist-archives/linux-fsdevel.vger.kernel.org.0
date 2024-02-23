Return-Path: <linux-fsdevel+bounces-12610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6106861A60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 18:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72F01C2513C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 17:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8214146E70;
	Fri, 23 Feb 2024 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFpF8u9U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD03145B1B;
	Fri, 23 Feb 2024 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710183; cv=none; b=IoM4hpDwhiCE3EOcTrqdE7g2ykjL+JUExIi4FfbgeuHAFp5VLJ+L8ZMnAoGO0nn03buCvcsPQNzZe+rBx5KY7bGwAu+kPZLJV28M7/9D2x6v0LiRlKv3r5asGIC/ZyvySFY/uCSfMl1RRDzHa/ikcBarRo7XPNnLN5XHDcfJbEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710183; c=relaxed/simple;
	bh=gfDqrv2IB8dGuNuxnTRTAgf83rxue/Tl0NVJJQh84Bw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rwoThicx1DtuhVSrDWXqPD9pWg1Z5t9P6VUNoXWQ/Cj1nIShohOWPKJbrcYWMNsgW2FvLrCZL/07LwqwgW+MVmtjloB2xzwygxQFR+cQZnugddnWWqbPpUfDZ5c0RwVEBxAmULDB4ChfYl3NfbR93PuVwvK/Q3WXD2JmS+evuT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFpF8u9U; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2185d368211so579688fac.3;
        Fri, 23 Feb 2024 09:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708710180; x=1709314980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1a+mGhIFV5S9yOIM/mTwkpKXjnQFwrZ+3KlU4LOk/M=;
        b=PFpF8u9UhXID6fzATN3sQikfuhvPwtu3FDwQ/kQdk87Xf5CeAhmBvs8UkyGOWu2SSv
         FZUfXAqJqm5jy/RZtSqATgjQKYwZS10AgwCWdYa40mHhrjVisD4IHcer82a/KXDZoHAl
         kIC5raYcnOhT0pLcRAcZbd5UHtY+Hq46xtszhesivSC9b0Pg9CCKORF5JSCHyIOHGZUl
         uMNaNftGcXt+Qkid/gXzMdeVORuFNyZc3lWGZWxoETlp5UtJMp083JgOj3mLP9qacH+M
         gDE8YxWnDxKhMO+17Z/E3W8DvRVC5UZKo/lOxun38zhgLxFI0OUDxsihtSvaAR31P6b9
         qeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710180; x=1709314980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u1a+mGhIFV5S9yOIM/mTwkpKXjnQFwrZ+3KlU4LOk/M=;
        b=c7sXCBL1drBu96eKrW6rTJrcmL2W1GVVtJiJ8YLfEx3okLwzk35AXiFFvoDB2H2NUK
         Gpa1W+xWpvMkRfi4zlhDWtikdEuSLRck9nKYy0Z6oDs4HkFbhScb5x4xv/KdB9rUhWhr
         +URRDejc037qsUhkJk79DnDgELY+LhkHgDKzXkPxXf+eyaZAc5jK8bgOHoN7f1AYMSG/
         +PXOxmZgOT3EWQAhLXAJIhnZ8NL0tXeC6ZWYFeGS2HSKPbW9dXGS9MB2DNuc4L8Quxv9
         /1N/dyP20IFPmOfcbk4DCnxecA4oVzLIYO/1ydXtDA2af3l6+G5tM92aQy4Mwc6G+L0p
         kP3w==
X-Forwarded-Encrypted: i=1; AJvYcCWBLZw9JvwItYlOsANNRqlzt/kTPmp/LBz5imhV2BAAYHaIvbyWCaAOECF7C2ZUs5TZn7uUivMxdBNfHN1NsHauzemh4qUli1SPTd+CUcB74fhIqGZbmnw66NDQie818ka4vKxUziALW33JA+ws/+O5StRPrbe8VB+qXPbR91B8CqMd2/YoxCi+GdAe/jhkKMrKxVRAmy+sS/B4WG0o6WI27w==
X-Gm-Message-State: AOJu0Yw7f7YwD004OghVWIyQrO8Stmgyg3n5v+eai4gSFeV9s7MRpJZ4
	IxeN2423iLPfje/VEihNSBuKPBi7YkQq+PpW0gbbYw/L2LJXzy4O
X-Google-Smtp-Source: AGHT+IGvxRx1x0iM8YFXd/Ou2m5jkMZ8OYrYEJf96MjvtDyIZQMs9edy6hMhNpE0gZvzjl3i4gWw1w==
X-Received: by 2002:a05:6870:f143:b0:21e:d808:5a2a with SMTP id l3-20020a056870f14300b0021ed8085a2amr594038oac.7.1708710180571;
        Fri, 23 Feb 2024 09:43:00 -0800 (PST)
Received: from localhost.localdomain (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id rb7-20020a056871618700b0021f6a2bd4b9sm1257803oab.3.2024.02.23.09.42.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Feb 2024 09:43:00 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: John@Groves.net,
	john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	dave.hansen@linux.intel.com,
	gregory.price@memverge.com,
	John Groves <john@groves.net>
Subject: [RFC PATCH 15/20] famfs: Add ioctl to file_operations
Date: Fri, 23 Feb 2024 11:41:59 -0600
Message-Id: <a5d0969403ca02af6593b6789a21b230b2436800.1708709155.git.john@groves.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <cover.1708709155.git.john@groves.net>
References: <cover.1708709155.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces the per-file ioctl function famfs_file_ioctl()
into struct file_operations, and introduces the famfs_file_init_dax()
function (which is called by famfs_file_ioct())

famfs_file_init_dax() associates a dax extent list with a file, making
it into a proper famfs file. It is called from the FAMFSIOC_MAP_CREATE
ioctl. Starting with an empty file (which is basically a ramfs file),
this turns the file into a DAX file backed by the specified extent list.

The other ioctls are:

FAMFSIOC_NOP - A convenient way for user space to verify it's a famfs file
FAMFSIOC_MAP_GET - Get the header of the metadata for a file
FAMFSIOC_MAP_GETEXT - Get the extents for a file

The latter two, together, are comparable to xfs_bmap. Our user space tools
use them primarly in testing.

Signed-off-by: John Groves <john@groves.net>
---
 fs/famfs/famfs_file.c | 226 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 226 insertions(+)

diff --git a/fs/famfs/famfs_file.c b/fs/famfs/famfs_file.c
index 5228e9de1e3b..fd42d5966982 100644
--- a/fs/famfs/famfs_file.c
+++ b/fs/famfs/famfs_file.c
@@ -19,6 +19,231 @@
 #include <uapi/linux/famfs_ioctl.h>
 #include "famfs_internal.h"
 
+/**
+ * famfs_map_meta_alloc() - Allocate famfs file metadata
+ * @mapp:       Pointer to an mcache_map_meta pointer
+ * @ext_count:  The number of extents needed
+ */
+static int
+famfs_meta_alloc(
+	struct famfs_file_meta  **metap,
+	size_t                    ext_count)
+{
+	struct famfs_file_meta *meta;
+	size_t                  metasz;
+
+	*metap = NULL;
+
+	metasz = sizeof(*meta) + sizeof(*(meta->tfs_extents)) * ext_count;
+
+	meta = kzalloc(metasz, GFP_KERNEL);
+	if (!meta)
+		return -ENOMEM;
+
+	meta->tfs_extent_ct = ext_count;
+	*metap = meta;
+
+	return 0;
+}
+
+static void
+famfs_meta_free(
+	struct famfs_file_meta *map)
+{
+	kfree(map);
+}
+
+/**
+ * famfs_file_init_dax() - FAMFSIOC_MAP_CREATE ioctl handler
+ * @file:
+ * @arg:        ptr to struct mcioc_map in user space
+ *
+ * Setup the dax mapping for a file. Files are created empty, and then function is called
+ * (by famfs_file_ioctl()) to setup the mapping and set the file size.
+ */
+static int
+famfs_file_init_dax(
+	struct file    *file,
+	void __user    *arg)
+{
+	struct famfs_extent    *tfs_extents = NULL;
+	struct famfs_file_meta *meta = NULL;
+	struct inode           *inode;
+	struct famfs_ioc_map    imap;
+	struct famfs_fs_info   *fsi;
+	struct super_block     *sb;
+	int    alignment_errs = 0;
+	size_t extent_total = 0;
+	size_t ext_count;
+	int    rc = 0;
+	int    i;
+
+	rc = copy_from_user(&imap, arg, sizeof(imap));
+	if (rc)
+		return -EFAULT;
+
+	ext_count = imap.ext_list_count;
+	if (ext_count < 1) {
+		rc = -ENOSPC;
+		goto errout;
+	}
+
+	if (ext_count > FAMFS_MAX_EXTENTS) {
+		rc = -E2BIG;
+		goto errout;
+	}
+
+	inode = file_inode(file);
+	if (!inode) {
+		rc = -EBADF;
+		goto errout;
+	}
+	sb  = inode->i_sb;
+	fsi = inode->i_sb->s_fs_info;
+
+	tfs_extents = &imap.ext_list[0];
+
+	rc = famfs_meta_alloc(&meta, ext_count);
+	if (rc)
+		goto errout;
+
+	meta->file_type = imap.file_type;
+	meta->file_size = imap.file_size;
+
+	/* Fill in the internal file metadata structure */
+	for (i = 0; i < imap.ext_list_count; i++) {
+		size_t len;
+		off_t  offset;
+
+		offset = imap.ext_list[i].offset;
+		len    = imap.ext_list[i].len;
+
+		extent_total += len;
+
+		if (WARN_ON(offset == 0 && meta->file_type != FAMFS_SUPERBLOCK)) {
+			rc = -EINVAL;
+			goto errout;
+		}
+
+		meta->tfs_extents[i].offset = offset;
+		meta->tfs_extents[i].len    = len;
+
+		/* All extent addresses/offsets must be 2MiB aligned,
+		 * and all but the last length must be a 2MiB multiple.
+		 */
+		if (!IS_ALIGNED(offset, PMD_SIZE)) {
+			pr_err("%s: error ext %d hpa %lx not aligned\n",
+			       __func__, i, offset);
+			alignment_errs++;
+		}
+		if (i < (imap.ext_list_count - 1) && !IS_ALIGNED(len, PMD_SIZE)) {
+			pr_err("%s: error ext %d length %ld not aligned\n",
+			       __func__, i, len);
+			alignment_errs++;
+		}
+	}
+
+	/*
+	 * File size can be <= ext list size, since extent sizes are constrained
+	 * to PMD multiples
+	 */
+	if (imap.file_size > extent_total) {
+		pr_err("%s: file size %lld larger than ext list size %lld\n",
+		       __func__, (u64)imap.file_size, (u64)extent_total);
+		rc = -EINVAL;
+		goto errout;
+	}
+
+	if (alignment_errs > 0) {
+		pr_err("%s: there were %d alignment errors in the extent list\n",
+		       __func__, alignment_errs);
+		rc = -EINVAL;
+		goto errout;
+	}
+
+	/* Publish the famfs metadata on inode->i_private */
+	inode_lock(inode);
+	if (inode->i_private) {
+		rc = -EEXIST; /* file already has famfs metadata */
+	} else {
+		inode->i_private = meta;
+		i_size_write(inode, imap.file_size);
+		inode->i_flags |= S_DAX;
+	}
+	inode_unlock(inode);
+
+ errout:
+	if (rc)
+		famfs_meta_free(meta);
+
+	return rc;
+}
+
+/**
+ * famfs_file_ioctl() -  top-level famfs file ioctl handler
+ * @file:
+ * @cmd:
+ * @arg:
+ */
+static
+long
+famfs_file_ioctl(
+	struct file    *file,
+	unsigned int    cmd,
+	unsigned long   arg)
+{
+	long rc;
+
+	switch (cmd) {
+	case FAMFSIOC_NOP:
+		rc = 0;
+		break;
+
+	case FAMFSIOC_MAP_CREATE:
+		rc = famfs_file_init_dax(file, (void *)arg);
+		break;
+
+	case FAMFSIOC_MAP_GET: {
+		struct inode *inode = file_inode(file);
+		struct famfs_file_meta *meta = inode->i_private;
+		struct famfs_ioc_map umeta;
+
+		memset(&umeta, 0, sizeof(umeta));
+
+		if (meta) {
+			/* TODO: do more to harmonize these structures */
+			umeta.extent_type    = meta->tfs_extent_type;
+			umeta.file_size      = i_size_read(inode);
+			umeta.ext_list_count = meta->tfs_extent_ct;
+
+			rc = copy_to_user((void __user *)arg, &umeta, sizeof(umeta));
+			if (rc)
+				pr_err("%s: copy_to_user returned %ld\n", __func__, rc);
+
+		} else {
+			rc = -EINVAL;
+		}
+	}
+		break;
+	case FAMFSIOC_MAP_GETEXT: {
+		struct inode *inode = file_inode(file);
+		struct famfs_file_meta *meta = inode->i_private;
+
+		if (meta)
+			rc = copy_to_user((void __user *)arg, meta->tfs_extents,
+					  meta->tfs_extent_ct * sizeof(struct famfs_extent));
+		else
+			rc = -EINVAL;
+	}
+		break;
+	default:
+		rc = -ENOTTY;
+		break;
+	}
+
+	return rc;
+}
+
 /*********************************************************************
  * file_operations
  */
@@ -143,6 +368,7 @@ const struct file_operations famfs_file_operations = {
 	/* Custom famfs operations */
 	.write_iter	   = famfs_dax_write_iter,
 	.read_iter	   = famfs_dax_read_iter,
+	.unlocked_ioctl    = famfs_file_ioctl,
 	.mmap		   = famfs_file_mmap,
 
 	/* Force PMD alignment for mmap */
-- 
2.43.0



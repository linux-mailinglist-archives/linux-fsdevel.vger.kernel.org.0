Return-Path: <linux-fsdevel+bounces-11720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1178856670
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 15:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C611C23893
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 14:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4574134734;
	Thu, 15 Feb 2024 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="dwDnURMs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48BB132C1B;
	Thu, 15 Feb 2024 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008405; cv=none; b=VivlC26EUb/Q8Mju9pZKP0fuPfMk10zsb29IiooepSlzOqu0ZSefGaL45sJDurgB1xmujghQRtc+SXJ4/gn7A7SGqAjaFn6zGBwgZ5r4JUBDIqyKZbuTYF6ER4DToHgvVOf2tftvZJRkV8To3AQqEJEsyy6g7WIIIytTrlEWGbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008405; c=relaxed/simple;
	bh=2UjvX1mPA15gxdiokNXtijzapjvmSFS/ZT8DpOJxoxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aRk5scEFD0Qg6i3yCv5BXlg13vig7vF4rUrbw0IPpAiLad9Xl52It28mcaqKCYGDc34o2bl97LRylAcSa4k84U9Tq07J3H4/Juor4cHPZUlQabdtTkjblEXlTwkIITKbGgpM6zrhxWWhTrZHKiMok2ipakRWB8Dm0CM0Mo5/ARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=dwDnURMs; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1708008401;
	bh=2UjvX1mPA15gxdiokNXtijzapjvmSFS/ZT8DpOJxoxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dwDnURMsq/o0lx0Luqzr1eCWXZ6boSyn/PfHtqDhE9di0Yaeh5hFvXFEVnscxnwfB
	 HdULKMvpUjxPrHcBrTSGCxUwc/6SKwFKs6LIT6fdL/3ftEXXPNiekWJr8nj/gR/q9c
	 QcJBv7vckhsKbvWsfM+JqX/J6Slwnjxs8oF1mRxEaLbXjTzM69QiXhCzPziHI7SjRZ
	 bfQ2k8dVK3JMDOxaloIr8P2vxfpEjYX+4JMzi/nhiXnedDHYNxMyX9plrBx81pB+lk
	 4J5KT5pg0LUHw7A5CJ4FjkzPPBOeznzJE4IHyW1ws0jLeHOWwAUQUPnQw3UWpBbAKv
	 XmDk4Tq5SBp/A==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TbHvP2F7YzZKl;
	Thu, 15 Feb 2024 09:46:41 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-xfs@vger.kernel.org,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-s390@vger.kernel.org,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v6 6/9] virtio: Treat alloc_dax() -EOPNOTSUPP failure as non-fatal
Date: Thu, 15 Feb 2024 09:46:30 -0500
Message-Id: <20240215144633.96437-7-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215144633.96437-1-mathieu.desnoyers@efficios.com>
References: <20240215144633.96437-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for checking whether the architecture has data cache
aliasing within alloc_dax(), modify the error handling of virtio
virtio_fs_setup_dax() to treat alloc_dax() -EOPNOTSUPP failure as
non-fatal.

Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arch@vger.kernel.org
Cc: linux-cxl@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-xfs@vger.kernel.org
Cc: dm-devel@lists.linux.dev
Cc: nvdimm@lists.linux.dev
---
 fs/fuse/virtio_fs.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 5f1be1da92ce..a28466c2da71 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -16,6 +16,7 @@
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/highmem.h>
+#include <linux/cleanup.h>
 #include <linux/uio.h>
 #include "fuse_i.h"
 
@@ -795,8 +796,11 @@ static void virtio_fs_cleanup_dax(void *data)
 	put_dax(dax_dev);
 }
 
+DEFINE_FREE(cleanup_dax, struct dax_dev *, if (!IS_ERR_OR_NULL(_T)) virtio_fs_cleanup_dax(_T))
+
 static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 {
+	struct dax_device *dax_dev __free(cleanup_dax) = NULL;
 	struct virtio_shm_region cache_reg;
 	struct dev_pagemap *pgmap;
 	bool have_cache;
@@ -804,6 +808,12 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 	if (!IS_ENABLED(CONFIG_FUSE_DAX))
 		return 0;
 
+	dax_dev = alloc_dax(fs, &virtio_fs_dax_ops);
+	if (IS_ERR(dax_dev)) {
+		int rc = PTR_ERR(dax_dev);
+		return rc == -EOPNOTSUPP ? 0 : rc;
+	}
+
 	/* Get cache region */
 	have_cache = virtio_get_shm_region(vdev, &cache_reg,
 					   (u8)VIRTIO_FS_SHMCAP_ID_CACHE);
@@ -849,10 +859,7 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 	dev_dbg(&vdev->dev, "%s: window kaddr 0x%px phys_addr 0x%llx len 0x%llx\n",
 		__func__, fs->window_kaddr, cache_reg.addr, cache_reg.len);
 
-	fs->dax_dev = alloc_dax(fs, &virtio_fs_dax_ops);
-	if (IS_ERR(fs->dax_dev))
-		return PTR_ERR(fs->dax_dev);
-
+	fs->dax_dev = no_free_ptr(dax_dev);
 	return devm_add_action_or_reset(&vdev->dev, virtio_fs_cleanup_dax,
 					fs->dax_dev);
 }
-- 
2.39.2



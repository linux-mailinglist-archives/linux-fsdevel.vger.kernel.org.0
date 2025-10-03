Return-Path: <linux-fsdevel+bounces-63374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC1BBB7102
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 15:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A5F424A95
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 13:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD0022157B;
	Fri,  3 Oct 2025 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGTYVhLS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC045200BBC
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498973; cv=none; b=qgJN7/oc0zq1nNjQ6FLpaBF9/9ujSVkyrlvnsWDZV4Zy0bN/89yXj/DIJMFayFwKS5tUoi52GiuhVBnsLPuqcD3eZbS435FgBn+/BoylRVzwChuvalV3sFzKBiYDQuyOeATddnvUPg3nWnBdqzqqyqIb/rL+1P0JukNiRXKrNxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498973; c=relaxed/simple;
	bh=S0luBEw+pKTOP77uJKNdnvA9x6sJBXpx1jNrhV7mDks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHEyL08XLtU+C72Km8YZcLDJ6hLwoxtvsVeWBmqb7IxsvaxrDwryr+/8VV1j54IRnC8du5Ol/JKhpYqavAv7gbVmuPUDVmLq6xtD7KiQSg3eVUkypFTHGlyYUO23RoOgn5ZoTcKu/g64vnn10QLqMdE6nIRX/XaNJYx9JvOM83I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGTYVhLS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759498971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=waUo9x0FBaqv0KZdVCsd+QvqF9lALbkUVPK8T4Gm5+Q=;
	b=YGTYVhLSsRy2Dr2voPHbsRBmGwlfZk7+T2ZrDimJH5NiFL4BwGPU15Xdgau+VzgS1F3njC
	tecUZxC12Uvi4bttyJgqH9pyvQ2zGyLBNmIXBRMEYEHwv9LjLHfxe5rVg3Ub+3EUDlkh1k
	cMyJM5EFk08PpM9bvIwgsEbifLtnLXk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-cZw-hyGiO0ShUs6Erifr8g-1; Fri,
 03 Oct 2025 09:42:45 -0400
X-MC-Unique: cZw-hyGiO0ShUs6Erifr8g-1
X-Mimecast-MFC-AGG-ID: cZw-hyGiO0ShUs6Erifr8g_1759498964
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F1CE19560AE;
	Fri,  3 Oct 2025 13:42:44 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B23819560B1;
	Fri,  3 Oct 2025 13:42:43 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org,
	brauner@kernel.org
Subject: [PATCH v5 7/7] xfs: error tag to force zeroing on debug kernels
Date: Fri,  3 Oct 2025 09:46:41 -0400
Message-ID: <20251003134642.604736-8-bfoster@redhat.com>
In-Reply-To: <20251003134642.604736-1-bfoster@redhat.com>
References: <20251003134642.604736-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

iomap_zero_range() has to cover various corner cases that are
difficult to test on production kernels because it is used in fairly
limited use cases. For example, it is currently only used by XFS and
mostly only in partial block zeroing cases.

While it's possible to test most of these functional cases, we can
provide more robust test coverage by co-opting fallocate zero range
to invoke zeroing of the entire range instead of the more efficient
block punch/allocate sequence. Add an errortag to occasionally
invoke forced zeroing.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_errortag.h |  6 ++++--
 fs/xfs/xfs_file.c            | 29 ++++++++++++++++++++++-------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_errortag.h b/fs/xfs/libxfs/xfs_errortag.h
index de840abc0bcd..57e47077c75a 100644
--- a/fs/xfs/libxfs/xfs_errortag.h
+++ b/fs/xfs/libxfs/xfs_errortag.h
@@ -73,7 +73,8 @@
 #define XFS_ERRTAG_WRITE_DELAY_MS			43
 #define XFS_ERRTAG_EXCHMAPS_FINISH_ONE			44
 #define XFS_ERRTAG_METAFILE_RESV_CRITICAL		45
-#define XFS_ERRTAG_MAX					46
+#define XFS_ERRTAG_FORCE_ZERO_RANGE			46
+#define XFS_ERRTAG_MAX					47
 
 /*
  * Random factors for above tags, 1 means always, 2 means 1/2 time, etc.
@@ -133,7 +134,8 @@ XFS_ERRTAG(ATTR_LEAF_TO_NODE,	attr_leaf_to_node,	1) \
 XFS_ERRTAG(WB_DELAY_MS,		wb_delay_ms,		3000) \
 XFS_ERRTAG(WRITE_DELAY_MS,	write_delay_ms,		3000) \
 XFS_ERRTAG(EXCHMAPS_FINISH_ONE,	exchmaps_finish_one,	1) \
-XFS_ERRTAG(METAFILE_RESV_CRITICAL, metafile_resv_crit,	4)
+XFS_ERRTAG(METAFILE_RESV_CRITICAL, metafile_resv_crit,	4) \
+XFS_ERRTAG(FORCE_ZERO_RANGE,	force_zero_range,	4)
 #endif /* XFS_ERRTAG */
 
 #endif /* __XFS_ERRORTAG_H_ */
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 2702fef2c90c..5b9864c8582e 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -27,6 +27,8 @@
 #include "xfs_file.h"
 #include "xfs_aops.h"
 #include "xfs_zone_alloc.h"
+#include "xfs_error.h"
+#include "xfs_errortag.h"
 
 #include <linux/dax.h>
 #include <linux/falloc.h>
@@ -1254,23 +1256,36 @@ xfs_falloc_zero_range(
 	struct xfs_zone_alloc_ctx *ac)
 {
 	struct inode		*inode = file_inode(file);
+	struct xfs_inode	*ip = XFS_I(inode);
 	unsigned int		blksize = i_blocksize(inode);
 	loff_t			new_size = 0;
 	int			error;
 
-	trace_xfs_zero_file_space(XFS_I(inode));
+	trace_xfs_zero_file_space(ip);
 
 	error = xfs_falloc_newsize(file, mode, offset, len, &new_size);
 	if (error)
 		return error;
 
-	error = xfs_free_file_space(XFS_I(inode), offset, len, ac);
-	if (error)
-		return error;
+	/*
+	 * Zero range implements a full zeroing mechanism but is only used in
+	 * limited situations. It is more efficient to allocate unwritten
+	 * extents than to perform zeroing here, so use an errortag to randomly
+	 * force zeroing on DEBUG kernels for added test coverage.
+	 */
+	if (XFS_TEST_ERROR(ip->i_mount,
+			   XFS_ERRTAG_FORCE_ZERO_RANGE)) {
+		error = xfs_zero_range(ip, offset, len, ac, NULL);
+	} else {
+		error = xfs_free_file_space(ip, offset, len, ac);
+		if (error)
+			return error;
 
-	len = round_up(offset + len, blksize) - round_down(offset, blksize);
-	offset = round_down(offset, blksize);
-	error = xfs_alloc_file_space(XFS_I(inode), offset, len);
+		len = round_up(offset + len, blksize) -
+			round_down(offset, blksize);
+		offset = round_down(offset, blksize);
+		error = xfs_alloc_file_space(ip, offset, len);
+	}
 	if (error)
 		return error;
 	return xfs_falloc_setsize(file, new_size);
-- 
2.51.0



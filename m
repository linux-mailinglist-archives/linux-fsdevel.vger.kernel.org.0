Return-Path: <linux-fsdevel+bounces-10809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3546784E81F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 19:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE48D1F2DCE6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 18:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A5C3612B;
	Thu,  8 Feb 2024 18:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="BHv82fq4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DAF28DA6;
	Thu,  8 Feb 2024 18:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418171; cv=none; b=mCH0TpSlR2b/YxkzZm8gDqfgYGhpMSLqVn5WQB945hgzj1x//GatZ7RlS8lFLrbTq0Qt9PQwoy/ECTTpc+vDc6Ay40KKWwPc6m0vYWSAfkmX93CTJJ2B3Is/r+831aptMmmdrHfWjoSjMOM9KJDBAnWYL+YhuXWkd78QrfQFKQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418171; c=relaxed/simple;
	bh=NdQ4OmFkV2+G2H8B4VkXTCxDeM+TIHeVIiPEQVlM7R8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dZmE4m25CT0W9UMGSw64YHJX/3T2qVIcCBlNeuWjiGhPGms3traG20FFh+PL0LQ+NxApw6iU2rpKyf2AGf9d5vL4CokvlXkhI7FUSMzjRUNZipf2LaWHf7Qm/bE2A5KeC2ZplE7ya/1HFHWJYP3I6PtjHRCAq/6l0qZKbxM8VJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=BHv82fq4; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1707418163;
	bh=NdQ4OmFkV2+G2H8B4VkXTCxDeM+TIHeVIiPEQVlM7R8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BHv82fq4hO859vusQup+/Ew3E/xkDIrfZ5htPvlriwUnHkvNeARgnnZMiSWHzApqW
	 mBUnp7NhYcFC4sHncmcbqwbZiLufbXuPZ1mmrcc2XRx2OacMg8w1iMcNtrBwOoQ7t8
	 tlegoMFq/Kcq54d6KDuhbA+a5CHjBM14TYr6oFPdFcRGkfXiGVluKpmPuYTt++FmPu
	 urOv+1cJgX+X7s/GbAlJpQacEjTwJqNEmsDVAUYaXnkKjRNrV7bXs2jN1Ij2VQhEwb
	 /6iWsYm8EPA5tPa8SlmPXLVR3oPElZBuasrhf6GDfTwyLf9CcfdtgsPjHjkxUKokLX
	 dtG+zbC42rI5A==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TW5cg1khXzY5L;
	Thu,  8 Feb 2024 13:49:23 -0500 (EST)
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
Subject: [PATCH v4 02/12] nvdimm/pmem: Treat alloc_dax() -EOPNOTSUPP failure as non-fatal
Date: Thu,  8 Feb 2024 13:49:03 -0500
Message-Id: <20240208184913.484340-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208184913.484340-1-mathieu.desnoyers@efficios.com>
References: <20240208184913.484340-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for checking whether the architecture has data cache
aliasing within alloc_dax(), modify the error handling of nvdimm/pmem
pmem_attach_disk() to treat alloc_dax() -EOPNOTSUPP failure as non-fatal.

For the transition, consider that alloc_dax() returning NULL is the
same as returning -EOPNOTSUPP.

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
 drivers/nvdimm/pmem.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 9fe358090720..f1d9f5c6dbac 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -558,19 +558,21 @@ static int pmem_attach_disk(struct device *dev,
 	disk->bb = &pmem->bb;
 
 	dax_dev = alloc_dax(pmem, &pmem_dax_ops);
-	if (IS_ERR(dax_dev)) {
-		rc = PTR_ERR(dax_dev);
-		goto out;
+	if (IS_ERR_OR_NULL(dax_dev)) {
+		rc = IS_ERR(dax_dev) ? PTR_ERR(dax_dev) : -EOPNOTSUPP;
+		if (rc != -EOPNOTSUPP)
+			goto out;
+	} else {
+		set_dax_nocache(dax_dev);
+		set_dax_nomc(dax_dev);
+		if (is_nvdimm_sync(nd_region))
+			set_dax_synchronous(dax_dev);
+		pmem->dax_dev = dax_dev;
+		rc = dax_add_host(dax_dev, disk);
+		if (rc)
+			goto out_cleanup_dax;
+		dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
 	}
-	set_dax_nocache(dax_dev);
-	set_dax_nomc(dax_dev);
-	if (is_nvdimm_sync(nd_region))
-		set_dax_synchronous(dax_dev);
-	pmem->dax_dev = dax_dev;
-	rc = dax_add_host(dax_dev, disk);
-	if (rc)
-		goto out_cleanup_dax;
-	dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
 	rc = device_add_disk(dev, disk, pmem_attribute_groups);
 	if (rc)
 		goto out_remove_host;
-- 
2.39.2



Return-Path: <linux-fsdevel+bounces-44553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE53EA6A495
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 12:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8BFC8A2CAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762DC21D585;
	Thu, 20 Mar 2025 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SJBSMDr2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B05521CA0E;
	Thu, 20 Mar 2025 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469223; cv=none; b=pE2w9GQCyF9xh+Tlrqxmgf6zNPgzLoblXDXcwhJmHgXLAf0hhgqaLViw3M7PEbFrNWacPDxT/+Q0M1qlPiwL5PW5LstiUhTFXE9N1qDEG5y0kkCzxNmqgFg8bJiOgghi0cj2oe0UrDvY+rT6u1RB0W7ybWzPtZ0lsLK2nRHQWz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469223; c=relaxed/simple;
	bh=b/TxHeN/8psah2+iBSvjRef+V7YYuh48cay+wJGU5KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOVhVfGLEN9F5kNCchwycPZ22Nrv/xaj0npjbA/g0NC4r6so15TyTUQN8XoqF5ELrWsIC4uRNM7YYPLS0I0R/bGTB3/HB0c9NMRN70cK389P4//CqwOSMMpp6Llt304QwW+2sdqO6uecXV6ZnngXNb+u5PWsDOPEf8Q6HyEiWZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SJBSMDr2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0HxLvE16YL9P1A4HpsuUtCMnn8D/Dk21qpZacVa2AGY=; b=SJBSMDr2fNGmqh34vxJMTMJuHp
	dWkXnftkBc2gTsvYvyS36H/68CqyPbqCTB9yz17Scl40ZICNG8S8NTByCjs8lF3rTHmv40RQ184Ro
	lUS85Y9mbtnzp0Rspl7SgIIPAK7onAV3aSw79P1+gCr8XelQOMFmQm0wNT/OAviZ83ycE4GvdiE+j
	YFvW0H/3/avPMWtoXsR64Fk1y3w3iroPORvHXXV5YGy3u/0LG7x4jWhyIA8xgAxLREnrNGb83JbyN
	4ygdycwkUG9H89wWa0z4ULeWpyAcyPAsabuRMiSFsMAHO0+fvWQ440SjFsqvLulRHo4Z3P9Gs1mY7
	LT2pWB2g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tvDqB-0000000BvGL-0uOZ;
	Thu, 20 Mar 2025 11:13:35 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: leon@kernel.org,
	hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	axboe@kernel.dk,
	joro@8bytes.org,
	brauner@kernel.org,
	hare@suse.de,
	willy@infradead.org,
	david@fromorbit.com,
	djwong@kernel.org
Cc: john.g.garry@oracle.com,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [RFC 2/4] blkdev: lift BLK_MAX_BLOCK_SIZE to page cache limit
Date: Thu, 20 Mar 2025 04:13:26 -0700
Message-ID: <20250320111328.2841690-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320111328.2841690-1-mcgrof@kernel.org>
References: <20250320111328.2841690-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

It's a brave new world. This is now part of the validation to get
to at least the page cache limit.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/blkdev.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1c0cf6af392c..9e1b3e7526d9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -26,6 +26,7 @@
 #include <linux/xarray.h>
 #include <linux/file.h>
 #include <linux/lockdep.h>
+#include <linux/pagemap.h>
 
 struct module;
 struct request_queue;
@@ -268,11 +269,7 @@ static inline dev_t disk_devt(struct gendisk *disk)
 	return MKDEV(disk->major, disk->first_minor);
 }
 
-/*
- * We should strive for 1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER)
- * however we constrain this to what we can validate and test.
- */
-#define BLK_MAX_BLOCK_SIZE      SZ_64K
+#define BLK_MAX_BLOCK_SIZE      1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER)
 
 /* blk_validate_limits() validates bsize, so drivers don't usually need to */
 static inline int blk_validate_block_size(unsigned long bsize)
-- 
2.47.2



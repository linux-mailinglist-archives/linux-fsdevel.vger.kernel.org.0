Return-Path: <linux-fsdevel+bounces-37688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C519F5C90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 03:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 235CA7A3E91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 02:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99C235976;
	Wed, 18 Dec 2024 02:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ARm2XXrf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECFB35949;
	Wed, 18 Dec 2024 02:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734487343; cv=none; b=TWvZyuvMRkzBCm9DA4fDpOCgNBBgWHFirybLfTCO3PimziYmsl3iLeuw3oHdaYk++ov9gyNZQyhitWjWz6jhQH/mxsLfMpawDBsQNYlbAdBiy9JQFyq+GgyuBJdCNxD6xhavK0khkOQr0sqqYaGDv1nK7jNeWjGQYVkSrvGU2+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734487343; c=relaxed/simple;
	bh=NyQ/VTAQc2/yqzb8g7x3GiUrXi2adsGgvZKx6pYBrJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZbet27/tQ2aXHobajWlIYIdrCk+Glg7Ko++ofS1ryg8zVPVGkx6dnAtVWPJBqHC1Bgiuk/VlI2fp+bPYJbtuNTbR3XyKnM3zR4AHEdhtRu5PR8OxgN0Qf0lt9ajOMe+P9TQTbhrcj7q/inUHkhjtMwzYf6lr3eMS6R9mJtNHew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ARm2XXrf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=WCOIziiQc3yXhNuboxlTSddFpns8L7WWTqCYfZybbD0=; b=ARm2XXrfPngFRZVJvDGkyfwEt0
	LmQCWyMcRxVuhEoAIPM+OXXOFDvt+ACslBENjP3KCFzVur5eYWReWCPj3h467YpcV4mtzCBPAyFHm
	Gv4kxJdCrLJMMZD3mA/hr1gL/l1o2LDorwVGVfit4yBfdtNVmPyoL2Dhful4neUgJWRbJSnx/z78P
	O7uOS6+Iwr4Adb9Cz7d+mYv7zZICWc4DsfBVQG0XBL8NhFT3vTalixvi3YiSQRgQqE0FQstM5se5g
	cCf2adVGPLWAMagHdDEQ8CKmsF38gGHpaQkUR6l+9ZdaspazJRRbr4Af281BjjVh0ik5tPize8Kv6
	8uVYBdZQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNjO9-0000000FLOH-1IBp;
	Wed, 18 Dec 2024 02:02:13 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk,
	hch@lst.de,
	hare@suse.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	willy@infradead.org,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org
Cc: john.g.garry@oracle.com,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [PATCH 1/2] block/bdev: use helper for max block size check
Date: Tue, 17 Dec 2024 18:02:11 -0800
Message-ID: <20241218020212.3657139-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218020212.3657139-1-mcgrof@kernel.org>
References: <20241218020212.3657139-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

We already have a helper for checking the limits on the block size
both low and high, just use that.

No functional changes.

Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/bdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 738e3c8457e7..9d73a8fbf7f9 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -155,8 +155,7 @@ int set_blocksize(struct file *file, int size)
 	struct inode *inode = file->f_mapping->host;
 	struct block_device *bdev = I_BDEV(inode);
 
-	/* Size must be a power of two, and between 512 and PAGE_SIZE */
-	if (size > PAGE_SIZE || size < 512 || !is_power_of_2(size))
+	if (blk_validate_block_size(size))
 		return -EINVAL;
 
 	/* Size cannot be smaller than the size supported by the device */
-- 
2.43.0



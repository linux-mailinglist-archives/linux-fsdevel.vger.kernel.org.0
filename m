Return-Path: <linux-fsdevel+bounces-42315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE402A402D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 23:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095B93B1235
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 22:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD36255E31;
	Fri, 21 Feb 2025 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XDnfMo1V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D752045BC;
	Fri, 21 Feb 2025 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177512; cv=none; b=fVPBBdoXiV5xKiP7irXQrQAKUK3M7BYDnTbce725evYCATEkV0e9988RKXdj3I9yR0VbTdYtZbHnCYyR+COn8VJHMkFQjRyWYnOhDhMVRRr6/UPawgqOCeuA1qBaBa0LqezaXTaZQ6fujolXYEN4KREoAMtsg5KkKk0Q1cpiI8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177512; c=relaxed/simple;
	bh=xlVW+nmNUU3Mx7kjCHAf4g3c3X46e1nkPyeVOwrtLYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZX6XcA+JiMa3sq12HYmgzzBfx+DWNAOtyKUTDJJik7IZLEYpwKw+u0B8/+d19cizwVCDPUk/u8jDssI1/fZt3B+v0w6pJ58kUe+kkUEQvrbKSJMkZ5jkBfvudenyJMnWOjzuDTspPSKU9btDAGu4bk6vb9YwmkQu7yBO4A7KIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XDnfMo1V; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3/8moX70+aSKaT13TlyhV/XaFEGoqVjVhuDSY9DkRzU=; b=XDnfMo1Vwdj4jcr8Jvs3oJ0PuK
	s24IOa7rDwYGgQAUm0OWzKX5z9w431aQJmyM6li85UjqomVbjd1UDPxOLb3Q3vMkcBcuY+tjeqIp5
	y/bPWO+YhAC2JyoWReaELre7hSPE3h7sHi0ob8piVq4oyfWNdonXcTLygztsa6Vmbiida6D19SJJU
	IwYVaxi6yPulxaGEpq7RVAlyotRmFlbt7LSWQ0Ls7FRpICGq4NDKIaqeKvuY48/PVFA6eywoIRFMI
	LARMsRH1stIV3oiPSLhqH7+ETYc4NRQORSuf1bnRP3EGwEgt71j+zSlHDJPCJtNGAjjF5BQih7HFK
	XcE6Tzdg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlbf7-000000073DD-3rzt;
	Fri, 21 Feb 2025 22:38:25 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: brauner@kernel.org,
	akpm@linux-foundation.org,
	hare@suse.de,
	willy@infradead.org,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org,
	kbusch@kernel.org
Cc: john.g.garry@oracle.com,
	hch@lst.de,
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
Subject: [PATCH v3 6/8] block/bdev: enable large folio support for large logical block sizes
Date: Fri, 21 Feb 2025 14:38:21 -0800
Message-ID: <20250221223823.1680616-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221223823.1680616-1-mcgrof@kernel.org>
References: <20250221223823.1680616-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

From: Hannes Reinecke <hare@suse.de>

Call mapping_set_folio_min_order() when modifying the logical block
size to ensure folios are allocated with the correct size.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/bdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index 9d73a8fbf7f9..8aadf1f23cb4 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -148,6 +148,8 @@ static void set_init_blocksize(struct block_device *bdev)
 		bsize <<= 1;
 	}
 	BD_INODE(bdev)->i_blkbits = blksize_bits(bsize);
+	mapping_set_folio_min_order(BD_INODE(bdev)->i_mapping,
+				    get_order(bsize));
 }
 
 int set_blocksize(struct file *file, int size)
@@ -169,6 +171,7 @@ int set_blocksize(struct file *file, int size)
 	if (inode->i_blkbits != blksize_bits(size)) {
 		sync_blockdev(bdev);
 		inode->i_blkbits = blksize_bits(size);
+		mapping_set_folio_min_order(inode->i_mapping, get_order(size));
 		kill_bdev(bdev);
 	}
 	return 0;
-- 
2.47.2



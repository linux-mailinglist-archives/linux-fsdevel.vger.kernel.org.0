Return-Path: <linux-fsdevel+bounces-37406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A399F1C45
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 04:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0F5188D398
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 03:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013537E105;
	Sat, 14 Dec 2024 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rBgMS/ly"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93F8182BC;
	Sat, 14 Dec 2024 03:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734145860; cv=none; b=el2yTXyltcTWCFKcXNNbPBGpjRbDQP4Tk7iJfBpctM6xFTVAM/6Mwzy9i/UWR9ASCI8LzkvmD8+ncTyNSxTY390uEW4o8WSf5F205VdG5MUCWVNHe0tatJh7BKq6PcufWhoLzO01CKrNTjdcYv+tRJggyZHfgY7YKVAx3ce4xwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734145860; c=relaxed/simple;
	bh=SsLwRYjDnZhLjFEWH6rmXr0rjN+JdjyyGgFfERa/yfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BX727nW4lRvlH3dp3v2w3lH8MBl7IN0vGPuqblgIWVfENEbMFDUaTjPGfM0ioZSjv/xVRWa8lW1HocpJtN3igZAxayumlrJu9Zp+tLZ/Su9Z/6WENZLg1WuLTJsPbeynk2lmdftJAS5nY1cBjoTCMhsKZeCXRzMELuvrnAvV4r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rBgMS/ly; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rV5AoYJPlny/7wnGoBOtLs3pAmaEJ9e3y3MRINCsK0A=; b=rBgMS/lyjy3Ti+VMrwe1JNxiA8
	eR0POwBQ7F9I7u0BreYHGzLgGHYo5au1bZKC4A+0HUDXIRpEPtKNdKPl/hg3NYWSWTTwsbxN1CFmk
	u4en09SHB4VOE44Qb3533cdPHpRkd9NUC5ozc6o1GJdedziqFC57uH9xNYHFqkHE3dHjwfOGvIIeK
	7nV7Nug+EBDp5bnSB4J2mRCG6dhkXiUkNic0zADTIySpUwYdJqcqKKaesr25P1UGq21cts4hwc9ib
	mtMiz46VjuC3+q9iEz0GBO8iSLgOZcuy4HAHH1DYHuDv32yDA8/NKuGE2fj3/LwlDnmWlwrJ8d5SA
	fNZXHcCg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tMIYN-00000005c3n-4A6d;
	Sat, 14 Dec 2024 03:10:51 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: willy@infradead.org,
	hch@lst.de,
	hare@suse.de,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org
Cc: john.g.garry@oracle.com,
	ritesh.list@gmail.com,
	kbusch@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [RFC v2 08/11] block/bdev: enable large folio support for large logical block sizes
Date: Fri, 13 Dec 2024 19:10:46 -0800
Message-ID: <20241214031050.1337920-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241214031050.1337920-1-mcgrof@kernel.org>
References: <20241214031050.1337920-1-mcgrof@kernel.org>
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

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/bdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index 738e3c8457e7..167d82b46781 100644
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
@@ -170,6 +172,7 @@ int set_blocksize(struct file *file, int size)
 	if (inode->i_blkbits != blksize_bits(size)) {
 		sync_blockdev(bdev);
 		inode->i_blkbits = blksize_bits(size);
+		mapping_set_folio_min_order(inode->i_mapping, get_order(size));
 		kill_bdev(bdev);
 	}
 	return 0;
-- 
2.43.0



Return-Path: <linux-fsdevel+bounces-64821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331F9BF4E13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 09:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34483AEC42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 07:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F6127F01B;
	Tue, 21 Oct 2025 07:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="ajEmScFX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.132.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165D5354AC9;
	Tue, 21 Oct 2025 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.178.132.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030731; cv=none; b=dIAw8gwaG4ym/vHL4uaSDexlUtOAjYlq+zq5tcwSehVAD9lGwCLPJGUTyxe6z9dmu4i7hiVDG0/GZA64NP0KXphypfyCxI6JumVIOjbyvxdgPI2CP8GUvC1cF/NH7KeyOINm8qAfVHJArn9umxNGfwthvIogC5NQV+3qg2utYa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030731; c=relaxed/simple;
	bh=qBXMD7foKCLM8tG99NVLnc1+8+/Ddg/uvu+Ww3sKHXE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/GGXAMB1QjJe56WB5XBJi0OnZ54huh2RwbbSbsrhwNq1igax6HXVO2cG+OmFKRjrVjDpdgSX+i4NIW3pvADItrOu/ux3Om05Jt4VjNVZbuk6G3pA4h35om9hfwXkThsRFlvVtykbGnMsHTYVnsqdCmBTFORR+mIaM0+E0HlhDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=ajEmScFX; arc=none smtp.client-ip=63.178.132.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1761030729; x=1792566729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xox3qTc8hYU6L3c6JXOuETVCy0yWRIpRqh99YwnzkOo=;
  b=ajEmScFX9+HXP8f9AuavN6luknZYMPv2RTENAhOHWSP6AyDzJwAZ8wxY
   slyWfeSyByw1EjRmuHQVCzJdvq5yiJijjVrCRzFMNFOrLdj8iOuKRP4V+
   8f2LUDJ6p+F0c3HVbTChbv8SSJSxjliNEmcs74zqcPWkei/9EvQ9/+cAE
   MMh8TFeZxoWIbGGtqJuaqJfkjsyXaTfZSUv5JfiCIesRarywCGKzR9Djw
   DPnwqpDj1GuRMKbU2yXzpOpohSzONvR3z6yshg6QTV+Fv2wNQwXYN084C
   lZDtEzAWDjNO33p6bwbjXhkQ4sRZr/XmAvt3b0bIVIH+/gdQ0Ght7poIU
   A==;
X-CSE-ConnectionGUID: 6VGIvb/dQ++kJKWLFnmwYA==
X-CSE-MsgGUID: OwKsQXoZQsikLSKYYlhXrA==
X-IronPort-AV: E=Sophos;i="6.19,244,1754956800"; 
   d="scan'208";a="3828837"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 07:11:57 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:11098]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.17.8:2525] with esmtp (Farcaster)
 id 6cec1b60-3232-473d-9f64-4d0e631f5a13; Tue, 21 Oct 2025 07:11:57 +0000 (UTC)
X-Farcaster-Flow-ID: 6cec1b60-3232-473d-9f64-4d0e631f5a13
Received: from EX19D013EUB004.ant.amazon.com (10.252.51.92) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 21 Oct 2025 07:11:57 +0000
Received: from dev-dsk-mngyadam-1c-cb3f7548.eu-west-1.amazon.com
 (10.253.107.175) by EX19D013EUB004.ant.amazon.com (10.252.51.92) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Tue, 21 Oct 2025
 07:11:48 +0000
From: Mahmoud Adam <mngyadam@amazon.de>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <nagy@khwaternagy.com>, Christoph Hellwig
	<hch@lst.de>, Johannes Thumshirn <johannes.thumshirn@wdc.com>, "Christian
 Brauner" <brauner@kernel.org>, Hannes Reinecke <hare@suse.de>, "Luis
 Chamberlain" <mcgrof@kernel.org>, Jens Axboe <axboe@kernel.dk>, Xiubo Li
	<xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Jeff Layton
	<jlayton@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Theodore Ts'o
	<tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim
	<jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, Christoph Hellwig
	<hch@infradead.org>, "Darrick J. Wong" <djwong@kernel.org>, Trond Myklebust
	<trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, "Ryusuke
 Konishi" <konishi.ryusuke@gmail.com>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "Damien Le
 Moal" <dlemoal@kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-xfs@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>, <linux-nilfs@vger.kernel.org>,
	<linux-mm@kvack.org>
Subject: [PATCH 6.1 6/8] block: open code __generic_file_write_iter for blkdev writes
Date: Tue, 21 Oct 2025 09:03:41 +0200
Message-ID: <20251021070353.96705-8-mngyadam@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021070353.96705-2-mngyadam@amazon.de>
References: <20251021070353.96705-2-mngyadam@amazon.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D013EUB004.ant.amazon.com (10.252.51.92)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Christoph Hellwig <hch@lst.de>

commit 727cfe976758b79f8d2f8051c75a5ccb14539a56 upstream.

Open code __generic_file_write_iter to remove the indirect call into
->direct_IO and to prepare using the iomap based write code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Link: https://lore.kernel.org/r/20230801172201.1923299-4-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[fix contextual changes]
Signed-off-by: Mahmoud Adam <mngyadam@amazon.de>
---
 block/fops.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index b02fe200c3ecd0..fb7a57ed42d995 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -515,6 +515,30 @@ static int blkdev_close(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static ssize_t
+blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
+{
+	size_t count = iov_iter_count(from);
+	ssize_t written;
+
+	written = kiocb_invalidate_pages(iocb, count);
+	if (written) {
+		if (written == -EBUSY)
+			return 0;
+		return written;
+	}
+
+	written = blkdev_direct_IO(iocb, from);
+	if (written > 0) {
+		kiocb_invalidate_post_direct_write(iocb, count);
+		iocb->ki_pos += written;
+		count -= written;
+	}
+	if (written != -EIOCBQUEUED)
+		iov_iter_revert(from, count - iov_iter_count(from));
+	return written;
+}
+
 /*
  * Write data to the block device.  Only intended for the block device itself
  * and the raw driver which basically is a fake block device.
@@ -524,7 +548,8 @@ static int blkdev_close(struct inode *inode, struct file *filp)
  */
 static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct block_device *bdev = iocb->ki_filp->private_data;
+	struct file *file = iocb->ki_filp;
+	struct block_device *bdev = file->private_data;
 	struct inode *bd_inode = bdev->bd_inode;
 	loff_t size = bdev_nr_bytes(bdev);
 	struct blk_plug plug;
@@ -553,7 +578,23 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	blk_start_plug(&plug);
-	ret = __generic_file_write_iter(iocb, from);
+	ret = file_remove_privs(file);
+	if (ret)
+		return ret;
+
+	ret = file_update_time(file);
+	if (ret)
+		return ret;
+
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		ret = blkdev_direct_write(iocb, from);
+		if (ret >= 0 && iov_iter_count(from))
+			ret = direct_write_fallback(iocb, from, ret,
+					generic_perform_write(iocb, from));
+	} else {
+		ret = generic_perform_write(iocb, from);
+	}
+
 	if (ret > 0)
 		ret = generic_write_sync(iocb, ret);
 	iov_iter_reexpand(from, iov_iter_count(from) + shorted);
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597



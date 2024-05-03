Return-Path: <linux-fsdevel+bounces-18555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 564ED8BA464
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 02:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E615B23206
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 00:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEFB1367;
	Fri,  3 May 2024 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cxaZe8Cr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900791FDA;
	Fri,  3 May 2024 00:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714695085; cv=none; b=I8bELIMmPv3NXq531fupUvdaCNdlIJUF5eazlCpDgEbBqI1BYpUe/x7kJrqn+ijdK870GLYACsmYnYuAKjS7a9EV4a5GR24o0pQ25Jp+JOKW/sVfAY2msGBHUGt2Xcp8YoMKPQZa2/N0/iHe3KJINtooX2vULiz924m2LdJb7qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714695085; c=relaxed/simple;
	bh=ZY1QxZtFxBjgqUQAN0MaQZuTJkkcwvtB7mVOVYYdnFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8PxZSTee4R76CvRn6wfEb7aN0i3MXzEYV7drbyYoHHAUc0jCK2Ck1sY6XUI3tELal2Yg9/egBi8K2kVlUYNQfxNaecDZO0ccR5c5iU75wheDghTu60O1W6clrvRljAMWrRkdaNNBaf02wD1l+lXmm1UhYTDzLQAI4iZrO0cZhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cxaZe8Cr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0SS3sTlKK63HL5RcSUatqvwGfSVEL8pnEtH16W529JQ=; b=cxaZe8Cr4qs2myGPzGFUFUVWqZ
	BRKydz0L060gD+SyJY4gBg2ynwI8EFO5wFzksmb0XwG+zsOZfBul/GGp7QANFuJyTX0q9TS8ueU92
	wY3Qf/bdaOcR4CYtxUuEA2zw1Orun3m66ZpWY6rRcc6Q1RzVMRg+qWaBRkuW1thXSq+cQX8S2RNdu
	e7u4o5T7mDff48NBhzSp2M4yUsV/9E/2zm+w9RcMoSAZsaTcjPSpTOvRa8MxjHlI6YdFwZ8tQ4Kvt
	U3iItwQdcfDLKEg9B2Vaab0SFVWdp65bi1PYSr0dBuJ5mvi+g2DwnmTE3DJhEkxHOjEbe8GHJrb+E
	Wv2NDKVQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2gWI-009tTS-39;
	Fri, 03 May 2024 00:11:23 +0000
Date: Fri, 3 May 2024 01:11:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
	linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 8/8] bdev: move ->bd_make_it_fail to ->__bd_flags
Message-ID: <20240503001122.GH2357260@ZenIV>
References: <20240428051232.GU2118490@ZenIV>
 <20240429052315.GB32688@lst.de>
 <20240429073107.GZ2118490@ZenIV>
 <20240429170209.GA2118490@ZenIV>
 <20240429181300.GB2118490@ZenIV>
 <20240429183041.GC2118490@ZenIV>
 <20240503000647.GQ2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503000647.GQ2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 block/blk-core.c          |  3 ++-
 block/genhd.c             | 12 ++++++++----
 include/linux/blk_types.h |  6 +++---
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1be49be9fac4..1076336dd620 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -494,7 +494,8 @@ __setup("fail_make_request=", setup_fail_make_request);
 
 bool should_fail_request(struct block_device *part, unsigned int bytes)
 {
-	return part->bd_make_it_fail && should_fail(&fail_make_request, bytes);
+	return bdev_test_flag(part, BD_MAKE_IT_FAIL) &&
+	       should_fail(&fail_make_request, bytes);
 }
 
 static int __init fail_make_request_debugfs(void)
diff --git a/block/genhd.c b/block/genhd.c
index 19cd1a31fa80..0cce461952f6 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1066,7 +1066,8 @@ static DEVICE_ATTR(diskseq, 0444, diskseq_show, NULL);
 ssize_t part_fail_show(struct device *dev,
 		       struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", dev_to_bdev(dev)->bd_make_it_fail);
+	return sprintf(buf, "%d\n",
+		       bdev_test_flag(dev_to_bdev(dev), BD_MAKE_IT_FAIL));
 }
 
 ssize_t part_fail_store(struct device *dev,
@@ -1075,9 +1076,12 @@ ssize_t part_fail_store(struct device *dev,
 {
 	int i;
 
-	if (count > 0 && sscanf(buf, "%d", &i) > 0)
-		dev_to_bdev(dev)->bd_make_it_fail = i;
-
+	if (count > 0 && sscanf(buf, "%d", &i) > 0) {
+		if (i)
+			bdev_set_flag(dev_to_bdev(dev), BD_MAKE_IT_FAIL);
+		else
+			bdev_clear_flag(dev_to_bdev(dev), BD_MAKE_IT_FAIL);
+	}
 	return count;
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 4e0c8785090c..5bb7805927ac 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -51,6 +51,9 @@ struct block_device {
 #define BD_WRITE_HOLDER		(1u<<9)
 #define BD_HAS_SUBMIT_BIO	(1u<<10)
 #define BD_RO_WARNED		(1u<<11)
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+#define BD_MAKE_IT_FAIL		(1u<<12)
+#endif
 	dev_t			bd_dev;
 	struct inode		*bd_inode;	/* will die */
 
@@ -67,9 +70,6 @@ struct block_device {
 	struct mutex		bd_fsfreeze_mutex; /* serialize freeze/thaw */
 
 	struct partition_meta_info *bd_meta_info;
-#ifdef CONFIG_FAIL_MAKE_REQUEST
-	bool			bd_make_it_fail;
-#endif
 	int			bd_writers;
 	/*
 	 * keep this out-of-line as it's both big and not needed in the fast
-- 
2.39.2



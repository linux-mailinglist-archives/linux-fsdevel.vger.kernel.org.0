Return-Path: <linux-fsdevel+bounces-18005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6F78B49D1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 07:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB22282047
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 05:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC88053BE;
	Sun, 28 Apr 2024 05:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="I+S0MGPk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C692C320C;
	Sun, 28 Apr 2024 05:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714281669; cv=none; b=Xb8qR4liojazXd15wvDEv2kSSqdj9vFtZbRQG645TP9IYF7PD5VWNupZ3vJY4ogomfX0amsPlx395qK7bkf8GQhovouEeHeWvMjKhs8YrSPerchDAIFZaBd44pFeOx6xXw7ZU6UDYSbc1h8NSer4DXw1NG44JH3Uec7JUhadInQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714281669; c=relaxed/simple;
	bh=8ZcnS8b0PNCfVGXzTKij4oQxakJ6aMqGuUG1wToqsrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfosN0EBMChilFn1ZQUjXw/OdDyX44TQ6cCALm5nzVHipS6c2/vL+Ye0kjSGwe2g9+hvWprQOM45tc+R5HHgoJZ5xqB7sGStzMUSxlPGk2iT8Ygr7CsWkm8VqKVeOdpRbx2h8gpQ57qBV5X+RzLuZr4UahqtGjhee8DZo5CpTEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=I+S0MGPk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WJhjreZ4/O1HDJ0IIl3pZkSWylZry442LChV7Q1j9Qw=; b=I+S0MGPkV7JU2xQhB5RVq/zz53
	QdkOy2mQV73hfCCA44UhZVbqqvFoHnxZMX+sR8OxFLI+2Mmac6sOgnzryxVznSqCoTytLKURa5IDi
	RBRDWN5/Wen8OAdetOfW4HObyXY0YIYaiJ3qUOuIQ623bij5hKgrR72XZ5SS1xw6/ZsfjVpk8Em3W
	By5gcWuXd+tqjQ4WOCQEy8FIgUCq4Is3zoD/iFjZp4fvWoCdD3CHbJWmsP9apZOWfz3Bky2k6hzPT
	eZodscQER1PHxpaCey6YG4IjjoWMnWbbUQTRaoMzo/uqBVkTYUMHbUS+phywAP894uIy9CQC6wWg5
	np19HTwA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s0wyI-006VT5-0U;
	Sun, 28 Apr 2024 05:21:06 +0000
Date: Sun, 28 Apr 2024 06:21:06 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 8/8] bdev: move ->bd_make_it_fail to ->__bd_flags
Message-ID: <20240428052106.GH1549798@ZenIV>
References: <20240428051232.GU2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428051232.GU2118490@ZenIV>
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
index 59de93913cc4..98e1c2d28d60 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -62,9 +62,6 @@ struct block_device {
 	struct mutex		bd_fsfreeze_mutex; /* serialize freeze/thaw */
 
 	struct partition_meta_info *bd_meta_info;
-#ifdef CONFIG_FAIL_MAKE_REQUEST
-	bool			bd_make_it_fail;
-#endif
 	int			bd_writers;
 	/*
 	 * keep this out-of-line as it's both big and not needed in the fast
@@ -87,6 +84,9 @@ enum {
 	BD_WRITE_HOLDER,
 	BD_HAS_SUBMIT_BIO,
 	BD_RO_WARNED,
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+	BD_MAKE_IT_FAIL,
+#endif
 };
 
 /*
-- 
2.39.2



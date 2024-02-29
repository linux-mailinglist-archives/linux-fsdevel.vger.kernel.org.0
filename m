Return-Path: <linux-fsdevel+bounces-13187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5844F86C85F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 12:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCFB1C20443
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 11:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129E27D3E5;
	Thu, 29 Feb 2024 11:45:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7520C7CF17;
	Thu, 29 Feb 2024 11:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207137; cv=none; b=pX4pbyvOOHBwZ4ugfJOY3sz9A+aN6c9U+TxlsvH+HvmJ4RXxqXsPBLJW06jovlFOul1HPmDicMDoRJp4TGZLQkgBhTGx+GjvRqkDL+AjShDc3p/isMK6K1o3r1nNFJl49ifELjYkTmP1pL3jmPi3pA8V2pWu1YuMRgNAhEwTTWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207137; c=relaxed/simple;
	bh=Kq0TK4bY8t/Mvm9W8afZQDPlQRDXrI1jGg+Gg966bnE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNM2OKu2aGWYN1OFmvrLuxpKx/nQpMjIZboz3/Dyp8pLEsq4y/dEzn4rYQrbj4d09WBmjgSa/XQkKQ6ZssDMsExrpJfP2a0sAoXH8AeNlZG51C75OE6hqlDPEdj7utdfD8q442vAWYBIaUGq/MPaDN0U4piVbbE+WglERRqpOfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TlqB83zg7z1xpTm;
	Thu, 29 Feb 2024 19:44:00 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id CB0B71402CE;
	Thu, 29 Feb 2024 19:45:31 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Feb
 2024 19:45:30 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <brauner@kernel.org>, <david@fromorbit.com>, <djwong@kernel.org>,
	<jack@suse.cz>, <tytso@mit.edu>
CC: <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
	<yi.zhang@huawei.com>
Subject: [PATCH RFC 1/2] iomap: Add a IOMAP_DIO_MAY_INLINE_COMP flag
Date: Thu, 29 Feb 2024 19:38:48 +0800
Message-ID: <20240229113849.2222577-2-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229113849.2222577-1-chengzhihao1@huawei.com>
References: <20240229113849.2222577-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)

It will be more efficient to execute quick endio process(eg. non-sync
overwriting case) under irq process rather than starting a worker to
do it.
Add a flag to control DIO to be finished inline(under irq context), which
can be used for non-sync overwriting case.
Besides, skip invalidating pages if DIO is finished inline, which will
keep the same logic with dio_bio_end_aio in non-sync overwriting case.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/iomap/direct-io.c  | 10 ++++++++--
 include/linux/iomap.h |  6 ++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index bcd3f8cf5ea4..221715b38ce2 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -110,7 +110,8 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 	 * ->end_io() when necessary, otherwise a racing buffer read would cache
 	 * zeros from unwritten extents.
 	 */
-	if (!dio->error && dio->size && (dio->flags & IOMAP_DIO_WRITE))
+	if (!dio->error && dio->size && (dio->flags & IOMAP_DIO_WRITE) &&
+	    !(dio->flags & IOMAP_DIO_INLINE_COMP))
 		kiocb_invalidate_post_direct_write(iocb, dio->size);
 
 	inode_dio_end(file_inode(iocb->ki_filp));
@@ -122,8 +123,10 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 		 * If this is a DSYNC write, make sure we push it to stable
 		 * storage now that we've written data.
 		 */
-		if (dio->flags & IOMAP_DIO_NEED_SYNC)
+		if (dio->flags & IOMAP_DIO_NEED_SYNC) {
+			WARN_ON_ONCE(dio->flags & IOMAP_DIO_INLINE_COMP);
 			ret = generic_write_sync(iocb, ret);
+		}
 		if (ret > 0)
 			ret += dio->done_before;
 	}
@@ -628,6 +631,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			*/
 			if (!(iocb->ki_flags & IOCB_SYNC))
 				dio->flags |= IOMAP_DIO_WRITE_THROUGH;
+		} else if (dio_flags & IOMAP_DIO_MAY_INLINE_COMP) {
+			/* writes could complete inline */
+			dio->flags |= IOMAP_DIO_INLINE_COMP;
 		}
 
 		/*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 96dd0acbba44..f292b10028d0 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -382,6 +382,12 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_PARTIAL		(1 << 2)
 
+/*
+ * DIO will be completed inline unless sync operation is needed after io is
+ * finished.
+ */
+#define IOMAP_DIO_MAY_INLINE_COMP	(1 << 3)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
-- 
2.39.2



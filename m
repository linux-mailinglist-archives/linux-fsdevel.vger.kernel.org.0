Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686171C52B4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 12:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgEEKNQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 06:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728670AbgEEKNO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 06:13:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F317FC061A0F;
        Tue,  5 May 2020 03:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dphWhub3k3IwN/E6os0kfw+N54Qd2sRuSpy/O+B5opg=; b=pRpDMbo7qGW9M2OEFN9UZQnd3F
        KUt6WmQIFvyOIKMKE+9JiUF8K2tQiePPRWgcoks1d4EWxTyfXXYuksVlWHYsng6Fy7EwGuRIGLvPj
        qayze8pJjBsy3kNKcLUnOrLJZflNEmjIc9DmtPojRqmOdlAhWbkfaRLBq414uXdvTP9NFbNd5bUjx
        0reVWubHbGiBQ1VrQMSOfRU0Gq1cjzRNUPrS8V4SnXJtxAWZQqF/QXUdaR/03iUlIDrQnkErNxMzS
        stEN9iSzElD3HvUQojbBbLeXBpnRcXIiQJ8HY5nVIdr2L73ehnXuN+JJXAh2B5dInouh+F/oACyp2
        ZvOhupYw==;
Received: from [2001:4bb8:191:66b6:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVuZU-0006tz-Cc; Tue, 05 May 2020 10:13:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] powerpc/spufs: stop using access_ok
Date:   Tue,  5 May 2020 12:12:51 +0200
Message-Id: <20200505101256.3121270-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505101256.3121270-1-hch@lst.de>
References: <20200505101256.3121270-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just use the proper non __-prefixed get/put_user variants where that is
not done yet.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/cell/spufs/file.c | 42 +++++-------------------
 1 file changed, 8 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index f4a4dfb191e7d..bd30b5e0c4c37 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -590,17 +590,12 @@ static ssize_t spufs_mbox_read(struct file *file, char __user *buf,
 			size_t len, loff_t *pos)
 {
 	struct spu_context *ctx = file->private_data;
-	u32 mbox_data, __user *udata;
+	u32 mbox_data, __user *udata = (void __user *)buf;
 	ssize_t count;
 
 	if (len < 4)
 		return -EINVAL;
 
-	if (!access_ok(buf, len))
-		return -EFAULT;
-
-	udata = (void __user *)buf;
-
 	count = spu_acquire(ctx);
 	if (count)
 		return count;
@@ -616,7 +611,7 @@ static ssize_t spufs_mbox_read(struct file *file, char __user *buf,
 		 * but still need to return the data we have
 		 * read successfully so far.
 		 */
-		ret = __put_user(mbox_data, udata);
+		ret = put_user(mbox_data, udata);
 		if (ret) {
 			if (!count)
 				count = -EFAULT;
@@ -698,17 +693,12 @@ static ssize_t spufs_ibox_read(struct file *file, char __user *buf,
 			size_t len, loff_t *pos)
 {
 	struct spu_context *ctx = file->private_data;
-	u32 ibox_data, __user *udata;
+	u32 ibox_data, __user *udata = (void __user *)buf;
 	ssize_t count;
 
 	if (len < 4)
 		return -EINVAL;
 
-	if (!access_ok(buf, len))
-		return -EFAULT;
-
-	udata = (void __user *)buf;
-
 	count = spu_acquire(ctx);
 	if (count)
 		goto out;
@@ -727,7 +717,7 @@ static ssize_t spufs_ibox_read(struct file *file, char __user *buf,
 	}
 
 	/* if we can't write at all, return -EFAULT */
-	count = __put_user(ibox_data, udata);
+	count = put_user(ibox_data, udata);
 	if (count)
 		goto out_unlock;
 
@@ -741,7 +731,7 @@ static ssize_t spufs_ibox_read(struct file *file, char __user *buf,
 		 * but still need to return the data we have
 		 * read successfully so far.
 		 */
-		ret = __put_user(ibox_data, udata);
+		ret = put_user(ibox_data, udata);
 		if (ret)
 			break;
 	}
@@ -836,17 +826,13 @@ static ssize_t spufs_wbox_write(struct file *file, const char __user *buf,
 			size_t len, loff_t *pos)
 {
 	struct spu_context *ctx = file->private_data;
-	u32 wbox_data, __user *udata;
+	u32 wbox_data, __user *udata = (void __user *)buf;
 	ssize_t count;
 
 	if (len < 4)
 		return -EINVAL;
 
-	udata = (void __user *)buf;
-	if (!access_ok(buf, len))
-		return -EFAULT;
-
-	if (__get_user(wbox_data, udata))
+	if (get_user(wbox_data, udata))
 		return -EFAULT;
 
 	count = spu_acquire(ctx);
@@ -873,7 +859,7 @@ static ssize_t spufs_wbox_write(struct file *file, const char __user *buf,
 	/* write as much as possible */
 	for (count = 4, udata++; (count + 4) <= len; count += 4, udata++) {
 		int ret;
-		ret = __get_user(wbox_data, udata);
+		ret = get_user(wbox_data, udata);
 		if (ret)
 			break;
 
@@ -1982,9 +1968,6 @@ static ssize_t spufs_mbox_info_read(struct file *file, char __user *buf,
 	u32 stat, data;
 	int ret;
 
-	if (!access_ok(buf, len))
-		return -EFAULT;
-
 	ret = spu_acquire_saved(ctx);
 	if (ret)
 		return ret;
@@ -2028,9 +2011,6 @@ static ssize_t spufs_ibox_info_read(struct file *file, char __user *buf,
 	u32 stat, data;
 	int ret;
 
-	if (!access_ok(buf, len))
-		return -EFAULT;
-
 	ret = spu_acquire_saved(ctx);
 	if (ret)
 		return ret;
@@ -2082,9 +2062,6 @@ static ssize_t spufs_wbox_info_read(struct file *file, char __user *buf,
 	u32 data[ARRAY_SIZE(ctx->csa.spu_mailbox_data)];
 	int ret, count;
 
-	if (!access_ok(buf, len))
-		return -EFAULT;
-
 	ret = spu_acquire_saved(ctx);
 	if (ret)
 		return ret;
@@ -2143,9 +2120,6 @@ static ssize_t spufs_dma_info_read(struct file *file, char __user *buf,
 	struct spu_dma_info info;
 	int ret;
 
-	if (!access_ok(buf, len))
-		return -EFAULT;
-
 	ret = spu_acquire_saved(ctx);
 	if (ret)
 		return ret;
-- 
2.26.2


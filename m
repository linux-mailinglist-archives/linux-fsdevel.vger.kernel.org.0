Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEBF3BC5EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jul 2021 07:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhGFFI7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jul 2021 01:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhGFFI7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jul 2021 01:08:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851F3C061574;
        Mon,  5 Jul 2021 22:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Hrqanaoi/RtO507Oge3AIMRHlYs9d/SsknmqOE9P7tA=; b=l21KwPDhzlExodbHVqnTawkwH7
        NqTUFWWg/GeGZe9ecrfPxJPtuPaCerNakx8unMN4CrOrzej4pUN3SzYUxaR91MnLEng/YD45LXnyu
        S5XgvPJn5pOSTWWGYSytVmjRQIQFfwlHQhayRu505Iko6GQaHOxAqaQvHrCsHBJ8vHdduEbsp43Xt
        M06zsgf7GXV3xT6Cjj4dGVMBNmd6rBLiQfz8bXRIHMiAJkG72zEqIYaiKbfCfZh21Qn2bs4m5CJjc
        9z+KYVEZkmaPaqnQsyD+ewLr4cuVaFCk1gI5T6Iv7THNOcz5Vgoxr/Lbg4yUpvlPZanDeqvksMLRl
        STeCVmpQ==;
Received: from p4fdb05cb.dip0.t-ipconnect.de ([79.219.5.203] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0dHb-00Aqrv-AW; Tue, 06 Jul 2021 05:06:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Leizhen <thunder.leizhen@huawei.com>
Subject: [PATCH 2/2] iomap: remove the length variable in iomap_seek_hole
Date:   Tue,  6 Jul 2021 07:05:41 +0200
Message-Id: <20210706050541.1974618-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706050541.1974618-1-hch@lst.de>
References: <20210706050541.1974618-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The length variable is rather pointless given that it can be trivially
deduced from offset and size.  Also the initial calculation can lead
to KASAN warnings.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Leizhen (ThunderTown) <thunder.leizhen@huawei.com>
---
 fs/iomap/seek.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
index 50b8f1418f2668..ce6fb810854fec 100644
--- a/fs/iomap/seek.c
+++ b/fs/iomap/seek.c
@@ -35,23 +35,20 @@ loff_t
 iomap_seek_hole(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
 {
 	loff_t size = i_size_read(inode);
-	loff_t length = size - offset;
 	loff_t ret;
 
 	/* Nothing to be found before or beyond the end of the file. */
 	if (offset < 0 || offset >= size)
 		return -ENXIO;
 
-	while (length > 0) {
-		ret = iomap_apply(inode, offset, length, IOMAP_REPORT, ops,
-				  &offset, iomap_seek_hole_actor);
+	while (offset < size) {
+		ret = iomap_apply(inode, offset, size - offset, IOMAP_REPORT,
+				  ops, &offset, iomap_seek_hole_actor);
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
 			break;
-
 		offset += ret;
-		length -= ret;
 	}
 
 	return offset;
-- 
2.30.2


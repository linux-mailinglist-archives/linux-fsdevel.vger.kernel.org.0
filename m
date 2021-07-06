Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004103BDB74
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jul 2021 18:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhGFQfa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jul 2021 12:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhGFQf3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jul 2021 12:35:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD567C061574;
        Tue,  6 Jul 2021 09:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=hTspFmFVOxbrlXkexgm7PyZ5A7GwG3nbuqtXwkT6wZo=; b=UhSYAykSYjd7hIJtwFgS0nTTac
        tCKuyhoZsaN6e52YUPA1TUNPS5tjKM/rBLdQYykji/jo2zZjPsd4G2lULgUagiYLVc3sZ3SNDav3y
        Gm7FkzR0AzEslf2ji9FnQa//rLbmWyETqIC7CSHXzBZAXuvgOwg00fp2FPejhqE1wUJhzhOdWQTMa
        lCcHgHFUwifkcS4ID79KGzJOi0QhaHKyuFAjZqIRTiXIbHhjTZwGnrqABShB5ZilaztFV68a/xehy
        3y7a57x7NyhEtfhA5P31O1H2EZXKBjfeVd4xz1qoRD8Q6/YGNq3Iv7xNklHJh0TGfeU+suCchBxKN
        c6PNFWDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0nzQ-00BZZc-MB; Tue, 06 Jul 2021 16:32:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/2] iomap: Remove length variable in iomap_seek_data()
Date:   Tue,  6 Jul 2021 17:31:56 +0100
Message-Id: <20210706163158.2758223-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There's no need to calculate and maintain 'length'.  It's shorter and
simpler code to just calculate size - offset each time around the loop.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reported-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/seek.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
index dab1b02eba5b..241169b49af8 100644
--- a/fs/iomap/seek.c
+++ b/fs/iomap/seek.c
@@ -83,27 +83,23 @@ loff_t
 iomap_seek_data(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
 {
 	loff_t size = i_size_read(inode);
-	loff_t length = size - offset;
 	loff_t ret;
 
 	/* Nothing to be found before or beyond the end of the file. */
 	if (offset < 0 || offset >= size)
 		return -ENXIO;
 
-	while (length > 0) {
-		ret = iomap_apply(inode, offset, length, IOMAP_REPORT, ops,
-				  &offset, iomap_seek_data_actor);
+	while (offset < size) {
+		ret = iomap_apply(inode, offset, size - offset, IOMAP_REPORT,
+				ops, &offset, iomap_seek_data_actor);
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
-			break;
+			return offset;
 
 		offset += ret;
-		length -= ret;
 	}
 
-	if (length <= 0)
-		return -ENXIO;
-	return offset;
+	return -ENXIO;
 }
 EXPORT_SYMBOL_GPL(iomap_seek_data);
-- 
2.30.2


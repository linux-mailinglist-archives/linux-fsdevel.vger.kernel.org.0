Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DE146CFCA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 10:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhLHJPo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 04:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhLHJPn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:15:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFF8C061746;
        Wed,  8 Dec 2021 01:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=PnxYJD3WDG7A6/Qbtohv5ldkeqBnLPDokzFd0VlbXDM=; b=hXtDnEinie60aCy4kEJDppRTtm
        HpXJbdtROe93AVQnkA+uddN18Pl+NElsl85lzED9zBmOOkjXHUJRLlVym4j+AsrAOqgm0VAzTB1+G
        W06cTyy9tQExMI2Nx3wzkRhnDEkIKZDQf8cWY6JYL9lfFPyBN/s5+jC3l0hsNdXT5NdyLIh4joYYi
        M09z3uVx7N4rxdRbcIePTcZg6uw+CPKCx3Bpz++e58wAiIVIRWp4jc4hdu6iIWFV662paPTwcfO5U
        38nP4Pa4a8QgdC4ZTLbxGBe7uHp+vy5ITa58prN3iNjo1TQN9CCzxh4XCuAwL02fO+0M3QXQBzniW
        u5mmO98Q==;
Received: from [2001:4bb8:180:a1c8:2bed:fe3e:6e0:11ff] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muszb-008Gth-5a; Wed, 08 Dec 2021 09:12:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     dan.j.williams@intel.com
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] iomap: turn the byte variable in iomap_zero_iter into a ssize_t
Date:   Wed,  8 Dec 2021 10:12:03 +0100
Message-Id: <20211208091203.2927754-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

bytes also hold the return value from iomap_write_end, which can contain
a negative error value.  As bytes is always less than the page size even
the signed type can hold the entire possible range.

Fixes: c6f40468657d ("fsdax: decouple zeroing from the iomap buffered I/O code")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b1511255b4df8..ac040d607f4fe 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -883,7 +883,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 
 	do {
 		unsigned offset = offset_in_page(pos);
-		size_t bytes = min_t(u64, PAGE_SIZE - offset, length);
+		ssize_t bytes = min_t(u64, PAGE_SIZE - offset, length);
 		struct page *page;
 		int status;
 
-- 
2.30.2


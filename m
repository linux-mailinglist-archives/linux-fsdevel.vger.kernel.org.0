Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7368527ADB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Sep 2020 14:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgI1M0Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 08:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgI1M0Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:26:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B355C061755
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2020 05:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZUwxGFg5Z1Kcbt83WzozFhLB83AWDzsJW2AW3kOGdlA=; b=Du8TgVgeeOeLouw2irDlwZWH/j
        ZYU1byDPBb4yjsdi6pJm0ukud7pFCz4C89YAXZnsm4iXU4McnqDUgLPD3rdOGAd/lJL8tSWj3VpfL
        y0qdSFW3GBlEFtgT8Ar7SuQ3+EVdoZ19mi2xL9mqdk8eMkr0iPmobFcuv8IaUIbIfr7XY3Fpbt9zc
        HrSAqvn0RBjHpMdPlDRqq2Z3ErtMjPIhtj+bReuvZFe5qDkzjwtiS8DjpKRjErOu35mU9L0QYavM1
        KOpGFkDktE4UYZuUmE1CiBupouh+YZmusjGcQtT4luo8fLy/UXd6IaMMstVE9JkyaAlftsGZJYK9j
        DhApDpqg==;
Received: from [2001:4bb8:180:7b62:3a1d:d74e:d75b:5fe7] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMsEQ-0004AW-55; Mon, 28 Sep 2020 12:26:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] writeback: don't warn on an unregistered BDI in __mark_inode_dirty
Date:   Mon, 28 Sep 2020 14:26:13 +0200
Message-Id: <20200928122613.434820-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

BDIs get unregistered during device removal, and this WARN can be
trivially triggered by hot-removing a NVMe device while running fsx
It is otherwise harmless as we still hold a BDI reference, and the
writeback has been shut down already.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

I have a vague memory someone else sent this patch alredy, but couldn't
find it in my mailing list folder.  But given that my current NVMe
tests trigger it easily I'd rather get it fixed ASAP.

 fs/fs-writeback.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e6005c78bfa93e..acfb55834af23c 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2321,10 +2321,6 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 
 			wb = locked_inode_to_wb_and_lock_list(inode);
 
-			WARN((wb->bdi->capabilities & BDI_CAP_WRITEBACK) &&
-			     !test_bit(WB_registered, &wb->state),
-			     "bdi-%s not registered\n", bdi_dev_name(wb->bdi));
-
 			inode->dirtied_when = jiffies;
 			if (dirtytime)
 				inode->dirtied_time_when = jiffies;
-- 
2.28.0


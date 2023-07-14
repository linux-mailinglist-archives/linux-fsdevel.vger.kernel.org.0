Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FB07535AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 10:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbjGNIvz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 04:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbjGNIvl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:51:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AF226A5;
        Fri, 14 Jul 2023 01:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1Mmk0hcQiy9mntBXriZUXYSFGw90mYsBEkK5jJEnRzw=; b=MvTymamHN3zkqhNT1fE1Fvzzsc
        ASvKE8XPmBuIxwjrNchNXRmjrGlnxlV1ai8QRgjl3okWwyCiUu9hs8VCnqVuVlbbVCTxoQIVkFUeO
        yYI0gQ/bW77LmeNvjvnJjFd1cBs41thrORAO4gwJDM3t4SZ2q+9RAMQDkzoPDEfSvhn+HGoJX4bim
        /nTX9ag1wru9WgucL5p7PHHwL5lx+jd7v24O00JPedhRyq7pSfURfz0TRXlD5owcJR8R6zan8/S+Y
        fVwA4+Jh4fT35VnMIUKNHcrr4r6IliPCjQA8L3Pn3oGWtPBkzc5Sm9WKBE9qrPPTBkQAn72TvvMLz
        +iZQnq0g==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qKEWW-005aGS-0q;
        Fri, 14 Jul 2023 08:51:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        Cyril Hrubis <chrubis@suse.cz>
Subject: [PATCH 1/2] iomap: fix a regression for partial write errors
Date:   Fri, 14 Jul 2023 10:51:23 +0200
Message-Id: <20230714085124.548920-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When write* wrote some data it should return the amount of written data
and not the error code that caused it to stop.  Fix a recent regression
in iomap_file_buffered_write that caused it to return the errno instead.

Fixes: 219580eea1ee ("iomap: update ki_pos in iomap_file_buffered_write")
Reported-by: kernel test robot <oliver.sang@intel.com>
Reported-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index adb92cdb24b009..7cc9f7274883a5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -872,7 +872,7 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.processed = iomap_write_iter(&iter, i);
 
-	if (unlikely(ret < 0))
+	if (unlikely(iter.pos == iocb->ki_pos))
 		return ret;
 	ret = iter.pos - iocb->ki_pos;
 	iocb->ki_pos += ret;
-- 
2.39.2


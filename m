Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099215353ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 21:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348191AbiEZT32 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 15:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiEZT30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 15:29:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800225B894
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 12:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9JqXy0lBEg/MQdfYlCAme5LYG4YIOIwkBWQxllmFD7g=; b=h7sSKXwy3S78KgTISdtMXLUu9x
        ZCioesmSNcyQUHNaOZT0wXzUfvKfCA9+Ug7IWhiBpPLE51fn0Qgf0doWNmVOtlleQumu11CLhLr3W
        OUXPLQ2eFB+LLySV/2l2yTSC4XvfOeujput/gY/qzARIEUc4aMQ1DBslMgdsklfu9jWdwn3Gih6I8
        Rc68nSesgYSGP/lhjKTbTC1NZtYKMd/fbFGCFPNV7kiUPgMBtayVomaG9kGWsPoEqHv6mrI2iceWJ
        G1UQi0l0rJlo+HUA05nXsJfNJxx3DRyu4pA3KpjQ2aXvZXN+PqaGTjeJA/xt+XHH5lBsz6LnzCyQR
        ifqIl2nw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuJAa-001UuB-Et; Thu, 26 May 2022 19:29:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [RFC PATCH 1/9] IOMAP_DIO_NOSYNC
Date:   Thu, 26 May 2022 20:29:02 +0100
Message-Id: <20220526192910.357055-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220526192910.357055-1-willy@infradead.org>
References: <20220526192910.357055-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al's patch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/direct-io.c  | 3 ++-
 include/linux/iomap.h | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 370c3241618a..6a361131080f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -548,7 +548,8 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		}
 
 		/* for data sync or sync, we need sync completion processing */
-		if (iocb->ki_flags & IOCB_DSYNC)
+		if (iocb->ki_flags & IOCB_DSYNC &&
+		    !(dio_flags & IOMAP_DIO_NOSYNC))
 			dio->flags |= IOMAP_DIO_NEED_SYNC;
 
 		/*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index e552097c67e0..c8622d8f064e 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -353,6 +353,12 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_PARTIAL		(1 << 2)
 
+/*
+ * The caller will sync the write if needed; do not sync it within
+ * iomap_dio_rw.  Overrides IOMAP_DIO_FORCE_WAIT.
+ */
+#define IOMAP_DIO_NOSYNC		(1 << 3)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
-- 
2.34.1


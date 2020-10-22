Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9870929667A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 23:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372256AbgJVVWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 17:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897727AbgJVVWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 17:22:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1895EC0613CE;
        Thu, 22 Oct 2020 14:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/Sk507X/XJRZb80wAXzDRfdLw7egwWlksVqiUNUiyjs=; b=j0gytLMNDZRI40meEo4hRH0jPx
        MaadKOoRAPi5awBfQX5VgWUV5s2w/Vq8fLZU7MEYAZpA6hWI36nO0Yyy87RMst0MaWjYFrDwDYkmY
        1Mmm67OCuN6KpXH2OEfhgTkkLEX2rnoG1L5KxXBqM5t6ocYmlKBJYQ/KA3fq64qupBiiNHa1+eBp3
        kns7bcC2TbVAOpW6oKEFdQmtxu79GBBw0QBR/Xz/d9YDOUs65+/sr7Eg55SFiCgJlHLYA5qGL7xkq
        WRRCEoB7yu1gIVj8FVkelOahlDSNLRO/ULvcB2rU3q4Haps42hFd+dyKw3WMTHvndlWFGTwarGCc0
        DCgHAx1A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVi2Y-00046F-AE; Thu, 22 Oct 2020 21:22:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 1/6] block: Add blk_completion
Date:   Thu, 22 Oct 2020 22:22:23 +0100
Message-Id: <20201022212228.15703-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201022212228.15703-1-willy@infradead.org>
References: <20201022212228.15703-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This new data structure allows a task to wait for N things to complete.
Usually the submitting task will handle cleanup, but if it is killed,
the last completer will take care of it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 block/blk-core.c    | 61 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/bio.h | 11 ++++++++
 2 files changed, 72 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 10c08ac50697..2892246f2176 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1900,6 +1900,67 @@ void blk_io_schedule(void)
 }
 EXPORT_SYMBOL_GPL(blk_io_schedule);
 
+void blk_completion_init(struct blk_completion *cmpl, int n)
+{
+	spin_lock_init(&cmpl->cmpl_lock);
+	cmpl->cmpl_count = n;
+	cmpl->cmpl_task = current;
+	cmpl->cmpl_status = BLK_STS_OK;
+}
+
+int blk_completion_sub(struct blk_completion *cmpl, blk_status_t status, int n)
+{
+	int ret = 0;
+
+	spin_lock_bh(&cmpl->cmpl_lock);
+	if (cmpl->cmpl_status == BLK_STS_OK && status != BLK_STS_OK)
+		cmpl->cmpl_status = status;
+	cmpl->cmpl_count -= n;
+	BUG_ON(cmpl->cmpl_count < 0);
+	if (cmpl->cmpl_count == 0) {
+		if (cmpl->cmpl_task)
+			wake_up_process(cmpl->cmpl_task);
+		else
+			ret = -EINTR;
+	}
+	spin_unlock_bh(&cmpl->cmpl_lock);
+	if (ret < 0)
+		kfree(cmpl);
+	return ret;
+}
+
+int blk_completion_wait_killable(struct blk_completion *cmpl)
+{
+	int err = 0;
+
+	for (;;) {
+		set_current_state(TASK_KILLABLE);
+		spin_lock_bh(&cmpl->cmpl_lock);
+		if (cmpl->cmpl_count == 0)
+			break;
+		spin_unlock_bh(&cmpl->cmpl_lock);
+		blk_io_schedule();
+		if (fatal_signal_pending(current)) {
+			spin_lock_bh(&cmpl->cmpl_lock);
+			cmpl->cmpl_task = NULL;
+			if (cmpl->cmpl_count != 0) {
+				spin_unlock_bh(&cmpl->cmpl_lock);
+				cmpl = NULL;
+			}
+			err = -ERESTARTSYS;
+			break;
+		}
+	}
+	set_current_state(TASK_RUNNING);
+	if (cmpl) {
+		spin_unlock_bh(&cmpl->cmpl_lock);
+		err = blk_status_to_errno(cmpl->cmpl_status);
+		kfree(cmpl);
+	}
+
+	return err;
+}
+
 int __init blk_dev_init(void)
 {
 	BUILD_BUG_ON(REQ_OP_LAST >= (1 << REQ_OP_BITS));
diff --git a/include/linux/bio.h b/include/linux/bio.h
index f254bc79bb3a..0bde05f5548c 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -814,4 +814,15 @@ static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 		bio->bi_opf |= REQ_NOWAIT;
 }
 
+struct blk_completion {
+	struct task_struct *cmpl_task;
+	spinlock_t cmpl_lock;
+	int cmpl_count;
+	blk_status_t cmpl_status;
+};
+
+void blk_completion_init(struct blk_completion *, int n);
+int blk_completion_sub(struct blk_completion *, blk_status_t status, int n);
+int blk_completion_wait_killable(struct blk_completion *);
+
 #endif /* __LINUX_BIO_H */
-- 
2.28.0


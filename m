Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283383E883E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 04:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhHKCwC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 22:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbhHKCwB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:52:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF56FC061765;
        Tue, 10 Aug 2021 19:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qsXnlWir+jCMA8VrQ9bMeCMmXf5FzlVg876WkEv4TuI=; b=TjZdmMnwtYrlTXNNczw9Mxf4K8
        7qKpP0qZTVSJaLaWcdXoSenSC4VSyq8lc4DuQTxMd4/qmjcANFvlKywbdY/5fy0Z4cBHcsLj99w2o
        veI1vj83GLtGWJCzPdwOvMX0g2RCiL2n9Q8QA7RVpiqAU6YIEqYxSWUBGY8s+rGK46bhc32GC12dw
        k3JbOC5/TDpco+1QMAuMiWyHUupKwViL/gZA8OXJyk87l56SUwFB4ZMRH7QTDEycjJu1dDxmhaHuW
        AGXxXwzPlD/8HitHZGn34iVIWB7CnK6xzj6q/3OYgzkzlhltq4PDs9B+IbF0hW1OcwWSpXBUpd4Vl
        wY2gXfWw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDeJp-00CsHW-LR; Wed, 11 Aug 2021 02:50:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 5/8] iomap: Pass iomap_write_ctx to iomap_write_actor()
Date:   Wed, 11 Aug 2021 03:46:44 +0100
Message-Id: <20210811024647.3067739-6-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210811024647.3067739-1-willy@infradead.org>
References: <20210811024647.3067739-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We need to pass a little more information to iomap_write_actor(),
so define our own little struct for it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ad9d8fe97f2e..a74da66e64a7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -514,6 +514,13 @@ enum {
 	IOMAP_WRITE_F_UNSHARE		= (1 << 0),
 };
 
+struct iomap_write_ctx {
+	struct iov_iter *iter;
+	struct iomap_ioend *ioend;
+	struct list_head iolist;
+	bool write_through;
+};
+
 static void
 iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
 {
@@ -734,7 +741,8 @@ static loff_t
 iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		struct iomap *iomap, struct iomap *srcmap)
 {
-	struct iov_iter *i = data;
+	struct iomap_write_ctx *iwc = data;
+	struct iov_iter *i = iwc->iter;
 	long status = 0;
 	ssize_t written = 0;
 
@@ -804,12 +812,17 @@ ssize_t
 iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops)
 {
+	struct iomap_write_ctx iwc = {
+		.iter = iter,
+		.iolist = LIST_HEAD_INIT(iwc.iolist),
+		.write_through = iocb->ki_flags & IOCB_SYNC,
+	};
 	struct inode *inode = iocb->ki_filp->f_mapping->host;
 	loff_t pos = iocb->ki_pos, ret = 0, written = 0;
 
 	while (iov_iter_count(iter)) {
 		ret = iomap_apply(inode, pos, iov_iter_count(iter),
-				IOMAP_WRITE, ops, iter, iomap_write_actor);
+				IOMAP_WRITE, ops, &iwc, iomap_write_actor);
 		if (ret <= 0)
 			break;
 		pos += ret;
-- 
2.30.2


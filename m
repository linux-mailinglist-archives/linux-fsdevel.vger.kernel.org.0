Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C35651A564
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 18:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353389AbiEDQ1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 12:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbiEDQ1Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 12:27:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA05646675;
        Wed,  4 May 2022 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=i27+VtCIOe04rf/aY8+YzgwW8t+4wpVcGI5t6v0kSec=; b=lrXyuWIsSlTKa0Dea/OPSIqX+i
        yLL0F9h9Wb7hXWkJj4YhMh2JOTUmC1IHlKSsm8d0ny66A094kEu5tEev7HwmJPRJrDiwCzKnYFC9p
        5y/Gbyxbe7WsSr1ks7PyUKtxKwrV54XXXeJarLkQi6kHIzZBtwrvroj8UheZHMEcGvzFJRrs2t5dC
        Ug2yk032vVk9ldqnPsMWdixb1/RU7N4UHjKIrp1YhG3EKtzuRKlEYaTx5rmKhK6b17pYRtjLvc4aa
        ITkCWqQPWvdkdoSXPSJqmN4/PakyI0ze1BmAkgHiXI8tnjvxp+IAIHhy5tzmioWzJWAiOuVfnMRzj
        D9FgCdZA==;
Received: from [8.34.116.185] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmHmx-00BeDF-PG; Wed, 04 May 2022 16:23:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5] iomap: add per-iomap_iter private data
Date:   Wed,  4 May 2022 09:23:39 -0700
Message-Id: <20220504162342.573651-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220504162342.573651-1-hch@lst.de>
References: <20220504162342.573651-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow the file system to keep state for all iterations.  For now only
wire it up for direct I/O as there is an immediate need for it there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c  | 8 ++++++++
 include/linux/iomap.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 15929690d89e3..355abe2eacc6a 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -520,6 +520,14 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->submit.waiter = current;
 	dio->submit.poll_bio = NULL;
 
+	/*
+	 * Transfer the private data that was passed by the caller to the
+	 * iomap_iter, and clear it in the iocb, as iocb->private will be
+	 * used for polled bio completion later.
+	 */
+	iomi.private = iocb->private;
+	WRITE_ONCE(iocb->private, NULL);
+
 	if (iov_iter_rw(iter) == READ) {
 		if (iomi.pos >= dio->i_size)
 			goto out_free_dio;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index a5483020dad41..109c055865f73 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -188,6 +188,7 @@ struct iomap_iter {
 	unsigned flags;
 	struct iomap iomap;
 	struct iomap srcmap;
+	void *private;
 };
 
 int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops);
-- 
2.30.2


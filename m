Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBFF4E43AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237237AbiCVP7g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238900AbiCVP7J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:59:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F52C7004F;
        Tue, 22 Mar 2022 08:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=T4OP/kQhkNGqkRwhNXhAZws6IePTzoC8weH9gjPJVRA=; b=Id8VvtLGCQkjC77LIMsnR4jQC3
        TBViU8NBsxmSDStePDo136YDW+jQ6t1e3tIVvGpp+IL81abUt/OwA9rXhrveL/o2il6LzQ9UVhqRp
        63CqH6AWM3mHq97rrTLCQvokOpbofz/wzofLr0n9V5tp0va/3+vMgIzJ1n0A2e+VvjHsPJvQHTBvQ
        W59KP5B9dXKW3veuj29O18n8M/1pF6u4b1whwQ9VVYFLeIKr9OuG1xiz8Is1IZXLbpCkp4lP71Kuo
        YP3F0F37+MLh+/4QdgwvaRET+d9KoAhm8CyWC13czHksDb7abeJnT88yaI0ooGFles3cUvYi7b3PG
        5MIxuuZA==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgsw-00Bb23-5G; Tue, 22 Mar 2022 15:57:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 30/40] iomap: add per-iomap_iter private data
Date:   Tue, 22 Mar 2022 16:55:56 +0100
Message-Id: <20220322155606.1267165-31-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220322155606.1267165-1-hch@lst.de>
References: <20220322155606.1267165-1-hch@lst.de>
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
wire it up for direct I/O as there is an immediate need for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c  | 3 +++
 include/linux/iomap.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index a434b1829545d..63ee37b40fd8f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -477,6 +477,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		.pos		= iocb->ki_pos,
 		.len		= iov_iter_count(iter),
 		.flags		= IOMAP_DIRECT,
+		.private	= iocb->private,
 	};
 	loff_t end = iomi.pos + iomi.len - 1, ret = 0;
 	bool wait_for_completion =
@@ -504,6 +505,8 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->submit.waiter = current;
 	dio->submit.poll_bio = NULL;
 
+	WRITE_ONCE(iocb->private, NULL);
+
 	if (iov_iter_rw(iter) == READ) {
 		if (iomi.pos >= dio->i_size)
 			goto out_free_dio;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 97a3a2edb5850..3cc5ee01066d0 100644
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


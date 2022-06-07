Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4112E53F4E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 06:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbiFGEN3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 00:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiFGEN2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 00:13:28 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BC72A432
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jun 2022 21:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pl5q/tnDV9JxySseejJDZyiDzcWufk965nXMSX8CuyM=; b=hf47NA9jsAEyeE351dlYUudu+g
        UT9ptMXoBu66jOTDrh1tXAYm3tvpE7GRn/CkvB+HMeuvikkcSC+RNXRr9xjlkkYflZvxMGJQS6ixH
        H5MruIscy0LCUBjR/vmzmCPpfpnTnjA6wW1aXe/inXJH7TRDcOiFEl7vWujwHvd7lvOCva92UJGqh
        yb53H0fC1xvdbVVH2UtVkhdPeTnk0V9f9mlkfmWlVS/hSQ3RKRB+WHl8kuMzCEzflsSFQo7p4BHTS
        povsXKzHVEQomAcLZbt1ryTRaSW0LDYnNe0bzZytbNrWDp2JBwGEXtATmXM1nKKgjdzv+arNeJaDd
        nLfSdt5A==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyQas-004YqP-BN; Tue, 07 Jun 2022 04:13:26 +0000
Date:   Tue, 7 Jun 2022 04:13:26 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 8/9] switch new_sync_{read,write}() to ITER_UBUF
Message-ID: <Yp7QZmatNYM7+zcJ@zeniv-ca.linux.org.uk>
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/read_write.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index b1b1cdfee9d3..e82e4301cadd 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -389,14 +389,13 @@ EXPORT_SYMBOL(rw_verify_area);
 
 static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos)
 {
-	struct iovec iov = { .iov_base = buf, .iov_len = len };
 	struct kiocb kiocb;
 	struct iov_iter iter;
 	ssize_t ret;
 
 	init_sync_kiocb(&kiocb, filp);
 	kiocb.ki_pos = (ppos ? *ppos : 0);
-	iov_iter_init(&iter, READ, &iov, 1, len);
+	iov_iter_ubuf(&iter, READ, buf, len);
 
 	ret = call_read_iter(filp, &kiocb, &iter);
 	BUG_ON(ret == -EIOCBQUEUED);
@@ -492,14 +491,13 @@ ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
 
 static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t len, loff_t *ppos)
 {
-	struct iovec iov = { .iov_base = (void __user *)buf, .iov_len = len };
 	struct kiocb kiocb;
 	struct iov_iter iter;
 	ssize_t ret;
 
 	init_sync_kiocb(&kiocb, filp);
 	kiocb.ki_pos = (ppos ? *ppos : 0);
-	iov_iter_init(&iter, WRITE, &iov, 1, len);
+	iov_iter_ubuf(&iter, WRITE, (void __user *)buf, len);
 
 	ret = call_write_iter(filp, &kiocb, &iter);
 	BUG_ON(ret == -EIOCBQUEUED);
-- 
2.30.2


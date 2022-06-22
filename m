Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B3F554167
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356879AbiFVEQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356709AbiFVEP6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:15:58 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F65A656E
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NPOwPO2c4uajDyblyCE6/dHQ5kD7t1bOCOYXJLLpL1w=; b=rdcJI37/hMYtodBGotEKwpVlhz
        +dv2RppEYa0uRaPVBo/9K26GSLBHpxyBgGjny18/PSUT92xLQs90Dwie02L8rv73iwq4iFFB88xZb
        GnuAZQ8nMoVdtrw0zNYjjX8c01/02Zwz8wJEhLFfIoABKXuwLis4Uxai9EmA+WxKrer+iFz5Owzlq
        qTIxm9hqhPKdWZlf84yeeD9MF+rB6hmBB5RSuSYTuftr8q8mJG+mPXmeXaTUEz59VEauYGx7MH1S3
        4fVsRLUp7D1Ii4CxdudgQr6a2PXdNrJ2wJ9tMZnmtGVFeb3xBZl77UOWsYI4p6ikfrZ9BWSvb3J6K
        ItqQzATQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmU-0035wU-Lp;
        Wed, 22 Jun 2022 04:15:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 13/44] splice: stop abusing iov_iter_advance() to flush a pipe
Date:   Wed, 22 Jun 2022 05:15:21 +0100
Message-Id: <20220622041552.737754-13-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622041552.737754-1-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use pipe_discard_from() explicitly in generic_file_read_iter(); don't bother
with rather non-obvious use of iov_iter_advance() in there.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/splice.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 047b79db8eb5..6645b30ec990 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -301,11 +301,9 @@ ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
 {
 	struct iov_iter to;
 	struct kiocb kiocb;
-	unsigned int i_head;
 	int ret;
 
 	iov_iter_pipe(&to, READ, pipe, len);
-	i_head = to.head;
 	init_sync_kiocb(&kiocb, in);
 	kiocb.ki_pos = *ppos;
 	ret = call_read_iter(in, &kiocb, &to);
@@ -313,9 +311,8 @@ ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
 		*ppos = kiocb.ki_pos;
 		file_accessed(in);
 	} else if (ret < 0) {
-		to.head = i_head;
-		to.iov_offset = 0;
-		iov_iter_advance(&to, 0); /* to free what was emitted */
+		/* free what was emitted */
+		pipe_discard_from(pipe, to.start_head);
 		/*
 		 * callers of ->splice_read() expect -EAGAIN on
 		 * "can't put anything in there", rather than -EFAULT.
-- 
2.30.2


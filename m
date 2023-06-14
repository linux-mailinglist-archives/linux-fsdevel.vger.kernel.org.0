Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0342730124
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 16:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245367AbjFNOD6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 10:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245360AbjFNOD5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:03:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92511FD5;
        Wed, 14 Jun 2023 07:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kqzcuvv5+ni30kABbm+RVPgUdj7KFWVibordNlWqX6g=; b=AWae5lUZJZR0gw6CSaF6i8Dbxw
        skKovZPT6h+rF/aDaEp8pP7DgsSXnQrSqPZnWmt9PMms2TIM/n7YOGPZOS9kW6/dkL5mEeoDCi8ci
        CHw7rVcx8+IzodkylR66w5rxYKABLuEcjnW9FXVsXfxiriTcUW52Rvm5xCYU5qOh2l9YtJgxrnkUZ
        9RUnI3tAjmXW7XjVSoMebO+UoJ7IkB74NuLwNbaD05DdUCgKQqjke0k0NA8CCBXU1IYVE7RvH5H8S
        j/YGXqap3mu2Nuo3AL0ak86ioLKyQXQ+A0kToo4HDQONuALJlfV4l7OvT/x1dx9IIztqgxdEQo7Yk
        fLHADayw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9R6G-00Br9k-0L;
        Wed, 14 Jun 2023 14:03:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] splice: simplify a conditional in copy_splice_read
Date:   Wed, 14 Jun 2023 16:03:39 +0200
Message-Id: <20230614140341.521331-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230614140341.521331-1-hch@lst.de>
References: <20230614140341.521331-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Check for -EFAULT instead of wrapping the check in an ret < 0 block.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/splice.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 87c69fdb333dab..7a9565d8ec4f9d 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -368,15 +368,15 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 	if (ret > 0) {
 		keep = DIV_ROUND_UP(ret, PAGE_SIZE);
 		*ppos = kiocb.ki_pos;
-	} else if (ret < 0) {
-		/*
-		 * callers of ->splice_read() expect -EAGAIN on
-		 * "can't put anything in there", rather than -EFAULT.
-		 */
-		if (ret == -EFAULT)
-			ret = -EAGAIN;
 	}
 
+	/*
+	 * Callers of ->splice_read() expect -EAGAIN on "can't put anything in
+	 * there", rather than -EFAULT.
+	 */
+	if (ret == -EFAULT)
+		ret = -EAGAIN;
+
 	/* Free any pages that didn't get touched at all. */
 	if (keep < npages)
 		release_pages(pages + keep, npages - keep);
-- 
2.39.2


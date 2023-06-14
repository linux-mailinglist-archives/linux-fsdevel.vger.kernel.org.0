Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF28730122
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 16:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245357AbjFNOD4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 10:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245361AbjFNODw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:03:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B30C198;
        Wed, 14 Jun 2023 07:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=N0NqQg1rr3XivzomKAcpH5XXjeENykGjUWnON9YOFfw=; b=lPM87SRljs2UXLESTnsqKCjCS+
        6drtMRyhslDM0yWnYUb29V02Vkx/iEzseEOR6OdAh9d3EGwuFAEbLL6ravyYr4UQtmLx3AsHzVCmU
        dmMMHGauPBWNIWcQgzUrC2Cfg/XQlpPR0bZAkNncVTo3K2pwZ2YzA/K34An9KIgAzj5CqxahN6BRq
        BrFzffW01wWRLM/cwKXE4jwuIyv3QSOhyolAET2ajFEAHtkV+OyMnGXDkPo8V4aBtSQVsGURPkXGn
        G8RuFeh7e0rkuCtZnCdh/WTSmLgfa4oSeNFbIG0860m5WOTLeS+bb4H9JtYY7hdBPP4kJn5lt09rn
        1TlJ1qJg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9R6C-00Br9O-2N;
        Wed, 14 Jun 2023 14:03:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] splice: don't call file_accessed in copy_splice_read
Date:   Wed, 14 Jun 2023 16:03:38 +0200
Message-Id: <20230614140341.521331-2-hch@lst.de>
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

copy_splice_read calls into ->read_iter to read the data, which already
calls file_accessed.

Fixes: 33b3b041543e ("splice: Add a func to do a splice from an O_DIRECT file without ITER_PIPE")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/splice.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index 2420ead610a727..87c69fdb333dab 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -368,7 +368,6 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 	if (ret > 0) {
 		keep = DIV_ROUND_UP(ret, PAGE_SIZE);
 		*ppos = kiocb.ki_pos;
-		file_accessed(in);
 	} else if (ret < 0) {
 		/*
 		 * callers of ->splice_read() expect -EAGAIN on
-- 
2.39.2


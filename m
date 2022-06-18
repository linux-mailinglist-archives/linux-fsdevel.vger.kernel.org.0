Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67675502FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 07:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbiFRFgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 01:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiFRFgA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:36:00 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1AE6832D
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 22:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=LZbZlv3eQ7A6KG1fO/J0ToQISYXdlJES4yFWnJkMCls=; b=TgNhfoKeRoM9qdMC4Z6K6EUWnb
        0QfKCCpyMvmxuYHsbPYmDJJrOMFYF/Za/0/gvL0+vAVu+EllExmiQuh6WbOqmVwIccNUU0SDWhZap
        bBO0bt8vZcOKpIByX5iJLHeqgI5qJpjT6Q0halwxh5A7OGXqzuIcKxLPZhxiqH1pD/L4Ml6CIgahb
        hhxH3mgyko3oGAA0i1Gub0eS4iEynqquxl/zOqoM3sACQUIokwO2P98erEBTUcG26MEaDrg9DRbgx
        XvqBD1JrjFJG2mNEumbOP5MRHjQMGmLDxB+NO6Ln59HR4jvlAzkTJTv/pCbmlq/zo8GPJvaOXgKPh
        1bS/Mk+g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2R7X-001VRY-3y;
        Sat, 18 Jun 2022 05:35:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 25/31] iter_to_pipe(): switch to advancing variant of iov_iter_get_pages()
Date:   Sat, 18 Jun 2022 06:35:32 +0100
Message-Id: <20220618053538.359065-26-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220618053538.359065-1-viro@zeniv.linux.org.uk>
References: <Yq1iNHboD+9fz60M@ZenIV>
 <20220618053538.359065-1-viro@zeniv.linux.org.uk>
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

... and untangle the cleanup on failure to add into pipe.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/splice.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 493878bd9bb9..1b810fbbabcf 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1160,39 +1160,40 @@ static int iter_to_pipe(struct iov_iter *from,
 	};
 	size_t total = 0;
 	int ret = 0;
-	bool failed = false;
 
-	while (iov_iter_count(from) && !failed) {
+	while (iov_iter_count(from)) {
 		struct page *pages[16];
-		ssize_t copied;
+		ssize_t left;
 		size_t start;
-		int n;
+		int i, n;
 
-		copied = iov_iter_get_pages(from, pages, LONG_MAX, 16, &start);
-		if (copied <= 0) {
-			ret = copied;
+		left = iov_iter_get_pages2(from, pages, LONG_MAX, 16, &start);
+		if (left <= 0) {
+			ret = left;
 			break;
 		}
 
-		for (n = 0; copied; n++, start = 0) {
-			int size = min_t(int, copied, PAGE_SIZE - start);
-			if (!failed) {
-				buf.page = pages[n];
-				buf.offset = start;
-				buf.len = size;
-				ret = add_to_pipe(pipe, &buf);
-				if (unlikely(ret < 0)) {
-					failed = true;
-				} else {
-					iov_iter_advance(from, ret);
-					total += ret;
-				}
-			} else {
-				put_page(pages[n]);
+		n = DIV_ROUND_UP(left + start, PAGE_SIZE);
+		for (i = 0; i < n; i++) {
+			int size = min_t(int, left, PAGE_SIZE - start);
+
+			buf.page = pages[i];
+			buf.offset = start;
+			buf.len = size;
+			ret = add_to_pipe(pipe, &buf);
+			if (unlikely(ret < 0)) {
+				iov_iter_revert(from, left);
+				// this one got dropped by add_to_pipe()
+				while (++i < n)
+					put_page(pages[i]);
+				goto out;
 			}
-			copied -= size;
+			total += ret;
+			left -= size;
+			start = 0;
 		}
 	}
+out:
 	return total ? total : ret;
 }
 
-- 
2.30.2


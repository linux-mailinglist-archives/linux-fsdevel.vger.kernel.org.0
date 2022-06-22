Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABEE554179
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356910AbiFVERC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356846AbiFVEQK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:16:10 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87453B7D9
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kBA4jm/ByDgMz+ovb1bPQYkTGj/XoEeGjXJPyhPI5/k=; b=aGivSm3YkaWm6Eof5gz4pXymlC
        xXx0WmbWyVOtURl5lNklDgQyzsMLj2592IMCplZ/oVXIC/HnpRmcFcmGsc2K9HejNsRCiNTZIUftW
        3zOlrQFcw7t3djfQvChh9TD4WVnSxUyImREsJnPIGff7tMAvPIIdulXkTnzvYqFDNjA2eXGvrvmru
        Zh6KkcVKuGqRhsHM1XzLiDxHPsZ3r7ffWnBPn7Asu3dHVuylaSeKVKhIJs6uVQpNgbCDbfe1HHTcs
        +5SyiClk3lHErRJFKn6rHGAccuTCRUb4AnxMWMO9J63JzhD9hWfZyzlBsJc8x7vhG9ClxEgYTvtmI
        ByzMBIiA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmZ-0035zh-Ax;
        Wed, 22 Jun 2022 04:15:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 38/44] iter_to_pipe(): switch to advancing variant of iov_iter_get_pages()
Date:   Wed, 22 Jun 2022 05:15:46 +0100
Message-Id: <20220622041552.737754-38-viro@zeniv.linux.org.uk>
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

... and untangle the cleanup on failure to add into pipe.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/splice.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 6645b30ec990..9f84bd21f64c 100644
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
 
-		copied = iov_iter_get_pages(from, pages, ~0UL, 16, &start);
-		if (copied <= 0) {
-			ret = copied;
+		left = iov_iter_get_pages2(from, pages, ~0UL, 16, &start);
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


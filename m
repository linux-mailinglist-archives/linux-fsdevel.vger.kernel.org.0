Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EA35502F5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 07:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbiFRFfy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 01:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiFRFfn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:35:43 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6097C66228
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 22:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FA2Ec0lsFk0aJCEdVbkX3Yz3w8NSeIj3E2mQyCFqOGU=; b=d9jAIYmRlhJJi0FVMXg7dS+D/g
        xR5BlkGFeDtJLp8Ae1F7ZMEpWV0T6eFLRBbmg7X4TeEfkuY3gpB/jxQjThzE99U7sYrtipR5Pta6+
        DKNTT3274TB+flH6fNAP5EknE9LKPMzZJ9PTVbMRQOJbk7W1Qi0Rx3t0rHYFEqcVm2MHXxxsMii7s
        TnEzQEzOkLrwUmYiaKDkTr+a0IHHpuYjueyPIj1ZDD3fBrrJ1cfX2YufBZu17kdTs7zs1DVKlm+H6
        xj0XHAg7QklsVuSVw3p6mtXO/Qm8jfKWmDF4l+dYIy8WsoAsfsJWyd+2ijunqN9csSgVX3t/dp2uI
        i+X6DKQQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2R7U-001VQE-Jo;
        Sat, 18 Jun 2022 05:35:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 11/31] iov_iter_get_pages{,_alloc}(): cap the maxsize with LONG_MAX
Date:   Sat, 18 Jun 2022 06:35:18 +0100
Message-Id: <20220618053538.359065-12-viro@zeniv.linux.org.uk>
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

All callers can and should handle iov_iter_get_pages() returning
fewer pages than requested.  All in-kernel ones do.  And it makes
the arithmetical overflow analysis much simpler...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/splice.c    | 2 +-
 lib/iov_iter.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index 6645b30ec990..493878bd9bb9 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1168,7 +1168,7 @@ static int iter_to_pipe(struct iov_iter *from,
 		size_t start;
 		int n;
 
-		copied = iov_iter_get_pages(from, pages, ~0UL, 16, &start);
+		copied = iov_iter_get_pages(from, pages, LONG_MAX, 16, &start);
 		if (copied <= 0) {
 			ret = copied;
 			break;
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 3abd1c596520..2d4176a2a1b5 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1367,6 +1367,8 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 		maxsize = i->count;
 	if (!maxsize)
 		return 0;
+	if (maxsize > LONG_MAX)
+		maxsize = LONG_MAX;
 
 	if (likely(user_backed_iter(i))) {
 		unsigned int gup_flags = 0;
@@ -1485,6 +1487,8 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		maxsize = i->count;
 	if (!maxsize)
 		return 0;
+	if (maxsize > LONG_MAX)
+		maxsize = LONG_MAX;
 
 	if (likely(user_backed_iter(i))) {
 		unsigned int gup_flags = 0;
-- 
2.30.2


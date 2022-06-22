Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A10554187
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356970AbiFVEQr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356779AbiFVEQA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:16:00 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DDB10C4
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FxLpAQp33qMHhiVHeDBym+xIzy9dgSEuFPNXXyxK8aM=; b=GAUvgMWyrnSJpgz6iF78J6Q+eL
        ENx1Bdcbf0viXEVDO83Y8js2HgNmdSZ2/ruguGl5bt0mk8cA5hyf9ZUpVdxFTNvQAbwjLLrkpLb9x
        P2VuS0UTCZU3PuGEEpNqf6i5AoaGJpth0wpq+KLQkTXqw7cCZZ6MhwPx0rXsQVWvV97Wi54y2S/HU
        blvir2gY0XJufRvCbNyy3ML5ed2U9SMxZkbn3F4nR/NW35SMhQq2Xn2mQGMtZmvyJnXWrNDVT01oU
        x7mtQ4CMnc2VgFOGKPs8kKhOO7mGHtdtc0TiwGz76cmyvgP87uv/d6NeHMc+0Je2O/uz7UMspKzak
        hDdOVGfA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmW-0035xv-MB;
        Wed, 22 Jun 2022 04:15:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 25/44] iov_iter_get_pages(): sanity-check arguments
Date:   Wed, 22 Jun 2022 05:15:33 +0100
Message-Id: <20220622041552.737754-25-viro@zeniv.linux.org.uk>
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

zero maxpages is bogus, but best treated as "just return 0";
NULL pages, OTOH, should be treated as a hard bug.

get rid of now completely useless checks in xarray_get_pages{,_alloc}().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 9c25661684c6..5c985cf2858e 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1271,9 +1271,6 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 	size_t size = maxsize;
 	loff_t pos;
 
-	if (!size || !maxpages)
-		return 0;
-
 	pos = i->xarray_start + i->iov_offset;
 	index = pos >> PAGE_SHIFT;
 	offset = pos & ~PAGE_MASK;
@@ -1365,10 +1362,11 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 
 	if (maxsize > i->count)
 		maxsize = i->count;
-	if (!maxsize)
+	if (!maxsize || !maxpages)
 		return 0;
 	if (maxsize > MAX_RW_COUNT)
 		maxsize = MAX_RW_COUNT;
+	BUG_ON(!pages);
 
 	if (likely(user_backed_iter(i))) {
 		unsigned int gup_flags = 0;
@@ -1441,9 +1439,6 @@ static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
 	size_t size = maxsize;
 	loff_t pos;
 
-	if (!size)
-		return 0;
-
 	pos = i->xarray_start + i->iov_offset;
 	index = pos >> PAGE_SHIFT;
 	offset = pos & ~PAGE_MASK;
-- 
2.30.2


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1710B5502F7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 07:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiFRFf5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 01:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiFRFfn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:35:43 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A16663D2
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 22:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Uam/EQkvc0qpNx+1Np581WJXf887kZ/fYiX2vKmjbnM=; b=o5zUQsGvoXS+Ft4AIrHTQ0GB8o
        4p3BK9shSFelc4xFqD6W4OU0v4gtyQRzRYvCVBVsQcL0CIRr6jgHCRL0+sLs3GRyn+MseR9SZd9Vi
        ZhL397At/OFZYtBH4ZkeQyv4bBoAOJVJm3xfOzd5maIhetk7QNE+RaLjJ6b56RJOx/vQP9dY9f6+o
        Bi0kQsZWawdfjsxFkf0Vay3HwaWyf8I94CJPN9U/3d6pAwqudqu7ynSRvxgOkBqcmpEw48eeBn01I
        j83T3/gDyBp9Gxk1VbIGY+9bclZy8S50wbdsPQn84qpoYS/6tIcm7NPRtR4XTqf2J9LnRndunSiJV
        n1iYOx+w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2R7V-001VQQ-2z;
        Sat, 18 Jun 2022 05:35:41 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 13/31] iov_iter_get_pages(): sanity-check arguments
Date:   Sat, 18 Jun 2022 06:35:20 +0100
Message-Id: <20220618053538.359065-14-viro@zeniv.linux.org.uk>
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

zero maxpages is bogus, but best treated as "just return 0";
NULL pages, OTOH, should be treated as a hard bug.

get rid of now completely useless checks in xarray_get_pages{,_alloc}().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f5e14535f6bb..369fbb10b16f 100644
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
+	if (!maxsize || maxpages)
 		return 0;
 	if (maxsize > LONG_MAX)
 		maxsize = LONG_MAX;
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


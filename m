Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A66550303
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 07:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbiFRFgV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 01:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbiFRFgC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:36:02 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CCB69285
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 22:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=KualK0se6TDI6VtHVUIPNHUiIRtKxDg34aQFE49/BSc=; b=PszVe/UnvCDALqYXyyGzHEP/fS
        Fjq8Jqe33XLGFIhP0HxdLJLVM6GFdYpZ665UQdG4i9j0XHbI1l/9b9WzBj5IIWCGZ6rQdZT7pHAF0
        +7We0wPkQ/D2pAHPd8pcGU+vFXe82zTP65GnODnTEtUJ3j+xTQ8bNwJmfzuTprcwJm6zjR+yjIGhk
        MEjDka8HfXoLH9f4iQsExcF4OznToa9jSoTuhAVC4IPsgadcEA+GX/OCKYWP79XEL7B4qd7Q4mrsE
        5vEN6XEfowtG/MMfH00pEC2hT9YYTXWhFviT2G4cYTKV0HZKq4BDsuxj1HLTRSdRoMfoQNh3q128S
        hXVNlftg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2R7Y-001VSH-2x;
        Sat, 18 Jun 2022 05:35:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 31/31] expand those iov_iter_advance()...
Date:   Sat, 18 Jun 2022 06:35:38 +0100
Message-Id: <20220618053538.359065-32-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 3306072c7b73..b50e264a14bf 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1279,7 +1279,8 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 		return 0;
 
 	maxsize = min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
-	iov_iter_advance(i, maxsize);
+	i->iov_offset += maxsize;
+	i->count -= maxsize;
 	return maxsize;
 }
 
@@ -1368,7 +1369,13 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		for (int k = 0; k < n; k++)
 			get_page(p[k] = page + k);
 		len = min_t(size_t, len, n * PAGE_SIZE - *start);
-		iov_iter_advance(i, len);
+		i->count -= len;
+		i->iov_offset += len;
+		if (i->iov_offset == i->bvec->bv_len) {
+			i->iov_offset = 0;
+			i->bvec++;
+			i->nr_segs--;
+		}
 		return len;
 	}
 	if (iov_iter_is_pipe(i))
-- 
2.30.2


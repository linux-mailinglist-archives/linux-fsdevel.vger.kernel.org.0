Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEC6554180
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356907AbiFVERH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356851AbiFVEQK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:16:10 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4556165A8
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=U4EtewnBFbTPEF12aprvcdvs76IRTF0XhXYK8SHtVQg=; b=gGubJ94ov4565wjcpkPfTWqPrq
        a0WAgUADlYT0dPHu+OUelNyZSQ1qwKMqhx4FlhlFPkyeqfYd8UrVbLmacxkuGqs0wGh48wq0PAry7
        LohvWnBzODELjclGsHNtKK9Nv5J7bOGbJU5PZ/J06/Ar1pwbmYZ50bU0uS7zkqONYFah0+pZFuX+T
        UfhuS5sc79oit78p27R9Fw/7mVg/c6SnYHSs6deN1Jo1A6hzDrooIhcCIc/O6zlSNHpXtUlaDuPxY
        +HQzrurMm/0HNdKkiGbA7H93wZAPkF3tb44APaMpfLwcPgnBdtg3vkYudK0S0jpqU78wA1fAtQZNU
        AK3FM9vg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rma-00360c-Qr;
        Wed, 22 Jun 2022 04:16:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 44/44] expand those iov_iter_advance()...
Date:   Wed, 22 Jun 2022 05:15:52 +0100
Message-Id: <20220622041552.737754-44-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index a8045c97b975..79c86add8dea 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1284,7 +1284,8 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 		return 0;
 
 	maxsize = min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
-	iov_iter_advance(i, maxsize);
+	i->iov_offset += maxsize;
+	i->count -= maxsize;
 	return maxsize;
 }
 
@@ -1373,7 +1374,13 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		for (int k = 0; k < n; k++)
 			get_page(p[k] = page + k);
 		maxsize = min_t(size_t, maxsize, n * PAGE_SIZE - *start);
-		iov_iter_advance(i, maxsize);
+		i->count -= maxsize;
+		i->iov_offset += maxsize;
+		if (i->iov_offset == i->bvec->bv_len) {
+			i->iov_offset = 0;
+			i->bvec++;
+			i->nr_segs--;
+		}
 		return maxsize;
 	}
 	if (iov_iter_is_pipe(i))
-- 
2.30.2


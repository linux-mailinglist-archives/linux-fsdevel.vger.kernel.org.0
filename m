Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB1E1F0AD2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jun 2020 12:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgFGKfm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jun 2020 06:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgFGKfm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jun 2020 06:35:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDA4C08C5C2;
        Sun,  7 Jun 2020 03:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=AYYj5832c2GT+ytDAH77UfTxdHbmCP2yBkk1Z1c11/k=; b=SoflgbrD1vufhyAmI578bvTMpp
        ZxX+243nditxsT5hSgCH5w2f1xRuy0yJhgW2J/do85wQK8RSXqBnV1Q9gbus4Rot5RuFBAAAH5KAo
        QKet4OFzlpAls5UKjqrjK+6ZGvoqAnHy2NvWa5a6YrRNartkdf6UODgoABld7jQxIzZHoylxsqUPe
        Khc11Z/CH4MNClX6DgFnVQPtnKJD6VtAnPnUp4fnG0sGSj4zDPaBQza8Hijd+lA7SxtA4hc5mWJGO
        UY2XXV5QnXFMeP+HkHDQZyGybSCiGYTwhcQnb32mGlO6QkCOufCvhwj8QvLywcf1tJ9DtouqjfJZy
        0fNogjGQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhseQ-0007VI-Cd; Sun, 07 Jun 2020 10:35:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] iomap: Fix unsharing of an extent >2GB on a 32-bit machine
Date:   Sun,  7 Jun 2020 03:35:36 -0700
Message-Id: <20200607103536.26508-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Widen the type used for counting the number of bytes unshared.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ae6c5e38f0e8..9f90d2394535 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -909,7 +909,7 @@ iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		struct iomap *iomap, struct iomap *srcmap)
 {
 	long status = 0;
-	ssize_t written = 0;
+	loff_t written = 0;
 
 	/* don't bother with blocks that are not shared to start with */
 	if (!(iomap->flags & IOMAP_F_SHARED))
-- 
2.26.2


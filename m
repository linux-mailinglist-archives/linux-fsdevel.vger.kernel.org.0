Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C44E290931
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 18:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410565AbgJPQEt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 12:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410445AbgJPQEs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:04:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363CCC061755
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 09:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DjEv8CInt3MYIbFFccwff33IuqhKVtai0GAjHHJ41BQ=; b=ryk51nkbiVP/20QOSjU8LYKNch
        D3PuNSHHPjrUvGPushpNdbD4bliIpUDtJv+akKDXqH0Xy8GzFQ9209dtg3xKcESUSPpxQ6kdrr6/P
        iWjyDNAWmUiE0NLKaHJBsX8SPbR6V/4hSnXjMESHP4FZ9C+dHPLuPeT+nbrWaSmx3tmzXMyd+6K7I
        SeUPXtxJkcTK7Zu2dPWxhpp7sN78NkE7o1nQgfRSny2QeZXGFK31GiWqLGByf/YtzDnO5amp14uff
        7eettvMERGlcEAavRUHdw1Su0huwcDEJOct5aoA4HTdYh6bQlVNMUmFKeBTatnD2+E5yeaCEuGAZA
        O7kiJ8Lw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTSDm-0004sj-Hq; Fri, 16 Oct 2020 16:04:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 07/18] ceph: Tell the VFS that readpage was synchronous
Date:   Fri, 16 Oct 2020 17:04:32 +0100
Message-Id: <20201016160443.18685-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016160443.18685-1-willy@infradead.org>
References: <20201016160443.18685-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The ceph readpage implementation was already synchronous, so use
AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 6ea761c84494..b2bf8bf7a312 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -291,10 +291,11 @@ static int ceph_do_readpage(struct file *filp, struct page *page)
 static int ceph_readpage(struct file *filp, struct page *page)
 {
 	int r = ceph_do_readpage(filp, page);
-	if (r != -EINPROGRESS)
-		unlock_page(page);
-	else
-		r = 0;
+	if (r == -EINPROGRESS)
+		return 0;
+	if (r == 0)
+		return AOP_UPDATED_PAGE;
+	unlock_page(page);
 	return r;
 }
 
-- 
2.28.0


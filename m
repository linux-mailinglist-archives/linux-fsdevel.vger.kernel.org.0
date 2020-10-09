Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7453F288B41
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 16:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388838AbgJIObK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 10:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388809AbgJIObJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:31:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BDFC0613D5;
        Fri,  9 Oct 2020 07:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DjEv8CInt3MYIbFFccwff33IuqhKVtai0GAjHHJ41BQ=; b=JW4Gc9od+Mrkhab3EyAvAknH83
        AW53PAKcYzPA+CmJOYzoLgQFQo8nB2vg+coN2AVXTs2hOHMwvd70FQFXDmM/k+fPp0HKyM8ybNI/H
        A6AtPZO/F1fJfyFd4J0Xgb3EihjJtXEZMWxkIVnmvAzE20VzfPz5n9/ZtrfZAAKpKkIePgVKo6v47
        rYrdHyLEraZ9rhUmB8oLmjgXf0Jdjs/2gFZqaAMmRgUGsSPTu0bLP/mIvlOyJuzJqyodO/39j9V7A
        /hWxXgMY8lCwtZ7kjj32duEzgvzfYEpQi0AcfUHgouHmYUSyFcDY2BYQwjNI/hssVp+UutS8wjCQ+
        TFqwUUmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQtQJ-0005up-H7; Fri, 09 Oct 2020 14:31:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        ecryptfs@vger.kernel.org, linux-um@lists.infradead.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        linux-xfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 05/16] ceph: Tell the VFS that readpage was synchronous
Date:   Fri,  9 Oct 2020 15:30:53 +0100
Message-Id: <20201009143104.22673-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201009143104.22673-1-willy@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
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


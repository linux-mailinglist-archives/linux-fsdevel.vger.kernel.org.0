Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF67C26E567
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 21:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgIQPOA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 11:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbgIQPL0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:11:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACDDC06178C;
        Thu, 17 Sep 2020 08:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7u5VAtMiRg84eQRBFRLzhqfSMq0woXu9gI0XciTFBfo=; b=lom2Li8CD5jx4y8HUW5Lgpotel
        g5sgTa8o84FBY6eD9XZnsMogJwTzS0kX7EHBuY/49XLLZXSR4wLmhLgOb8JW7CscVwWQrnNwBAKHr
        j7CVV6g0cXwc+nGT4AIAJA808eU22SNJ9CBJ/8/F5v+XL4rlYVow3XW0/atXcL99l5y8iFAwKj/g+
        r1932WK61SVY5dsFLtPsuy1gB3GgM9VZRVr0L9vl//Vxq3aoPu9AzJ+ux9mTb8dBZaYYreEY0dZiz
        NENBckd2xTM7maqIO9KDD3crOW0EjJfYim3RWyi8WUGUkvbBfG6gSWZUH/7Wnm/yCfVKjLrOOaE5P
        raCfhwcw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIvYj-0001Pi-5U; Thu, 17 Sep 2020 15:10:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        ecryptfs@vger.kernel.org, linux-um@lists.infradead.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 05/13] cifs: Tell the VFS that readpage was synchronous
Date:   Thu, 17 Sep 2020 16:10:42 +0100
Message-Id: <20200917151050.5363-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200917151050.5363-1-willy@infradead.org>
References: <20200917151050.5363-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The cifs readpage implementation was already synchronous, so use
AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/cifs/file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index be46fab4c96d..533b151a9143 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4537,7 +4537,8 @@ static int cifs_readpage_worker(struct file *file, struct page *page,
 	/* send this page to the cache */
 	cifs_readpage_to_fscache(file_inode(file), page);
 
-	rc = 0;
+	kunmap(page);
+	return AOP_UPDATED_PAGE;
 
 io_error:
 	kunmap(page);
@@ -4677,7 +4678,10 @@ static int cifs_write_begin(struct file *file, struct address_space *mapping,
 		 * an error, we don't need to return it. cifs_write_end will
 		 * do a sync write instead since PG_uptodate isn't set.
 		 */
-		cifs_readpage_worker(file, page, &page_start);
+		int err = cifs_readpage_worker(file, page, &page_start);
+
+		if (err == AOP_UPDATED_PAGE)
+			goto out;
 		put_page(page);
 		oncethru = 1;
 		goto start;
-- 
2.28.0


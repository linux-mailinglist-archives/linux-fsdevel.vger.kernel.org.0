Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFC9288B38
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 16:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388955AbgJIObq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 10:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388864AbgJIObN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:31:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC02C0613DA;
        Fri,  9 Oct 2020 07:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SoeUdKTgaEeumdsHlwEayshKcw/8MedETPawI1HuSQI=; b=vWd51sgqlxnfp2VOy655iSPs7z
        O3YkCDgMjxBBloGOOAyS5rpH8ieyr5e2l00AoQXyAkQJcIgVPKmM8fw3iN+FOvohdpNNdF6z/0pqF
        bp8HoW5MuOgRmDF4wNnN9jL3xi01IwTUf2Tb6/HpU3NddbL2wVRj2jJkzDxTn1ZXZAlih7iR44Onz
        rMN0Q1O5nZdQHWhvkkADFCX0st7PTr2AThI5WXcAa/gjWkasoCrEA/9lZ6Z6LKADj4nYQn0KMq568
        ZmEdQ9R42qymHkjUJojR8GhpzZYfcFFaRC7tayMNDeFSp0hwGDpPiUJliLMgzyBK6kmXFjt7axxT3
        2I0MWCpA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQtQM-0005w1-KN; Fri, 09 Oct 2020 14:31:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        ecryptfs@vger.kernel.org, linux-um@lists.infradead.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        linux-xfs@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 13/16] udf: Tell the VFS that readpage was synchronous
Date:   Fri,  9 Oct 2020 15:31:01 +0100
Message-Id: <20201009143104.22673-14-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201009143104.22673-1-willy@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The udf inline data readpage implementation was already synchronous,
so use AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/udf/file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/udf/file.c b/fs/udf/file.c
index 628941a6b79a..52bbe92d7c43 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -61,9 +61,8 @@ static int udf_adinicb_readpage(struct file *file, struct page *page)
 {
 	BUG_ON(!PageLocked(page));
 	__udf_adinicb_readpage(page);
-	unlock_page(page);
 
-	return 0;
+	return AOP_UPDATED_PAGE;
 }
 
 static int udf_adinicb_writepage(struct page *page,
-- 
2.28.0


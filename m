Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47162820A4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Oct 2020 04:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgJCCzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 22:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgJCCzj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 22:55:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE8BC0613E2
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2020 19:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JjGPXD4WVwInpllMxZ87nv5UuquIpx8q4seK29XyhNo=; b=SjQF1AUsX7EdWWnCG4xYzOMhi6
        Hgg9H4bJZEE2e/xgkyxQWBQmARpcBcta8f4ZxIL6LNh/dCnIqtfjTRtU6plWafK2rAQ3MKiUVZCXI
        il/n6ngzv8MVcCahhbDHgOJaCEC9Hc+bpns5XtrK9ebnI7CPkzPnbGWlvWxWeg8jqKhH5scAKn6g0
        fPw2ErIC/J4GJDTFSazTQkeiaEg3wo5QSFwbXi3ZqH6VMwZiJvR+KZdskGFe2YK6s7QfCwH4usUiN
        4madwA7I9NQIx5UfbgvFT4mRMsJ0/YSqAcYQVjyqTUD4OyawIZiMrRUCdDTAABkWPFbZg/kP6M+fv
        JM+synvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOXhx-0005VJ-AS; Sat, 03 Oct 2020 02:55:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/13] binfmt_flat: Pass a NULL pointer to kernel_read
Date:   Sat,  3 Oct 2020 03:55:28 +0100
Message-Id: <20201003025534.21045-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201003025534.21045-1-willy@infradead.org>
References: <20201003025534.21045-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We want to start at 0 and do not care about the updated value.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/binfmt_flat.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index f2f9086ebe98..b3f525be0a1a 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -891,7 +891,6 @@ static int load_flat_shared_library(int id, struct lib_info *libs)
 	struct linux_binprm bprm;
 	int res;
 	char buf[16];
-	loff_t pos = 0;
 
 	memset(&bprm, 0, sizeof(bprm));
 
@@ -905,7 +904,7 @@ static int load_flat_shared_library(int id, struct lib_info *libs)
 	if (IS_ERR(bprm.file))
 		return res;
 
-	res = kernel_read(bprm.file, bprm.buf, BINPRM_BUF_SIZE, &pos);
+	res = kernel_read(bprm.file, bprm.buf, BINPRM_BUF_SIZE, NULL);
 
 	if (res >= 0)
 		res = load_flat_file(&bprm, libs, id, NULL);
-- 
2.28.0


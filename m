Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BE126DFEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 17:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgIQPPY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 11:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbgIQPLm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:11:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A06C06121E;
        Thu, 17 Sep 2020 08:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=On43e4GnGO79fh9MGOiH3t2swuO0c44z7mV7G3PjPdg=; b=JpgNMgAMtP37e2z1ODJoACSlyK
        ZQFRFUMyW6V2MeLhpTmyJAeub1VQHVFoEFbrpdAuEICFyc0AHXjewrnjzRXfMEuzWL7E+dyYGabyd
        A1RS7Tonh20I00pQtRnWsnK+nfLGfgwVuwmiwJCERV56YcrH+xTkJxvoSXyxbudjVRNVQZQPsJGDw
        /GSHYP46vWHoYPnjADmCSGZO9olC+ksUnB6Jcrds+VDufa4bFLZCIQpaFfLSIplfPdvT9nrFF6G4U
        PHAGD4QvI88MFyYVX2M35YIWXErf0ffDTV1XoWhrPUUGdig34Sj0jR3s2VZV69Z9EMEt8hjqRRV1T
        zvgKjiwA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIvYi-0001PW-ND; Thu, 17 Sep 2020 15:10:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        ecryptfs@vger.kernel.org, linux-um@lists.infradead.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 03/13] afs: Tell the VFS that readpage was synchronous
Date:   Thu, 17 Sep 2020 16:10:40 +0100
Message-Id: <20200917151050.5363-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200917151050.5363-1-willy@infradead.org>
References: <20200917151050.5363-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The afs readpage implementation was already synchronous, so use
AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/afs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 6f6ed1605cfe..8f15305b6574 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -367,7 +367,8 @@ int afs_page_filler(void *data, struct page *page)
 			BUG_ON(PageFsCache(page));
 		}
 #endif
-		unlock_page(page);
+		_leave(" = AOP_UPDATED_PAGE");
+		return AOP_UPDATED_PAGE;
 	}
 
 	_leave(" = 0");
-- 
2.28.0


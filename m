Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0A7DAAAD5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 20:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389859AbfIESXv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 14:23:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34308 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389827AbfIESXv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 14:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LKUiBNu62lGmhyWv6FBhdsxxt3Gohyu4Oappg0jQS50=; b=d6WylP3ncbyOTDyizq27EEdpE
        D0TxFudh5JMyplHfsisMFB5yciYIFD5ANr268oaWVnBhwn9vfdR7EPsUOyu+mWQv7NycKbIEGPGEw
        +aDmWE00s54BVbTZu1z3XkCrPyKt1y5FA3PQWfHEISoO51DcWnHhHS32qJkZBnMMX1XYBmd82jIIl
        M1xWSHoLlxt8Wpo85IbYl2GoHcfs/WIOcPVGKnrLJw1QVPgC5/NIZcTQT3AaxzUd9GbmQZkmHdIVR
        bUgtYW2BA06zGFeY+ty9x9n16bl2oF47saflW+5XzkY3dm1yruqZU06UolTu8kUJfO5iLcPQxI3o1
        S/53ISTTw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5wQA-0001Tu-8A; Thu, 05 Sep 2019 18:23:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kirill Shutemov <kirill@shutemov.name>,
        Song Liu <songliubraving@fb.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <jweiner@fb.com>
Subject: [PATCH 0/3] Large pages in the page cache
Date:   Thu,  5 Sep 2019 11:23:45 -0700
Message-Id: <20190905182348.5319-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Michael Hocko's reaction to Bill's implementation of filemap_huge_fault
was "convoluted so much I cannot wrap my head around it".  This spurred me
to finish up something I'd been working on in the background prompted by
Kirill's desire to be able to allocate large page cache pages in paths
other than the fault handler.

This is in no sense complete as there's nothing in this patch series
which actually uses FGP_PMD.  It should remove a lot of the complexity
from a future filemap_huge_fault() implementation and make it possible
to allocate larger pages in the read/write paths in future.

Matthew Wilcox (Oracle) (3):
  mm: Add __page_cache_alloc_order
  mm: Allow large pages to be added to the page cache
  mm: Allow find_get_page to be used for large pages

 include/linux/pagemap.h |  23 ++++++-
 mm/filemap.c            | 132 +++++++++++++++++++++++++++++++++-------
 2 files changed, 130 insertions(+), 25 deletions(-)

-- 
2.23.0.rc1


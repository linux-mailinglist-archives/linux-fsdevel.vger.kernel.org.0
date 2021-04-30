Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A34136FCEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 16:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhD3O53 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 10:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhD3O5Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:57:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3860C06138C
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 07:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=4H/NVeuEe9ZS7PaoKsofKAniVZEi0kya5rGXMaDHauc=; b=pHbQBF9F3UbmeAznbYPiU5w9wF
        lo28rlEnBS5t3Mgg91OL2XQHe5dwNLawETkCTGiHSxUS3n4azyv1Bla3b1kirtsp7QlmhgZckpZJb
        rpVK5RqVxXuJUUkvRt4BXWh/KhhCpXtbICJRaqYvnJhc5JjVs8OSCO+xGWzteCeKrlxU6qU6FD43c
        xrKPO4jkoKEXnde6kXASRPzLR7roTlGL21EU0TaHBO+pFW9s7PDG5VnlQTXoJ3XA9HM01mG9D9uAm
        FX+sJefwfkChy9hSMkeMuihp/OmyFIx0sija3uFLDnRwfWTMVltaGTfv5MhpyIeeHZolMAGyDiNs8
        o7Cgl/Yw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcUYZ-00BAbx-BT; Fri, 30 Apr 2021 14:56:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 0/8] Folio Prequel patches
Date:   Fri, 30 Apr 2021 15:55:41 +0100
Message-Id: <20210430145549.2662354-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These patches have all been posted before and not picked up yet.  I've
built the folio patches on top of them; while they are not necessarily
prerequisites in the conceptual sense, I'm not convinced that the
folio patches will build without them.  The nth_page patch is purely an
efficiency question, while patch 5 ("Make compound_head const-preserving")
is required for the current implementation of page_folio().  Patch 8
("Fix struct page layout on 32-bit systems") is required for the struct
folio layout to match struct page layout on said 32-bit systems (arm,
mips, ppc).

They are on top of next-20210430

Matthew Wilcox (Oracle) (8):
  mm: Optimise nth_page for contiguous memmap
  mm: Make __dump_page static
  mm/debug: Factor PagePoisoned out of __dump_page
  mm/page_owner: Constify dump_page_owner
  mm: Make compound_head const-preserving
  mm: Constify get_pfnblock_flags_mask and get_pfnblock_migratetype
  mm: Constify page_count and page_ref_count
  mm: Fix struct page layout on 32-bit systems

 include/linux/mm.h              |  4 ++++
 include/linux/mm_types.h        |  4 ++--
 include/linux/mmdebug.h         |  3 +--
 include/linux/page-flags.h      | 10 +++++-----
 include/linux/page_owner.h      |  6 +++---
 include/linux/page_ref.h        |  4 ++--
 include/linux/pageblock-flags.h |  2 +-
 include/net/page_pool.h         | 12 +++++++++++-
 mm/debug.c                      | 25 +++++++------------------
 mm/page_alloc.c                 | 16 ++++++++--------
 mm/page_owner.c                 |  2 +-
 net/core/page_pool.c            | 12 +++++++-----
 12 files changed, 52 insertions(+), 48 deletions(-)

-- 
2.30.2


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4281529955A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 19:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789822AbgJZSbm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 14:31:42 -0400
Received: from casper.infradead.org ([90.155.50.34]:47244 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1784911AbgJZSbm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=xwCRlu/FqYYqdemZEGDlGFIbaRMKFrKG9ZNgKJ/NHrY=; b=wChICW7WItkxeMJYhDXYvuqV8N
        P2ESXDhfwmSzRRfBhVhKyEK4P7LNNoRHzX44iV1YCFPdNSHhPjkaCjJUzGOZtYHFzuW1KAFoj/VaP
        QI3TDSNokQ3oAofcie+vDJKbX/nobn+YCbw55RI3wX75Y6rxPRP7vwcEsm1YZxyfSSbbcRU5kj2++
        lK6e3vHS5z+a28kiOk5j054x82uJRSryg+mHrWiuCN+f/qGWvqWp2edJ7kPP0adypF1Fz9lmEqOdk
        ocnizNh1UlBRHR3Ry67JKOq31fv30Vu47yRvDGf4RPiCtGBaUePggiY0u0pNLHYPNO2FQ0JMjMWTi
        ZHshATGA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX7HQ-0002jC-SJ; Mon, 26 Oct 2020 18:31:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/9] More THP fixes
Date:   Mon, 26 Oct 2020 18:31:27 +0000
Message-Id: <20201026183136.10404-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm not sure there's a common thread to this set of THP patches other
than I think they're pretty uncontroversial.  Maybe I'm wrong.

Matthew Wilcox (Oracle) (8):
  mm: Support THPs in zero_user_segments
  mm/page-flags: Allow accessing PageError on tail pages
  mm: Return head pages from grab_cache_page_write_begin
  mm: Replace prep_transhuge_page with thp_prep
  mm/truncate: Make invalidate_inode_pages2_range work with THPs
  mm/truncate: Fix invalidate_complete_page2 for THPs
  mm/vmscan: Free non-shmem THPs without splitting them
  mm: Fix READ_ONLY_THP warning

Zi Yan (1):
  mm: Fix THP size assumption in mem_cgroup_split_huge_fixup

 include/linux/highmem.h    | 19 +++++++++---
 include/linux/huge_mm.h    |  7 +++--
 include/linux/page-flags.h |  3 +-
 include/linux/pagemap.h    |  4 +--
 mm/filemap.c               | 15 ++++++---
 mm/highmem.c               | 62 ++++++++++++++++++++++++++++++++++++--
 mm/huge_memory.c           | 12 +++++---
 mm/internal.h              |  1 +
 mm/khugepaged.c            | 12 ++------
 mm/memcontrol.c            |  2 +-
 mm/mempolicy.c             | 15 +++------
 mm/migrate.c               | 15 +++------
 mm/page-writeback.c        |  2 +-
 mm/shmem.c                 |  9 +++---
 mm/truncate.c              | 25 ++++++---------
 mm/vmscan.c                |  4 +--
 16 files changed, 132 insertions(+), 75 deletions(-)

-- 
2.28.0


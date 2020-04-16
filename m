Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129BE1AD27D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 00:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgDPWBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 18:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728720AbgDPWBd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:01:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFBAC03C1A6;
        Thu, 16 Apr 2020 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=14Ju6mOxlL9LJIOW/FTdgj6GivNAEkcDFvA+NJF0hh4=; b=JYt02rkpIxLfSksSlE8uemCZJq
        N29XAVZHY7OEQvLCJGet9/lu5zO/JUGTcdn00BySeshPpZCf/rvt9a7GTwJLh6H1xxB5LRy+QyGPZ
        BW2AFaaBs1sem3PR6wwbngwpAztHsiQKTqy/R4L79NzCmct41xrxivbxMO7w0ZxV0ToiMGIbKnvMc
        0G7gWn4xcHuLLox0Q8llw7ntoQ1JNfa4wv2md27c7fC/btqps3kYVlOAJXoqIebqSAsIjWbrpG9uo
        e1Yhwm0NNyim/bJtFBeTOmOQME265mnMLU9/9JVkpFsFi9XCHklAD9kSxEzpIsNYum1HMA/pfVxwO
        NZXY37Hw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPCZg-0003U8-Ca; Thu, 16 Apr 2020 22:01:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: [PATCH v3 00/11] Make PageWriteback use the PageLocked optimisation
Date:   Thu, 16 Apr 2020 15:01:19 -0700
Message-Id: <20200416220130.13343-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

PageWaiters is used by PageWriteback and PageLocked (and no other page
flags), so it makes sense to use the same codepaths that have already been
optimised for PageLocked, even if there's probably no real performance
benefit to be had.

Unfortunately, clear_bit_unlock_is_negative_byte() isn't present on every
architecture, and the default implementation is only available in filemap.c
while I want to use it in page-writeback.c.  Rather than move the default
implementation to a header file, I've done optimised implementations for
alpha and ia64.  I can't figure out optimised implementations for m68k,
mips, riscv and s390, so I've just replicated the effect of the generic
implementation in them.  I leave it to the experts to fix that (... or
convert over to using asm-generic/bitops/lock.h ...)

v3:
 - Added implementations of clear_bit_unlock_is_negative_byte()
   to architectures which need it

v2: Rebased to 5.7-rc1
 - Split up patches better
 - Moved the BUG() from end_page_writeback() to __clear_page_writeback()
   as requested by Jan Kara.
 - Converted the BUG() to WARN_ON()
 - Removed TestClearPageWriteback

Matthew Wilcox (Oracle) (11):
  alpha: Add clear_bit_unlock_is_negative_byte implementation
  ia64: Add clear_bit_unlock_is_negative_byte implementation
  m68k: Add clear_bit_unlock_is_negative_byte implementation
  mips: Add clear_bit_unlock_is_negative_byte implementation
  riscv: Add clear_bit_unlock_is_negative_byte implementation
  s390: Add clear_bit_unlock_is_negative_byte implementation
  mm: Remove definition of clear_bit_unlock_is_negative_byte
  mm: Move PG_writeback into the bottom byte
  mm: Convert writeback BUG to WARN_ON
  mm: Use clear_bit_unlock_is_negative_byte for PageWriteback
  mm: Remove TestClearPageWriteback

 arch/alpha/include/asm/bitops.h | 23 ++++++++++++++++++
 arch/ia64/include/asm/bitops.h  | 20 ++++++++++++++++
 arch/m68k/include/asm/bitops.h  |  7 ++++++
 arch/mips/include/asm/bitops.h  |  7 ++++++
 arch/riscv/include/asm/bitops.h |  7 ++++++
 arch/s390/include/asm/bitops.h  |  9 +++++++
 include/linux/page-flags.h      |  8 +++----
 mm/filemap.c                    | 41 ++++----------------------------
 mm/page-writeback.c             | 42 ++++++++++++++++++++-------------
 9 files changed, 107 insertions(+), 57 deletions(-)

-- 
2.25.1

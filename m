Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74451ACB5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 17:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895889AbgDPPqT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 11:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895874AbgDPPqH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:46:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B799C061A0C
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2020 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=if4ORID+BxVDq4S2B7nn9PXXtWXd/o102VgOQcmpw40=; b=auKzbnWNJpIH6JqYDBJsrlYgBS
        xEQm82w18D1/XvtXaVXhK6bWl+6Iqb8z30NItNvIzf9qZNlSTnB0gvsIVMqycltcuCTyEGq7iMcT3
        jgUQUH/eUnWE5BBJ/PWPr4Ksu/5orKT6K7ddLJUBWW6wxgIjh+4KTF6uHLPKg9Wh7o8H/wxNE4XMe
        6cUL25vIQfR4FrHr6Y+8uT5cg64QYywWImyKO80Hi7cvdDWka1sh3IVrzICgt99n5+uAh7jzvBKOz
        dX/ZPriBXO+nli7INbWqndzPBhWb1+O9m/Uear8s2Py92832mN6OfOJeAUufZ9E7ucUwoSytvzIe9
        ZZy1xjLg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP6iN-00006K-Cp; Thu, 16 Apr 2020 15:46:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v2 0/5] Make PageWriteback use the PageLocked optimisation
Date:   Thu, 16 Apr 2020 08:46:01 -0700
Message-Id: <20200416154606.306-1-willy@infradead.org>
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

v2: Rebased to 5.7-rc1
 - Split up patches better
 - Moved the BUG() from end_page_writeback() to __clear_page_writeback()
   as requested by Jan Kara.
 - Converted the BUG() to WARN_ON()
 - Removed TestClearPageWriteback

Matthew Wilcox (Oracle) (5):
  mm: Remove definition of clear_bit_unlock_is_negative_byte
  mm: Move PG_writeback into the bottom byte
  mm: Convert writeback BUG to WARN_ON
  mm: Use clear_bit_unlock_is_negative_byte for PageWriteback
  mm: Remove TestClearPageWriteback

 include/linux/page-flags.h |  8 ++++----
 mm/filemap.c               | 41 +++++--------------------------------
 mm/page-writeback.c        | 42 +++++++++++++++++++++++---------------
 3 files changed, 34 insertions(+), 57 deletions(-)

-- 
2.25.1


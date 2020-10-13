Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8570D28C76C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 05:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgJMDAM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 23:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgJMDAM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 23:00:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE36BC0613D0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2020 20:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=bet5k8jZJNCIYtyLuGWqsrFsH6VgfcTRiIk5ksLeT9A=; b=j02dSIENrMLe0mE57phMNWV/82
        PFF/zTfEqcYLzFfFifHHoapFKVgTrLD1jAQEnkh3zcrl8lPKubHdKUXtJWd5IihpyFrv0uMe4NOHu
        YNH1YbPP1USYuJyvOnsZeOf4p81gPDoDo+UbKmSo+5itwSjFUhRoz94ruEbMfiYH6TsY0sFVdgWlz
        qCEAJlv9bJjaF6vgkf0FDs/BREd41/vhLS7+dxzbWFCAWgDmG/yRv1XF/Yy5Ff3DMqZE4+Jbewywc
        Qjr2J1QO8PCvIqjKxjVaeWRuXRsq5UTpITZO9g5csSQ96QTWXioEcHINa0iyUul9/qR2Kmz3I7i5v
        U6CB2w4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSAXp-00075i-F8; Tue, 13 Oct 2020 03:00:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/3] Wait for I/O without holding a page reference
Date:   Tue, 13 Oct 2020 04:00:04 +0100
Message-Id: <20201013030008.27219-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The upcoming THP patchset keeps THPs Uptodate at all times unless we
hit an I/O error.  So I have a patch which induces I/O errors in 10%
of readahead I/Os in order to test the fallback path.  It hits a
problem with xfstests generic/273 which has 500 threads livelocking
trying to split the THP.  This patchset fixes that livelock and
takes 21 lines out of generic_file_buffered_read().

Matthew Wilcox (Oracle) (3):
  mm: Pass a sleep state to put_and_wait_on_page_locked
  mm/filemap: Don't hold a page reference while waiting for unlock
  mm: Inline __wait_on_page_locked_async into caller

 include/linux/pagemap.h |   3 +-
 mm/filemap.c            | 129 +++++++++++++++-------------------------
 mm/huge_memory.c        |   4 +-
 mm/migrate.c            |   4 +-
 4 files changed, 52 insertions(+), 88 deletions(-)

-- 
2.28.0


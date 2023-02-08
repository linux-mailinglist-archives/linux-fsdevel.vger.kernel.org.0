Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A0668F143
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 15:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjBHOxn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 09:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjBHOxm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:53:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C82526E;
        Wed,  8 Feb 2023 06:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=iwap63tRQpLRz1M3/ZH39JjKxVVpflQtFW/BwxqhOgI=; b=nk1wMNlQPmB6GXz+8FfahMBPMo
        xJjjzpA41i+Mye5NI5sJbdbNS4E9EwujoRG4PYyeABybVxhDhyxHRPKiysBGRjiNtzRHj+5zhCcrC
        NQ2oizqIFFcYsvoH/jqrPKqb5Pwo7G8HkCFUHn04DO37Bdj1Tc2sAElT4RxbnPtClno/GQVE5Wx7/
        H7FmMcyql3WN3JkMALp+1zeh12iQT0BuENO9LS7/uBviL8yQzolhjAVa6jSWTojfdA9i1nmENaKSb
        dgP04+QG32U4JDravRhuh5m99cAuUOVGghcakhq9tp2rJore+2YLiaO+aQAWNL4RGgEy78rT7MSNI
        U5R55aGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPlpK-001HwP-PM; Wed, 08 Feb 2023 14:53:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 0/3] Prevent ->map_pages from sleeping
Date:   Wed,  8 Feb 2023 14:53:32 +0000
Message-Id: <20230208145335.307287-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for a larger patch series which will handle (some, easy)
page faults protected only by RCU, change the two filesystems which have
sleeping locks to not take them and hold the RCU lock around calls to
->map_page to prevent other filesystems from adding sleeping locks.

Matthew Wilcox (Oracle) (3):
  xfs: Remove xfs_filemap_map_pages() wrapper
  afs: Split afs_pagecache_valid() out of afs_validate()
  mm: Hold the RCU read lock over calls to ->map_pages

 Documentation/filesystems/locking.rst |  4 ++--
 fs/afs/file.c                         | 14 ++------------
 fs/afs/inode.c                        | 27 +++++++++++++++++++--------
 fs/afs/internal.h                     |  1 +
 fs/xfs/xfs_file.c                     | 17 +----------------
 mm/memory.c                           |  7 ++++++-
 6 files changed, 31 insertions(+), 39 deletions(-)

-- 
2.35.1


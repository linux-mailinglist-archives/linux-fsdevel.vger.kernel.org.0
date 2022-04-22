Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83A650C16E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 00:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiDVWFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 18:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiDVWFT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:05:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2580028882D;
        Fri, 22 Apr 2022 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=xXTvDwOshNmT8k01EPNDMJ5Vw4kyttJnV4C5HkjVHmo=; b=lCmZiJ8f6r3JpHX3G3metcapt8
        xV/Jn2baI6NQYvOMdGiNgfDE6/xKNgCmL8vwrKdToESpCiIN+gsKnLE5j2RGxM/BQFTKT62V3nFNf
        mPEPSroSRU1lDTsbdNyblCuqxC+3zilX9wO8dUnOJ43e0lJcEm1jDfZ1XCjYWK1YmqK/O2DjeiB1F
        4Tmn+LR6z0JzsxcQCneFR8nbvo6y6Qs/IuRa3YZUOSm1uETCaqkP4BHbUBiodTiXb+0SBO02zCTvo
        t4GCrb8YCdrXSpW0/5wr3ATe8ttg7m4XNetMC9fq7qLv+CF+dCAuUVORKWHoiZdD+UqmQcMljJ6dF
        0c8w/GkA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhzDj-006MHK-On; Fri, 22 Apr 2022 19:45:35 +0000
Date:   Fri, 22 Apr 2022 20:45:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [GIT PULL] Rare page cache data corruption fix
Message-ID: <YmMF32RlCn2asAhc@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Syzbot found a nasty race between large page splitting and page lookup.
Details in the commit log, but fortunately it has a reliable reproducer.
I thought it better to send this one to you straight away.

The other commit fixes the test suite build, again.

The following changes since commit 281b9d9a4b02229b602a14f7540206b0fbe4134f:

  Merge branch 'akpm' (patches from Andrew) (2022-04-22 10:10:43 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/willy/xarray.git tags/xarray-5.18a

for you to fetch changes up to 63b1898fffcd8bd81905b95104ecc52b45a97e21:

  XArray: Disallow sibling entries of nodes (2022-04-22 15:35:40 -0400)

----------------------------------------------------------------
XArray: Two fixes for 5.18

 - Fix the test suite build for kmem_cache_alloc_lru()

 - Fix a rare race between split and load

----------------------------------------------------------------
Matthew Wilcox (Oracle) (2):
      tools: Add kmem_cache_alloc_lru()
      XArray: Disallow sibling entries of nodes

 lib/xarray.c                     | 2 ++
 tools/include/linux/slab.h       | 8 +++++++-
 tools/testing/radix-tree/linux.c | 3 ++-
 3 files changed, 11 insertions(+), 2 deletions(-)


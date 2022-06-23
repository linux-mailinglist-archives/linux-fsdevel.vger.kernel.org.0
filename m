Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9130558021
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 18:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiFWQm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 12:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiFWQmp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:42:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECB749911;
        Thu, 23 Jun 2022 09:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZNJjmbuEFB+xE7zO2XCavODcPuKBf6BJxSUuwq7uUcI=; b=sPcn8pTVVFWGlDT37HvjMHED6M
        J0MkK513JyB5BQr6/RBi6LVOviCaMYgBt2SwSAiJJ//gGJLN4nOMsTWVGScIcXQ9Fo6wi1272ndPM
        7jVVj5GXuVWSF00NA+UEV100f6KRkfP6RelLOYAyShOy3U6tkp+Mn6kFEtd8ix1K26wM/NnXrLAtg
        8zNxnVsULjG9+PwQ2pUGT14H/I16nfF7D8H5nXzOZuzNgvDK4kkPvAUQyS7PQO6fuNEizXR9ogmUi
        O6U/9EKkTs29EmBcru+A54BMavVs0z7dCZSOS7QmGTOB7HVqd4CshkVS+XSLRCS0cu1cS4pcOn+i6
        16u96kWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4Pui-0080gy-Vn; Thu, 23 Jun 2022 16:42:41 +0000
Date:   Thu, 23 Jun 2022 17:42:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Pagecache fixes for 5.19-rc4
Message-ID: <YrSYAKtoRrrgayrZ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 78ca55889a549a9a194c6ec666836329b774ab6d:

  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2022-06-20 09:35:04 -0500)

are available in the Git repository at:

  git://git.infradead.org/users/willy/pagecache.git tags/folio-5.19b

for you to fetch changes up to 00fa15e0d56482e32d8ca1f51d76b0ee00afb16b:

  filemap: Fix serialization adding transparent huge pages to page cache (2022-06-23 12:22:00 -0400)

----------------------------------------------------------------
Four folio-related fixes for 5.19:

 - Mark a folio accessed at the right time (Yu Kuai)

 - Fix a race for folios being replaced in the middle of a read (Brian Foster)

 - Clear folio->private in more places (Xiubo Li)

 - Take the invalidate_lock in page_cache_ra_order() (Alistair Popple)

----------------------------------------------------------------
Alistair Popple (1):
      filemap: Fix serialization adding transparent huge pages to page cache

Matthew Wilcox (Oracle) (3):
      filemap: Correct the conditions for marking a folio as accessed
      filemap: Handle sibling entries in filemap_get_read_batch()
      mm: Clear page->private when splitting or migrating a page

 mm/filemap.c     | 15 ++++++++++++---
 mm/huge_memory.c |  1 +
 mm/migrate.c     |  1 +
 mm/readahead.c   |  2 ++
 4 files changed, 16 insertions(+), 3 deletions(-)


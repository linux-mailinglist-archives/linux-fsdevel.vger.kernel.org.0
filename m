Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3673596203
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 20:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbiHPSJo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 14:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236930AbiHPSJW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:09:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58241844D9
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 11:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZLVKIcawwkKrSnDsopp6RkAn4EyYL3MBfq6ZuhD3+gI=; b=UkXUvIXjDF+1pfxUv5fy1JSXO7
        bcq6a8trV7/S0PONXw7o7vRw0w4ebA3F9xgbyl7LSPkuiFnlqZDSqtK2bOnQgLVgCDGUJ53/rhz8x
        Jv5jd2uAOB0X8obDVYONd/Qtr8V+2/DkBJ4FwxV3TaIIpyPFrhPeN8Pge/t3lQyplSUfPYcm02SK1
        kCdnb9VE+HpqosR/uTHhxktNTcqBAACkKcLEmm5MBIl3ZHuG+VEkCw6OT+ARI08jNPqB/kbB4+uUQ
        DZmDVg/u/ntCbnSxkDLeq7LquAxG7S80qmqMtm7rlr2tEQP3Z2spDw8Jgr+Ic7C3T1YXgbxPkuNoL
        2x8BAoQQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oO0zG-007DBe-Ni; Tue, 16 Aug 2022 18:08:22 +0000
Date:   Tue, 16 Aug 2022 19:08:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: folio_map
Message-ID: <YvvdFrtiW33UOkGr@casper.infradead.org>
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

Some of you will already know all this, but I'll go into a certain amount
of detail for the peanut gallery.

One of the problems that people want to solve with multi-page folios
is supporting filesystem block sizes > PAGE_SIZE.  Such filesystems
already exist; you can happily create a 64kB block size filesystem on
a PPC/ARM/... today, then fail to mount it on an x86 machine.

kmap_local_folio() only lets you map a single page from a folio.
This works for the majority of cases (eg ->write_begin() works on a
per-page basis *anyway*, so we can just map a single page from the folio).
But this is somewhat hampering for ext2_get_page(), used for directory
handling.  A directory record may cross a page boundary (because it
wasn't a page boundary on the machine which created the filesystem),
and juggling two pages being mapped at once is tricky with the stack
model for kmap_local.

I don't particularly want to invest heavily in optimising for HIGHMEM.
The number of machines which will use multi-page folios and HIGHMEM is
not going to be large, one hopes, as 64-bit kernels are far more common.
I'm happy for 32-bit to be slow, as long as it works.

For these reasons, I proposing the logical equivalent to this:

+void *folio_map_local(struct folio *folio)
+{
+       if (!IS_ENABLED(CONFIG_HIGHMEM))
+               return folio_address(folio);
+       if (!folio_test_large(folio))
+               return kmap_local_page(&folio->page);
+       return vmap_folio(folio);
+}
+
+void folio_unmap_local(const void *addr)
+{
+       if (!IS_ENABLED(CONFIG_HIGHMEM))
+               return;
+       if (is_vmalloc_addr(addr))
+               vunmap(addr);
+	else
+       	kunmap_local(addr);
+}

(where vmap_folio() is a new function that works a lot like vmap(),
chunks of this get moved out-of-line, etc, etc., but this concept)

Does anyone have any better ideas?  If it'd be easy to map N pages
locally, for example ... looks like we only support up to 16 pages
mapped per CPU at any time, so mapping all of a 64kB folio would
almost always fail, and even mapping a 32kB folio would be unlikely
to succeed.


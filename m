Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389B8738BF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 18:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjFUQq3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 12:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFUQqU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:46:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AE419AF;
        Wed, 21 Jun 2023 09:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=gPF8zQQSIHiKU2e2Ly4ej0SDtpoejzkFWwWEYtBtv+s=; b=R6XCM2zV5SdOXGzdC4zN24TUJT
        M4veWjCAPq0VNUMCOXwK50bgiMz71O8YN/hsbWICKjaGBn0L/hOi6O3vzf8WibWLHu9fl3oQnQsny
        VGKEA7Ik15shC5pM7bj5sOsWEZqfwMVm1w/UApf/gyrXm2EOIwgAe4VVVX5iq6/R6BNzAkxe/vJHh
        XJoF4JmL38Rj6+7jZjgWTJ1XxMEElaDGBPXE4ET31k0NcLCnoFJ3RJwwdIo3TnQpnX9h+isSLIe6j
        JkTmNrRbvZfY6wvO0Tfw3qOS6OftxBxHLANWzL3TPle2V4DyHE+CsN5B7LgFifpOLmUjM6a7p9apc
        NtFA7iFA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qC0y1-00EjDe-6y; Wed, 21 Jun 2023 16:46:01 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 00/13] Remove pagevecs
Date:   Wed, 21 Jun 2023 17:45:44 +0100
Message-Id: <20230621164557.3510324-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We're almost done with the pagevec -> folio_batch conversion.  Finish
the job.

Matthew Wilcox (Oracle) (13):
  afs: Convert pagevec to folio_batch in afs_extend_writeback()
  mm: Add __folio_batch_release()
  scatterlist: Add sg_set_folio()
  i915: Convert shmem_sg_free_table() to use a folio_batch
  drm: Convert drm_gem_put_pages() to use a folio_batch
  mm: Remove check_move_unevictable_pages()
  pagevec: Rename fbatch_count()
  i915: Convert i915_gpu_error to use a folio_batch
  net: Convert sunrpc from pagevec to folio_batch
  mm: Remove struct pagevec
  mm: Rename invalidate_mapping_pagevec to mapping_try_invalidate
  mm: Remove references to pagevec
  mm: Remove unnecessary pagevec includes

 drivers/gpu/drm/drm_gem.c                 | 68 +++++++++++++----------
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 55 ++++++++++--------
 drivers/gpu/drm/i915/i915_gpu_error.c     | 50 ++++++++---------
 fs/afs/write.c                            | 16 +++---
 include/linux/pagevec.h                   | 67 +++-------------------
 include/linux/scatterlist.h               | 24 ++++++++
 include/linux/sunrpc/svc.h                |  2 +-
 include/linux/swap.h                      |  1 -
 mm/fadvise.c                              | 17 +++---
 mm/huge_memory.c                          |  2 +-
 mm/internal.h                             |  4 +-
 mm/khugepaged.c                           |  6 +-
 mm/ksm.c                                  |  6 +-
 mm/memory.c                               |  6 +-
 mm/memory_hotplug.c                       |  1 -
 mm/migrate.c                              |  1 -
 mm/migrate_device.c                       |  2 +-
 mm/readahead.c                            |  1 -
 mm/swap.c                                 | 20 +++----
 mm/swap_state.c                           |  1 -
 mm/truncate.c                             | 27 +++++----
 mm/vmscan.c                               | 17 ------
 net/sunrpc/svc.c                          | 10 ++--
 23 files changed, 185 insertions(+), 219 deletions(-)

-- 
2.39.2


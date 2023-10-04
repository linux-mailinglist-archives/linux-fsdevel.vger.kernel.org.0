Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7B87B85D9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 18:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243581AbjJDQyK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 12:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243522AbjJDQxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:53:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B470A7;
        Wed,  4 Oct 2023 09:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=LwA3p5YQj5OgBPSUkutIowOVEGM0rG3Lj5ULCLty+YM=; b=JRt10tJuArdHNRRYBWcWAKTL3L
        5qoqHs+L3muErMYTGOiagRQEu5W1rLCQDiFr3Iwo196Be3buwEBHUBuhyJ2lkzSo5boAHD6BpdQHv
        kqco3WhNwcfQdxHLgIKr6jj1hCDFmwbEOi7zalI+OyPKeGZXwcyxU39WAzL3812ODwKoz8UIhx/vv
        o61fvI+j3BZ7GT/v6+KeSDyP9XVgSoWDWfOCSoQLKWZ0jA4gDvO0Oce/vZbGPFASGWxPj7GtcqhGH
        SzFZ2r52dVlmq2d4eN2U6+hmOI9Y86s4spZlVWUiqtlfz7/s5/BMdU/trJw0lt93QR3U5OocxHR28
        nsv+z4xA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qo57f-004SEr-45; Wed, 04 Oct 2023 16:53:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, torvalds@linux-foundation.org,
        npiggin@gmail.com
Subject: [PATCH v2 00/17] Add folio_end_read
Date:   Wed,  4 Oct 2023 17:53:00 +0100
Message-Id: <20231004165317.1061855-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The core of this patchset is the new folio_end_read() call which
filesystems can use when finishing a page cache read instead of separate
calls to mark the folio uptodate and unlock it.  As an illustration of
its use, I converted ext4, iomap & mpage; more can be converted.

I think that's useful by itself, but the interesting optimisation is
that we can implement that with a single XOR instruction that sets the
uptodate bit, clears the lock bit, tests the waiter bit and provides a
write memory barrier.  That removes one memory barrier and one atomic
instruction from each page read, which seems worth doing.  That's in
patch 15.

The last two patches could be a separate series, but basically we can do
the same thing with the writeback flag that we do with the unlock flag;
clear it and test the waiters bit at the same time.

v2:
 - Update to 6.6-rc4
 - Simplify iomap's use of folio_end_read() as suggested by Linus
 - Fix weird Alpha assembly, as suggested by Linus
 - Implement xor_unlock_is_negative_byte for Coldfire
 - Add a likely() to folio_end_read() after studying the Coldfire assembly

Matthew Wilcox (Oracle) (17):
  iomap: Hold state_lock over call to ifs_set_range_uptodate()
  iomap: Protect read_bytes_pending with the state_lock
  mm: Add folio_end_read()
  ext4: Use folio_end_read()
  buffer: Use folio_end_read()
  iomap: Use folio_end_read()
  bitops: Add xor_unlock_is_negative_byte()
  alpha: Implement xor_unlock_is_negative_byte
  m68k: Implement xor_unlock_is_negative_byte
  mips: Implement xor_unlock_is_negative_byte
  powerpc: Implement arch_xor_unlock_is_negative_byte on 32-bit
  riscv: Implement xor_unlock_is_negative_byte
  s390: Implement arch_xor_unlock_is_negative_byte
  mm: Delete checks for xor_unlock_is_negative_byte()
  mm: Add folio_xor_flags_has_waiters()
  mm: Make __end_folio_writeback() return void
  mm: Use folio_xor_flags_has_waiters() in folio_end_writeback()

 arch/alpha/include/asm/bitops.h               | 20 +++++
 arch/m68k/include/asm/bitops.h                | 21 +++++
 arch/mips/include/asm/bitops.h                | 25 +++++-
 arch/mips/lib/bitops.c                        | 14 ++++
 arch/powerpc/include/asm/bitops.h             | 21 ++---
 arch/riscv/include/asm/bitops.h               | 12 +++
 arch/s390/include/asm/bitops.h                | 10 +++
 arch/x86/include/asm/bitops.h                 | 11 ++-
 fs/buffer.c                                   | 16 +---
 fs/ext4/readpage.c                            | 14 +---
 fs/iomap/buffered-io.c                        | 57 ++++++++------
 .../asm-generic/bitops/instrumented-lock.h    | 28 ++++---
 include/asm-generic/bitops/lock.h             | 20 +----
 include/linux/page-flags.h                    | 19 +++++
 include/linux/pagemap.h                       |  1 +
 kernel/kcsan/kcsan_test.c                     |  9 +--
 kernel/kcsan/selftest.c                       |  9 +--
 mm/filemap.c                                  | 77 ++++++++++---------
 mm/kasan/kasan_test.c                         |  8 +-
 mm/page-writeback.c                           | 35 ++++-----
 20 files changed, 255 insertions(+), 172 deletions(-)

-- 
2.40.1


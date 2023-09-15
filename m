Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F40B7A2610
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbjIOSiT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbjIOShr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:37:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736281BD3;
        Fri, 15 Sep 2023 11:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=JjdcCeARBetsZH137aFl33BJ3ii6NFAsip2SWa5M3tY=; b=p17pTr3se0JO/f6M04cDpPtP+5
        K/0tbeZ6PTE1lD28UmJtDp+MmcL/fkV6rpoqjooMTaFiT6A+wiZNO3LfFsTW0EJg0CtGJ3T2Htj7q
        2vPlqyDoipOOe5joiIo8yawKYHtz72l/cRIJRH1Y7fKZZaXRjPnL96TuNG3d7I5exwb2fOz2bdJZx
        hrZHp1wcxwHcn37XwnLC4Q98HIXkwl0RW4mQtwsuzJZ06on3fs6Qb0d6uUwUI1wZ+FxH8pQT4w73L
        qS3WAWId/CoC7Q2weH7Kr/MQIOEamN7K1gZKEzWnitOC6RJa5VvnCInxTb738HTzJvu/bfYYBYciq
        GcGIN+Ig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhDgi-00BMIL-Vs; Fri, 15 Sep 2023 18:37:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        torvalds@linux-foundation.org, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 00/17] Add folio_end_read
Date:   Fri, 15 Sep 2023 19:36:50 +0100
Message-Id: <20230915183707.2707298-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

I don't have any performance numbers; I'm hoping Nick might provide some
since PPC seems particularly unhappy with write-after-write hazards.

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
 arch/m68k/include/asm/bitops.h                | 13 ++++
 arch/mips/include/asm/bitops.h                | 25 +++++-
 arch/mips/lib/bitops.c                        | 14 ++++
 arch/powerpc/include/asm/bitops.h             | 21 ++---
 arch/riscv/include/asm/bitops.h               | 12 +++
 arch/s390/include/asm/bitops.h                | 10 +++
 arch/x86/include/asm/bitops.h                 | 11 ++-
 fs/buffer.c                                   | 16 +---
 fs/ext4/readpage.c                            | 14 +---
 fs/iomap/buffered-io.c                        | 55 ++++++++-----
 .../asm-generic/bitops/instrumented-lock.h    | 28 ++++---
 include/asm-generic/bitops/lock.h             | 20 +----
 include/linux/page-flags.h                    | 19 +++++
 include/linux/pagemap.h                       |  1 +
 kernel/kcsan/kcsan_test.c                     |  9 +--
 kernel/kcsan/selftest.c                       |  9 +--
 mm/filemap.c                                  | 77 ++++++++++---------
 mm/kasan/kasan_test.c                         |  8 +-
 mm/page-writeback.c                           | 35 ++++-----
 20 files changed, 248 insertions(+), 169 deletions(-)

-- 
2.40.1


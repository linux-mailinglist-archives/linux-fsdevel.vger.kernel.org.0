Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D594A471EF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 01:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhLMAG5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Dec 2021 19:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhLMAGw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Dec 2021 19:06:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0ABC06173F;
        Sun, 12 Dec 2021 16:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=0/ZSeD2g9sHV3CBi2MWygycQsl1GshpalXb84wvvZ1g=; b=NgBcLYQkdEZIozaqZuceqlvHGH
        ZCCyK4gc6K95hW2sZuGlrI3BGOtc1RY3ujpuGiVlROJ9kzTdts+noh9XCLrb5HP7vwsUhpiDjwtXe
        +wmq0x70oTDMEjZ8oMBjXxCPIWiiPdfLUrz3Jzy1Z/Txut7IEzVLqh9nhtTpOkg0IJmok9sG98V3T
        82etjIYRG4Z8XwIAsxaDmKoKLaGW63c6AjKINiR0HSCv/xzzyctC/jnTUC3B09DuBZzv+VWWv3FnU
        GBMkDXN1vFs61dNJOpFrOFs6chFMKDvxqleTPOM+QTDGtT9JDL7nK4l1Pmio0Q58pgWhNwHO1uJsk
        6sz+yQHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwYrW-00CIuE-1G; Mon, 13 Dec 2021 00:06:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/3] Convert vmcore to use an iov_iter
Date:   Mon, 13 Dec 2021 00:06:33 +0000
Message-Id: <20211213000636.2932569-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For some reason several people have been sending bad patches to fix
compiler warnings in vmcore recently.  Here's how it should be done.
Compile-tested only on x86.  As noted in the first patch, s390 should
take this conversion a bit further, but I'm not inclined to do that
work myself.

Matthew Wilcox (Oracle) (3):
  vmcore: Convert copy_oldmem_page() to take an iov_iter
  vmcore: Convert __read_vmcore to use an iov_iter
  vmcore: Convert read_from_oldmem() to take an iov_iter

 arch/arm/kernel/crash_dump.c     |  14 +---
 arch/arm64/kernel/crash_dump.c   |  14 +---
 arch/ia64/kernel/crash_dump.c    |  12 +--
 arch/mips/kernel/crash_dump.c    |  13 +---
 arch/powerpc/kernel/crash_dump.c |  20 +----
 arch/riscv/kernel/crash_dump.c   |  13 +---
 arch/s390/kernel/crash_dump.c    |  12 +--
 arch/sh/kernel/crash_dump.c      |  15 +---
 arch/x86/kernel/crash_dump_32.c  |  13 +---
 arch/x86/kernel/crash_dump_64.c  |  31 ++++----
 fs/proc/vmcore.c                 | 130 +++++++++++++------------------
 include/linux/crash_dump.h       |  19 ++---
 12 files changed, 112 insertions(+), 194 deletions(-)

-- 
2.33.0


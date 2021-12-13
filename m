Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29748472F85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 15:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbhLMOjj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 09:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239566AbhLMOjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:39:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88929C061574;
        Mon, 13 Dec 2021 06:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Eaxby4ZP6wqT6b6KH+03ESE20UThQFGmFtzG+Def2X0=; b=IeKgVkyUcFahThpVUlvLL8GgKT
        sJ+WYuHBzqqFdd+3j4eCDMRjsU5EJu3avgswaPALtjGrZiXGV137Ab5nhCH5QprU1M3+hzoN9YroM
        iSiwu7nv5nkDnxT+Rn9PiUYye6KQ9oUswv4+BBXxq/gdHtQZlcvMCC3BaOqeLsgc42mXfuYG9KHH5
        inKCSWHPR4ZQnD1pZySEjrsWF1I9dDK90ZpUAsXrqedon5AlpJ8Grn7rkXYsElHcNQlrXw4dARzDS
        mNkj6vbMDbwKmzNf2N7eWcuT0j+zIt80nFyGhuYBA6Kyyzs5tZnQ1a94jgHEMrdiUQQOKFILBvhgo
        /69Yeong==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwmUC-00CsXK-47; Mon, 13 Dec 2021 14:39:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/3] Convert vmcore to use an iov_iter
Date:   Mon, 13 Dec 2021 14:39:24 +0000
Message-Id: <20211213143927.3069508-1-willy@infradead.org>
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

v3:
 - Send the correct patches this time
v2:
 - Removed unnecessary kernel-doc
 - Included uio.h to fix compilation problems
 - Made read_from_oldmem_iter static to avoid compile warnings during the
   conversion
 - Use iov_iter_truncate() (Christoph)

Matthew Wilcox (Oracle) (3):
  vmcore: Convert copy_oldmem_page() to take an iov_iter
  vmcore: Convert __read_vmcore to use an iov_iter
  vmcore: Convert read_from_oldmem() to take an iov_iter

 arch/arm/kernel/crash_dump.c     |  27 +------
 arch/arm64/kernel/crash_dump.c   |  29 +------
 arch/ia64/kernel/crash_dump.c    |  32 +-------
 arch/mips/kernel/crash_dump.c    |  27 +------
 arch/powerpc/kernel/crash_dump.c |  35 ++-------
 arch/riscv/kernel/crash_dump.c   |  26 +------
 arch/s390/kernel/crash_dump.c    |  13 ++--
 arch/sh/kernel/crash_dump.c      |  29 ++-----
 arch/x86/kernel/crash_dump_32.c  |  29 +------
 arch/x86/kernel/crash_dump_64.c  |  48 ++++--------
 fs/proc/vmcore.c                 | 129 +++++++++++++------------------
 include/linux/crash_dump.h       |  19 ++---
 12 files changed, 122 insertions(+), 321 deletions(-)

-- 
2.33.0


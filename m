Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDE4373E1B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 17:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhEEPIz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 11:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbhEEPIy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 11:08:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF5DC061574;
        Wed,  5 May 2021 08:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hBpQR/0D3JnfgszdRdi1IhKjYmrqMJy8CCih3IT3ePo=; b=qIlhenN55SYdUaLUwpXFQa4Lvx
        AlZiLLKgmBfGYEWkIFBMaOP2k5v1vfs4hmxqE0t6FsWrQ+gLV8EJB2+BIU+v2KfG1lJbV8gD1nwlN
        pKb/Hd3S27b4Dqxvy4W+ag4ORb/7eDpFBjGUuBv4FKRBH1/Zwjr1UFvHBIyrMpzEWYOFc1GY5cPaf
        7UFQIg+KdcYaxXFvZquza5EA/IINkXOIQqsI4Rq8qS5XzmeZOry5pM6aEyTxH375R8/AjZcSW55lu
        OD+U0dSdIgOPxZDBiOazq5WROJ5dZ4EfgtA9u2KzVWa0F3XTq3krZUuNlFhnlMZkOOfuMmHFO+POK
        P3N3vy/A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leJ6x-000T5S-7E; Wed, 05 May 2021 15:06:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH v9 01/96] mm: Optimise nth_page for contiguous memmap
Date:   Wed,  5 May 2021 16:04:53 +0100
Message-Id: <20210505150628.111735-2-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the memmap is virtually contiguous (either because we're using
a virtually mapped memmap or because we don't support a discontig
memmap at all), then we can implement nth_page() by simple addition.
Contrary to popular belief, the compiler is not able to optimise this
itself for a vmemmap configuration.  This reduces one example user (sg.c)
by four instructions:

        struct page *page = nth_page(rsv_schp->pages[k], offset >> PAGE_SHIFT);

before:
   49 8b 45 70             mov    0x70(%r13),%rax
   48 63 c9                movslq %ecx,%rcx
   48 c1 eb 0c             shr    $0xc,%rbx
   48 8b 04 c8             mov    (%rax,%rcx,8),%rax
   48 2b 05 00 00 00 00    sub    0x0(%rip),%rax
           R_X86_64_PC32      vmemmap_base-0x4
   48 c1 f8 06             sar    $0x6,%rax
   48 01 d8                add    %rbx,%rax
   48 c1 e0 06             shl    $0x6,%rax
   48 03 05 00 00 00 00    add    0x0(%rip),%rax
           R_X86_64_PC32      vmemmap_base-0x4

after:
   49 8b 45 70             mov    0x70(%r13),%rax
   48 63 c9                movslq %ecx,%rcx
   48 c1 eb 0c             shr    $0xc,%rbx
   48 c1 e3 06             shl    $0x6,%rbx
   48 03 1c c8             add    (%rax,%rcx,8),%rbx

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/mm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 25b9041f9925..2327f99b121f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -234,7 +234,11 @@ int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
 int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
 		pgoff_t index, gfp_t gfp, void **shadowp);
 
+#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
+#else
+#define nth_page(page,n) ((page) + (n))
+#endif
 
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr) ALIGN(addr, PAGE_SIZE)
-- 
2.30.2


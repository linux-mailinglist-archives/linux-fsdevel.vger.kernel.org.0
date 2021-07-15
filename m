Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C663CA17A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 17:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbhGOPcr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 11:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbhGOPcr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 11:32:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A93C06175F;
        Thu, 15 Jul 2021 08:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hm/c5pmmDO4cb+/t3JiroPJ98SJwa1APyoXE5DC9x/M=; b=r3e0mnboQeEh+ByrdjioLrSrjX
        I767N2xaNAyFXjjyt+IpOzqNNTpnJXtN+sWuyHrGpwccnizqcloUpZGec0w8EuN99Om4h+K0YCipS
        LkVHUX3OPHuc5XGn7edNy3uB8j/Y/FOyUgZqxE3KSsuQvzeytuDNn5VvP+D5o0zwoVLGzrWrctqV0
        23+0Ac7Y0vMjLMhw0bAq8JyFNLmCxehP4XNoVxDZ6hGwryjS0F6brM8jVOCyBLDVdktQRBFY/lNsw
        SSMDdyBnPPH0gPT0xc5AD69QLN7rOiwFXjsF6VvTH6KtmHAqZbrKwHipYFXFbVg6R3kls6uZ3zWtT
        V9AB7y4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m43Ii-003TTK-Cg; Thu, 15 Jul 2021 15:29:30 +0000
Date:   Thu, 15 Jul 2021 16:29:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kbuild-all@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 102/138] iomap: Convert iomap_write_begin and
 iomap_write_end to folios
Message-ID: <YPBUVLmutOHejK9z@casper.infradead.org>
References: <20210715033704.692967-103-willy@infradead.org>
 <202107152112.MqBfMXMK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202107152112.MqBfMXMK-lkp@intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 09:53:26PM +0800, kernel test robot wrote:
> >> fs/iomap/buffered-io.c:645:2: error: implicit declaration of function 'flush_dcache_folio' [-Werror,-Wimplicit-function-declaration]
>            flush_dcache_folio(folio);

Thanks.  ARM doesn't include asm-generic/cacheflush.h so it needs
flush_dcache_folio() declared.  Adding this:

+++ b/arch/arm/include/asm/cacheflush.h
@@ -290,6 +290,7 @@ extern void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr
  */
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 extern void flush_dcache_page(struct page *);
+void flush_dcache_folio(struct folio *folio);

 static inline void flush_kernel_vmap_range(void *addr, int size)
 {




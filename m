Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C1B46BF2E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 16:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbhLGPZA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 10:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbhLGPY7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:24:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CF3C061574;
        Tue,  7 Dec 2021 07:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2G4sRuPvASvykdf+RGVh/2mIPuDGyjKFYNtqvJW5YbM=; b=TJMN7qGXhOyJAf6ImL+1cj1WMU
        iCqFS+lv8r1i9byGRIhDXENs7YBeBrRiCPVMdeQQnQb6GtYRIF//czqEfQY6ZpbJdd7nLeTyARYZ7
        Je9FQd89oAqelj1J8R0ypJ15ydaneWyPMob5Sin/bkD7xmrPGNw5RnXvaHoy5zAbPciNm86MZpEtG
        w6HtpoJMFwgYjwGx/JubZ5/jmXB1NgnkfBUNvEllFM/aMSPj15CEntTE5ppQHa3b58p/tqS68WuNp
        GHd53UnvVhfLURRf0XVTCJci4SSCrsAmzsCPrdHK3PKyq52TIxSsM/T+zdYOM06X2zv6cZijeIr5V
        v9Hpl1YQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mucHU-007Th6-3V; Tue, 07 Dec 2021 15:21:24 +0000
Date:   Tue, 7 Dec 2021 15:21:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, kernelci@groups.io,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [RFC 1/3] headers: add more types to linux/types.h
Message-ID: <Ya979Hh0V2CdhNSU@casper.infradead.org>
References: <20211207150927.3042197-1-arnd@kernel.org>
 <20211207150927.3042197-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207150927.3042197-2-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 07, 2021 at 04:09:25PM +0100, Arnd Bergmann wrote:
> +struct list_lru {
> +	struct list_lru_node	*node;
> +#ifdef CONFIG_MEMCG_KMEM
> +	struct list_head	list;
> +	int			shrinker_id;
> +	bool			memcg_aware;
> +#endif
> +};

This is the only one that gives me qualms.  While there are other
CONFIG options mentioned in types.h they're properties of the platform,
eg CONFIG_HAVE_UID16, CONFIG_64BIT, CONFIG_ARCH_DMA_ADDR_T_64BIT, etc.
I dislike it that changing this CONFIG option is going to result in
rebuilding the _entire_ kernel.  CONFIG_MEMCG_KMEM just isn't that
central to how everything works.

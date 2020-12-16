Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9C12DC89A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 23:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbgLPWBo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 17:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729840AbgLPWBo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 17:01:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF473C061794;
        Wed, 16 Dec 2020 14:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ytTtA1pALsETtIdSlU2w2vhrdzWxtF525/d1jU/Olhk=; b=OQkDQdH5oa7t9KfGEUOOkn/7wF
        csKPl20Zi97hVOEgPUOkonLH7r0yJsPh15fKEEJaZwhwusE22H4ajnaZlnArkECHS9yjyyXBctJ1g
        UH9Ez31bSdeOnlkfRRumx6yYLXHKEyazefcQsWkq3m+xZOjqFxeqbtG7OO99lElWCuUsvCReeFqro
        Qgc+wnoKZE4xrJ+F9DmTVYh4PRv5MNLSqPTIv2JZyXVoJEiyZTNd4o6lrOzldOo1RXeIdMhGbYLKN
        l93vPP6ee2QUMMq4FTdWqUb3D74+tFIWfkVsjEgkvi3LJUUlrGbvX61qoEvuWiHd6sD/Yqb6fk+YZ
        iu+fQmDg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpeqy-000365-QT; Wed, 16 Dec 2020 22:01:00 +0000
Date:   Wed, 16 Dec 2020 22:01:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/25] mm: Add flush_dcache_folio
Message-ID: <20201216220100.GY2443@casper.infradead.org>
References: <20201216182335.27227-24-willy@infradead.org>
 <202012170425.x32aFRjm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202012170425.x32aFRjm-lkp@intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 04:59:21AM +0800, kernel test robot wrote:
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/powerpc/include/asm/cacheflush.h:111,
>                     from include/linux/highmem.h:12,
>                     from include/linux/pagemap.h:11,
>                     from include/linux/blkdev.h:14,
>                     from include/linux/blk-cgroup.h:23,
>                     from include/linux/writeback.h:14,
>                     from include/linux/memcontrol.h:22,
>                     from include/linux/swap.h:9,
>                     from include/linux/suspend.h:5,
>                     from arch/powerpc/kernel/asm-offsets.c:23:
>    include/asm-generic/cacheflush.h: In function 'flush_dcache_folio':
> >> include/asm-generic/cacheflush.h:64:33: error: subscripted value is neither array nor pointer nor vector
>       64 |   flush_dcache_page(&folio->page[--n]);

Thanks.  Apparently I need to compile on more than just x86 ;-)

This compiles on aargh64:

@@ -61,7 +61,8 @@ static inline void flush_dcache_folio(struct folio *folio)
        unsigned int n = folio_nr_pages(folio);
 
        do {
-               flush_dcache_page(&folio->page[--n]);
+               n--;
+               flush_dcache_page(&folio->page + n);
        } while (n);
 }
 #endif

I'll fold it into my git tree.

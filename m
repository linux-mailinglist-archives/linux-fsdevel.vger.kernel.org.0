Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FEE3D2352
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 14:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhGVLtD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 07:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhGVLtB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 07:49:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12894C061575;
        Thu, 22 Jul 2021 05:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DuSfqtaB0ngelOfdPmwtHOFsvbwzQU43s1iPkHHgCOY=; b=CDPU7rS/r6RC9X60DZY0bTR79W
        zIFexzbAW2kV9TU/9XbHoiexUXWiZT1hykYMmfIMhvX1mJTlQh366sK9lpd3i86gxVGxb0ufBm3b7
        2qNeKbSZ2ja7YL6n51uzmTQJUA+5QhQQxo8LJtcMJz2mAh8yMZVqyvAWG6X9OdztWndDIWtnKDemx
        chUzbyio2/e41hNSItYXb2oBbreXQyy1Zq24ax2bzgjP95UCdsqZ9nb3wQ5XdGWFbIUWCauu0vD9n
        xy0DRyPigMH30VY8/82/twMp7dVLWjUr7cgFgx+9N0HDzEMHO2FdVYIvC61RqdJ24OLl0/dONb9LW
        6Avt9wgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6XpL-00AFNu-Uy; Thu, 22 Jul 2021 12:29:29 +0000
Date:   Thu, 22 Jul 2021 13:29:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v14 062/138] mm/migrate: Add folio_migrate_copy()
Message-ID: <YPlko1ObxD/CEz8o@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-63-willy@infradead.org>
 <a670e7c1-95fb-324f-055f-74dd4c81c0d0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a670e7c1-95fb-324f-055f-74dd4c81c0d0@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 22, 2021 at 02:52:28PM +0300, Dmitry Osipenko wrote:
> I'm getting warnings that might be related to this patch.

Thank you!  This is a good report.  I've trimmed away some of the
unnecessary bits from below:

> BUG: sleeping function called from invalid context at mm/util.c:761
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 29, name: kcompactd0

This is absolutely a result of this patch:

        for (i = 0; i < nr; i++) {
                cond_resched();
                copy_highpage(folio_page(dst, i), folio_page(src, i));
        }

cond_resched() can sleep, of course.  This is new; previously only
copying huge pages would call cond_resched().  Now every page copy
calls cond_resched().

> (___might_sleep) from (folio_copy+0x3f/0x84)
> (folio_copy) from (folio_migrate_copy+0x11/0x1c)
> (folio_migrate_copy) from (__buffer_migrate_page.part.0+0x215/0x238)
> (__buffer_migrate_page.part.0) from (buffer_migrate_page_norefs+0x19/0x28)

__buffer_migrate_page() is where we become atomic:

        if (check_refs)
                spin_lock(&mapping->private_lock);
...
                migrate_page_copy(newpage, page);
...
        if (check_refs)
                spin_unlock(&mapping->private_lock);

> (buffer_migrate_page_norefs) from (move_to_new_page+0x4d/0x200)
> (move_to_new_page) from (migrate_pages+0x521/0x72c)
> (migrate_pages) from (compact_zone+0x589/0xb60)

The obvious solution is just to change folio_copy():

 {
-       unsigned i, nr = folio_nr_pages(src);
+       unsigned i = 0;
+       unsigned nr = folio_nr_pages(src);

-       for (i = 0; i < nr; i++) {
-               cond_resched();
+       for (;;) {
                copy_highpage(folio_page(dst, i), folio_page(src, i));
+               if (i++ == nr)
+                       break;
+               cond_resched();
        }
 }

now it only calls cond_resched() for multi-page folios.

But that leaves us with a bit of an ... impediment to using multi-page
folios for buffer-head based filesystems (and block devices).  I must
admit to not knowing the buffer_head locking scheme quite as well as
I would like to.  Is it possible to drop this spinlock earlier?

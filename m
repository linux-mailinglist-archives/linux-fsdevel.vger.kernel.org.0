Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8465447C6BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 19:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241405AbhLUSk3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 13:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbhLUSk2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:40:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C454C061574;
        Tue, 21 Dec 2021 10:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IohrmZmNU3Hl56vOk9dfj8ea6Zz8qMj/ReZu4s25uUo=; b=hRMP29RPHdi28VGviekLkzmWh4
        shpCgk95knF0M5RALNqOEJKYvvPUnmgWGXmjOVOqo1pvKNvXdotnDNIExTk/h77OtZjVWAQKW/qkm
        R+YWMjerPJlaOqxqpJoWzSecSJW83CmdbWgKfORTu8mpuY6HzbgDrzw5Wr3R/LF7JwIjcUhRlYIAF
        PJKRIsGADeUXf5Y/1Au9vWH+YD4K06bl3nHpsB4/Lo+RsdmpQCkLJY90CvUugZH1VUdAUUWUiq1/K
        E4gP4tfBGq9RLmgXNa7vrAVybtpAEbP5A67uJTOjykV7Xol0H11Ll6p6nFeNFHDGiO/Npq3l1ubw0
        G4Nj4heA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzk3b-002ivi-Tc; Tue, 21 Dec 2021 18:40:15 +0000
Date:   Tue, 21 Dec 2021 18:40:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     syzbot <syzbot+1f52b3a18d5633fa7f82@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        chinwen.chang@mediatek.com, fgheet255t@gmail.com,
        Jann Horn <jannh@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs@googlegroups.com, tonymarislogistics@yandex.com,
        Vlastimil Babka <vbabka@suse.cz>, walken@google.com,
        Zi Yan <ziy@nvidia.com>
Subject: Re: [syzbot] kernel BUG in __page_mapcount
Message-ID: <YcIfj3nfuL0kzkFO@casper.infradead.org>
References: <00000000000017977605c395a751@google.com>
 <0000000000009411bb05d3ab468f@google.com>
 <CAHbLzkoU_giAFiOyhHZvxLT9Vie2-8TmQv_XLDpRxbec5r5weg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkoU_giAFiOyhHZvxLT9Vie2-8TmQv_XLDpRxbec5r5weg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 21, 2021 at 10:24:27AM -0800, Yang Shi wrote:
> It seems the THP is split during smaps walk. The reproducer does call
> MADV_FREE on partial THP which may split the huge page.
> 
> The below fix (untested) should be able to fix it.

Did you read the rest of the thread on this?  If the page is being
migrated, we should still account it ... also, you've changed the
refcount, so this:

        if (page_count(page) == 1) {
                smaps_page_accumulate(mss, page, size, size << PSS_SHIFT, dirty,
                        locked, true);
                return;
        }

will never trigger.

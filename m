Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7E73FDCFF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 15:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbhIANC5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 09:02:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344530AbhIAM7k (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 08:59:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53C5360F23;
        Wed,  1 Sep 2021 12:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630501123;
        bh=Fs+Ei850S/AfoXruaZpaxBAI0iXC8n1giB7EbO3rJOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hlHStViLm82AieCjlQ46Lrn2UwKHUxLtsmClsGnjxYRfnQXXD0Cr+m1obtcWVRCHE
         NyvGl2K0GNeWXci3i2flnId7bgYcRxv1ebOmm/UJEuqDwjVJDzDSKKKOqFbqA8ncX6
         Ux/CtirmtcVQyrOyeYxJne4Vl1Zr3M9sK1/hVAqouPZhA48uBQFE1Vb44FiZLw3mOf
         thlPffimqvhwVJTLbeKvlHCp+YVKzDpGPLUa0fXtnSoonHguDczvjQVeX2A8u6MAro
         1Ur2rnheW/kJ9bYC66eJSxO2Wt4cKh9dp0qHn4S6ygN89/yTQc9p/TlZd0kncL2nJh
         tEhBtqqOl1nqg==
Date:   Wed, 1 Sep 2021 15:58:37 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YS94/aRcG6F9Su9R@kernel.org>
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
 <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk>
 <YSUy2WwO9cuokkW0@casper.infradead.org>
 <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
 <YSVCAJDYShQke6Sy@casper.infradead.org>
 <CAHk-=wisF580D_g+wFt0B_uijSX+mCgz6tRRT5KADnO7Y97t-g@mail.gmail.com>
 <YSVHI9iaamxTGmI7@casper.infradead.org>
 <YSVMMMrzqxyFjHlw@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSVMMMrzqxyFjHlw@mit.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 24, 2021 at 03:44:48PM -0400, Theodore Ts'o wrote:
> On Tue, Aug 24, 2021 at 08:23:15PM +0100, Matthew Wilcox wrote:
>
> So if someone sees "kmem_cache_alloc()", they can probably make a
> guess what it means, and it's memorable once they learn it.
> Similarly, something like "head_page", or "mempages" is going to a bit
> more obvious to a kernel newbie.  So if we can make a tiny gesture
> towards comprehensibility, it would be good to do so while it's still
> easier to change the name.

Talking about being newbie friendly, how about we'll just add a piece of
documentation along with the new type for a change?

Something along those lines (I'm sure willy can add several more sentences
for Folio description)

diff --git a/Documentation/vm/memory-model.rst b/Documentation/vm/memory-model.rst
index 30e8fbed6914..b5b39ebe67cf 100644
--- a/Documentation/vm/memory-model.rst
+++ b/Documentation/vm/memory-model.rst
@@ -30,6 +30,29 @@ Each memory model defines :c:func:`pfn_to_page` and :c:func:`page_to_pfn`
 helpers that allow the conversion from PFN to `struct page` and vice
 versa.
 
+Pages
+-----
+
+Each physical page frame in the system is represented by a `struct page`.
+This structure aggregatates several types, each corresponding to a
+particular usage of a page frame, such as anonymous memory, SLAB caches,
+file-backed memory etc. These types are define within unions in the struct
+page to reduce memory footprint of the memory map.
+
+The actual type of the particular insance of struct page is determined by
+values of the fields shared between the different types and can be quired
+using page flag operatoins defined in ``include/linux/page-flags.h``
+
+Folios
+------
+
+For many use cases, single page frame granularity is too small. In such
+cases a contiguous range of memory can be referred by `struct folio`.
+
+A folio is a physically, virtually and logically contiguous range of
+bytes. It is a power-of-two in size, and it is aligned to that same
+power-of-two. It is at least as large as PAGE_SIZE.
+
 FLATMEM
 =======

-- 
Sincerely yours,
Mike.

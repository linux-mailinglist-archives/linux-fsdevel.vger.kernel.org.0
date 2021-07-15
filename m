Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3803CA1BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 17:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239549AbhGOP7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 11:59:18 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42513 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239546AbhGOP7R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 11:59:17 -0400
Received: from callcc.thunk.org (96-65-121-81-static.hfc.comcastbusiness.net [96.65.121.81])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16FFu7nG013646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 11:56:08 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2D4984202F5; Thu, 15 Jul 2021 11:56:07 -0400 (EDT)
Date:   Thu, 15 Jul 2021 11:56:07 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 000/138] Memory folios
Message-ID: <YPBal2dhY+Rv3APB@mit.edu>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:34:46AM +0100, Matthew Wilcox (Oracle) wrote:
> Managing memory in 4KiB pages is a serious overhead.  Many benchmarks
> benefit from a larger "page size".  As an example, an earlier iteration
> of this idea which used compound pages (and wasn't particularly tuned)
> got a 7% performance boost when compiling the kernel.
> 
> Using compound pages or THPs exposes a weakness of our type system.
> Functions are often unprepared for compound pages to be passed to them,
> and may only act on PAGE_SIZE chunks.  Even functions which are aware of
> compound pages may expect a head page, and do the wrong thing if passed
> a tail page.
> 
> We also waste a lot of instructions ensuring that we're not looking at
> a tail page.  Almost every call to PageFoo() contains one or more hidden
> calls to compound_head().  This also happens for get_page(), put_page()
> and many more functions.
> 
> This patch series uses a new type, the struct folio, to manage memory.
> It converts enough of the page cache, iomap and XFS to use folios instead
> of pages, and then adds support for multi-page folios.  It passes xfstests
> (running on XFS) with no regressions compared to v5.14-rc1.

Hey Willy,

I must confess I've lost the thread of the plot in terms of how you
hope to get the Memory folio work merged upstream.  There are some
partial patch sets that just have the mm core, and then there were
some larger patchsets include some in the past which as I recall,
would touch ext4 (but which isn't in this set).

I was wondering if you could perhaps post a roadmap for how this patch
set might be broken up, and which subsections you were hoping to
target for the upcoming merge window versus the following merge
windows.

Also I assume that for file systems that aren't converted to use
Folios, there won't be any performance regressions --- is that
correct?  Or is that something we need to watch for?  Put another way,
if we don't land all of the memory folio patches before the end of the
calendar year, and we cut an LTS release with some file systems
converted and some file systems not yet converted, are there any
potential problems in that eventuality?

Thanks!

						- Ted

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E993CF873
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbhGTKO4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:14:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237649AbhGTKOG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:14:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9884600D4;
        Tue, 20 Jul 2021 10:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626778484;
        bh=Ja1be3usDDuv2HFqu3UdV/HBuywqhaiWMGjarNGVSxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oWbtO1C6ssjAl8A8/TUy/4MJ+D1+YoxtieXKimAg3Y0aNz/BxIr4OL51uig3Z0R38
         9N/y6VfgbnrSv6m37Yv8NVUcPWiXZxSlp44ndQrVI7oyLILn/zFwfE/Jh590iVcvSg
         veQZQULOIw0j84/xUVkXbaycXmF5XblA24XmXwZWKkkXnhO0NGLwwkJrqX+NTWYUcb
         OE8yBrczsTk2CZ1ehs19FGfP2q00tq+aJVZDOqZZST0zXqof/50gufNvlZs42UJrYd
         mXbCZjpVe14qY5Gjxom3PFf9gtJooP0Ree5Ttn2+bVhnh4Nn3Iwjr8+IFRURUPDY16
         cgJg0PboswF7w==
Date:   Tue, 20 Jul 2021 13:54:38 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 000/138] Memory folios
Message-ID: <YParbk8LxhrZMExc@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

(Sorry for the late response, I could not find time earlier)

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

I like the idea of folio and that first patches I've reviewed look good.

Most of the changelogs (at least at the first patches) mention reduction of
the kernel size for your configuration on x86. I wonder, what happens if
you build the kernel with "non-distro" configuration, e.g. defconfig or
tiny.config?

Also, what is the difference on !x86 builds?
 
> Git: https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/tags/folio_14

-- 
Sincerely yours,
Mike.

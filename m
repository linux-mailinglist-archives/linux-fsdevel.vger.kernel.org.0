Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1E23D000A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 19:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhGTQjZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 12:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhGTQiJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 12:38:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E339BC061574;
        Tue, 20 Jul 2021 10:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nIUPbWmLSj16v4fdAmjxUh4nxogfx1bpU0hHVWTHTvI=; b=nAMqbSKWqbj/Ac8oc6FDFmgton
        RWU7nDnH8HrY85pFnG7w+Znd8kqgpgYH6kGrc0ZS0U4Rj3cgtOVkZ9CQVcSB3AvQJmFeaBpDg+AHQ
        3h17EK9hTAwPtE9UQjVBjT9mYQ+kKPofbajFnmisOvdG3HmquACGcZSlEszqrCdkAGjDlyt+lkrQI
        LluCGBk2OL/UMvMOhPbeJDLHHibCxk6RvoNSe81nNjIfrVuvZizcHHWE5F9fKbAYiLEXwW3tPSiYx
        WWVglYjmfJGXd1ANfpypqnnW2wcjiJp4xM99heruNQkZJtVfWHzadyV2PUALLWwC3WAXgisP+MSTT
        i9ru9xuA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5tNl-008LUQ-99; Tue, 20 Jul 2021 17:18:17 +0000
Date:   Tue, 20 Jul 2021 18:18:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 000/138] Memory folios
Message-ID: <YPcFVScLa2GGY2RP@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <YParbk8LxhrZMExc@kernel.org>
 <YPbEax52N7OBQCZp@casper.infradead.org>
 <YPbpBv30NqeQPqPK@kernel.org>
 <YPbqcQ9i/Vi7ivEE@casper.infradead.org>
 <YPbtVvnow+4I4ytS@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPbtVvnow+4I4ytS@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 06:35:50PM +0300, Mike Rapoport wrote:
> On Tue, Jul 20, 2021 at 04:23:29PM +0100, Matthew Wilcox wrote:
> > Which patch did you go up to for that?  If you're going past patch 50 or
> > so, then you're starting to add functionality (ie support for arbitrary
> > order pages), so a certain amount of extra code size might be expected.
> > I measured 6KB at patch 32 or so, then between patch 32 & 50 was pretty
> > much a wash.
> 
> I've used folio_14 tag:
> 
> commit 480552d0322d855d146c0fa6fdf1e89ca8569037 (HEAD, tag: folio_14)
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Wed Feb 5 11:27:01 2020 -0500
> 
>     mm/readahead: Add multi-page folio readahead

Probably worth trying the for-next tag instead to get a meaningful
comparison of how much using folios saves over pages.

I don't want to give the impression that this is all that can be
saved by switching to folios.  There are still hundreds of places that
call PageFoo(), SetPageFoo(), ClearPageFoo(), put_page(), get_page(),
lock_page() and so on.  There's probably another 20KB of code that can
be removed that way.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937F039B03B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 04:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhFDCPd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 22:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhFDCPd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 22:15:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783DCC06174A;
        Thu,  3 Jun 2021 19:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZJLS4mJyjnY+bHzbPHD0JnHSTH2Mf2XBgDyq2VaF36A=; b=ZK+l8zcISQfWND9zUMSVphN4v6
        JIZZgcd/s1pPJpkvkPrf+9sVSWNgiWuj4JAOnv3typNwCuF2jti9P3zEH9R4IojVWDKTqz2qZ0UiT
        Uf/7kVTz2CTWCmY+RaTYEfSf+3lYLM1cIS/9BOzhg/CajJiaGLRuOgAd4PvQM58sp43SWGJ6QjHm+
        RKBoOL5MU+kOCHsvKy26sei6iXxomRN888kWI1LiM8bQSI13MHVBjU0bcG++IaXYxywhzNz1J5aXL
        wrUpCun5Ltworv8btMQh1n/Y3OPtXbA/SvYzoGF2joG14L5C5uEqsO1zvxG7Zopiq1G74ZPD9ypce
        O2ygDQLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lozKq-00ClDW-LM; Fri, 04 Jun 2021 02:13:26 +0000
Date:   Fri, 4 Jun 2021 03:13:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 00/33] Memory folios
Message-ID: <YLmMQJgld6ndNzqI@casper.infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210604030712.11b31259@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604030712.11b31259@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 04, 2021 at 03:07:12AM +0200, Matteo Croce wrote:
> On Tue, 11 May 2021 22:47:02 +0100
> "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
> > We also waste a lot of instructions ensuring that we're not looking at
> > a tail page.  Almost every call to PageFoo() contains one or more
> > hidden calls to compound_head().  This also happens for get_page(),
> > put_page() and many more functions.  There does not appear to be a
> > way to tell gcc that it can cache the result of compound_head(), nor
> > is there a way to tell it that compound_head() is idempotent.
> > 
> 
> Maybe it's not effective in all situations but the following hint to
> the compiler seems to have an effect, at least according to bloat-o-meter:

It definitely has an effect ;-)

     Note that a function that has pointer arguments and examines the
     data pointed to must _not_ be declared 'const' if the pointed-to
     data might change between successive invocations of the function.
     In general, since a function cannot distinguish data that might
     change from data that cannot, const functions should never take
     pointer or, in C++, reference arguments.  Likewise, a function that
     calls a non-const function usually must not be const itself.

So that's not going to work because a call to split_huge_page() won't
tell the compiler that it's changed.

Reading the documentation, we might be able to get away with marking the
function as pure:

     The 'pure' attribute imposes similar but looser restrictions on a
     function's definition than the 'const' attribute: 'pure' allows the
     function to read any non-volatile memory, even if it changes in
     between successive invocations of the function.

although that's going to miss opportunities, since taking a lock will
modify the contents of struct page, meaning the compiler won't cache
the results of compound_head().

> $ scripts/bloat-o-meter vmlinux.o.orig vmlinux.o
> add/remove: 3/13 grow/shrink: 65/689 up/down: 21080/-198089 (-177009)

I assume this is an allyesconfig kernel?    I think it's a good
indication of how much opportunity there is.


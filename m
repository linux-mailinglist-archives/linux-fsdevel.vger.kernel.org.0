Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17EE381AF2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 May 2021 22:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbhEOUPs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 May 2021 16:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhEOUPq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 May 2021 16:15:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC25C061573;
        Sat, 15 May 2021 13:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9XOLX3lclxqmOizJHcYJXn5gUXcoNsJjjPeZ7bAkGuo=; b=Oj4pfQCxOYIZIubFOGoWq6QKrD
        TXlHtKiOnJrrhh/3J91qwZ1heaYZ3Hh3Vjdd2biF9hsgZlCTrm8UDfxTUY75yPdahRhGixtnZVd57
        bpUHb8y+8jPqTUeFIAjziupW2Btwa+r37TZkPiGwU9LgcdW/grnik4JI9/T+loxEH7P4J2A8YHunB
        B23UcDF1qZyQDBieq+/PhzTk8uO0X93IXiqF8deZvZkFO67Rw/Yk1p5G8CYHoz6fiFI0SRIYupArf
        3trdgjNQz0SMbk+2hZxUTgZiFjMnVy8wSKHMPSorSdJWkbXfwUbs9ityUlaaGeDBZcDvMKn9PeVMF
        vhETKKZA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1li0ft-00BUME-LY; Sat, 15 May 2021 20:14:17 +0000
Date:   Sat, 15 May 2021 21:14:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v10 01/33] mm: Introduce struct folio
Message-ID: <YKArlVbtkJo3l1Rz@casper.infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-2-willy@infradead.org>
 <0FF7A37F-80A8-4B49-909D-6234ADA8A25C@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0FF7A37F-80A8-4B49-909D-6234ADA8A25C@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 15, 2021 at 10:55:19AM +0000, William Kucharski wrote:
> > +/**
> > + * folio_page - Return a page from a folio.
> > + * @folio: The folio.
> > + * @n: The page number to return.
> > + *
> > + * @n is relative to the start of the folio.  It should be between
> > + * 0 and folio_nr_pages(@folio) - 1, but this is not checked for.
> 
> Please add a statement noting WHY @n isn't checked since you state it
> should be. Something like "...but this is not checked for because this is
> a hot path."

Hmm ... how about this:

/**
 * folio_page - Return a page from a folio.
 * @folio: The folio.
 * @n: The page number to return.
 *
 * @n is relative to the start of the folio.  This function does not
 * check that the page number lies within @folio; the caller is presumed
 * to have a reference to the page.
 */
#define folio_page(folio, n)    nth_page(&(folio)->page, n)

It occurred to me that it is actually useful (under some circumstances)
for referring to a page outside the base folio.  For example when
dealing with bios that have merged consecutive pages together into a
single bvec (ok, bios don't use folios, but it would be reasonable if
they did in future).

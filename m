Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26A23CFA2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 15:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhGTMap (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 08:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhGTMao (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:30:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4097C061574;
        Tue, 20 Jul 2021 06:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hgPl5F02pttqsu+FUSnFeMJhzopEmUNSjuPlvxGlBNQ=; b=M6xeEccq4GIeEt99toObAGtega
        3m5vXEaKuL0UJFc7tAGqTZZd0Og1h2AmXcr/BLCdSYHDFQQ+ceK9SAwtm4mhWFxtDlpMtrNk6kQtq
        3narjx3gwvt6smCi08/VGdQn/hyuOVKK/96yfbhpmT1DUyh7sS2XAUpsD/e4loZnORNGjmGG7wjXq
        G0ruOtWipKwCrP4s3jcp17w0HyaJCWrYiwi+KfgRX0OrCBHASij/vmXQj7Kl2Wv6ylaAkHkgxUuOS
        EQBQjX0T+gILeL6j/dEER9Py2kZxiI+hT+kjb7WlRee4qMf0r9+dyT1RyHfUo1jzRxOvlLnk5Iuf7
        b/ZhMeKA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5pWL-008850-86; Tue, 20 Jul 2021 13:10:55 +0000
Date:   Tue, 20 Jul 2021 14:10:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v14 011/138] mm/lru: Add folio LRU functions
Message-ID: <YPbLWVXXC8sJNt8N@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-12-willy@infradead.org>
 <YPao+syEWXGhDxay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPao+syEWXGhDxay@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 01:44:10PM +0300, Mike Rapoport wrote:
> >  /**
> > - * page_is_file_lru - should the page be on a file LRU or anon LRU?
> > - * @page: the page to test
> > + * folio_is_file_lru - should the folio be on a file LRU or anon LRU?
> > + * @folio: the folio to test
> >   *
> > - * Returns 1 if @page is a regular filesystem backed page cache page or a lazily
> > - * freed anonymous page (e.g. via MADV_FREE).  Returns 0 if @page is a normal
> > - * anonymous page, a tmpfs page or otherwise ram or swap backed page.  Used by
> > - * functions that manipulate the LRU lists, to sort a page onto the right LRU
> > - * list.
> > + * Returns 1 if @folio is a regular filesystem backed page cache folio
> > + * or a lazily freed anonymous folio (e.g. via MADV_FREE).  Returns 0 if
> > + * @folio is a normal anonymous folio, a tmpfs folio or otherwise ram or
> > + * swap backed folio.  Used by functions that manipulate the LRU lists,
> > + * to sort a folio onto the right LRU list.
> >   *
> >   * We would like to get this info without a page flag, but the state
> > - * needs to survive until the page is last deleted from the LRU, which
> > + * needs to survive until the folio is last deleted from the LRU, which
> >   * could be as far down as __page_cache_release.
> 
> It seems mm_inline.h is not a part of generated API docs, otherwise
> kerneldoc would be unhappy about missing Return: description.

kernel-doc doesn't warn about that by default.

    # This check emits a lot of warnings at the moment, because many
    # functions don't have a 'Return' doc section. So until the number
    # of warnings goes sufficiently down, the check is only performed in
    # verbose mode.
    # TODO: always perform the check.
    if ($verbose && !$noret) {
            check_return_section($file, $declaration_name, $return_type);
    }


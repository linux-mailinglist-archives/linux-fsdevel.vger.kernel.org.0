Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2167435B26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 08:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhJUGyX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 02:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhJUGyW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:54:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7737CC06161C;
        Wed, 20 Oct 2021 23:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C2GrLESxDXsBxKFZvlOYstIpoNYEUDQLI727DbPovXU=; b=TYrAkaXBTNr+gi7RBMQibqZ9UB
        KqzD6Glbfg9BlshviXhxp3yv+0HgftkgaY9vHc/fOKwUffsfiybdj8EEO4wY7TNHWNXj/gLA0J+ia
        NWia0Cxl+1wWi2C02fVMGWtiW4SxsKaHaWLXK2fdqVn3L2WcZjJBemlTwtiWQ//Y4bH1GI/CkadsN
        nSHT6To9Yc6sIHZH54oBreoNiJ0ORfFObC3L11xwgMFaFOizERrE4OtmgU1PZX08DHmltNcDNiP2r
        kgfPGiSdrY3joe2O1O4zOkpSZFdHH04TAhEyz+ABwz8ylQv6EFrMuWIESyZRlKHDSJ9AcEpU9uOd8
        7WmNzpXQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdRvc-006aZH-7q; Thu, 21 Oct 2021 06:51:52 +0000
Date:   Wed, 20 Oct 2021 23:51:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YXEOCIWKEcUOvVtv@infradead.org>
References: <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org>
 <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW28vaoW7qNeX3GP@casper.infradead.org>
 <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org>
 <996b3ac4-1536-2152-f947-aad6074b046a@redhat.com>
 <YXBRPSjPUYnoQU+M@casper.infradead.org>
 <436a9f9c-d5af-7d12-b7d2-568e45ffe0a0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436a9f9c-d5af-7d12-b7d2-568e45ffe0a0@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 08:04:56PM +0200, David Hildenbrand wrote:
> real): assume we have to add a field for handling something about anon
> THP in the struct page (let's assume in the head page for simplicity).
> Where would we add it? To "struct folio" and expose it to all other
> folios that don't really need it because it's so special? To "struct
> page" where it actually doesn't belong after all the discussions? And if
> we would have to move that field it into a tail page, it would get even
> more "tricky".
> 
> Of course, we could let all special types inherit from "struct folio",
> which inherit from "struct page" ... but I am not convinced that we
> actually want that. After all, we're C programmers ;)
> 
> But enough with another side-discussion :)

FYI, with my block and direct I/O developer hat on I really, really
want to have the folio for both file and anon pages.  Because to make
the get_user_pages path a _lot_ more efficient it should store folios.
And to make that work I need them to work for file and anon pages
because for get_user_pages and related code they are treated exactly
the same.

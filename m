Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA964381ED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Oct 2021 07:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhJWFFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Oct 2021 01:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhJWFFK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Oct 2021 01:05:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DECC061764;
        Fri, 22 Oct 2021 22:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hKfR3/ryyitNRCxx14thpt1Pe6SRC47enbuHQnqPb6s=; b=ecpD4Qwjh5T3agQ5qTTl8GtazS
        w8HThPRzeXp2YcS37McMWS94pO36xXo9FG7zvEhc06IFsxSbb2Qwlo7FtOje/iP67fHEZg64yh3vi
        Mm5TaOJFNsqbf3MjFPFmmsp6iFcOcCKyd9Mafs/Z3z1nTJ0coG3N/xzJ/dpYyTfapY1HadzEXakKI
        bVw8DDn5qKYrD8XMGtYjvwvM13VlF49ex+gPSA2+TzT7cOpsK/u/V2jKSqnSQ8YWLdSDNbi/JUhmW
        blKvlxteuJ2MNVZatZET1jlnTSEGTVZpI5E4A3w1fCxoV5NNR66RLiS3yXsSdCPoIt5JorLe8TTVa
        KxFz70TA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1me9Av-00CHxV-Uc; Sat, 23 Oct 2021 05:02:33 +0000
Date:   Fri, 22 Oct 2021 22:02:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YXOXaTNPkln3Blvt@infradead.org>
References: <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org>
 <YXBUPguecSeSO6UD@moria.home.lan>
 <YXHdpQTL1Udz48fc@cmpxchg.org>
 <YXIZX0truEBv2YSz@casper.infradead.org>
 <326b5796-6ef9-a08f-a671-4da4b04a2b4f@redhat.com>
 <YXK2ICKi6fjNfr4X@casper.infradead.org>
 <c18923a1-8144-785e-5fb3-5cbce4be1310@redhat.com>
 <YXNx686gvsJMgS+z@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXNx686gvsJMgS+z@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 23, 2021 at 03:22:35AM +0100, Matthew Wilcox wrote:
> You can see folios as a first step to disentangling some of the users
> of struct page.  It certainly won't be the last step.  But I'd really
> like to stop having theoretical discussions of memory types and get on
> with writing code.

Agreed.  I think folios are really important to sort out the mess
around compound pages ASAP.

I'm a lot more lukewarm on the other splits.  Yes, struct page is a
mess, but I'm not sure creating gazillions of new types solve that
mess.  Getting rid of a bunch of the crazy optimizations that abuse
struct page fields might a better first step - or rather after the
first step of folios which fix real bugs in compount handling and do
enable sane handling of compound pages in the page cache.

> If that means we modify the fs APIs again in twelve
> months to replace folios with file_mem, well, I'm OK with that.

I suspect we won't even need that so quickly if at all, but I'd rather
have a little more churn rather than blocking this important work
forever.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425B93502D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 16:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbhCaO4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 10:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbhCaOzn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:55:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65468C061574;
        Wed, 31 Mar 2021 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WOGmEDTpzeV+1sPuo1/4FzQmK0Bbmt6+Hd4kBlUeNn4=; b=ezANnEEwtA3WVH3yRzdT3IIjm/
        hPtAZF+uX9BQ9Vf2DrfCxXGMegOYtEXonVofV18ODNEHrWv3451OJ112lzliorOZbgp5VD8aQsQOU
        +hsiY3qspYBznIjxtmxCq0zjTC+dYgqfwkjWpuhvrV9Cvxn+CWE9ahveEsJIelBybB4kdDgTU7P0s
        9bhLA8ioXyMoS+42FX8qW9gfNFBPspwG++LKkfETXQAbGFPBCnLAPKtj3KI42xW0pCdcQnZXSzwoA
        27gLDyTtu9P5QiKxZQ/PxhM/iy/P4asC8Bun2EYeEufke2SERIYy+bmUulTkkUEjQ7+qKkjeLsDD+
        4ETENptA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRcEh-004hdF-5c; Wed, 31 Mar 2021 14:54:35 +0000
Date:   Wed, 31 Mar 2021 15:54:23 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 00/27] Memory Folios
Message-ID: <20210331145423.GA1118729@infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
 <YFja/LRC1NI6quL6@cmpxchg.org>
 <20210322184744.GU1719932@casper.infradead.org>
 <YFqH3B80Gn8pcPqB@cmpxchg.org>
 <20210324062421.GQ1719932@casper.infradead.org>
 <YF4eX/VBPLmontA+@cmpxchg.org>
 <20210329165832.GG351017@casper.infradead.org>
 <YGN8biqigvPP0SGN@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGN8biqigvPP0SGN@cmpxchg.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 30, 2021 at 03:30:54PM -0400, Johannes Weiner wrote:
> > Eventually, I want to make struct page optional for allocations.  It's too
> > small for some things (allocating page tables, for example), and overly
> > large for others (allocating a 2MB page, networking page_pool).  I don't
> > want to change its size in the meantime; having a struct page refer to
> > PAGE_SIZE bytes is something that's quite deeply baked in.
> 
> Right, I think it's overloaded and it needs to go away from many
> contexts it's used in today.

FYI, one unrelated usage is that in many contet we use a struct page and
an offset to describe locations for I/O (block layer, networking, DMA
API).  With huge pages and merged I/O buffers this representation
actually becomes increasingly painful.

And a little bit back to the topic:  I think the folio as in the
current patchset is incredibly useful and someting we need like
yesterday to help file systems and the block layer to cope with
huge and compound pages of all sorts.  Once willy sends out a new
version with the accumulated fixes I'm ready to ACK the whole thing.

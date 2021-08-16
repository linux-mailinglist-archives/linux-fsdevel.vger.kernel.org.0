Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA453ECCA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 04:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhHPCWI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 22:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhHPCWI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 22:22:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A542FC061764;
        Sun, 15 Aug 2021 19:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8wNz7LcT9xNxK0y/fhLt58PK8+R22+7lIZQyn3Pih+A=; b=fGbOje6iv2gBRt1NHwxNDaxkq6
        bR34Tb/IF3vQKwky/8bwQdw/c9IBHmo8ElPm1+vBgVs3W5rWFsasstgDzSNrCoOol3FrzRyaKr/g3
        ECms22cwdWo7taquCtWt7b6ORbhWnZaQ/vJSz7euXjILEYqO2gl4a/KRJIyrBliJCXHJleF1jZkg3
        n49k3sOoFT9dSNmrNSr8o6YdKKejvpJukuU4tVUKMiWTRFJ91WsxGf/7v/l699aT9Pow5fRYuSUwe
        2O1I+8O5xQvvEJFph0AXtsftkt0TdlxN773hB/taWKibG28guGZmTSxBcNWwCyOmWidgggVcKl/iy
        DZml9eJA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFSFd-000rxS-77; Mon, 16 Aug 2021 02:21:27 +0000
Date:   Mon, 16 Aug 2021 03:21:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 082/138] mm/lru: Convert __pagevec_lru_add_fn to take
 a folio
Message-ID: <YRnLoYRps6HXdTyD@casper.infradead.org>
References: <20210715033704.692967-83-willy@infradead.org>
 <20210715033704.692967-1-willy@infradead.org>
 <1814231.1628631867@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1814231.1628631867@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 10:44:27PM +0100, David Howells wrote:
> Matthew Wilcox (Oracle) <willy@infradead.org> wrote:
> 
> >  	 * looking at the same page) and the evictable page will be stranded
> >  	 * in an unevictable LRU.
> 
> Does that need converting to say 'folio'?

Changed the parapgraph (passed it through fmt too)

         * if '#1' does not observe setting of PG_lru by '#0' and
         * fails isolation, the explicit barrier will make sure that
         * folio_evictable check will put the folio on the correct
         * LRU. Without smp_mb(), folio_set_lru() can be reordered
         * after folio_test_mlocked() check and can make '#1' fail the
         * isolation of the folio whose mlocked bit is cleared (#0 is
         * also looking at the same folio) and the evictable folio will
         * be stranded on an unevictable LRU.

> Other than that:
> 
> Reviewed-by: David Howells <dhowells@redhat.com>
> 

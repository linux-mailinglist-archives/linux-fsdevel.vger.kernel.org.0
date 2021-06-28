Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C836F3B58F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 08:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhF1GJl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 02:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbhF1GJk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:09:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADEDC061574;
        Sun, 27 Jun 2021 23:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2mZuGcEXs8gsYDGEVt3HJAUS/bsdu6MGRtoja2lA6ZY=; b=mOgYpHkstZdkp12xij/IbcULF9
        fbsiC0DRRtQKhqJzaZi0c/SH9mw2rFFlMxltX9JcsIK8ptlxjIMcq7Z5vNXQfxFJgTryb0jqf6YNy
        xCHsg1DgDofk2U7U7F60UGegHzoIeTzwVk+zyQ7dQXNrgrMfeU3nbh5lNxpKMlD15S9EU2F4tiUJH
        qRO9X7251dudhFeBbHL3oe1Y2AzQEYrcama8rXBk9TrwhRUUe4h4i4INlvv/asVUZGf5O/RU/Smsj
        umjb5Q97rg12Oc7jh5BWoffJOCnNBz/3htgBJEGwkhHkyp70/qapNoBV9KyqqFpok7DuxkMC0z9e/
        Bq9JDsyA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxkMg-002dgf-AM; Mon, 28 Jun 2021 06:03:49 +0000
Date:   Mon, 28 Jun 2021 07:03:26 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 27/46] mm/writeback: Add __folio_mark_dirty()
Message-ID: <YNlmLjhf+nZLKKRo@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-28-willy@infradead.org>
 <YNL+cHDPMfvvXMUh@infradead.org>
 <YNTQ6o0kxESisBri@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNTQ6o0kxESisBri@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 24, 2021 at 07:37:30PM +0100, Matthew Wilcox wrote:
> On Wed, Jun 23, 2021 at 11:27:12AM +0200, Christoph Hellwig wrote:
> > On Tue, Jun 22, 2021 at 01:15:32PM +0100, Matthew Wilcox (Oracle) wrote:
> > > Turn __set_page_dirty() into a wrapper around __folio_mark_dirty() (which
> > > can directly cast from page to folio because we know that set_page_dirty()
> > > calls filesystems with the head page).  Convert account_page_dirtied()
> > > into folio_account_dirtied() and account the number of pages in the folio.
> > 
> > Is it really worth micro-optimizing a transitional function like that?
> > I'd rather eat the overhead of the compound_page() call over adding hacky
> > casts like this.
> 
> Fair enough.  There's only three calls to it and one of them goes away
> this series.

The other option would be a helper that asserts a page is not a tail
page and then do the cast to document the assumptions.

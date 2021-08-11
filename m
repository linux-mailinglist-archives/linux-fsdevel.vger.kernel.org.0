Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB3C3E88B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 05:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhHKDNX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 23:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbhHKDNW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 23:13:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F6DC061765;
        Tue, 10 Aug 2021 20:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+BD8bHPfSUIsdGULmpALqMFcshnOVLTSeycxgTymMVA=; b=I4xa0mmXWHwafl3+3KlzjMpsyd
        fUDC2rCzytydPvZwxv4eg1zjcIT9R1A8+A4HqPQ6mCODHFMqrO5Kp8ZPaAP+ny13bHGHoMgUownQV
        FCQ7o9P4oaCoPavC67lamAt3OnQkvedFXaLOBM89v5OJGYdsXLCEvAbWxoXakJwK6aUXlnurKFXmp
        qi3UHdok32ZAGR3xFE/OIZgcIm8l8Ljb/KD3cEe6/oPgki6UQNwoSVJ/VUy3AUktlr22h6CSu2/CD
        4Q1Bz5hDtuBvdDL0LMnshp6wDgSyRpceeTz6kSmWn//V9ymip8+PONYeZpBihfUzvpbQl2y/RmYOp
        WtK6fHrA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDefG-00CtuP-Hv; Wed, 11 Aug 2021 03:12:33 +0000
Date:   Wed, 11 Aug 2021 04:12:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 061/138] mm/migrate: Add folio_migrate_flags()
Message-ID: <YRNAFmvdleh+4jnX@casper.infradead.org>
References: <20210715033704.692967-62-willy@infradead.org>
 <20210715033704.692967-1-willy@infradead.org>
 <1812509.1628629765@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1812509.1628629765@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 10:09:25PM +0100, David Howells wrote:
> Matthew Wilcox (Oracle) <willy@infradead.org> wrote:
> 
> > +	if (folio_test_error(folio))
> > +		folio_set_error(newfolio);
> > +	if (folio_test_referenced(folio))
> > +		folio_set_referenced(newfolio);
> > +	if (folio_test_uptodate(folio))
> > +		folio_mark_uptodate(newfolio);
> > +	if (folio_test_clear_active(folio)) {
> > +		VM_BUG_ON_FOLIO(folio_test_unevictable(folio), folio);
> > +		folio_set_active(newfolio);
> > +	} else if (folio_test_clear_unevictable(folio))
> > +		folio_set_unevictable(newfolio);
> > +	if (folio_test_workingset(folio))
> > +		folio_set_workingset(newfolio);
> > +	if (folio_test_checked(folio))
> > +		folio_set_checked(newfolio);
> > +	if (folio_test_mappedtodisk(folio))
> > +		folio_set_mappedtodisk(newfolio);
> 
> Since a bunch of these are bits in folio->flags and newfolio->flags, I wonder
> if it's better to do use a cmpxchg() loop or LL/SC construct to transfer all
> the relevant flags in one go.

I have plans for that, but they're on hold until the folio work is a bit
further progressed.  It also helps code that does something like:

	if (folio_test_dirty(folio) || folio_test_writeback(folio))


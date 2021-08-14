Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEF13EC3F1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Aug 2021 18:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbhHNQwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Aug 2021 12:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbhHNQwY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Aug 2021 12:52:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E8FC061764;
        Sat, 14 Aug 2021 09:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=THZ//hV3fEyfAA4zhklKtKpMz1OFaHnMmtlB1qWq1hg=; b=KedV6pi3ZXiTo5WIk8Uo2beK0N
        UcDULdF2vZ9BxASpNSR7UaI3c3iU/fWiKCtM21zMX/YvS+njS/e7R7SFyUR7qS6rWQx7yWwOgru57
        YHUe/u6pKQCQNFOnyiy7OIxhdCbQOLf6SbXAkG0qb1TD/mn5A4jclTnUweo/sNgHczjL3GEVzIIXp
        BYFLhjat+sF4Cux8JG401ykGk9DojGJgPQLsQvUmQsP43U+/lTWzkpL1V4Z9O6sjMAe2Fn5aO0Bw4
        llNeag6pF+9c07EG4MLzC00Sr6PDfMHl+C5ANf1ZX6DJs551Qxec74qm1Xg1l6zSHTSYcbuJ+QNuj
        aUEdqxfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEwsX-00GrRQ-Rk; Sat, 14 Aug 2021 16:51:33 +0000
Date:   Sat, 14 Aug 2021 17:51:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 052/138] mm: Add folio_raw_mapping()
Message-ID: <YRf0jTttJIjMcnkp@casper.infradead.org>
References: <20210715033704.692967-53-willy@infradead.org>
 <20210715033704.692967-1-willy@infradead.org>
 <1811270.1628628133@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1811270.1628628133@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 09:42:13PM +0100, David Howells wrote:
> Matthew Wilcox (Oracle) <willy@infradead.org> wrote:
> 
> > Convert __page_rmapping to folio_raw_mapping and move it to mm/internal.h.
> > It's only a couple of instructions (load and mask), so it's definitely
> > going to be cheaper to inline it than call it.  Leave page_rmapping
> > out of line.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> I assume you're going to call it from another source file at some point,
> otherwise this is unnecessary.

Yes, it gets called from mm/ksm.c in a later patch in this series.
__page_rmapping() assumes it's being passed a head page and
folio_raw_mapping() asserts that.  Eventually, page_rmapping() can
go away (and maybe it should have been moved to folio-compat.c),
but I'm not inclined to do that now.

> Apart from that,
> 
> Reviewed-by: David Howells <dhowells@redhat.com>
> 

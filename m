Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667C93877B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 13:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbhERLdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 07:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237487AbhERLc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 07:32:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00627C061573;
        Tue, 18 May 2021 04:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bcVit+6mgvFx6heftajsrfaGxDkJsK5oc1JEKMXcvbk=; b=t8b781qfNVrmqOk36u2HkQAnOx
        3W8zk/6U2ayPe7nlMCdyQKDq5sK6zToIkich1QZsLvVi4Ef40iM1NQf/c3DO2Bw5VrEd12V5SzHb+
        1cOUCYljpa9RqEfXAJRGJSCEloeSVRUtjxY3I5Zy4v61LDPhLryztZfyIO+zqSUOkZNQTZaUnvKos
        h1HVt1hJZP9IapTE2fnBHe/L/qbbxFtY7Ms4cork7z+pdoSjGbQGNRW1dMn5uMqcasMHRm/GyMKti
        vUYpR/zArMKUU2BLUwaJiCEz1z3/DGSEA+G7R31dwlBynnjx2qNl9FJxQY+ISkqeBIX+63q9u4h+B
        geD92rLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lixvF-00DvfV-Dm; Tue, 18 May 2021 11:30:53 +0000
Date:   Tue, 18 May 2021 12:30:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v10 18/33] mm/filemap: Add folio_unlock
Message-ID: <YKOlOfFBrVu36g1q@casper.infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-19-willy@infradead.org>
 <e3869efd-b4a3-93a2-b510-21142db91603@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3869efd-b4a3-93a2-b510-21142db91603@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 18, 2021 at 12:06:42PM +0200, Vlastimil Babka wrote:
> >  /**
> > - * unlock_page - unlock a locked page
> > - * @page: the page
> > + * folio_unlock - Unlock a locked folio.
> > + * @folio: The folio.
> >   *
> > - * Unlocks the page and wakes up sleepers in wait_on_page_locked().
> > - * Also wakes sleepers in wait_on_page_writeback() because the wakeup
> > - * mechanism between PageLocked pages and PageWriteback pages is shared.
> > - * But that's OK - sleepers in wait_on_page_writeback() just go back to sleep.
> > + * Unlocks the folio and wakes up any thread sleeping on the page lock.
> >   *
> > - * Note that this depends on PG_waiters being the sign bit in the byte
> > - * that contains PG_locked - thus the BUILD_BUG_ON(). That allows us to
> > - * clear the PG_locked bit and test PG_waiters at the same time fairly
> > - * portably (architectures that do LL/SC can test any bit, while x86 can
> > - * test the sign bit).
> 
> Was it necessary to remove the comments about wait_on_page_writeback() and
> PG_waiters etc?

I think so.  This kernel-doc is for the person who wants to understand
how to use the function, not for the person who wants to understand why
the function is written the way it is.  For that person, we have git log
messages and other comments dotted throughout, eg the comment on
clear_bit_unlock_is_negative_byte() in mm/filemap.c and the comment
on PG_waiters in include/linux/page-flags.h.

> > + * Context: May be called from interrupt or process context.  May not be
> > + * called from NMI context.
> 
> Where did the NMI part come from?

If you're in NMI context and call unlock_page() and the page has a
waiter on it, we call folio_wake_bit(), which calls spin_lock_irqsave()
on the wait_queue_head_t lock, which I believe cannot be done safely 
from NMI context (as the NMI may have interrupted us while holding
that lock).


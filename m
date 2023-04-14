Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E856E2A31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 20:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjDNSn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 14:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDNSnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:43:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58547868B;
        Fri, 14 Apr 2023 11:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p26dZK3pH6VmE9TncnwVN82emLjrvNPhwxTiscJM8dU=; b=Sd/cxbIkTSLPdPrOyKbZZr25Yk
        YwccLPev/kvz0gp5GFwNUnfgXp+fhJlhYTVZKK0P5sYL8xyjHsX/RAGiviCKwy3eFnojOgRE93pRj
        wjBET4Nv4ldXh/xNykeV3Re6au6xejXVhuYQxtwkT5EXoTUjR0wY0b/dHfOLWyoDn9FbIaOgIvFka
        66lHXnuIx3gtHO5BGyjEHbIlRTA3+snpRomlp1zSShbh308va4EmMNd/bkQZcl+apjOwmr42zNbTd
        nds1ibzn7oxYqmdROUjK9Q04q2ogcBBtIii1R7kYe06diNa7TBjT4YjR0aM09KznpCUK5flSECDBv
        NOzAcIbA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnONy-008zEZ-0z; Fri, 14 Apr 2023 18:43:02 +0000
Date:   Fri, 14 Apr 2023 19:43:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/1] mm: handle swap page faults if the faulting page can
 be locked
Message-ID: <ZDmetaUdmlEz/W8Q@casper.infradead.org>
References: <20230414180043.1839745-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414180043.1839745-1-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 11:00:43AM -0700, Suren Baghdasaryan wrote:
> When page fault is handled under VMA lock protection, all swap page
> faults are retried with mmap_lock because folio_lock_or_retry
> implementation has to drop and reacquire mmap_lock if folio could
> not be immediately locked.
> Instead of retrying all swapped page faults, retry only when folio
> locking fails.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Let's just review what can now be handled under the VMA lock instead of
the mmap_lock, in case somebody knows better than me that it's not safe.

 - We can call migration_entry_wait().  This will wait for PG_locked to
   become clear (in migration_entry_wait_on_locked()).  As previously
   discussed offline, I think this is safe to do while holding the VMA
   locked.
 - We can call remove_device_exclusive_entry().  That calls
   folio_lock_or_retry(), which will fail if it can't get the VMA lock.
 - We can call pgmap->ops->migrate_to_ram().  Perhaps somebody familiar
   with Nouveau and amdkfd could comment on how safe this is?
 - I believe we can't call handle_pte_marker() because we exclude UFFD
   VMAs earlier.
 - We can call swap_readpage() if we allocate a new folio.  I haven't
   traced through all this code to tell if it's OK.

So ... I believe this is all OK, but we're definitely now willing to
wait for I/O from the swap device while holding the VMA lock when we
weren't before.  And maybe we should make a bigger deal of it in the
changelog.

And maybe we shouldn't just be failing the folio_lock_or_retry(),
maybe we should be waiting for the folio lock with the VMA locked.


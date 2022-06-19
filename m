Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E25550829
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jun 2022 05:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbiFSDts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 23:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiFSDtr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 23:49:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB1911A2E;
        Sat, 18 Jun 2022 20:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n0V/QlpU6hmWIFdXHN46nESAfJQsfOJKchpQNnTZHFk=; b=lB5e51TpUA5Mdiw/oLqx9Wojzj
        4VqegTjVCIv8+QY7VhLBz7QLMc2q6Uit4Al/IVpbO7QEV8yq3eyCKE+HTg9V+Vg4IWpNJIODQb+0T
        PzAGysuubC3g7J7kVXldRZ6O62EvLRe+CegcNSXSYGCProa4R0/YrMu0JUNuAui5yK9rYjHgvOmqm
        eIZrSb1SZcULqtGuDbK0VPmD9mUjQZaB9poKaQvDX894BEsanLrTlS4GNkrdqCgl34phyY1LCgewE
        GpGxEflGAE+cdgTLjjBHAuvXffFfDgRl1L6NGLksyQbdI8r3IOm0iP5CuN6qEM5BPQwTxVXHB+knE
        611FfaKw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2lwP-0046RB-4e; Sun, 19 Jun 2022 03:49:37 +0000
Date:   Sun, 19 Jun 2022 04:49:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] ceph: switch back to testing for NULL folio->private in
 ceph_dirty_folio
Message-ID: <Yq6c0fxTLJnnU0Ob@casper.infradead.org>
References: <20220610154013.68259-1-jlayton@kernel.org>
 <6189bdb3-6bfa-b85a-8df5-0fe94d7a962a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6189bdb3-6bfa-b85a-8df5-0fe94d7a962a@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 13, 2022 at 08:48:40AM +0800, Xiubo Li wrote:
> 
> On 6/10/22 11:40 PM, Jeff Layton wrote:
> > Willy requested that we change this back to warning on folio->private
> > being non-NULl. He's trying to kill off the PG_private flag, and so we'd
> > like to catch where it's non-NULL.
> > 
> > Add a VM_WARN_ON_FOLIO (since it doesn't exist yet) and change over to
> > using that instead of VM_BUG_ON_FOLIO along with testing the ->private
> > pointer.
> > 
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >   fs/ceph/addr.c          | 2 +-
> >   include/linux/mmdebug.h | 9 +++++++++
> >   2 files changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index b43cc01a61db..b24d6bdb91db 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -122,7 +122,7 @@ static bool ceph_dirty_folio(struct address_space *mapping, struct folio *folio)
> >   	 * Reference snap context in folio->private.  Also set
> >   	 * PagePrivate so that we get invalidate_folio callback.
> >   	 */
> > -	VM_BUG_ON_FOLIO(folio_test_private(folio), folio);
> > +	VM_WARN_ON_FOLIO(folio->private, folio);
> >   	folio_attach_private(folio, snapc);
> >   	return ceph_fscache_dirty_folio(mapping, folio);

I found a couple of places where page->private needs to be NULLed out.
Neither of them are Ceph's fault.  I decided that testing whether
folio->private and PG_private are in agreement was better done in
folio_unlock() than in any of the other potential places we could
check for it.

diff --git a/mm/filemap.c b/mm/filemap.c
index 8ef861297ffb..acef71f75e78 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1535,6 +1535,9 @@ void folio_unlock(struct folio *folio)
 	BUILD_BUG_ON(PG_waiters != 7);
 	BUILD_BUG_ON(PG_locked > 7);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+	VM_BUG_ON_FOLIO(!folio_test_private(folio) &&
+			!folio_test_swapbacked(folio) &&
+			folio_get_private(folio), folio);
 	if (clear_bit_unlock_is_negative_byte(PG_locked, folio_flags(folio, 0)))
 		folio_wake_bit(folio, PG_locked);
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2e2a8b5bc567..af0751a79c19 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2438,6 +2438,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
 			page_tail);
 	page_tail->mapping = head->mapping;
 	page_tail->index = head->index + tail;
+	page_tail->private = 0;
 
 	/* Page flags must be visible before we make the page non-compound. */
 	smp_wmb();
diff --git a/mm/migrate.c b/mm/migrate.c
index eb62e026c501..fa8e36e74f0d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1157,6 +1157,8 @@ static int unmap_and_move(new_page_t get_new_page,
 	newpage = get_new_page(page, private);
 	if (!newpage)
 		return -ENOMEM;
+	BUG_ON(compound_order(newpage) != compound_order(page));
+	newpage->private = 0;
 
 	rc = __unmap_and_move(page, newpage, force, mode);
 	if (rc == MIGRATEPAGE_SUCCESS)

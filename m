Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68D35400F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 16:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245246AbiFGOL7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 10:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245218AbiFGOLs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:11:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02159AE241;
        Tue,  7 Jun 2022 07:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4nUpYTI4YzQUWe3MX/DeuqIdjPgTHj7mksBWnabO8pk=; b=IoritkaL90aqbR+RUHZKoSo8fb
        np1ux4ttns5tYj2sJk/FAj12Ak/CQ/wW4eIuwXN5ulK6rhUSeL7wfME8a6K9gYUgIYgqg08BNe9+I
        tus3kQ04SmPJZl9V4GH+E2xTibe280AETqIE3sbtSug/TUXDR0128c42jRa/+qeI8q7uri0dQOk1f
        wWHM11+pgzBreVL8bkL3da/JDGIf99g2HUm8tnTrzT4cPM9I17c3dxlon1CkQMKJOgWEf9FbWmKJ9
        h7TOtnv+jsL8ABFyKBR86bb03b2ZVDj0NIek4XcowncLGE0YjVino+xsZhqucJvOU+7lO9abDpL7s
        BM8iPWpg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyZvo-00BhC6-Sq; Tue, 07 Jun 2022 14:11:40 +0000
Date:   Tue, 7 Jun 2022 15:11:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ocfs2-devel@oss.oracle.com, linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 05/20] mm/migrate: Convert expected_page_refs() to
 folio_expected_refs()
Message-ID: <Yp9cnCaZ1O4qHFEp@casper.infradead.org>
References: <20220606204050.2625949-1-willy@infradead.org>
 <20220606204050.2625949-6-willy@infradead.org>
 <Yp9VpZDsUEAZHEuy@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp9VpZDsUEAZHEuy@bfoster>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 09:41:57AM -0400, Brian Foster wrote:
> On Mon, Jun 06, 2022 at 09:40:35PM +0100, Matthew Wilcox (Oracle) wrote:
> > -static int expected_page_refs(struct address_space *mapping, struct page *page)
> > +static int folio_expected_refs(struct address_space *mapping,
> > +		struct folio *folio)
> >  {
> > -	int expected_count = 1;
> > +	int refs = 1;
> > +	if (!mapping)
> > +		return refs;
> >  
> > -	if (mapping)
> > -		expected_count += compound_nr(page) + page_has_private(page);
> > -	return expected_count;
> > +	refs += folio_nr_pages(folio);
> > +	if (folio_get_private(folio))
> > +		refs++;
> 
> Why not folio_has_private() (as seems to be used for later
> page_has_private() conversions) here?

We have a horrid confusion that I'm trying to clean up stealthily
without anyone noticing.  I would have gotten away with it too if it
weren't for you pesky kids.

#define PAGE_FLAGS_PRIVATE                              \
        (1UL << PG_private | 1UL << PG_private_2)

static inline int page_has_private(struct page *page)
{
        return !!(page->flags & PAGE_FLAGS_PRIVATE);
}

So what this function is saying is that there is one extra refcount
expected on the struct page if PG_private _or_ PG_private_2 is set.

How are filesystems expected to manage their page's refcount with this
rule?  Increment the refcount when setting PG_private unless
PG_private_2 is already set?  Decrement the refcount when clearing
PG_private_2 unless PG_private is set?

This is garbage.  IMO, PG_private_2 should have no bearing on the page's
refcount.  Only btrfs and the netfs's use private_2 and neither of them
do anything to the refcount when setting/clearing it.  So that's what
I'm implementing here.

> > +
> > +	return refs;;
> 
> Nit: extra ;

Oh, that's where it went ;-)  I had a compile error due to a missing
semicolon at some point, and thought it was just a typo ...

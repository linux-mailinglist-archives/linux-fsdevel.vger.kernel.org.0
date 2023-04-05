Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69C36D8906
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 22:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjDEUrv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 16:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjDEUrs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:47:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1041BEE;
        Wed,  5 Apr 2023 13:47:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 391F262BB9;
        Wed,  5 Apr 2023 20:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62061C433EF;
        Wed,  5 Apr 2023 20:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680727666;
        bh=JHYkzEFJehfbG4+KRCg90sRcADee5WmNO6JSJDaA3UI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KcHIC6dk/n3uDrmqf2bu7zCEr2DJ28jvt/zGKEVORnaPu5cmB/PPFR8mfpeGN/do5
         NpDaLZ7zP7rS5/zBniaVT8rxVDJz5wXWVpsnD8PD55oeh8HNwDMGQ3lFXXFM48ZVIa
         pzzusqmdFST6v5G6DN5KPM87zqTQHjI3D1oRsUfoPiput1EuVKhDSNPDMQ6E7NLqe+
         6YsQ4khuyLr0TT78b3fBh/Uxkv0Aaw+JUOkc2MBPgOkEc86xCee7NYch51aJntyXX1
         wo75tXqHKzWTaLjc8F8sc+bDJbnDcWD/7S1KDhL7Jrffne5O14KVvejg72d2xpuAGJ
         WisliDXJc8UyA==
Date:   Wed, 5 Apr 2023 13:47:44 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: get out of a repeat loop when getting a
 locked data page
Message-ID: <ZC3ecF7pklH8CxBw@google.com>
References: <20230323213919.1876157-1-jaegeuk@kernel.org>
 <8aea02b0-86f9-539a-02e9-27b381e68b66@kernel.org>
 <ZCG2mfviZfY1dqb4@google.com>
 <ZCHCykI/BLcfDzt7@casper.infradead.org>
 <ZC2kSfNUXKK4PfpM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC2kSfNUXKK4PfpM@google.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/05, Jaegeuk Kim wrote:
> On 03/27, Matthew Wilcox wrote:
> > On Mon, Mar 27, 2023 at 08:30:33AM -0700, Jaegeuk Kim wrote:
> > > On 03/26, Chao Yu wrote:
> > > > On 2023/3/24 5:39, Jaegeuk Kim wrote:
> > > > > https://bugzilla.kernel.org/show_bug.cgi?id=216050
> > > > > 
> > > > > Somehow we're getting a page which has a different mapping.
> > > > > Let's avoid the infinite loop.
> > > > > 
> > > > > Cc: <stable@vger.kernel.org>
> > > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > > ---
> > > > >   fs/f2fs/data.c | 8 ++------
> > > > >   1 file changed, 2 insertions(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > > > index bf51e6e4eb64..80702c93e885 100644
> > > > > --- a/fs/f2fs/data.c
> > > > > +++ b/fs/f2fs/data.c
> > > > > @@ -1329,18 +1329,14 @@ struct page *f2fs_get_lock_data_page(struct inode *inode, pgoff_t index,
> > > > >   {
> > > > >   	struct address_space *mapping = inode->i_mapping;
> > > > >   	struct page *page;
> > > > > -repeat:
> > > > > +
> > > > >   	page = f2fs_get_read_data_page(inode, index, 0, for_write, NULL);
> > > > >   	if (IS_ERR(page))
> > > > >   		return page;
> > > > >   	/* wait for read completion */
> > > > >   	lock_page(page);
> > > > > -	if (unlikely(page->mapping != mapping)) {
> > > > 
> > > > How about using such logic only for move_data_page() to limit affect for
> > > > other paths?
> > > 
> > > Why move_data_page() only? If this happens, we'll fall into a loop in anywhere?
> > > 
> > > > 
> > > > Jaegeuk, any thoughts about why mapping is mismatch in between page's one and
> > > > inode->i_mapping?
> > > 
> > > > 
> > > > After several times code review, I didn't get any clue about why f2fs always
> > > > get the different mapping in a loop.
> > > 
> > > I couldn't find the path to happen this. So weird. Please check the history in the
> > > bug.
> > > 
> > > > 
> > > > Maybe we can loop MM guys to check whether below folio_file_page() may return
> > > > page which has different mapping?
> > > 
> > > Matthew may have some idea on this?
> > 
> > There's a lot of comments in the bug ... hard to come into this one
> > cold.
> > 
> > I did notice this one (#119):
> > : Interestingly, ref count is 514, which looks suspiciously as a binary
> > : flag 1000000010. Is it possible that during 5.17/5.18 implementation
> > : of a "pin", somehow binary flag was written to ref count, or something
> > : like '1 << ...' happens?
> > 
> > That indicates to me that somehow you've got hold of a THP that is in
> > the page cache.  Probably shmem/tmpfs.  That indicate to me a refcount
> > problem that looks something like this:
> > 
> > f2fs allocates a page
> > f2fs adds the page to the page cache
> > f2fs puts the reference to the page without removing it from the
> > page cache (how?)
> 
> Is it somewhat related to setting a bit in private field?
> 
> When we migrate the blocks, we do:
> 1) get_lock_page()
> 2) submit read
> 3) lock_page()
> 3) set_page_dirty()
> 4) set_page_private_gcing(page)
> 
> --- in fs/f2fs/f2fs.h
> 1409 #define PAGE_PRIVATE_SET_FUNC(name, flagname) \
> 1410 static inline void set_page_private_##name(struct page *page) \
> 1411 { \
> 1412         if (!PagePrivate(page)) { \
> 1413                 get_page(page); \
> 1414                 SetPagePrivate(page); \
> 1415                 set_page_private(page, 0); \
> 1416         } \
> 1417         set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)); \
> 1418         set_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
> 1419 }
> 
> 
> 5) set_page_writebac()
> 6) submit write
> 7) unlock_page()
> 8) put_page(page)
> 
> Later, f2fs_invalidate_folio will do put_page again by:
> clear_page_private_gcing(&folio->page);
> 
> --- in fs/f2fs/f2fs.h
> 1421 #define PAGE_PRIVATE_CLEAR_FUNC(name, flagname) \
> 1422 static inline void clear_page_private_##name(struct page *page) \
> 1423 { \
> 1424         clear_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
> 1425         if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER)) { \
> 1426                 set_page_private(page, 0); \
> 1427                 if (PagePrivate(page)) { \
> 1428                         ClearPagePrivate(page); \
> 1429                         put_page(page); \
> 1430                 }\
> 1431         } \
> 1432 }

It seems f2fs_invalidate_folio and f2fs_release_folio drop the refcount by
folio_detach_private() additionally.

https://lore.kernel.org/lkml/20230405204321.2056498-1-jaegeuk@kernel.org/T/#u

> 
> > page is now free, gets reallocated into a THP
> > lookup from the f2fs file finds the new THP
> > things explode messily
> > 
> > Checking page->mapping is going to avoid the messy explosion, but
> > you'll still have a page in the page cache which doesn't actually
> > belong to you, and that's going to lead to subtle data corruption.
> > 
> > This should be caught by page_expected_state(), called from
> > free_page_is_bad(), called from free_pages_prepare().  Do your testers
> > have CONFIG_DEBUG_VM enabled?  That might give you a fighting chance at
> > finding the last place which called put_page().  It won't necessarily be
> > the _wrong_ place to call put_page() (that may have happened earlier),
> > but it may give you a clue.
> > 
> > > > 
> > > > struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
> > > > 		int fgp_flags, gfp_t gfp)
> > > > {
> > > > 	struct folio *folio;
> > > > 
> > > > 	folio = __filemap_get_folio(mapping, index, fgp_flags, gfp);
> > > > 	if (IS_ERR(folio))
> > > > 		return NULL;
> > > > 	return folio_file_page(folio, index);
> > > > }
> > > > 
> > > > Thanks,
> > > > 
> > > > > -		f2fs_put_page(page, 1);
> > > > > -		goto repeat;
> > > > > -	}
> > > > > -	if (unlikely(!PageUptodate(page))) {
> > > > > +	if (unlikely(page->mapping != mapping || !PageUptodate(page))) {
> > > > >   		f2fs_put_page(page, 1);
> > > > >   		return ERR_PTR(-EIO);
> > > > >   	}

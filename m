Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0985C64234B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Dec 2022 08:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbiLEHBx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Dec 2022 02:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiLEHBv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Dec 2022 02:01:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868AAA1A1;
        Sun,  4 Dec 2022 23:01:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BCEA60F81;
        Mon,  5 Dec 2022 07:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8220CC433D7;
        Mon,  5 Dec 2022 07:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670223709;
        bh=lzxXV3+ISXJLTcSZoK/Rx7MfyjzLJVa7KZ1tVF5H5Q0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aCioxItJO/z/upse0Ms70j5KEz+lb31rcVNL0w01f1K2DmGGoJch2pKkPxULOJ9RR
         8h6EulekldlVjsIGws3GbvZnxx8HLuMlssIYi2I8YyB7LrS5qO8UsLuNar0lp6fuyk
         4NXXtlwkZ7D7BLYBe1BPtGEgqPvsoic+ihXSD7IYCiytdkcFHO9aPrt2Ev0FNRv/a8
         Wu+DoRjkWumCjjC2wjWtneV8cFPjj7rsHN4aIyt7fybID/4z4YC3+ww8A/zdzYwkK6
         o9Kre1b6wdQ9sHpOTMkaiv7CrODNynXvHKJEaC5xwGkwi9N8KSfCSyaMRs72OLPfN0
         2E9I2BUCYCEwA==
Date:   Sun, 4 Dec 2022 23:01:49 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, david@fromorbit.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2.1 1/8] fsdax: introduce page->share for fsdax in
 reflink mode
Message-ID: <Y42XXWY8L7EiL/p+@magnolia>
References: <1669908538-55-2-git-send-email-ruansy.fnst@fujitsu.com>
 <1669972991-246-1-git-send-email-ruansy.fnst@fujitsu.com>
 <638aaf72cba2a_3cbe029479@dwillia2-xfh.jf.intel.com.notmuch>
 <9c5528bf-b183-7e30-08e8-72ef9c0321ef@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c5528bf-b183-7e30-08e8-72ef9c0321ef@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 05, 2022 at 01:56:24PM +0800, Shiyang Ruan wrote:
> 
> 
> 在 2022/12/3 10:07, Dan Williams 写道:
> > Shiyang Ruan wrote:
> > > fsdax page is used not only when CoW, but also mapread. To make the it
> > > easily understood, use 'share' to indicate that the dax page is shared
> > > by more than one extent.  And add helper functions to use it.
> > > 
> > > Also, the flag needs to be renamed to PAGE_MAPPING_DAX_SHARED.
> > > 
> > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > ---
> > >   fs/dax.c                   | 38 ++++++++++++++++++++++----------------
> > >   include/linux/mm_types.h   |  5 ++++-
> > >   include/linux/page-flags.h |  2 +-
> > >   3 files changed, 27 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/fs/dax.c b/fs/dax.c
> > > index 1c6867810cbd..edbacb273ab5 100644
> > > --- a/fs/dax.c
> > > +++ b/fs/dax.c
> > > @@ -334,35 +334,41 @@ static unsigned long dax_end_pfn(void *entry)
> > >   	for (pfn = dax_to_pfn(entry); \
> > >   			pfn < dax_end_pfn(entry); pfn++)
> > > -static inline bool dax_mapping_is_cow(struct address_space *mapping)
> > > +static inline bool dax_page_is_shared(struct page *page)
> > >   {
> > > -	return (unsigned long)mapping == PAGE_MAPPING_DAX_COW;
> > > +	return (unsigned long)page->mapping == PAGE_MAPPING_DAX_SHARED;
> > >   }
> > >   /*
> > > - * Set the page->mapping with FS_DAX_MAPPING_COW flag, increase the refcount.
> > > + * Set the page->mapping with PAGE_MAPPING_DAX_SHARED flag, increase the
> > > + * refcount.
> > >    */
> > > -static inline void dax_mapping_set_cow(struct page *page)
> > > +static inline void dax_page_bump_sharing(struct page *page)
> > 
> > Similar to page_ref naming I would call this page_share_get() and the
> > corresponding function page_share_put().
> > 
> > >   {
> > > -	if ((uintptr_t)page->mapping != PAGE_MAPPING_DAX_COW) {
> > > +	if ((uintptr_t)page->mapping != PAGE_MAPPING_DAX_SHARED) {
> > >   		/*
> > >   		 * Reset the index if the page was already mapped
> > >   		 * regularly before.
> > >   		 */
> > >   		if (page->mapping)
> > > -			page->index = 1;
> > > -		page->mapping = (void *)PAGE_MAPPING_DAX_COW;
> > > +			page->share = 1;
> > > +		page->mapping = (void *)PAGE_MAPPING_DAX_SHARED;
> > 
> > Small nit, You could save a cast here by defining
> > PAGE_MAPPING_DAX_SHARED as "((void *) 1)".
> 
> Ok.

It's sort of a pity you can't pass around a pointer to a privately
defined const struct in dax.c.  But yeah, you might as well include the
cast in the macro definition.

> > 
> > >   	}
> > > -	page->index++;
> > > +	page->share++;
> > > +}
> > > +
> > > +static inline unsigned long dax_page_drop_sharing(struct page *page)
> > > +{
> > > +	return --page->share;
> > >   }
> > >   /*
> > > - * When it is called in dax_insert_entry(), the cow flag will indicate that
> > > + * When it is called in dax_insert_entry(), the shared flag will indicate that
> > >    * whether this entry is shared by multiple files.  If so, set the page->mapping
> > > - * FS_DAX_MAPPING_COW, and use page->index as refcount.
> > > + * PAGE_MAPPING_DAX_SHARED, and use page->share as refcount.
> > >    */
> > >   static void dax_associate_entry(void *entry, struct address_space *mapping,
> > > -		struct vm_area_struct *vma, unsigned long address, bool cow)
> > > +		struct vm_area_struct *vma, unsigned long address, bool shared)
> > >   {
> > >   	unsigned long size = dax_entry_size(entry), pfn, index;
> > >   	int i = 0;
> > > @@ -374,8 +380,8 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
> > >   	for_each_mapped_pfn(entry, pfn) {
> > >   		struct page *page = pfn_to_page(pfn);
> > > -		if (cow) {
> > > -			dax_mapping_set_cow(page);
> > > +		if (shared) {
> > > +			dax_page_bump_sharing(page);
> > >   		} else {
> > >   			WARN_ON_ONCE(page->mapping);
> > >   			page->mapping = mapping;
> > > @@ -396,9 +402,9 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
> > >   		struct page *page = pfn_to_page(pfn);
> > >   		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
> > > -		if (dax_mapping_is_cow(page->mapping)) {
> > > -			/* keep the CoW flag if this page is still shared */
> > > -			if (page->index-- > 0)
> > > +		if (dax_page_is_shared(page)) {
> > > +			/* keep the shared flag if this page is still shared */
> > > +			if (dax_page_drop_sharing(page) > 0)
> > >   				continue;
> > 
> > I think part of what makes this hard to read is trying to preserve the
> > same code paths for shared pages and typical pages.
> > 
> > page_share_put() should, in addition to decrementing the share, clear
> > out page->mapping value.
> 
> In order to be consistent, how about naming the 3 helper functions like
> this:
> 
> bool          dax_page_is_shared(struct page *page);
> void          dax_page_share_get(struct page *page);
> unsigned long dax_page_share_put(struct page *page);

_sharing_get/_sharing_put ?

Either way sounds fine to me.

--D

> 
> --
> Thanks,
> Ruan.
> 
> > 
> > >   		} else
> > >   			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
> > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > index 500e536796ca..f46cac3657ad 100644
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -103,7 +103,10 @@ struct page {
> > >   			};
> > >   			/* See page-flags.h for PAGE_MAPPING_FLAGS */
> > >   			struct address_space *mapping;
> > > -			pgoff_t index;		/* Our offset within mapping. */
> > > +			union {
> > > +				pgoff_t index;		/* Our offset within mapping. */
> > > +				unsigned long share;	/* share count for fsdax */
> > > +			};
> > >   			/**
> > >   			 * @private: Mapping-private opaque data.
> > >   			 * Usually used for buffer_heads if PagePrivate.
> > > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > > index 0b0ae5084e60..c8a3aa02278d 100644
> > > --- a/include/linux/page-flags.h
> > > +++ b/include/linux/page-flags.h
> > > @@ -641,7 +641,7 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
> > >    * Different with flags above, this flag is used only for fsdax mode.  It
> > >    * indicates that this page->mapping is now under reflink case.
> > >    */
> > > -#define PAGE_MAPPING_DAX_COW	0x1
> > > +#define PAGE_MAPPING_DAX_SHARED	0x1
> > >   static __always_inline bool folio_mapping_flags(struct folio *folio)
> > >   {
> > > -- 
> > > 2.38.1
> > > 
> > 
> > 

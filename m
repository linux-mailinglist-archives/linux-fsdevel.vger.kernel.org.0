Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9EC616D57
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 20:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiKBTDs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 15:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiKBTDr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:03:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B7522C
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Nov 2022 12:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667415774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UqcZSn2dIGg+txRUz0yg2pNp7hn+WnfiER5ZgqstaLw=;
        b=GaQrBokjqhx4GW7VWoymWqz6oeA9c+jzXa4ynZKTS/TsrfaVjqEm2mFiZIuJMvhYN1cZAi
        sZx5Nc4rhs5/QYQ//LHs/hiZ42ShC7gWm/3vpb2ZqpzFqbT0VBXeUUwCsukBW0BYLdJdmL
        BSJesUUI/qOrLoss5yvhS93pD/qOocE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-507-DKZZW40nPbq7lx6RGeLHIg-1; Wed, 02 Nov 2022 15:02:53 -0400
X-MC-Unique: DKZZW40nPbq7lx6RGeLHIg-1
Received: by mail-qt1-f198.google.com with SMTP id cm12-20020a05622a250c00b003a521f66e8eso7196219qtb.17
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Nov 2022 12:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqcZSn2dIGg+txRUz0yg2pNp7hn+WnfiER5ZgqstaLw=;
        b=ahhKGPolnFnPbmp5LcfRHP8+SKB57ayDGv8HBZ8EhSRwq7kVORXUoiS6DVo4/gnPSR
         qjqOvadW4tm6MUOHzpZ617d0mbl51DxFDwmIG7p9Qo3GdDVKXay0019SgFwhouiczcUR
         hdQEKMCcnX2DQYxnNUywlBvIP6bsB4ECZQvKKJDFG0NF5ukD/RugfBaarD6atUqCeVMn
         po1WzegYye6wIYz/ckTpFMqjH2qpgWg08QnJBMkPOtFj1+umb3DSK6MAXowYoFANtDzN
         /oq62R+RrpeaDCO55yYkGfesh0a6DLfUPAqSibSuMOuGIIn1c3/MwEY5qpB0ZS7GsKC/
         fhsQ==
X-Gm-Message-State: ACrzQf3t+qz/q7ae5x2vPmoDviWJgiGMR8DEhThH+5jqMirr/qANBdhk
        YKtNVEoY2sKJai5nONF7fRm/f0DMdR17jFjoPH/BqeItCE8g7peswzJnaItwDI7/yuQdDNDAxWr
        ZEJ7UXZ4s3kXE6F/3oHsmUMXotA==
X-Received: by 2002:a0c:e28a:0:b0:4b9:e578:1581 with SMTP id r10-20020a0ce28a000000b004b9e5781581mr22708701qvl.102.1667415767040;
        Wed, 02 Nov 2022 12:02:47 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6MCTCf/l3AxomdMLN6xadr+DHXOXgwS23JyXphBskH+IPvIsI6jm68HNZtMx+QppTeytMxpA==
X-Received: by 2002:a0c:e28a:0:b0:4b9:e578:1581 with SMTP id r10-20020a0ce28a000000b004b9e5781581mr22708077qvl.102.1667415757850;
        Wed, 02 Nov 2022 12:02:37 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id fx7-20020a05622a4ac700b003a4f6a566e9sm6990905qtb.83.2022.11.02.12.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 12:02:36 -0700 (PDT)
Date:   Wed, 2 Nov 2022 15:02:35 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH 3/5] userfualtfd: Replace lru_cache functions with
 folio_add functions
Message-ID: <Y2K+y7wnhC4vbnP2@x1n>
References: <20221101175326.13265-1-vishal.moola@gmail.com>
 <20221101175326.13265-4-vishal.moola@gmail.com>
 <Y2Fl/pZyLSw/ddZY@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XtXX9UT9oQ4Z3Adt"
Content-Disposition: inline
In-Reply-To: <Y2Fl/pZyLSw/ddZY@casper.infradead.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--XtXX9UT9oQ4Z3Adt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Nov 01, 2022 at 06:31:26PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 01, 2022 at 10:53:24AM -0700, Vishal Moola (Oracle) wrote:
> > Replaces lru_cache_add() and lru_cache_add_inactive_or_unevictable()
> > with folio_add_lru() and folio_add_lru_vma(). This is in preparation for
> > the removal of lru_cache_add().
> 
> Ummmmm.  Reviewing this patch reveals a bug (not introduced by your
> patch).  Look:
> 
> mfill_atomic_install_pte:
>         bool page_in_cache = page->mapping;
> 
> mcontinue_atomic_pte:
>         ret = shmem_get_folio(inode, pgoff, &folio, SGP_NOALLOC);
> ...
>         page = folio_file_page(folio, pgoff);
>         ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
>                                        page, false, wp_copy);
> 
> That says pretty plainly that mfill_atomic_install_pte() can be passed
> a tail page from shmem, and if it is ...
> 
>         if (page_in_cache) {
> ...
>         } else {
>                 page_add_new_anon_rmap(page, dst_vma, dst_addr);
>                 lru_cache_add_inactive_or_unevictable(page, dst_vma);
>         }
> 
> it'll get put on the rmap as an anon page!

Hmm yeah.. thanks Matthew!

Does the patch attached look reasonable to you?

Copying Axel too.

> 
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >  mm/userfaultfd.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index e24e8a47ce8a..2560973b00d8 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -66,6 +66,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> >  	bool vm_shared = dst_vma->vm_flags & VM_SHARED;
> >  	bool page_in_cache = page->mapping;
> >  	spinlock_t *ptl;
> > +	struct folio *folio;
> >  	struct inode *inode;
> >  	pgoff_t offset, max_off;
> >  
> > @@ -113,14 +114,15 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> >  	if (!pte_none_mostly(*dst_pte))
> >  		goto out_unlock;
> >  
> > +	folio = page_folio(page);
> >  	if (page_in_cache) {
> >  		/* Usually, cache pages are already added to LRU */
> >  		if (newly_allocated)
> > -			lru_cache_add(page);
> > +			folio_add_lru(folio);
> >  		page_add_file_rmap(page, dst_vma, false);
> >  	} else {
> >  		page_add_new_anon_rmap(page, dst_vma, dst_addr);
> > -		lru_cache_add_inactive_or_unevictable(page, dst_vma);
> > +		folio_add_lru_vma(folio, dst_vma);
> >  	}
> >  
> >  	/*
> > -- 
> > 2.38.1
> > 
> > 
> 

-- 
Peter Xu

--XtXX9UT9oQ4Z3Adt
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-mm-shmem-Use-page_mapping-to-detect-page-cache-for-u.patch"

From 4eea0908b4890745bedd931283c1af91f509d039 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 2 Nov 2022 14:41:52 -0400
Subject: [PATCH] mm/shmem: Use page_mapping() to detect page cache for uffd
 continue
Content-type: text/plain

mfill_atomic_install_pte() checks page->mapping to detect whether one page
is used in the page cache.  However as pointed out by Matthew, the page can
logically be a tail page rather than always the head in the case of uffd
minor mode with UFFDIO_CONTINUE.  It means we could wrongly install one pte
with shmem thp tail page assuming it's an anonymous page.

It's not that clear even for anonymous page, since normally anonymous pages
also have page->mapping being setup with the anon vma. It's safe here only
because the only such caller to mfill_atomic_install_pte() is always
passing in a newly allocated page (mcopy_atomic_pte()), whose page->mapping
is not yet setup.  However that's not extremely obvious either.

For either of above, use page_mapping() instead.

And this should be stable material.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: stable@vger.kernel.org
Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 3d0fef3980b3..650ab6cfd5f4 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -64,7 +64,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	pte_t _dst_pte, *dst_pte;
 	bool writable = dst_vma->vm_flags & VM_WRITE;
 	bool vm_shared = dst_vma->vm_flags & VM_SHARED;
-	bool page_in_cache = page->mapping;
+	bool page_in_cache = page_mapping(page);
 	spinlock_t *ptl;
 	struct inode *inode;
 	pgoff_t offset, max_off;
-- 
2.37.3


--XtXX9UT9oQ4Z3Adt--


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5692D616F03
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 21:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiKBUpV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 16:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiKBUpU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:45:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B38F6559
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Nov 2022 13:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667421861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W/vNqEe9kdMiUGr3xRIJxtzc4rwHsL9U2+4y8NsyPqk=;
        b=Ivj2/+OQ25XcTAxn+n42nCQLBjS0h13IVSPYbvbPjASNJstCNnry29ReLvgT1v2OmXvbj3
        xa4H37uZfZsWXjjppZxTj78AA+bA2v9eQgVBZXP0hcxNsxOzwDv03cU3ki0qkv5OVEXCmo
        poVCxa1pi6sMZ7MA3seZ8XwvODyUZz8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-121-0NtScs11PxSkcW35SI-u4w-1; Wed, 02 Nov 2022 16:44:20 -0400
X-MC-Unique: 0NtScs11PxSkcW35SI-u4w-1
Received: by mail-qt1-f198.google.com with SMTP id cp8-20020a05622a420800b003a4f4f7b621so123760qtb.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Nov 2022 13:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/vNqEe9kdMiUGr3xRIJxtzc4rwHsL9U2+4y8NsyPqk=;
        b=WQBJSF33msxQA0sKbP8lKKj5OMwjqH2ykuArKVYFdZ3FCJWxgxmTQTm/4Uc37pTWCU
         FouO2va1qVGaBZhhoKRePXarEr5S6dJ5gmLldoGxo3QLIr8dBwePRO8h1qr0TiuIfawv
         0v2U2Yv3Db6ON9mhC/aonb+0zlW6q5IF1dHGzApC1fQRYeqSg3JgU5Chs/n+s95KhfYd
         DBwL5o6KhxUB61BHY0Ko8q37BiJLA2lyurgQ+TB8UBD74FZed2JHJId0H94hykCCFTGx
         wMLlCFMLdi34ZvGhR4U3CJOnc/I9M21GAfQAL9X2I+a4xQ8JezzlJysqZrxp0xBC1J+C
         hm8g==
X-Gm-Message-State: ACrzQf3AVw0vgZDn5BNxvC1I/Mf4iWVGHR59uufUCz+6MlT/CKtyCU9/
        I9c0ykt0HDfhKHVmp0lyhmCaIZ4ApJEUbcN9WpRienXzo2xYB8ZiKvZbqc3w79Y3xIm+82CQqp9
        kjMgz7uGMModCkvXEy1x7EWzCgw==
X-Received: by 2002:a37:c4d:0:b0:6fa:b44:1610 with SMTP id 74-20020a370c4d000000b006fa0b441610mr18938085qkm.153.1667421860290;
        Wed, 02 Nov 2022 13:44:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM45PiqOchTm473K6yukASrI7J3XtwxvJ2ubdKVdWdx5zZccQ1R7pEO4ceI62cTHD1N+1bBGJA==
X-Received: by 2002:a37:c4d:0:b0:6fa:b44:1610 with SMTP id 74-20020a370c4d000000b006fa0b441610mr18938066qkm.153.1667421860080;
        Wed, 02 Nov 2022 13:44:20 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id w20-20020a05620a445400b006cbe3be300esm1873284qkp.12.2022.11.02.13.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:44:19 -0700 (PDT)
Date:   Wed, 2 Nov 2022 16:44:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH 3/5] userfualtfd: Replace lru_cache functions with
 folio_add functions
Message-ID: <Y2LWonzCdWkDwyyr@x1n>
References: <20221101175326.13265-1-vishal.moola@gmail.com>
 <20221101175326.13265-4-vishal.moola@gmail.com>
 <Y2Fl/pZyLSw/ddZY@casper.infradead.org>
 <Y2K+y7wnhC4vbnP2@x1n>
 <Y2LDL8zjgxDPCzH9@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2LDL8zjgxDPCzH9@casper.infradead.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 02, 2022 at 07:21:19PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 02, 2022 at 03:02:35PM -0400, Peter Xu wrote:
> > Does the patch attached look reasonable to you?
> 
> Mmm, no.  If the page is in the swap cache, this will be "true".

It will not happen in practise, right?

I mean, shmem_get_folio() should have done the swap-in, and we should have
the page lock held at the meantime.

For anon, mcopy_atomic_pte() is the only user and it's passing in a newly
allocated page here.

> 
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 3d0fef3980b3..650ab6cfd5f4 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -64,7 +64,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> >  	pte_t _dst_pte, *dst_pte;
> >  	bool writable = dst_vma->vm_flags & VM_WRITE;
> >  	bool vm_shared = dst_vma->vm_flags & VM_SHARED;
> > -	bool page_in_cache = page->mapping;
> > +	bool page_in_cache = page_mapping(page);
> 
> We could do:
> 
> 	struct page *head = compound_head(page);
> 	bool page_in_cache = head->mapping && !PageMappingFlags(head);

Sounds good to me, but it just gets a bit complicated.

If page_mapping() doesn't sound good, how about we just pass that over from
callers?  We only have three, so quite doable too.

-- 
Peter Xu


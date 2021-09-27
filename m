Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31E6419DF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 20:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbhI0SSh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 14:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbhI0SSg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:18:36 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF34C061575;
        Mon, 27 Sep 2021 11:16:58 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id a9so11786571qvf.0;
        Mon, 27 Sep 2021 11:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ktSTORNNq8S1FcURLzITo6BxzVuTeC9E0wfbs37JzGc=;
        b=IT1kjY/if5cD1zKyRa9VUjaXJt1swUgBNyRGFvHbY+Fq4bG85GPx4BaEtxUVVeqcgA
         Z6xG1wzGSwjXoTdi8mzfQ2uHaI6iEJgl2fM+fdYS6B00f6xuSxrUj8e+am6pHvNYjsg0
         K5PJ8ezDoztXKy5wNvLwqBMS/exbl9kVlRAeNtyIBeCMBG/+TFXH+23QWSwGwVB7ZT++
         SLOFFd35BptSD8SR1pv3WM+Hyyc6hL19Ltg7KEP0tH2oKCNlABNEtwUXkrUqzT5CI80A
         umc+oWVeyhAhcCqDpvm/BFeblbMAgwlAq97wXwtNbTrEjCLIKVcX2107DzjzATYZg+23
         b6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ktSTORNNq8S1FcURLzITo6BxzVuTeC9E0wfbs37JzGc=;
        b=0fp2JDYCnSgZLcoOPofrRuru5IEfcOLdU8BwuWx13vyoHgNx49VNYvbzcIkFla7Mto
         l21l/sigLWPSHgglb4i8ms8Nvp+cwCLESxKnnnot6YmlbDDcyllWP7AOOQ6afUlVe0j3
         T2mPpMJXVVZfz38x8rUoo/9bXbvOM4SIT3x8u1g94kJIMixMCUc1g6mc0lce+ByPmtBN
         OdNbK0Fo5Zkj2+Y6ujgwdmUkWk1RNe6MSaMXVGJRNfFGuZOSde6H3ipBJKyVjukJdaNH
         UF/oOa/W4dJo2BYBioU6U2XQnqbVwWsZF8Xi9fJ9ZkQ/b1zBX27TCXz211gWAEQsfXWV
         54Pw==
X-Gm-Message-State: AOAM5329b0jjydCykb3TwkklRVCF9/u5ZMXlpz9rWB0QE1OYCDw+jR0X
        n4qvcvb09coO+LjRlF7GycewrI+JcJnY
X-Google-Smtp-Source: ABdhPJwzHqe1Z/6WYpHdZTlByURoz+WpRNXlH8q4EUdr7WookqRdsvv9RU2H2t630rE/aczNPs2anQ==
X-Received: by 2002:a05:6214:56e:: with SMTP id cj14mr162544qvb.10.1632766617610;
        Mon, 27 Sep 2021 11:16:57 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id m24sm12875570qki.40.2021.09.27.11.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 11:16:55 -0700 (PDT)
Date:   Mon, 27 Sep 2021 14:16:53 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Struct page proposal
Message-ID: <YVIKlcgvN19BSZsu@moria.home.lan>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
 <bc22b4d0-ba63-4559-88d9-a510da233cad@suse.cz>
 <YVIH5j5xkPafvNds@casper.infradead.org>
 <YVII7eM7P42riwoI@moria.home.lan>
 <YVIJg+kNqqbrBZFW@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVIJg+kNqqbrBZFW@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 07:12:19PM +0100, Matthew Wilcox wrote:
> On Mon, Sep 27, 2021 at 02:09:49PM -0400, Kent Overstreet wrote:
> > On Mon, Sep 27, 2021 at 07:05:26PM +0100, Matthew Wilcox wrote:
> > > On Mon, Sep 27, 2021 at 07:48:15PM +0200, Vlastimil Babka wrote:
> > > > On 9/23/21 03:21, Kent Overstreet wrote:
> > > > > So if we have this:
> > > > > 
> > > > > struct page {
> > > > > 	unsigned long	allocator;
> > > > > 	unsigned long	allocatee;
> > > > > };
> > > > > 
> > > > > The allocator field would be used for either a pointer to slab/slub's state, if
> > > > > it's a slab page, or if it's a buddy allocator page it'd encode the order of the
> > > > > allocation - like compound order today, and probably whether or not the
> > > > > (compound group of) pages is free.
> > > > 
> > > > The "free page in buddy allocator" case will be interesting to implement.
> > > > What the buddy allocator uses today is:
> > > > 
> > > > - PageBuddy - determine if page is free; a page_type (part of mapcount
> > > > field) today, could be a bit in "allocator" field that would have to be 0 in
> > > > all other "page is allocated" contexts.
> > > > - nid/zid - to prevent merging accross node/zone boundaries, now part of
> > > > page flags
> > > > - buddy order
> > > > - a list_head (reusing the "lru") to hold the struct page on the appropriate
> > > > free list, which has to be double-linked so page can be taken from the
> > > > middle of the list instantly
> > > > 
> > > > Won't be easy to cram all that into two unsigned long's, or even a single
> > > > one. We should avoid storing anything in the free page itself. Allocating
> > > > some external structures to track free pages is going to have funny
> > > > bootstrap problems. Probably a major redesign would be needed...
> > > 
> > > Wait, why do we want to avoid using the memory that we're allocating?
> > 
> > The issue is where to stick the state for free pages. If that doesn't fit in two
> > ulongs, then we'd need a separate allocation, which means slab needs to be up
> > and running before free pages are initialized.
> 
> But the thing we're allocating is at least PAGE_SIZE bytes in size.
> Why is "We should avoid storing anything in the free page itself" true?

Good point!

Highmem and dax do complicate things though - would they make it too much of a
hassle? You want to get rid of struct page for dax (what's the right term for
that kind of memory?), but we're not there yet, right?

Very curious why we need to be able to pull pages off the middle of a freelist.
If we can make do with singly linked freelists, then I think two ulongs would be
sufficient.

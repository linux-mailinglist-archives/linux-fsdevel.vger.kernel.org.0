Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99851419E5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 20:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbhI0Sfd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 14:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbhI0Sfc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:35:32 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D96C061575
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Sep 2021 11:33:53 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id b15so80251172lfe.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Sep 2021 11:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OkJDRTajjBYXZ9Lg7Znrw7BKNW4OCn6XI+sAVpYq6QI=;
        b=qdXZo0VKKvGxILef7JmwcenBcQKasiE54pz+WtZ2c1nuNKo0FWwkU4SAgC8IVJn75f
         mjCpRzf2uF1ul1E1lLRt6og0U0UE8lupicpoy8MsJhx87RW7ZRF2/IiAQk3X1EUkad/H
         SVS+td1Hcckzl3bVIQ07SGPH73T8NApdeMk8LCcoF2OmE1LvJCngQws8nZxjbVLviqFi
         MxSH0Z+tnuLGIuvHGzZCKU2j4H7he35g2cRq+JBRytRejIalREMLXhS8wizSW8YBtCx5
         yBzTEMlPIXVM4MsxAAcqg2DzUqMznWk6dIwbo5IJOFQPk0OMFQy66/jsTIEPNfLt13Kq
         kzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OkJDRTajjBYXZ9Lg7Znrw7BKNW4OCn6XI+sAVpYq6QI=;
        b=z9Y0BYFRwwGgplahfr7ZcgOIsvRQwr3oNQ9HTOjoKCD8JMF1hu7ZYYA+vVfiEipie4
         HKhcJ9P5oDSVYj82eUH/+ZFiu8EUEf/6PuQJSV00GU1Oc2SGsvrCMv8LLogAhB7M9Cnf
         Veg0zsJi3W+2Q8l+FvX0JFx2NxiBAo1BDSrXVAGtfhYOcaazW+lw+2y8LYYOlwjHDC3f
         gBCv6NTmqswpeWraYcHD0HQLrthhk3sdsbjzTYkiSnsk5IbzebHZ6okH7u43pKmlqjlg
         tMNl5R8P3dBE9QSbxmlQGQDPO06bl4eJc7q51eWpK2kBaG5VEdoBaAsifLTnOD8SRvLA
         U5VQ==
X-Gm-Message-State: AOAM531uqQ+W90MyXksf2GyekinicMTsssN9tl/ShAMhObLW7WLPJhmZ
        l83S5nHKl1C5AD7ysQhUbRJ3Zw==
X-Google-Smtp-Source: ABdhPJzWZh6daO8VsDoVks7ChKfKV/MwaTxKX73LmO60ysmNU0X0sNpEippMfCo/ilGu6AoJUJdENA==
X-Received: by 2002:ac2:561c:: with SMTP id v28mr1153727lfd.457.1632767631753;
        Mon, 27 Sep 2021 11:33:51 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n9sm1672309lfu.88.2021.09.27.11.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 11:33:51 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E89C5102FE0; Mon, 27 Sep 2021 21:33:50 +0300 (+03)
Date:   Mon, 27 Sep 2021 21:33:50 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Struct page proposal
Message-ID: <20210927183350.obd756wnsctukf63@box.shutemov.name>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
 <bc22b4d0-ba63-4559-88d9-a510da233cad@suse.cz>
 <YVIH5j5xkPafvNds@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVIH5j5xkPafvNds@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 07:05:26PM +0100, Matthew Wilcox wrote:
> On Mon, Sep 27, 2021 at 07:48:15PM +0200, Vlastimil Babka wrote:
> > On 9/23/21 03:21, Kent Overstreet wrote:
> > > So if we have this:
> > > 
> > > struct page {
> > > 	unsigned long	allocator;
> > > 	unsigned long	allocatee;
> > > };
> > > 
> > > The allocator field would be used for either a pointer to slab/slub's state, if
> > > it's a slab page, or if it's a buddy allocator page it'd encode the order of the
> > > allocation - like compound order today, and probably whether or not the
> > > (compound group of) pages is free.
> > 
> > The "free page in buddy allocator" case will be interesting to implement.
> > What the buddy allocator uses today is:
> > 
> > - PageBuddy - determine if page is free; a page_type (part of mapcount
> > field) today, could be a bit in "allocator" field that would have to be 0 in
> > all other "page is allocated" contexts.
> > - nid/zid - to prevent merging accross node/zone boundaries, now part of
> > page flags
> > - buddy order
> > - a list_head (reusing the "lru") to hold the struct page on the appropriate
> > free list, which has to be double-linked so page can be taken from the
> > middle of the list instantly
> > 
> > Won't be easy to cram all that into two unsigned long's, or even a single
> > one. We should avoid storing anything in the free page itself. Allocating
> > some external structures to track free pages is going to have funny
> > bootstrap problems. Probably a major redesign would be needed...
> 
> Wait, why do we want to avoid using the memory that we're allocating?

Intel TDX and AMD-SEV have concept of unaccpeted memory. You cannot use
the memory until it got "accepted". The acceptance is costly and I made a
patchset[1] to pospone the accaptance until the first allocation. So pages
are on free list, but page type indicate that it has to go though
additional step on allocation.

[1] https://lore.kernel.org/all/20210810062626.1012-1-kirill.shutemov@linux.intel.com/

-- 
 Kirill A. Shutemov

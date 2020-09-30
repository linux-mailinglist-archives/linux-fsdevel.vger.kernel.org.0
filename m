Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5CD27DEBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 05:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgI3DNk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 23:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgI3DNk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 23:13:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D14C061755;
        Tue, 29 Sep 2020 20:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZdPsP/+B1OF420qqHgB+/SxMYEAFyf2O+eNfuVQ7neg=; b=pcQTc4aAZnW0R9sFBt3cL+TWW2
        UFhibNgovuZb7lVeEiW2VQuRLrhkVRCtOGu38lpi0Fq6INx3+iPr0GodqLPFtavq3SO5mhE43/8Pw
        zOjjZ/Z2WJQ82xE6yTM5fRoFCKT9fGUOi0mtn3dJafoT97dd1gXtp45WIGdjGtojk8lO+FX/+S995
        laKMTXrPutRO2RM92p3K6qygPeAG25AuxdGkf11idsufBTPq/lPyXh1re1B9bl4GDDtsoqSr69KGS
        6E5A8/HBI10VK3Pd69FxUmPhZjco+K3tav8KBqQ3HUTDZus1LC4TnmhplcQ0k+G6NNP9qKuwCiJBB
        38GQyy+g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNSYB-0008Ti-S1; Wed, 30 Sep 2020 03:13:04 +0000
Date:   Wed, 30 Sep 2020 04:13:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 00/24] mm/hugetlb: Free some vmemmap pages of hugetlb
 page
Message-ID: <20200930031303.GN20115@casper.infradead.org>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
 <31eac1d8-69ba-ed2f-8e47-d957d6bb908c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31eac1d8-69ba-ed2f-8e47-d957d6bb908c@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 29, 2020 at 02:58:18PM -0700, Mike Kravetz wrote:
> On 9/15/20 5:59 AM, Muchun Song wrote:
> > Hi all,
> > 
> > This patch series will free some vmemmap pages(struct page structures)
> > associated with each hugetlbpage when preallocated to save memory.
> ...
> > The mapping of the first page(index 0) and the second page(index 1) is
> > unchanged. The remaining 6 pages are all mapped to the same page(index
> > 1). So we only need 2 pages for vmemmap area and free 6 pages to the
> > buddy system to save memory. Why we can do this? Because the content
> > of the remaining 7 pages are usually same except the first page.
> > 
> > When a hugetlbpage is freed to the buddy system, we should allocate 6
> > pages for vmemmap pages and restore the previous mapping relationship.
> > 
> > If we uses the 1G hugetlbpage, we can save 4095 pages. This is a very
> > substantial gain. On our server, run some SPDK applications which will
> > use 300GB hugetlbpage. With this feature enabled, we can save 4797MB
> > memory.
> 
> At a high level this seems like a reasonable optimization for hugetlb
> pages.  It is possible because hugetlb pages are 'special' and mostly
> handled differently than pages in normal mm paths.
> 
> The majority of the new code is hugetlb specific, so it should not be
> of too much concern for the general mm code paths.  I'll start looking
> closer at the series.  However, if someone has high level concerns please
> let us know.  The only 'potential' conflict I am aware of is discussion
> about support of double mapping hugetlb pages.

Not on x86, but architectures which have dcache coherency issues sometimes
use PG_arch_1 on the subpages.  I think it would be wise to map pages
1-7 read-only to catch this, as well as any future change which causes
subpage bits to get set.

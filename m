Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E569676351B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 13:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjGZLgk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 07:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbjGZLgj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:36:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02C51FF5;
        Wed, 26 Jul 2023 04:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690371396; x=1721907396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SuZ1oLRGv+DogObqtc+f4FAjzMjj7hxAmbmabhNK8B0=;
  b=YwqBcgsJcGwfBSXAHnFBe8hOQs8ODXjZM9yj8hfDNYOjWZvTDY0+h2Jc
   Hrv5gkXkfQE6ytovplwZ9uCzhKgPqAyGvirSWrkB0j1rZ4aUvMLBgj9kj
   LPqMig0JErSMbGNrUvktZSOm1bef5FydCzX9hGdpOxI6HrspAyfbyPZ5g
   /bAi469mGKG0Bcus/TfMPVn8qsUL9QtN8T2Ht/rrCWA5fwLHERjcG0zoH
   qJgSsG+KynZufzzwcVJXagVg3G5Sdqoff2+pJeYVSaLwjfNHDPpmy5MiK
   L9MGin1+anEQIuTLEiJcfFEq5iHxLuoku5jOHH2TMHn9wdrMr23kvmGu6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="371598752"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="371598752"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 04:36:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="729807753"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="729807753"
Received: from mbrdon-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.209.47])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 04:36:21 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 8BCEB109503; Wed, 26 Jul 2023 14:36:17 +0300 (+03)
Date:   Wed, 26 Jul 2023 14:36:17 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>
Subject: Re: [RFC PATCH v11 10/29] mm: Add AS_UNMOVABLE to mark mapping as
 completely unmovable
Message-ID: <20230726113617.432nuovswn6odcmx@box>
References: <20230718234512.1690985-1-seanjc@google.com>
 <20230718234512.1690985-11-seanjc@google.com>
 <20230725102403.xywjqlhyqkrzjok6@box.shutemov.name>
 <ZL/Fa4W2Ne9EVxoh@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL/Fa4W2Ne9EVxoh@casper.infradead.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 25, 2023 at 01:51:55PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 25, 2023 at 01:24:03PM +0300, Kirill A . Shutemov wrote:
> > On Tue, Jul 18, 2023 at 04:44:53PM -0700, Sean Christopherson wrote:
> > > diff --git a/mm/compaction.c b/mm/compaction.c
> > > index dbc9f86b1934..a3d2b132df52 100644
> > > --- a/mm/compaction.c
> > > +++ b/mm/compaction.c
> > > @@ -1047,6 +1047,10 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
> > >  		if (!mapping && (folio_ref_count(folio) - 1) > folio_mapcount(folio))
> > >  			goto isolate_fail_put;
> > >  
> > > +		/* The mapping truly isn't movable. */
> > > +		if (mapping && mapping_unmovable(mapping))
> > > +			goto isolate_fail_put;
> > > +
> > 
> > I doubt that it is safe to dereference mapping here. I believe the folio
> > can be truncated from under us and the mapping freed with the inode.
> > 
> > The folio has to be locked to dereference mapping safely (given that the
> > mapping is still tied to the folio).
> 
> There's even a comment to that effect later on in the function:
> 
>                         /*
>                          * Only pages without mappings or that have a
>                          * ->migrate_folio callback are possible to migrate
>                          * without blocking. However, we can be racing with
>                          * truncation so it's necessary to lock the page
>                          * to stabilise the mapping as truncation holds
>                          * the page lock until after the page is removed
>                          * from the page cache.
>                          */
> 
> (that could be reworded to make it clear how dangerous dereferencing
> ->mapping is without the lock ... and it does need to be changed to say
> "folio lock" instead of "page lock", so ...)
> 
> How does this look?
> 
>                         /*
>                          * Only folios without mappings or that have
>                          * a ->migrate_folio callback are possible to
>                          * migrate without blocking. However, we can
>                          * be racing with truncation, which can free
>                          * the mapping.  Truncation holds the folio lock
>                          * until after the folio is removed from the page
>                          * cache so holding it ourselves is sufficient.
>                          */
> 

Looks good to me.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

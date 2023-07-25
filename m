Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F987618E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 14:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjGYMw1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 08:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjGYMw0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:52:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04449DB;
        Tue, 25 Jul 2023 05:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cip1L4+WNN72lEdlEtgKKz6+Th/GNW6kyU+RnxFbZZ8=; b=UgAJBFRLO20d1Q4UeecSqlBQIs
        PFHuz0NUmB/1Y+2cEVFvwqnHb1BSxWW4RhQ2P8kvsu3ACbwOqr57viJKTa7uG+qe1fdufl5rqF2qr
        jHy5L3HlBpbKr1Vl5EefvCAyn8+oe9n/K+eN0UUCvHZ3OgwtPhyspcNh4yAoE49KOIUkQVp2v0HR9
        +xKnn/gm3dSYH0IDK2KkKvdpo4YPQW6CLliHGifFEImfRxrevzUzbI0xJBT7SCfU6e7LIrXsQ1mlT
        uc0IdyK39Z/Ut2VF+t8tpW9pm9g50y0Q3SwS/URKZyTPqyVYvUikuYgn7PDUb1oSxM38pOnLhiEyt
        M5/wJdyg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qOHW7-005Tcv-AA; Tue, 25 Jul 2023 12:51:55 +0000
Date:   Tue, 25 Jul 2023 13:51:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
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
Message-ID: <ZL/Fa4W2Ne9EVxoh@casper.infradead.org>
References: <20230718234512.1690985-1-seanjc@google.com>
 <20230718234512.1690985-11-seanjc@google.com>
 <20230725102403.xywjqlhyqkrzjok6@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725102403.xywjqlhyqkrzjok6@box.shutemov.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 25, 2023 at 01:24:03PM +0300, Kirill A . Shutemov wrote:
> On Tue, Jul 18, 2023 at 04:44:53PM -0700, Sean Christopherson wrote:
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index dbc9f86b1934..a3d2b132df52 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -1047,6 +1047,10 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
> >  		if (!mapping && (folio_ref_count(folio) - 1) > folio_mapcount(folio))
> >  			goto isolate_fail_put;
> >  
> > +		/* The mapping truly isn't movable. */
> > +		if (mapping && mapping_unmovable(mapping))
> > +			goto isolate_fail_put;
> > +
> 
> I doubt that it is safe to dereference mapping here. I believe the folio
> can be truncated from under us and the mapping freed with the inode.
> 
> The folio has to be locked to dereference mapping safely (given that the
> mapping is still tied to the folio).

There's even a comment to that effect later on in the function:

                        /*
                         * Only pages without mappings or that have a
                         * ->migrate_folio callback are possible to migrate
                         * without blocking. However, we can be racing with
                         * truncation so it's necessary to lock the page
                         * to stabilise the mapping as truncation holds
                         * the page lock until after the page is removed
                         * from the page cache.
                         */

(that could be reworded to make it clear how dangerous dereferencing
->mapping is without the lock ... and it does need to be changed to say
"folio lock" instead of "page lock", so ...)

How does this look?

                        /*
                         * Only folios without mappings or that have
                         * a ->migrate_folio callback are possible to
                         * migrate without blocking. However, we can
                         * be racing with truncation, which can free
                         * the mapping.  Truncation holds the folio lock
                         * until after the folio is removed from the page
                         * cache so holding it ourselves is sufficient.
                         */


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C5B761098
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 12:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjGYKYQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 06:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjGYKYP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:24:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE76610CB;
        Tue, 25 Jul 2023 03:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690280654; x=1721816654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z2JgSRr57QfGjyG/fWEsaikXL6iwmaxUOjUdDAVtI0A=;
  b=RAb1leraqX5Fyk6HEvP9T703FMF8+1ubL2WTdk/W6M/nh63j8c+gyD+8
   ldRTrTyztR8vGBwEyJBHK/SKadmUhsiA5MNJhy320hC3kWAsd4iVQvyqE
   vocuEeelD/8dgxtS4meTWHDD6+8OFU71+q7VGTjK8GzSrh+pQMKBqj4lO
   PtGq4nWE63jDDBOpj7/++pecb/44c/1zSJ8GzeI8AHU5vUWLycMbWy9kB
   SQjl51FS33cwUBefU91alkr6ZhH8JkeI4sXAoyFDQGLHNnLY5QW7FBGOv
   3DHGaDlfGuMlMytnRXm+SJkBfa1KcZtuTESmJfCmD1JZXK6uEH9O8Wasw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="347956818"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="347956818"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 03:24:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="1056753039"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="1056753039"
Received: from mlytkin-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.57.129])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 03:24:05 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 171E4103A12; Tue, 25 Jul 2023 13:24:03 +0300 (+03)
Date:   Tue, 25 Jul 2023 13:24:03 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
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
Message-ID: <20230725102403.xywjqlhyqkrzjok6@box.shutemov.name>
References: <20230718234512.1690985-1-seanjc@google.com>
 <20230718234512.1690985-11-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718234512.1690985-11-seanjc@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 18, 2023 at 04:44:53PM -0700, Sean Christopherson wrote:
> diff --git a/mm/compaction.c b/mm/compaction.c
> index dbc9f86b1934..a3d2b132df52 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1047,6 +1047,10 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  		if (!mapping && (folio_ref_count(folio) - 1) > folio_mapcount(folio))
>  			goto isolate_fail_put;
>  
> +		/* The mapping truly isn't movable. */
> +		if (mapping && mapping_unmovable(mapping))
> +			goto isolate_fail_put;
> +

I doubt that it is safe to dereference mapping here. I believe the folio
can be truncated from under us and the mapping freed with the inode.

The folio has to be locked to dereference mapping safely (given that the
mapping is still tied to the folio).

Vlastimil, any comments?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CE95B3ABD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 16:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiIIOdR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 10:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiIIOdO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:33:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3743FEB2D0;
        Fri,  9 Sep 2022 07:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662733993; x=1694269993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gVTNsSyIBrhcPs2gtAOglD6dY69wve4jHFwcbsEjqEg=;
  b=YCNEJkUgYMvWX8Ca4SiKVEusdseonO3G0U4IIfFgagOuXhrp5ATI+xoL
   clsCmxL2VpJTPd8Jf0S73lg35hTTeVQYfs0DE1DC4/9o3RdFew1Bb8Cfi
   r5Q1b8+O2G0OGmf1wDRoO123R9/AQAOzdjs8u8pQERZUwTZKIqEMBBN/N
   3TLwrT++bDZY5bamSYL1XJhPdx028iyckiaOCjp/a+A1NPHa32X7gnLaM
   pBj0zjJPdsbItTxwtdxJ1wE0fd8JqPDsYqnrXwcaGZdFjui792kJezeH8
   A5x2o6EI425Iui/OnAFkyq57g5wWuWugeHhU3LEeSUxbhUsJDqEu54izA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="295068205"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="295068205"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 07:32:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="757619409"
Received: from sumitdes-mobl3.gar.corp.intel.com (HELO box.shutemov.name) ([10.249.45.93])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 07:32:39 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id ED94B1037A2; Fri,  9 Sep 2022 17:32:36 +0300 (+03)
Date:   Fri, 9 Sep 2022 17:32:36 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, jun.nakajima@intel.com,
        dave.hansen@intel.com, ak@linux.intel.com, david@redhat.com,
        aarcange@redhat.com, ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20220909143236.sznwzkpedldrlnn5@box.shutemov.name>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com>
 <20220818132421.6xmjqduempmxnnu2@box>
 <c6ccbb96-5849-2e2f-3b49-4ea711af525d@google.com>
 <20220820002700.6yflrxklmpsavdzi@box.shutemov.name>
 <95bd287b-d17f-fda8-58c9-20700b1e0c72@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95bd287b-d17f-fda8-58c9-20700b1e0c72@kernel.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 08, 2022 at 09:48:35PM -0700, Andy Lutomirski wrote:
> On 8/19/22 17:27, Kirill A. Shutemov wrote:
> > On Thu, Aug 18, 2022 at 08:00:41PM -0700, Hugh Dickins wrote:
> > > On Thu, 18 Aug 2022, Kirill A . Shutemov wrote:
> > > > On Wed, Aug 17, 2022 at 10:40:12PM -0700, Hugh Dickins wrote:
> > > > > 
> > > > > If your memory could be swapped, that would be enough of a good reason
> > > > > to make use of shmem.c: but it cannot be swapped; and although there
> > > > > are some references in the mailthreads to it perhaps being swappable
> > > > > in future, I get the impression that will not happen soon if ever.
> > > > > 
> > > > > If your memory could be migrated, that would be some reason to use
> > > > > filesystem page cache (because page migration happens to understand
> > > > > that type of memory): but it cannot be migrated.
> > > > 
> > > > Migration support is in pipeline. It is part of TDX 1.5 [1]. And swapping
> > > > theoretically possible, but I'm not aware of any plans as of now.
> > > > 
> > > > [1] https://www.intel.com/content/www/us/en/developer/articles/technical/intel-trust-domain-extensions.html
> > > 
> > > I always forget, migration means different things to different audiences.
> > > As an mm person, I was meaning page migration, whereas a virtualization
> > > person thinks VM live migration (which that reference appears to be about),
> > > a scheduler person task migration, an ornithologist bird migration, etc.
> > > 
> > > But you're an mm person too: you may have cited that reference in the
> > > knowledge that TDX 1.5 Live Migration will entail page migration of the
> > > kind I'm thinking of.  (Anyway, it's not important to clarify that here.)
> > 
> > TDX 1.5 brings both.
> > 
> > In TDX speak, mm migration called relocation. See TDH.MEM.PAGE.RELOCATE.
> > 
> 
> This seems to be a pretty bad fit for the way that the core mm migrates
> pages.  The core mm unmaps the page, then moves (in software) the contents
> to a new address, then faults it in.  TDH.MEM.PAGE.RELOCATE doesn't fit into
> that workflow very well.  I'm not saying it can't be done, but it won't just
> work.

Hm. From what I see we have all necessary infrastructure in place.

Unmaping is NOP for inaccessible pages as it is never mapped and we have
mapping->a_ops->migrate_folio() callback that allows to replace software
copying with whatever is needed, like TDH.MEM.PAGE.RELOCATE.

What do I miss?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3944FF333
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 11:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbiDMJSN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 05:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbiDMJSM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:18:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D34A245B6;
        Wed, 13 Apr 2022 02:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649841351; x=1681377351;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=Qyg9qkfEOmRnd7ecWKODTY6fNCX00KNJAm/6F+S5OvQ=;
  b=I8ypfzxbm0qwuSXuFG30iRhXH9mb0FjfoKFFb/P3h0hxXkAWUKgsUU9P
   Jfi9yb+ddRDoH5iZ3QnhFkHB9Uz3zzYxETClclLkGdUF2/6QzFXpjxTZL
   glOtAp9hTQ3C/cnMaKnMup0faGNBjbG25qU/KDFC/yhfDswniV1D2hlDm
   OI4nxbp7vW/7iQmk4DkGTbmejeeRpvKCdwgiLGHeaVcC82SLInFiXoG98
   4XaGa1yZ+tA0mjriZzJk10W88znaXn4bP7lFIfRhUmYvoflZN1RMfYsmW
   u5qgqOoMd0WwqaJsam7d/JO3Cvrmv1tcFCR3wEpT435we3DXKyEc6wiea
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="260213830"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="260213830"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 02:15:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="700175232"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 13 Apr 2022 02:15:43 -0700
Date:   Wed, 13 Apr 2022 17:15:33 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v5 04/13] mm/shmem: Restrict MFD_INACCESSIBLE memory
 against RLIMIT_MEMLOCK
Message-ID: <20220413091533.GC10041@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-5-chao.p.peng@linux.intel.com>
 <Yk8L0CwKpTrv3Rg3@google.com>
 <20220411153233.54ljmi7zgqovhgsn@box.shutemov.name>
 <20220412133925.GG8013@chaop.bj.intel.com>
 <20220412192821.xliop57sblvjx4t4@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412192821.xliop57sblvjx4t4@box.shutemov.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 12, 2022 at 10:28:21PM +0300, Kirill A. Shutemov wrote:
> On Tue, Apr 12, 2022 at 09:39:25PM +0800, Chao Peng wrote:
> > On Mon, Apr 11, 2022 at 06:32:33PM +0300, Kirill A. Shutemov wrote:
> > > On Thu, Apr 07, 2022 at 04:05:36PM +0000, Sean Christopherson wrote:
> > > > Hmm, shmem_writepage() already handles SHM_F_INACCESSIBLE by rejecting the swap, so
> > > > maybe it's just the page migration path that needs to be updated?
> > > 
> > > My early version prevented migration with -ENOTSUPP for
> > > address_space_operations::migratepage().
> > > 
> > > What's wrong with that approach?
> > 
> > I previously thought migratepage will not be called since we already
> > marked the pages as UNMOVABLE, sounds not correct?
> 
> Do you mean missing __GFP_MOVABLE?

Yes.

> I can be wrong, but I don't see that it
> direclty affects if the page is migratable. It is a hint to page allocator
> to group unmovable pages to separate page block and impove availablity of
> higher order pages this way. Page allocator tries to allocate unmovable
> pages from pages blocks that already have unmovable pages.

OK, thanks.

Chao
> 
> -- 
>  Kirill A. Shutemov

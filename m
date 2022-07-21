Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E901D57C811
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 11:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiGUJu3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 05:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbiGUJu0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:50:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F62F3A480;
        Thu, 21 Jul 2022 02:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658397026; x=1689933026;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=Ac+0RLuL49DbuWul8+wP6iRaArHsOfPE0tmeiZTP7OA=;
  b=hTz9YotS9xWFXknZGPbV5OQvu8sG0LrT5rFevNkwwiIgKl6KwmDsQYRC
   1TcBzqSLV5bi8LdQ1YXvkhw19UIsscuzprhts6aeemNB+1Sp5LRIFi8/z
   sZQTus0dU8u165S/MHo5Z+qv2WRisKjvSYsjG6iruBw7hgnxXK86+nc7W
   s8Jz5ywGQDwv3m2xJaX4Eqbl/td8a8kbfSpe/6Q362yFc3C1s8mUacbs9
   js/KZrommMztWrZ0ecc+oSf1FtOjH2oFM6+xZ+ydi/gsnPDrnMDShmbnE
   c0IGYgBTSP/m2Exoznwsuh9tCWa7PA4JGU80KIxHRUKUDXgfBjxa343bZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="287752644"
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="287752644"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 02:50:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="626050085"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga008.jf.intel.com with ESMTP; 21 Jul 2022 02:50:12 -0700
Date:   Thu, 21 Jul 2022 17:45:23 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Michael Roth <michael.roth@amd.com>,
        "Nikunj A. Dadhania" <nikunj@amd.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86 <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, mhocko@suse.com
Subject: Re: [PATCH v6 6/8] KVM: Handle page fault for private memory
Message-ID: <20220721094523.GC153288@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-7-chao.p.peng@linux.intel.com>
 <b3ce0855-0e4b-782a-599c-26590df948dd@amd.com>
 <20220624090246.GA2181919@chaop.bj.intel.com>
 <CAGtprH82H_fjtRbL0KUxOkgOk4pgbaEbAydDYfZ0qxz41JCnAQ@mail.gmail.com>
 <20220630222140.of4md7bufd5jv5bh@amd.com>
 <4fe3b47d-e94a-890a-5b87-6dfb7763bc7e@intel.com>
 <Ysc9JDcVAnlVrGC8@google.com>
 <5d0b9341-78b5-0959-2517-0fb1fe83a205@intel.com>
 <CAGtprH9knCr++C7jgXYCi1zfYcreip1uun-d+eucjEQy9xymNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGtprH9knCr++C7jgXYCi1zfYcreip1uun-d+eucjEQy9xymNg@mail.gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 20, 2022 at 04:08:10PM -0700, Vishal Annapurve wrote:
> > > Hmm, so a new slot->arch.page_attr array shouldn't be necessary, KVM can instead
> > > update slot->arch.lpage_info on shared<->private conversions.  Detecting whether
> > > a given range is partially mapped could get nasty if KVM defers tracking to the
> > > backing store, but if KVM itself does the tracking as was previously suggested[*],
> > > then updating lpage_info should be relatively straightfoward, e.g. use
> > > xa_for_each_range() to see if a given 2mb/1gb range is completely covered (fully
> > > shared) or not covered at all (fully private).
> > >
> > > [*] https://lore.kernel.org/all/YofeZps9YXgtP3f1@google.com
> >
> > Yes, slot->arch.page_attr was introduced to help identify whether a page
> > is completely shared/private at given level. It seems XARRAY can serve
> > the same purpose, though I know nothing about it. Looking forward to
> > seeing the patch of using XARRAY.
> >
> > yes, update slot->arch.lpage_info is good to utilize the existing logic
> > and Isaku has applied it to slot->arch.lpage_info for 2MB support patches.
> 
> Chao, are you planning to implement these changes to ensure proper
> handling of hugepages partially mapped as private/shared in subsequent
> versions of this series?
> Or is this something left to be handled by the architecture specific code?

Ah, the topic gets moved to a different place. I should update here.
There were more discussions under TDX KVM patch series and I actually
just sent out the draft code for this:

https://lkml.org/lkml/2022/7/20/610

That patch is based on UPM v7 here. If I can get more feedbacks there
then I will include an udpated version in UPM v8.

If you have bandwdith, you can also play with that patch, any feedback
is welcome.

Chao
> 
> Regards,
> Vishal

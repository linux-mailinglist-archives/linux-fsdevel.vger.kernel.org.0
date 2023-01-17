Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2763F66DEBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 14:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbjAQN1j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 08:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbjAQN1h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:27:37 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A086534C01;
        Tue, 17 Jan 2023 05:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673962056; x=1705498056;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=OkxN9qHIfugzlGcYWrmJzkTgsJkFyQ0089rnB9xhbso=;
  b=FZZ67c5fd67JbVwO7XsESIoD/yIBVevp/EuOVI6JMN/vb1e3rb5QghW+
   xW3WzHxkFezkA6H5M4B6PIQJ3ocXJTrcMXDx5fQ9xJMDqY/xkz/jv0Jxe
   MMOgo00Ut1cnuyScd1obC/JgTIRJnFmToGuk9PihgCkMNRSM7foyg8qYi
   ra/Ft3lQlZDbxzvLY6Euo4xschTv6pYVZYZ03GkwqUPAlE0HatBGOGQfh
   Hpfyg9+JmneyxbNuWHTviVrDajfWKtEeaQbJNuh1yDiir40oi53WfpQWi
   QEIEVeaUsIILnxfhQ45K1GoDvVPrVmFPrhzf4q4ZowOpOQovTBkWXzEjA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="410930540"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="410930540"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 05:27:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="722655367"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="722655367"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.105])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jan 2023 05:27:25 -0800
Date:   Tue, 17 Jan 2023 21:19:37 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 0/9] KVM: mm: fd-based approach for supporting KVM
Message-ID: <20230117131937.GD273037@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <Y8H5Z3e4hZkFxAVS@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8H5Z3e4hZkFxAVS@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 14, 2023 at 12:37:59AM +0000, Sean Christopherson wrote:
> On Fri, Dec 02, 2022, Chao Peng wrote:
> > This patch series implements KVM guest private memory for confidential
> > computing scenarios like Intel TDX[1]. If a TDX host accesses
> > TDX-protected guest memory, machine check can happen which can further
> > crash the running host system, this is terrible for multi-tenant
> > configurations. The host accesses include those from KVM userspace like
> > QEMU. This series addresses KVM userspace induced crash by introducing
> > new mm and KVM interfaces so KVM userspace can still manage guest memory
> > via a fd-based approach, but it can never access the guest memory
> > content.
> > 
> > The patch series touches both core mm and KVM code. I appreciate
> > Andrew/Hugh and Paolo/Sean can review and pick these patches. Any other
> > reviews are always welcome.
> >   - 01: mm change, target for mm tree
> >   - 02-09: KVM change, target for KVM tree
> 
> A version with all of my feedback, plus reworked versions of Vishal's selftest,
> is available here:
> 
>   git@github.com:sean-jc/linux.git x86/upm_base_support
> 
> It compiles and passes the selftest, but it's otherwise barely tested.  There are
> a few todos (2 I think?) and many of the commits need changelogs, i.e. it's still
> a WIP.

Thanks very much for doing this. Almost all of your comments are well
received, except for two cases that need more discussions which have
replied individually.

> 
> As for next steps, can you (handwaving all of the TDX folks) take a look at what
> I pushed and see if there's anything horrifically broken, and that it still works
> for TDX?

I have integrated this into my local TDX repo, with some changes (as I
replied individually), the new code basically still works with TDX.

I have also asked other TDX folks to take a look.

> 
> Fuad (and pKVM folks) same ask for you with respect to pKVM.  Absolutely no rush
> (and I mean that).
> 
> On my side, the two things on my mind are (a) tests and (b) downstream dependencies
> (SEV and TDX).  For tests, I want to build a lists of tests that are required for
> merging so that the criteria for merging are clear, and so that if the list is large
> (haven't thought much yet), the work of writing and running tests can be distributed.
> 
> Regarding downstream dependencies, before this lands, I want to pull in all the
> TDX and SNP series and see how everything fits together.  Specifically, I want to
> make sure that we don't end up with a uAPI that necessitates ugly code, and that we
> don't miss an opportunity to make things simpler.  The patches in the SNP series to
> add "legacy" SEV support for UPM in particular made me slightly rethink some minor
> details.  Nothing remotely major, but something that needs attention since it'll
> be uAPI.
> 
> I'm off Monday, so it'll be at least Tuesday before I make any more progress on
> my side.

Appreciate your effort. As for the next steps, if you see something we
can do parallel, feel free to let me know.

Thanks,
Chao

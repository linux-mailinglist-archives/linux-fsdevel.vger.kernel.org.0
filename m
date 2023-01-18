Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48ED667170D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 10:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjARJGZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 04:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjARJEg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:04:36 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755523E0AD;
        Wed, 18 Jan 2023 00:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674030281; x=1705566281;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=mSO4PAMhEZisTll2SVfi2Yx3pBS6smLK7Q3mTuJU1oA=;
  b=Xw5pozIH/dQFwvoJIvMdSKyZ69PKHC2soxXvHTqfxtxwVSDqkyWEtCfA
   ipGSRm2hIIZxS3oQ0xiNx/l29EfDF1SJH2L97GChoGaKd4BctU+oeVRUY
   mUCOuNP14slRIsR4Hj//w1ykPHkYYqcp/OSYQjkn88KBcUKnzF2WmwSg9
   UvuvxkDlrQ3StY+f+L2CBO3aOOGhsSscfNh87yrxPEghYjw2hsYy0c8il
   EVbziUgGqb67ahXJKBgpRh0kvRORM8lu95w5HrCHcjq78znw31sEQ/LbM
   vNJTrUZ0qH8DrEEqOaAjHLKFW284bfJstu4HG1wGECFDEyjd43slXQpe5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="323620012"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="323620012"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 00:24:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="722997271"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="722997271"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.105])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jan 2023 00:24:28 -0800
Date:   Wed, 18 Jan 2023 16:16:41 +0800
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
Subject: Re: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Message-ID: <20230118081641.GA303785@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
 <Y8HTITl1+Oe0H7Gd@google.com>
 <20230117124107.GA273037@chaop.bj.intel.com>
 <Y8bOB7VuVIsxoMcn@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8bOB7VuVIsxoMcn@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 17, 2023 at 04:34:15PM +0000, Sean Christopherson wrote:
> On Tue, Jan 17, 2023, Chao Peng wrote:
> > On Fri, Jan 13, 2023 at 09:54:41PM +0000, Sean Christopherson wrote:
> > > > +	list_for_each_entry(notifier, &data->notifiers, list) {
> > > > +		notifier->ops->invalidate_start(notifier, start, end);
> > > 
> > > Two major design issues that we overlooked long ago:
> > > 
> > >   1. Blindly invoking notifiers will not scale.  E.g. if userspace configures a
> > >      VM with a large number of convertible memslots that are all backed by a
> > >      single large restrictedmem instance, then converting a single page will
> > >      result in a linear walk through all memslots.  I don't expect anyone to
> > >      actually do something silly like that, but I also never expected there to be
> > >      a legitimate usecase for thousands of memslots.
> > > 
> > >   2. This approach fails to provide the ability for KVM to ensure a guest has
> > >      exclusive access to a page.  As discussed in the past, the kernel can rely
> > >      on hardware (and maybe ARM's pKVM implementation?) for those guarantees, but
> > >      only for SNP and TDX VMs.  For VMs where userspace is trusted to some extent,
> > >      e.g. SEV, there is value in ensuring a 1:1 association.
> > > 
> > >      And probably more importantly, relying on hardware for SNP and TDX yields a
> > >      poor ABI and complicates KVM's internals.  If the kernel doesn't guarantee a
> > >      page is exclusive to a guest, i.e. if userspace can hand out the same page
> > >      from a restrictedmem instance to multiple VMs, then failure will occur only
> > >      when KVM tries to assign the page to the second VM.  That will happen deep
> > >      in KVM, which means KVM needs to gracefully handle such errors, and it means
> > >      that KVM's ABI effectively allows plumbing garbage into its memslots.
> > 
> > It may not be a valid usage, but in my TDX environment I do meet below
> > issue.
> > 
> > kvm_set_user_memory AddrSpace#0 Slot#0 flags=0x4 gpa=0x0 size=0x80000000 ua=0x7fe1ebfff000 ret=0
> > kvm_set_user_memory AddrSpace#0 Slot#1 flags=0x4 gpa=0xffc00000 size=0x400000 ua=0x7fe271579000 ret=0
> > kvm_set_user_memory AddrSpace#0 Slot#2 flags=0x4 gpa=0xfeda0000 size=0x20000 ua=0x7fe1ec09f000 ret=-22
> > 
> > Slot#2('SMRAM') is actually an alias into system memory(Slot#0) in QEMU
> > and slot#2 fails due to below exclusive check.
> > 
> > Currently I changed QEMU code to mark these alias slots as shared
> > instead of private but I'm not 100% confident this is correct fix.
> 
> That's a QEMU bug of sorts.  SMM is mutually exclusive with TDX, QEMU shouldn't
> be configuring SMRAM (or any SMM memslots for that matter) for TDX guests.

Thanks for the confirmation. As long as we only bind one notifier for
each address, using xarray does make things simple.

Chao

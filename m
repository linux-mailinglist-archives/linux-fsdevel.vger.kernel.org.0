Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0212A60483F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 15:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbiJSNw6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 09:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiJSNwI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:52:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBC2185422;
        Wed, 19 Oct 2022 06:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666186557; x=1697722557;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=4xcGc4T12PBypY/VcZfHNkEly5yZ/s7CT5KUy36zg78=;
  b=jjhzCoBCsLf8VUs0R+QfGydIe7QYMFm556unX6I3R1DhSqiZ6WdqdGVa
   b58y8RqAbpOUVWcVU80uo6UdKSAEaP58z78cTXYknf8jnPI1EPw1Ko8CS
   9P4GSLacFbYoEP5y0IdzcamCNPNMyiKLNICDGy3Sb384VgKaZcR10bNVB
   RA8w2ffKnvwlH2hIji1lwf7aova5NGJGlNbXdroBiWEj3jQJb4F+KSwx+
   P8m2wZLALph4TDFXT2aZIqb6t4vHFkYos0euU2OjLo9a0tQGtZztObxhN
   m5uvSoc3lGKdeFUgCz0ogBy9KOvVgmRg9BL0ZqEQxRM9EEY9rXf4luzXk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="286801355"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="286801355"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 06:35:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="624137726"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="624137726"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2022 06:35:14 -0700
Date:   Wed, 19 Oct 2022 21:30:43 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Fuad Tabba <tabba@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
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
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Message-ID: <20221019133043.GB3496045@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <Yyi+l3+p9lbBAC4M@google.com>
 <CA+EHjTzy4iOxLF=5UX=s5v6HSB3Nb1LkwmGqoKhp_PAnFeVPSQ@mail.gmail.com>
 <20220926142330.GC2658254@chaop.bj.intel.com>
 <CA+EHjTz5yGhsxUug+wqa9hrBO60Be0dzWeWzX00YtNxin2eYHg@mail.gmail.com>
 <YzN9gYn1uwHopthW@google.com>
 <CA+EHjTw3din891hMUeRW-cn46ktyMWSdoB31pL+zWpXo_=3UVg@mail.gmail.com>
 <20221013133457.GA3263142@chaop.bj.intel.com>
 <CA+EHjTzZ2zsm7Ru_OKCZg9FCYESgZsmB=7ScKRh6ZN4=4OZ3gw@mail.gmail.com>
 <20221017145856.GB3417432@chaop.bj.intel.com>
 <CA+EHjTyiU230am0cuWc7xBBirGocPWGmyqCskhTytA10xpigYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTyiU230am0cuWc7xBBirGocPWGmyqCskhTytA10xpigYQ@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 17, 2022 at 08:05:10PM +0100, Fuad Tabba wrote:
> Hi,
> 
> > > > Using both private_fd and userspace_addr is only needed in TDX and other
> > > > confidential computing scenarios, pKVM may only use private_fd if the fd
> > > > can also be mmaped as a whole to userspace as Sean suggested.
> > >
> > > That does work in practice, for now at least, and is what I do in my
> > > current port. However, the naming and how the API is defined as
> > > implied by the name and the documentation. By calling the field
> > > private_fd, it does imply that it should not be mapped, which is also
> > > what api.rst says in PATCH v8 5/8. My worry is that in that case pKVM
> > > would be mis/ab-using this interface, and that future changes could
> > > cause unforeseen issues for pKVM.
> >
> > That is fairly enough. We can change the naming and the documents.
> >
> > >
> > > Maybe renaming this to something like "guest_fp", and specifying in
> > > the documentation that it can be restricted, e.g., instead of "the
> > > content of the private memory is invisible to userspace" something
> > > along the lines of  "the content of the guest memory may be restricted
> > > to userspace".
> >
> > Some other candidates in my mind:
> > - restricted_fd: to pair with the mm side restricted_memfd
> > - protected_fd: as Sean suggested before
> > - fd: how it's explained relies on the memslot.flag.
> 
> All these sound good, since they all capture the potential use cases.
> Restricted might be the most logical choice if that's going to also
> become the name for the mem_fd.

Thanks, I will use 'restricted' for them. e.g.:
- memfd_restricted() syscall
- restricted_fd
- restricted_offset

The memslot flags will still be KVM_MEM_PRIVATE, since I think pKVM will
create its own one?

Chao
> 
> Thanks,
> /fuad
> 
> > Thanks,
> > Chao
> > >
> > > What do you think?
> > >
> > > Cheers,
> > > /fuad
> > >
> > > >
> > > > Thanks,
> > > > Chao
> > > > >
> > > > > Cheers,
> > > > > /fuad

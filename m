Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87246601264
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 17:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiJQPGc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 11:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiJQPGF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 11:06:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FFE6D547;
        Mon, 17 Oct 2022 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666019141; x=1697555141;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=PvgBjoYyaoMX/iKVZUi6GVXenC/pYD5E0G2UFDGF3Zw=;
  b=IU3LmUkLVt36rvVKa9l916RfDbpgiRFHzjy57j8VE5wsnRvfpKAlpOZd
   2brl+HVkkRpDgs7erNYSqncIAX0+BRkq4+tdIRDIMCpISsSX48TyhAIYH
   VnQbj3GuBSvty8nqptQNxuxmOGH9mbkPpN92Ms9GY9vt6+ScHe/HrJ00Z
   pcweMnaz1AbVk57r2pqnh1tn46FvqCqDQVdhEXW8NkL0Dwn1vssEQQRbS
   tNz9bjTm8JYYwuDOLvDpzn4Vr87zueycm4qVj3chWuAC/Mpe720lkbPXY
   37lO6G2qq5TUIONbfaVt7aKKZKBdMaNwTBawqKECCT8vPiOOYox7upECp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="370011931"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="370011931"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 08:03:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="691387974"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="691387974"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 17 Oct 2022 08:03:27 -0700
Date:   Mon, 17 Oct 2022 22:58:56 +0800
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
Message-ID: <20221017145856.GB3417432@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
 <d16284f5-3493-2892-38e6-f1fa5c10bdbb@redhat.com>
 <Yyi+l3+p9lbBAC4M@google.com>
 <CA+EHjTzy4iOxLF=5UX=s5v6HSB3Nb1LkwmGqoKhp_PAnFeVPSQ@mail.gmail.com>
 <20220926142330.GC2658254@chaop.bj.intel.com>
 <CA+EHjTz5yGhsxUug+wqa9hrBO60Be0dzWeWzX00YtNxin2eYHg@mail.gmail.com>
 <YzN9gYn1uwHopthW@google.com>
 <CA+EHjTw3din891hMUeRW-cn46ktyMWSdoB31pL+zWpXo_=3UVg@mail.gmail.com>
 <20221013133457.GA3263142@chaop.bj.intel.com>
 <CA+EHjTzZ2zsm7Ru_OKCZg9FCYESgZsmB=7ScKRh6ZN4=4OZ3gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTzZ2zsm7Ru_OKCZg9FCYESgZsmB=7ScKRh6ZN4=4OZ3gw@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 17, 2022 at 11:31:19AM +0100, Fuad Tabba wrote:
> Hi,
> 
> > >
> > > Actually, for pKVM, there is no need for the guest memory to be
> > > GUP'able at all if we use the new inaccessible_get_pfn().
> >
> > If pKVM can use inaccessible_get_pfn() to get pfn and can avoid GUP (I
> > think that is the major concern?), do you see any other gap from
> > existing API?
> 
> Actually for this part no, there aren't any gaps and
> inaccessible_get_pfn() is sufficient.

Thanks for the confirmation.

> 
> > > This of
> > > course goes back to what I'd mentioned before in v7; it seems that
> > > representing the memslot memory as a file descriptor should be
> > > orthogonal to whether the memory is shared or private, rather than a
> > > private_fd for private memory and the userspace_addr for shared
> > > memory. The host can then map or unmap the shared/private memory using
> > > the fd, which allows it more freedom in even choosing to unmap shared
> > > memory when not needed, for example.
> >
> > Using both private_fd and userspace_addr is only needed in TDX and other
> > confidential computing scenarios, pKVM may only use private_fd if the fd
> > can also be mmaped as a whole to userspace as Sean suggested.
> 
> That does work in practice, for now at least, and is what I do in my
> current port. However, the naming and how the API is defined as
> implied by the name and the documentation. By calling the field
> private_fd, it does imply that it should not be mapped, which is also
> what api.rst says in PATCH v8 5/8. My worry is that in that case pKVM
> would be mis/ab-using this interface, and that future changes could
> cause unforeseen issues for pKVM.

That is fairly enough. We can change the naming and the documents.

> 
> Maybe renaming this to something like "guest_fp", and specifying in
> the documentation that it can be restricted, e.g., instead of "the
> content of the private memory is invisible to userspace" something
> along the lines of  "the content of the guest memory may be restricted
> to userspace".

Some other candidates in my mind:
- restricted_fd: to pair with the mm side restricted_memfd
- protected_fd: as Sean suggested before
- fd: how it's explained relies on the memslot.flag.

Thanks,
Chao
> 
> What do you think?
> 
> Cheers,
> /fuad
> 
> >
> > Thanks,
> > Chao
> > >
> > > Cheers,
> > > /fuad

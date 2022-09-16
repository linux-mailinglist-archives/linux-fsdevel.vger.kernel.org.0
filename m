Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360D95BA9DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 12:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiIPJ6n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 05:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiIPJ6d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:58:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1E8AA4DF;
        Fri, 16 Sep 2022 02:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663322311; x=1694858311;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=12OZBcnGODAmYZ+AQhyX6U0d1a9s5HIpAjq3AWPtWJs=;
  b=hK7Z2muPoe51t+mAtm3DCPxAFrwHkUH4KdVddLvWyC5NdgoSi7SJwMAm
   7QXpD1QkARfIZ8SBmQ27HRCShf8Iflxv6Q/7/5dad5GaXbZR6W+ojV8F1
   aWGG3mBJ9KH8/8Eb2e3cecxO76Px9lQUkvwrPchRKOGpzcu5rjpZ/oG4X
   jPRBQ+0d+ZNec65VmYnU6KvNtpUI0tMjcyUnEPT0wjaFxM9YYQM0vF1xB
   c8rZ9NXL+FxLcDFfLvxQNbD8yk1KYTQNeUNrXNCgS8FzfynSdyfh2ymfj
   brlycSVwwLc7dJ7biIByg8EJoBkCSN/AL/yTWn6hnbvP6EUePyPFmaeNU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="298950578"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="298950578"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 02:58:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="620036603"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga007.fm.intel.com with ESMTP; 16 Sep 2022 02:58:21 -0700
Date:   Fri, 16 Sep 2022 17:53:42 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v8 2/8] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <20220916095342.GA2261402@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-3-chao.p.peng@linux.intel.com>
 <YyQ+dQT9/V5e62/u@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyQ+dQT9/V5e62/u@debian.me>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 16, 2022 at 04:14:29PM +0700, Bagas Sanjaya wrote:
> On Thu, Sep 15, 2022 at 10:29:07PM +0800, Chao Peng wrote:
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > index abd7c32126ce..c1fac1e9f820 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -1319,7 +1319,7 @@ yet and must be cleared on entry.
> >  :Capability: KVM_CAP_USER_MEMORY
> >  :Architectures: all
> >  :Type: vm ioctl
> > -:Parameters: struct kvm_userspace_memory_region (in)
> > +:Parameters: struct kvm_userspace_memory_region(_ext) (in)
> >  :Returns: 0 on success, -1 on error
> >  
> >  ::
> > @@ -1332,9 +1332,18 @@ yet and must be cleared on entry.
> >  	__u64 userspace_addr; /* start of the userspace allocated memory */
> >    };
> >  
> > +  struct kvm_userspace_memory_region_ext {
> > +	struct kvm_userspace_memory_region region;
> > +	__u64 private_offset;
> > +	__u32 private_fd;
> > +	__u32 pad1;
> > +	__u64 pad2[14];
> > +  };
> > +
> >    /* for kvm_memory_region::flags */
> >    #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
> >    #define KVM_MEM_READONLY	(1UL << 1)
> > +  #define KVM_MEM_PRIVATE		(1UL << 2)
> >  
> >  This ioctl allows the user to create, modify or delete a guest physical
> >  memory slot.  Bits 0-15 of "slot" specify the slot id and this value
> > @@ -1365,12 +1374,27 @@ It is recommended that the lower 21 bits of guest_phys_addr and userspace_addr
> >  be identical.  This allows large pages in the guest to be backed by large
> >  pages in the host.
> >  
> > -The flags field supports two flags: KVM_MEM_LOG_DIRTY_PAGES and
> > -KVM_MEM_READONLY.  The former can be set to instruct KVM to keep track of
> > -writes to memory within the slot.  See KVM_GET_DIRTY_LOG ioctl to know how to
> > -use it.  The latter can be set, if KVM_CAP_READONLY_MEM capability allows it,
> > -to make a new slot read-only.  In this case, writes to this memory will be
> > -posted to userspace as KVM_EXIT_MMIO exits.
> > +kvm_userspace_memory_region_ext includes all the kvm_userspace_memory_region
> > +fields. It also includes additional fields for some specific features. See
> > +below description of flags field for more information. It's recommended to use
> > +kvm_userspace_memory_region_ext in new userspace code.
> 
> Better say "kvm_userspace_memory_region_ext includes all fields of
> kvm_userspace_memory_region struct, while also adds additional fields ..."
> 
> > +
> > +The flags field supports below flags:
> 
> s/below/following/
> 
> > +
> > +- KVM_MEM_LOG_DIRTY_PAGES can be set to instruct KVM to keep track of writes to
> > +  memory within the slot.  See KVM_GET_DIRTY_LOG ioctl to know how to use it.
> > +
> 
> Better say "... For more details, see KVM_GET_DIRTY_LOG."
> 
> > +- KVM_MEM_READONLY can be set, if KVM_CAP_READONLY_MEM capability allows it, to
> > +  make a new slot read-only.  In this case, writes to this memory will be posted
> > +  to userspace as KVM_EXIT_MMIO exits.
> > +
> 
> Better say "if KVM_CAP_READONLY_MEM allows, KVM_MEM_READONLY makes a new
> slot read-only ..."
> 
> > +- KVM_MEM_PRIVATE can be set to indicate a new slot has private memory backed by
> > +  a file descirptor(fd) and the content of the private memory is invisible to
> > +  userspace. In this case, userspace should use private_fd/private_offset in
> > +  kvm_userspace_memory_region_ext to instruct KVM to provide private memory to
> > +  guest. Userspace should guarantee not to map the same pfn indicated by
> > +  private_fd/private_offset to different gfns with multiple memslots. Failed to
> > +  do this may result undefined behavior.
> >  
> 
> For the lists above,
> s/can be set/

It all looks good, thanks!

> 
> Thanks. 
> 
> -- 
> An old man doll... just what I always wanted! - Clara



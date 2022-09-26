Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5A55EAAD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 17:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbiIZPZW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 11:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbiIZPYC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:24:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8A71E3D1;
        Mon, 26 Sep 2022 07:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664201389; x=1695737389;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=kLBWR5qEV1U14bOBHrdj86S+fx8bShjKVx0oSvRe47k=;
  b=iSJSXIFxmEPPzzhQPc8Aq8o5dPkLSD+Nk04JxvzeMf0ETHkKRtT0A/XG
   Gm9rZW/FMCZ9Mk/wygBAcheoEHj3qBZnldcy+azn0woWxgMdAQsZwKvO8
   MLi9TTLwzijWvRScze04ZMZURRt5yGnWOpePaxRSApG18DSY5qNmBWohP
   qtNWnL9ywD6dZAw6KOnYG9tp1vYxaZqYryWbuEpULNd8Vm0TT52/ny4Rh
   sNB/QJF3GHrOVNqyv+j0j8bxw5rEh5EGvEZ0j/dNWIlPx0lECYVzHB/1+
   4YZlCpZzAPVkRG0nE+b6wfOh2nWNllXsxaRm0C1IVSsJfFvLQHuvUksCJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="365068855"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="365068855"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 07:09:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="651840417"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="651840417"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga008.jf.intel.com with ESMTP; 26 Sep 2022 07:09:28 -0700
Date:   Mon, 26 Sep 2022 22:04:51 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Fuad Tabba <tabba@google.com>
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
Message-ID: <20220926140451.GA2658254@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-3-chao.p.peng@linux.intel.com>
 <CA+EHjTzHTaDaAKEMjFHzXLBgUS4bMfnppzO==KeDGpyUKO0fCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTzHTaDaAKEMjFHzXLBgUS4bMfnppzO==KeDGpyUKO0fCw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 26, 2022 at 11:26:45AM +0100, Fuad Tabba wrote:
...

> > +
> > +- KVM_MEM_PRIVATE can be set to indicate a new slot has private memory backed by
> > +  a file descirptor(fd) and the content of the private memory is invisible to
> 
> s/descirptor/descriptor

Thanks.

...

>  static long kvm_vm_ioctl(struct file *filp,
> >                            unsigned int ioctl, unsigned long arg)
> >  {
> > @@ -4645,14 +4672,20 @@ static long kvm_vm_ioctl(struct file *filp,
> >                 break;
> >         }
> >         case KVM_SET_USER_MEMORY_REGION: {
> > -               struct kvm_userspace_memory_region kvm_userspace_mem;
> > +               struct kvm_user_mem_region mem;
> > +               unsigned long size = sizeof(struct kvm_userspace_memory_region);
> 
> nit: should this be sizeof(struct mem)? That's more similar to the
> existing code and makes it dependent on the size of mem regardless of
> possible changes to its type in the future.

Unluckily no, the size we need copy_from_user() depends on the flags,
e.g. without KVM_MEM_PRIVATE, we can't safely copy that big size since
the 'extended' part may not even exist.

> 
> > +
> > +               kvm_sanity_check_user_mem_region_alias();
> >
> >                 r = -EFAULT;
> > -               if (copy_from_user(&kvm_userspace_mem, argp,
> > -                                               sizeof(kvm_userspace_mem)))
> > +               if (copy_from_user(&mem, argp, size);
> 
> It gets fixed in a future patch, but the ; should be a ).

Good catch, thanks!

Chao
> 
> Cheers,
> /fuad

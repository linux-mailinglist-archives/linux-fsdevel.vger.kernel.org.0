Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C0865E4C9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 05:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjAEEnx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 23:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjAEEnv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 23:43:51 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467E2203B;
        Wed,  4 Jan 2023 20:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672893830; x=1704429830;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=M2HzjY4mMzV2AyGn4ieao8qywB/GzVzqvY8BmkeNGAs=;
  b=aaTwBrl+UagqUDhK8DOZenV2UW6rNb4bXw6yrioMermuNtlVnDztKop0
   BaKuOmuqnqStJSXIdHAP95ur8Yvv1AADHQF4Te7SPTW0SzwOXMNa5fgEA
   1MTxShykT801PMXNP7bXILH7biVOnHNDgegKPwsPNfoKNh9RTva+9wo93
   JFqnXr53SCk3xIMMvIr+Xbgb+3JxYstciSD6jt81iUq/DpAU2q3v8LMoH
   wh6SbJqW+w0U+J5O5n5C5wdpXYyTeix4f+hnhim1Vum16eRQHUtY42/iF
   0MSx9f9zcKqOYIwSHdI6V2SWQlZyUBcINs849Lo78cjaFasbHOpCSSxRs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="319820021"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="319820021"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 20:43:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="687765563"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="687765563"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga001.jf.intel.com with ESMTP; 04 Jan 2023 20:43:36 -0800
Date:   Thu, 5 Jan 2023 12:39:23 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Wang, Wei W" <wei.w.wang@intel.com>,
        "Qiang, Chenyi" <chenyi.qiang@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
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
        Miaohe Lin <linmiaohe@huawei.com>,
        "x86@kernel.org" <x86@kernel.org>,
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
        "Lutomirski, Andy" <luto@kernel.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        Quentin Perret <qperret@google.com>,
        "tabba@google.com" <tabba@google.com>,
        Michael Roth <michael.roth@amd.com>,
        "Hocko, Michal" <mhocko@suse.com>
Subject: Re: [PATCH v10 2/9] KVM: Introduce per-page memory attributes
Message-ID: <20230105043923.GC2251521@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-3-chao.p.peng@linux.intel.com>
 <1c9bbaa5-eea3-351e-d6a0-cfbc32115c82@intel.com>
 <20230103013948.GA2178318@chaop.bj.intel.com>
 <DS0PR11MB63738AE206ADE5EB00D8838BDCF49@DS0PR11MB6373.namprd11.prod.outlook.com>
 <Y7S0/VYsy4aWjfQ+@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7S0/VYsy4aWjfQ+@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 03, 2023 at 11:06:37PM +0000, Sean Christopherson wrote:
> On Tue, Jan 03, 2023, Wang, Wei W wrote:
> > On Tuesday, January 3, 2023 9:40 AM, Chao Peng wrote:
> > > > Because guest memory defaults to private, and now this patch stores
> > > > the attributes with KVM_MEMORY_ATTRIBUTE_PRIVATE instead of
> > > _SHARED,
> > > > it would bring more KVM_EXIT_MEMORY_FAULT exits at the beginning of
> > > > boot time. Maybe it can be optimized somehow in other places? e.g. set
> > > > mem attr in advance.
> > > 
> > > KVM defaults to 'shared' because this ioctl can also be potentially used by
> > > normal VMs and 'shared' sounds a value meaningful for both normal VMs and
> > > confidential VMs. 
> > 
> > Do you mean a normal VM could have pages marked private? What's the usage?
> > (If all the pages are just marked shared for normal VMs, then why do we need it)
> 
> No, there are potential use cases for per-page attribute/permissions, e.g. to
> make select pages read-only, exec-only, no-exec, etc...

Right, normal VMs are not likely use private/shared bit. Not sure pKVM,
but perhaps not call it 'normal' VMs in this context. But since the
ioctl can be used by normal VMs for other bits (read-only, exec-only,
no-exec, etc), a default 'private' looks strange for them. That's why I
default it to 'shared' and for confidential guest, we can issue another
call to this ioctl to set all the memory to 'private' before guest
booting, if default 'private' is needed for guest.

Like Wei mentioned, it's also possible to make the default dependents on
vm_type, but that looks awkward to me from the API definition as well as
the implementation, also the vm_type has not been introduced at this time.

> 
> > > As for more KVM_EXIT_MEMORY_FAULT exits during the
> > > booting time, yes, setting all memory to 'private' for confidential VMs through
> > > this ioctl in userspace before guest launch is an approach for KVM userspace to
> > > 'override' the KVM default and reduce the number of implicit conversions.
> > 
> > Most pages of a confidential VM are likely to be private pages. It seems more efficient
> > (and not difficult to check vm_type) to have KVM defaults to "private" for confidential VMs
> > and defaults to "shared" for normal VMs.
> 
> If done right, the default shouldn't matter all that much for efficiency.  KVM
> needs to be able to effeciently track large ranges regardless of the default,
> otherwise the memory overhead and the presumably cost of lookups will be painful.
> E.g. converting a 1GiB chunk to shared should ideally require one entry, not 256k
> entries.

I agree, KVM should have the ability to track large ranges efficiently.

> 
> Looks like that behavior was changed in v8 in response to feedback[*] that doing
> xa_store_range() on a subset of an existing range (entry) would overwrite the
> entire existing range (entry), not just the smaller subset.  xa_store_range() does
> appear to be too simplistic for this use case, but looking at __filemap_add_folio(),
> splitting an existing entry isn't super complex.

Yes, xa_store_range() looks a perfect match for us initially but the
'overwriting the entire entry' behavior makes it incorrect for us when
storing a subset on an existing large entry. xarray lib has utilities
for splitting, the hard part is merging existing entries, as you also
said below. Thanks for pointing out the __filemap_add_folio() example,
it does look not too complex for splitting.

> 
> Using xa_store() for the very initial implementation is ok, and probably a good
> idea since it's more obviously correct and will give us a bisection point.  But
> we definitely want a more performant implementation sooner than later.  The hardest
> part will likely be merging existing entries, but that can be done separately too,
> and is probably lower priority.
> 
> E.g. (1) use xa_store() and always track at 4KiB granularity, (2) support storing
> metadata in multi-index entries, and finally (3) support merging adjacent entries
> with identical values.

This path looks good to me.

Thanks,
Chao
> 
> [*] https://lore.kernel.org/all/CAGtprH9xyw6bt4=RBWF6-v2CSpabOCpKq5rPz+e-9co7EisoVQ@mail.gmail.com

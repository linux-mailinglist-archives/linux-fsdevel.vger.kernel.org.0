Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D51B56AC86
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 22:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbiGGUIN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 16:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236724AbiGGUIL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:08:11 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8404660510
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jul 2022 13:08:09 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id e132so20449329pgc.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Jul 2022 13:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cFtvjAz52PfP2pPD+ElBW0/QBf2EF5ZKVG4poUQicBo=;
        b=mP6SCv4ZYKPXIVkeWPvSzYVLVZhUki25eBM3YjhHa4kfvUF6M24odaSonkI7GHxDgl
         q8l7jb+yebppC1HydPiKCkfhvmANyTWfCu52lX2gIwEpQBnE29Hb8QHYalq/BA13UOjv
         +Zyr+YT7RtoA7XbaOypkXR3a1booylX88aVw60q9E8Hgv256LIL7u283VOkjfSc/SkGk
         xBZgDfQP4w+8tYaciO9M9qkbnh1pzs5vOsjgxpOmnkZpqJo64Sb1mOLl2eYm3CP/azOl
         MjvEVEDBMn2QuzM5ShiwcRwk74T7S++IlrVOEUYGSFYHaFxUDcAizX/UA4mV7JIntHW7
         0e3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cFtvjAz52PfP2pPD+ElBW0/QBf2EF5ZKVG4poUQicBo=;
        b=HtSC5WKh2u5MtyUK2STgdFzXPzRjYPiZVvu3gkVgAh5On2/hdjyF/yhpoBmmL3DtTt
         nzSGAoGQF/cVfr/kmJn6WSnhM8pT5VUlMvQiNTl80iNMht2z8KOswKeynt2ojlShnSe5
         25qvr2D0ihAZc0TGmP6gy86Z/HdEGs6YSYZdRgCV1m5yz89JyIfjh8EQYrQ8+B3+fY7p
         z4NNy83n4xn834ugMTiowwFz2A0FdetvC+FB3aLgjLQ5kHSwTGqNIQQmBMzTtftTE2Ex
         Uc3CuGxRBfnpeaiFrGAfL5D2BV4Inp/Dh/q7xwLxTz1Uv3ObDflN3a4QzIbVzD85lJFE
         fe0g==
X-Gm-Message-State: AJIora/bvQiHtBgxYB77t1aD16VRKXHt/YgeHkvW3PH7pXCVh7UiL1Kx
        CD1cXqsA+4kJNFZoKZdXktJVXw==
X-Google-Smtp-Source: AGRyM1vO+9LD36zGVYjZHKVETQF42VSn4ohks+4f4YrWxIjNuhp8m2LWNGsH0so1jBJkR3/GbUBuuQ==
X-Received: by 2002:a17:902:d28a:b0:16b:e4d6:6534 with SMTP id t10-20020a170902d28a00b0016be4d66534mr23220212plc.68.1657224488885;
        Thu, 07 Jul 2022 13:08:08 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id w8-20020a627b08000000b00528c6c7bb65sm2244075pfc.83.2022.07.07.13.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 13:08:08 -0700 (PDT)
Date:   Thu, 7 Jul 2022 20:08:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Michael Roth <michael.roth@amd.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
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
Message-ID: <Ysc9JDcVAnlVrGC8@google.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-7-chao.p.peng@linux.intel.com>
 <b3ce0855-0e4b-782a-599c-26590df948dd@amd.com>
 <20220624090246.GA2181919@chaop.bj.intel.com>
 <CAGtprH82H_fjtRbL0KUxOkgOk4pgbaEbAydDYfZ0qxz41JCnAQ@mail.gmail.com>
 <20220630222140.of4md7bufd5jv5bh@amd.com>
 <4fe3b47d-e94a-890a-5b87-6dfb7763bc7e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fe3b47d-e94a-890a-5b87-6dfb7763bc7e@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 01, 2022, Xiaoyao Li wrote:
> On 7/1/2022 6:21 AM, Michael Roth wrote:
> > On Thu, Jun 30, 2022 at 12:14:13PM -0700, Vishal Annapurve wrote:
> > > With transparent_hugepages=always setting I see issues with the
> > > current implementation.

...

> > > Looks like with transparent huge pages enabled kvm tried to handle the
> > > shared memory fault on 0x84d gfn by coalescing nearby 4K pages
> > > to form a contiguous 2MB page mapping at gfn 0x800, since level 2 was
> > > requested in kvm_mmu_spte_requested.
> > > This caused the private memory contents from regions 0x800-0x84c and
> > > 0x86e-0xa00 to get unmapped from the guest leading to guest vm
> > > shutdown.
> > 
> > Interesting... seems like that wouldn't be an issue for non-UPM SEV, since
> > the private pages would still be mapped as part of that 2M mapping, and
> > it's completely up to the guest as to whether it wants to access as
> > private or shared. But for UPM it makes sense this would cause issues.
> > 
> > > 
> > > Does getting the mapping level as per the fault access type help
> > > address the above issue? Any such coalescing should not cross between
> > > private to
> > > shared or shared to private memory regions.
> > 
> > Doesn't seem like changing the check to fault->is_private would help in
> > your particular case, since the subsequent host_pfn_mapping_level() call
> > only seems to limit the mapping level to whatever the mapping level is
> > for the HVA in the host page table.
> > 
> > Seems like with UPM we need some additional handling here that also
> > checks that the entire 2M HVA range is backed by non-private memory.
> > 
> > Non-UPM SNP hypervisor patches already have a similar hook added to
> > host_pfn_mapping_level() which implements such a check via RMP table, so
> > UPM might need something similar:
> > 
> >    https://github.com/AMDESE/linux/commit/ae4475bc740eb0b9d031a76412b0117339794139
> > 
> > -Mike
> > 
> 
> For TDX, we try to track the page type (shared, private, mixed) of each gfn
> at given level. Only when the type is shared/private, can it be mapped at
> that level. When it's mixed, i.e., it contains both shared pages and private
> pages at given level, it has to go to next smaller level.
> 
> https://github.com/intel/tdx/commit/ed97f4042eb69a210d9e972ccca6a84234028cad

Hmm, so a new slot->arch.page_attr array shouldn't be necessary, KVM can instead
update slot->arch.lpage_info on shared<->private conversions.  Detecting whether
a given range is partially mapped could get nasty if KVM defers tracking to the
backing store, but if KVM itself does the tracking as was previously suggested[*],
then updating lpage_info should be relatively straightfoward, e.g. use
xa_for_each_range() to see if a given 2mb/1gb range is completely covered (fully
shared) or not covered at all (fully private).

[*] https://lore.kernel.org/all/YofeZps9YXgtP3f1@google.com

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB5057D2D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 19:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiGUR67 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 13:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiGUR66 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:58:58 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3619288117
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 10:58:56 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s18-20020a17090aa11200b001f1e9e2438cso5997804pjp.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 10:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wvI0q5HAql8tMPxcnKbiOi/9NxgmmSwnzAAkVZd1GZE=;
        b=QeJXriKT9c5kzVC7WwOIhi80ckWM6ug8VcaWprkpELe4t4pSILpTjfg8m+cMtOrWBe
         jmelByXoDseFjzPN05HlM35WJraOgVD8XBmkQsrB5vGpNrj70IhxBhsBNPglHsEpzekf
         1kG3W212r4FUnxp6h1itgEO/FJ4Uuo3CeYYXkoiOWqCRXrzKR28+BcJbG5kguyytRjkg
         rjsFU2rMHcaFZYM7jRBwDx3y4TNjRz8cS5RWMgjh+1ofnV6wnx05hcN9heFlTTNfsAVq
         qUjZMJxGLa9mHYyEFjkrcwiRRdLtgvROz3H/Z1mIRgvYivxLAzSanUXyi85+4NTaGuJS
         Ssew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wvI0q5HAql8tMPxcnKbiOi/9NxgmmSwnzAAkVZd1GZE=;
        b=z4nVDppIHSeyqwYi14NEyR86P+1P8l37II4BItgDewGhn2BTNTck3mtEj6VLi7hO23
         hNJE+p/cfPb7X+RYitmxYPO9pqPIqgrC8bx8S1vVAA27a3z1BN2TBXf1NL/C3vs/bGYw
         sf0oKq5ygu0ifv194tMTfPoW46asx7zWchhhUFVvTEZRXr0L9EnIUgmGub2zlVn/9Cx5
         ZWwFInY8kJVJ+t7MvWBRP2r3ZuKKNCiP+gnQpgsbJhsg72qHlnXeAoHivUnKd+SInsQj
         iI2wj+9/q+xFHc6QjWArZbeNU4vj+RZL/kekODT6u+EZObgfDIVRWlruV/ceYBlMdLkU
         vpdA==
X-Gm-Message-State: AJIora8aky/JjTYAGI7Xn4q0GC1+AmTE0n6O+vBqM/7s1xsDiX+EJBDw
        38gvqx/1HxY0TXI0cttUYnYnxUEML+2bgw==
X-Google-Smtp-Source: AGRyM1sy1sNPIZTfbcs9D/R5onBZFJSx4EAG07fQgd3u5pHjtvT3tSBi6UiM7uRquYtBlR+3qYzZvg==
X-Received: by 2002:a17:90b:3d84:b0:1ef:9049:9f43 with SMTP id pq4-20020a17090b3d8400b001ef90499f43mr12682443pjb.45.1658426335405;
        Thu, 21 Jul 2022 10:58:55 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b0016c1cdd2de3sm1956763pln.281.2022.07.21.10.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 10:58:54 -0700 (PDT)
Date:   Thu, 21 Jul 2022 17:58:50 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Wei Wang <wei.w.wang@linux.intel.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
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
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 11/14] KVM: Register/unregister the guest private
 memory regions
Message-ID: <YtmT2irvgInX1kPp@google.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-12-chao.p.peng@linux.intel.com>
 <f02baa37-8d34-5d07-a0ae-300ffefc7fee@amd.com>
 <20220719140843.GA84779@chaop.bj.intel.com>
 <36e671d2-6b95-8e4f-c2ac-fee4b2670c6e@amd.com>
 <20220720150706.GB124133@chaop.bj.intel.com>
 <d0fd229d-afa6-c66d-3e55-09ac5877453e@amd.com>
 <YtgrkXqP/GIi9ujZ@google.com>
 <45ae9f57-d595-f202-abb5-26a03a2ca131@linux.intel.com>
 <20220721092906.GA153288@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721092906.GA153288@chaop.bj.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 21, 2022, Chao Peng wrote:
> On Thu, Jul 21, 2022 at 03:34:59PM +0800, Wei Wang wrote:
> > 
> > 
> > On 7/21/22 00:21, Sean Christopherson wrote:
> > Maybe you could tag it with cgs for all the confidential guest support
> > related stuff: e.g. kvm_vm_ioctl_set_cgs_mem()
> > 
> > bool is_private = ioctl == KVM_MEMORY_ENCRYPT_REG_REGION;
> > ...
> > kvm_vm_ioctl_set_cgs_mem(, is_private)
> 
> If we plan to widely use such abbr. through KVM (e.g. it's well known),
> I'm fine.

I'd prefer to stay away from "confidential guest", and away from any VM-scoped
name for that matter.  User-unmappable memmory has use cases beyond hiding guest
state from the host, e.g. userspace could use inaccessible/unmappable memory to
harden itself against unintentional access to guest memory.

> I actually use mem_attr in patch: https://lkml.org/lkml/2022/7/20/610
> But I also don't quite like it, it's so generic and sounds say nothing.
> 
> But I do want a name can cover future usages other than just 
> private/shared (pKVM for example may have a third state).

I don't think there can be a third top-level state.  Memory is either private to
the guest or it's not.  There can be sub-states, e.g. memory could be selectively
shared or encrypted with a different key, in which case we'd need metadata to
track that state.

Though that begs the question of whether or not private_fd is the correct
terminology.  E.g. if guest memory is backed by a memfd that can't be mapped by
userspace (currently F_SEAL_INACCESSIBLE), but something else in the kernel plugs
that memory into a device or another VM, then arguably that memory is shared,
especially the multi-VM scenario.

For TDX and SNP "private vs. shared" is likely the correct terminology given the
current specs, but for generic KVM it's probably better to align with whatever
terminology is used for memfd.  "inaccessible_fd" and "user_inaccessible_fd" are
a bit odd since the fd itself is accesible.

What about "user_unmappable"?  E.g.

  F_SEAL_USER_UNMAPPABLE, MFD_USER_UNMAPPABLE, KVM_HAS_USER_UNMAPPABLE_MEMORY,
  MEMFILE_F_USER_INACCESSIBLE, user_unmappable_fd, etc...

that gives us flexibility to map the memory from within the kernel, e.g. into
other VMs or devices.

Hmm, and then keep your original "mem_attr_array" name?  And probably 

 int kvm_vm_ioctl_set_mem_attr(struct kvm *kvm, gpa_t gpa, gpa_t size,
 			       bool is_user_mappable)

Then the x86/mmu code for TDX/SNP private faults could be:

	is_private = !kvm_is_gpa_user_mappable();

	if (fault->is_private != is_private) {

or if we want to avoid mixing up "user_mappable" and "user_unmappable":

	is_private = kvm_is_gpa_user_unmappable();

	if (fault->is_private != is_private) {

though a helper that returns a negative (not mappable) feels kludgy.  And I like
kvm_is_gpa_user_mappable() because then when there's not "special" memory, it
defaults to true, which is more intuitive IMO.

And then if the future needs more precision, e.g. user-unmappable memory isn't
necessarily guest-exclusive, the uAPI names still work even though KVM internals
will need to be reworked, but that's unavoidable.  E.g. piggybacking
KVM_MEMORY_ENCRYPT_(UN)REG_REGION doesn't allow for further differentiation,
so we'd need to _extend_ the uAPI, but the _existing_ uAPI would still be sane.

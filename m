Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA55654A9B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 08:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352389AbiFNGs5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 02:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352348AbiFNGs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:48:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B42393D0;
        Mon, 13 Jun 2022 23:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655189335; x=1686725335;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=wuX5JnFrxSq386a6TH37odo/ge8jsmW2qkPxXWwsMwk=;
  b=XqyBeM+SC0sn1m7v6sUkGKi3+OmUwaPu8oyiBwspM2lG1Iic58DIA9vw
   BsBnIj1O+Wjy1LFUBhFzfVmct8m2xyi9ZXj648n+QmmsfIwd9Y62S1vxg
   rIs9oFIPj4C7JjaL5z475EnQcUC3dP8Qzi6kJu36+Fm601u6gGVi4LDlA
   UQbsc1ZFe7GHxZ3E3ls4b4Ua8RwQMk1G71H3wU06W3yz763pklJWFcm7M
   UksybhVQ+ibZYou2JPRLTqdstS+yj2IofS4ch5SpC87yuCVVhuuuhYq1I
   x7Dd/G8pOLEfKVJnXbWGRupqhA2wEr8cdoO6ZRQYAjXy7n5Vrjkvptcxi
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="303933443"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="303933443"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 23:48:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="582566724"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 13 Jun 2022 23:48:44 -0700
Date:   Tue, 14 Jun 2022 14:45:22 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>, kvm@vger.kernel.org,
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Subject: Re: [PATCH v6 4/8] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <20220614064522.GA1783435@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-5-chao.p.peng@linux.intel.com>
 <8840b360-cdb2-244c-bfb6-9a0e7306c188@kernel.org>
 <YofeZps9YXgtP3f1@google.com>
 <20220523132154.GA947536@chaop.bj.intel.com>
 <YoumuHUmgM6TH20S@google.com>
 <20220530132613.GA1200843@chaop.bj.intel.com>
 <YqNt3Sgzge5Rph/R@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqNt3Sgzge5Rph/R@google.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 10, 2022 at 04:14:21PM +0000, Sean Christopherson wrote:
> On Mon, May 30, 2022, Chao Peng wrote:
> > On Mon, May 23, 2022 at 03:22:32PM +0000, Sean Christopherson wrote:
> > > Actually, if the semantics are that userspace declares memory as private, then we
> > > can reuse KVM_MEMORY_ENCRYPT_REG_REGION and KVM_MEMORY_ENCRYPT_UNREG_REGION.  It'd
> > > be a little gross because we'd need to slightly redefine the semantics for TDX, SNP,
> > > and software-protected VM types, e.g. the ioctls() currently require a pre-exisitng
> > > memslot.  But I think it'd work...
> > 
> > These existing ioctls looks good for TDX and probably SNP as well. For
> > softrware-protected VM types, it may not be enough. Maybe for the first
> > step we can reuse this for all hardware based solutions and invent new
> > interface when software-protected solution gets really supported.
> > 
> > There is semantics difference for fd-based private memory. Current above
> > two ioctls() use userspace addreess(hva) while for fd-based it should be
> > fd+offset, and probably it's better to use gpa in this case. Then we
> > will need change existing semantics and break backward-compatibility.
> 
> My thought was to keep the existing semantics for VMs with type==0, i.e. SEV and
> SEV-ES VMs.  It's a bit gross, but the pinning behavior is a dead end for SNP and
> TDX, so it effectively needs to be deprecated anyways. 

Yes agreed.

> I'm definitely not opposed
> to a new ioctl if Paolo or others think this is too awful, but burning an ioctl
> for this seems wasteful.

Yes, I also feel confortable if it's acceptable to reuse kvm_enc_region
to pass _gpa_ range for this new type.

> 
> Then generic KVM can do something like:
> 
> 	case KVM_MEMORY_ENCRYPT_REG_REGION:
> 	case KVM_MEMORY_ENCRYPT_UNREG_REGION:
> 		struct kvm_enc_region region;
> 
> 		if (!kvm_arch_vm_supports_private_memslots(kvm))
> 			goto arch_vm_ioctl;
> 
> 		r = -EFAULT;
> 		if (copy_from_user(&region, argp, sizeof(region)))
> 			goto out;
> 
> 		r = kvm_set_encrypted_region(ioctl, &region);
> 		break;
> 	default:
> arch_vm_ioctl:
> 		r = kvm_arch_vm_ioctl(filp, ioctl, arg);
> 
> 
> where common KVM provides
> 
>   __weak void kvm_arch_vm_supports_private_memslots(struct kvm *kvm)
>   {
> 	return false;
>   }

I already had kvm_arch_private_mem_supported() introduced in patch-07
so that can be reused.

> 
> and x86 overrides that to
> 
>   bool kvm_arch_vm_supports_private_memslots(struct kvm *kvm)
>   {
>   	/* I can't remember what we decided on calling type '0' VMs. */
> 	return !!kvm->vm_type;
>   }
> 
> and if someone ever wants to enable private memslot for SEV/SEV-ES guests we can
> always add a capability or even a new VM type.
> 
> pKVM on arm can then obviously implement kvm_arch_vm_supports_private_memslots()
> to grab whatever identifies a pKVM VM.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00AC57A174
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 16:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbiGSO2J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 10:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237767AbiGSO1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:27:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B37BDF;
        Tue, 19 Jul 2022 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658240047; x=1689776047;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=/UxCRrCRwzJ4X66ZQ0IeKBQtuQGxvYag5toGoeMRWuQ=;
  b=CZYyYygzXCqloUO9aGVdDcJXYjTh9oYBJFxUMSxe3vvRKpU4gOckgOMn
   JilTFTI6emQSdx8rywraLU90dhr1EOEFNhKfhHa+WsZwIMkLeSH7zbqq8
   FJouPrO28zJUxeb/SxE4iTLfLasD7me/K4TWdAjq7X4a2dohduIirBRKf
   WNMDKsJHPtvSN0BsTYzXvXe3ManHlqTz4kQe21r9Bp/HBTiLQpGGnwOKd
   U3tdxxcsUWbu4QZv9FYTSDAfiMSLeYxqi5lVXlJjruhpOV6n6KK1zvRtZ
   q9yPYIc6RAqbyfUskmfkyguvP+kJlEdUqp0XNo4+JbI2iX1YsPRQhKoAg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="284063648"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="284063648"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 07:13:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="655776691"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jul 2022 07:13:34 -0700
Date:   Tue, 19 Jul 2022 22:08:43 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 11/14] KVM: Register/unregister the guest private
 memory regions
Message-ID: <20220719140843.GA84779@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-12-chao.p.peng@linux.intel.com>
 <f02baa37-8d34-5d07-a0ae-300ffefc7fee@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f02baa37-8d34-5d07-a0ae-300ffefc7fee@amd.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 19, 2022 at 10:00:23AM +0200, Gupta, Pankaj wrote:

...

> > +bool __weak kvm_arch_private_mem_supported(struct kvm *kvm)
> > +{
> > +	return false;
> > +}
> 
> Does this function has to be overriden by SEV and TDX to support the private
> regions?

Yes it should be overridden by architectures which want to support it.

> 
> > +
> >   static int check_memory_region_flags(const struct kvm_user_mem_region *mem)
> >   {
> >   	u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
> > @@ -4689,6 +4729,22 @@ static long kvm_vm_ioctl(struct file *filp,
> >   		r = kvm_vm_ioctl_set_memory_region(kvm, &mem);
> >   		break;
> >   	}
> > +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> > +	case KVM_MEMORY_ENCRYPT_REG_REGION:
> > +	case KVM_MEMORY_ENCRYPT_UNREG_REGION: {
> > +		struct kvm_enc_region region;
> > +
> > +		if (!kvm_arch_private_mem_supported(kvm))
> > +			goto arch_vm_ioctl;
> > +
> > +		r = -EFAULT;
> > +		if (copy_from_user(&region, argp, sizeof(region)))
> > +			goto out;
> > +
> > +		r = kvm_vm_ioctl_set_encrypted_region(kvm, ioctl, &region);
> 
> this is to store private region metadata not only the encrypted region?

Correct.

> 
> Also, seems same ioctl can be used to put other regions (e.g firmware, later
> maybe DAX backend etc) into private memory?

Possibly. Depends on what exactly the semantics is. If just want to set
those regions as private current code already support that.

Chao
> 
> > +		break;
> > +	}
> > +#endif
> >   	case KVM_GET_DIRTY_LOG: {
> >   		struct kvm_dirty_log log;
> > @@ -4842,6 +4898,7 @@ static long kvm_vm_ioctl(struct file *filp,
> >   		r = kvm_vm_ioctl_get_stats_fd(kvm);
> >   		break;
> >   	default:
> > +arch_vm_ioctl:
> >   		r = kvm_arch_vm_ioctl(filp, ioctl, arg);
> >   	}
> >   out:
> 

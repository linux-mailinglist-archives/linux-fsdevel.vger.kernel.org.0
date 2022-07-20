Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D6557BB54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 18:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbiGTQVr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 12:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiGTQVo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:21:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1B561B0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jul 2022 09:21:42 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y141so16917958pfb.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jul 2022 09:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f0adogo0zxbyENycGDyitWJjrMgz2USumvEVtMapSaM=;
        b=spGLDNQ08YQPqH7UmhIpiHe2RaM2zw7ODEii6vmP7whH0yk8NhoS7QYoLrpacwnfbW
         S3VkQABUgvOUZAhV+aAm4mnqaDYIZ6zOWmQpK2Ozj1qZ4yEP8IO8Ogxh+e38++9rhFjG
         Gncn3BStXeB7j7O3s/y/CX20mihB4UWNCG15aOuY2njFY086JqM16L+H4BlY/AN8pWe8
         s9ex7tY8xz16AMATUg5JkSGjI8FqtQ1JH/Ckd2eXT2/cGJ188i8q7NwsSTtTXSvKMUHc
         Y4He+Vu/AgyMtaInE+pTo4N4Wc2xqCJOuE/medBD2cHSdxBx52LLtQTesVoUiLmIcCvV
         AYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f0adogo0zxbyENycGDyitWJjrMgz2USumvEVtMapSaM=;
        b=2ujeAGAzp3RusIvwbOLDUlhrK150cQ/8R5Dx09Wa5vSHCFwQjqq1mGdZhT/4AwsCXB
         5D+ri+D6Rc6H2I6UipB8RpFZvmfKgWJrF1+YlpOs41VFuH7reNLuSk8RVl2TubBOvOj2
         jVmG8b00VMM71Q0epmab5H9yT252P4zCSiRZCkD9oka0VS4rD+jUugM5+8uUFn7X/GNC
         lgQjtkQpHmMonHpY4QP21rqWmYRow6DMMpgdkYdi//uuPPVkGpOK9SDrpDHT/qbDQJV4
         73jCT2IlJ0DrjV9iOLjdauL8+wONAluFpcqWVXOIbgIY5clcufFChAUEvHXOYshFLsXp
         se6A==
X-Gm-Message-State: AJIora+uk/gcu+x93OLVbYEa91QxtIaw29H+rpyuWnwCj0qOGLUZVlLT
        5lzUtmN45BilzVhMsQAqhrZlTQ==
X-Google-Smtp-Source: AGRyM1vSVUjKLbGc4Kd7xVml29j/pMq086Pfs5AgzFCjeBxpV+cVQy9BGtwT6tQB+IRvWirFlwJ5Og==
X-Received: by 2002:a65:6bcc:0:b0:3f6:1815:f541 with SMTP id e12-20020a656bcc000000b003f61815f541mr33324434pgw.183.1658334101831;
        Wed, 20 Jul 2022 09:21:41 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id g5-20020a63dd45000000b0041a4d5e7e5fsm3266314pgj.47.2022.07.20.09.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 09:21:41 -0700 (PDT)
Date:   Wed, 20 Jul 2022 16:21:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
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
Message-ID: <YtgrkXqP/GIi9ujZ@google.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-12-chao.p.peng@linux.intel.com>
 <f02baa37-8d34-5d07-a0ae-300ffefc7fee@amd.com>
 <20220719140843.GA84779@chaop.bj.intel.com>
 <36e671d2-6b95-8e4f-c2ac-fee4b2670c6e@amd.com>
 <20220720150706.GB124133@chaop.bj.intel.com>
 <d0fd229d-afa6-c66d-3e55-09ac5877453e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0fd229d-afa6-c66d-3e55-09ac5877453e@amd.com>
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

On Wed, Jul 20, 2022, Gupta, Pankaj wrote:
> 
> > > > > > +bool __weak kvm_arch_private_mem_supported(struct kvm *kvm)

Use kvm_arch_has_private_mem(), both because "has" makes it obvious this is checking
a flag of sorts, and to align with other helpers of this nature (and with
CONFIG_HAVE_KVM_PRIVATE_MEM).

  $ git grep kvm_arch | grep supported | wc -l
  0
  $ git grep kvm_arch | grep has | wc -l
  26

> > > > > > +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> > > > > > +	case KVM_MEMORY_ENCRYPT_REG_REGION:
> > > > > > +	case KVM_MEMORY_ENCRYPT_UNREG_REGION: {
> > > > > > +		struct kvm_enc_region region;
> > > > > > +
> > > > > > +		if (!kvm_arch_private_mem_supported(kvm))
> > > > > > +			goto arch_vm_ioctl;
> > > > > > +
> > > > > > +		r = -EFAULT;
> > > > > > +		if (copy_from_user(&region, argp, sizeof(region)))
> > > > > > +			goto out;
> > > > > > +
> > > > > > +		r = kvm_vm_ioctl_set_encrypted_region(kvm, ioctl, &region);
> > > > > 
> > > > > this is to store private region metadata not only the encrypted region?
> > > > 
> > > > Correct.
> > > 
> > > Sorry for not being clear, was suggesting name change of this function from:
> > > "kvm_vm_ioctl_set_encrypted_region" to "kvm_vm_ioctl_set_private_region"
> > 
> > Though I don't have strong reason to change it, I'm fine with this and
> 
> Yes, no strong reason, just thought "kvm_vm_ioctl_set_private_region" would
> depict the actual functionality :)
> 
> > this name matches the above kvm_arch_private_mem_supported perfectly.
> BTW could not understand this, how "kvm_vm_ioctl_set_encrypted_region"
> matches "kvm_arch_private_mem_supported"?

Chao is saying that kvm_vm_ioctl_set_private_region() pairs nicely with
kvm_arch_private_mem_supported(), not that the "encrypted" variant pairs nicely.

I also like using "private" instead of "encrypted", though we should probably
find a different verb than "set", because calling "set_private" when making the
region shared is confusing.  I'm struggling to come up with a good alternative
though.

kvm_vm_ioctl_set_memory_region() is already taken by KVM_SET_USER_MEMORY_REGION,
and that also means that anything with "memory_region" in the name is bound to be
confusing.

Hmm, and if we move away from "encrypted", it probably makes sense to pass in
addr+size instead of a kvm_enc_region.

Maybe this?

static int kvm_vm_ioctl_set_or_clear_mem_private(struct kvm *kvm, gpa_t gpa,
					         gpa_t size, bool set_private)

and then:

#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
	case KVM_MEMORY_ENCRYPT_REG_REGION:
	case KVM_MEMORY_ENCRYPT_UNREG_REGION: {
		bool set = ioctl == KVM_MEMORY_ENCRYPT_REG_REGION;
		struct kvm_enc_region region;

		if (!kvm_arch_private_mem_supported(kvm))
			goto arch_vm_ioctl;

		r = -EFAULT;
		if (copy_from_user(&region, argp, sizeof(region)))
			goto out;

		r = kvm_vm_ioctl_set_or_clear_mem_private(kvm, region.addr,
							  region.size, set);
		break;
	}
#endif

I don't love it, so if someone has a better idea...

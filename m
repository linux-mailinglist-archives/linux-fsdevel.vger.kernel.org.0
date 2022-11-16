Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F6C62CD8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 23:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbiKPWY3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 17:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238754AbiKPWYV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:24:21 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E37A6AEEB
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 14:24:16 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id h193so217547pgc.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 14:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QGkcU8bsAXTracYvItbCwnniUSLgMtAC897scf+9ddo=;
        b=Yb4wKwuTq8SDmbVGc+P7ahM8KCEiEG3EeQYJnIBy43Yu4s+iC+yGjvQgmVRoCCNQD4
         bFiXa2DlOoj+M6COODORifyN82jIJfcy0aF0ZJtT8PTph1kJcj2QMeh/X+0txTmE1L9e
         vjCm/+n4/Ca01rOL6VyR5fbnbwtckm/wl6rnzgA+2U9G86s1X+WQKo3mRqwdqt/NZj4i
         P3BxQwhuIeyDfA8UssWFkeXvKFbx/BZ4epGrEEpau+te7+rSV+HSw5cBzmIPmEEBr4ge
         1bl1xkBDMVGhMoLkvC/hKl/ZnG4RNCOpP9NsjFm/3oC6Zxx7zYxZx28Lz46N2hnBOT/Z
         8NoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGkcU8bsAXTracYvItbCwnniUSLgMtAC897scf+9ddo=;
        b=4njURBBl5sYNiC+l6ptnKiRhgtabTLvAV6nT1G+ZvEXOG9DnkVNbI5TBfODDDQH8f5
         JbyknihAWrpRusgJiJAx7L+yKo8l08hDtxBoVRtqeIHJGdkcD0GoRsH4+Xq1wXiWe4Q7
         MbG3A3J5w36R4TaeZnO5nnf44R9wokFCBMi56H9FW5ARfIoUDewUybvYIPnRLMhK8F0T
         FDqUgtyBM1s+lwEQJoXDGSaY0stgCOWpN8+IgW+EiwZoDalWQRW+0AVbu0jt63UhXAbO
         SCiuq5jUt3MLjVJil1L0jQBsXO9WDInb6z3TiL5WlY5Rs+VRlm4joNOlFyF8aGIDmWuy
         BGEA==
X-Gm-Message-State: ANoB5plY9JS6dKbDEKN59TP2HQPO9cdYNsK313LBdavshCfn9wr5qk9G
        5xGqlTE1I0R+3tU6x5GqVrRS0w==
X-Google-Smtp-Source: AA0mqf57GusGHy4fGdIdCCD+ypBDi3fwzFhsJUW/Qb2DW/M9r1lO66W8ccdVhRkSLbzOP4I6svKevg==
X-Received: by 2002:a63:560c:0:b0:476:9983:b4b5 with SMTP id k12-20020a63560c000000b004769983b4b5mr12164723pgb.516.1668637455542;
        Wed, 16 Nov 2022 14:24:15 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7972f000000b0056bbba4302dsm11324389pfg.119.2022.11.16.14.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 14:24:15 -0800 (PST)
Date:   Wed, 16 Nov 2022 22:24:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
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
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v9 5/8] KVM: Register/unregister the guest private memory
 regions
Message-ID: <Y3VjCxCiujCOLP7x@google.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-6-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025151344.3784230-6-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 25, 2022, Chao Peng wrote:
> +static int kvm_vm_ioctl_set_mem_attr(struct kvm *kvm, gpa_t gpa, gpa_t size,
> +				     bool is_private)
> +{
> +	gfn_t start, end;
> +	unsigned long i;
> +	void *entry;
> +	int idx;
> +	int r = 0;
> +
> +	if (size == 0 || gpa + size < gpa)
> +		return -EINVAL;
> +	if (gpa & (PAGE_SIZE - 1) || size & (PAGE_SIZE - 1))
> +		return -EINVAL;
> +
> +	start = gpa >> PAGE_SHIFT;
> +	end = (gpa + size - 1 + PAGE_SIZE) >> PAGE_SHIFT;
> +
> +	/*
> +	 * Guest memory defaults to private, kvm->mem_attr_array only stores
> +	 * shared memory.
> +	 */
> +	entry = is_private ? NULL : xa_mk_value(KVM_MEM_ATTR_SHARED);
> +
> +	idx = srcu_read_lock(&kvm->srcu);
> +	KVM_MMU_LOCK(kvm);
> +	kvm_mmu_invalidate_begin(kvm, start, end);
> +
> +	for (i = start; i < end; i++) {
> +		r = xa_err(xa_store(&kvm->mem_attr_array, i, entry,
> +				    GFP_KERNEL_ACCOUNT));
> +		if (r)
> +			goto err;
> +	}
> +
> +	kvm_unmap_mem_range(kvm, start, end);
> +
> +	goto ret;
> +err:
> +	for (; i > start; i--)
> +		xa_erase(&kvm->mem_attr_array, i);

I don't think deleting previous entries is correct.  To unwind, the correct thing
to do is restore the original values.  E.g. if userspace space is mapping a large
range as shared, and some of the previous entries were shared, deleting them would
incorrectly "convert" those entries to private.

Tracking the previous state likely isn't the best approach, e.g. it would require
speculatively allocating extra memory for a rare condition that is likely going to
lead to OOM anyways.

Instead of trying to unwind, what about updating the ioctl() params such that
retrying with the updated addr+size would Just Work?  E.g.

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 55b07aae67cc..f1de592a1a06 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1015,15 +1015,12 @@ static int kvm_vm_ioctl_set_mem_attr(struct kvm *kvm, gpa_t gpa, gpa_t size,
 
        kvm_unmap_mem_range(kvm, start, end, attr);
 
-       goto ret;
-err:
-       for (; i > start; i--)
-               xa_erase(&kvm->mem_attr_array, i);
-ret:
        kvm_mmu_invalidate_end(kvm, start, end);
        KVM_MMU_UNLOCK(kvm);
        srcu_read_unlock(&kvm->srcu, idx);
 
+       <update gpa and size>
+
        return r;
 }
 #endif /* CONFIG_KVM_GENERIC_PRIVATE_MEM */
@@ -4989,6 +4986,8 @@ static long kvm_vm_ioctl(struct file *filp,
 
                r = kvm_vm_ioctl_set_mem_attr(kvm, region.addr,
                                              region.size, set);
+               if (copy_to_user(argp, &region, sizeof(region)) && !r)
+                       r = -EFAULT
                break;
        }
 #endif

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC7747C34D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 16:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbhLUPqf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 10:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239516AbhLUPop (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:44:45 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88549C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Dec 2021 07:44:45 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id k64so12092493pfd.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Dec 2021 07:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k/JMvwK29hd8F/EfV5XzDRnc59RW8yzi0W84ODXNMgs=;
        b=AbVrsJdBc5MN3KQC0A9AIyS9IRMdFjbEfvVJtUC3LZIrYXKcfifwgybiMrJ1dzyejd
         q8YUFb1QM78QNIXTzVIec5gAsnLvo3X4AAG9zJHBWwIwUsGBs7Az4wPXZREawmQ76537
         D4yK7omm6pLvt14gmta/yF+uKHmpG3uYwhvqYGCO1YbTfXustV5RYUKJ6USZinlk6B9J
         dms6mrO1SjUxJjtuiu0tTWEq3XPddVfxNpbBEmbK2Nvq8909cqhkI5e1UBaZoLob+Zff
         NFQDtXgY+753bzTe2lIKwytRe5IF/iysrdIxwl5Qq0gfzEU22ZxLymbf3FGvWJr/8MfY
         IGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k/JMvwK29hd8F/EfV5XzDRnc59RW8yzi0W84ODXNMgs=;
        b=O53sWBt0hgPulQ6Hrrzspy9OQpqALeXCyB2tDKEZEgWjJ97Bmj0/xF+yV5JeoxghST
         NrYD12Nqf/JdgMALr4+Ce9BdS4ElX53YpDjjEBwJt9ykNHNfjoN2NkU+h1/P6TB7r1U2
         qE3AlG7w5HBgLI60Sx+rpeWvOYIIyaJQ1IRWDFnucd+4HNiIcxJpMDdOvrG5eSVKl/mc
         yhp9SFiryD/qYwV3JEKfLVt5tsbxZ722bDgnx68q+Az/z+5hW8rM2aciZ9Pu7Uim4TiG
         I+2VFPfGovdYN1ubvh0Ypbknt6LStPMWOK8cilWYI9SKla5QkKOlQYZM+gujPLnn/QkU
         ZYCA==
X-Gm-Message-State: AOAM531bfyoE6P58WCGA/6iy7CUvOynSG5i1vIBAgjjwDOBcD2OMwQ8v
        QMabnANSyCdlho5lSBash02Eug==
X-Google-Smtp-Source: ABdhPJxrzNHBFbWmw0xZGAtZ2iGNWlJDv22rYelmdk8vCnJP2iZK3gUwsvnZ7g69hELWZvhhMRjJJA==
X-Received: by 2002:a63:8249:: with SMTP id w70mr3516432pgd.274.1640101484781;
        Tue, 21 Dec 2021 07:44:44 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s16sm22577607pfu.109.2021.12.21.07.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:44:44 -0800 (PST)
Date:   Tue, 21 Dec 2021 15:44:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: Re: [PATCH v3 00/15] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <YcH2aGNJn57pLihJ@google.com>
References: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 21, 2021, Chao Peng wrote:
> This is the third version of this series which try to implement the
> fd-based KVM guest private memory.

...

> Test
> ----
> This code has been tested with latest TDX code patches hosted at
> (https://github.com/intel/tdx/tree/kvm-upstream) with minimal TDX
> adaption and QEMU support.
> 
> Example QEMU command line:
> -object tdx-guest,id=tdx \
> -object memory-backend-memfd-private,id=ram1,size=2G \
> -machine q35,kvm-type=tdx,pic=no,kernel_irqchip=split,memory-encryption=tdx,memory-backend=ram1
> 
> Changelog
> ----------
> v3:
>   - Added locking protection when calling
>     invalidate_page_range/fallocate callbacks.
>   - Changed memslot structure to keep use useraddr for shared memory.
>   - Re-organized F_SEAL_INACCESSIBLE and MEMFD_OPS.
>   - Added MFD_INACCESSIBLE flag to force F_SEAL_INACCESSIBLE.
>   - Commit message improvement.
>   - Many small fixes for comments from the last version.

Can you rebase on top of kvm/queue and send a new version?  There's a massive
overhaul of KVM's memslots code that's queued for 5.17, and the KVM core changes
in this series conflict mightily.

It's ok if the private memslot support isn't tested exactly as-is, it's not like
any of us reviewers can test it anyways, but I would like to be able to apply
cleanly and verify that the series doesn't break existing functionality.

This version also appears to be based on an internal development branch, e.g. patch
12/15 has some bits from the TDX series.

@@ -336,6 +348,7 @@ struct kvm_tdx_exit {
 #define KVM_EXIT_X86_BUS_LOCK     33
 #define KVM_EXIT_XEN              34
 #define KVM_EXIT_RISCV_SBI        35
+#define KVM_EXIT_MEMORY_ERROR     36
 #define KVM_EXIT_TDX              50   /* dump number to avoid conflict. */

 /* For KVM_EXIT_INTERNAL_ERROR */
@@ -554,6 +567,8 @@ struct kvm_run {
                        unsigned long args[6];
                        unsigned long ret[2];
                } riscv_sbi;
+               /* KVM_EXIT_MEMORY_ERROR */
+               struct kvm_memory_exit mem;
                /* KVM_EXIT_TDX_VMCALL */
                struct kvm_tdx_exit tdx;
                /* Fix the size of the union. */


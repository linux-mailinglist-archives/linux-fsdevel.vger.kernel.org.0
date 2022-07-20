Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B6457BBA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 18:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiGTQok (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 12:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGTQoi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:44:38 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F2766AC9
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jul 2022 09:44:37 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id g17so15477011plh.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jul 2022 09:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NKI6wQLzSjuIgXqGP/STBDd/io3ztt1cS6FImLHwFp4=;
        b=aYf105zHRqcKnwIvd6ekmpqruUyQToVuka3h99YqNWRmFXkZ7ZVHV8oWNskzAvMx2F
         hflOC9nxBStxjqtxvcltphe6Q5E58yJ1G2iJfhXNEqLsdIUxBz1Jghs5U/OLu3mGUc1a
         JRrnyPRUFOER4kSZYOrYSqnkSlzR3XQAIIqK13/lyE2A23HrMPyXlZiOV822mKgY0tgd
         nTwYcdRpttHY+A4wo2bLHxYVFSJL0sIrCNfPF0RyUS+KwJ64AABEJ8yX01Hb9NjXpaI/
         s6Pf48SWnWTxK6vMsYlo9rnJGzIsPUCTu5j+IdeVl1yrYnYpbPzLMaw748Y0j9AcRKUU
         ZGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NKI6wQLzSjuIgXqGP/STBDd/io3ztt1cS6FImLHwFp4=;
        b=l51H/nyNrh1tlvQ0Q9rXtttAIeDqqvMpBPrAC2sIivWjUqkY9XMhX4JM/xDXLa/aQv
         zl2WfBgB/834DahyhA7UciRhGkJylZitY5pFjgBzn0oYJbxYYrQXUwBwalTUJwVM81LB
         swbezdkqgTH/ty6X5DfAGTZ3WVzfmTYJAyStna3sWE6ujNROwmPWjSmBRSaYOmKqaCMG
         tjfU029ph/OBp7Y3hfVSXti0dMLIwXUM6TKesrtMe/fvtNq6uBSxwxWsiEU5QkhkSPXu
         6NZewYsEN1UoAL3wIEYnyVDFExMReoF2ppeB+NvdEmvwKsLOmT78jY2L1tD5vc6l3HCW
         ylMg==
X-Gm-Message-State: AJIora/xUL2sT2oS5TRGGyIv30T9lFElqaIq0ibLrqxhb1PP/Z2l8V+x
        ehInJa0ntLVQys6P4ncQf44V5tk/NUxMZA==
X-Google-Smtp-Source: AGRyM1utYrsQFWglg8OIUvJRKtR6LVkU7MbzTy7HM7RFQtBExxPfhBWR/u5swtl61L63cUwi4vupQg==
X-Received: by 2002:a17:90b:3ec1:b0:1f1:edcf:dd2b with SMTP id rm1-20020a17090b3ec100b001f1edcfdd2bmr6535996pjb.156.1658335476747;
        Wed, 20 Jul 2022 09:44:36 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id k6-20020aa79986000000b00528c22038f5sm14345128pfh.14.2022.07.20.09.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 09:44:36 -0700 (PDT)
Date:   Wed, 20 Jul 2022 16:44:32 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
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
Message-ID: <Ytgw8HAsKTmZaubv@google.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-12-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706082016.2603916-12-chao.p.peng@linux.intel.com>
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

On Wed, Jul 06, 2022, Chao Peng wrote:
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 230c8ff9659c..bb714c2a4b06 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -914,6 +914,35 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
>  
>  #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
>  
> +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> +#define KVM_MEM_ATTR_PRIVATE	0x0001
> +static int kvm_vm_ioctl_set_encrypted_region(struct kvm *kvm, unsigned int ioctl,
> +					     struct kvm_enc_region *region)
> +{
> +	unsigned long start, end;

As alluded to in a different reply, because this will track GPAs instead of HVAs,
the type needs to be "gpa_t", not "unsigned long".  Oh, actually, they need to
be gfn_t, since those are what gets shoved into the xarray.

> +	void *entry;
> +	int r;
> +
> +	if (region->size == 0 || region->addr + region->size < region->addr)
> +		return -EINVAL;
> +	if (region->addr & (PAGE_SIZE - 1) || region->size & (PAGE_SIZE - 1))
> +		return -EINVAL;
> +
> +	start = region->addr >> PAGE_SHIFT;
> +	end = (region->addr + region->size - 1) >> PAGE_SHIFT;
> +
> +	entry = ioctl == KVM_MEMORY_ENCRYPT_REG_REGION ?
> +				xa_mk_value(KVM_MEM_ATTR_PRIVATE) : NULL;
> +
> +	r = xa_err(xa_store_range(&kvm->mem_attr_array, start, end,
> +					entry, GFP_KERNEL_ACCOUNT));

IIUC, this series treats memory as shared by default.  I think we should invert
that and have KVM's ABI be that all guest memory as private by default, i.e.
require the guest to opt into sharing memory instead of opt out of sharing memory.

And then the xarray would track which regions are shared.

Regarding mem_attr_array, it probably makes sense to explicitly include what it's
tracking in the name, i.e. name it {private,shared}_mem_array depending on whether
it's used to track private vs. shared memory.  If we ever need to track metadata
beyond shared/private then we can tweak the name as needed, e.g. if hardware ever
supports secondary non-ephemeral encryption keys.

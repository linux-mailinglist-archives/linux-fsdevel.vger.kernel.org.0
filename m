Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6624F848D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 18:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345636AbiDGQJA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 12:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345661AbiDGQHm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:07:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3FF18D2B0
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Apr 2022 09:05:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ku13-20020a17090b218d00b001ca8fcd3adeso9288841pjb.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Apr 2022 09:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oJxIZVkcUncMUZQfQzkdJ+zb+DZalywUloW4568yYn0=;
        b=kfqHsKdfw89Dwd7QGak9HdKv00acSQig8ZHOqKWrcgwuHdvnnaELMDCR55SPQFtBnS
         TCxq7MWV9AQn4Hy0EhgxCx0TPpiUCpQgwy7H23Vwal4SDaAw8HvwrqITWyGFNK4sQzhH
         JFlGRWNfuLUz6qBVdSmZZ4kfxxkJBk87qruGPkjprjbLBVVAK37/Q8fsRcuV33Xw/HVj
         B8h8cqJw82ZLbYL11sh4DuKcy3QGnH0AAQvp3PE979fT3HkEwRHAW82vgfR+KkL2QJN5
         KSj7BU6Ix6FVP1cRvsNGtSRLODq/C8E5+MMo0e8vGjCEj/PqSsvyu1EMlSFPMgRzy1o2
         ak7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oJxIZVkcUncMUZQfQzkdJ+zb+DZalywUloW4568yYn0=;
        b=yn3+/TIJ3X3N+aPnRSX0Qb8XaVyuqpqiVffxynx6SOqyCWqB3ZpgeAPvkhvXKtJ2zL
         BcvFp3BlpE32xmSnpiwRpkKDce9t5nlWRHvsgTuRKObHQ5ePlXgQh6pOc79jDT8TWBuZ
         aRyVspqD7b3MF2qK3+SKMF85WJunOF+tcZfYEQuigtMhUsesmNkoa/Zb0uV0oLxjS155
         G2Lq68/PnVSiSyFhwuupfMsN07EJGAreOrwFqStJh2Mb4s2qrEokqi1dEVX3GiuBNj6X
         NRMYeLYQqWR+mnEv/iEFlRVJqjMOMludBpVd4bP0UqX77Vr6VY7sO/foYRyqiBT7liat
         IMNA==
X-Gm-Message-State: AOAM530a7ImGtDeCBSvSJtjRNab6F28jelIn5w3ovIqRIf9X/dorZN8Z
        1YXN8uCBAMSY5WwSPbhFItGxVQ==
X-Google-Smtp-Source: ABdhPJxwrn5jcOCrefa44ifJu+1yvC1mRdMBBIerz3MlZcxhkTZR+e25OlxT/CA5AXmZeG4/pzPIww==
X-Received: by 2002:a17:90b:4a84:b0:1cb:29bd:db3e with SMTP id lp4-20020a17090b4a8400b001cb29bddb3emr1947695pjb.112.1649347540416;
        Thu, 07 Apr 2022 09:05:40 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q17-20020aa79831000000b0050566040330sm3561920pfl.126.2022.04.07.09.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 09:05:39 -0700 (PDT)
Date:   Thu, 7 Apr 2022 16:05:36 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
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
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v5 04/13] mm/shmem: Restrict MFD_INACCESSIBLE memory
 against RLIMIT_MEMLOCK
Message-ID: <Yk8L0CwKpTrv3Rg3@google.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-5-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310140911.50924-5-chao.p.peng@linux.intel.com>
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

On Thu, Mar 10, 2022, Chao Peng wrote:
> Since page migration / swapping is not supported yet, MFD_INACCESSIBLE
> memory behave like longterm pinned pages and thus should be accounted to
> mm->pinned_vm and be restricted by RLIMIT_MEMLOCK.
> 
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  mm/shmem.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 7b43e274c9a2..ae46fb96494b 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -915,14 +915,17 @@ static void notify_fallocate(struct inode *inode, pgoff_t start, pgoff_t end)
>  static void notify_invalidate_page(struct inode *inode, struct folio *folio,
>  				   pgoff_t start, pgoff_t end)
>  {
> -#ifdef CONFIG_MEMFILE_NOTIFIER
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  
> +#ifdef CONFIG_MEMFILE_NOTIFIER
>  	start = max(start, folio->index);
>  	end = min(end, folio->index + folio_nr_pages(folio));
>  
>  	memfile_notifier_invalidate(&info->memfile_notifiers, start, end);
>  #endif
> +
> +	if (info->xflags & SHM_F_INACCESSIBLE)
> +		atomic64_sub(end - start, &current->mm->pinned_vm);

As Vishal's to-be-posted selftest discovered, this is broken as current->mm may
be NULL.  Or it may be a completely different mm, e.g. AFAICT there's nothing that
prevents a different process from punching hole in the shmem backing.

I don't see a sane way of tracking this in the backing store unless the inode is
associated with a single mm when it's created, and that opens up a giant can of
worms, e.g. what happens with the accounting if the creating process goes away?

I think the correct approach is to not do the locking automatically for SHM_F_INACCESSIBLE,
and instead require userspace to do shmctl(.., SHM_LOCK, ...) if userspace knows the
consumers don't support migrate/swap.  That'd require wrapping migrate_page() and then
wiring up notifier hooks for migrate/swap, but IMO that's a good thing to get sorted
out sooner than later.  KVM isn't planning on support migrate/swap for TDX or SNP,
but supporting at least migrate for a software-only implementation a la pKVM should
be relatively straightforward.  On the notifiee side, KVM can terminate the VM if it
gets an unexpected migrate/swap, e.g. so that TDX/SEV VMs don't die later with
exceptions and/or data corruption (pre-SNP SEV guests) in the guest.

Hmm, shmem_writepage() already handles SHM_F_INACCESSIBLE by rejecting the swap, so
maybe it's just the page migration path that needs to be updated?

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61944F9C15
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 19:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238389AbiDHR7J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 13:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiDHR7H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:59:07 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE22310F6E3
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Apr 2022 10:57:00 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d15so8529584pll.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Apr 2022 10:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IudNh/HynxxH+tLoweLS06+fVTpNQOOa59eg8I3l6dE=;
        b=U2/eA7V9kOv67ug/CEAAH5jJ3bDdjcuxlz1/CKBkgdCZNj0JT/9J3pCPxI/ctDFSbM
         qK1+Sr9mcyKaUr/H66Pv9yktEidb3BhejDS+0/amDof+SQfyaKA08TzT03iiUsMWJJ3J
         1MOBs6THAm4fpRtqfO8Z5nRoWMFj9z3GkfuNpKxv/p7ca1UQgBQvuQUPEasblyTQ9RrO
         yn1hcR+9v3A8/OJPimHYWYuYVMj6vFYN+ei68jGp8D7XrjHDIdyTkfs0MDCZSOMFvB64
         yHKUCeuwajm7ozlzkxvbDs/GO8MPtR8QBXSY2YgA4lYkeM/deK+/SqRK5LFaoYUgODz1
         i3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IudNh/HynxxH+tLoweLS06+fVTpNQOOa59eg8I3l6dE=;
        b=TNYLowzEfgovRD9GN0Az9qEAx+XRe4PUym9jyPyFo1XxVPta6eizxopzTq2dVxM2Br
         TRFe9IDwn8JpnuN9Kl9vD/u4/+Ag9BDuPe2fP4LVI58x3UmQNm7VCib0gxD7t/zFAAhK
         IZi7vG/0DS2hVy70GWdleRJ6B6ZiBDKYf8F2YYP/OZyzgMDFFeN2Sqnt3HIyQ/Mtd0EY
         0+/7Lt+ch35C9wW4goHKNn3SRYyaoZZP212NUwKiApM0EEy0rLIJg9/MTMvV6/sBGlcK
         Pkb1q//LuHkYojVWE+j5p53thy3WNZwmydVf2bdcvf8T4OaRR+phytCDpw1XwMZrZE2D
         sUOg==
X-Gm-Message-State: AOAM532MVIZo4iZ69Sv2ifAqsEifcjUnToNiZaeJdI1H4cV569hqgsdS
        GxSdNYm2AhmiFGbQv/nUaIM/VQ==
X-Google-Smtp-Source: ABdhPJzyqykFhKSNRm78BrrnsD1mOVmGCPlJulii4V8oRfU//P/WLig+dmASk3SzvKPSoD3usOwcWw==
X-Received: by 2002:a17:903:2346:b0:156:9956:f437 with SMTP id c6-20020a170903234600b001569956f437mr20871133plh.123.1649440620128;
        Fri, 08 Apr 2022 10:57:00 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w123-20020a623081000000b005056a4d71e3sm6021624pfw.77.2022.04.08.10.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 10:56:59 -0700 (PDT)
Date:   Fri, 8 Apr 2022 17:56:55 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>,
        kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v5 04/13] mm/shmem: Restrict MFD_INACCESSIBLE memory
 against RLIMIT_MEMLOCK
Message-ID: <YlB3Z8fqJ+67a2Ck@google.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-5-chao.p.peng@linux.intel.com>
 <Yk8L0CwKpTrv3Rg3@google.com>
 <02e18c90-196e-409e-b2ac-822aceea8891@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02e18c90-196e-409e-b2ac-822aceea8891@www.fastmail.com>
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

On Thu, Apr 07, 2022, Andy Lutomirski wrote:
> 
> On Thu, Apr 7, 2022, at 9:05 AM, Sean Christopherson wrote:
> > On Thu, Mar 10, 2022, Chao Peng wrote:
> >> Since page migration / swapping is not supported yet, MFD_INACCESSIBLE
> >> memory behave like longterm pinned pages and thus should be accounted to
> >> mm->pinned_vm and be restricted by RLIMIT_MEMLOCK.
> >> 
> >> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> >> ---
> >>  mm/shmem.c | 25 ++++++++++++++++++++++++-
> >>  1 file changed, 24 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/mm/shmem.c b/mm/shmem.c
> >> index 7b43e274c9a2..ae46fb96494b 100644
> >> --- a/mm/shmem.c
> >> +++ b/mm/shmem.c
> >> @@ -915,14 +915,17 @@ static void notify_fallocate(struct inode *inode, pgoff_t start, pgoff_t end)
> >>  static void notify_invalidate_page(struct inode *inode, struct folio *folio,
> >>  				   pgoff_t start, pgoff_t end)
> >>  {
> >> -#ifdef CONFIG_MEMFILE_NOTIFIER
> >>  	struct shmem_inode_info *info = SHMEM_I(inode);
> >>  
> >> +#ifdef CONFIG_MEMFILE_NOTIFIER
> >>  	start = max(start, folio->index);
> >>  	end = min(end, folio->index + folio_nr_pages(folio));
> >>  
> >>  	memfile_notifier_invalidate(&info->memfile_notifiers, start, end);
> >>  #endif
> >> +
> >> +	if (info->xflags & SHM_F_INACCESSIBLE)
> >> +		atomic64_sub(end - start, &current->mm->pinned_vm);
> >
> > As Vishal's to-be-posted selftest discovered, this is broken as current->mm
> > may be NULL.  Or it may be a completely different mm, e.g. AFAICT there's
> > nothing that prevents a different process from punching hole in the shmem
> > backing.
> >
> 
> How about just not charging the mm in the first place?  There’s precedent:
> ramfs and hugetlbfs (at least sometimes — I’ve lost track of the current
> status).
> 
> In any case, for an administrator to try to assemble the various rlimits into
> a coherent policy is, and always has been, quite messy. ISTM cgroup limits,
> which can actually add across processes usefully, are much better.
> 
> So, aside from the fact that these fds aren’t in a filesystem and are thus
> available by default, I’m not convinced that this accounting is useful or
> necessary.
> 
> Maybe we could just have some switch require to enable creation of private
> memory in the first place, and anyone who flips that switch without
> configuring cgroups is subject to DoS.

I personally have no objection to that, and I'm 99% certain Google doesn't rely
on RLIMIT_MEMLOCK.

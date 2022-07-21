Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E7A57CE7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 17:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiGUPFT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 11:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGUPFR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:05:17 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4006342
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 08:05:14 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 72so1967705pge.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 08:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+qHP7skd3Cv7XJJygZVSwGskr21EGyWaFJgDdfd1xqA=;
        b=oQSFR9+MjkkY1ur4gDW1MTlCrXf3uwlJLfESqNwsf2awYRDW0+8aavy8VzAuy9DB0G
         JDCIQp1vt5BvWbaqkABHrCn9h2qVHzO/SxEDKgSBlbay4FQdznJ6OWnc4Hc0C/769sBL
         aq7cj8hP0AUHXUTvnue16TNcqCwcMJHJ1Gz4cj7NXbvObCQklTY4pdJ1ZwEWRYUotwWt
         BRQpaLf82OEJ9tYyxOPCUOLwadWEY7ln+vmIVrCj1MGptoVCZg53AGjaczk8CTfjFYcd
         x+IeQO2qzB9zjTUGUovD73lL5DdL7DCL3eyEpBmg3MXYdMfYAAsyQOy2T2yk808kuO5O
         Wxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+qHP7skd3Cv7XJJygZVSwGskr21EGyWaFJgDdfd1xqA=;
        b=ey1v9RyKyNqj8L3kxLxnKlI+a0hJ5LaGS0KLELDC1GSuZ4vTkbee0ZREzliv/Pv3ro
         S/SLp/6U8fwnk+jox9jXWng9a27gmeTW9/S+4ezJdAtpqlMWUtGhbnc1jh/dLAXuflVA
         lLKi1cDhHael6R7KUFF2Zec0P8/X2g1mW6BRItfsyaqseM2gFjoL9nWJGUWcNhqTWT5r
         2sH/NHI9suX8N8Ka7yny5YVzhmkB9ZWySMkm5ruH2/1HsuzbUGwWXbu1P1DYFn9fdSTQ
         rdnmzub2FtNGFI2TwxGOu0qBvjc5jZJfdFb/5iIplHaH3/32Pyjp5O9BPCg4dVDFyZLN
         f5Rg==
X-Gm-Message-State: AJIora/33VHqY4yrZVwkLvWRYbvK9qSQ89h65b9wNWZPoRlNJ0tbRupN
        6cpRcosryGoOb+oUPxDNf9JkJ27kpYj+8A==
X-Google-Smtp-Source: AGRyM1uCSCT3ljh7PToWudc0PHcaebaKp/GEubhDiVG89ItWbH0HuD55vNtJx6Xaam1ITOer8uSeSA==
X-Received: by 2002:a63:b56:0:b0:41a:495a:2a26 with SMTP id a22-20020a630b56000000b0041a495a2a26mr13293961pgl.411.1658415913932;
        Thu, 21 Jul 2022 08:05:13 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id a17-20020aa78e91000000b005254e44b748sm1872610pfr.84.2022.07.21.08.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 08:05:13 -0700 (PDT)
Date:   Thu, 21 Jul 2022 15:05:09 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Hildenbrand <david@redhat.com>
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
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 01/14] mm: Add F_SEAL_AUTO_ALLOCATE seal to memfd
Message-ID: <YtlrJR3uP6940tjd@google.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-2-chao.p.peng@linux.intel.com>
 <f39c4f63-a511-4beb-b3a4-66589ddb5475@redhat.com>
 <39067d09-b32b-23a6-ae0e-00ac2fe0466c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39067d09-b32b-23a6-ae0e-00ac2fe0466c@redhat.com>
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

On Thu, Jul 21, 2022, David Hildenbrand wrote:
> On 21.07.22 11:44, David Hildenbrand wrote:
> > On 06.07.22 10:20, Chao Peng wrote:
> >> Normally, a write to unallocated space of a file or the hole of a sparse
> >> file automatically causes space allocation, for memfd, this equals to
> >> memory allocation. This new seal prevents such automatically allocating,
> >> either this is from a direct write() or a write on the previously
> >> mmap-ed area. The seal does not prevent fallocate() so an explicit
> >> fallocate() can still cause allocating and can be used to reserve
> >> memory.
> >>
> >> This is used to prevent unintentional allocation from userspace on a
> >> stray or careless write and any intentional allocation should use an
> >> explicit fallocate(). One of the main usecases is to avoid memory double
> >> allocation for confidential computing usage where we use two memfds to
> >> back guest memory and at a single point only one memfd is alive and we
> >> want to prevent memory allocation for the other memfd which may have
> >> been mmap-ed previously. More discussion can be found at:
> >>
> >>   https://lkml.org/lkml/2022/6/14/1255
> >>
> >> Suggested-by: Sean Christopherson <seanjc@google.com>
> >> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> >> ---
> >>  include/uapi/linux/fcntl.h |  1 +
> >>  mm/memfd.c                 |  3 ++-
> >>  mm/shmem.c                 | 16 ++++++++++++++--
> >>  3 files changed, 17 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> >> index 2f86b2ad6d7e..98bdabc8e309 100644
> >> --- a/include/uapi/linux/fcntl.h
> >> +++ b/include/uapi/linux/fcntl.h
> >> @@ -43,6 +43,7 @@
> >>  #define F_SEAL_GROW	0x0004	/* prevent file from growing */
> >>  #define F_SEAL_WRITE	0x0008	/* prevent writes */
> >>  #define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
> >> +#define F_SEAL_AUTO_ALLOCATE	0x0020  /* prevent allocation for writes */
> > 
> > Why only "on writes" and not "on reads". IIRC, shmem doesn't support the
> > shared zeropage, so you'll simply allocate a new page via read() or on
> > read faults.
> 
> Correction: on read() we don't allocate a fresh page. But on read faults
> we would. So this comment here needs clarification.

Not just the comment, the code too.  The intent of F_SEAL_AUTO_ALLOCATE is very
much to block _all_ implicit allocations (or maybe just fault-based allocations
if "implicit" is too broad of a description).

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21392710021
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 23:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbjEXVj4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 17:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbjEXVjy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 17:39:54 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2609F123
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 14:39:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561d565cb0aso16510637b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 14:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684964392; x=1687556392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u+lTI9LGfJCIeH9eUZOS37jnh9XivOrfiNHxwExkkPU=;
        b=1OM2n6A6XJR4jj8vE2JD/qVka6KhOa37sATKkJGdtzfw5ejGSX46cgRyM3KxfTglOD
         0RNiltYW0aqpSJK1ylM7pyVuNywmw3i8GLhqy6D8KbpUnlsiq///5XlVQOyARTMakL95
         sruDKzgA0kJWIRgwdNf60tHMZ2lnfSldT/PHutYtTTub50wqJp62S52UJsWvKQ7jpGPj
         JBND0HA8P6pXYHkEPXwT4zPgdYSplBBE7ttHpAHPL1RPyn6nSmxfEos2auwOVntQ9sEN
         x6n9gU3Z0Y/wI8zE55ONSW8DBiSo/6ReRvhBCmqYQEuA2BiS/6yDjqxNIpbAGpQ1wAiT
         KtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684964392; x=1687556392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+lTI9LGfJCIeH9eUZOS37jnh9XivOrfiNHxwExkkPU=;
        b=WoNIYwl6nX+qLQ59tTKi4/M6qfaZobJbPZWkAq2yRQP7fMZt3P9azZyqKvgERq4Ml2
         ZD9EvkwK+1VGxRLpbpTtO8vDjhvwQOI+e1zaO4WM1xihXiAWzuqJIw79K+5DAXvYZ2LW
         2yizcBLO7M3PhLCfuPzDuF6udveOthAD8jXaOrytAH8YYO5ZOqgytGEILRsZqnS96pCH
         CkpKpNhmh8MwFc73ygPvu5GFdq4WrheN0mGTcvQLu6xP83LjGswPqjReJ3i7r4YiWBYw
         glCQWq0ZHfvvbbcmXldWjfUJ0FfzFLTsZX+EDY6ol2qA08FCWrBpAxBP33n/0753LDAQ
         UrKw==
X-Gm-Message-State: AC+VfDzisM2uVYOJFwQWmMR78UGOi+Es16GLxeNON1kKdE6sOC1KxhpW
        yBk9YZj98yGA76CALJP6f0IN7t6XTWY=
X-Google-Smtp-Source: ACHHUZ4gGkG32f/WDPDY+8DnC86QiU6Z2uyq9N2VVLscH3WfhLiakxSPFeyk8pWCaiTnq1AgYyU2vpbztC4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ae14:0:b0:561:8bfb:feb1 with SMTP id
 m20-20020a81ae14000000b005618bfbfeb1mr12005442ywh.10.1684964392193; Wed, 24
 May 2023 14:39:52 -0700 (PDT)
Date:   Wed, 24 May 2023 14:39:50 -0700
In-Reply-To: <20230524203336.GC3447678@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-9-chao.p.peng@linux.intel.com> <ZGxo9ylqYI8JXjGn@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <ZGzLf4zgxpBjghaF@google.com> <ZG2qv9sWl2RUnGqd@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <ZG5wg3VbG4rCYrfk@google.com> <20230524203336.GC3447678@hirez.programming.kicks-ass.net>
Message-ID: <ZG6EJoXbduApRsgV@google.com>
Subject: Re: [PATCH v7 08/14] KVM: Rename mmu_notifier_*
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kautuk Consul <kconsul@linux.vnet.ibm.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023, Peter Zijlstra wrote:
> On Wed, May 24, 2023 at 01:16:03PM -0700, Sean Christopherson wrote:
> > Of course, the only accesses outside of mmu_lock are reads, so on x86 that
> > "atomic" access is just a READ_ONCE() load, but that's not the case for all
> > architectures.
> 
> This is true on *all* archs. atomic_set() and atomic_read() are no more
> and no less than WRITE_ONCE() / READ_ONCE().

Ah, I take it s390's handcoded assembly routines are just a paranoid equivalents
and not truly special?  "l" and "st" do sound quite generic...

  commit 7657e41a0bd16c9d8b3cefe8fd5d6ac3c25ae4bf
  Author: Heiko Carstens <hca@linux.ibm.com>
  Date:   Thu Feb 17 13:13:58 2011 +0100

    [S390] atomic: use inline asm
    
    Use inline assemblies for atomic_read/set(). This way there shouldn't
    be any questions or subtle volatile semantics left.

static inline int __atomic_read(const atomic_t *v)
{
	int c;

	asm volatile(
		"	l	%0,%1\n"
		: "=d" (c) : "R" (v->counter));
	return c;
}

static inline void __atomic_set(atomic_t *v, int i)
{
	asm volatile(
		"	st	%1,%0\n"
		: "=R" (v->counter) : "d" (i));
}

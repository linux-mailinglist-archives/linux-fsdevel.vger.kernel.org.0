Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842F770FF51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 22:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbjEXUfB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 16:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbjEXUev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 16:34:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9628E1AC;
        Wed, 24 May 2023 13:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xfybRCqfmly451via0zB+H/Q+AApSu2iaDmN5fGZ/x4=; b=IgXiGZt/AjIkZyk47M6JmzSETo
        5JvYqmTY0S/6CNcf6rOgIUGkx8fCELILrDrVXemYkb5BPYKAn0HI2Y6XB5K+3xzooX2AKsZSw2rzz
        mh9MKJ/BLQiIqzzeKOeINobvgbeJqtrrw702L1m+480O4PgbeQxZTVHsPTxFOgTQXwjhkEFw9ES3j
        jYrlmoMd2O6KMc0tFDq7r+mdPcC6sbWD0mdmLQKvSrN/CRbmjwjlImLpNC1DyVuMY2O6L3UPugOJF
        IUkQyLOL6dwpJlAiac2Dvj+LDhnldubALNgI54EHmr7EPEHVm08LfHTcHZ65apsu3c2zLqTuflfCR
        76pcnqHw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q1vAx-00BWOr-Uz; Wed, 24 May 2023 20:33:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AD8D830013F;
        Wed, 24 May 2023 22:33:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D6F5F20A78733; Wed, 24 May 2023 22:33:36 +0200 (CEST)
Date:   Wed, 24 May 2023 22:33:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>
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
Subject: Re: [PATCH v7 08/14] KVM: Rename mmu_notifier_*
Message-ID: <20230524203336.GC3447678@hirez.programming.kicks-ass.net>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-9-chao.p.peng@linux.intel.com>
 <ZGxo9ylqYI8JXjGn@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <ZGzLf4zgxpBjghaF@google.com>
 <ZG2qv9sWl2RUnGqd@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <ZG5wg3VbG4rCYrfk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG5wg3VbG4rCYrfk@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 01:16:03PM -0700, Sean Christopherson wrote:

> Atomics aren't memory barriers on all architectures, e.g. see the various
> definitions of smp_mb__after_atomic().
> 
> Even if atomic operations did provide barriers, using an atomic would be overkill
> and a net negative.  On strongly ordered architectures like x86, memory barriers are
> just compiler barriers, whereas atomics may be more expensive. 

Not quite, smp_{r,w}mb() and smp_mb__{before,after}_atomic() are
compiler barriers on the TSO archs, but smp_mb() very much isn't. TSO
still allows stores to be delayed vs later loads (iow it doesn't pretend
to hide the store buffer).

> Of course, the only
> accesses outside of mmu_lock are reads, so on x86 that "atomic" access is just a
> READ_ONCE() load, but that's not the case for all architectures.

This is true on *all* archs. atomic_set() and atomic_read() are no more
and no less than WRITE_ONCE() / READ_ONCE().

> Anyways, the point is that atomics and memory barriers are different things that
> serve different purposes.

This is true; esp. on the weakly ordered architectures where atomics do
not naturally imply any ordering.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5215B7107F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 10:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240101AbjEYIzO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 04:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjEYIzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 04:55:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0505798;
        Thu, 25 May 2023 01:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4b2eicAEuLtRWdZtNZ5cHEIkzBFWO5fbGUCIkmElStA=; b=awjODk2fwPYTgmCI5gJmw6l9OT
        webj8qbFiwu2EL0MRewtFXEC24of9u7MvAW5satunvNuK0PfsEXnHCvwZdPeVlmrsw6YlUMgskELw
        WNFvHhYGq2vX1/nA3+RnT7Ewviy63PEB/VQJlSpqkZNlmRE6hBD+qKC25FfdB8cV/yZPZ6qBNLpBo
        en8dqOWQjXH3kLxP48mjho4LySuKy+LkE7/OcY26lmBWJY9wsywIRwmVJ4noS0NZY3hsyN8wzzxgY
        eo9zRmZLXoe6kD+DKJ5sOgSpyhphRKbS6OSMZfY7OxgblBnBnlx+363WZE2cNfcb8tk/Pqg7uMSA3
        iH5ae6cg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q26jT-00C1Be-HE; Thu, 25 May 2023 08:54:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AA4AA3002F0;
        Thu, 25 May 2023 10:54:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3566720A78733; Thu, 25 May 2023 10:54:00 +0200 (CEST)
Date:   Thu, 25 May 2023 10:54:00 +0200
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
Message-ID: <20230525085400.GP4253@hirez.programming.kicks-ass.net>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-9-chao.p.peng@linux.intel.com>
 <ZGxo9ylqYI8JXjGn@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <ZGzLf4zgxpBjghaF@google.com>
 <ZG2qv9sWl2RUnGqd@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <ZG5wg3VbG4rCYrfk@google.com>
 <20230524203336.GC3447678@hirez.programming.kicks-ass.net>
 <ZG6EJoXbduApRsgV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG6EJoXbduApRsgV@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 02:39:50PM -0700, Sean Christopherson wrote:
> On Wed, May 24, 2023, Peter Zijlstra wrote:
> > On Wed, May 24, 2023 at 01:16:03PM -0700, Sean Christopherson wrote:
> > > Of course, the only accesses outside of mmu_lock are reads, so on x86 that
> > > "atomic" access is just a READ_ONCE() load, but that's not the case for all
> > > architectures.
> > 
> > This is true on *all* archs. atomic_set() and atomic_read() are no more
> > and no less than WRITE_ONCE() / READ_ONCE().
> 
> Ah, I take it s390's handcoded assembly routines are just a paranoid equivalents
> and not truly special?  "l" and "st" do sound quite generic...

Yep, compiler *should* generate the same with READ_ONCE/WRITE_ONCE.

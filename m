Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBF9588063
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 18:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbiHBQj1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 12:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239086AbiHBQjK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 12:39:10 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2642627
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Aug 2022 09:39:00 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o3so13968758ple.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Aug 2022 09:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=YLolmPC/4W6Ekt5KXSGhTlaQ+SvTrN9uL1784FHTktA=;
        b=DEczoNtVTMwIsaw8yg11wYkQuI9LeTuQwFeOQ0oJ03m1tMW/YgHdOnTv17v8+A6WTV
         U7hpMystc0MLLmDXYDMaROWkoGrECN3+IY7Ia+Z09cQyp/+2thONhPGLIYnqECJRrXhr
         dDHRlXhlBA0o0w24sHNoK99DkncCME85F/XcNTjXnZbY1/vtUg34rxTUMG/OWYQ4HMcI
         iIFe/Qw/lNcBgMnxPgPuAhy90CFyCy84wOdE8NkRPB91ulC5zTuJcdVgjk8H0EgOjoUm
         FnlRd5MiMQxVvv/M1kuZRL91q7QvdBIT05QOREIPMw2HWyehKvsTbH9WC464J4D8ov37
         YsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=YLolmPC/4W6Ekt5KXSGhTlaQ+SvTrN9uL1784FHTktA=;
        b=p3zjwG+/IaMRRX44lqiUfbkO3yDr1T83Png4L8YFzhele6OMCu5mPCRpP59pcdFY+u
         cRK79K28ROpj4fiMLqKW8iFu5O7fLNF8H/IPrgYfUHAZPsBjFJI8gc4/ICwS8WoKlc61
         Y1iZd1tVWyRWH3phaMZ5o6Xr9AmjHOykYGhtzrt2iMij7hDY+nXLRGHZjU1dimK9NFNw
         9tcGu8+UsWGULICWRFgcv8IojliCQkue3eGDEksFeopCTCEvvaIZjBTBZV8PPKJyWUGL
         LKJg1h7CP2FcGH5pxC4hwy3EbIttwSdPbXwpJFIwQJegNIavqyDuza+2rXl9zCjemD8O
         AlNg==
X-Gm-Message-State: ACgBeo3Os1hkKJVZmdrwEF90DTiWy9wlbjRixpnN5Op7fwbeDu4rart0
        EANZuxY0PEbMkg6eKHL7icHtWA==
X-Google-Smtp-Source: AA6agR5iAjFP2q7X1PbZvwrW6P6B4ILkh92ieVBGwE4LPz6Qma2k0ZREMBEhxOJKazpAhnjrSGkWTg==
X-Received: by 2002:a17:902:dac6:b0:16d:bdf5:7084 with SMTP id q6-20020a170902dac600b0016dbdf57084mr22165713plx.55.1659458340177;
        Tue, 02 Aug 2022 09:39:00 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id l15-20020a17090aec0f00b001f216407204sm11136513pjy.36.2022.08.02.09.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 09:38:59 -0700 (PDT)
Date:   Tue, 2 Aug 2022 16:38:55 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Wei Wang <wei.w.wang@linux.intel.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>, kvm@vger.kernel.org,
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
Message-ID: <YulTH7bL4MwT5v5K@google.com>
References: <36e671d2-6b95-8e4f-c2ac-fee4b2670c6e@amd.com>
 <20220720150706.GB124133@chaop.bj.intel.com>
 <d0fd229d-afa6-c66d-3e55-09ac5877453e@amd.com>
 <YtgrkXqP/GIi9ujZ@google.com>
 <45ae9f57-d595-f202-abb5-26a03a2ca131@linux.intel.com>
 <20220721092906.GA153288@chaop.bj.intel.com>
 <YtmT2irvgInX1kPp@google.com>
 <20220725130417.GA304216@chaop.bj.intel.com>
 <YuQ64RgWqdoAAGdY@google.com>
 <Yuh0ikhoh+tCK6VW@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yuh0ikhoh+tCK6VW@google.com>
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

On Tue, Aug 02, 2022, Sean Christopherson wrote:
> I think we should avoid UNMAPPABLE even on the KVM side of things for the core
> memslots functionality and instead be very literal, e.g.
> 
> 	KVM_HAS_FD_BASED_MEMSLOTS
> 	KVM_MEM_FD_VALID
> 
> We'll still need KVM_HAS_USER_UNMAPPABLE_MEMORY, but it won't be tied directly to
> the memslot.  Decoupling the two thingis will require a bit of extra work, but the
> code impact should be quite small, e.g. explicitly query and propagate
> MEMFILE_F_USER_INACCESSIBLE to kvm_memory_slot to track if a memslot can be private.
> And unless I'm missing something, it won't require an additional memslot flag.
> The biggest oddity (if we don't also add KVM_MEM_PRIVATE) is that KVM would
> effectively ignore the hva for fd-based memslots for VM types that don't support
> private memory, i.e. userspace can't opt out of using the fd-based backing, but that
> doesn't seem like a deal breaker.

Hrm, but basing private memory on top of a generic FD_VALID would effectively require
shared memory to use hva-based memslots for confidential VMs.  That'd yield a very
weird API, e.g. non-confidential VMs could be backed entirely by fd-based memslots,
but confidential VMs would be forced to use hva-based memslots.

Ignore this idea for now.  If there's an actual use case for generic fd-based memory
then we'll want a separate flag, fd, and offset, i.e. that support could be added
independent of KVM_MEM_PRIVATE.

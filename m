Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C3F6367F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 19:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239383AbiKWSC0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 13:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239337AbiKWSCR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:02:17 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8570787540
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 10:02:16 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 4so17364823pli.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 10:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JBAHsDOjy5OO4Ngubx5UMoEA0/sDtPMwp6OMmJM5Kq8=;
        b=j0pjNho9RlZm19Tehr3FVjo7Db8885B4Y7xkdDdUAoWctaEVu0QXpeH4dAhlT+H/66
         rXShciLYPKXX/As5ej1NnFhKVYsgqZOAIM86zq/8g4IoL0rpFkAis4hyMIxH32ObpzTD
         q12ac2q20Bq/175aKSlrDsis/kh1ZErXHlsfXaFF0vLM0VKl7Q/KOGrAwfHxRNQmXI/O
         driosPsB+7yejIXs59Nh7GScXFt/2qGI69bVfBSTlUwjFNjy1R5omvxslKZApaKKy6Vb
         bCz1WtnxHp4F2zgsQTYD/KhQpB2n22TuYLklkc67sIj+R3YF0oMYZg8xQcjMBvZBgqVR
         chmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBAHsDOjy5OO4Ngubx5UMoEA0/sDtPMwp6OMmJM5Kq8=;
        b=DSxEUn1Rc9EhmIUNQ7UfeCGUql8O1AjXM4T4t2nz1xpJCll6LOtAGpwqlUGg5QZqR7
         fhOdL4/Nwcemwdwg1u/gHO9qmrGneFdSvhgY09a4PWvCfX+DJEdPgbF/6RggbPC4FBlk
         cVly9kxqkC0gKlW4TjGpToaTPBpb9x472nNakCdhR/0yOxxU8x9SxAWJsns2olg22UY1
         WUzFYNkQZHJT6Y73YMWqIVztJfTMmNUQvuCPrHISPJ4sVO8KXja0qmAU1Hq23teYbBTr
         VzeruvE1NnI+uV7/6IqreFlq/cXy9fqNaOspivdlaBxqemZzUYbABTH+aA8DNYerFBA/
         IBFw==
X-Gm-Message-State: ANoB5pnKagWYSvhdH4ccwQhBdAlkG5dpzpoNA+S8+DDOTc4604qfTdZT
        UUPC9pjaj5du1IV6YmaAJQMLKQ==
X-Google-Smtp-Source: AA0mqf4h/eDzvGfQmUc/ZjBSomm7vgT2Crg1NblOZpQoP8uNf60lMXpAkbUo70CvheBSDG5J9lpZAg==
X-Received: by 2002:a17:902:da89:b0:189:8b2:b069 with SMTP id j9-20020a170902da8900b0018908b2b069mr10756414plx.13.1669226535720;
        Wed, 23 Nov 2022 10:02:15 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id w26-20020a63475a000000b00462612c2699sm11075143pgk.86.2022.11.23.10.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:02:15 -0800 (PST)
Date:   Wed, 23 Nov 2022 18:02:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v9 3/8] KVM: Add KVM_EXIT_MEMORY_FAULT exit
Message-ID: <Y35gI0L8GMt9+OkK@google.com>
References: <20221025151344.3784230-4-chao.p.peng@linux.intel.com>
 <87cz9o9mr8.fsf@linaro.org>
 <20221116031441.GA364614@chaop.bj.intel.com>
 <87mt8q90rw.fsf@linaro.org>
 <20221117134520.GD422408@chaop.bj.intel.com>
 <87a64p8vof.fsf@linaro.org>
 <20221118013201.GA456562@chaop.bj.intel.com>
 <87o7t475o7.fsf@linaro.org>
 <Y3er0M5Rpf1X97W/@google.com>
 <20221122095022.GA617784@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122095022.GA617784@chaop.bj.intel.com>
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

On Tue, Nov 22, 2022, Chao Peng wrote:
> On Fri, Nov 18, 2022 at 03:59:12PM +0000, Sean Christopherson wrote:
> > On Fri, Nov 18, 2022, Alex Benn?e wrote:
> > > > We don't actually need a new bit, the opposite side of private is
> > > > shared, i.e. flags with KVM_MEMORY_EXIT_FLAG_PRIVATE cleared expresses
> > > > 'shared'.
> > > 
> > > If that is always true and we never expect a 3rd type of memory that is
> > > fine. But given we are leaving room for expansion having an explicit bit
> > > allows for that as well as making cases of forgetting to set the flags
> > > more obvious.
> > 
> > Hrm, I'm on the fence.
> > 
> > A dedicated flag isn't strictly needed, e.g. even if we end up with 3+ types in
> > this category, the baseline could always be "private".
> 
> The baseline for the current code is actually "shared".

Ah, right, the baseline needs to be "shared" so that legacy code doesn't end up
with impossible states.

> > I do like being explicit, and adding a PRIVATE flag costs KVM practically nothing
> > to implement and maintain, but evetually we'll up with flags that are paired with
> > an implicit state, e.g. see the many #PF error codes in x86.  In other words,
> > inevitably KVM will need to define the default/base state of the access, at which
> > point the base state for SHARED vs. PRIVATE is "undefined".  
> 
> Current memory conversion for confidential usage is bi-directional so we
> already need both private and shared states and if we use one bit for
> both "shared" and "private" then we will have to define the default
> state, e.g, currently the default state is "shared" when we define
> 
> 	KVM_MEMORY_EXIT_FLAG_PRIVATE	(1 << 0)

...

> > So I would say if we add an explicit READ flag, then we might as well add an explicit
> > PRIVATE flag too.  But if we omit PRIVATE, then we should omit READ too.
> 
> Since we assume the default state is shared, so we actually only need a
> PRIVATE flag, e.g. there is no SHARED flag and will ignore the RWX for now.

Yeah, I'm leading towards "shared" being the implied default state.  Ditto for
"read" if/when we need to communicate write/execute information  E.g. for VMs
that don't support guest private memory, the "shared" flag is in some ways
nonsensical.  Worst case scenario, e.g. if we end up with variations of "shared",
we'll need something like KVM_MEMORY_EXIT_FLAG_SHARED_RESTRICTIVE or whatever,
but the basic "shared" default will still work.

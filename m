Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9EC7ADDE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 19:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjIYRhz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 13:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjIYRhy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:37:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4D6112
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 10:37:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81e9981ff4so9968835276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 10:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695663464; x=1696268264; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4OSNJSuzGEyn2eFVxut8UHIn8mk8UoHB1vJTBDeWUjg=;
        b=vHOkqRox53qWWq1w+Y3R/aBAcsqP2f0/LNwJwmzxBUBvbELxtAJ6WQLQ4COw481jWg
         5XpcRTOL103TSrAzZNlnTMG1Cf+eOC0WZxF+FCAwmbRRdVNuLepHIOBdWyDB08n5YCSe
         jlJtH2FuqegQqHwVchEEPTST2X8ZE5G4nYrRSKwHxa5x5HM0vMXNJ87VZ0aQtzsS9kdv
         jAQqIus3+oLXkGka3TY1JEsJ79dwBXNI8OvA2hAUtIPbElxcF8AXME0DcJe+DbcurUGr
         L+0oTtRH3YdccuVR3DF+3bqDuzvatC7Ug4oeHYoRIb1aOoKvXGwV8mY7IhxF6UXG9hwd
         1UMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695663464; x=1696268264;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4OSNJSuzGEyn2eFVxut8UHIn8mk8UoHB1vJTBDeWUjg=;
        b=FFUd2P6nlapyPi91C3PQ2YVc/elGFRxPaapgp5bxW5pdVlgq/NMyIYkcV73wmbvq0l
         GWv/2m5S5xw0vuXWIBwHinJ0s5g8c8EMHwc02SlfMCz94INv7Unn/Bs/tNzo9TTmgGQ8
         0EDbPxnCtvllZvJ6r4vkUwQ1PX6K5UyhAjmqViF+WgXspROwDg7pdNnKO58CbEAZrz+B
         Q3K8Qf3BmWYpdhV3qfVVNJ09y8igY6+4JUn41sb4EQVbJDE35ldp035BLfqLkS0+xSMJ
         rE0wFXFnt8mFp/7yp1yjemgzYsavYJ7aebLRjKm0S4NgsVncsV9hz7m4QnNcgKpL4YIx
         hJPQ==
X-Gm-Message-State: AOJu0YyZrsDlnKfCwPm75Sx+vJ4c95wHePG4CX/1ubGrfa4S0MQw/iGn
        prC+qqlc044LRh75vknFPaUIxyu7KpM=
X-Google-Smtp-Source: AGHT+IFbdNqdQBINXaKsxLFNsbPAlNsb64v79jTXlms6OpZDsyyWIMsDvfLKOISLOkUltg3c0KbHgHQxQwM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:abac:0:b0:d81:fc08:29ea with SMTP id
 v41-20020a25abac000000b00d81fc0829eamr67094ybi.2.1695663463860; Mon, 25 Sep
 2023 10:37:43 -0700 (PDT)
Date:   Mon, 25 Sep 2023 10:37:42 -0700
In-Reply-To: <ZQuahXpq2fy8rMDV@yzhao56-desk.sh.intel.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com> <20230914015531.1419405-12-seanjc@google.com>
 <ZQP6ZqXH81V24Lj/@yzhao56-desk.sh.intel.com> <ZQtdZmJ3SekURjiQ@google.com> <ZQuahXpq2fy8rMDV@yzhao56-desk.sh.intel.com>
Message-ID: <ZRHFZmaa/6HQnZD1@google.com>
Subject: Re: [RFC PATCH v12 11/33] KVM: Introduce per-page memory attributes
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023, Yan Zhao wrote:
> On Wed, Sep 20, 2023 at 02:00:22PM -0700, Sean Christopherson wrote:
> > On Fri, Sep 15, 2023, Yan Zhao wrote:
> > > On Wed, Sep 13, 2023 at 06:55:09PM -0700, Sean Christopherson wrote:
> > > > +/* Set @attributes for the gfn range [@start, @end). */
> > > > +static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> > > > +				     unsigned long attributes)
> > > > +{
> > > > +	struct kvm_mmu_notifier_range pre_set_range = {
> > > > +		.start = start,
> > > > +		.end = end,
> > > > +		.handler = kvm_arch_pre_set_memory_attributes,
> > > > +		.on_lock = kvm_mmu_invalidate_begin,
> > > > +		.flush_on_ret = true,
> > > > +		.may_block = true,
> > > > +	};
> > > > +	struct kvm_mmu_notifier_range post_set_range = {
> > > > +		.start = start,
> > > > +		.end = end,
> > > > +		.arg.attributes = attributes,
> > > > +		.handler = kvm_arch_post_set_memory_attributes,
> > > > +		.on_lock = kvm_mmu_invalidate_end,
> > > > +		.may_block = true,
> > > > +	};
> > > > +	unsigned long i;
> > > > +	void *entry;
> > > > +	int r = 0;
> > > > +
> > > > +	entry = attributes ? xa_mk_value(attributes) : NULL;
> > > Also here, do we need to get existing attributes of a GFN first ?
> > 
> > No?  @entry is the new value that will be set for all entries.  This line doesn't
> > touch the xarray in any way.  Maybe I'm just not understanding your question.
> Hmm, I thought this interface was to allow users to add/remove an attribute to a GFN
> rather than overwrite all attributes of a GFN. Now I think I misunderstood the intention.
> 
> But I wonder if there is a way for users to just add one attribute, as I don't find
> ioctl like KVM_GET_MEMORY_ATTRIBUTES for users to get current attributes and then to
> add/remove one based on that. e.g. maybe in future, KVM wants to add one attribute in
> kernel without being told by userspace ?

The plan is that memory attributes will be 100% userspace driven, i.e. that KVM
will never add its own attributes.  That's why there is (currently) no
KVM_GET_MEMORY_ATTRIBUTES, the intended usage model is that userspace is fully
responsible for managing attributes, and so should never need to query information
that it already knows.  If there's a compelling case for getting attributes then
we could certainly add such an ioctl(), but I hope we never need to add a GET
because that likely means we've made mistakes along the way.

Giving userspace full control of attributes allows for a simpler uAPI, e.g. if
userspace doesn't have full control, then setting or clearing bits requires a RMW
operation, which means creating a more complex ioctl().  That's why its a straight
SET operation and not an OR type operation.

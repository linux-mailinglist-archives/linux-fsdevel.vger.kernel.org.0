Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF3A77C2DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 23:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbjHNVzU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 17:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjHNVzI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:55:08 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D9F1BE1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 14:54:38 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55c79a55650so8933591a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 14:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692050074; x=1692654874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WLV8cwl+q0+MgeCaKnjEbSXBm+ijn/cuT9eg2QvMQy8=;
        b=WyQ6Tn/5h37xMsEIDmbWcY+nQiTqqFoftlXVBTiztMb2A7vinkou0FyJxT5Tj+pa31
         3y4mktmY47itqZcGsKCOeUubQi9MQwPyYS/ntrx9oV/jIdUAoZkwRuGY0yw403B+hUV5
         PyUzYrySs29/O30p+yDsELGRzby+1aqFcxoBBJ6omQFPygNitIVTJAp2Hnd4R0/QcY2H
         EgizfgVBfhm/BlB4owWFjSnqlPuhKRjVS+MvDjPpwOsN8USa7haRJjhrCn+/9m5M/b9b
         HnVauoeuLnwYhNy2SBnjlv/xkJdMMlVKqHESswng1uUarqPNC4oB5B1VogZQC9cpA3Kv
         gLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692050074; x=1692654874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLV8cwl+q0+MgeCaKnjEbSXBm+ijn/cuT9eg2QvMQy8=;
        b=g1J0K/XZ3xKWl81BGvhAaI0kFv1NdTJ+yk9ITCjRO99c3bvpBFnSqG/B4fbhXZbk4p
         DctYMCqtK6oW/DLCOahnB8BUVCItFmhmsCh9bot43j4CIpHn56UF5HdUmYv0KFD94ATZ
         +9lS5KzwH8a3RsItfL0WQd8OoNNr7AlaCHosZ9tO3v1AGPC40/r/HwC4dHVqrBGlg+YZ
         CfnInNOc7J/nKIXo2v2WCENm0k8u+ghORDm4XvU/nM5XAqtZ5421WjFdKlOrNk8AL3ga
         ajXfU1x9P+GlrbLXNeYpcjTPSsstcnzM10k1fFe5OGp4mc7F2TT5KcV7Lck57wsdSwRF
         G1aA==
X-Gm-Message-State: AOJu0YxuLcg/UOt1uPYcsWH0fupcuBfsUSemM6Db3ytXedDRMRow+WrR
        SMd81tuS3W8pnqWviWr5mJQwsgltcyc=
X-Google-Smtp-Source: AGHT+IGPzyG2ye2a1feyqcG86dyCHC82qzx5i2/p6ALHRmr0rfFoFMM8MlFz9jxGz9wjwtqC3ppaRbddXVE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:9f12:0:b0:565:3355:87b0 with SMTP id
 g18-20020a639f12000000b00565335587b0mr2044577pge.5.1692050074189; Mon, 14 Aug
 2023 14:54:34 -0700 (PDT)
Date:   Mon, 14 Aug 2023 14:54:32 -0700
In-Reply-To: <02239d95-0253-a223-28c2-016cca3ab4d2@linux.intel.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com> <20230718234512.1690985-9-seanjc@google.com>
 <02239d95-0253-a223-28c2-016cca3ab4d2@linux.intel.com>
Message-ID: <ZNqimGhCD+70q/lG@google.com>
Subject: Re: [RFC PATCH v11 08/29] KVM: Introduce per-page memory attributes
From:   Sean Christopherson <seanjc@google.com>
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
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
        linux-kernel@vger.kernel.org, Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
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

On Mon, Aug 14, 2023, Binbin Wu wrote:
> 
> On 7/19/2023 7:44 AM, Sean Christopherson wrote:
> > +	struct kvm_mmu_notifier_range post_set_range = {
> > +		.start = start,
> > +		.end = end,
> > +		.arg.attributes = attributes,
> > +		.handler = kvm_arch_post_set_memory_attributes,
> > +		.on_lock = (void *)kvm_null_fn,
> > +		.on_unlock = kvm_mmu_invalidate_end,
> > +		.may_block = true,
> > +	};
> > +	unsigned long i;
> > +	void *entry;
> > +	int r;
> > +
> > +	entry = attributes ? xa_mk_value(attributes) : NULL;
> Why attributes of value 0 is considered not a value? Is it because 0 is not
> a valid value when RWX is considered in the future?

0 values don't require an entry in the xarray, i.e. don't need to be stored and
so don't consume memory.  The potential conflict with a RWX=0 entry has already
been noted, but we'll cross that bridge when we get to it, e.g. KVM can easily
support RWX=0 by using an internal "valid" flag.

> Both the changelog and the document added mention that the address and size
> of attrs will be updated to
> "reflect the actual pages of the memory range have been successfully set to
> the attributes", but it doesn't.

Yeah, on the todo list, all of the changelogs are horribly stale.

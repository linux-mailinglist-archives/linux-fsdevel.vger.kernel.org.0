Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75F7783157
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 21:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjHUTtL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 15:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjHUTtK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:49:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D4310E
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 12:49:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d748b6f1077so2501580276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 12:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692647347; x=1693252147;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cJZGEQtf1VL3HQEXak5eCjnl1mSbYK2LpINf2Y7mWuc=;
        b=RZl6OjBiLyxrlN7m8yUzSzxx4s8l6y5XQtCqoL2DKa9CznCEyAG8OEzPqxiGWWfNJU
         DP58nwM09rHRg7Se9vncvUgBs+EoatdB0oIHiYis/CY/mK8bpz5tBW/wF/N/V/N/8FcH
         u/rMp5FZpxMI+ASR8w8FwZSKb5yUKy8z1UKPp14XAoTBk3vwb+9KvbuE4eIugJspN8RX
         snR6LHbvF/g0TCDHMTgr7kn44jTj6A+c9BdOOfnITVAKCoxj2XXqVMiBuH5zs1EhWFJ1
         LASBEZFLbEqzA+6VnHUNymrGUBh6X+GLDf47Xj3E2vNSql4sDsL+0xZSb2rnh4OE9Sf8
         LLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692647347; x=1693252147;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJZGEQtf1VL3HQEXak5eCjnl1mSbYK2LpINf2Y7mWuc=;
        b=Ii36/guIo8TXw3PLFwgnRqPIs1FmGJaz43KcR+1aXoUsza3ia2X1V1YHvUaNoQrJ1t
         c0kKGiyrvgaIberMDZyNgt3sEQfLNeqX9sMdhyO1WipcdkVHT3yg/XP67gifKL5+nsAK
         QaRPT1zssNwb0AanpqilYZ5I+ri6IHxIdp74IBOXISggCCb8DpXtHZARIQHjTBTPCiou
         X/vXyYiWZ+Mj0t8DfvPYlldh4fpI6b8TvbCEqwdbQqg3n7jligo1GpgtQoy6vo5uf6fK
         sjfZfjZPelmLFmj0bWc/lqo1kFe2WxL1SQHQsDbzEQKukYbc/xWJFmD7ti0BW4qDl5yo
         TqCg==
X-Gm-Message-State: AOJu0Yzmt6mJiuxKG0XRP06RxTWBISJuNyDtLi9U0UH1MN2xvt/zEd6O
        /ocRsZA7Sb3G85VClnj1x9Hf6FIdtM5Qi8UN0g==
X-Google-Smtp-Source: AGHT+IHM9bfoMlIQRP0Zhx06e/5qWh61CmNcgWIzhDyB//MY5jBFnNMVKsg1bGSAIpor6rGkYRANDK9cShM4uv9gKA==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:fc0d:0:b0:d07:e80c:412e with SMTP
 id v13-20020a25fc0d000000b00d07e80c412emr56346ybd.12.1692647346791; Mon, 21
 Aug 2023 12:49:06 -0700 (PDT)
Date:   Mon, 21 Aug 2023 19:49:05 +0000
In-Reply-To: <ZN/4RjDsBLf0FB98@google.com> (message from Sean Christopherson
 on Fri, 18 Aug 2023 16:01:26 -0700)
Mime-Version: 1.0
Message-ID: <diqzwmxotbv2.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v11 28/29] KVM: selftests: Add basic selftest for guest_memfd()
From:   Ackerley Tng <ackerleytng@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     pbonzini@redhat.com, maz@kernel.org, oliver.upton@linux.dev,
        chenhuacai@kernel.org, mpe@ellerman.id.au, anup@brainfault.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, willy@infradead.org,
        akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, chao.p.peng@linux.intel.com,
        tabba@google.com, jarkko@kernel.org, yu.c.zhang@linux.intel.com,
        vannapurve@google.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        david@redhat.com, qperret@google.com, michael.roth@amd.com,
        wei.w.wang@intel.com, liam.merwick@oracle.com,
        isaku.yamahata@gmail.com, kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Aug 07, 2023, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>> > Add a selftest to verify the basic functionality of guest_memfd():
>> >
>> > <snip>
>> 
>> Here's one more test:
>
> First off, thank you!  I greatly appreciate all the selftests work you (and
> others!) have been doing.
>
> For v2, can you please post a standalone patch?  My workflow barfs on unrelated,
> inlined patches.  I'm guessing I can get b4 to play nice, but it's easier to just
> yell at people :-)
>

Here's a standalone patch :)
https://lore.kernel.org/lkml/20230821194411.2165757-1-ackerleytng@google.com/

> <snip>

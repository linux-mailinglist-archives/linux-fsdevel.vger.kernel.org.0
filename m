Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50ED7932BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 01:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241887AbjIEX4j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 19:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjIEX4h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 19:56:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CBE1AB
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Sep 2023 16:56:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7c676651c7so713689276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Sep 2023 16:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693958193; x=1694562993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BTMdUX0G2lv2+kU2WiYySTJObpffzgV002stI1a1W7I=;
        b=e7n6Yjksn2CMZRtFHL5RDakHGb5NbF8DYWqlKCV2VtvDz+bekmAxT60g6N1QEt4Q9x
         TnsqFvLITcWcza8/3XwZpqAt0gi0gYzd1nGQYtSJxMLnJNH2oHGZIMTvMrQVoz/ZFZik
         tbKvfANIdod5uVbLAZYsDMDpiT3PiNLOr8kAox4fLx9MwiOZYQKmhuLC6uF8FytOaf5d
         qY3XUntd/mCB+S4TE8YGHPYj5zzee1tN1PA42iKcQUw5WQLVQW/JKAEVFoQlof+IXjgO
         Fcy86VDmQgAqbHsdDgcGCn8ZxzB3Jb49XYlt7LU9Mv15oAV8iTZFBLCCmUqI4wpgNEW6
         QFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693958193; x=1694562993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BTMdUX0G2lv2+kU2WiYySTJObpffzgV002stI1a1W7I=;
        b=arPqTjH+m3hRuGIMFGnyGOvfZs1yS6vVPbiUpoN5mhbP3+rIUTXhhJm1fOjoyqhBN6
         C5cYpmJLjaFfSmdyMSbehW/3FHeuK+y33tCeG70NIt6TXj6vRX9Wp+uZgmhhbBin7MM3
         Ip9m8bMY8re6TM4zXZtHZ0+pDwCQm53blqPEfZVdXCQV54cRoiwF5TRqxbrNCA3th3Xx
         +z4r0BukkhyKngpQyN2VrVgrANO2z0/MqaCtnXX2QYVleYyww/JaU21xq8v26TdSOTpu
         oRqIaDov86LGKoOwRmARJEtg5j3hKOE2sFaMDqxfZb3C2lpxj2F9rBfLuDAeMRXKPKD2
         KUJw==
X-Gm-Message-State: AOJu0YyowxV/vwdq3b3HkSB9+BVi4l2vnK+sdZzQxxx726tAQtcIlHj2
        ZEoBu6axQuDtqAGXtZZWbALdnPK6BbY=
X-Google-Smtp-Source: AGHT+IGHRLIyxOEOlqNogao+wtJt3d7D+zZNTRSCijTepfZz1QuZZsrU81NGe3dzgdfi+rQuqyfdUQCuPic=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:4211:0:b0:d7e:c4af:22d2 with SMTP id
 p17-20020a254211000000b00d7ec4af22d2mr293199yba.4.1693958192804; Tue, 05 Sep
 2023 16:56:32 -0700 (PDT)
Date:   Tue, 5 Sep 2023 16:56:31 -0700
In-Reply-To: <20230901082025.20548-2-vbabka@suse.cz>
Mime-Version: 1.0
References: <20230901082025.20548-2-vbabka@suse.cz>
Message-ID: <ZPfAL0D95AwXD9tg@google.com>
Subject: Re: [PATCH gmem FIXUP] mm, compaction: make testing
 mapping_unmovable() safe
From:   Sean Christopherson <seanjc@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     ackerleytng@google.com, akpm@linux-foundation.org,
        anup@brainfault.org, aou@eecs.berkeley.edu,
        chao.p.peng@linux.intel.com, chenhuacai@kernel.org,
        david@redhat.com, isaku.yamahata@gmail.com, jarkko@kernel.org,
        jmorris@namei.org, kirill.shutemov@linux.intel.com,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, liam.merwick@oracle.com,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        linux-security-module@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mail@maciej.szmigiero.name,
        maz@kernel.org, michael.roth@amd.com, mpe@ellerman.id.au,
        oliver.upton@linux.dev, palmer@dabbelt.com,
        paul.walmsley@sifive.com, paul@paul-moore.com, pbonzini@redhat.com,
        qperret@google.com, serge@hallyn.com, tabba@google.com,
        vannapurve@google.com, wei.w.wang@intel.com, willy@infradead.org,
        yu.c.zhang@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 01, 2023, Vlastimil Babka wrote:
> As Kirill pointed out, mapping can be removed under us due to
> truncation. Test it under folio lock as already done for the async
> compaction / dirty folio case. To prevent locking every folio with
> mapping to do the test, do it only for unevictable folios, as we can
> expect the unmovable mapping folios are also unevictable - it is the
> case for guest memfd folios.

Rather than expect/assume that unmovable mappings are always unevictable, how about
requiring that?  E.g. either through a VM_WARN_ON in mapping_set_unmovable(), or by
simply having that helper forcefully set AS_UNEVICTABLE as well.

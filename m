Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFA5759C25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 19:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjGSRN1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 13:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjGSRNO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F001D172E
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 10:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689786746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zkcPX3Osb4OA2D5IidduaA2zXjGkNlWKrQ0mhSge49c=;
        b=Ks93h3vtqS+uYmBR9wdp94NuYQOIw10HTA1wrD0Vi8kOR603y9p9aYfS6285k6gvUUZJCJ
        IbExLWZmtckmvuAf3M+poNZUTwwaSjlfneAb8yT+DHQP7rGvbZqwpzHPWEazHUJMw6fgCL
        Lblm47gR2vFKNgHNueyaLbmH/7ORU7M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-cXuUs7jWPRCD0gHfQgs14Q-1; Wed, 19 Jul 2023 13:12:24 -0400
X-MC-Unique: cXuUs7jWPRCD0gHfQgs14Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a355cf318so418666666b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 10:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689786743; x=1692378743;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkcPX3Osb4OA2D5IidduaA2zXjGkNlWKrQ0mhSge49c=;
        b=hFOz2fdy48lOgdQGCuEFg9KPsEoA+9DuWvkoH43YENpIDMhRLhsEEJNvS6nKHBakzD
         Sx5rDWFBoj9AnCcMFefp+wbQV/AoclSSxwJ60cXNV3HiKnGUfM+lQd+jrZYS8L6NrwnJ
         e0fpkwzswpWxikWjeY4HTlN8pcxtqU04nSKcO2QWE4yVqHDkj/hP9vXHwz23DeAc6sb6
         BT73x5aOwxb7W2O6BX19o2eYiS7wq3CN7FiYXorvCGLHWUC4FKw/0JS/Ka3QD4xfep5F
         9kV8nJRpNu8T0QYsd2Ir3SN5E/xeVDU8KD/iXkgqCpoCc7FKF4cyQ45UG7+j3JNc2FlK
         UqKw==
X-Gm-Message-State: ABy/qLbKeBAIrzgkJGnDEtogSBmONYs01eOLWIIOyjlEhwc6FFzQk73o
        re3KyI/PV+zktJ5CHOkjWL8RSrCA03gpnWrsldIOU2RYZrXli20+6vqeQPqQySs8Rj4NNcxLCOf
        aQjBZaN2SY49svXgnJfy1zEBD8w==
X-Received: by 2002:a17:906:d84:b0:994:54ff:10f6 with SMTP id m4-20020a1709060d8400b0099454ff10f6mr2451599eji.30.1689786743728;
        Wed, 19 Jul 2023 10:12:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGz54zGhPvYMbmpFt53PQK6LgNX37cQEB9yNTieid5ItMiwID6yFOylHPqQjVFsqfqQ8BKwkQ==
X-Received: by 2002:a17:906:d84:b0:994:54ff:10f6 with SMTP id m4-20020a1709060d8400b0099454ff10f6mr2451551eji.30.1689786743496;
        Wed, 19 Jul 2023 10:12:23 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id h24-20020a1709063c1800b00989828a42e8sm2589100ejg.154.2023.07.19.10.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 10:12:21 -0700 (PDT)
Message-ID: <095133d1-ad3a-8b5d-d000-10b0b377c7b3@redhat.com>
Date:   Wed, 19 Jul 2023 19:12:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v11 02/29] KVM: Tweak kvm_hva_range and hva_handler_t
 to allow reusing for gfn ranges
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
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
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
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
References: <20230718234512.1690985-1-seanjc@google.com>
 <20230718234512.1690985-3-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230718234512.1690985-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/19/23 01:44, Sean Christopherson wrote:
> Signed-off-by: Sean Christopherson<seanjc@google.com>
> ---
>   virt/kvm/kvm_main.c | 34 +++++++++++++++++++---------------
>   1 file changed, 19 insertions(+), 15 deletions(-)

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


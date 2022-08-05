Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C6158AF3D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 19:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241526AbiHERzt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 13:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241489AbiHERzq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:55:46 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110CAE0E9;
        Fri,  5 Aug 2022 10:55:45 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z22so4288157edd.6;
        Fri, 05 Aug 2022 10:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3pDyPaXmSjg1dfYYTVcD5twgm0VJEcQCaH5PzUebh+o=;
        b=NasTXfyIKwSXshhH6uRWdhVe4jCKkDoBRipCni1OVWDHHkSZE8iK0Vhw289lgKT2uv
         qS6eMQm42wwQy1UZM4kkyrdch99ditPm3awIimLr82sU3if3bt8aw/xZpAu/zujUoS54
         cekJu+G0f5hLStL7JaE8TqYvMOIiGi/Jpq7aUtENnLq1amafw+ZX0Y2XkXTjLvABPgZy
         B2U3SlVeDIS9e9u0kjZ4XgI66qvYPgtf+Dc14Ob180027TtXQXfKeB9PzzQrAjBFtZj5
         NCEt46wYh/AQ0HNsMQk9lnmN60NZeyIIR4J9rMfvYs5Q3+KGn6pMjwuXrHIEpd4ll7dC
         5XQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3pDyPaXmSjg1dfYYTVcD5twgm0VJEcQCaH5PzUebh+o=;
        b=TVlx1kQ+ha3dWHQG8yoWH5f/MhMl/SOMwkbKc0Qb06cl3SA4nN3h4wptGqxB7i9qUc
         sJGHAs7gb6itmZxkzn8PZdteNdCtSM0QyeDqXLxB+3NDeGCvirpN5KdRp5ySspcUwfx3
         gyj1WhNz/xPWvlXw7Z3XeKrSg3/XwxXtaygwD4YvFrXcP1Gb/2Ra2+3e3ZLD2onnXjMz
         yA8KUwYuvfh4o5kQHUqQjpiKcv6W5yrVP6tXsvR8Y5hqwfFNmtTmj26UiGKBQXVueuk/
         R0LlCXaAPxffPeCOgrnCagzMjaKxTxnVavBli9qKRDc4+phh5CI7e/1Nz12rsj0wVGQ+
         zV5g==
X-Gm-Message-State: ACgBeo2phJFfYh2nwdG4n7DvZeWHLPGjrvxqqA6arqu/6XQckarWDOTj
        OyYKRgQ//b0uCruObqkQ/lIjOgr2WQxwjA==
X-Google-Smtp-Source: AA6agR5VWBwmuMByhlGp2jZk5km25TlB77WRs6fSjW6q6o8glqXJyrvjZip6gTq1ZgU4MWVWBbx1Kw==
X-Received: by 2002:a05:6402:5518:b0:43a:9e32:b6fc with SMTP id fi24-20020a056402551800b0043a9e32b6fcmr8004431edb.252.1659722143505;
        Fri, 05 Aug 2022 10:55:43 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id b11-20020a17090630cb00b0072b36cbcdaasm1809391ejb.92.2022.08.05.10.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 10:55:42 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <472207cf-ff71-563b-7b66-0c7bea9ea8ad@redhat.com>
Date:   Fri, 5 Aug 2022 19:55:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 01/14] mm: Add F_SEAL_AUTO_ALLOCATE seal to memfd
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-2-chao.p.peng@linux.intel.com>
 <f39c4f63-a511-4beb-b3a4-66589ddb5475@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <f39c4f63-a511-4beb-b3a4-66589ddb5475@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/21/22 11:44, David Hildenbrand wrote:
> 
> Also, I*think*  you can place pages via userfaultfd into shmem. Not
> sure if that would count "auto alloc", but it would certainly bypass
> fallocate().

Yeah, userfaultfd_register would probably have to forbid this for 
F_SEAL_AUTO_ALLOCATE vmas.  Maybe the memfile_node can be reused for 
this, adding a new MEMFILE_F_NO_AUTO_ALLOCATE flags?  Then 
userfault_register would do something like 
memfile_node_get_flags(vma->vm_file) and check the result.

This means moving this patch later, after "mm: Introduce memfile_notifier".

Thanks,

Paolo

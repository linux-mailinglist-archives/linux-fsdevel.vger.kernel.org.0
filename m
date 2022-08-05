Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2194158AB86
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 15:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbiHENXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 09:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbiHENXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 09:23:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CF88101DF
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Aug 2022 06:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659705783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cvTnOWMtENdA0lewWHSDMt4C5p+Z0vLjSaKneQSan0A=;
        b=iHMUxtcTYjY2UrwOyv3Xi0gmMh+7Bkox1NpSLYi4Eh8gsDf2iwLbBocutFX2mxJr1RIO1e
        OB1XhmfPVn65QcUUGz+LfN6rYK1IZ5zmLHzRF/g4dWcBHX5CiY6ayJiTVG2FSKj7seWwdj
        LkZIbbEfVjE7d93h8NoJ83WKZNWaRiw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-O6GJVusuOhCBRY1BNukTPg-1; Fri, 05 Aug 2022 09:23:02 -0400
X-MC-Unique: O6GJVusuOhCBRY1BNukTPg-1
Received: by mail-wm1-f69.google.com with SMTP id n19-20020a05600c3b9300b003a314062cf4so3555783wms.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Aug 2022 06:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=cvTnOWMtENdA0lewWHSDMt4C5p+Z0vLjSaKneQSan0A=;
        b=HVOSe2JxynuOxpY8SVJRulJPhDvSuwuqTfJs6QmHBbPNa5rgwFwFpFarwDiW4zvxng
         kMzS32B0UWrkFZ3yqTGH86Um03kyrbGspoqG/AI2WufqvmRxYIrLSs6o2E1X1TIiYFpJ
         8HkMd0ZmfR5HtOSAfXWUm+cUAPpHeLSuPUN70TT5eq1TaC0LKrO+/OakJldPM2Bug/oo
         PM0Anb1nRhq7PfFAwKTBcVYnZGMPQNJUKY8OLiPciicVRQzU9pcWf2Fs985rtuuuvxCD
         ibrfu/FP7oZhQzhDxG3o0sRZTbX8IrAe0xMN6sVsdQD5zM5ItZGDwhgsoxQq5svtAeh4
         BBEw==
X-Gm-Message-State: ACgBeo0wtcOHG0d2uUpHwye9ZINnEGSwY7H1cBNd0ERaWeJjQgQsflXa
        1/5/ZXCZuSz2w5GIGxi2bmuYoXbY8WtLMekL7oZNzGQGuzW+bSZQLxn06kpMQwpbuGV52VO/YnO
        0Nam67R7SpQzgSjRNoRP1qxCe1A==
X-Received: by 2002:adf:ce92:0:b0:220:5ef0:876d with SMTP id r18-20020adfce92000000b002205ef0876dmr4402408wrn.647.1659705781191;
        Fri, 05 Aug 2022 06:23:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4uPBaWEs/z4mc87PDNQd0FqLSk3+CEo5G4UY36ZDFdxSdxTMNZ5FFOGBR2vXXQe8nDaUxZUw==
X-Received: by 2002:adf:ce92:0:b0:220:5ef0:876d with SMTP id r18-20020adfce92000000b002205ef0876dmr4402357wrn.647.1659705780923;
        Fri, 05 Aug 2022 06:23:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fb00:f5c3:24b2:3d03:9d52? (p200300cbc706fb00f5c324b23d039d52.dip0.t-ipconnect.de. [2003:cb:c706:fb00:f5c3:24b2:3d03:9d52])
        by smtp.gmail.com with ESMTPSA id h36-20020a05600c49a400b003a2c7bf0497sm4326304wmp.16.2022.08.05.06.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 06:23:00 -0700 (PDT)
Message-ID: <13394075-fca0-6f2b-92a2-f1291fcec9a3@redhat.com>
Date:   Fri, 5 Aug 2022 15:22:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
 <20220706082016.2603916-4-chao.p.peng@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v7 03/14] mm: Introduce memfile_notifier
In-Reply-To: <20220706082016.2603916-4-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06.07.22 10:20, Chao Peng wrote:
> This patch introduces memfile_notifier facility so existing memory file
> subsystems (e.g. tmpfs/hugetlbfs) can provide memory pages to allow a
> third kernel component to make use of memory bookmarked in the memory
> file and gets notified when the pages in the memory file become
> invalidated.

Stupid question, but why is this called "memfile_notifier" and not
"memfd_notifier". We're only dealing with memfd's after all ... which
are anonymous files essentially. Or what am I missing? Are there any
other plans for fs than plain memfd support that I am not aware of?

> 
> It will be used for KVM to use a file descriptor as the guest memory
> backing store and KVM will use this memfile_notifier interface to
> interact with memory file subsystems. In the future there might be other
> consumers (e.g. VFIO with encrypted device memory).
> 
> It consists below components:
>  - memfile_backing_store: Each supported memory file subsystem can be
>    implemented as a memory backing store which bookmarks memory and
>    provides callbacks for other kernel systems (memfile_notifier
>    consumers) to interact with.
>  - memfile_notifier: memfile_notifier consumers defines callbacks and
>    associate them to a file using memfile_register_notifier().
>  - memfile_node: A memfile_node is associated with the file (inode) from
>    the backing store and includes feature flags and a list of registered
>    memfile_notifier for notifying.
> 
> In KVM usages, userspace is in charge of guest memory lifecycle: it first
> allocates pages in memory backing store and then passes the fd to KVM and
> lets KVM register memory slot to memory backing store via
> memfile_register_notifier.

Can we add documentation/description in any form how the different
functions exposed in linux/memfile_notifier.h are supposed to be used?

Staring at memfile_node_set_flags() and memfile_notifier_invalidate()
it's not immediately clear to me who's supposed to call that and under
which conditions.

-- 
Thanks,

David / dhildenb


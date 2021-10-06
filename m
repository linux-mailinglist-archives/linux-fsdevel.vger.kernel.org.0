Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0322423A87
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 11:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237867AbhJFJ3o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 05:29:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56739 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237852AbhJFJ3n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 05:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633512471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ngYQ8UnRk1ZQG1QBxVMt0vUipJ0oB+rpBaTB/8WXgg=;
        b=AzZSTP2BTPLej+IZv+m/sekAu9zo1/Aiv5sQ/Yh8qZThGfgJX3yvJfVrA/bFW8tRj/klug
        qvwwtdsL+F+w4S5sUdWLib/dyajtt5aX/bMnTe+fF0TIewT1JbPF5oLgHg4zGpnYQhN7cO
        Inqnhq5CoNwtHuku/z3RUD40sPNCMN4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-7z_duv6NMqS-qor_d86TZw-1; Wed, 06 Oct 2021 05:27:50 -0400
X-MC-Unique: 7z_duv6NMqS-qor_d86TZw-1
Received: by mail-wr1-f69.google.com with SMTP id d13-20020adf9b8d000000b00160a94c235aso1518692wrc.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Oct 2021 02:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7ngYQ8UnRk1ZQG1QBxVMt0vUipJ0oB+rpBaTB/8WXgg=;
        b=b7qArSeSpue9L296RuUR0fFmok4e3YXKp8B5gzEvaKxqivIRQgcJ9/lLuy+mAyTJa9
         F7T+b7ZARXPthEYeig20q5gACOuCbm/yV13KB/b6whdNV1mCdROeieZYtVZ1U2aSoz61
         vB+RyTQmi6hqtEZELBSGJuPKrOEatIJiHVnlwA+UxynFZTeUFhLlaY9nKByPcL0GQqBk
         jngML4HXlaCGk68sCDj17BhJRDjzMqeA6DBxypfENtghL96TYXX7ZCfu/scIdPcSAyz8
         qIM71UcsRKobDUD3j10Jh9yhYkaUVGuPgOyyb2n5od07VTruZ1qkJZ3cEmOr5BT6As9/
         iLIw==
X-Gm-Message-State: AOAM532QWEoP7/MeaGjyC5wxUtmAS+5W+qsZyCQdxj32ri3CWP1oVyIG
        9KAHJGrPhTn0j2lZsmgOLoK4jkT6Xq1FgAIt0ECHtE+jPCfPaQkhJBs5N9iyMhHYlCE96/VPiQZ
        DgoSEYxwqATem/Lwa6fUV60UUAw==
X-Received: by 2002:a05:600c:2504:: with SMTP id d4mr8654602wma.53.1633512468947;
        Wed, 06 Oct 2021 02:27:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGUhy0gAKWUOqrJ1UNTMcU+0gj6b2WgmTy8wezEYe1OO1y1Ud7N7Qy2A2zoM8LgbCxYHGIwg==
X-Received: by 2002:a05:600c:2504:: with SMTP id d4mr8654537wma.53.1633512468677;
        Wed, 06 Oct 2021 02:27:48 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6529.dip0.t-ipconnect.de. [91.12.101.41])
        by smtp.gmail.com with ESMTPSA id o26sm4707828wmc.17.2021.10.06.02.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 02:27:48 -0700 (PDT)
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
To:     Michal Hocko <mhocko@suse.com>, John Hubbard <jhubbard@nvidia.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        chris.hyser@oracle.com, Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
References: <20211001205657.815551-1-surenb@google.com>
 <20211001205657.815551-3-surenb@google.com>
 <20211005184211.GA19804@duo.ucw.cz>
 <CAJuCfpE5JEThTMhwKPUREfSE1GYcTx4YSLoVhAH97fJH_qR0Zg@mail.gmail.com>
 <20211005200411.GB19804@duo.ucw.cz>
 <CAJuCfpFZkz2c0ZWeqzOAx8KFqk1ge3K-SiCMeu3dmi6B7bK-9w@mail.gmail.com>
 <efdffa68-d790-72e4-e6a3-80f2e194d811@nvidia.com>
 <YV1eCu0eZ+gQADNx@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <6b15c682-72eb-724d-bc43-36ae6b79b91a@redhat.com>
Date:   Wed, 6 Oct 2021 11:27:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YV1eCu0eZ+gQADNx@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06.10.21 10:27, Michal Hocko wrote:
> On Tue 05-10-21 23:57:36, John Hubbard wrote:
> [...]
>> 1) Yes, just leave the strings in the kernel, that's simple and
>> it works, and the alternatives don't really help your case nearly
>> enough.
> 
> I do not have a strong opinion. Strings are easier to use but they
> are more involved and the necessity of kref approach just underlines
> that. There are going to be new allocations and that always can lead
> to surprising side effects.  These are small (80B at maximum) so the
> overall footpring shouldn't all that large by default but it can grow
> quite large with a very high max_map_count. There are workloads which
> really require the default to be set high (e.g. heavy mremap users). So
> if anything all those should be __GFP_ACCOUNT and memcg accounted.
> 
> I do agree that numbers are just much more simpler from accounting,
> performance and implementation POV.

+1

I can understand that having a string can be quite beneficial e.g., when 
dumping mmaps. If only user space knows the id <-> string mapping, that 
can be quite tricky.

However, I also do wonder if there would be a way to standardize/reserve 
ids, such that a given id always corresponds to a specific user. If we 
use an uint64_t for an id, there would be plenty room to reserve ids ...

I'd really prefer if we can avoid using strings and instead using ids.

-- 
Thanks,

David / dhildenb


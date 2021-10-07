Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E05424F68
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 10:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhJGItd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 04:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbhJGItc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 04:49:32 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E60C061746
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Oct 2021 01:47:38 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r19so20781092lfe.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 01:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=adlW7pivg4cyteV3mlsXKz5Do/ag2vJ2th3mLW+Jmhk=;
        b=NWv2fnZXyOmBKQNz9D7DBaxjTucq2XfkEMTsgzUE8HR+WVOhbVAUU4xS7nXJRwqJF8
         g3q1WrbffIpNZTnYHCkKMDKRrc3rJ2PvfatVUE2Uw1i6BVBTwiccMxMJj/YAMu2MuKJ7
         9XEcOXAoCIocfpPBryXu5bKAKs+AlDSqnYUtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=adlW7pivg4cyteV3mlsXKz5Do/ag2vJ2th3mLW+Jmhk=;
        b=RfP7xi4mvTWU2UwbmdGhvzCgU6eemoo56WXDV3VH5EqLYknoh8WUg2nnjoWHEl7aPs
         iuUf2WE8LdmPii7OYlUZs/SeEoaE3CjgAUHBhZ1CAWgj+5HApGocOxVh0kljUOr2WjFH
         jEV0BfSz63q+LCPOFNAelT565HXy9VVUZZCt5GRrsAQX8ZOEf6HHydJxIxQg0+B2O83J
         px0/ZNwXfDbGMxDimSjEgX4zqiwpTgEyrnaiazu6wTY6ptKxc+ywuK8PF7f6F1cyv2Rw
         8t4ENN61egdlk7flSAJcxIvBXNBLKN5q2dM4jeW8oDo7fv8ov+dcvqRMeuo8JbTNC5cl
         Hdmw==
X-Gm-Message-State: AOAM531DURSLJVcBl1YXo6mCtUwRvhWoq0nPvLoYokZIGhVzhcAHhIgJ
        mtV9JHYpnSao7qVMbuWuPFVUGw==
X-Google-Smtp-Source: ABdhPJzsYPt+vLAs50hdpyaFOkVRdocmTQrfybHrq0Gm27Ezn/kTFNFcWG+99jNjVDI1tjzVTzjMvw==
X-Received: by 2002:a05:6512:228f:: with SMTP id f15mr2982523lfu.253.1633596454456;
        Thu, 07 Oct 2021 01:47:34 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id l23sm2716647ljg.99.2021.10.07.01.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 01:47:34 -0700 (PDT)
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
To:     Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     Pavel Machek <pavel@ucw.cz>, David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
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
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
References: <20211005184211.GA19804@duo.ucw.cz>
 <CAJuCfpE5JEThTMhwKPUREfSE1GYcTx4YSLoVhAH97fJH_qR0Zg@mail.gmail.com>
 <20211005200411.GB19804@duo.ucw.cz>
 <CAJuCfpFZkz2c0ZWeqzOAx8KFqk1ge3K-SiCMeu3dmi6B7bK-9w@mail.gmail.com>
 <efdffa68-d790-72e4-e6a3-80f2e194d811@nvidia.com>
 <YV1eCu0eZ+gQADNx@dhcp22.suse.cz>
 <6b15c682-72eb-724d-bc43-36ae6b79b91a@redhat.com>
 <CAJuCfpEPBM6ehQXgzp=g4SqtY6iaC8wuZ-CRE81oR1VOq7m4CA@mail.gmail.com>
 <20211006175821.GA1941@duo.ucw.cz>
 <CAJuCfpGuuXOpdYbt3AsNn+WNbavwuEsDfRMYunh+gajp6hOMAg@mail.gmail.com>
 <YV6rksRHr2iSWR3S@dhcp22.suse.cz>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <92cbfe3b-f3d1-a8e1-7eb9-bab735e782f6@rasmusvillemoes.dk>
Date:   Thu, 7 Oct 2021 10:47:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YV6rksRHr2iSWR3S@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/10/2021 10.10, Michal Hocko wrote:
> On Wed 06-10-21 11:18:31, Suren Baghdasaryan wrote:
>> On Wed, Oct 6, 2021 at 10:58 AM Pavel Machek <pavel@ucw.cz> wrote:
> [...]
>>> That "central facility" option can be as simple as "mkdir
>>> /somewhere/sanitized_id", using inode numbers for example. You don't
>>> really need IPC.
>>
>> Hmm, so the suggestion is to have some directory which contains files
>> representing IDs, each containing the string name of the associated
>> vma? Then let's say we are creating a new VMA and want to name it. We
>> would have to scan that directory, check all files and see if any of
>> them contain the name we want to reuse the same ID.
> 
> I believe Pavel meant something as simple as
> $ YOUR_FILE=$YOUR_IDS_DIR/my_string_name
> $ touch $YOUR_FILE
> $ stat -c %i $YOUR_FILE

So in terms of syscall overhead, that would be open(..., O_CREAT |
O_CLOEXEC), fstat(), close() - or one could optimistically start by
doing a single lstat() if it is normal that the name is already created
(which I assume).

As for the consumer, one can't directly map an inode number to a dentry,
but whoever first creates the name->id mapping could also be responsible
for doing a "sprintf(buf, "/id/to/name/%016lx", id); symlink(name,
buf)". And if one did the optimistic lstat() succesfully, one would know
that someone else created the file and thus the symlink. And since the
operations are idempotent, the obvious races are irrelevant.

Then the consumer would only need to do a readlink() to get the name.
But that would only be for presentation to a human. Internally all the
aggregation based on the type of anon mem the tool might as well do in
terms of the integer id.

> YOUR_IDS_DIR can live on a tmpfs and you can even implement a policy on
> top of that (who can generate new ids, gurantee uniqness etc...).
> 
> The above is certainly not for free of course but if you really need a
> system wide consistency when using names then you need some sort of
> central authority. How you implement that is not all that important
> but I do not think we want to handle that in the kernel.

IDK. If the whole thing could be put behind a CONFIG_ knob, with _zero_
overhead when not enabled (and I'm a bit worried about all the functions
that grow an extra argument that gets passed around), I don't mind the
string interface. But I don't really have a say either way.

Rasmus

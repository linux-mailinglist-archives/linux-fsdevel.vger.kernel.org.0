Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8635F3E089F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 21:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239251AbhHDTSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 15:18:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229603AbhHDTSI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 15:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628104675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AOuTInqWHm5JsxiufxPxrl3RhFGmVgLzFC5P9l0+9vM=;
        b=VQt6kyZ1m4R5mWY+xRmd2I21P2Xh9VrJnqna1eD8uoEDikfIMgWNXuDgYSi9hKCHEkKm1t
        FFivLnoerufYjhLnk5fA4aR3dr5x54vWGlDzgO+bbR59RQ4QZifj4LHIemfWyKBfZgmEcP
        KgeTS/OLLKdBUZnbjGDwDKfyBmeH5pQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-3zLtGSsQOkilFL3KdyenuA-1; Wed, 04 Aug 2021 15:17:54 -0400
X-MC-Unique: 3zLtGSsQOkilFL3KdyenuA-1
Received: by mail-qk1-f198.google.com with SMTP id x2-20020a05620a0ec2b02903b8bd8b612eso2621639qkm.19
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Aug 2021 12:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AOuTInqWHm5JsxiufxPxrl3RhFGmVgLzFC5P9l0+9vM=;
        b=IZXTxaFEVTbc3QX+wTbqEkdskJSvx8EIahXDkJKiOzA0pxPQr05czIrJcYzZi0tVOk
         Hfougp8LsxA0Xq82vOPw3SCELjHGBsbP1wkB5FgKg2Z52JKKNDzaavH54kQALKHM+2N/
         OJ0cz0dLTI28JpM7AsJNFYKQN61neX0S4/EyiWI/oztiFFREnVEWhyJonwgI6JBUhG0u
         Zwx4AOZ9wpTNBodoLXUgv62GtbGUShoPbBMzTgKPXJKM6nbVxa8JiQ8TXI9dtHR6eN0G
         KPUkfpmBVUKjVM8AsZEH16kd+2erpO85Fd9sNwU3TMzCHSkrCBrZ/smRI4cQ/RgWKLe9
         +JSA==
X-Gm-Message-State: AOAM533dAk9V0NXKK8msGaSAZglP1tukchI0pulugITPMA7wbxxobJtK
        4jp5EzAanuTtDeZFr2+s5QU8SxtLZ5IAnUgR9/QbSx6yI29qsRMko92t0nXnHAIJdKt4fqFil6E
        +K0SxLLdr39iA60ZzY1nro30uqw==
X-Received: by 2002:ac8:1106:: with SMTP id c6mr1064937qtj.20.1628104673686;
        Wed, 04 Aug 2021 12:17:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/VPzU3MTG44ao6DOYRTTSzyp04c8qcvUclHsx6dvYvekjwEGCNaOIR/cWW1gAe6hROeaXLw==
X-Received: by 2002:ac8:1106:: with SMTP id c6mr1064902qtj.20.1628104673462;
        Wed, 04 Aug 2021 12:17:53 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-92-76-70-75-133.dsl.bell.ca. [76.70.75.133])
        by smtp.gmail.com with ESMTPSA id w14sm1821905qkm.81.2021.08.04.12.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 12:17:52 -0700 (PDT)
Date:   Wed, 4 Aug 2021 15:17:51 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        christian.brauner@ubuntu.com, ebiederm@xmission.com,
        adobriyan@gmail.com, songmuchun@bytedance.com, axboe@kernel.dk,
        vincenzo.frascino@arm.com, catalin.marinas@arm.com,
        peterz@infradead.org, chinwen.chang@mediatek.com,
        linmiaohe@huawei.com, jannh@google.com, apopple@nvidia.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, ivan.teterevkov@nutanix.com,
        florian.schmidt@nutanix.com, carl.waldspurger@nutanix.com,
        jonathan.davies@nutanix.com
Subject: Re: [PATCH 0/1] pagemap: swap location for shared pages
Message-ID: <YQrn33pOlpdl662i@t490s>
References: <20210730160826.63785-1-tiberiu.georgescu@nutanix.com>
 <YQrdY5zQOVgQJ1BI@t490s>
 <839e82f7-2c54-d1ef-8371-0a332a4cb447@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <839e82f7-2c54-d1ef-8371-0a332a4cb447@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 04, 2021 at 08:49:14PM +0200, David Hildenbrand wrote:
> TBH, I tend to really dislike the PTE marker idea. IMHO, we shouldn't store
> any state information regarding shared memory in per-process page tables: it
> just doesn't make too much sense.
> 
> And this is similar to SOFTDIRTY or UFFD_WP bits: this information actually
> belongs to the shared file ("did *someone* write to this page", "is
> *someone* interested into changes to that page", "is there something"). I
> know, that screams for a completely different design in respect to these
> features.
> 
> I guess we start learning the hard way that shared memory is just different
> and requires different interfaces than per-process page table interfaces we
> have (pagemap, userfaultfd).
> 
> I didn't have time to explore any alternatives yet, but I wonder if tracking
> such stuff per an actual fd/memfd and not via process page tables is
> actually the right and clean approach. There are certainly many issues to
> solve, but conceptually to me it feels more natural to have these shared
> memory features not mangled into process page tables.

Yes, we can explore all the possibilities, I'm totally fine with it.

I just want to say I still don't think when there's page cache then we must put
all the page-relevant things into the page cache.

They're shared by processes, but process can still have its own way to describe
the relationship to that page in the cache, to me it's as simple as "we allow
process A to write to page cache P", while "we don't allow process B to write
to the same page" like the write bit.

Swap information is indeed tricky because it's shared by all the processes, but
so far I still see it as a doable approach as long as it can solve the problem.

I am not against the approach mentioned in this patch either - but I still
share my concerns, as that's not normally what we do with existing interfaces.

Thanks,

-- 
Peter Xu


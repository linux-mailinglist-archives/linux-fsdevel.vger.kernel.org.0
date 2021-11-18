Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2141A4551BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 01:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241972AbhKRAhZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 19:37:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53392 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241952AbhKRAhZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 19:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637195665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BeNhrEKZDmwOYYueDNfboE8DCNvjuM9I1jBB9AYYqeQ=;
        b=a21Jja2RNrBRV/Gr+Q5DmW5aOc5NfCQ4tCvJjllkxp/fLaQcij7kZcKXp/g0OjbRixpdsb
        S88RnM73qUGHP81axDy1A4UYWUAVruORunCBKFteIm1ZTxd1CZUUKEEMQaZ/vJ54KVZ0yc
        ZEvNbj/VcZqpDqz9PY09yq1lIaP/fE4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172-VlwvLM4xMgywOIDQK5qHzg-1; Wed, 17 Nov 2021 19:34:24 -0500
X-MC-Unique: VlwvLM4xMgywOIDQK5qHzg-1
Received: by mail-pj1-f69.google.com with SMTP id p12-20020a17090b010c00b001a65bfe8054so2166269pjz.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 16:34:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BeNhrEKZDmwOYYueDNfboE8DCNvjuM9I1jBB9AYYqeQ=;
        b=ayaWGlJGi3DhhJ5fYge15TwG9pz5PIQBRyW15djWxJDre5aXTDwsuw/gBffLetWfZR
         8JQ2g2eFaq5PTgKJUIhUGpDv9BmJmsLTErTNxlcUGnSOBzviftBWAXsZQJRskE0Tayw3
         n/Q7Yy+Jz07RqLo9S/LfHex1lvCIhsEM/yZmUrU1EGvduc11Xm7kub3XAlmWNM6Ywkek
         oVKtyIwrsZLgSAT35qOGzeeGBNUxSFSrP+2n5C5MeUnQFRgxU3UXk2SwWHzjNn3GB4yx
         4IVG7bINWAjwpESCwusPtAzKIdMT6VI5yunB1DxTsxuvDcCmTPI80r1t1O03k0HAgUvB
         P/Pw==
X-Gm-Message-State: AOAM53355ZvHLPaT6sAjhAGp8K9sJIapH/5Q9hPjY7nJGLp8z78IFCSh
        cyXt+1c0oGCK0y9IXNMxYnro7fr9SL5kljhnwd7+XEWqZa+qtyfKVEBcZhvNQOxe1knmbyHZc0O
        3WEoxIKcMx+M/v1NF8XRpq35EkQ==
X-Received: by 2002:a17:90b:4aca:: with SMTP id mh10mr5136764pjb.234.1637195663356;
        Wed, 17 Nov 2021 16:34:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0qgqZGid7zYOV0THXIIaStWGVESZVDgQ8anBVeCNdnsEnBD0O/E8F3Tq/CgNL9Ux+taUsqA==
X-Received: by 2002:a17:90b:4aca:: with SMTP id mh10mr5136707pjb.234.1637195662934;
        Wed, 17 Nov 2021 16:34:22 -0800 (PST)
Received: from xz-m1.local ([191.101.132.73])
        by smtp.gmail.com with ESMTPSA id f19sm777629pfc.122.2021.11.17.16.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 16:34:22 -0800 (PST)
Date:   Thu, 18 Nov 2021 08:34:14 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6] mm: Add PM_THP_MAPPED to /proc/pid/pagemap
Message-ID: <YZWfhsMtH8KUaEqO@xz-m1.local>
References: <20211117194855.398455-1-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211117194855.398455-1-almasrymina@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Mina,

On Wed, Nov 17, 2021 at 11:48:54AM -0800, Mina Almasry wrote:
> Add PM_THP_MAPPED MAPPING to allow userspace to detect whether a given virt
> address is currently mapped by a transparent huge page or not.  Example
> use case is a process requesting THPs from the kernel (via a huge tmpfs
> mount for example), for a performance critical region of memory.  The
> userspace may want to query whether the kernel is actually backing this
> memory by hugepages or not.
> 
> PM_THP_MAPPED bit is set if the virt address is mapped at the PMD
> level and the underlying page is a transparent huge page.
> 
> A few options were considered:
> 1. Add /proc/pid/pageflags that exports the same info as
>    /proc/kpageflags.  This is not appropriate because many kpageflags are
>    inappropriate to expose to userspace processes.
> 2. Simply get this info from the existing /proc/pid/smaps interface.
>    There are a couple of issues with that:
>    1. /proc/pid/smaps output is human readable and unfriendly to
>       programatically parse.
>    2. /proc/pid/smaps is slow.  The cost of reading /proc/pid/smaps into
>       userspace buffers is about ~800us per call, and this doesn't
>       include parsing the output to get the information you need. The
>       cost of querying 1 virt address in /proc/pid/pagemaps however is
>       around 5-7us.

This does not seem to be fair...  Should the "800us" value relevant to the
process memory size being mapped?  As smaps requires walking the whole memory
range and provides all stat info including THP accountings.

While querying 1 virt address can only account 1 single THP at most.

It means if we want to do all THP accounting for the whole range from pagemap
we need multiple read()s, right?  The fair comparison should compare the sum of
all the read()s on the virt addr we care to a single smap call.

And it's hard to be fair too, IMHO, because all these depend on size of mm.

Smaps is, logically, faster because of two things:

  - Smaps needs only one syscall for whatever memory range (so one
    user->kernel->user switch).

    Comparing to pagemap use case of yours, you'll need to read 1 virt address
    for each PMD, so when the PMD mapped size is huge, it could turn out that
    smaps is faster even counting in the parsing time of smaps output.

  - Smaps knows how to handle things in PMD level without looping into PTEs:
    see smaps_pmd_entry().

    Smaps will not duplicate the PMD entry into 512 PTE entries, because smaps
    is doing statistic (and that's exaxtly what your use case wants!), while
    pagemap is defined in 4K page size even for huge mappings because the
    structure is defined upon the offset of the pagemap fd; that's why it needs
    to duplicate the 2M entry into 512 same ones; even if they're not really so
    meaningful.

That's also why I tried to propose the interface of smaps to allow querying
partial of the memory range, because IMHO it solves the exact problem you're
describing and it'll also be in the most efficient way, meanwhile I think it
expose all the rest smaps data too besides THP accountings so it could help
more than thp accountings.

So again, no objection on this simple and working patch, but perhaps rephrasing
the 2nd bullet as: "smaps is slow because it must read the whole memory range
rather than a small range we care"?

Thanks,

-- 
Peter Xu


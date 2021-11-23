Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDC44599D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 02:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhKWBxz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 20:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhKWBxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 20:53:54 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC9CC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 17:50:47 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so1492494pjb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 17:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=HTzCF6jo65htyBDPrBpILeuvBdfXuhBAIKFNppjW8x0=;
        b=S6zMZEH+VmGFF/xsCr6aCbyNpxx1pxYIOJuVyfkhQNaxEH5T5BMG3mtU+HtkGq0ZNf
         MX8Fmo5U4MBHtVBCyO2WsuhFQYLk1zI3fbwn2Kn2KDKNHWA5Eifl/6ZRfDkJ1RxeWViV
         XY/3aPlZMKgcNtF0rISzPQCt1I4M63iRdN4SxFACjhKvXWwIgXK7oKGs91ePkwJ24Pw8
         YnKl2pDB16dO9oPqjbvqCgFUA4akW8Q5jpbD12C/Z4cf0matfKmmtSeSqF+wtf+kw8Ex
         CcTrwDptzTTBK2GdJ/WMckd65hFkOQlnl7i0Nf2EvhRnoe+oJV1qfEwL+pHyGjf62Roj
         /zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=HTzCF6jo65htyBDPrBpILeuvBdfXuhBAIKFNppjW8x0=;
        b=z2KSlNAgibrYXZyZdF8wtndEIDUAGrnWSvNeNxfD5MdWNDoRj1fyKSXzvCrmlP3MNB
         ZLmqte9sdJ8WY+C2UWuTioio1I0ADTmMSbQSblYj9HE1wRotcuu0+kfk5Hj7YckxF1ak
         WLQgp1qJfyvNhdyDcHLwaruJKTKbMOq5Ti+HRtB4scBEn4u416pMQLXyamKGmLGKsp2w
         o0gCJ1WZXsDmY5M8Ghe+j1ep+/EbolxH+XT+XwbLBUOmf++0xk/4jdD+e4GDnwXo1i6g
         wYdjD+8qXQxgzZ4ZLjShBJJgePrMbfD9Rl7v3wPjmNUOZRYjD3wL0IhDFFsUthS5jZQK
         HhiQ==
X-Gm-Message-State: AOAM5308CpRkfX9kyH7uhuuj8oI8SuL3XdVChuOamJUq6/niRxAlNr/8
        25Z9Q0Z7xLCqqxUouHuNVQbZaA==
X-Google-Smtp-Source: ABdhPJxQ/8pqCEDnIj+5QGwd3pdxrE9t/GxEAizWH0isuFT+ppdRZmYdF7x41Z64MCWW5JOlqy1cHw==
X-Received: by 2002:a17:90a:17ef:: with SMTP id q102mr1899751pja.116.1637632246379;
        Mon, 22 Nov 2021 17:50:46 -0800 (PST)
Received: from [2620:15c:17:3:c755:32e5:ce22:b7a8] ([2620:15c:17:3:c755:32e5:ce22:b7a8])
        by smtp.gmail.com with ESMTPSA id t4sm10307601pfj.13.2021.11.22.17.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 17:50:45 -0800 (PST)
Date:   Mon, 22 Nov 2021 17:50:44 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Mina Almasry <almasrymina@google.com>
cc:     Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7] mm: Add PM_THP_MAPPED to /proc/pid/pagemap
In-Reply-To: <20211123000102.4052105-1-almasrymina@google.com>
Message-ID: <b34e16a-f520-ec7b-7811-6adc2e645a5@google.com>
References: <20211123000102.4052105-1-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 22 Nov 2021, Mina Almasry wrote:

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
>    2. /proc/pid/smaps is slow because it must read the whole memory range
>       rather than a small range we care about.  The cost of reading
>       /proc/pid/smaps into userspace buffers is about ~800us per call,
>       and this doesn't include parsing the output to get the information
>       you need. The cost of querying 1 virt address in /proc/pid/pagemaps
>       however is around 5-7us.
> 
> Tested manually by adding logging into transhuge-stress, and by
> allocating THP and querying the PM_THP_MAPPED flag at those
> virtual addresses.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: David Rientjes <rientjes@google.com>

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3E845AD9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 21:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbhKWUyo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 15:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbhKWUyn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 15:54:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2F4C061574;
        Tue, 23 Nov 2021 12:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4VkUJFZfBikgHkbvPCTgubczW3p/ZjTIGcBnmCIkGFE=; b=td9GgBH3w0ndjVdL3WgxOIVa+5
        NfglRythKi8YXAcNoDmURi3YmyUPYMS1I6SrvyElzur5JY50fe418qj0xPSpXt/gFXINy3+Y+OMxL
        bBc1yEmoTrRrN4jRdiO35d6pCMEGlT1j9fs5H60jYEqUj/zkk+MRuIFQRyK0TZNWxorcNtzFYl3Z9
        jBBwBgpNtTOBxgfLV+j5SVpWUB1Hl8qnu9o2pDehmnA1hqW1i8isGWdsdlqPaBdQ5VVdOa/7hBFmR
        txqSv1CGZ/4yRKXxxRaU3zZpezR2TyZdOiv577qeuVaRzZ6Cp1odPe/K4sryaZPZ/1gRnknYuIyMV
        ZndgfYSQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpcl7-00GMub-Hh; Tue, 23 Nov 2021 20:51:21 +0000
Date:   Tue, 23 Nov 2021 20:51:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7] mm: Add PM_THP_MAPPED to /proc/pid/pagemap
Message-ID: <YZ1USY+zB1PP24Z1@casper.infradead.org>
References: <20211123000102.4052105-1-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123000102.4052105-1-almasrymina@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 22, 2021 at 04:01:02PM -0800, Mina Almasry wrote:
> Add PM_THP_MAPPED MAPPING to allow userspace to detect whether a given virt
> address is currently mapped by a transparent huge page or not.  Example
> use case is a process requesting THPs from the kernel (via a huge tmpfs
> mount for example), for a performance critical region of memory.  The
> userspace may want to query whether the kernel is actually backing this
> memory by hugepages or not.

So you want this bit to be clear if the memory is backed by a hugetlb
page?

>  		if (page && page_mapcount(page) == 1)
>  			flags |= PM_MMAP_EXCLUSIVE;
> +		if (page && is_transparent_hugepage(page))
> +			flags |= PM_THP_MAPPED;

because honestly i'd expect it to be more useful to mean "This memory
is mapped by a PMD entry" and then the code would look like:

		if (page)
			flags |= PM_PMD_MAPPED;

(and put a corresponding change in pagemap_hugetlb_range)

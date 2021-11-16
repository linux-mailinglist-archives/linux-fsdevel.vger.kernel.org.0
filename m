Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFEE452519
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 02:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347575AbhKPBqt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 20:46:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:57202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381924AbhKPBor (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 20:44:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE3A761A0D;
        Tue, 16 Nov 2021 01:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637026911;
        bh=3hMkbBt+nftVPfBL7onIS7bfvCNYqfZ04xqsGgCSA8k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v4IL68xgFo8100jW63GQsuBXCL4HsHUP+ndfLODwZxDDwvtYNCMjIRBmdg5iokeN0
         okgGhc9Zx6aAL0FqMX9o53P4DfQiw0oIeRS+Yji0LBMYrv+r9fHQIyE9e5MADqgZU1
         lKk59cS2sginfvqjTYqwQzoNS/Nk1nNZNWdqsM+Q=
Date:   Mon, 15 Nov 2021 17:41:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v5] mm: Add PM_HUGE_THP_MAPPING to /proc/pid/pagemap
Message-Id: <20211115174148.cdaeef3a026fe3143e6699cc@linux-foundation.org>
In-Reply-To: <20211110221120.3833294-1-almasrymina@google.com>
References: <20211110221120.3833294-1-almasrymina@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 10 Nov 2021 14:11:20 -0800 Mina Almasry <almasrymina@google.com> wrote:

> Add PM_HUGE_THP MAPPING to allow userspace to detect whether a given virt
> address is currently mapped by a transparent huge page or not.  Example
> use case is a process requesting THPs from the kernel (via a huge tmpfs
> mount for example), for a performance critical region of memory.  The
> userspace may want to query whether the kernel is actually backing this
> memory by hugepages or not.
> 
> PM_HUGE_THP_MAPPING bit is set if the virt address is mapped at the PMD
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
> 
> Tested manually by adding logging into transhuge-stress, and by
> allocating THP and querying the PM_HUGE_THP_MAPPING flag at those
> virtual addresses.
> 
> --- a/tools/testing/selftests/vm/transhuge-stress.c
> +++ b/tools/testing/selftests/vm/transhuge-stress.c
> @@ -16,6 +16,12 @@
>  #include <string.h>
>  #include <sys/mman.h>
> 
> +/*
> + * We can use /proc/pid/pagemap to detect whether the kernel was able to find
> + * hugepages or no. This can be very noisy, so is disabled by default.
> + */
> +#define NO_DETECT_HUGEPAGES
> +
>
> ...
>
> +#ifndef NO_DETECT_HUGEPAGES
> +		if (!PAGEMAP_THP(ent[0]))
> +			fprintf(stderr, "WARNING: detected non THP page\n");
> +#endif

This looks like a developer thing.  Is there any point in leaving it in
the mainline code?

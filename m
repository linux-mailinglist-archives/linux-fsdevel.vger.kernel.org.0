Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4781235903C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 01:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhDHXNp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 19:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232404AbhDHXNp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 19:13:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53565610E6;
        Thu,  8 Apr 2021 23:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617923613;
        bh=mpb93QphQtuxs5UnMlRM4pkZBibPsFpxB+KeCxq8Bns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SmkVmZIHE2AzWbDXTTV8ESq9Z0tJYGNFMGAPNiOGJdTjrTTli6v29PSWLk3I86M5p
         JYFfHf5U7r9CljP54pZ0BOGQvm10ZPTGabdvEC7Q4Wu57Wl1I3ZxIOhmeAaTVgbfNR
         o7UYNeCzclQgVzOWuKG7kGUsMcrOuNdJxEIe0+73QHSIDmMzZ1D7n+5N7cShz7p2ia
         bmvNo7aEDdV9M/U2kEIZs90y5DTcg0LpIN5oWKy4xbChHttOWce+6Aq4xPM99jVkrB
         9mBLVH/ZdSjloHt+wZUVUK35uHgZjmlfH4FHABfG/x5Qk+cvtSml0rD0uT142+YWP9
         e8FfPB9ffhOgw==
Date:   Thu, 8 Apr 2021 16:13:32 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, jolsa@kernel.org, hannes@cmpxchg.org,
        yhs@fb.com
Subject: Re: [RFC bpf-next 0/1] bpf: Add page cache iterator
Message-ID: <20210408231332.GH22094@magnolia>
References: <cover.1617831474.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617831474.git.dxu@dxuuu.xyz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 02:46:10PM -0700, Daniel Xu wrote:
> There currently does not exist a way to answer the question: "What is in
> the page cache?". There are various heuristics and counters but nothing
> that can tell you anything like:
> 
>   * 3M from /home/dxu/foo.txt
>   * 5K from ...

5K?  That's an extraordinary Weird Machine(tm).

>   * etc.
> 
> The answer to the question is particularly useful in the stacked
> container world. Stacked containers implies multiple containers are run
> on the same physical host. Memory is precious resource on some (if not
> most) of these systems. On these systems, it's useful to know how much
> duplicated data is in the page cache. Once you know the answer, you can
> do something about it. One possible technique would be bind mount common
> items from the root host into each container.

Um, are you describing a system that uses BPF to deduplicating the page
cache by using bind mounts?  Can the containers scribble on these files
and thereby mess up the other containers?  What happens if the container
wants to update itself and clobbers the root host's copy instead?  How
do you deal with a software update process failing because the root host
fights back against the container trying to change its files?

Also, I thought we weren't supposed to share resources across security
boundaries anymore?

--D

> 
> NOTES: 
> 
>   * This patch compiles and (maybe) works -- totally not fully tested
>     or in a final state
> 
>   * I'm sending this early RFC to get comments on the general approach.
>     I chatted w/ Johannes a little bit and it seems like the best way to
>     do this is through superblock -> inode -> address_space iteration
>     rather than going from numa node -> LRU iteration
> 
>   * I'll most likely add a page_hash() helper (or something) that hashes
>     a page so that userspace can more easily tell which pages are
>     duplicate
> 
> Daniel Xu (1):
>   bpf: Introduce iter_pagecache
> 
>  kernel/bpf/Makefile         |   2 +-
>  kernel/bpf/pagecache_iter.c | 293 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 294 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/bpf/pagecache_iter.c
> 
> -- 
> 2.26.3
> 

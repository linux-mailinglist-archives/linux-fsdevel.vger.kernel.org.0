Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4CE1D20C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 23:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgEMVPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 17:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbgEMVPV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 17:15:21 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0267920575;
        Wed, 13 May 2020 21:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589404520;
        bh=Ea3KACcclZ07aASwPFWht/xTSHvjT8unfYTdZBQH6q4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uEmayH51kFnINlCgnG8z6jlPjUkPsWCZjVK5iGMheGtLdiu9OLUjClWIf8Hhjn6V9
         bDEocbRLdn2kXTkQUYHQXy9GvXyiJCh8d2mtV7zTmENXvZJVLWE/GM2UTqUul2Zk+c
         G0HTOCKlIApdY4I6jo/LZaRhTeNRf+pQFy13cUOs=
Date:   Wed, 13 May 2020 14:15:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
Message-Id: <20200513141519.061f8fca4788cd02b4d7068f@linux-foundation.org>
In-Reply-To: <20200512212936.GA450429@cmpxchg.org>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
        <20200512212936.GA450429@cmpxchg.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 12 May 2020 17:29:36 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> 
> ...
>
> Solution
> 
> This patch fixes the aging inversion described above on
> !CONFIG_HIGHMEM systems, without reintroducing the problems associated
> with excessive shrinker LRU rotations, by keeping populated inodes off
> the shrinker LRUs entirely.
> 
> Currently, inodes are kept off the shrinker LRU as long as they have
> an elevated i_count, indicating an active user. Unfortunately, the
> page cache cannot simply hold an i_count reference, because unlink()
> *should* result in the inode being dropped and its cache invalidated.
> 
> Instead, this patch makes iput_final() consult the state of the page
> cache and punt the LRU linking to the VM if the inode is still
> populated; the VM in turn checks the inode state when it depopulates
> the page cache, and adds the inode to the LRU if necessary.
> 
> This is not unlike what we do for dirty inodes, which are moved off
> the LRU permanently until writeback completion puts them back on (iff
> still unused). We can reuse the same code -- inode_add_lru() - here.
> 
> This is also not unlike page reclaim, where the lower VM layer has to
> negotiate state with the higher VFS layer. Follow existing precedence
> and handle the inversion as much as possible on the VM side:
> 
> - introduce an I_PAGES flag that the VM maintains under the i_lock, so
>   that any inode code holding that lock can check the page cache state
>   without having to lock and inspect the struct address_space

Maintaining the same info in two places is a hassle.  Is this
optimization worthwhile?

> - introduce inode_pages_set() and inode_pages_clear() to maintain the
>   inode LRU state from the VM side, then update all cache mutators to
>   use them when populating the first cache entry or clearing the last
> 
> With this, the concept of "inodesteal" - where the inode shrinker
> drops page cache - is relegated to CONFIG_HIGHMEM systems only. The VM
> is in charge of the cache, the shrinker in charge of struct inode.

How tested is this on highmem machines?

> Footnotes
> 
> - For debuggability, add vmstat counters that track the number of
>   times a new cache entry pulls a previously unused inode off the LRU
>   (pginoderescue), as well as how many times existing cache deferred
>   an LRU addition. Keep the pginodesteal/kswapd_inodesteal counters
>   for backwards compatibility, but they'll just show 0 now.
> 
> - Fix /proc/sys/vm/drop_caches to drop shadow entries from the page
>   cache. Not doing so has always been a bit strange, but since most
>   people drop cache and metadata cache together, the inode shrinker
>   would have taken care of them before - no more, so do it VM-side.
> 
> ...
>
>  14 files changed, 208 insertions(+), 34 deletions(-)

Patch is surprisingly large.



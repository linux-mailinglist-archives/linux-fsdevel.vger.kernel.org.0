Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B893350216
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 16:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbhCaOYU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 10:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbhCaOYL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:24:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE5EC061574;
        Wed, 31 Mar 2021 07:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jGhCdX6Dfm1OSeRkmB4iA8KAAFuGkrxqCERpjTGrs7c=; b=XsHgwfwKwpjDiNdKG5k18eweRb
        w5ZbyAAILz2O7Tk2CAkb9fLt6tTHZ/YIlUvVx9b6tNRndZc0bNEsnPcWAg7zVTkSNtB2M5VtfExE6
        NOubqf8qJY8lLAq7hixdk/oK71ZSRGkjxI0xAs6vqjwbEcRs6vD/pfiMGsM1nO5bEixtXb3wXI/Kr
        EeBQJZ5zwcorUL7Sw05zUydwd9Vn13US/IBy7ZIOe0LIzYC1FzGreIbOogw0oMxi8xAi2TjsR/q9u
        VeFtM70uPcTvufDJzEj579BXr+mCwqkYR1+OLQjvvujM/624jxcW9j/sGiPPF9gu0nlt9uqeLKTJf
        lL2Zru2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRblD-004fNg-Pf; Wed, 31 Mar 2021 14:24:02 +0000
Date:   Wed, 31 Mar 2021 15:23:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, viro@zeniv.linux.org.uk,
        matthew.wilcox@oracle.com, khlebnikov@yandex-team.ru
Subject: Re: [PATCH RFC 0/6] fix the negative dentres bloating system memory
 usage
Message-ID: <20210331142355.GX351017@casper.infradead.org>
References: <1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping?  These patches are looking pretty good in our internal testing.

On Thu, Jan 21, 2021 at 06:49:39PM +0530, Gautham Ananthakrishna wrote:
> For most filesystems result of every negative lookup is cached, content of
> directories is usually cached too. Production of negative dentries isn't
> limited with disk speed. It's really easy to generate millions of them if
> system has enough memory.
> 
> Getting this memory back ins't that easy because slab frees pages only when
> all related objects are gone. While dcache shrinker works in LRU order.
> 
> Typical scenario is an idle system where some process periodically creates
> temporary files and removes them. After some time, memory will be filled
> with negative dentries for these random file names.
> 
> Simple lookup of random names also generates negative dentries very fast.
> Constant flow of such negative denries drains all other inactive caches.
> Too many negative dentries in the system can cause memory fragmentation
> and memory compaction.
> 
> Negative dentries are linked into siblings list along with normal positive
> dentries. Some operations walks dcache tree but looks only for positive
> dentries: most important is fsnotify/inotify. Hordes of negative dentries
> slow down these operations significantly.
> 
> Time of dentry lookup is usually unaffected because hash table grows along
> with size of memory. Unless somebody especially crafts hash collisions.
> 
> This patch set solves all of these problems:
> 
> Move negative denries to the end of sliblings list, thus walkers could
> skip them at first sight (patches 1-4).
> 
> Keep in dcache at most three unreferenced negative denties in row in each
> hash bucket (patches 5-6).
> 
> We tested this patch set recently and found it limiting negative dentry to a
> small part of total memory. The following is the test result we ran on two
> types of servers, one is 256G memory with 24 CPUS and another is 3T memory
> with 384 CPUS. The test case is using a lot of processes to generate negative
> dentry in parallel, the following is the test result after 72 hours, the
> negative dentry number is stable around that number even after running longer
> for much longer time. Without the patch set, in less than half an hour 197G was
> taken by negative dentry on 256G system, in 1 day 2.4T was taken on 3T system.
> 
> system memory   neg-dentry-number   neg-dentry-mem-usage
> 256G            55259084            10.6G
> 3T              202306756           38.8G
> 
> For perf test, we ran the following, and no regression found.
> 
> 1. create 1M negative dentry and then touch them to convert them to positive
>    dentry
> 
> 2. create 10K/100K/1M files
> 
> 3. remove 10K/100K/1M files
> 
> 4. kernel compile
> 
> To verify the fsnotify fix, we used inotifywait to watch file create/open in
> some directory where there is a lot of negative dentry, without the patch set,
> the system would run into soft lockup, with it, no soft lockup was found.
> 
> We also tried to defeat the limitation by making different processes generate
> negative dentry with the same name, that will make one negative dentry being
> accessed couple times around same time, DCACHE_REFERENCED will be set on it
> and it can't be trimmed easily.
> 
> There were a lot of customer cases on this issue. It makes no sense to leave
> so many negative dentry, it just causes memory fragmentation and compaction
> and does not help a lot.
> 
> Konstantin Khlebnikov (6):
>   dcache: sweep cached negative dentries to the end of list of siblings
>   fsnotify: stop walking child dentries if remaining tail is negative
>   dcache: add action D_WALK_SKIP_SIBLINGS to d_walk()
>   dcache: stop walking siblings if remaining dentries all negative
>   dcache: push releasing dentry lock into sweep_negative
>   dcache: prevent flooding with negative dentries
> 
>  fs/dcache.c            | 135 +++++++++++++++++++++++++++++++++++++++++++++++--
>  fs/libfs.c             |   3 ++
>  fs/notify/fsnotify.c   |   6 ++-
>  include/linux/dcache.h |   6 +++
>  4 files changed, 145 insertions(+), 5 deletions(-)
> 
> -- 
> 1.8.3.1
> 
> 

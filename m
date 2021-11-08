Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E29449F1E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 00:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbhKHXox (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 18:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240978AbhKHXou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 18:44:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B9FC061764;
        Mon,  8 Nov 2021 15:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zyBXp9nFXyKpys6NToLTdLN2RrQcXAbIwe3B9JMITY8=; b=FRAwff94oZ+NODBFNyR3YgpLuB
        xxiX8cuJ4urF0o/WkJXojrXi5DskSv5tMDChxw3aAS0RM768tRSF2wy494p6yTHotLmzkgHURxvZ1
        WU8Fi8s9+EjjLlfy8w217m3iIrWZ3QpL2zv0a40kifhYxUtZBCyCEEX2PCuXKxvgiAhI+ZpuTvJae
        CQoCJHi4FRgSI7JVwwrojEjhe1yWTwgkTAZfodQpO14jM6vVx8zdAF318d0zj1d/YQjx2d7rA88/4
        uCqKFhquarFVBLJtrOa162D9iLN6aHka+1KVrJlLDz6RZCKkNKC4h0IDPKQ+FM0mpB9OPyhq06eAe
        8vnpA6KA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkEGt-000ZkJ-9P; Mon, 08 Nov 2021 23:41:51 +0000
Date:   Mon, 8 Nov 2021 23:41:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Roman Gushchin <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, riel@surriel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v1 1/5] mm/shmem: support deterministic charging of tmpfs
Message-ID: <YYm1v25dLZL99qKK@casper.infradead.org>
References: <20211108211959.1750915-1-almasrymina@google.com>
 <20211108211959.1750915-2-almasrymina@google.com>
 <20211108221047.GE418105@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108221047.GE418105@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 09, 2021 at 09:10:47AM +1100, Dave Chinner wrote:
> > +	rcu_read_lock();
> > +	memcg = rcu_dereference(mapping->host->i_sb->s_memcg_to_charge);
> 
> Anything doing pointer chasing to obtain static, unchanging
> superblock state is poorly implemented. The s_memcg_to_charge value never
> changes, so this code should associate the memcg to charge directly
> on the mapping when the mapping is first initialised by the
> filesystem. We already do this with things like attaching address
> space ops and mapping specific gfp masks (i.e
> mapping_set_gfp_mask()), so this association should be set up that
> way, too (e.g. mapping_set_memcg_to_charge()).

I'm not a fan of enlarging struct address_space with another pointer
unless it's going to be used by all/most filesystems.  If this is
destined to be a shmem-only feature, then it should be in the
shmem_inode instead of the mapping.

If we are to have this for all filesystems, then let's do that properly
and make it generic functionality from its introduction.

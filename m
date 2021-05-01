Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF09C370525
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 May 2021 05:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhEAD3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 23:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhEAD3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 23:29:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98579C06174A;
        Fri, 30 Apr 2021 20:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pCVpEmSBNkHbA2xrBVXJgYpV5Pdig67bJUCkTSad33Y=; b=HNQVUXqFNihjOn1gK2a+jWUJ52
        8sH4dGp5W5Ok9alYuoGDlG7K4N7e5UHqIZkkRmvb6F7+0qdiQ8wdKKufTxNnl7dcTCzSXfOmXse3d
        35KqSQw6HHQpLk2ZRQWtHDbbYzWSq7t8aI/03gBf5KnxSgs4JH/e28nYLyfUtr7jL8CEIEay+N9P3
        x9q0TQdjpyJuhYJrPLyjoCD7ksBuqlJiTjIoaQJ17Gn9Z9mixbjcuftGo32sSKhuPI9tIxaJ6TrTU
        AEJM9Y0RdWYczLhQ0PlGUigNn9I9xIzx5VYfgI3XU3OrXCTPeLi6GZdqg9UuLBwj7GwIEXhKeg0zW
        aRZrKAxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcgIH-00BuPw-3b; Sat, 01 May 2021 03:27:59 +0000
Date:   Sat, 1 May 2021 04:27:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Dave Chinner <david@fromorbit.com>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>, alexs@kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [External] Re: [PATCH 0/9] Shrink the list lru size on memory
 cgroup removal
Message-ID: <20210501032749.GQ1847222@casper.infradead.org>
References: <20210428094949.43579-1-songmuchun@bytedance.com>
 <20210430004903.GF1872259@dread.disaster.area>
 <YItf3GIUs2skeuyi@carbon.dhcp.thefacebook.com>
 <20210430032739.GG1872259@dread.disaster.area>
 <CAMZfGtXawtMT4JfBtDLZ+hES4iEHFboe2UgJee_s-NhZR5faAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtXawtMT4JfBtDLZ+hES4iEHFboe2UgJee_s-NhZR5faAw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 30, 2021 at 04:32:39PM +0800, Muchun Song wrote:
> Before start, we should know about the following rules of list lrus.
> 
> - Only objects allocated with __GFP_ACCOUNT need to allocate
>   the struct list_lru_node.
> - The caller of allocating memory must know which list_lru the
>   object will insert.
> 
> So we can allocate struct list_lru_node when allocating the
> object instead of allocating it when list_lru_add().  It is easy, because
> we already know the list_lru and memcg which the object belongs
> to. So we can introduce a new helper to allocate the object and
> list_lru_node. Like below.

I feel like there may be a simpler solution, although I'm not really
familiar with the list_lru situation.  The three caches you mention:

> I have looked at the code closely. There are 3 different kmem_caches that
> need to use this new API to allocate memory. They are inode_cachep,
> dentry_cache and radix_tree_node_cachep. I think that it is easy to migrate.

are all filesystem.  So if there's a way of knowing which filesystems
are exposed to each container, we can allocate the list_lru structures at
"mount" time rather than at first allocation for a given cache/lru/memcg
combination.

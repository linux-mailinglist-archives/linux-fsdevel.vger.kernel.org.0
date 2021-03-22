Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953E3343B76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 09:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhCVIQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 04:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCVIPr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:15:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DD1C061574;
        Mon, 22 Mar 2021 01:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3UcZ7X0BPfyvpZ2kfhXVZxzYo1lJR/oLtPPQ3opNY70=; b=ZwHWUWpaI1u32wbEwfRB0niJx6
        R9hu8b7S2ayxyCcBkuE7mzDuGi/LOxKIAZAYH7GEgzfk+zxan/+xBkzcXjsMGq5ixffAjANLVgGxX
        KpzYDUMRpTheAPaIPEqRF4Ayek/aEHxPuniOB/PpHBazqTrmyLPKFZ+p6kIwlvfgBqFZc3j1k/1oq
        cqWMRPdKXd0gzEba9MnTvwCtq15zfiR1uYTTIYXBC9cFw4DMCFpAg95vp08L0OEQGgNt5bI8jPmz2
        tEBgey1STuXk7Tw1ConfIoM3wTRfRuUZvJQPCVFUH/0lNCk6dMRlX0wl4DV4LSH6bO5UvT6Dh4+2r
        3rIl3bTg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOFiS-008CCP-TG; Mon, 22 Mar 2021 08:15:15 +0000
Date:   Mon, 22 Mar 2021 08:15:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 3/5] cifsd: add file operations
Message-ID: <20210322081512.GI1719932@casper.infradead.org>
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
 <CGME20210322052207epcas1p3f0a5bdfd2c994a849a67b465479d0721@epcas1p3.samsung.com>
 <20210322051344.1706-4-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322051344.1706-4-namjae.jeon@samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 02:13:42PM +0900, Namjae Jeon wrote:
> This adds file operations and buffer pool for cifsd.

Why do you want this buffer pool?  Do you not trust the
slab allocator to be able to do its job?  Because what you have
here looks slower than the slab allocator.

Let's follow this through for the best-case scenario (a buffer of the right
size already exists):

> +void *ksmbd_find_buffer(size_t size)
> +{
> +	struct wm *wm;
> +
> +	wm = find_wm(size);
> +
> +	WARN_ON(!wm);
> +	if (wm)
> +		return wm->buffer;
> +	return NULL;
> +}

OK, simple, we just call find_wm().

> +static struct wm *find_wm(size_t size)
> +{
> +	struct wm_list *wm_list;
> +	struct wm *wm;
> +
> +	wm_list = match_wm_list(size);

First we find the list for this buffer ...

> +static struct wm_list *match_wm_list(size_t size)
> +{
> +	struct wm_list *l, *rl = NULL;
> +
> +	read_lock(&wm_lists_lock);
> +	list_for_each_entry(l, &wm_lists, list) {
> +		if (l->sz == size) {
> +			rl = l;
> +			break;
> +		}
> +	}
> +	read_unlock(&wm_lists_lock);
> +	return rl;
> +}

... by taking an rwlock, and walking a linked list?!  Uh ...

> +	while (1) {
> +		spin_lock(&wm_list->wm_lock);
> +		if (!list_empty(&wm_list->idle_wm)) {
> +			wm = list_entry(wm_list->idle_wm.next,
> +					struct wm,
> +					list);
> +			list_del(&wm->list);
> +			spin_unlock(&wm_list->wm_lock);
> +			return wm;

Great!  We found one!  And all it cost us was acquiring a global rwlock,
walking a linked list to find a wmlist, then a per-wmlist spinlock.

Meanwhile, there's no guarantee the buffer we found is on the local
NUMA node.

Compare to slub, allocating from a kmem_cache (assuming you create
one for each buffer size ...):

void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
        void *ret = slab_alloc(s, gfpflags, _RET_IP_, s->object_size);

static __always_inline void *slab_alloc(struct kmem_cache *s,
                gfp_t gfpflags, unsigned long addr, size_t orig_size)
        return slab_alloc_node(s, gfpflags, NUMA_NO_NODE, addr, orig_size);

static __always_inline void *slab_alloc_node(struct kmem_cache *s,
                gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
        do {
                tid = this_cpu_read(s->cpu_slab->tid);
                c = raw_cpu_ptr(s->cpu_slab);
        } while (IS_ENABLED(CONFIG_PREEMPTION) &&
                 unlikely(tid != READ_ONCE(c->tid)));
        object = c->freelist;
        page = c->page;
        if (unlikely(!object || !page || !node_match(page, node))) {
                object = __slab_alloc(s, gfpflags, node, addr, c);
        } else {
                void *next_object = get_freepointer_safe(s, object);
                if (unlikely(!this_cpu_cmpxchg_double(
                                s->cpu_slab->freelist, s->cpu_slab->tid,
                                object, tid,
                                next_object, next_tid(tid)))) {

                        note_cmpxchg_failure("slab_alloc", s, tid);
                        goto redo;
                }
                prefetch_freepointer(s, next_object);
                stat(s, ALLOC_FASTPATH);

No lock, anywhere.  Lots of percpu goodness, so you get memory allocated
on your local node.

What's the scenario for which your allocator performs better than slub,
on a typical machine that serves enough SMB that it's worth having an
in-kernel SMBD?


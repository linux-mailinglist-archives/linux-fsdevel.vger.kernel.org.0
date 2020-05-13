Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8E81D0458
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 03:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbgEMBdg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 21:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgEMBdg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 21:33:36 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0C0C061A0C;
        Tue, 12 May 2020 18:33:36 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id b71so7524303ilg.8;
        Tue, 12 May 2020 18:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gHKmLBtj7UP/tLIczhxR7dFm2noy7Ee1n4mkFz8YlHI=;
        b=F5W7N+eDauBw+QcgFXtBRRZhqu6/0nhr9F0ZjOt9JOcQ1ZTcWI2wyoSICuPfEhKpn3
         1+p2bSs4+hE42vQAvyDT+M98c0w2LkjcvilfKrSn/wJquvtalVPh4Ay8LXq44Keptk6v
         te5ri8C05QoTFtZ/1zXq0uIE7+UrgocDbER5YXDOehH1z4b/8uYhUEWC/nthdnC52GaK
         ePgFt60ylSVICmKFd9C+t9naY5cJ8Im6uqu/I+WGX+vy8ocOJkApNP4j0bcHkox5LO8s
         7p2ei2MDQB5HB4aNdF3vj29MBeYT/Cz1EgTFwUd1X7AfhOXhDerNkdqjN2iVJ0O/mCRY
         1YWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gHKmLBtj7UP/tLIczhxR7dFm2noy7Ee1n4mkFz8YlHI=;
        b=FUnDFOHKngsbnz0eqhIdZoYlsMefxErR3C+HuGOtHgDCyoqqFcISh7xOvCINcGK5sC
         HljYXweXvfPAzMYMxk/VPDfCRGULLhlY0IZYkZLfLPXZ26D+oP2YsFq3uFvMhEAFMZNZ
         n1H/D+WGGJPrfGtH1FtXNEuvvjMiYp4v2Dgp/w8ww6uWVxiYHwrW/jPfUIrkFGE4nVy4
         GEmGOncZqNBGlaGZ+rsbjZqc/zdpunQKIf0N3w7zbu3NM4JlVdyhgFZhmn39yZa+KaJW
         1w7e5/kv8BIZYfv1BZMG3wNPxJ2kE3w+wcwA8q+Bl+x3buu3qx/6ike6hHciOmkrFsYg
         R00A==
X-Gm-Message-State: AGi0PuaWKukiGKr5DUqxxALGMhRbAPT0QUwaFAiGcOgnXhsjM8ZEdohb
        Gcv4iPB3JhqI/LD5v65MOu8mm9zq08dX7/cXyZQ=
X-Google-Smtp-Source: APiQypLSUJNUyfaPtQLE1vuvOFcOGSt5K/XBfYNY2ipBm8/iFPAMkpaWQIMjEUbPrehh7+d10XIq2VO6LqebuDRGsk8=
X-Received: by 2002:a92:9e11:: with SMTP id q17mr25076399ili.137.1589333615053;
 Tue, 12 May 2020 18:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200211175507.178100-1-hannes@cmpxchg.org> <20200512212936.GA450429@cmpxchg.org>
In-Reply-To: <20200512212936.GA450429@cmpxchg.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 13 May 2020 09:32:58 +0800
Message-ID: <CALOAHbAZ0eUmrBGt=J0cJZzPmDtPKpfMK0jrUNa0Z_-JfDLoXA@mail.gmail.com>
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker LRU
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 5:29 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Feb 11, 2020 at 12:55:07PM -0500, Johannes Weiner wrote:
> > The VFS inode shrinker is currently allowed to reclaim inodes with
> > populated page cache. As a result it can drop gigabytes of hot and
> > active page cache on the floor without consulting the VM (recorded as
> > "inodesteal" events in /proc/vmstat).
>
> I'm sending a rebased version of this patch.
>
> We've been running with this change in the Facebook fleet since
> February with no ill side effects observed.
>
> However, I just spent several hours chasing a mysterious reclaim
> problem that turned out to be this bug again on an unpatched system.
>
> In the scenario I was debugging, the problem wasn't that we were
> losing cache, but that we were losing the non-resident information for
> previously evicted cache.
>
> I understood the file set enough to know it was thrashing like crazy,
> but it didn't register as refaults to the kernel. Without detecting
> the refaults, reclaim wouldn't start swapping to relieve the
> struggling cache (plenty of cold anon memory around). It also meant
> the IO delays of those refaults didn't contribute to memory pressure
> in psi, which made userspace blind to the situation as well.
>
> The first aspect means we can get stuck in pathological thrashing, the
> second means userspace OOM detection breaks and we can leave servers
> (or Android devices, for that matter) hopelessly livelocked.
>
> New patch attached below. I hope we can get this fixed in 5.8, it's
> really quite a big hole in our cache management strategy.
>
> ---
> From 8db0b846ca0b7a136c0d3d8a1bee3d576990ba11 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Tue, 11 Feb 2020 12:55:07 -0500
> Subject: [PATCH] vfs: keep inodes with page cache off the inode shrinker LRU
>
> The VFS inode shrinker is currently allowed to reclaim cold inodes
> with populated page cache. This behavior goes back to CONFIG_HIGHMEM
> setups, which required the ability to drop page cache in large highem
> zones to free up struct inodes in comparatively tiny lowmem zones.
>
> However, it has significant side effects that are hard to justify on
> systems without highmem:
>
> - It can drop gigabytes of hot and active page cache on the floor
> without consulting the VM (recorded as "inodesteal" events in
> /proc/vmstat). Such an "aging inversion" between unreferenced inodes
> holding hot cache easily happens in practice: for example, a git tree
> whose objects are accessed frequently but no open file descriptors are
> maintained throughout.
>

Hi Johannes,

I think it is reasonable to keep inodes with _active_ page cache off
the inode shrinker LRU, but I'm not sure whether it is proper to keep
the inodes with _only_ inactive page cache off the inode list lru
neither. Per my understanding, if the inode has only inactive page
cache, then invalidate all these inactive page cache could save the
reclaimer's time, IOW, it may improve the performance in this case.

> - It can als prematurely drop non-resident info stored inside the
> inodes, which can let massive cache thrashing go unnoticed. This in
> turn means we're making the wrong decisions in page reclaim and can
> get stuck in pathological thrashing. The thrashing also doesn't show
> up as memory pressure in psi, causing failure in the userspace OOM
> detection chain, which can leave a system (or Android device e.g.)
> stranded in a livelock.
>
> History
>
> As this keeps causing problems for people, there have been several
> attempts to address this.
>
> One recent attempt was to make the inode shrinker simply skip over
> inodes that still contain pages: a76cf1a474d7 ("mm: don't reclaim
> inodes with many attached pages").
>
> However, this change had to be reverted in 69056ee6a8a3 ("Revert "mm:
> don't reclaim inodes with many attached pages"") because it caused
> severe reclaim performance problems: Inodes that sit on the shrinker
> LRU are attracting reclaim pressure away from the page cache and
> toward the VFS. If we then permanently exempt sizable portions of this
> pool from actually getting reclaimed when looked at, this pressure
> accumulates as deferred shrinker work (a mechanism for *temporarily*
> unreclaimable objects) until it causes mayhem in the VFS cache pools.
>
> In the bug quoted in 69056ee6a8a3 in particular, the excessive
> pressure drove the XFS shrinker into dirty objects, where it caused
> synchronous, IO-bound stalls, even as there was plenty of clean page
> cache that should have been reclaimed instead.
>
> Another variant of this problem was recently observed, where the
> kernel violates cgroups' memory.low protection settings and reclaims
> page cache way beyond the configured thresholds. It was followed by a
> proposal of a modified form of the reverted commit above, that
> implements memory.low-sensitive shrinker skipping over populated
> inodes on the LRU [1]. However, this proposal continues to run the
> risk of attracting disproportionate reclaim pressure to a pool of
> still-used inodes, while not addressing the more generic reclaim
> inversion problem outside of a very specific cgroup application.
>
> [1] https://lore.kernel.org/linux-mm/1578499437-1664-1-git-send-email-laoar.shao@gmail.com/
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
>
> - introduce inode_pages_set() and inode_pages_clear() to maintain the
>   inode LRU state from the VM side, then update all cache mutators to
>   use them when populating the first cache entry or clearing the last
>
> With this, the concept of "inodesteal" - where the inode shrinker
> drops page cache - is relegated to CONFIG_HIGHMEM systems only. The VM
> is in charge of the cache, the shrinker in charge of struct inode.
>
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
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  fs/block_dev.c                |   2 +-
>  fs/dax.c                      |  14 +++++
>  fs/drop_caches.c              |   2 +-
>  fs/inode.c                    | 112 +++++++++++++++++++++++++++++++---
>  fs/internal.h                 |   2 +-
>  include/linux/fs.h            |  17 ++++++
>  include/linux/pagemap.h       |   2 +-
>  include/linux/vm_event_item.h |   3 +-
>  mm/filemap.c                  |  37 ++++++++---
>  mm/huge_memory.c              |   3 +-
>  mm/truncate.c                 |  34 ++++++++---
>  mm/vmscan.c                   |   6 +-
>  mm/vmstat.c                   |   4 +-
>  mm/workingset.c               |   4 ++
>  14 files changed, 208 insertions(+), 34 deletions(-)
>
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 4c26dcd9dba3..e0f73647c848 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -79,7 +79,7 @@ void kill_bdev(struct block_device *bdev)
>  {
>         struct address_space *mapping = bdev->bd_inode->i_mapping;
>
> -       if (mapping->nrpages == 0 && mapping->nrexceptional == 0)
> +       if (mapping_empty(mapping))
>                 return;
>
>         invalidate_bh_lrus();
> diff --git a/fs/dax.c b/fs/dax.c
> index 11b16729b86f..89d1245a96ce 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -478,9 +478,11 @@ static void *grab_mapping_entry(struct xa_state *xas,
>  {
>         unsigned long index = xas->xa_index;
>         bool pmd_downgrade = false; /* splitting PMD entry into PTE entries? */
> +       int populated;
>         void *entry;
>
>  retry:
> +       populated = 0;
>         xas_lock_irq(xas);
>         entry = get_unlocked_entry(xas, order);
>
> @@ -526,6 +528,8 @@ static void *grab_mapping_entry(struct xa_state *xas,
>                 xas_store(xas, NULL);   /* undo the PMD join */
>                 dax_wake_entry(xas, entry, true);
>                 mapping->nrexceptional--;
> +               if (mapping_empty(mapping))
> +                       populated = -1;
>                 entry = NULL;
>                 xas_set(xas, index);
>         }
> @@ -541,11 +545,17 @@ static void *grab_mapping_entry(struct xa_state *xas,
>                 dax_lock_entry(xas, entry);
>                 if (xas_error(xas))
>                         goto out_unlock;
> +               if (mapping_empty(mapping))
> +                       populated++;
>                 mapping->nrexceptional++;
>         }
>
>  out_unlock:
>         xas_unlock_irq(xas);
> +       if (populated == -1)
> +               inode_pages_clear(mapping->inode);
> +       else if (populated == 1)
> +               inode_pages_set(mapping->inode);
>         if (xas_nomem(xas, mapping_gfp_mask(mapping) & ~__GFP_HIGHMEM))
>                 goto retry;
>         if (xas->xa_node == XA_ERROR(-ENOMEM))
> @@ -631,6 +641,7 @@ static int __dax_invalidate_entry(struct address_space *mapping,
>                                           pgoff_t index, bool trunc)
>  {
>         XA_STATE(xas, &mapping->i_pages, index);
> +       bool empty = false;
>         int ret = 0;
>         void *entry;
>
> @@ -645,10 +656,13 @@ static int __dax_invalidate_entry(struct address_space *mapping,
>         dax_disassociate_entry(entry, mapping, trunc);
>         xas_store(&xas, NULL);
>         mapping->nrexceptional--;
> +       empty = mapping_empty(mapping);
>         ret = 1;
>  out:
>         put_unlocked_entry(&xas, entry);
>         xas_unlock_irq(&xas);
> +       if (empty)
> +               inode_pages_clear(mapping->host);
>         return ret;
>  }
>
> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> index f00fcc4a4f72..20e845ff43f2 100644
> --- a/fs/drop_caches.c
> +++ b/fs/drop_caches.c
> @@ -27,7 +27,7 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
>                  * we need to reschedule to avoid softlockups.
>                  */
>                 if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
> -                   (inode->i_mapping->nrpages == 0 && !need_resched())) {
> +                   (mapping_empty(inode->i_mapping) && !need_resched())) {
>                         spin_unlock(&inode->i_lock);
>                         continue;
>                 }
> diff --git a/fs/inode.c b/fs/inode.c
> index 9fcec07a9d7c..9da373244db7 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -431,26 +431,101 @@ static void inode_lru_list_add(struct inode *inode)
>                 inode->i_state |= I_REFERENCED;
>  }
>
> +static void inode_lru_list_del(struct inode *inode)
> +{
> +       if (list_lru_del(&inode->i_sb->s_inode_lru, &inode->i_lru))
> +               this_cpu_dec(nr_unused);
> +}
> +
>  /*
>   * Add inode to LRU if needed (inode is unused and clean).
>   *
>   * Needs inode->i_lock held.
>   */
> -void inode_add_lru(struct inode *inode)
> +bool inode_add_lru(struct inode *inode)
>  {
> -       if (!(inode->i_state & (I_DIRTY_ALL | I_SYNC |
> -                               I_FREEING | I_WILL_FREE)) &&
> -           !atomic_read(&inode->i_count) && inode->i_sb->s_flags & SB_ACTIVE)
> -               inode_lru_list_add(inode);
> +       if (inode->i_state &
> +           (I_DIRTY_ALL | I_SYNC | I_FREEING | I_WILL_FREE | I_PAGES))
> +               return false;
> +       if (atomic_read(&inode->i_count))
> +               return false;
> +       if (!(inode->i_sb->s_flags & SB_ACTIVE))
> +               return false;
> +       inode_lru_list_add(inode);
> +       return true;
>  }
>
> +/*
> + * Usually, inodes become reclaimable when they are no longer
> + * referenced and their page cache has been reclaimed. The following
> + * API allows the VM to communicate cache population state to the VFS.
> + *
> + * However, on CONFIG_HIGHMEM we can't wait for the page cache to go
> + * away: cache pages allocated in a large highmem zone could pin
> + * struct inode memory allocated in relatively small lowmem zones. So
> + * when CONFIG_HIGHMEM is enabled, we tie cache to the inode lifetime.
> + */
>
> -static void inode_lru_list_del(struct inode *inode)
> +#ifndef CONFIG_HIGHMEM
> +/**
> + * inode_pages_set - mark the inode as holding page cache
> + * @inode: the inode whose first cache page was just added
> + *
> + * Tell the VFS that this inode has populated page cache and must not
> + * be reclaimed by the inode shrinker.
> + *
> + * The caller must hold the page lock of the just-added page: by
> + * pinning the page, the page cache cannot become depopulated, and we
> + * can safely set I_PAGES without a race check under the i_pages lock.
> + *
> + * This function acquires the i_lock.
> + */
> +void inode_pages_set(struct inode *inode)
>  {
> +       spin_lock(&inode->i_lock);
> +       if (!(inode->i_state & I_PAGES)) {
> +               inode->i_state |= I_PAGES;
> +               if (!list_empty(&inode->i_lru)) {
> +                       count_vm_event(PGINODERESCUE);
> +                       inode_lru_list_del(inode);
> +               }
> +       }
> +       spin_unlock(&inode->i_lock);
> +}
>
> -       if (list_lru_del(&inode->i_sb->s_inode_lru, &inode->i_lru))
> -               this_cpu_dec(nr_unused);
> +/**
> + * inode_pages_clear - mark the inode as not holding page cache
> + * @inode: the inode whose last cache page was just removed
> + *
> + * Tell the VFS that the inode no longer holds page cache and that its
> + * lifetime is to be handed over to the inode shrinker LRU.
> + *
> + * This function acquires the i_lock and the i_pages lock.
> + */
> +void inode_pages_clear(struct inode *inode)
> +{
> +       struct address_space *mapping = &inode->i_data;
> +       bool add_to_lru = false;
> +       unsigned long flags;
> +
> +       spin_lock(&inode->i_lock);
> +
> +       xa_lock_irqsave(&mapping->i_pages, flags);
> +       if ((inode->i_state & I_PAGES) && mapping_empty(mapping)) {
> +               inode->i_state &= ~I_PAGES;
> +               add_to_lru = true;
> +       }
> +       xa_unlock_irqrestore(&mapping->i_pages, flags);
> +
> +       if (add_to_lru) {
> +               WARN_ON_ONCE(!list_empty(&inode->i_lru));
> +               if (inode_add_lru(inode))
> +                       __count_vm_event(PGINODEDELAYED);
> +       }
> +
> +       spin_unlock(&inode->i_lock);
>  }
> +#endif /* !CONFIG_HIGHMEM */
>
>  /**
>   * inode_sb_list_add - add inode to the superblock list of inodes
> @@ -743,6 +818,8 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>         if (!spin_trylock(&inode->i_lock))
>                 return LRU_SKIP;
>
> +       WARN_ON_ONCE(inode->i_state & I_PAGES);
> +
>         /*
>          * Referenced or dirty inodes are still in use. Give them another pass
>          * through the LRU as we canot reclaim them now.
> @@ -762,7 +839,18 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>                 return LRU_ROTATE;
>         }
>
> -       if (inode_has_buffers(inode) || inode->i_data.nrpages) {
> +       /*
> +        * Usually, populated inodes shouldn't be on the shrinker LRU,
> +        * but they can be briefly visible when a new page is added to
> +        * an inode that was already linked but inode_pages_set()
> +        * hasn't run yet to move them off.
> +        *
> +        * The other exception is on HIGHMEM systems: highmem cache
> +        * can pin lowmem struct inodes, and we might be in dire
> +        * straits in the lower zones. Purge cache to free the inode.
> +        */
> +       if (inode_has_buffers(inode) || !mapping_empty(&inode->i_data)) {
> +#ifdef CONFIG_HIGHMEM
>                 __iget(inode);
>                 spin_unlock(&inode->i_lock);
>                 spin_unlock(lru_lock);
> @@ -779,6 +867,12 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>                 iput(inode);
>                 spin_lock(lru_lock);
>                 return LRU_RETRY;
> +#else
> +               list_lru_isolate(lru, &inode->i_lru);
> +               spin_unlock(&inode->i_lock);
> +               this_cpu_dec(nr_unused);
> +               return LRU_REMOVED;
> +#endif
>         }
>
>         WARN_ON(inode->i_state & I_NEW);
> diff --git a/fs/internal.h b/fs/internal.h
> index aa5d45524e87..2ca77c0afb0b 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -137,7 +137,7 @@ extern int vfs_open(const struct path *, struct file *);
>   * inode.c
>   */
>  extern long prune_icache_sb(struct super_block *sb, struct shrink_control *sc);
> -extern void inode_add_lru(struct inode *inode);
> +extern bool inode_add_lru(struct inode *inode);
>  extern int dentry_needs_remove_privs(struct dentry *dentry);
>
>  /*
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e4a1f28435fe..c3137ee87cb2 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -592,6 +592,11 @@ static inline void mapping_allow_writable(struct address_space *mapping)
>         atomic_inc(&mapping->i_mmap_writable);
>  }
>
> +static inline bool mapping_empty(struct address_space *mapping)
> +{
> +       return mapping->nrpages + mapping->nrexceptional == 0;
> +}
> +
>  /*
>   * Use sequence counter to get consistent i_size on 32-bit processors.
>   */
> @@ -2165,6 +2170,9 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
>   *
>   * I_CREATING          New object's inode in the middle of setting up.
>   *
> + * I_PAGES             Inode is holding page cache that needs to get reclaimed
> + *                     first before the inode can go onto the shrinker LRU.
> + *
>   * Q: What is the difference between I_WILL_FREE and I_FREEING?
>   */
>  #define I_DIRTY_SYNC           (1 << 0)
> @@ -2187,6 +2195,7 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
>  #define I_WB_SWITCH            (1 << 13)
>  #define I_OVL_INUSE            (1 << 14)
>  #define I_CREATING             (1 << 15)
> +#define I_PAGES                        (1 << 16)
>
>  #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
>  #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
> @@ -3124,6 +3133,14 @@ static inline void remove_inode_hash(struct inode *inode)
>                 __remove_inode_hash(inode);
>  }
>
> +#ifndef CONFIG_HIGHMEM
> +extern void inode_pages_set(struct inode *inode);
> +extern void inode_pages_clear(struct inode *inode);
> +#else
> +static inline void inode_pages_set(struct inode *inode) {}
> +static inline void inode_pages_clear(struct inode *inode) {}
> +#endif
> +
>  extern void inode_sb_list_add(struct inode *inode);
>
>  #ifdef CONFIG_BLOCK
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index c6348c50136f..c3646b79489e 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -613,7 +613,7 @@ int add_to_page_cache_locked(struct page *page, struct address_space *mapping,
>  int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
>                                 pgoff_t index, gfp_t gfp_mask);
>  extern void delete_from_page_cache(struct page *page);
> -extern void __delete_from_page_cache(struct page *page, void *shadow);
> +extern bool __delete_from_page_cache(struct page *page, void *shadow);
>  int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask);
>  void delete_from_page_cache_batch(struct address_space *mapping,
>                                   struct pagevec *pvec);
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index ffef0f279747..de362c9cda29 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -38,7 +38,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  #ifdef CONFIG_NUMA
>                 PGSCAN_ZONE_RECLAIM_FAILED,
>  #endif
> -               PGINODESTEAL, SLABS_SCANNED, KSWAPD_INODESTEAL,
> +               SLABS_SCANNED,
> +               PGINODESTEAL, KSWAPD_INODESTEAL, PGINODERESCUE, PGINODEDELAYED,
>                 KSWAPD_LOW_WMARK_HIT_QUICKLY, KSWAPD_HIGH_WMARK_HIT_QUICKLY,
>                 PAGEOUTRUN, PGROTATED,
>                 DROP_PAGECACHE, DROP_SLAB,
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 792e22e1e3c0..9cc423dcb16c 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -116,8 +116,8 @@
>   *   ->tasklist_lock            (memory_failure, collect_procs_ao)
>   */
>
> -static void page_cache_delete(struct address_space *mapping,
> -                                  struct page *page, void *shadow)
> +static bool __must_check page_cache_delete(struct address_space *mapping,
> +                                          struct page *page, void *shadow)
>  {
>         XA_STATE(xas, &mapping->i_pages, page->index);
>         unsigned int nr = 1;
> @@ -151,6 +151,8 @@ static void page_cache_delete(struct address_space *mapping,
>                 smp_wmb();
>         }
>         mapping->nrpages -= nr;
> +
> +       return mapping_empty(mapping);
>  }
>
>  static void unaccount_page_cache_page(struct address_space *mapping,
> @@ -227,15 +229,18 @@ static void unaccount_page_cache_page(struct address_space *mapping,
>   * Delete a page from the page cache and free it. Caller has to make
>   * sure the page is locked and that nobody else uses it - or that usage
>   * is safe.  The caller must hold the i_pages lock.
> + *
> + * If this returns true, the caller must call inode_pages_clear()
> + * after dropping the i_pages lock.
>   */
> -void __delete_from_page_cache(struct page *page, void *shadow)
> +bool __must_check __delete_from_page_cache(struct page *page, void *shadow)
>  {
>         struct address_space *mapping = page->mapping;
>
>         trace_mm_filemap_delete_from_page_cache(page);
>
>         unaccount_page_cache_page(mapping, page);
> -       page_cache_delete(mapping, page, shadow);
> +       return page_cache_delete(mapping, page, shadow);
>  }
>
>  static void page_cache_free_page(struct address_space *mapping,
> @@ -267,12 +272,16 @@ void delete_from_page_cache(struct page *page)
>  {
>         struct address_space *mapping = page_mapping(page);
>         unsigned long flags;
> +       bool empty;
>
>         BUG_ON(!PageLocked(page));
>         xa_lock_irqsave(&mapping->i_pages, flags);
> -       __delete_from_page_cache(page, NULL);
> +       empty = __delete_from_page_cache(page, NULL);
>         xa_unlock_irqrestore(&mapping->i_pages, flags);
>
> +       if (empty)
> +               inode_pages_clear(mapping->host);
> +
>         page_cache_free_page(mapping, page);
>  }
>  EXPORT_SYMBOL(delete_from_page_cache);
> @@ -291,8 +300,8 @@ EXPORT_SYMBOL(delete_from_page_cache);
>   *
>   * The function expects the i_pages lock to be held.
>   */
> -static void page_cache_delete_batch(struct address_space *mapping,
> -                            struct pagevec *pvec)
> +static bool __must_check page_cache_delete_batch(struct address_space *mapping,
> +                                                struct pagevec *pvec)
>  {
>         XA_STATE(xas, &mapping->i_pages, pvec->pages[0]->index);
>         int total_pages = 0;
> @@ -337,12 +346,15 @@ static void page_cache_delete_batch(struct address_space *mapping,
>                 total_pages++;
>         }
>         mapping->nrpages -= total_pages;
> +
> +       return mapping_empty(mapping);
>  }
>
>  void delete_from_page_cache_batch(struct address_space *mapping,
>                                   struct pagevec *pvec)
>  {
>         int i;
> +       bool empty;
>         unsigned long flags;
>
>         if (!pagevec_count(pvec))
> @@ -354,9 +366,12 @@ void delete_from_page_cache_batch(struct address_space *mapping,
>
>                 unaccount_page_cache_page(mapping, pvec->pages[i]);
>         }
> -       page_cache_delete_batch(mapping, pvec);
> +       empty = page_cache_delete_batch(mapping, pvec);
>         xa_unlock_irqrestore(&mapping->i_pages, flags);
>
> +       if (empty)
> +               inode_pages_clear(mapping->host);
> +
>         for (i = 0; i < pagevec_count(pvec); i++)
>                 page_cache_free_page(mapping, pvec->pages[i]);
>  }
> @@ -833,6 +848,7 @@ static int __add_to_page_cache_locked(struct page *page,
>  {
>         XA_STATE(xas, &mapping->i_pages, offset);
>         int huge = PageHuge(page);
> +       bool populated = false;
>         int error;
>         void *old;
>
> @@ -859,6 +875,7 @@ static int __add_to_page_cache_locked(struct page *page,
>                 if (xas_error(&xas))
>                         goto unlock;
>
> +               populated = mapping_empty(mapping);
>                 if (xa_is_value(old)) {
>                         mapping->nrexceptional--;
>                         if (shadowp)
> @@ -879,6 +896,10 @@ static int __add_to_page_cache_locked(struct page *page,
>         }
>
>         trace_mm_filemap_add_to_page_cache(page);
> +
> +       if (populated)
> +               inode_pages_set(mapping->host);
> +
>         return 0;
>  error:
>         page->mapping = NULL;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 23763452b52a..fbe9a7297759 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2406,7 +2406,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>                 /* Some pages can be beyond i_size: drop them from page cache */
>                 if (head[i].index >= end) {
>                         ClearPageDirty(head + i);
> -                       __delete_from_page_cache(head + i, NULL);
> +                       /* We know we're not removing the last page */
> +                       (void)__delete_from_page_cache(head + i, NULL);
>                         if (IS_ENABLED(CONFIG_SHMEM) && PageSwapBacked(head))
>                                 shmem_uncharge(head->mapping->host, 1);
>                         put_page(head + i);
> diff --git a/mm/truncate.c b/mm/truncate.c
> index dd9ebc1da356..8fb6c2f762bc 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -31,24 +31,31 @@
>   * itself locked.  These unlocked entries need verification under the tree
>   * lock.
>   */
> -static inline void __clear_shadow_entry(struct address_space *mapping,
> -                               pgoff_t index, void *entry)
> +static bool __must_check __clear_shadow_entry(struct address_space *mapping,
> +                                             pgoff_t index, void *entry)
>  {
>         XA_STATE(xas, &mapping->i_pages, index);
>
>         xas_set_update(&xas, workingset_update_node);
>         if (xas_load(&xas) != entry)
> -               return;
> +               return 0;
>         xas_store(&xas, NULL);
>         mapping->nrexceptional--;
> +
> +       return mapping_empty(mapping);
>  }
>
>  static void clear_shadow_entry(struct address_space *mapping, pgoff_t index,
>                                void *entry)
>  {
> +       bool empty;
> +
>         xa_lock_irq(&mapping->i_pages);
> -       __clear_shadow_entry(mapping, index, entry);
> +       empty = __clear_shadow_entry(mapping, index, entry);
>         xa_unlock_irq(&mapping->i_pages);
> +
> +       if (empty)
> +               inode_pages_clear(mapping->host);
>  }
>
>  /*
> @@ -61,7 +68,7 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
>                                 pgoff_t end)
>  {
>         int i, j;
> -       bool dax, lock;
> +       bool dax, lock, empty = false;
>
>         /* Handled by shmem itself */
>         if (shmem_mapping(mapping))
> @@ -96,11 +103,16 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
>                         continue;
>                 }
>
> -               __clear_shadow_entry(mapping, index, page);
> +               if (__clear_shadow_entry(mapping, index, page))
> +                       empty = true;
>         }
>
>         if (lock)
>                 xa_unlock_irq(&mapping->i_pages);
> +
> +       if (empty)
> +               inode_pages_clear(mapping->host);
> +
>         pvec->nr = j;
>  }
>
> @@ -300,7 +312,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
>         pgoff_t         index;
>         int             i;
>
> -       if (mapping->nrpages == 0 && mapping->nrexceptional == 0)
> +       if (mapping_empty(mapping))
>                 goto out;
>
>         /* Offsets within partial pages */
> @@ -636,6 +648,7 @@ static int
>  invalidate_complete_page2(struct address_space *mapping, struct page *page)
>  {
>         unsigned long flags;
> +       bool empty;
>
>         if (page->mapping != mapping)
>                 return 0;
> @@ -648,9 +661,12 @@ invalidate_complete_page2(struct address_space *mapping, struct page *page)
>                 goto failed;
>
>         BUG_ON(page_has_private(page));
> -       __delete_from_page_cache(page, NULL);
> +       empty = __delete_from_page_cache(page, NULL);
>         xa_unlock_irqrestore(&mapping->i_pages, flags);
>
> +       if (empty)
> +               inode_pages_clear(mapping->host);
> +
>         if (mapping->a_ops->freepage)
>                 mapping->a_ops->freepage(page);
>
> @@ -692,7 +708,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
>         int ret2 = 0;
>         int did_range_unmap = 0;
>
> -       if (mapping->nrpages == 0 && mapping->nrexceptional == 0)
> +       if (mapping_empty(mapping))
>                 goto out;
>
>         pagevec_init(&pvec);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index cc555903a332..2ae2df605006 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -901,6 +901,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
>         } else {
>                 void (*freepage)(struct page *);
>                 void *shadow = NULL;
> +               int empty;
>
>                 freepage = mapping->a_ops->freepage;
>                 /*
> @@ -922,9 +923,12 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
>                 if (reclaimed && page_is_file_lru(page) &&
>                     !mapping_exiting(mapping) && !dax_mapping(mapping))
>                         shadow = workingset_eviction(page, target_memcg);
> -               __delete_from_page_cache(page, shadow);
> +               empty = __delete_from_page_cache(page, shadow);
>                 xa_unlock_irqrestore(&mapping->i_pages, flags);
>
> +               if (empty)
> +                       inode_pages_clear(mapping->host);
> +
>                 if (freepage != NULL)
>                         freepage(page);
>         }
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 35219271796f..0fdbec92265a 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1205,9 +1205,11 @@ const char * const vmstat_text[] = {
>  #ifdef CONFIG_NUMA
>         "zone_reclaim_failed",
>  #endif
> -       "pginodesteal",
>         "slabs_scanned",
> +       "pginodesteal",
>         "kswapd_inodesteal",
> +       "pginoderescue",
> +       "pginodedelayed",
>         "kswapd_low_wmark_hit_quickly",
>         "kswapd_high_wmark_hit_quickly",
>         "pageoutrun",
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 474186b76ced..7ce9c74ebfdb 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -491,6 +491,7 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
>         struct xa_node *node = container_of(item, struct xa_node, private_list);
>         XA_STATE(xas, node->array, 0);
>         struct address_space *mapping;
> +       bool empty = false;
>         int ret;
>
>         /*
> @@ -529,6 +530,7 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
>         if (WARN_ON_ONCE(node->count != node->nr_values))
>                 goto out_invalid;
>         mapping->nrexceptional -= node->nr_values;
> +       empty = mapping_empty(mapping);
>         xas.xa_node = xa_parent_locked(&mapping->i_pages, node);
>         xas.xa_offset = node->offset;
>         xas.xa_shift = node->shift + XA_CHUNK_SHIFT;
> @@ -542,6 +544,8 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
>
>  out_invalid:
>         xa_unlock_irq(&mapping->i_pages);
> +       if (empty)
> +               inode_pages_clear(mapping->host);
>         ret = LRU_REMOVED_RETRY;
>  out:
>         cond_resched();
> --
> 2.26.2
>


-- 
Thanks
Yafang

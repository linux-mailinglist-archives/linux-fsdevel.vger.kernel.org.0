Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD0915AD7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 17:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgBLQfo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 11:35:44 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34211 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbgBLQfo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 11:35:44 -0500
Received: by mail-qv1-f68.google.com with SMTP id o18so1211135qvf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2020 08:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ErEqPgupRH9qwXigutRb5nRU2tSqdRNtaUNrXot3qOY=;
        b=0FY3OSQjod8BNoUEE6WvqGkSCWhPWM3K8BmwU/xQaGFTN8p9yFt2mHhxAOX75eeZyk
         DVMjTyvPE8pvY2ZqP64Brq457RoQ6jYk1pKorcRKj8GJJD4sHvICh9n1uJUGRnV3Vr5V
         sdn784FgS9mZtHy5hvfaIwQJDVfTOIW7bbCmJNTVPmRvAICfTREbDWXf59G0ZS6x4XhA
         Nsks2kBCro1QtPJaPIAuk3GR4iKPqaX6AJyEWTYDqXAP4MJbuMBYWExSjtJj00capEQR
         1/gvmrdfzH2Jxgq9V98XVBX8JND00CcKBROg6UOCiB7q62uZdSEL9KTIsMjoEIyT6TTD
         YQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ErEqPgupRH9qwXigutRb5nRU2tSqdRNtaUNrXot3qOY=;
        b=SCMai2M8p+GjPVBLdPmazgh7Jg1nyte6ZHZW7IwkIH+nhvt0fLeiU7+8j0M3jEdSac
         0pQIPZqeW9WsRcUkg/VnD2ptVrIkC/EuFPuHVyCcAz5j1++1l3XXHX/ytJGe+x1tD3YW
         oPr/9vYry5ednvLiitwKXoqjNaiSZ3EwrtfhGgN7zM4FB+czoh0LKTuACmfAzn1OcFcv
         QkrljGd4aRTsw2658s7gJpRNob4i805AAbf47pnaswwp55u0If42A3KRveCD6JhJDr9v
         dOS6YWqQCYe++7sHaIWiCf5dnWHPebYGKP4NmhZRXLTkZi1+o26+szoCBez/KlTcNNyX
         qH5w==
X-Gm-Message-State: APjAAAWUkEWnGZVu5mQyfZ6Yu/47A1h/Hl/P6DCMgwpsbokHu1juIEJN
        rBhF2N24xWhADfDBWc2zNuHfgg==
X-Google-Smtp-Source: APXvYqwUxExxKSsaixRm6IofspdH+NUspdRSMq4om9NxqPMEW40z/llLitVs6aIvlb+AwVfAPgGiKg==
X-Received: by 2002:a05:6214:108a:: with SMTP id o10mr7757297qvr.246.1581525342222;
        Wed, 12 Feb 2020 08:35:42 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:26be])
        by smtp.gmail.com with ESMTPSA id v78sm469947qkb.48.2020.02.12.08.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 08:35:41 -0800 (PST)
Date:   Wed, 12 Feb 2020 11:35:40 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rik van Riel <riel@surriel.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
Message-ID: <20200212163540.GA180867@cmpxchg.org>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
 <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
 <20200211193101.GA178975@cmpxchg.org>
 <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 03:44:38PM -0800, Andrew Morton wrote:
> On Tue, 11 Feb 2020 14:31:01 -0500 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > On Tue, Feb 11, 2020 at 02:05:38PM -0500, Rik van Riel wrote:
> > > On Tue, 2020-02-11 at 12:55 -0500, Johannes Weiner wrote:
> > > > The VFS inode shrinker is currently allowed to reclaim inodes with
> > > > populated page cache. As a result it can drop gigabytes of hot and
> > > > active page cache on the floor without consulting the VM (recorded as
> > > > "inodesteal" events in /proc/vmstat).
> > > > 
> > > > This causes real problems in practice. Consider for example how the
> > > > VM
> > > > would cache a source tree, such as the Linux git tree. As large parts
> > > > of the checked out files and the object database are accessed
> > > > repeatedly, the page cache holding this data gets moved to the active
> > > > list, where it's fully (and indefinitely) insulated from one-off
> > > > cache
> > > > moving through the inactive list.
> > > 
> > > > This behavior of invalidating page cache from the inode shrinker goes
> > > > back to even before the git import of the kernel tree. It may have
> > > > been less noticeable when the VM itself didn't have real workingset
> > > > protection, and floods of one-off cache would push out any active
> > > > cache over time anyway. But the VM has come a long way since then and
> > > > the inode shrinker is now actively subverting its caching strategy.
> > > 
> > > Two things come to mind when looking at this:
> > > - highmem
> > > - NUMA
> > > 
> > > IIRC one of the reasons reclaim is done in this way is
> > > because a page cache page in one area of memory (highmem,
> > > or a NUMA node) can end up pinning inode slab memory in
> > > another memory area (normal zone, other NUMA node).
> > 
> > That's a good point, highmem does ring a bell now that you mention it.
> 
> Yup, that's why this mechanism exists.  Here:
> 
> https://marc.info/?l=git-commits-head&m=103646757213266&w=2

Ah, thanks for digging that up, I did not know that.

> > If we still care, I think this could be solved by doing something
> > similar to what we do with buffer_heads_over_limit: allow a lowmem
> > allocation to reclaim page cache inside the highmem zone if the bhs
> > (or inodes in this case) have accumulated excessively.
> 
> Well, reclaiming highmem pagecache at random would be a painful way to
> reclaim lowmem inodes.  Better to pick an inode then shoot down all its
> pagecache.  Perhaps we could take its pagecache's aging into account.

That reminds me of trying to correlate inode pages in reclaim to batch
the cache tree lock, slab page objects in the shrinker to free whole
pages etc. We never managed to actually do that. :-)

> Testing this will be a challenge, but the issue was real - a 7GB
> highmem machine isn't crazy and I expect the inode has become larger
> since those days.

Since the cache purging code was written for highmem scenarios, how
about making it specific to CONFIG_HIGHMEM at least?

That way we improve the situation for the more common setups, without
regressing highmem configurations. And if somebody wanted to improve
the CONFIG_HIGHMEM behavior as well, they could still do so.

Somethig like the below delta on top of my patch?

---
 fs/inode.c         | 44 ++++++++++++++++++++++++++++++++++++++++----
 include/linux/fs.h |  5 +++++
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 575b780fa9bb..45b2abd4fef6 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -454,6 +454,18 @@ bool inode_add_lru(struct inode *inode)
 	return true;
 }
 
+/*
+ * Usually, inodes become reclaimable when they are no longer
+ * referenced and their page cache has been reclaimed. The following
+ * API allows the VM to communicate cache population state to the VFS.
+ *
+ * However, on CONFIG_HIGHMEM we can't wait for the page cache to go
+ * away: cache pages allocated in a large highmem zone could pin
+ * struct inode memory allocated in relatively small lowmem zones. So
+ * when CONFIG_HIGHMEM is enabled, we tie cache to the inode lifetime.
+ */
+
+#ifndef CONFIG_HIGHMEM
 /**
  * inode_pages_set - mark the inode as holding page cache
  * @inode: the inode whose first cache page was just added
@@ -512,6 +524,7 @@ void inode_pages_clear(struct inode *inode)
 
 	spin_unlock(&inode->i_lock);
 }
+#endif /* !CONFIG_HIGHMEM */
 
 /**
  * inode_sb_list_add - add inode to the superblock list of inodes
@@ -826,16 +839,39 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	}
 
 	/*
-	 * Populated inodes shouldn't be on the shrinker LRU, but they
-	 * can be briefly visible when a new page is added to an inode
-	 * that was already linked but inode_pages_set() hasn't run
-	 * yet to move them off.
+	 * Usually, populated inodes shouldn't be on the shrinker LRU,
+	 * but they can be briefly visible when a new page is added to
+	 * an inode that was already linked but inode_pages_set()
+	 * hasn't run yet to move them off.
+	 *
+	 * The other exception is on HIGHMEM systems: highmem cache
+	 * can pin lowmem struct inodes, and we might be in dire
+	 * straits in the lower zones. Purge cache to free the inode.
 	 */
 	if (inode_has_buffers(inode) || !mapping_empty(&inode->i_data)) {
+#ifdef CONFIG_HIGHMEM
+		__iget(inode);
+		spin_unlock(&inode->i_lock);
+		spin_unlock(lru_lock);
+		if (remove_inode_buffers(inode)) {
+			unsigned long reap;
+			reap = invalidate_mapping_pages(&inode->i_data, 0, -1);
+			if (current_is_kswapd())
+				__count_vm_events(KSWAPD_INODESTEAL, reap);
+			else
+				__count_vm_events(PGINODESTEAL, reap);
+			if (current->reclaim_state)
+				current->reclaim_state->reclaimed_slab += reap;
+		}
+		iput(inode);
+		spin_lock(lru_lock);
+		return LRU_RETRY;
+#else
 		list_lru_isolate(lru, &inode->i_lru);
 		spin_unlock(&inode->i_lock);
 		this_cpu_dec(nr_unused);
 		return LRU_REMOVED;
+#endif
 	}
 
 	WARN_ON(inode->i_state & I_NEW);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a98d9dee39f4..abdb3fd3432f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3106,8 +3106,13 @@ static inline void remove_inode_hash(struct inode *inode)
 		__remove_inode_hash(inode);
 }
 
+#ifndef CONFIG_HIGHMEM
 extern void inode_pages_set(struct inode *inode);
 extern void inode_pages_clear(struct inode *inode);
+#else
+static inline void inode_pages_set(struct inode *inode) {}
+static inline void inode_pages_clear(struct inode *inode) {}
+#endif
 
 extern void inode_sb_list_add(struct inode *inode);
 
-- 
2.24.1


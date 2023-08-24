Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE697786662
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239874AbjHXDxY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239877AbjHXDw3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:52:29 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0711FD7
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:50:44 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a8586813cfso655960b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692849007; x=1693453807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bj97+7kRuzjBy8tIew3M4TNtnbEno9Wuan+4JTlpSSQ=;
        b=Pf6vNHkcB1vA+6pxbgxqpCgxpTQyk2TtDM/one3T/7C2oTeNlkoEFdQ0L+WsmL9Y+q
         BjBv6VhRRLZdvemmxw4SoGo8giABbtk+hJjbUvzD9xKbM+F06wn4gwW4u8zm7429LXth
         3CAeLPVtrqyhJ+pNzZ27ujBXU6T0SdwYWU6AYQtLaBCIKMUwWo2tehQ59lXNTJxqwpjh
         QSCHxH4GcVwROqRsmcJ4PYqES36W4oSEATQLnGYrVdSRQTVs+xacMGyzpMR7Luxhok1d
         CDFJezReHQORkNLmpGGdLCVlNbqFm8Htz4v8L6Gp82964pbV+f9rHsaB4MwdgXLHjtpQ
         t6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692849007; x=1693453807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bj97+7kRuzjBy8tIew3M4TNtnbEno9Wuan+4JTlpSSQ=;
        b=FKZCAAzywgP58S8okeHjzYNZx5btSditLlXB4D1Hm/avHn1Xd++/ODIVWqekfC+HsG
         TlkvhwUu2mh7ZhsG12fa776iCSp+3lLrv46++bXZmkNEA6DXoabgZY4hp06pS/NaJ951
         Ugbfhu/SRKxJG/u8keHNp2fGvM8h232M5FR9Bvpnj+gm/vKIAyz5tFfMF8/4Cx1w4+xj
         g0k3m6/HHvJhG0lx+JfMQr5ygLAATD6shSWbkhIpR8//i9nWm4n7YGYKAh0TvFxKxdMH
         8wWvirgX7fyt42M91LJKHgnPpyJTZgZhxjW+aKtCxUQYtibVkcDnhzx4K6jWD9tRmOY+
         Q/fA==
X-Gm-Message-State: AOJu0YwgTJG3OGyQoqS7k3t1BPXEWXpyMr8bi/Qk7mCGY45zrnaan23q
        /aLSfdzjcGjuw74BYOaFYRDSbQ==
X-Google-Smtp-Source: AGHT+IFy9m7FV74PRUXhk8NrRebE6Bg/bLzhyLzquzwrzg4LwcJGIL+HBXsvf05OcawJkJTA6sAEMQ==
X-Received: by 2002:a05:6808:30a7:b0:3a7:2eb4:ce04 with SMTP id bl39-20020a05680830a700b003a72eb4ce04mr17486035oib.5.1692849007231;
        Wed, 23 Aug 2023 20:50:07 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:50:06 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v5 43/45] mm: shrinker: make memcg slab shrink lockless
Date:   Thu, 24 Aug 2023 11:43:02 +0800
Message-Id: <20230824034304.37411-44-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Like global slab shrink, this commit also uses refcount+RCU method to make
memcg slab shrink lockless.

Use the following script to do slab shrink stress test:

```

DIR="/root/shrinker/memcg/mnt"

do_create()
{
    mkdir -p /sys/fs/cgroup/memory/test
    echo 4G > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
    for i in `seq 0 $1`;
    do
        mkdir -p /sys/fs/cgroup/memory/test/$i;
        echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
        mkdir -p $DIR/$i;
    done
}

do_mount()
{
    for i in `seq $1 $2`;
    do
        mount -t tmpfs $i $DIR/$i;
    done
}

do_touch()
{
    for i in `seq $1 $2`;
    do
        echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
        dd if=/dev/zero of=$DIR/$i/file$i bs=1M count=1 &
    done
}

case "$1" in
  touch)
    do_touch $2 $3
    ;;
  test)
    do_create 4000
    do_mount 0 4000
    do_touch 0 3000
    ;;
  *)
    exit 1
    ;;
esac
```

Save the above script, then run test and touch commands. Then we can use
the following perf command to view hotspots:

perf top -U -F 999

1) Before applying this patchset:

  40.44%  [kernel]            [k] down_read_trylock
  17.59%  [kernel]            [k] up_read
  13.64%  [kernel]            [k] pv_native_safe_halt
  11.90%  [kernel]            [k] shrink_slab
   8.21%  [kernel]            [k] idr_find
   2.71%  [kernel]            [k] _find_next_bit
   1.36%  [kernel]            [k] shrink_node
   0.81%  [kernel]            [k] shrink_lruvec
   0.80%  [kernel]            [k] __radix_tree_lookup
   0.50%  [kernel]            [k] do_shrink_slab
   0.21%  [kernel]            [k] list_lru_count_one
   0.16%  [kernel]            [k] mem_cgroup_iter

2) After applying this patchset:

  60.17%  [kernel]           [k] shrink_slab
  20.42%  [kernel]           [k] pv_native_safe_halt
   3.03%  [kernel]           [k] do_shrink_slab
   2.73%  [kernel]           [k] shrink_node
   2.27%  [kernel]           [k] shrink_lruvec
   2.00%  [kernel]           [k] __rcu_read_unlock
   1.92%  [kernel]           [k] mem_cgroup_iter
   0.98%  [kernel]           [k] __rcu_read_lock
   0.91%  [kernel]           [k] osq_lock
   0.63%  [kernel]           [k] mem_cgroup_calculate_protection
   0.55%  [kernel]           [k] shrinker_put
   0.46%  [kernel]           [k] list_lru_count_one

We can see that the first perf hotspot becomes shrink_slab, which is what
we expect.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/shrinker.c | 85 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 19 deletions(-)

diff --git a/mm/shrinker.c b/mm/shrinker.c
index 2b8c1f1bbf2d..a66e2a30cc16 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -218,7 +218,6 @@ static int shrinker_memcg_alloc(struct shrinker *shrinker)
 		return -ENOSYS;
 
 	down_write(&shrinker_rwsem);
-	/* This may call shrinker, so it must use down_read_trylock() */
 	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		goto unlock;
@@ -252,10 +251,15 @@ static long xchg_nr_deferred_memcg(int nid, struct shrinker *shrinker,
 {
 	struct shrinker_info *info;
 	struct shrinker_info_unit *unit;
+	long nr_deferred;
 
-	info = shrinker_info_protected(memcg, nid);
+	rcu_read_lock();
+	info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
 	unit = info->unit[shrinker_id_to_index(shrinker->id)];
-	return atomic_long_xchg(&unit->nr_deferred[shrinker_id_to_offset(shrinker->id)], 0);
+	nr_deferred = atomic_long_xchg(&unit->nr_deferred[shrinker_id_to_offset(shrinker->id)], 0);
+	rcu_read_unlock();
+
+	return nr_deferred;
 }
 
 static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
@@ -263,10 +267,16 @@ static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
 {
 	struct shrinker_info *info;
 	struct shrinker_info_unit *unit;
+	long nr_deferred;
 
-	info = shrinker_info_protected(memcg, nid);
+	rcu_read_lock();
+	info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
 	unit = info->unit[shrinker_id_to_index(shrinker->id)];
-	return atomic_long_add_return(nr, &unit->nr_deferred[shrinker_id_to_offset(shrinker->id)]);
+	nr_deferred =
+		atomic_long_add_return(nr, &unit->nr_deferred[shrinker_id_to_offset(shrinker->id)]);
+	rcu_read_unlock();
+
+	return nr_deferred;
 }
 
 void reparent_shrinker_deferred(struct mem_cgroup *memcg)
@@ -463,18 +473,54 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 	if (!mem_cgroup_online(memcg))
 		return 0;
 
-	if (!down_read_trylock(&shrinker_rwsem))
-		return 0;
-
-	info = shrinker_info_protected(memcg, nid);
+	/*
+	 * lockless algorithm of memcg shrink.
+	 *
+	 * The shrinker_info may be freed asynchronously via RCU in the
+	 * expand_one_shrinker_info(), so the rcu_read_lock() needs to be used
+	 * to ensure the existence of the shrinker_info.
+	 *
+	 * The shrinker_info_unit is never freed unless its corresponding memcg
+	 * is destroyed. Here we already hold the refcount of memcg, so the
+	 * memcg will not be destroyed, and of course shrinker_info_unit will
+	 * not be freed.
+	 *
+	 * So in the memcg shrink:
+	 *  step 1: use rcu_read_lock() to guarantee existence of the
+	 *          shrinker_info.
+	 *  step 2: after getting shrinker_info_unit we can safely release the
+	 *          RCU lock.
+	 *  step 3: traverse the bitmap and calculate shrinker_id
+	 *  step 4: use rcu_read_lock() to guarantee existence of the shrinker.
+	 *  step 5: use shrinker_id to find the shrinker, then use
+	 *          shrinker_try_get() to guarantee existence of the shrinker,
+	 *          then we can release the RCU lock to do do_shrink_slab() that
+	 *          may sleep.
+	 *  step 6: do shrinker_put() paired with step 5 to put the refcount,
+	 *          if the refcount reaches 0, then wake up the waiter in
+	 *          shrinker_free() by calling complete().
+	 *          Note: here is different from the global shrink, we don't
+	 *                need to acquire the RCU lock to guarantee existence of
+	 *                the shrinker, because we don't need to use this
+	 *                shrinker to traverse the next shrinker in the bitmap.
+	 *  step 7: we have already exited the read-side of rcu critical section
+	 *          before calling do_shrink_slab(), the shrinker_info may be
+	 *          released in expand_one_shrinker_info(), so go back to step 1
+	 *          to reacquire the shrinker_info.
+	 */
+again:
+	rcu_read_lock();
+	info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
 	if (unlikely(!info))
 		goto unlock;
 
-	for (; index < shrinker_id_to_index(info->map_nr_max); index++) {
+	if (index < shrinker_id_to_index(info->map_nr_max)) {
 		struct shrinker_info_unit *unit;
 
 		unit = info->unit[index];
 
+		rcu_read_unlock();
+
 		for_each_set_bit(offset, unit->map, SHRINKER_UNIT_BITS) {
 			struct shrink_control sc = {
 				.gfp_mask = gfp_mask,
@@ -484,12 +530,14 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			struct shrinker *shrinker;
 			int shrinker_id = calc_shrinker_id(index, offset);
 
+			rcu_read_lock();
 			shrinker = idr_find(&shrinker_idr, shrinker_id);
-			if (unlikely(!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))) {
-				if (!shrinker)
-					clear_bit(offset, unit->map);
+			if (unlikely(!shrinker || !shrinker_try_get(shrinker))) {
+				clear_bit(offset, unit->map);
+				rcu_read_unlock();
 				continue;
 			}
+			rcu_read_unlock();
 
 			/* Call non-slab shrinkers even though kmem is disabled */
 			if (!memcg_kmem_online() &&
@@ -522,15 +570,14 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 					set_shrinker_bit(memcg, nid, shrinker_id);
 			}
 			freed += ret;
-
-			if (rwsem_is_contended(&shrinker_rwsem)) {
-				freed = freed ? : 1;
-				goto unlock;
-			}
+			shrinker_put(shrinker);
 		}
+
+		index++;
+		goto again;
 	}
 unlock:
-	up_read(&shrinker_rwsem);
+	rcu_read_unlock();
 	return freed;
 }
 #else /* !CONFIG_MEMCG */
-- 
2.30.2


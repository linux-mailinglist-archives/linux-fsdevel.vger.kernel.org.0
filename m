Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B9B764D1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 10:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjG0Iap (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 04:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjG0I3u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:29:50 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB18AD23
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:16:44 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6748a616e17so184181b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690445722; x=1691050522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfKKsEp61SZUnTy00HUcIO/dAXsDrrCBrc1q4f5gA2g=;
        b=EAS6K8pjZHV2xJO1k0B0O2ENzb3/Vvl+c5sC6vZF5+RNctHPYXK3F4aD7Xzt8amvSX
         Sp0sM3dY6nrfZgyX03OOoIKbasLRWXH327iv4+GYUr4WlO1QPIHvBbrRjUoddMLJYEtj
         qslIbW38aWpZfadSfI+TaMUP7PcrUPJ3woAJMv4ugKgPJM767PAG7K9gWxMSKIL9CKj3
         w5CY/SzoV5mu91kUw+3ztoEROa7i9Mv96qiOzuHElFUZjh2ImlDQY3RLu003MMnVyV3S
         TQhJNq9ppxsbvsUjd927IP6iiwsq7VIfzEbkN9zPwoI9Valaw0w8Qu8JFGFsYg3rQsoY
         gM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445722; x=1691050522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfKKsEp61SZUnTy00HUcIO/dAXsDrrCBrc1q4f5gA2g=;
        b=DyWgO9WSqxDnAXU56y82cUR1AGJlDbqpeOt0EK51n/dJ1iiLZgfPJ7LZUfZufC8OSd
         HOG2ZUoC0ENAy2vqC22Ldi2ycA5Vmxjz9UI9B9kv1bWBbGaamnvy1ocwCjs3zkQBqs3K
         /K7bz1oXw9OygBZnk7I7hZNYwJnaWY3qXfFiwf/OZ4EWWCyIRNrVgMq4J0xWTKOyGn57
         mLzajhB68/K0j8mrnmQsl47J34HXrLI5+u1xvtM6q2jD+e3bpB/itoM2xkkfuE6pE2fx
         TO9tKmvZ3LMGK846eXRVlkF4kNunEAkY9WWovd7ZwcNFiCVfbtGXfz8++1MPDpJ+s8hl
         sh9w==
X-Gm-Message-State: ABy/qLaikIbqsmH+WT8YJb6PNVBtp+MRwVBx9TtY0O+KdyVMWmwXc7Dt
        z9LQjtxYSumgdYSdaAxM8t2Ocg==
X-Google-Smtp-Source: APBJJlGaIHiWHX80BWphqmbYYC2Qe9rA0t1NXuG9/ru/q26OnfFQXVEhM5bGyqGhtVnixSectLT5LA==
X-Received: by 2002:a05:6a00:4792:b0:668:834d:4bd with SMTP id dh18-20020a056a00479200b00668834d04bdmr4689753pfb.0.1690445722143;
        Thu, 27 Jul 2023 01:15:22 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:15:21 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 47/49] mm: shrinker: make memcg slab shrink lockless
Date:   Thu, 27 Jul 2023 16:05:00 +0800
Message-Id: <20230727080502.77895-48-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 mm/shrinker.c | 80 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 26 deletions(-)

diff --git a/mm/shrinker.c b/mm/shrinker.c
index d318f5621862..fee6f62904fb 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -107,6 +107,12 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
 					 lockdep_is_held(&shrinker_rwsem));
 }
 
+static struct shrinker_info *shrinker_info_rcu(struct mem_cgroup *memcg,
+					       int nid)
+{
+	return rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
+}
+
 static int expand_one_shrinker_info(struct mem_cgroup *memcg, int new_size,
 				    int old_size, int new_nr_max)
 {
@@ -198,7 +204,7 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 		struct shrinker_info_unit *unit;
 
 		rcu_read_lock();
-		info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
+		info = shrinker_info_rcu(memcg, nid);
 		unit = info->unit[shriner_id_to_index(shrinker_id)];
 		if (!WARN_ON_ONCE(shrinker_id >= info->map_nr_max)) {
 			/* Pairs with smp mb in shrink_slab() */
@@ -211,7 +217,7 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 
 static DEFINE_IDR(shrinker_idr);
 
-static int prealloc_memcg_shrinker(struct shrinker *shrinker)
+static int shrinker_memcg_alloc(struct shrinker *shrinker)
 {
 	int id, ret = -ENOMEM;
 
@@ -219,7 +225,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 		return -ENOSYS;
 
 	down_write(&shrinker_rwsem);
-	/* This may call shrinker, so it must use down_read_trylock() */
 	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		goto unlock;
@@ -237,7 +242,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 	return ret;
 }
 
-static void unregister_memcg_shrinker(struct shrinker *shrinker)
+static void shrinker_memcg_remove(struct shrinker *shrinker)
 {
 	int id = shrinker->id;
 
@@ -253,10 +258,15 @@ static long xchg_nr_deferred_memcg(int nid, struct shrinker *shrinker,
 {
 	struct shrinker_info *info;
 	struct shrinker_info_unit *unit;
+	long nr_deferred;
 
-	info = shrinker_info_protected(memcg, nid);
+	rcu_read_lock();
+	info = shrinker_info_rcu(memcg, nid);
 	unit = info->unit[shriner_id_to_index(shrinker->id)];
-	return atomic_long_xchg(&unit->nr_deferred[shriner_id_to_offset(shrinker->id)], 0);
+	nr_deferred = atomic_long_xchg(&unit->nr_deferred[shriner_id_to_offset(shrinker->id)], 0);
+	rcu_read_unlock();
+
+	return nr_deferred;
 }
 
 static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
@@ -264,10 +274,16 @@ static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
 {
 	struct shrinker_info *info;
 	struct shrinker_info_unit *unit;
+	long nr_deferred;
 
-	info = shrinker_info_protected(memcg, nid);
+	rcu_read_lock();
+	info = shrinker_info_rcu(memcg, nid);
 	unit = info->unit[shriner_id_to_index(shrinker->id)];
-	return atomic_long_add_return(nr, &unit->nr_deferred[shriner_id_to_offset(shrinker->id)]);
+	nr_deferred =
+		atomic_long_add_return(nr, &unit->nr_deferred[shriner_id_to_offset(shrinker->id)]);
+	rcu_read_unlock();
+
+	return nr_deferred;
 }
 
 void reparent_shrinker_deferred(struct mem_cgroup *memcg)
@@ -299,12 +315,12 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 	up_read(&shrinker_rwsem);
 }
 #else
-static int prealloc_memcg_shrinker(struct shrinker *shrinker)
+static int shrinker_memcg_alloc(struct shrinker *shrinker)
 {
 	return -ENOSYS;
 }
 
-static void unregister_memcg_shrinker(struct shrinker *shrinker)
+static void shrinker_memcg_remove(struct shrinker *shrinker)
 {
 }
 
@@ -464,18 +480,23 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 	if (!mem_cgroup_online(memcg))
 		return 0;
 
-	if (!down_read_trylock(&shrinker_rwsem))
-		return 0;
-
-	info = shrinker_info_protected(memcg, nid);
+again:
+	rcu_read_lock();
+	info = shrinker_info_rcu(memcg, nid);
 	if (unlikely(!info))
 		goto unlock;
 
-	for (; index < shriner_id_to_index(info->map_nr_max); index++) {
+	if (index < shriner_id_to_index(info->map_nr_max)) {
 		struct shrinker_info_unit *unit;
 
 		unit = info->unit[index];
 
+		/*
+		 * The shrinker_info_unit will not be freed, so we can
+		 * safely release the RCU lock here.
+		 */
+		rcu_read_unlock();
+
 		for_each_set_bit(offset, unit->map, SHRINKER_UNIT_BITS) {
 			struct shrink_control sc = {
 				.gfp_mask = gfp_mask,
@@ -485,12 +506,14 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
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
@@ -523,15 +546,20 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
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
+		/*
+		 * We have already exited the read-side of rcu critical section
+		 * before calling do_shrink_slab(), the shrinker_info may be
+		 * released in expand_one_shrinker_info(), so reacquire the
+		 * shrinker_info.
+		 */
+		index++;
+		goto again;
 	}
 unlock:
-	up_read(&shrinker_rwsem);
+	rcu_read_unlock();
 	return freed;
 }
 #else /* !CONFIG_MEMCG */
@@ -638,7 +666,7 @@ struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...)
 	shrinker->flags = flags | SHRINKER_ALLOCATED;
 
 	if (flags & SHRINKER_MEMCG_AWARE) {
-		err = prealloc_memcg_shrinker(shrinker);
+		err = shrinker_memcg_alloc(shrinker);
 		if (err == -ENOSYS)
 			shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
 		else if (err == 0)
@@ -731,7 +759,7 @@ void shrinker_free(struct shrinker *shrinker)
 	}
 
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
-		unregister_memcg_shrinker(shrinker);
+		shrinker_memcg_remove(shrinker);
 	up_write(&shrinker_rwsem);
 
 	if (debugfs_entry)
-- 
2.30.2


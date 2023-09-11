Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9D979B40D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbjIKUza (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbjIKJwD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:52:03 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEF2CE6
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:51:38 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68cc1b70e05so1081911b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425898; x=1695030698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02oN8W08zjTxUZl21U6+DV55wPZPOOOcomDUkgbjeeM=;
        b=eb2NCWfziWPjr3d/T+ODGwOVe4Nh+Tj0dozANXldfp23HfwIbQ6T3iNc7oTNwUWztZ
         M+RLbFRPJSBvdaZ2B4+Oo2IacG7D2kokrlxdd9ygstNr0+jIQOLN9/yZ7yj3n7xp9yJ6
         JjAO1V++EQNwUjZjqpfqn9eSH9gYguwrhYlkCyO1KLzt6M15thI6sov60Iqow5pJI0Zl
         3Oahb4E3IqtGvGYXLpmRllLyF6SCXcNUx9aaa71EGqa6MfEkXkehq5PDlQliCvvy2LVq
         edP/UJ8VZaHbluN1YeXZWv0AEtg011meG8MwdZBekch9w73yM/cdOEE3Bwx7t5c4rgZD
         8PlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425898; x=1695030698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02oN8W08zjTxUZl21U6+DV55wPZPOOOcomDUkgbjeeM=;
        b=Vp7fJgtyr8kUVS6DlDjCrKxc0s475ag0L2ORdC6zxzBidsySSldwHV7jBctzy8GIAL
         vfKHyZGEpYyppUZArn1G9Uv5hCMq/7kqKPL4PjMaQIqJMFI+GCAwqKeiOvN6B0GeQShP
         P2RwXIZ3jBtC4DSejxRwcG6zrnn9NM6eUaHBWrAUXurnTSFKi2UHurrpbxaQdtBdhD/U
         eVVHqNav+MOZU+OOvpr7bX2H3gJZSju0ioe6eBY/oZVZxYSfHaNy6YsQFoZdB/oHsCEA
         RZtKxgi3Ot5I/yD2TqwxMSD9lsHZNgooBAqe85YbKK6QYfNMtzLK/cpQYTpoCapxk7Ec
         SiMA==
X-Gm-Message-State: AOJu0Yz1qWpLI9P4sFd1Z84z7VTFigUMmEZ4xwp0A5mS9bEfuXMxr/cH
        vXs+7PzWmsXPRRu+8eo0OAG3yQ==
X-Google-Smtp-Source: AGHT+IH97cG96KOmpoktz2XA7SklxuW0ceeXqXRZ1DysovZgTlaqQRndvB65TuUAaXsE5amMaJ1n9w==
X-Received: by 2002:a05:6a21:6da4:b0:137:3941:17b3 with SMTP id wl36-20020a056a216da400b00137394117b3mr12294593pzb.6.1694425897928;
        Mon, 11 Sep 2023 02:51:37 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:51:37 -0700 (PDT)
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
Subject: [PATCH v6 43/45] mm: shrinker: make memcg slab shrink lockless
Date:   Mon, 11 Sep 2023 17:44:42 +0800
Message-Id: <20230911094444.68966-44-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

  33.15%  [kernel]          [k] down_read_trylock
  25.38%  [kernel]          [k] shrink_slab
  21.75%  [kernel]          [k] up_read
   4.45%  [kernel]          [k] _find_next_bit
   2.27%  [kernel]          [k] do_shrink_slab
   1.80%  [kernel]          [k] intel_idle_irq
   1.79%  [kernel]          [k] shrink_lruvec
   0.67%  [kernel]          [k] xas_descend
   0.41%  [kernel]          [k] mem_cgroup_iter
   0.40%  [kernel]          [k] shrink_node
   0.38%  [kernel]          [k] list_lru_count_one

2) After applying this patchset:

  64.56%  [kernel]          [k] shrink_slab
  12.18%  [kernel]          [k] do_shrink_slab
   3.30%  [kernel]          [k] __rcu_read_unlock
   2.61%  [kernel]          [k] shrink_lruvec
   2.49%  [kernel]          [k] __rcu_read_lock
   1.93%  [kernel]          [k] intel_idle_irq
   0.89%  [kernel]          [k] shrink_node
   0.81%  [kernel]          [k] mem_cgroup_iter
   0.77%  [kernel]          [k] mem_cgroup_calculate_protection
   0.66%  [kernel]          [k] list_lru_count_one

We can see that the first perf hotspot becomes shrink_slab, which is what
we expect.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/shrinker.c | 85 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 19 deletions(-)

diff --git a/mm/shrinker.c b/mm/shrinker.c
index 82dc61133c5b..ad64cac5248c 100644
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


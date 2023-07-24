Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5A975F1E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 12:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjGXKCv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 06:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjGXKBw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:01:52 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966955259
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 02:54:56 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bb85ed352bso2248785ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 02:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690192445; x=1690797245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FywtQwu9mwqdLnpgsxjfsrD11oDXqt6ENbvCNRWNCVA=;
        b=DikUT4CKvV9RWn+fl0EOFm95TR3cSja3PlgjCDFqYMWPqMDDzd0vmehY70wgwFHQZD
         xId6TApEDoayIU5bQp8ozmrUPwrV+fZdWpug1R+OQH5DrriDxnV5YGJ3iOuChC8/ataP
         +R3gMMBTSe4nwS0xpXqJAoWzm6vYwBlpoaI2H2xyHy5N1Vcg7pPEK5Dz8BrqbjXdo46a
         BIBOWCEzFcgC3VjgRrMmpjjBZE50INCoJYWq8LivZP/kkdwHaluoJFKZZtpIIdRFhRls
         Kq/htL25Wjh18OwWW51R+/aE+ahnELBQ5oiFmyJ9PiIhZjCyUAuo6LkxYtq+ZqQ6xAXz
         Fmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192445; x=1690797245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FywtQwu9mwqdLnpgsxjfsrD11oDXqt6ENbvCNRWNCVA=;
        b=Vf3UPYGu5yn9wCvXeziEyIHEwV7WpjFMYtCou8gSo8rTQM2Y6cgtCxh0kEWjB5YHT0
         JcHNayvvD7TMWPP4FOIa07jk0ZCb4F7eTzURgyzrnzfg84G5o8PSpbOEWeuwDbVrAMp4
         uhPzGeqtnZjMxhFw8up2tsPsnADdTe3L1QHbbZazHtVLPd0mytu+JOIqgIbOXTxHXgw5
         GKd07TZv84pMDiCfy2qS3gxWIaJDvRhD/bUGd2b7xQ+PzDZoESmIo0xnHNVNpHhEQItv
         b7Rly8tPwh20TxI78qU+Gu1p/93Da5wbg6M+GWetiM2PismrPZEMyUZDKwSSvONeOfvO
         C8cQ==
X-Gm-Message-State: ABy/qLZbqPR7HnVf5egAK9UBL1FvPYdAQphwg3yMLn4+BYh4tbdD0Hzz
        XS2rRsebdCORJV4Z90e3gV2oEw==
X-Google-Smtp-Source: APBJJlGle8sGTFCIz3U+SEQARZPGtcsatZf97BgxEHL69WWMCLjqGjoS5fsqRbwtJvxWPn7Q2rRfzw==
X-Received: by 2002:a17:902:cecd:b0:1b8:70d2:eb3a with SMTP id d13-20020a170902cecd00b001b870d2eb3amr12272091plg.0.1690192445165;
        Mon, 24 Jul 2023 02:54:05 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:54:04 -0700 (PDT)
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
Subject: [PATCH v2 45/47] mm: shrinker: make memcg slab shrink lockless
Date:   Mon, 24 Jul 2023 17:43:52 +0800
Message-Id: <20230724094354.90817-46-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
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
 mm/shrinker.c       | 121 +++++++++++++++++++++++++++-----------------
 mm/shrinker_debug.c |   4 +-
 2 files changed, 76 insertions(+), 49 deletions(-)

diff --git a/mm/shrinker.c b/mm/shrinker.c
index 8e3334749552..744361afd520 100644
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
@@ -152,11 +158,11 @@ static int expand_shrinker_info(int new_id)
 	int new_size, old_size = 0;
 	struct mem_cgroup *memcg;
 
+	down_write(&shrinker_rwsem);
+
 	if (!root_mem_cgroup)
 		goto out;
 
-	lockdep_assert_held(&shrinker_rwsem);
-
 	new_size = shrinker_unit_size(new_nr_max);
 	old_size = shrinker_unit_size(shrinker_nr_max);
 
@@ -173,6 +179,8 @@ static int expand_shrinker_info(int new_id)
 	if (!ret)
 		shrinker_nr_max = new_nr_max;
 
+	up_write(&shrinker_rwsem);
+
 	return ret;
 }
 
@@ -198,7 +206,7 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 		struct shrinker_info_unit *unit;
 
 		rcu_read_lock();
-		info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
+		info = shrinker_info_rcu(memcg, nid);
 		unit = info->unit[shriner_id_to_index(shrinker_id)];
 		if (!WARN_ON_ONCE(shrinker_id >= info->map_nr_max)) {
 			/* Pairs with smp mb in shrink_slab() */
@@ -211,39 +219,40 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 
 static DEFINE_IDR(shrinker_idr);
 
-static int prealloc_memcg_shrinker(struct shrinker *shrinker)
+static int shrinker_memcg_alloc(struct shrinker *shrinker)
 {
-	int id, ret = -ENOMEM;
+	int id;
 
 	if (mem_cgroup_disabled())
 		return -ENOSYS;
 
-	down_write(&shrinker_rwsem);
-	/* This may call shrinker, so it must use down_read_trylock() */
-	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
+	spin_lock(&shrinker_lock);
+	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_ATOMIC);
+	spin_unlock(&shrinker_lock);
+
 	if (id < 0)
-		goto unlock;
+		return -ENOMEM;
 
 	if (id >= shrinker_nr_max) {
 		if (expand_shrinker_info(id)) {
+			spin_lock(&shrinker_lock);
 			idr_remove(&shrinker_idr, id);
-			goto unlock;
+			spin_unlock(&shrinker_lock);
+			return -ENOMEM;
 		}
 	}
 	shrinker->id = id;
-	ret = 0;
-unlock:
-	up_write(&shrinker_rwsem);
-	return ret;
+
+	return 0;
 }
 
-static void unregister_memcg_shrinker(struct shrinker *shrinker)
+static void shrinker_memcg_remove(struct shrinker *shrinker)
 {
 	int id = shrinker->id;
 
 	BUG_ON(id < 0);
 
-	lockdep_assert_held(&shrinker_rwsem);
+	lockdep_assert_held(&shrinker_lock);
 
 	idr_remove(&shrinker_idr, id);
 }
@@ -253,10 +262,15 @@ static long xchg_nr_deferred_memcg(int nid, struct shrinker *shrinker,
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
@@ -264,10 +278,16 @@ static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
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
@@ -299,12 +319,12 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
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
 
@@ -458,6 +478,8 @@ void shrinker_put(struct shrinker *shrinker)
 	if (refcount_dec_and_test(&shrinker->refcount)) {
 		spin_lock(&shrinker_lock);
 		list_del_rcu(&shrinker->list);
+		if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+			shrinker_memcg_remove(shrinker);
 		spin_unlock(&shrinker_lock);
 
 		kfree(shrinker->nr_deferred);
@@ -476,18 +498,23 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
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
@@ -497,13 +524,14 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			struct shrinker *shrinker;
 			int shrinker_id = calc_shrinker_id(index, offset);
 
+			rcu_read_lock();
 			shrinker = idr_find(&shrinker_idr, shrinker_id);
-			if (unlikely(!shrinker ||
-				     !READ_ONCE(shrinker->registered))) {
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
@@ -536,15 +564,20 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
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
@@ -652,7 +685,7 @@ struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...)
 	shrinker->flags = flags;
 
 	if (flags & SHRINKER_MEMCG_AWARE) {
-		err = prealloc_memcg_shrinker(shrinker);
+		err = shrinker_memcg_alloc(shrinker);
 		if (err == -ENOSYS)
 			shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
 		else if (err == 0)
@@ -697,9 +730,9 @@ void shrinker_free_non_registered(struct shrinker *shrinker)
 	shrinker->name = NULL;
 #endif
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
-		down_write(&shrinker_rwsem);
-		unregister_memcg_shrinker(shrinker);
-		up_write(&shrinker_rwsem);
+		spin_lock(&shrinker_lock);
+		shrinker_memcg_remove(shrinker);
+		spin_unlock(&shrinker_lock);
 	}
 
 	kfree(shrinker->nr_deferred);
@@ -731,13 +764,7 @@ void shrinker_unregister(struct shrinker *shrinker)
 		return;
 
 	WRITE_ONCE(shrinker->registered, false);
-
-	down_write(&shrinker_rwsem);
-	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
-		unregister_memcg_shrinker(shrinker);
 	debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
-	up_write(&shrinker_rwsem);
-
 	shrinker_debugfs_remove(debugfs_entry, debugfs_id);
 
 	shrinker_put(shrinker);
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index c5573066adbf..badda35464c3 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -246,8 +246,7 @@ struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
 {
 	struct dentry *entry = shrinker->debugfs_entry;
 
-	lockdep_assert_held(&shrinker_rwsem);
-
+	down_write(&shrinker_rwsem);
 	kfree_const(shrinker->name);
 	shrinker->name = NULL;
 
@@ -258,6 +257,7 @@ struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
 	 */
 	smp_wmb();
 	shrinker->debugfs_entry = NULL;
+	up_write(&shrinker_rwsem);
 
 	return entry;
 }
-- 
2.30.2


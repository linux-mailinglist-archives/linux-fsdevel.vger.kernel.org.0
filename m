Return-Path: <linux-fsdevel+bounces-61408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8123B57DE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 15:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F423A93DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8569B3191DC;
	Mon, 15 Sep 2025 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsYsqaww"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222413128BE
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944085; cv=none; b=Rvr5hDszIWSZfVre4/uZv3H5z0CygWUYJOEWfyXcEdo52AvSbY/hQt1GAweuK/lKSciauCI2clNE/J0zMOJeLUwM/+t8ZMNIAAWfkjG0VHnLT9fTSPPrnDp9+adj3GNGlgUjkVh+lvxlaRLclBhFRS/SZ00LVW2Pv+qRtny3Kvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944085; c=relaxed/simple;
	bh=SKHmqvWWe/Z5R5RG9dZQPgVCF/XUfQdAX6xgO//4/pQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IRVQk1INZzPXLi0zQFRrpmbJWDJOuKyCf9WxsAgEh7FK6g5llFloMFemE6Ob0dr/kWSrcIHk+AGhS3n0T/q2+P7Jv0Ygbbuj1ZZ4e3Tg9lrscESNgw7AxxIleiZslbFnihWq1WIKtUeKAta05ySGsrRiuWuN7POGo8dyWmeWd9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsYsqaww; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b54d23714adso583310a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 06:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757944081; x=1758548881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EBmg+LxXgKyTmTcC9keCM60L1vufisbkPgvfPos4Cjw=;
        b=VsYsqawwf8HU/kQxjGEnFmC6kCXtfa6Rj6LipK8Xp6fIJJn4M6FZOOVa5XtP12JbeK
         ZuSRf09lCTQGgGEJm8tzYR8kLw4mgLJT526Ewg8JLkp0vAZeWcx3W7gBQZZdr7yzYEvd
         0RvDLBp56ZsAmDQGj5o5nps4ucoZm7ZBCZ550RXuN5YW/acHRBTnkIwt/jJX09IkjOS5
         EUhnN3YWhdC9Z9eZw+/ozHTmCHeBn0yhBTiliwsgK8e/EMfboIxYO9kinm8IcYPmOOH5
         iGcpeB5pU5vIFFTnp3L3Pyu9EP33e4im/t31rzNGXUFoH8Y5KtaGadDYIYGPJ+lhBXY+
         VUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757944081; x=1758548881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EBmg+LxXgKyTmTcC9keCM60L1vufisbkPgvfPos4Cjw=;
        b=VRyCE0uAp0QADhZWZ4SLZRnHm+f7KskrO4qePzaBFE4VmW2MohWaA5IZB8pYVxEUbE
         iMbNARvmmyjvdsW8XjVRvbo9J32LoHqVpXcp9LDcv218b+enoqyN8JSp8keeu+gsswo+
         dlcTY2nJAJlnp+t351kRjAgzLwtIuioCWZqOHGDevpKKHefogcIefswNdBHwUtvP5061
         CPY1o/Pucalxwp9b5frwptqEdPg+zc0Y+zHH0YW++5xDTsEfqV0llzdFSq+5mbU6McCw
         zMJ5LcqpYmS8DlPofZyZfxp3aZUTqudaXfp/ylrMCim8Yj/+TYTfl/M47ka7JXhHdF8I
         bk5g==
X-Forwarded-Encrypted: i=1; AJvYcCW1YsPuqdoOLJGSIlyj39QVVwhGrD/b8AYbGOaFUgtlloeGSgKiOq+jLf731Qdfer0dSRRFAudDpyJAvaNJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Pum7S0kXYV8i42ZfV63moybr15xVVVrzFOkWaZlMdhoJG5EN
	HUW3M0UrJYjzxPlQl9xklbz+meY5spDuvCG4Urtk5i8EXqTeqELFlIhL
X-Gm-Gg: ASbGncu1FyB6VPv5SoylM36T02LxEuzu8DMXCSCYm4kqbnbGfvgS78kBqAOb73soG3o
	6dXIOIG8uC41BP5RNqnWf8Q34aw/Vj4pdHT7583xl0OI+R2SyQlX0IhN/1F3uzUvOTYfXLnsSef
	O92i6xpilrPG47jmnR7HBCOQOBN9rCwutXIUjGl5fKW1m9d0zY90wVRbUtCeBggCKINXS0fLYNu
	ZkILAHp92t75Cgmkh5mKQaypCAy31YHsLMceS/cMx/Svxzsfy2JXT0RrKXvdQ0rYOTcQ4QVxOpf
	9EPOX4m7I+KS5Wnt4NCktv8WhFg+PDJLmkk4VNQb/kWVoCmtKIhuGCUEDO4VcoQV9UrGcTne49z
	6MkgaY2WhqBwu+YgOXzIR5sCZ7z3JURxtT9cuYgOEDHa0vNEH+Q==
X-Google-Smtp-Source: AGHT+IGF6Q2khplFnQZiLOt+3nqcoNxxhk6Fu2ikcjzjM+rfB7FLjTLaxCP4kTmqZzCnd81NLEdLfw==
X-Received: by 2002:a17:903:19c8:b0:24c:e9de:ee11 with SMTP id d9443c01a7336-25d2c560f8emr153188935ad.17.1757944081134;
        Mon, 15 Sep 2025 06:48:01 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26505197a82sm43706285ad.85.2025.09.15.06.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 06:48:00 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v2] rcu: Remove redundant rcu_read_lock/unlock() in spin_lock critical sections
Date: Mon, 15 Sep 2025 21:47:29 +0800
Message-Id: <20250915134729.1801557-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Per Documentation/RCU/rcu_dereference.rst [1], since Linux 4.20's RCU
consolidation [2][3], RCU read-side critical sections include:
  - Explicit rcu_read_lock()
  - BH/interrupt/preemption-disabling regions
  - Spinlock critical sections (including CONFIG_PREEMPT_RT kernels [4])

Thus, explicit rcu_read_lock()/unlock() calls within spin_lock*() regions are redundant.
This patch removes them, simplifying locking semantics while preserving RCU protection.

[1] https://elixir.bootlin.com/linux/v6.17-rc5/source/Documentation/RCU/rcu_dereference.rst#L407
[2] https://lore.kernel.org/lkml/20180829222021.GA29944@linux.vnet.ibm.com/
[3] https://lwn.net/Articles/777036/
[4] https://lore.kernel.org/lkml/6435833a-bdcb-4114-b29d-28b7f436d47d@paulmck-laptop/

Cc: Waiman Long <longman@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
Changes in v2:
  - Clarified commit message to prevent accidental backport to older kernels
  - Added lockdep_is_held() to avoid false positives
---
 drivers/acpi/apei/ghes.c                        | 2 --
 drivers/gpu/drm/i915/gt/intel_ring_submission.c | 2 --
 drivers/net/amt.c                               | 8 --------
 drivers/net/bonding/bond_3ad.c                  | 2 --
 drivers/net/wireless/ath/ath9k/xmit.c           | 2 --
 drivers/s390/crypto/pkey_base.c                 | 3 ---
 fs/aio.c                                        | 6 ++----
 fs/nfs/callback_proc.c                          | 2 --
 fs/nfs/nfs4state.c                              | 2 --
 fs/nfs/pnfs.c                                   | 9 ---------
 fs/nfs/pnfs_dev.c                               | 4 ----
 ipc/msg.c                                       | 1 -
 ipc/sem.c                                       | 1 -
 ipc/shm.c                                       | 1 -
 ipc/util.c                                      | 2 --
 kernel/cgroup/cgroup.c                          | 2 --
 kernel/cgroup/cpuset.c                          | 6 ------
 kernel/cgroup/debug.c                           | 4 ----
 net/mac80211/cfg.c                              | 2 --
 net/mac80211/debugfs.c                          | 2 --
 net/mac80211/debugfs_netdev.c                   | 2 --
 net/mac80211/debugfs_sta.c                      | 2 --
 net/mac80211/sta_info.c                         | 2 --
 net/ncsi/ncsi-manage.c                          | 2 --
 security/yama/yama_lsm.c                        | 4 ----
 25 files changed, 2 insertions(+), 73 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a0d54993edb3..97ee19f2cae0 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1207,12 +1207,10 @@ static int ghes_notify_hed(struct notifier_block *this, unsigned long event,
 	int ret = NOTIFY_DONE;
 
 	spin_lock_irqsave(&ghes_notify_lock_irq, flags);
-	rcu_read_lock();
 	list_for_each_entry_rcu(ghes, &ghes_hed, list) {
 		if (!ghes_proc(ghes))
 			ret = NOTIFY_OK;
 	}
-	rcu_read_unlock();
 	spin_unlock_irqrestore(&ghes_notify_lock_irq, flags);
 
 	return ret;
diff --git a/drivers/gpu/drm/i915/gt/intel_ring_submission.c b/drivers/gpu/drm/i915/gt/intel_ring_submission.c
index 2a6d79abf25b..bf73166a1337 100644
--- a/drivers/gpu/drm/i915/gt/intel_ring_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_ring_submission.c
@@ -392,14 +392,12 @@ static void reset_rewind(struct intel_engine_cs *engine, bool stalled)
 
 	rq = NULL;
 	spin_lock_irqsave(&engine->sched_engine->lock, flags);
-	rcu_read_lock();
 	list_for_each_entry(pos, &engine->sched_engine->requests, sched.link) {
 		if (!__i915_request_is_complete(pos)) {
 			rq = pos;
 			break;
 		}
 	}
-	rcu_read_unlock();
 
 	/*
 	 * The guilty request will get skipped on a hung engine.
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index ed86537b2f61..aaed9fbc7526 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -295,7 +295,6 @@ static void amt_source_work(struct work_struct *work)
 
 	tunnel = gnode->tunnel_list;
 	spin_lock_bh(&tunnel->lock);
-	rcu_read_lock();
 	if (gnode->filter_mode == MCAST_INCLUDE) {
 		amt_destroy_source(snode);
 		if (!gnode->nr_sources)
@@ -306,7 +305,6 @@ static void amt_source_work(struct work_struct *work)
 		 */
 		snode->status = AMT_SOURCE_STATUS_D_FWD;
 	}
-	rcu_read_unlock();
 	spin_unlock_bh(&tunnel->lock);
 }
 
@@ -426,7 +424,6 @@ static void amt_group_work(struct work_struct *work)
 		goto out;
 	}
 
-	rcu_read_lock();
 	for (i = 0; i < buckets; i++) {
 		hlist_for_each_entry_safe(snode, t,
 					  &gnode->sources[i], node) {
@@ -443,7 +440,6 @@ static void amt_group_work(struct work_struct *work)
 		amt_del_group(amt, gnode);
 	else
 		gnode->filter_mode = MCAST_INCLUDE;
-	rcu_read_unlock();
 	spin_unlock_bh(&tunnel->lock);
 out:
 	dev_put(amt->dev);
@@ -1327,11 +1323,9 @@ static void amt_clear_groups(struct amt_tunnel_list *tunnel)
 	int i;
 
 	spin_lock_bh(&tunnel->lock);
-	rcu_read_lock();
 	for (i = 0; i < amt->hash_buckets; i++)
 		hlist_for_each_entry_safe(gnode, t, &tunnel->groups[i], node)
 			amt_del_group(amt, gnode);
-	rcu_read_unlock();
 	spin_unlock_bh(&tunnel->lock);
 }
 
@@ -1343,11 +1337,9 @@ static void amt_tunnel_expire(struct work_struct *work)
 	struct amt_dev *amt = tunnel->amt;
 
 	spin_lock_bh(&amt->lock);
-	rcu_read_lock();
 	list_del_rcu(&tunnel->list);
 	amt->nr_tunnels--;
 	amt_clear_groups(tunnel);
-	rcu_read_unlock();
 	spin_unlock_bh(&amt->lock);
 	kfree_rcu(tunnel, rcu);
 }
diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 4edc8e6b6b64..c53ea73f103a 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -2485,7 +2485,6 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
 	 * concurrently due to incoming LACPDU as well.
 	 */
 	spin_lock_bh(&bond->mode_lock);
-	rcu_read_lock();
 
 	/* check if there are any slaves */
 	if (!bond_has_slaves(bond))
@@ -2537,7 +2536,6 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
 			break;
 		}
 	}
-	rcu_read_unlock();
 	spin_unlock_bh(&bond->mode_lock);
 
 	if (update_slave_arr)
diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 0ac9212e42f7..4a0f465aa2fe 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -1993,7 +1993,6 @@ void ath_txq_schedule(struct ath_softc *sc, struct ath_txq *txq)
 
 	ieee80211_txq_schedule_start(hw, txq->mac80211_qnum);
 	spin_lock_bh(&sc->chan_lock);
-	rcu_read_lock();
 
 	if (sc->cur_chan->stopped)
 		goto out;
@@ -2011,7 +2010,6 @@ void ath_txq_schedule(struct ath_softc *sc, struct ath_txq *txq)
 	}
 
 out:
-	rcu_read_unlock();
 	spin_unlock_bh(&sc->chan_lock);
 	ieee80211_txq_schedule_end(hw, txq->mac80211_qnum);
 }
diff --git a/drivers/s390/crypto/pkey_base.c b/drivers/s390/crypto/pkey_base.c
index b15741461a63..4c4a9feecccc 100644
--- a/drivers/s390/crypto/pkey_base.c
+++ b/drivers/s390/crypto/pkey_base.c
@@ -48,16 +48,13 @@ int pkey_handler_register(struct pkey_handler *handler)
 
 	spin_lock(&handler_list_write_lock);
 
-	rcu_read_lock();
 	list_for_each_entry_rcu(h, &handler_list, list) {
 		if (h == handler) {
-			rcu_read_unlock();
 			spin_unlock(&handler_list_write_lock);
 			module_put(handler->module);
 			return -EEXIST;
 		}
 	}
-	rcu_read_unlock();
 
 	list_add_rcu(&handler->list, &handler_list);
 	spin_unlock(&handler_list_write_lock);
diff --git a/fs/aio.c b/fs/aio.c
index 7fc7b6221312..e3f9a5a391b5 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -359,15 +359,14 @@ static int aio_ring_mremap(struct vm_area_struct *vma)
 	int i, res = -EINVAL;
 
 	spin_lock(&mm->ioctx_lock);
-	rcu_read_lock();
-	table = rcu_dereference(mm->ioctx_table);
+	table = rcu_dereference_check(mm->ioctx_table, lockdep_is_held(&mm->ioctx_lock));
 	if (!table)
 		goto out_unlock;
 
 	for (i = 0; i < table->nr; i++) {
 		struct kioctx *ctx;
 
-		ctx = rcu_dereference(table->table[i]);
+		ctx = rcu_dereference_check(table->table[i], lockdep_is_held(&mm->ioctx_lock));
 		if (ctx && ctx->aio_ring_file == file) {
 			if (!atomic_read(&ctx->dead)) {
 				ctx->user_id = ctx->mmap_base = vma->vm_start;
@@ -378,7 +377,6 @@ static int aio_ring_mremap(struct vm_area_struct *vma)
 	}
 
 out_unlock:
-	rcu_read_unlock();
 	spin_unlock(&mm->ioctx_lock);
 	return res;
 }
diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 8397c43358bd..16144db39335 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -721,7 +721,6 @@ __be32 nfs4_callback_offload(void *data, void *dummy,
 		return cpu_to_be32(NFS4ERR_DELAY);
 
 	spin_lock(&cps->clp->cl_lock);
-	rcu_read_lock();
 	list_for_each_entry_rcu(server, &cps->clp->cl_superblocks,
 				client_link) {
 		list_for_each_entry(tmp_copy, &server->ss_copies, copies) {
@@ -736,7 +735,6 @@ __be32 nfs4_callback_offload(void *data, void *dummy,
 		}
 	}
 out:
-	rcu_read_unlock();
 	if (!found) {
 		memcpy(&copy->stateid, &args->coa_stateid, NFS4_STATEID_SIZE);
 		nfs4_copy_cb_args(copy, args);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 7612e977e80b..598229fc07ed 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -241,13 +241,11 @@ const struct cred *nfs4_get_renew_cred(struct nfs_client *clp)
 		goto out;
 
 	spin_lock(&clp->cl_lock);
-	rcu_read_lock();
 	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
 		cred = nfs4_get_renew_cred_server_locked(server);
 		if (cred != NULL)
 			break;
 	}
-	rcu_read_unlock();
 	spin_unlock(&clp->cl_lock);
 
 out:
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index a3135b5af7ee..c9399452bcfd 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -862,16 +862,13 @@ pnfs_layout_bulk_destroy_byserver_locked(struct nfs_client *clp,
 			if (pnfs_layout_add_bulk_destroy_list(inode,
 						layout_list))
 				continue;
-			rcu_read_unlock();
 			spin_unlock(&clp->cl_lock);
 			iput(inode);
 		} else {
-			rcu_read_unlock();
 			spin_unlock(&clp->cl_lock);
 		}
 		nfs_sb_deactive(server->super);
 		spin_lock(&clp->cl_lock);
-		rcu_read_lock();
 		return -EAGAIN;
 	}
 	return 0;
@@ -922,7 +919,6 @@ int pnfs_layout_destroy_byfsid(struct nfs_client *clp, struct nfs_fsid *fsid,
 	LIST_HEAD(layout_list);
 
 	spin_lock(&clp->cl_lock);
-	rcu_read_lock();
 restart:
 	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
 		if (memcmp(&server->fsid, fsid, sizeof(*fsid)) != 0)
@@ -932,7 +928,6 @@ int pnfs_layout_destroy_byfsid(struct nfs_client *clp, struct nfs_fsid *fsid,
 				&layout_list) != 0)
 			goto restart;
 	}
-	rcu_read_unlock();
 	spin_unlock(&clp->cl_lock);
 
 	return pnfs_layout_free_bulk_destroy_list(&layout_list, mode);
@@ -944,14 +939,12 @@ static void pnfs_layout_build_destroy_list_byclient(struct nfs_client *clp,
 	struct nfs_server *server;
 
 	spin_lock(&clp->cl_lock);
-	rcu_read_lock();
 restart:
 	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
 		if (pnfs_layout_bulk_destroy_byserver_locked(clp, server,
 							     list) != 0)
 			goto restart;
 	}
-	rcu_read_unlock();
 	spin_unlock(&clp->cl_lock);
 }
 
@@ -990,7 +983,6 @@ static void pnfs_layout_build_recover_list_byclient(struct nfs_client *clp,
 	struct nfs_server *server;
 
 	spin_lock(&clp->cl_lock);
-	rcu_read_lock();
 restart:
 	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
 		if (!(server->caps & NFS_CAP_REBOOT_LAYOUTRETURN))
@@ -999,7 +991,6 @@ static void pnfs_layout_build_recover_list_byclient(struct nfs_client *clp,
 							     list) != 0)
 			goto restart;
 	}
-	rcu_read_unlock();
 	spin_unlock(&clp->cl_lock);
 }
 
diff --git a/fs/nfs/pnfs_dev.c b/fs/nfs/pnfs_dev.c
index bf0f2d67e96c..d19752ec1a95 100644
--- a/fs/nfs/pnfs_dev.c
+++ b/fs/nfs/pnfs_dev.c
@@ -231,9 +231,7 @@ nfs4_delete_deviceid(const struct pnfs_layoutdriver_type *ld,
 	struct nfs4_deviceid_node *d;
 
 	spin_lock(&nfs4_deviceid_lock);
-	rcu_read_lock();
 	d = _lookup_deviceid(ld, clp, id, nfs4_deviceid_hash(id));
-	rcu_read_unlock();
 	if (!d) {
 		spin_unlock(&nfs4_deviceid_lock);
 		return;
@@ -331,14 +329,12 @@ _deviceid_purge_client(const struct nfs_client *clp, long hash)
 	HLIST_HEAD(tmp);
 
 	spin_lock(&nfs4_deviceid_lock);
-	rcu_read_lock();
 	hlist_for_each_entry_rcu(d, &nfs4_deviceid_cache[hash], node)
 		if (d->nfs_client == clp && atomic_read(&d->ref)) {
 			hlist_del_init_rcu(&d->node);
 			hlist_add_head(&d->tmpnode, &tmp);
 			clear_bit(NFS_DEVICEID_NOCACHE, &d->flags);
 		}
-	rcu_read_unlock();
 	spin_unlock(&nfs4_deviceid_lock);
 
 	if (hlist_empty(&tmp))
diff --git a/ipc/msg.c b/ipc/msg.c
index ee6af4fe52bf..1e579b57023f 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -179,7 +179,6 @@ static int newque(struct ipc_namespace *ns, struct ipc_params *params)
 	}
 
 	ipc_unlock_object(&msq->q_perm);
-	rcu_read_unlock();
 
 	return msq->q_perm.id;
 }
diff --git a/ipc/sem.c b/ipc/sem.c
index a39cdc7bf88f..38ad57b2b558 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -579,7 +579,6 @@ static int newary(struct ipc_namespace *ns, struct ipc_params *params)
 	ns->used_sems += nsems;
 
 	sem_unlock(sma, -1);
-	rcu_read_unlock();
 
 	return sma->sem_perm.id;
 }
diff --git a/ipc/shm.c b/ipc/shm.c
index a9310b6dbbc3..61fae1b6a18e 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -795,7 +795,6 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 	error = shp->shm_perm.id;
 
 	ipc_unlock_object(&shp->shm_perm);
-	rcu_read_unlock();
 	return error;
 
 no_id:
diff --git a/ipc/util.c b/ipc/util.c
index cae60f11d9c2..1be691b5dcad 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -293,7 +293,6 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	idr_preload(GFP_KERNEL);
 
 	spin_lock_init(&new->lock);
-	rcu_read_lock();
 	spin_lock(&new->lock);
 
 	current_euid_egid(&euid, &egid);
@@ -316,7 +315,6 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	if (idx < 0) {
 		new->deleted = true;
 		spin_unlock(&new->lock);
-		rcu_read_unlock();
 		return idx;
 	}
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 312c6a8b55bb..db9e00a559df 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2944,14 +2944,12 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 
 	/* look up all src csets */
 	spin_lock_irq(&css_set_lock);
-	rcu_read_lock();
 	task = leader;
 	do {
 		cgroup_migrate_add_src(task_css_set(task), dst_cgrp, &mgctx);
 		if (!threadgroup)
 			break;
 	} while_each_thread(leader, task);
-	rcu_read_unlock();
 	spin_unlock_irq(&css_set_lock);
 
 	/* prepare dst csets and commit */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 27adb04df675..9b7e8e8e9411 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4073,7 +4073,6 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 	struct cpuset *cs;
 
 	spin_lock_irqsave(&callback_lock, flags);
-	rcu_read_lock();
 
 	cs = task_cs(tsk);
 	if (cs != &top_cpuset)
@@ -4095,7 +4094,6 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 			cpumask_copy(pmask, possible_mask);
 	}
 
-	rcu_read_unlock();
 	spin_unlock_irqrestore(&callback_lock, flags);
 }
 
@@ -4168,9 +4166,7 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
 	unsigned long flags;
 
 	spin_lock_irqsave(&callback_lock, flags);
-	rcu_read_lock();
 	guarantee_online_mems(task_cs(tsk), &mask);
-	rcu_read_unlock();
 	spin_unlock_irqrestore(&callback_lock, flags);
 
 	return mask;
@@ -4265,10 +4261,8 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
 	/* Not hardwall and node outside mems_allowed: scan up cpusets */
 	spin_lock_irqsave(&callback_lock, flags);
 
-	rcu_read_lock();
 	cs = nearest_hardwall_ancestor(task_cs(current));
 	allowed = node_isset(node, cs->mems_allowed);
-	rcu_read_unlock();
 
 	spin_unlock_irqrestore(&callback_lock, flags);
 	return allowed;
diff --git a/kernel/cgroup/debug.c b/kernel/cgroup/debug.c
index 80aa3f027ac3..81ea38dd6f9d 100644
--- a/kernel/cgroup/debug.c
+++ b/kernel/cgroup/debug.c
@@ -49,7 +49,6 @@ static int current_css_set_read(struct seq_file *seq, void *v)
 		return -ENODEV;
 
 	spin_lock_irq(&css_set_lock);
-	rcu_read_lock();
 	cset = task_css_set(current);
 	refcnt = refcount_read(&cset->refcount);
 	seq_printf(seq, "css_set %pK %d", cset, refcnt);
@@ -67,7 +66,6 @@ static int current_css_set_read(struct seq_file *seq, void *v)
 		seq_printf(seq, "%2d: %-4s\t- %p[%d]\n", ss->id, ss->name,
 			  css, css->id);
 	}
-	rcu_read_unlock();
 	spin_unlock_irq(&css_set_lock);
 	cgroup_kn_unlock(of->kn);
 	return 0;
@@ -95,7 +93,6 @@ static int current_css_set_cg_links_read(struct seq_file *seq, void *v)
 		return -ENOMEM;
 
 	spin_lock_irq(&css_set_lock);
-	rcu_read_lock();
 	cset = task_css_set(current);
 	list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
 		struct cgroup *c = link->cgrp;
@@ -104,7 +101,6 @@ static int current_css_set_cg_links_read(struct seq_file *seq, void *v)
 		seq_printf(seq, "Root %d group %s\n",
 			   c->root->hierarchy_id, name_buf);
 	}
-	rcu_read_unlock();
 	spin_unlock_irq(&css_set_lock);
 	kfree(name_buf);
 	return 0;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 2ed07fa121ab..4fe50d4c461d 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4825,7 +4825,6 @@ static int ieee80211_get_txq_stats(struct wiphy *wiphy,
 	int ret = 0;
 
 	spin_lock_bh(&local->fq.lock);
-	rcu_read_lock();
 
 	if (wdev) {
 		sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
@@ -4851,7 +4850,6 @@ static int ieee80211_get_txq_stats(struct wiphy *wiphy,
 	}
 
 out:
-	rcu_read_unlock();
 	spin_unlock_bh(&local->fq.lock);
 
 	return ret;
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index e8b78ec682da..82099f4cedbe 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -82,7 +82,6 @@ static ssize_t aqm_read(struct file *file,
 	int len = 0;
 
 	spin_lock_bh(&local->fq.lock);
-	rcu_read_lock();
 
 	len = scnprintf(buf, sizeof(buf),
 			"access name value\n"
@@ -105,7 +104,6 @@ static ssize_t aqm_read(struct file *file,
 			fq->limit,
 			fq->quantum);
 
-	rcu_read_unlock();
 	spin_unlock_bh(&local->fq.lock);
 
 	return simple_read_from_buffer(user_buf, count, ppos,
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 1dac78271045..30a5a978a678 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -625,7 +625,6 @@ static ssize_t ieee80211_if_fmt_aqm(
 	txqi = to_txq_info(sdata->vif.txq);
 
 	spin_lock_bh(&local->fq.lock);
-	rcu_read_lock();
 
 	len = scnprintf(buf,
 			buflen,
@@ -642,7 +641,6 @@ static ssize_t ieee80211_if_fmt_aqm(
 			txqi->tin.tx_bytes,
 			txqi->tin.tx_packets);
 
-	rcu_read_unlock();
 	spin_unlock_bh(&local->fq.lock);
 
 	return len;
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 49061bd4151b..ef75255d47d5 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -148,7 +148,6 @@ static ssize_t sta_aqm_read(struct file *file, char __user *userbuf,
 		return -ENOMEM;
 
 	spin_lock_bh(&local->fq.lock);
-	rcu_read_lock();
 
 	p += scnprintf(p,
 		       bufsz + buf - p,
@@ -178,7 +177,6 @@ static ssize_t sta_aqm_read(struct file *file, char __user *userbuf,
 			       test_bit(IEEE80211_TXQ_DIRTY, &txqi->flags) ? " DIRTY" : "");
 	}
 
-	rcu_read_unlock();
 	spin_unlock_bh(&local->fq.lock);
 
 	rv = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 8c550aab9bdc..663318a75d7f 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2637,13 +2637,11 @@ static void sta_set_tidstats(struct sta_info *sta,
 
 	if (link_id < 0 && tid < IEEE80211_NUM_TIDS) {
 		spin_lock_bh(&local->fq.lock);
-		rcu_read_lock();
 
 		tidstats->filled |= BIT(NL80211_TID_STATS_TXQ_STATS);
 		ieee80211_fill_txq_stats(&tidstats->txq_stats,
 					 to_txq_info(sta->sta.txq[tid]));
 
-		rcu_read_unlock();
 		spin_unlock_bh(&local->fq.lock);
 	}
 }
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 446e4e3b9553..6e36cd64a31e 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -650,7 +650,6 @@ static int set_one_vid(struct ncsi_dev_priv *ndp, struct ncsi_channel *nc,
 
 	spin_lock_irqsave(&nc->lock, flags);
 
-	rcu_read_lock();
 	list_for_each_entry_rcu(vlan, &ndp->vlan_vids, list) {
 		vid = vlan->vid;
 		for (i = 0; i < ncf->n_vids; i++)
@@ -661,7 +660,6 @@ static int set_one_vid(struct ncsi_dev_priv *ndp, struct ncsi_channel *nc,
 		if (vid)
 			break;
 	}
-	rcu_read_unlock();
 
 	if (!vid) {
 		/* No VLAN ID is not set */
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 3d064dd4e03f..60d38deb181b 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -117,14 +117,12 @@ static void yama_relation_cleanup(struct work_struct *work)
 	struct ptrace_relation *relation;
 
 	spin_lock(&ptracer_relations_lock);
-	rcu_read_lock();
 	list_for_each_entry_rcu(relation, &ptracer_relations, node) {
 		if (relation->invalid) {
 			list_del_rcu(&relation->node);
 			kfree_rcu(relation, rcu);
 		}
 	}
-	rcu_read_unlock();
 	spin_unlock(&ptracer_relations_lock);
 }
 
@@ -152,7 +150,6 @@ static int yama_ptracer_add(struct task_struct *tracer,
 	added->invalid = false;
 
 	spin_lock(&ptracer_relations_lock);
-	rcu_read_lock();
 	list_for_each_entry_rcu(relation, &ptracer_relations, node) {
 		if (relation->invalid)
 			continue;
@@ -166,7 +163,6 @@ static int yama_ptracer_add(struct task_struct *tracer,
 	list_add_rcu(&added->node, &ptracer_relations);
 
 out:
-	rcu_read_unlock();
 	spin_unlock(&ptracer_relations_lock);
 	return 0;
 }
-- 
2.34.1



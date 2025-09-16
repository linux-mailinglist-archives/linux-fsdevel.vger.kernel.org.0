Return-Path: <linux-fsdevel+bounces-61704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4F9B590A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 10:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F09322FE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 08:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD912EB5A5;
	Tue, 16 Sep 2025 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fU9hvUzQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AC12EAD0A
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011381; cv=none; b=iW8hNkR1/MyrdmxlPjPz+DT+jXixXoRzeV/rYx8Q01AsJiC0FqHVZXU2NzwB8ZAIAMp7P1rXudfgzBK9owdUfdEYRATHiscHqx48IXHMmdNJ6Ll0+0FRtYxCEX6LnMb7pckz3hOqwo8zRnN4VjuXlSYjbr4NHpd6ftt86M/7ZL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011381; c=relaxed/simple;
	bh=K7YPDPZFAE6sVJVf7EgfXTh14JJBhD2cYTW4qBIoWFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDVMevYRmFFMjhWGOD6xHH6QPEareDpPCLB4BkY6ttZkjrNnNdS0ALuxMPx5h8sAv2VZ8MFCj7/SQAYbll5nFn/BO2m3jdy2atwKLm9e6dv99sZ9IRO+3dnN4UO0qXezPMVz3DccMBsPERW226Dxf1eyLjOBddwCMFINj8hjBto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fU9hvUzQ; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3ea7af25f42so1416676f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 01:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758011378; x=1758616178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baH/Z1f5f8iZGA6Au4zz6QKHJHadwW2kGkKITcSHlfU=;
        b=fU9hvUzQmkQOIPHXnxDmn4CrPdHB/KTba+kFpwKS+4X2pDM312AXxWy6ah1640z08R
         3t9fujRwOv85Sh4WfkymDQE5BjcXU4BhfZGsWIuLcRWa8AWZPHPl7gRmXYKByGlQGzQ2
         b2olTfW4/nx8+MsfIUh9qvZlAdr8gLLxA3/XGrHObWSYmhGgqXcb5hpgEoEP9b6C2Jry
         aMJypyb+rBiDw9EcQ0YRkeGfRMj/Kz1Q2lQSWLFMB+31BasUhco0Q/Rlc9dTPYlpiwvx
         +pnRSYp/39maddIgiJbS7fqya4wivtEYPdqIi/mhix8PpWRd/ZRu0w9ev6561FxySoOE
         5qEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758011378; x=1758616178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baH/Z1f5f8iZGA6Au4zz6QKHJHadwW2kGkKITcSHlfU=;
        b=aGVQx9S+yIOLMYUGKaxhFkmn92wgMBlSQ9dqq+IOMGfDeQP6OrIBtJ6hMICoZcT9oK
         6kICDUCIjJKIJUkTya83Hm51pJgV0KvKDvrfVdFoLGntwTJIM3HIKoNCN5/pletjBqRJ
         Z4kHrj4tMnFEnwi5oL4J5MwI3v+dt7BWWVqLyzwgGlZyxfdu2JNBGDV0uQ62wUNhH3KR
         jZ1kirkmjjUejfnsKfxnPi+Qd1RhU+rffQnTwY6ihQfpl3aF3oco4NOYteIOYiEogAYI
         /sM6nKHlWhP5+rIpTZjucYsb2vTwJcg2S0WDlKgvKekiqpjnWEb2ffw5IeJD7MOQSHU9
         rKig==
X-Forwarded-Encrypted: i=1; AJvYcCW3cinXSRywN4uJsgpdktlutR32eUTMrNwL5iulEAa9IBOaCKrhdnxncjIAKy3PfXiIZer//BkNXFSKa9pR@vger.kernel.org
X-Gm-Message-State: AOJu0YzI9QdzPco+1r1rHEbtSt7lYP7XdXOalTj6dEsQQBeTOGG4vxNy
	vIJqRr/Ut7CJ8UHdiDKPSiAZX7mo36l3f9C7lheJEMswsPU95zpVyd1HcC+NoV3g5blpx1tAi8d
	aGJCnpPfq1w==
X-Gm-Gg: ASbGncuIZStjEIsQq3dnLDfqNY/jQWYPteGscGXNFhwflP0DOtcBVW/R7SV/jaIpdpC
	6jCEPe9us7EtntFym1NCSFKAv3e9GBeQkBmljAhHQvPQCUNQQsjgYWg8JoaXH/mDyVbj7M5Msm/
	b6XdF85wUte9w9LLXYIObszcrGjWt90xOCu/NmMt+ff8IWl6gWZGg3+RDhix2I7hY7nxozONXYj
	fRKHN5ycXYgWHTH7i6IxA0aLDH2p0BicxcbhZy3xMNIxaGwnyhaqIbn0ZmHqfKTH36Ixst+bsEc
	RX9wkuP2vC+mrgjxdA5jqJR2M2ixlHYbhhsxvws0UNG2a8WK1SXHgLXOEGbIaqSTX8MMKnsuogD
	54p4PZPq/wHrtQ+4nxkkRG1KMvpX07E7r8CT8gkknJpXP8es=
X-Google-Smtp-Source: AGHT+IEU6fy5i34ArkZZeaj8r2NZELls8P+t5l6yq/cZbsAVauLjGqw7Ul5ufd1VdTfW9XVrA2N2zg==
X-Received: by 2002:a05:6000:40db:b0:3e5:190b:b04e with SMTP id ffacd0b85a97d-3e765a140f0mr9981489f8f.37.1758011377616;
        Tue, 16 Sep 2025 01:29:37 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e95b111b68sm11006125f8f.32.2025.09.16.01.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 01:29:37 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 1/3] fs: replace use of system_unbound_wq with system_dfl_wq
Date: Tue, 16 Sep 2025 10:29:04 +0200
Message-ID: <20250916082906.77439-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916082906.77439-1-marco.crivellari@suse.com>
References: <20250916082906.77439-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 fs/afs/callback.c                | 4 ++--
 fs/afs/write.c                   | 2 +-
 fs/bcachefs/btree_write_buffer.c | 2 +-
 fs/bcachefs/io_read.c            | 8 ++++----
 fs/bcachefs/journal_io.c         | 2 +-
 fs/btrfs/block-group.c           | 2 +-
 fs/btrfs/extent_map.c            | 2 +-
 fs/btrfs/space-info.c            | 4 ++--
 fs/btrfs/zoned.c                 | 2 +-
 fs/coredump.c                    | 2 +-
 fs/ext4/mballoc.c                | 2 +-
 fs/netfs/misc.c                  | 2 +-
 fs/netfs/objects.c               | 2 +-
 fs/nfsd/filecache.c              | 2 +-
 fs/notify/mark.c                 | 4 ++--
 fs/quota/dquot.c                 | 2 +-
 16 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 69e1dd55b160..894d2bad6b6c 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -42,7 +42,7 @@ static void afs_volume_init_callback(struct afs_volume *volume)
 	list_for_each_entry(vnode, &volume->open_mmaps, cb_mmap_link) {
 		if (vnode->cb_v_check != atomic_read(&volume->cb_v_break)) {
 			afs_clear_cb_promise(vnode, afs_cb_promise_clear_vol_init_cb);
-			queue_work(system_unbound_wq, &vnode->cb_work);
+			queue_work(system_dfl_wq, &vnode->cb_work);
 		}
 	}
 
@@ -90,7 +90,7 @@ void __afs_break_callback(struct afs_vnode *vnode, enum afs_cb_break_reason reas
 		if (reason != afs_cb_break_for_deleted &&
 		    vnode->status.type == AFS_FTYPE_FILE &&
 		    atomic_read(&vnode->cb_nr_mmap))
-			queue_work(system_unbound_wq, &vnode->cb_work);
+			queue_work(system_dfl_wq, &vnode->cb_work);
 
 		trace_afs_cb_break(&vnode->fid, vnode->cb_break, reason, true);
 	} else {
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 2e7526ea883a..93ad86ff3345 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -172,7 +172,7 @@ static void afs_issue_write_worker(struct work_struct *work)
 void afs_issue_write(struct netfs_io_subrequest *subreq)
 {
 	subreq->work.func = afs_issue_write_worker;
-	if (!queue_work(system_unbound_wq, &subreq->work))
+	if (!queue_work(system_dfl_wq, &subreq->work))
 		WARN_ON_ONCE(1);
 }
 
diff --git a/fs/bcachefs/btree_write_buffer.c b/fs/bcachefs/btree_write_buffer.c
index 4b095235a0d2..0afb44ce1a85 100644
--- a/fs/bcachefs/btree_write_buffer.c
+++ b/fs/bcachefs/btree_write_buffer.c
@@ -827,7 +827,7 @@ int bch2_journal_keys_to_write_buffer_end(struct bch_fs *c, struct journal_keys_
 
 	if (bch2_btree_write_buffer_should_flush(c) &&
 	    __enumerated_ref_tryget(&c->writes, BCH_WRITE_REF_btree_write_buffer) &&
-	    !queue_work(system_unbound_wq, &c->btree_write_buffer.flush_work))
+	    !queue_work(system_dfl_wq, &c->btree_write_buffer.flush_work))
 		enumerated_ref_put(&c->writes, BCH_WRITE_REF_btree_write_buffer);
 
 	if (dst->wb == &wb->flushing)
diff --git a/fs/bcachefs/io_read.c b/fs/bcachefs/io_read.c
index e0874ad9a6cf..460e2e6341f1 100644
--- a/fs/bcachefs/io_read.c
+++ b/fs/bcachefs/io_read.c
@@ -684,7 +684,7 @@ static void bch2_rbio_error(struct bch_read_bio *rbio,
 
 	if (bch2_err_matches(ret, BCH_ERR_data_read_retry)) {
 		bch2_rbio_punt(rbio, bch2_rbio_retry,
-			       RBIO_CONTEXT_UNBOUND, system_unbound_wq);
+			       RBIO_CONTEXT_UNBOUND, system_dfl_wq);
 	} else {
 		rbio = bch2_rbio_free(rbio);
 
@@ -921,10 +921,10 @@ static void __bch2_read_endio(struct work_struct *work)
 	bch2_rbio_error(rbio, -BCH_ERR_data_read_retry_csum_err, BLK_STS_IOERR);
 	goto out;
 decompression_err:
-	bch2_rbio_punt(rbio, bch2_read_decompress_err, RBIO_CONTEXT_UNBOUND, system_unbound_wq);
+	bch2_rbio_punt(rbio, bch2_read_decompress_err, RBIO_CONTEXT_UNBOUND, system_dfl_wq);
 	goto out;
 decrypt_err:
-	bch2_rbio_punt(rbio, bch2_read_decrypt_err, RBIO_CONTEXT_UNBOUND, system_unbound_wq);
+	bch2_rbio_punt(rbio, bch2_read_decrypt_err, RBIO_CONTEXT_UNBOUND, system_dfl_wq);
 	goto out;
 }
 
@@ -963,7 +963,7 @@ static void bch2_read_endio(struct bio *bio)
 	    rbio->promote ||
 	    crc_is_compressed(rbio->pick.crc) ||
 	    bch2_csum_type_is_encryption(rbio->pick.crc.csum_type))
-		context = RBIO_CONTEXT_UNBOUND,	wq = system_unbound_wq;
+		context = RBIO_CONTEXT_UNBOUND,	wq = system_dfl_wq;
 	else if (rbio->pick.crc.csum_type)
 		context = RBIO_CONTEXT_HIGHPRI,	wq = system_highpri_wq;
 
diff --git a/fs/bcachefs/journal_io.c b/fs/bcachefs/journal_io.c
index 9e028dbcc3d0..29bea8e0e495 100644
--- a/fs/bcachefs/journal_io.c
+++ b/fs/bcachefs/journal_io.c
@@ -1362,7 +1362,7 @@ int bch2_journal_read(struct bch_fs *c,
 					  BCH_DEV_READ_REF_journal_read))
 			closure_call(&ca->journal.read,
 				     bch2_journal_read_device,
-				     system_unbound_wq,
+				     system_dfl_wq,
 				     &jlist.cl);
 		else
 			degraded = true;
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9bf282d2453c..9a0af7e4a935 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2031,7 +2031,7 @@ void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)
 	btrfs_reclaim_sweep(fs_info);
 	spin_lock(&fs_info->unused_bgs_lock);
 	if (!list_empty(&fs_info->reclaim_bgs))
-		queue_work(system_unbound_wq, &fs_info->reclaim_bgs_work);
+		queue_work(system_dfl_wq, &fs_info->reclaim_bgs_work);
 	spin_unlock(&fs_info->unused_bgs_lock);
 }
 
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 57f52585a6dd..9a5a497edc97 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1372,7 +1372,7 @@ void btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
 	if (atomic64_cmpxchg(&fs_info->em_shrinker_nr_to_scan, 0, nr_to_scan) != 0)
 		return;
 
-	queue_work(system_unbound_wq, &fs_info->em_shrinker_work);
+	queue_work(system_dfl_wq, &fs_info->em_shrinker_work);
 }
 
 void btrfs_init_extent_map_shrinker_work(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 0481c693ac2e..c573d80550ad 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1830,7 +1830,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 							  space_info->flags,
 							  orig_bytes, flush,
 							  "enospc");
-				queue_work(system_unbound_wq, async_work);
+				queue_work(system_dfl_wq, async_work);
 			}
 		} else {
 			list_add_tail(&ticket.list,
@@ -1847,7 +1847,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		    need_preemptive_reclaim(fs_info, space_info)) {
 			trace_btrfs_trigger_flush(fs_info, space_info->flags,
 						  orig_bytes, flush, "preempt");
-			queue_work(system_unbound_wq,
+			queue_work(system_dfl_wq,
 				   &fs_info->preempt_reclaim_work);
 		}
 	}
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index ea662036f441..3d554ebca08c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2515,7 +2515,7 @@ void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
 	refcount_inc(&eb->refs);
 	bg->last_eb = eb;
 	INIT_WORK(&bg->zone_finish_work, btrfs_zone_finish_endio_workfn);
-	queue_work(system_unbound_wq, &bg->zone_finish_work);
+	queue_work(system_dfl_wq, &bg->zone_finish_work);
 }
 
 void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg)
diff --git a/fs/coredump.c b/fs/coredump.c
index 5dce257c67fc..f36354785e11 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -635,7 +635,7 @@ static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
 
 		/*
 		 * Usermode helpers are childen of either
-		 * system_unbound_wq or of kthreadd. So we know that
+		 * system_dfl_wq or of kthreadd. So we know that
 		 * we're starting off with a clean file descriptor
 		 * table. So we should always be able to use
 		 * COREDUMP_PIDFD_NUMBER as our file descriptor value.
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5898d92ba19f..8b18802e83eb 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3995,7 +3995,7 @@ void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid)
 		list_splice_tail(&freed_data_list, &sbi->s_discard_list);
 		spin_unlock(&sbi->s_md_lock);
 		if (wake)
-			queue_work(system_unbound_wq, &sbi->s_discard_work);
+			queue_work(system_dfl_wq, &sbi->s_discard_work);
 	} else {
 		list_for_each_entry_safe(entry, tmp, &freed_data_list, efd_list)
 			kmem_cache_free(ext4_free_data_cachep, entry);
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 20748bcfbf59..486166460e17 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -321,7 +321,7 @@ void netfs_wake_collector(struct netfs_io_request *rreq)
 {
 	if (test_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &rreq->flags) &&
 	    !test_bit(NETFS_RREQ_RETRYING, &rreq->flags)) {
-		queue_work(system_unbound_wq, &rreq->work);
+		queue_work(system_dfl_wq, &rreq->work);
 	} else {
 		trace_netfs_rreq(rreq, netfs_rreq_trace_wake_queue);
 		wake_up(&rreq->waitq);
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index e8c99738b5bb..2ebe56b24ddd 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -163,7 +163,7 @@ void netfs_put_request(struct netfs_io_request *rreq, enum netfs_rreq_ref_trace
 		dead = __refcount_dec_and_test(&rreq->ref, &r);
 		trace_netfs_rreq_ref(debug_id, r - 1, what);
 		if (dead)
-			WARN_ON(!queue_work(system_unbound_wq, &rreq->cleanup_work));
+			WARN_ON(!queue_work(system_dfl_wq, &rreq->cleanup_work));
 	}
 }
 
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 732abf6b92a5..85ca663c052c 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -113,7 +113,7 @@ static void
 nfsd_file_schedule_laundrette(void)
 {
 	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags))
-		queue_delayed_work(system_unbound_wq, &nfsd_filecache_laundrette,
+		queue_delayed_work(system_dfl_wq, &nfsd_filecache_laundrette,
 				   NFSD_LAUNDRETTE_DELAY);
 }
 
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 798340db69d7..55a03bb05aa1 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -428,7 +428,7 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 		conn->destroy_next = connector_destroy_list;
 		connector_destroy_list = conn;
 		spin_unlock(&destroy_lock);
-		queue_work(system_unbound_wq, &connector_reaper_work);
+		queue_work(system_dfl_wq, &connector_reaper_work);
 	}
 	/*
 	 * Note that we didn't update flags telling whether inode cares about
@@ -439,7 +439,7 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 	spin_lock(&destroy_lock);
 	list_add(&mark->g_list, &destroy_list);
 	spin_unlock(&destroy_lock);
-	queue_delayed_work(system_unbound_wq, &reaper_work,
+	queue_delayed_work(system_dfl_wq, &reaper_work,
 			   FSNOTIFY_REAPER_DELAY);
 }
 EXPORT_SYMBOL_GPL(fsnotify_put_mark);
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index df4a9b348769..afa15a214538 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -881,7 +881,7 @@ void dqput(struct dquot *dquot)
 	put_releasing_dquots(dquot);
 	atomic_dec(&dquot->dq_count);
 	spin_unlock(&dq_list_lock);
-	queue_delayed_work(system_unbound_wq, &quota_release_work, 1);
+	queue_delayed_work(system_dfl_wq, &quota_release_work, 1);
 }
 EXPORT_SYMBOL(dqput);
 
-- 
2.51.0



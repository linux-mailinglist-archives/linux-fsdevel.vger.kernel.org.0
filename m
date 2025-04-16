Return-Path: <linux-fsdevel+bounces-46415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4751EA88EE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 00:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF743A6687
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 22:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7421F4C8E;
	Mon, 14 Apr 2025 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="l5R3Q48F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B731F3BBB
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744668627; cv=none; b=NrLU9aod3/cXXR0GK+RukQ9+D9RI5WgHtcUFGaf7USopdZ0I+J5KQUJdB4HPcMPueS31HtC73h9jShEmF1VJyzoD6VfR4t/UFwj2CV26FBHXK235PVrq0JTYC1Mi8f344ilPvhikOvVMIrjZeRYKtr+6yqGdNzj9NrlrvKTnCEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744668627; c=relaxed/simple;
	bh=ts1XFRz/vJcTex7wzUclZxeUUaLAKQfKYPaz1SidHfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XIYy0uLNNmvUYYRWxBewx9RmOHaWdxxiQWQ8CJcbZ+mbUZycq2x5yO95Hjf5tSJ3dltqsqxiw0wRxHpdGVhwPT48sXdwvsi3fPNfklnAkl9mXrCAkjXzSVC/hC8Q3Dro/II9JtM5wo/DlA0UuzPWbLJcOLaR7Uk3T8RfZVU44q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=l5R3Q48F; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-225477548e1so47059005ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 15:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1744668624; x=1745273424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=raRuGwK+/0ttpwLQcYn28m66h5gvEGKw71t32e1sEzg=;
        b=l5R3Q48FzYNjdI2KXZUigo964g+C5O+Fuq1nGF2FhGobHUV9E6N1GgynrJsceZuYXG
         FC2TEOjNCO3LVrwTnpW1RgWt7O0K8DOpwC2neQ6zL2shoOtgzp5S7ZbqH5Bya1loLBj2
         2u1nsbRO57RlfYYlPmUu9jIjG71Phv272STzoXUhSFNHC1OIhP0ZffkY3be8PTPUUVCm
         NhaCzONAgXWMWuGnwjNLPSSGps7TVWqBQnksaKuAES20PYMoJWwAXlZFSrX02d/jEFj4
         uADlOjLooTjgoNmRZJY57gsGY4qBvlCR2kEUxcXNoNCNblC1P8fGAjsmbOqFSTFkIs5D
         XfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744668624; x=1745273424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=raRuGwK+/0ttpwLQcYn28m66h5gvEGKw71t32e1sEzg=;
        b=OlGvdhzl8ScxCdpVSRuXUHpjlqnM6ldJ8BjSKvsTWA0+Qfji8jgggVuUHgD45HkfzC
         LCyX9BlIauJjKhoqMJiQLczinjRTRQL+x0wgCxgBZVJNL4BtUlHJRqpYTcRut1L4RaQB
         ekfsg/mXQO7oP3bHjj/Yy1jJ821JpwvMJRZJPJSb6JUXDt/1CHzlCa0pHr/13wjaOcqU
         2BMWzvhdBbaqQ0XnWNRsnktlphDeAv3F8MDhMLW8UQM24sIsjOiZjQ7ACyHpeNn6Hd2u
         rDAli8trIT3ryEmY4YCBPUg9suHsAMqEjSGTdYOYP1+CZak8z+h8OrBRs47cGQBhxAc3
         d5Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXj5illB0v97k2ABNYdx5NrH5TWM1HDkYyJuDQe0J57LGv8jYqoEKct2X/5nOC07hwocXjo5MIvyCoYcoGt@vger.kernel.org
X-Gm-Message-State: AOJu0YwXrMBWKPP5NosjL1VxB8ect7niUaiBqZ1xkvUrllrtpB6WnjrD
	j2JnGDb982+fOiAUDTcvm6qNucuGjYdjeNVnoR0CGQZnKuqHQhdQIwaenDz+Rhs=
X-Gm-Gg: ASbGncuyBtRxE/GPs7XoM0ESYYrOuLYL7odlyZExE1p/EtWF8iOLhYib4rQp9GGEmqj
	YS2910uPTGEXVDcA7eFYCCM4UJ5GNyti9eH79Oz9z76QXIPa9Z3tPD+eIwTO/b6dE5EZ9zx/WAv
	wEF6MvQiJ9Ka+3tw5dI8UTD7ahwKfQqRCgBmCKuzsFxbgAd3qi4NjLF2ShJbgmya9Yrfe+vJ6Gr
	Nq9VqE2yNCu//37MrBpAVZWLGzju6prrgSTYZxAJkE6Fmjt8104vFMFe/Z5bvoc7OAHNqdF9RXf
	7r1qbkJLIQOH8iMGWBl3EKwJaPPjVGS6mVm4uqiaHWSZPokuEQKk6fbVMvg=
X-Google-Smtp-Source: AGHT+IGK6JxqHcG4BDp0iv2uM0+ZqsmDAdhq3JUG2irRs1E6OCEPvBqhZ5k4WmcywslxKKdzx5PkGg==
X-Received: by 2002:a17:902:d551:b0:220:cb1a:da5 with SMTP id d9443c01a7336-22bea4efefamr228178705ad.40.1744668624161;
        Mon, 14 Apr 2025 15:10:24 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:879f:4651:9291:7696])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b90d99sm103880845ad.99.2025.04.14.15.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 15:10:23 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org,
	idryomov@gmail.com
Cc: dhowells@redhat.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH v5] ceph: fix slab-use-after-free in have_mon_and_osd_map()
Date: Mon, 14 Apr 2025 15:10:13 -0700
Message-ID: <20250414221013.157819-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The generic/395 and generic/397 is capable of generating
the oops is on line net/ceph/ceph_common.c:794 with
KASAN enabled.

BUG: KASAN: slab-use-after-free in have_mon_and_osd_map+0x56/0x70
Read of size 4 at addr ffff88811012d810 by task mount.ceph/13305

CPU: 2 UID: 0 PID: 13305 Comm: mount.ceph Not tainted 6.14.0-rc2-build2+ #1266
Hardware name: ASUS All Series/H97-PLUS, BIOS 2306 10/09/2014
Call Trace:
<TASK>
dump_stack_lvl+0x57/0x80
? have_mon_and_osd_map+0x56/0x70
print_address_description.constprop.0+0x84/0x330
? have_mon_and_osd_map+0x56/0x70
print_report+0xe2/0x1e0
? rcu_read_unlock_sched+0x60/0x80
? kmem_cache_debug_flags+0xc/0x20
? fixup_red_left+0x17/0x30
? have_mon_and_osd_map+0x56/0x70
kasan_report+0x8d/0xc0
? have_mon_and_osd_map+0x56/0x70
have_mon_and_osd_map+0x56/0x70
ceph_open_session+0x182/0x290
? __pfx_ceph_open_session+0x10/0x10
? __init_swait_queue_head+0x8d/0xa0
? __pfx_autoremove_wake_function+0x10/0x10
? shrinker_register+0xdd/0xf0
ceph_get_tree+0x333/0x680
vfs_get_tree+0x49/0x180
do_new_mount+0x1a3/0x2d0
? __pfx_do_new_mount+0x10/0x10
? security_capable+0x39/0x70
path_mount+0x6dd/0x730
? __pfx_path_mount+0x10/0x10
? kmem_cache_free+0x1e5/0x270
? user_path_at+0x48/0x60
do_mount+0x99/0xe0
? __pfx_do_mount+0x10/0x10
? lock_release+0x155/0x190
__do_sys_mount+0x141/0x180
do_syscall_64+0x9f/0x100
entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f01b1b14f3e
Code: 48 8b 0d d5 3e 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a2 3e 0f 00 f7 d8 64 89 01 48
RSP: 002b:00007fffd129fa08 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000564ec01a7850 RCX: 00007f01b1b14f3e
RDX: 0000564ec00f2225 RSI: 00007fffd12a1964 RDI: 0000564ec0147a20
RBP: 00007fffd129fbd0 R08: 0000564ec014da90 R09: 0000000000000080
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffd12a194e
R13: 0000000000000000 R14: 00007fffd129fa50 R15: 00007fffd129fa40
</TASK>

Allocated by task 13305:
stack_trace_save+0x8c/0xc0
kasan_save_stack+0x1e/0x40
kasan_save_track+0x10/0x30
__kasan_kmalloc+0x3a/0x50
__kmalloc_noprof+0x247/0x290
ceph_osdmap_alloc+0x16/0x130
ceph_osdc_init+0x27a/0x4c0
ceph_create_client+0x153/0x190
create_fs_client+0x50/0x2a0
ceph_get_tree+0xff/0x680
vfs_get_tree+0x49/0x180
do_new_mount+0x1a3/0x2d0
path_mount+0x6dd/0x730
do_mount+0x99/0xe0
__do_sys_mount+0x141/0x180
do_syscall_64+0x9f/0x100
entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 9475:
stack_trace_save+0x8c/0xc0
kasan_save_stack+0x1e/0x40
kasan_save_track+0x10/0x30
kasan_save_free_info+0x3b/0x50
__kasan_slab_free+0x18/0x30
kfree+0x212/0x290
handle_one_map+0x23c/0x3b0
ceph_osdc_handle_map+0x3c9/0x590
mon_dispatch+0x655/0x6f0
ceph_con_process_message+0xc3/0xe0
ceph_con_v1_try_read+0x614/0x760
ceph_con_workfn+0x2de/0x650
process_one_work+0x486/0x7c0
process_scheduled_works+0x73/0x90
worker_thread+0x1c8/0x2a0
kthread+0x2ec/0x300
ret_from_fork+0x24/0x40
ret_from_fork_asm+0x1a/0x30

The buggy address belongs to the object at ffff88811012d800
which belongs to the cache kmalloc-512 of size 512
The buggy address is located 16 bytes inside of
freed 512-byte region [ffff88811012d800, ffff88811012da00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11012c
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x200000000000040(head|node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000040 ffff888100042c80 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 0200000000000040 ffff888100042c80 dead000000000100 dead000000000122
head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 0200000000000002 ffffea0004404b01 ffffffffffffffff 0000000000000000
head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
ffff88811012d700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88811012d780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

    ffff88811012d800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

^
ffff88811012d880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff88811012d900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb ==================================================================
Disabling lock debugging due to kernel taint
libceph: client274326 fsid 8598140e-35c2-11ee-b97c-001517c545cc
libceph: mon0 (1)90.155.74.19:6789 session established
libceph: client274327 fsid 8598140e-35c2-11ee-b97c-001517c545cc

We have such scenario:

Thread 1:
void ceph_osdmap_destroy(...) {
    <skipped>
    kfree(map);
}
Thread 1 sleep...

Thread 2:
static bool have_mon_and_osd_map(struct ceph_client *client) {
    return client->monc.monmap && client->monc.monmap->epoch &&
        client->osdc.osdmap && client->osdc.osdmap->epoch;
}
Thread 2 has oops...

Thread 1 wake up:
static int handle_one_map(...) {
    <skipped>
    osdc->osdmap = newmap;
    <skipped>
}

This patch introduces a have_mon_and_osd_map atomic_t
field in struct ceph_client. If there is no OSD and
monitor maps, then the client->have_mon_and_osd_map
is equal to zero. The OSD and monitor maps initialization
results in incrementing of client->have_mon_and_osd_map
under the lock. As a result, have_mon_and_osd_map() function
simply checks now that client->have_mon_and_osd_map is equal to
CEPH_CLIENT_HAS_MON_AND_OSD_MAP.

Patch adds locking in the ceph_osdc_stop()
method during the destructruction of osdc->osdmap and
assigning of NULL to the pointer. The lock is used
in the ceph_monc_stop() during the freeing of monc->monmap
and assigning NULL to the pointer too. The monmap_show()
and osdmap_show() methods were reworked to prevent
the potential race condition during the methods call.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 include/linux/ceph/libceph.h | 20 ++++++++++++++++++++
 net/ceph/ceph_common.c       |  6 ++++--
 net/ceph/debugfs.c           | 17 +++++++++++++----
 net/ceph/mon_client.c        | 18 +++++++++++++++++-
 net/ceph/osd_client.c        | 11 +++++++++++
 5 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 733e7f93db66..f5694bf5bd54 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -132,6 +132,7 @@ struct ceph_client {
 	struct ceph_messenger msgr;   /* messenger instance */
 	struct ceph_mon_client monc;
 	struct ceph_osd_client osdc;
+	atomic_t have_mon_and_osd_map;
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_dir;
@@ -141,6 +142,25 @@ struct ceph_client {
 #endif
 };
 
+/*
+ * The have_mon_and_osd_map possible states
+ */
+enum {
+	CEPH_CLIENT_HAS_NO_MON_AND_NO_OSD_MAP = 0,
+	CEPH_CLIENT_HAS_ONLY_ONE_MAP = 1,
+	CEPH_CLIENT_HAS_MON_AND_OSD_MAP = 2,
+	CEPH_CLIENT_MAP_STATE_UNKNOWN
+};
+
+static inline
+bool is_mon_and_osd_map_state_invalid(struct ceph_client *client)
+{
+	int have_mon_and_osd_map = atomic_read(&client->have_mon_and_osd_map);
+
+	return have_mon_and_osd_map < CEPH_CLIENT_HAS_NO_MON_AND_NO_OSD_MAP ||
+		have_mon_and_osd_map >= CEPH_CLIENT_MAP_STATE_UNKNOWN;
+}
+
 #define from_msgr(ms)	container_of(ms, struct ceph_client, msgr)
 
 static inline bool ceph_msgr2(struct ceph_client *client)
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 4c6441536d55..62efceb3b19d 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -723,6 +723,8 @@ struct ceph_client *ceph_create_client(struct ceph_options *opt, void *private)
 
 	mutex_init(&client->mount_mutex);
 	init_waitqueue_head(&client->auth_wq);
+	atomic_set(&client->have_mon_and_osd_map,
+		   CEPH_CLIENT_HAS_NO_MON_AND_NO_OSD_MAP);
 	client->auth_err = 0;
 
 	client->extra_mon_dispatch = NULL;
@@ -790,8 +792,8 @@ EXPORT_SYMBOL(ceph_reset_client_addr);
  */
 static bool have_mon_and_osd_map(struct ceph_client *client)
 {
-	return client->monc.monmap && client->monc.monmap->epoch &&
-	       client->osdc.osdmap && client->osdc.osdmap->epoch;
+	return atomic_read(&client->have_mon_and_osd_map) ==
+				CEPH_CLIENT_HAS_MON_AND_OSD_MAP;
 }
 
 /*
diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
index 2110439f8a24..7b45c169a859 100644
--- a/net/ceph/debugfs.c
+++ b/net/ceph/debugfs.c
@@ -36,8 +36,10 @@ static int monmap_show(struct seq_file *s, void *p)
 	int i;
 	struct ceph_client *client = s->private;
 
+	mutex_lock(&client->monc.mutex);
+
 	if (client->monc.monmap == NULL)
-		return 0;
+		goto out_unlock;
 
 	seq_printf(s, "epoch %d\n", client->monc.monmap->epoch);
 	for (i = 0; i < client->monc.monmap->num_mon; i++) {
@@ -48,6 +50,10 @@ static int monmap_show(struct seq_file *s, void *p)
 			   ENTITY_NAME(inst->name),
 			   ceph_pr_addr(&inst->addr));
 	}
+
+out_unlock:
+	mutex_unlock(&client->monc.mutex);
+
 	return 0;
 }
 
@@ -56,13 +62,15 @@ static int osdmap_show(struct seq_file *s, void *p)
 	int i;
 	struct ceph_client *client = s->private;
 	struct ceph_osd_client *osdc = &client->osdc;
-	struct ceph_osdmap *map = osdc->osdmap;
+	struct ceph_osdmap *map = NULL;
 	struct rb_node *n;
 
+	down_read(&osdc->lock);
+
+	map = osdc->osdmap;
 	if (map == NULL)
-		return 0;
+		goto out_unlock;
 
-	down_read(&osdc->lock);
 	seq_printf(s, "epoch %u barrier %u flags 0x%x\n", map->epoch,
 			osdc->epoch_barrier, map->flags);
 
@@ -131,6 +139,7 @@ static int osdmap_show(struct seq_file *s, void *p)
 		seq_printf(s, "]\n");
 	}
 
+out_unlock:
 	up_read(&osdc->lock);
 	return 0;
 }
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index ab66b599ac47..5cf802236426 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -562,12 +562,16 @@ static void ceph_monc_handle_map(struct ceph_mon_client *monc,
 		goto out;
 	}
 
+	atomic_dec(&client->have_mon_and_osd_map);
+
 	kfree(monc->monmap);
 	monc->monmap = monmap;
 
 	__ceph_monc_got_map(monc, CEPH_SUB_MONMAP, monc->monmap->epoch);
 	client->have_fsid = true;
 
+	atomic_inc(&client->have_mon_and_osd_map);
+
 out:
 	mutex_unlock(&monc->mutex);
 	wake_up_all(&client->auth_wq);
@@ -1220,6 +1224,9 @@ int ceph_monc_init(struct ceph_mon_client *monc, struct ceph_client *cl)
 
 	monc->fs_cluster_id = CEPH_FS_CLUSTER_ID_NONE;
 
+	atomic_inc(&monc->client->have_mon_and_osd_map);
+	WARN_ON(is_mon_and_osd_map_state_invalid(monc->client));
+
 	return 0;
 
 out_auth_reply:
@@ -1232,6 +1239,7 @@ int ceph_monc_init(struct ceph_mon_client *monc, struct ceph_client *cl)
 	ceph_auth_destroy(monc->auth);
 out_monmap:
 	kfree(monc->monmap);
+	monc->monmap = NULL;
 out:
 	return err;
 }
@@ -1239,6 +1247,8 @@ EXPORT_SYMBOL(ceph_monc_init);
 
 void ceph_monc_stop(struct ceph_mon_client *monc)
 {
+	struct ceph_monmap *old_monmap;
+
 	dout("stop\n");
 
 	mutex_lock(&monc->mutex);
@@ -1266,7 +1276,13 @@ void ceph_monc_stop(struct ceph_mon_client *monc)
 	ceph_msg_put(monc->m_subscribe);
 	ceph_msg_put(monc->m_subscribe_ack);
 
-	kfree(monc->monmap);
+	mutex_lock(&monc->mutex);
+	WARN_ON(is_mon_and_osd_map_state_invalid(monc->client));
+	atomic_dec(&monc->client->have_mon_and_osd_map);
+	old_monmap = monc->monmap;
+	monc->monmap = NULL;
+	mutex_unlock(&monc->mutex);
+	kfree(old_monmap);
 }
 EXPORT_SYMBOL(ceph_monc_stop);
 
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index b24afec24138..14a91603bf6d 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -4068,8 +4068,10 @@ static int handle_one_map(struct ceph_osd_client *osdc,
 			skipped_map = true;
 		}
 
+		atomic_dec(&osdc->client->have_mon_and_osd_map);
 		ceph_osdmap_destroy(osdc->osdmap);
 		osdc->osdmap = newmap;
+		atomic_inc(&osdc->client->have_mon_and_osd_map);
 	}
 
 	was_full &= !ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL);
@@ -5266,6 +5268,9 @@ int ceph_osdc_init(struct ceph_osd_client *osdc, struct ceph_client *client)
 	schedule_delayed_work(&osdc->osds_timeout_work,
 	    round_jiffies_relative(osdc->client->options->osd_idle_ttl));
 
+	atomic_inc(&osdc->client->have_mon_and_osd_map);
+	WARN_ON(is_mon_and_osd_map_state_invalid(osdc->client));
+
 	return 0;
 
 out_notify_wq:
@@ -5278,6 +5283,7 @@ int ceph_osdc_init(struct ceph_osd_client *osdc, struct ceph_client *client)
 	mempool_destroy(osdc->req_mempool);
 out_map:
 	ceph_osdmap_destroy(osdc->osdmap);
+	osdc->osdmap = NULL;
 out:
 	return err;
 }
@@ -5306,10 +5312,15 @@ void ceph_osdc_stop(struct ceph_osd_client *osdc)
 	WARN_ON(atomic_read(&osdc->num_requests));
 	WARN_ON(atomic_read(&osdc->num_homeless));
 
+	down_write(&osdc->lock);
+	WARN_ON(is_mon_and_osd_map_state_invalid(osdc->client));
+	atomic_dec(&osdc->client->have_mon_and_osd_map);
 	ceph_osdmap_destroy(osdc->osdmap);
+	osdc->osdmap = NULL;
 	mempool_destroy(osdc->req_mempool);
 	ceph_msgpool_destroy(&osdc->msgpool_op);
 	ceph_msgpool_destroy(&osdc->msgpool_op_reply);
+	up_write(&osdc->lock);
 }
 
 int osd_req_op_copy_from_init(struct ceph_osd_request *req,
-- 
2.48.0



Return-Path: <linux-fsdevel+bounces-43005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17906A4CCC7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 21:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284323AB0F7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 20:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F7623535E;
	Mon,  3 Mar 2025 20:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="ohLsTREY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65DF22FAC3
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 20:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741033925; cv=none; b=NZg73ZOn7N1NOpq/k50iztWM1YD1jNERM3q83ldSJbmIPgsB+1A4ZYZ7F9SUPti9T9sz65jElQFYevwwZUWe4Fj9a5BabnyIX3BXD2mcOZNGdtSdiLixPonfVqw38G5c1NlU844cTy1PIvkzumh/9mGP1BXM6FOHSUETXUVT+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741033925; c=relaxed/simple;
	bh=Ky/v4Jq4mLBuC0uMMiNDLX+QN9JsPMRdDqksb0TXMWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OEQekebimgH7KV38YnqqdyoWiY/IGf5GKgJGbEwerFY6W4Lp9B/t/WPIXToGlVmTxycLMMBFkyQW5C2VZd1qozsWikwXVg8Q+GOo5WWaZQsIdMSVRRk375gm3C6EAStQlNIF5o2JQAlv6ZUhqvxpcKa1sQJcORiUBlzZHc70MMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=ohLsTREY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223594b3c6dso83888015ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 12:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1741033922; x=1741638722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hxJv2w2JyRi4anhbOoHNOqd8NhqQPocQn4CUgj7E56c=;
        b=ohLsTREYNqCQRsBcH75PQr0iWs3+3d4cGolGep0hP8FP7nwKdoZaKt3viLhRN6hw8d
         vbJ/jwecBpc+oSV/+6mrcxR2qFJDGWF87JkyWl/B3TPA7GdMwc52zyGXGviJsiWOMkL6
         o12q9jcsymDCpn74CM7kE2RXnf2ljHAVCq91qsMqjTTvfk1K8W7mtqA0t8lGzxKc8WaM
         spBLX4WrZIb8uTjq9nY2DE0TiKV+CaYAxGsGc7slT+nFGelXU7rJSFn2CFkHbLX0xy2i
         +a0PEaphvbdcqQnj/YRvXzNZeXfR6HgwK3LcrQRU4fAiNZ6lijfm7qBu/f31Bmkd8Q2D
         bmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741033922; x=1741638722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hxJv2w2JyRi4anhbOoHNOqd8NhqQPocQn4CUgj7E56c=;
        b=jFslKzDJhYLv2RV9KX5IXt9ICjSO0MIHh+lKzK72fyDTXKzC1RqYnf1oUo1aq+4TDX
         OyHoPdb38P+5d4EPTiM38KoQGRLai2swN4NHbbVV6smT0DoRT+kL1mazotoZvnDJNmGn
         ZZk7Y23CSKkykkdsqSnwQaoUZc0FSfKtIbKdoVfdh1P1S+scsd+KpcjKpVo+keG0D91k
         Uom+eknjYIQONuQZ3sFKpIXV1gpO1IcJ4EBKTv1ylaurZEm4fMjFV9TPwo6a2calr6fP
         0qqVqR+smnT6JvvG03xOVpfNA8GJmY0Hitfq0+A6dpKKZFPcosS7WZFN7DgqTGrOoCgl
         jo+g==
X-Forwarded-Encrypted: i=1; AJvYcCX3cjlFD/fdkmz0Ypcy4Bk4NHGROwnx8zFD0oL64+SlTFhQIGbRiAITtV4LEoFa7diZVk4kEyzOKLx/G9m6@vger.kernel.org
X-Gm-Message-State: AOJu0YyuVFIzZguqexgNubiLpAOkj80X4eJrObOZngE/MyoOcSX4LTt+
	GKiLq9BsnpOiiSf0rA6orUb3soSY93plNjtUN0R6+xp6jQj5dl9qoj0qVrRa4k4=
X-Gm-Gg: ASbGncuRh6F9pgAnSYzjN2aW4RpAQyCBvvHejvhw3/10t9dxTMqCBwrzyu9s0nObUgp
	AYfLB5oy+/bOkb/FJrQdVkdMu/lU6yOKJydd0Ul9iYZyK3bGnuKjCEN5xWEiMFaO/C4cnB9jFRc
	GxrD1OOtdZLzZV7MZ8zhTpDFaYJ/MmIAiH1j6LdkZAPB9tjdXxZLSeqIoT0DXxYRqhaunOITUle
	9Vca9EYHnJt2NokWwuohKLZqr1o95sHWPDdMhocv8TN8vJ3Dlw/UMd3/qVoTfvq63n6hBKSRxkj
	hxjOv58O5DLm/KME2XQzKBXsY7fS3/kJhZV6uwlJ9NdHWiblMbJNqgTwCv8PLg==
X-Google-Smtp-Source: AGHT+IEqSzW8DQiA+/nstNjr8XMBeiVtlMUtvUOdIOGYvdx61lEdjTAxvPcKqGPEK4SDDT7WLcQRwg==
X-Received: by 2002:a17:903:2ca:b0:223:619e:71e9 with SMTP id d9443c01a7336-22368f6dc5emr243922285ad.11.1741033921695;
        Mon, 03 Mar 2025 12:32:01 -0800 (PST)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:c99d:79f9:4c0:6f8e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c8665sm82322235ad.156.2025.03.03.12.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 12:32:00 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org,
	dhowells@redhat.com,
	amarkuze@redhat.com
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH v3] ceph: fix slab-use-after-free in have_mon_and_osd_map()
Date: Mon,  3 Mar 2025 12:31:37 -0800
Message-ID: <20250303203137.42636-1-slava@dubeyko.com>
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

This patch fixes the issue by means of locking
client->osdc.lock and client->monc.mutex before
the checking client->osdc.osdmap and
client->monc.monmap in have_mon_and_osd_map() function.
Patch adds locking in the ceph_osdc_stop()
method during the destructruction of osdc->osdmap and
assigning of NULL to the pointer. The lock is used
in the ceph_monc_stop() during the freeing of monc->monmap
and assigning NULL to the pointer too. The monmap_show()
and osdmap_show() methods were reworked to prevent
the potential race condition during the methods call.

Reported-by: David Howells <dhowells@redhat.com>
Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 net/ceph/ceph_common.c | 14 ++++++++++++--
 net/ceph/debugfs.c     | 33 +++++++++++++++++++--------------
 net/ceph/mon_client.c  |  4 ++++
 net/ceph/osd_client.c  |  4 ++++
 4 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 4c6441536d55..5c8fd78d6bd5 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -790,8 +790,18 @@ EXPORT_SYMBOL(ceph_reset_client_addr);
  */
 static bool have_mon_and_osd_map(struct ceph_client *client)
 {
-	return client->monc.monmap && client->monc.monmap->epoch &&
-	       client->osdc.osdmap && client->osdc.osdmap->epoch;
+	bool have_mon_map = false;
+	bool have_osd_map = false;
+
+	mutex_lock(&client->monc.mutex);
+	have_mon_map = client->monc.monmap && client->monc.monmap->epoch;
+	mutex_unlock(&client->monc.mutex);
+
+	down_read(&client->osdc.lock);
+	have_osd_map = client->osdc.osdmap && client->osdc.osdmap->epoch;
+	up_read(&client->osdc.lock);
+
+	return have_mon_map && have_osd_map;
 }
 
 /*
diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
index 2110439f8a24..6e2014c813ca 100644
--- a/net/ceph/debugfs.c
+++ b/net/ceph/debugfs.c
@@ -36,18 +36,20 @@ static int monmap_show(struct seq_file *s, void *p)
 	int i;
 	struct ceph_client *client = s->private;
 
-	if (client->monc.monmap == NULL)
-		return 0;
-
-	seq_printf(s, "epoch %d\n", client->monc.monmap->epoch);
-	for (i = 0; i < client->monc.monmap->num_mon; i++) {
-		struct ceph_entity_inst *inst =
-			&client->monc.monmap->mon_inst[i];
-
-		seq_printf(s, "\t%s%lld\t%s\n",
-			   ENTITY_NAME(inst->name),
-			   ceph_pr_addr(&inst->addr));
+	mutex_lock(&client->monc.mutex);
+	if (client->monc.monmap) {
+		seq_printf(s, "epoch %d\n", client->monc.monmap->epoch);
+		for (i = 0; i < client->monc.monmap->num_mon; i++) {
+			struct ceph_entity_inst *inst =
+				&client->monc.monmap->mon_inst[i];
+
+			seq_printf(s, "\t%s%lld\t%s\n",
+				   ENTITY_NAME(inst->name),
+				   ceph_pr_addr(&inst->addr));
+		}
 	}
+	mutex_unlock(&client->monc.mutex);
+
 	return 0;
 }
 
@@ -56,13 +58,15 @@ static int osdmap_show(struct seq_file *s, void *p)
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
+		goto finish_osdmap_show;
 
-	down_read(&osdc->lock);
 	seq_printf(s, "epoch %u barrier %u flags 0x%x\n", map->epoch,
 			osdc->epoch_barrier, map->flags);
 
@@ -131,6 +135,7 @@ static int osdmap_show(struct seq_file *s, void *p)
 		seq_printf(s, "]\n");
 	}
 
+finish_osdmap_show:
 	up_read(&osdc->lock);
 	return 0;
 }
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index ab66b599ac47..5013bddb52ba 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -1232,6 +1232,7 @@ int ceph_monc_init(struct ceph_mon_client *monc, struct ceph_client *cl)
 	ceph_auth_destroy(monc->auth);
 out_monmap:
 	kfree(monc->monmap);
+	monc->monmap = NULL;
 out:
 	return err;
 }
@@ -1266,7 +1267,10 @@ void ceph_monc_stop(struct ceph_mon_client *monc)
 	ceph_msg_put(monc->m_subscribe);
 	ceph_msg_put(monc->m_subscribe_ack);
 
+	mutex_lock(&monc->mutex);
 	kfree(monc->monmap);
+	monc->monmap = NULL;
+	mutex_unlock(&monc->mutex);
 }
 EXPORT_SYMBOL(ceph_monc_stop);
 
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index b24afec24138..762f4df5763b 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -5278,6 +5278,7 @@ int ceph_osdc_init(struct ceph_osd_client *osdc, struct ceph_client *client)
 	mempool_destroy(osdc->req_mempool);
 out_map:
 	ceph_osdmap_destroy(osdc->osdmap);
+	osdc->osdmap = NULL;
 out:
 	return err;
 }
@@ -5306,10 +5307,13 @@ void ceph_osdc_stop(struct ceph_osd_client *osdc)
 	WARN_ON(atomic_read(&osdc->num_requests));
 	WARN_ON(atomic_read(&osdc->num_homeless));
 
+	down_write(&osdc->lock);
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



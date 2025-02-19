Return-Path: <linux-fsdevel+bounces-42026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E06C9A3AD22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 01:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77DDD7A3565
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 00:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBB71805A;
	Wed, 19 Feb 2025 00:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="0BHudEcu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0878DF42
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 00:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739925277; cv=none; b=rIGc1p8riwIMwWiwjP48sgWLwnxSX5VGLSp81JlAvXQljZ1b+upwJaTS91oXbjJj++bUhh4FEIajqFqm6ZPZNQic8CV2IH/Mf7RnJActGVYnRZ9op4UNkK2lo7jlZ2vMRfi3x2ygbGYZnW7F3Uq0ocpwiiaB/lWVJtDOxcA7IP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739925277; c=relaxed/simple;
	bh=3Dw7qGtdMe8WhR/rAC9PTkUkNqQey6CJNGQXL7Wf2lA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IMvcFWZ41Sut65AJICeKvur+qTlk2R5NjzYQCD2iNq3KoS4yPOuAlCe/fvJNgaOyUya1ChPFnIGX7qUypttK0AR4VriqMo4D2d+yBSUK8dUqiKjcFMP6nWvJCwzUqUCEwAVLBPSOnlmRiea1VmxxO4biD/UfdfLPqz7hQVmhcJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=0BHudEcu; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72720572addso1996763a34.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 16:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1739925274; x=1740530074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8wzotNFW7xid1rWh6YdS7/7hpcOI3er8dmJgrWKbR+I=;
        b=0BHudEcu6DUJWzzwwKTmUOE2PSeTcWYGH7md1MK4jocYU6XgkWHzNox0Yo//jZTzSO
         0OHF1nr0Mv2PxEezZhLHW9teJFuRQViIOQ9OlzbdVf/uBxBE7H1EnEgKiqV30uHCpxER
         OIOmU2KAed9E0ZHzgEsUJWkcY7SRCHNUtZQ7lYzo9XxU9pR1w8b8q2hS868H0w+jEqgW
         4JFfrncEAQal6gX0vVAltlHWsGtwwkqx0VHzMZthSAa+lxCc9AkgTT+WkzsEXTBKHjGp
         Cm0tm0igwENo4AQbJFIcHBanfqk8rT679JhCNVpcAc2Qs5w9NK/ckG+UqnYzbBCExi58
         4TZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739925274; x=1740530074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wzotNFW7xid1rWh6YdS7/7hpcOI3er8dmJgrWKbR+I=;
        b=LN4srX1thpwNM8eLk0nw6sKjbXryLpSHHzC5Njvb555PMQZtUMr/ULG9zW+FbCBQVC
         5C3FuRrmJUuze9PicLQKqm+onSAoXDug2deYTPiW77zo08ZMXnL/j6uTQxChO4p1sGeF
         N22Lr72BqpoWaDnO8jiuyvPIHo/8tVzmzT4OOSisz97auTwRLXpXHFl1rPx9YS8S0N29
         rWqe4G0qWfuIhRNZSijSJeiJ3ZN+jAcBxRH3vIsKKVfX4LcvTQt5AdMt+jYxZfz9d3ry
         4T4Ui3PpKmNrVnbBUsztI1mAwDabXBSH7fyK3vLI4ZhyGlOrTPMlXPZh2FsX1ULa79bL
         y61w==
X-Forwarded-Encrypted: i=1; AJvYcCUzoaajeIkdRktOoS/hkDAZXtJpIB9OK6Q4yEYDJfwV4kQzguAj+7+eM8TO9OmiRVM4myEvgCqad3fD3Fxa@vger.kernel.org
X-Gm-Message-State: AOJu0YwO2BJejjY/n4uQbecgo5G01lQZLlTMdRFx6aerbRPBJwIbpb+u
	6CDi6pEw/I2/gjjO/16fyl24LiU7b/65NLB4SkWuAIkOlpSjdtBDtKHVQj2Ao+M=
X-Gm-Gg: ASbGnct/ANIz8RDFT2aoX08BTDcGlpP8++ooJSz3T9ZgzMuZKjWa/TEY5hPEKU4si9r
	CuKsdtyPgc7DgMlvq9Zk2PexeiMckl4MxA0ubdVT7aO/BvXFUw65xh1+Vklbs8t4IUFZ0TWDWBL
	A2E+0ukaZsf7++2hfNvn3Hplh9aTBJhztbH1J/FQV3mvkc5iLud0jjQVbL0Zvx2FNyLhNmLNVtm
	NOR8MM8Y3jbgLVeYG2btd6piZ80E/w7Ys7GlsQyQceGnAiXErfpzdIo3whr3wlkcfk0E4v+YB+E
	eSMnu8R8NMt9jf9vev8GbrhffVsyLPd2vidwqM4L5HX27+8w2i21bb7zEArka3zeD2KTyfetXDw
	r/TKLrwI=
X-Google-Smtp-Source: AGHT+IHzFQsMpyxnlgNgb6/AapEwMxAFsjlk1Y50ppumPDJaVyT94lrU8lQ75U2eZlmUy8MXD/UEzQ==
X-Received: by 2002:a05:6830:370f:b0:727:bf:e433 with SMTP id 46e09a7af769-7273779bdddmr1061231a34.19.1739925273718;
        Tue, 18 Feb 2025 16:34:33 -0800 (PST)
Received: from system76-pc.attlocal.net (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7272d8bd011sm1120406a34.14.2025.02.18.16.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 16:34:32 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org,
	dhowells@redhat.com
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH] ceph: fix slab-use-after-free in have_mon_and_osd_map()
Date: Tue, 18 Feb 2025 16:34:19 -0800
Message-ID: <20250219003419.241017-1-slava@dubeyko.com>
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
client->monc.monmap.

Reported-by: David Howells <dhowells@redhat.com>
Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 net/ceph/ceph_common.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

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
-- 
2.48.0



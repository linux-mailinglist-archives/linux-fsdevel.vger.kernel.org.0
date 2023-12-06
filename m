Return-Path: <linux-fsdevel+bounces-4939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 384C8806753
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 07:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2DA5280A80
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 06:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7B818AF9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 06:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="vueYdWwm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AB3D6C
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 22:06:37 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c21e185df5so4000051a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Dec 2023 22:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701842797; x=1702447597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4fn8znMBnHx32svyrnbDfUnHhzlVQ7G5pzlVkycieA=;
        b=vueYdWwmYeDx3LEn4Nye1xXvMy+5G/E9jQShJCw83qUlCniD1y2t9oPEohyUqOoltY
         BjztqHStsw58EMoS2Fzudh7ZaOmxKl+XuDLNgEERc24vCJmuRpwn4ATB7dw2ZJa2gU7V
         GbtC74J7H1chY2cXaAU40V1cAXazNakqkxvvq3ZuFN2OpBuW+MBVe46LKfN7qnsZQKZr
         h5YOvGSFHgiVt6fK7J+ktLmvqMMG8QFe32Ok1HGAFWKmqrGJN+5gcFJkJVGNqHR68nP1
         fK/GzXz9L8qquvU9zCn4hnzaF09K7Ci+9Qh5nsk3oJMkO1gWs8LmURpMWBFBCX9xMGI/
         /fkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701842797; x=1702447597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4fn8znMBnHx32svyrnbDfUnHhzlVQ7G5pzlVkycieA=;
        b=sSXt1zhPjyDSzDmjEB7/ZvxyNgmhPrGW51l3MvnncMU0rcmzYkyQfQegPQswN7AEPy
         JKDrf+f/GXasmYo/YoJ49FGV0ZkhUlGhHEsxGtPnRSswuT/7Mo7zvpG+bieXzNcZDmea
         bYe8eXjpft2nrlFkDUBe/4g488gND3Wv5cjc2+bxdZPBIuHQ/wDYb+D+WDv6XLx62TWJ
         c+tn0lDMgXBBSY4aO6czoZXdUFBMlP0iGVhHLY9S1pYatP60lZunAZLSml0HZIpHn2JL
         +eDlo74PE4cuUAVTxCuuNQAcgG303mtSxpLPDOzug5yZHKaQWD2azw+SPQWmFTcMIz1/
         kFjA==
X-Gm-Message-State: AOJu0YzQJRjMu2vn5zwzOCRFpqa4MszXOUArIOPLrM7GRVt4B3iNPJ/O
	EgEpDsr0L5AH+6kZVgQsddWAaA==
X-Google-Smtp-Source: AGHT+IHh3TFL/DzofTOA4bttY6oq6gSidAZO08x8CTr+BDDGslel3+9RSP1rqlq7aRu9sSclIqBRzA==
X-Received: by 2002:a17:902:7795:b0:1d0:5806:f45d with SMTP id o21-20020a170902779500b001d05806f45dmr351927pll.42.1701842796981;
        Tue, 05 Dec 2023 22:06:36 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902c40a00b001d087f68ef8sm2308763plk.37.2023.12.05.22.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 22:06:34 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.96)
	(envelope-from <dave@fromorbit.com>)
	id 1rAl3I-004VPF-1Q;
	Wed, 06 Dec 2023 17:06:32 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.97-RC0)
	(envelope-from <dave@devoid.disaster.area>)
	id 1rAl3H-0000000BrVp-49wq;
	Wed, 06 Dec 2023 17:06:32 +1100
From: Dave Chinner <david@fromorbit.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	linux-cachefs@redhat.com,
	dhowells@redhat.com,
	gfs2@lists.linux.dev,
	dm-devel@lists.linux.dev,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] hlist-bl: introduced nested locking for dm-snap
Date: Wed,  6 Dec 2023 17:05:40 +1100
Message-ID: <20231206060629.2827226-12-david@fromorbit.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231206060629.2827226-1-david@fromorbit.com>
References: <20231206060629.2827226-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

Testing with lockdep enabled threw this warning from generic/081 in
fstests:

[ 2369.724151] ============================================
[ 2369.725805] WARNING: possible recursive locking detected
[ 2369.727125] 6.7.0-rc2-dgc+ #1952 Not tainted
[ 2369.728647] --------------------------------------------
[ 2369.730197] systemd-udevd/389493 is trying to acquire lock:
[ 2369.732378] ffff888116a1a320 (&(et->table + i)->lock){+.+.}-{2:2}, at: snapshot_map+0x13e/0x7f0
[ 2369.736197]
               but task is already holding lock:
[ 2369.738657] ffff8881098a4fd0 (&(et->table + i)->lock){+.+.}-{2:2}, at: snapshot_map+0x136/0x7f0
[ 2369.742118]
               other info that might help us debug this:
[ 2369.744403]  Possible unsafe locking scenario:

[ 2369.746814]        CPU0
[ 2369.747675]        ----
[ 2369.748496]   lock(&(et->table + i)->lock);
[ 2369.749877]   lock(&(et->table + i)->lock);
[ 2369.751241]
                *** DEADLOCK ***

[ 2369.753173]  May be due to missing lock nesting notation

[ 2369.754963] 4 locks held by systemd-udevd/389493:
[ 2369.756124]  #0: ffff88811b3a1f48 (mapping.invalidate_lock#2){++++}-{3:3}, at: page_cache_ra_unbounded+0x69/0x190
[ 2369.758516]  #1: ffff888121ceff10 (&md->io_barrier){.+.+}-{0:0}, at: dm_get_live_table+0x52/0xd0
[ 2369.760888]  #2: ffff888110240078 (&s->lock#2){++++}-{3:3}, at: snapshot_map+0x12e/0x7f0
[ 2369.763254]  #3: ffff8881098a4fd0 (&(et->table + i)->lock){+.+.}-{2:2}, at: snapshot_map+0x136/0x7f0
[ 2369.765896]
               stack backtrace:
[ 2369.767429] CPU: 3 PID: 389493 Comm: systemd-udevd Not tainted 6.7.0-rc2-dgc+ #1952
[ 2369.770203] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 2369.773771] Call Trace:
[ 2369.774657]  <TASK>
[ 2369.775494]  dump_stack_lvl+0x5c/0xc0
[ 2369.776765]  dump_stack+0x10/0x20
[ 2369.778031]  print_deadlock_bug+0x220/0x2f0
[ 2369.779568]  __lock_acquire+0x1255/0x2180
[ 2369.781013]  lock_acquire+0xb9/0x2c0
[ 2369.782456]  ? snapshot_map+0x13e/0x7f0
[ 2369.783927]  ? snapshot_map+0x136/0x7f0
[ 2369.785240]  _raw_spin_lock+0x34/0x70
[ 2369.786413]  ? snapshot_map+0x13e/0x7f0
[ 2369.787482]  snapshot_map+0x13e/0x7f0
[ 2369.788462]  ? lockdep_init_map_type+0x75/0x250
[ 2369.789650]  __map_bio+0x1d7/0x200
[ 2369.790364]  dm_submit_bio+0x17d/0x570
[ 2369.791387]  __submit_bio+0x4a/0x80
[ 2369.792215]  submit_bio_noacct_nocheck+0x108/0x350
[ 2369.793357]  submit_bio_noacct+0x115/0x450
[ 2369.794334]  submit_bio+0x43/0x60
[ 2369.795112]  mpage_readahead+0xf1/0x130
[ 2369.796037]  ? blkdev_write_begin+0x30/0x30
[ 2369.797007]  blkdev_readahead+0x15/0x20
[ 2369.797893]  read_pages+0x5c/0x230
[ 2369.798703]  page_cache_ra_unbounded+0x143/0x190
[ 2369.799810]  force_page_cache_ra+0x9a/0xc0
[ 2369.800754]  page_cache_sync_ra+0x2e/0x50
[ 2369.801704]  filemap_get_pages+0x112/0x630
[ 2369.802696]  ? __lock_acquire+0x413/0x2180
[ 2369.803663]  filemap_read+0xfc/0x3a0
[ 2369.804527]  ? __might_sleep+0x42/0x70
[ 2369.805443]  blkdev_read_iter+0x6d/0x150
[ 2369.806370]  vfs_read+0x1a6/0x2d0
[ 2369.807148]  ksys_read+0x71/0xf0
[ 2369.807936]  __x64_sys_read+0x19/0x20
[ 2369.808810]  do_syscall_64+0x3c/0xe0
[ 2369.809746]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
[ 2369.810914] RIP: 0033:0x7f9f14dbb03d

Turns out that dm-snap holds two hash-bl locks at the same time,
so we need nesting semantics to ensure lockdep understands what is
going on.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 drivers/md/dm-snap.c    |  2 +-
 include/linux/list_bl.h | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index bf7a574499a3..cd97d5cb295d 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -645,7 +645,7 @@ static void dm_exception_table_lock_init(struct dm_snapshot *s, chunk_t chunk,
 static void dm_exception_table_lock(struct dm_exception_table_lock *lock)
 {
 	hlist_bl_lock(lock->complete_slot);
-	hlist_bl_lock(lock->pending_slot);
+	hlist_bl_lock_nested(lock->pending_slot, SINGLE_DEPTH_NESTING);
 }
 
 static void dm_exception_table_unlock(struct dm_exception_table_lock *lock)
diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index 990ad8e24e0b..0e3e60c10563 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -83,6 +83,11 @@ static inline void hlist_bl_lock(struct hlist_bl_head *b)
 	spin_lock(&b->lock);
 }
 
+static inline void hlist_bl_lock_nested(struct hlist_bl_head *b, int subclass)
+{
+	spin_lock_nested(&b->lock, subclass);
+}
+
 static inline void hlist_bl_unlock(struct hlist_bl_head *b)
 {
 	spin_unlock(&b->lock);
@@ -125,6 +130,11 @@ static inline void hlist_bl_lock(struct hlist_bl_head *b)
 	bit_spin_lock(0, (unsigned long *)b);
 }
 
+static inline void hlist_bl_lock_nested(struct hlist_bl_head *b, int subclass)
+{
+	hlist_bl_lock(b);
+}
+
 static inline void hlist_bl_unlock(struct hlist_bl_head *b)
 {
 	__bit_spin_unlock(0, (unsigned long *)b);
-- 
2.42.0



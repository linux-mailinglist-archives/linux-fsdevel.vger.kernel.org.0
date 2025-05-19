Return-Path: <linux-fsdevel+bounces-49368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF689ABB962
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A278B7AA79F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CF6277004;
	Mon, 19 May 2025 09:19:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8150B27A934;
	Mon, 19 May 2025 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646343; cv=none; b=JAlQ3pkTsWR73ZZgs7QxxZoD6vXGmAXr6ODS1qrcQAmFHWPUDNtBtjvBEqTndq+VyEttOjw8r1Ebj+WjAMa69rMfy5V5tcuhck++pWY8arM9V64O2NiK+1jPgLY90bKdbtGbEPQmCZR189YSgV/VjrgtjBfWHXSk4l3oiooz8aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646343; c=relaxed/simple;
	bh=1IZJyJwmvBeB2aOIzTtB/M01VK39C8cxFBwYkS4jNho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OUSklV3RsT1Io/wY+zyT40iQwlBiXAsJZToBcYxybpFZJxley8FqZWx9c0HB5xU0NjWFsqIY+KZApSU0kHj/qjF1CdFMGW7qrN8L6UDFOyklDJ9xzXl2Itlg847eNFvWF9ZN1+zDqsl8BPrn4A214bhBuVMQP57kUa0Z2igNBKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-9b-682af76f4a34
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	harry.yoo@oracle.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	yskelg@gmail.com,
	yunseong.kim@ericsson.com,
	yeoreum.yun@arm.com,
	netdev@vger.kernel.org,
	matthew.brost@intel.com,
	her0gyugyu@gmail.com
Subject: [PATCH v16 29/42] cpu/hotplug: use a weaker annotation in AP thread
Date: Mon, 19 May 2025 18:18:13 +0900
Message-Id: <20250519091826.19752-30-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTdxTG/d97e+9tZ+WmEnfBJcxGs8niCwaWs2SaJVv0P+MLiX4w24d5
	I3e0ASopiuBc0k5qnJWCOmAqYgFzraWM2mIUtYpFKgVFkIrAeJeoBJCl2CqC2wqbX05+eZ7z
	POfLYUmVTxbLanX7RL1OSFfTCkoxsbB8VebreM1aS10UhF4dpaC0xkFD2x9VCBy1RgJGGzfB
	k/A4gpkHD0koKWpDUD7UR0Ktrx+Bx/YLDR0jiyAQmqTBX2Sm4XBlDQ3tY7ME9BafJKDKtRUG
	pGcUtBRWEFAySsPZksNEZLwgYFqyMyAZVsCw7QwDs0MJ4O/vlIGn5zM4XdZLw02PnwLftWEC
	Oq6X0tDv+EcGLb4mCsKWpdB2Il8G1S8raBgLSyRIoUkGHtVbCfBZl4AzL1J4ZOpvGdzLryfg
	yIXLBAS6byC4dXSQAJejk4aG0DgBblcRCW8vNiIYtkwwYDo+zcBZowWB2VRMQV5vEsy8iVw+
	9yoBjOedFFS/60RfrceOMgfCDeOTJM5zH8BvQ49p7AlbKdxcweO6M30MzrvVw2Craz922+Jx
	5c1RApcHQzLssv9KY1fwJIOPTQQI/LK1lUn+6DvFlyliujZb1K/ZsFuhaZRmiMxBec7Vx8+R
	Ac0yx5Cc5blEvmPohew9m7yD5BzT3Cd8V9f0PEdzH/Pu/GeRHQVLcp0f8E/OdaM5YzG3hbf2
	jkeYYSluBX9JnFOV3Od8U3uQ/K8yjq9y1s+zPKL3mBvmkyouiQ9UlVFzlTxXIOdN1ub/AzH8
	HVsXVYiUVrTAjlRaXXaGoE1PXK3J1WlzVu/Zm+FCke+Sfp79/hoKtu3wIo5F6oVKp2elRiUT
	srNyM7yIZ0l1tNLu/lSjUqYIuQdF/d4f9PvTxSwvWspS6g+V68IHUlRcqrBPTBPFTFH/3iVY
	eawBJU+pDDP6UvPtXbVLTOYvjN2PXuM0erIvTjpI7woL7Tk/qakbzd8w73TQxZ2y7Kxbdvlr
	qUMw3v9xc3TN+TWnUpNsfqEgcdtzIaaw9vi9EUPrmHfr3W+nY9JUUByVWk76t/8e5zz0W+zG
	TX+uH1hufxoYGOoLXvlre1KooGWzKUpNZWmEhHhSnyX8C0ns3bFZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+5+708Vxih2MLiykMrpIGS8UEfSh05WiILKgRp7acNPYyrQI
	XJtdvCwVpmlp89Lyskq3KEsnNnG58lbqLFMzi0oyJXWmadY0+vLw43l4n+fLy+CSYjKYUUSf
	EdTRMqWUEhGivZt0q2N+hsrXdRQBeMauEnDrgYWC1vtlCCwPtRgM1G+HzvFBBFNNLThkGVsR
	5H/oweGhsxeBvfgSBW2f5kO7Z5gClzGZAl3hAwpefZvGoDszA4My6x54b/5MwMu0AgyyBii4
	maXDvPIVg0lzKQ3mhBDoL86hYfpDGLh63STU5bpIsHetguy8bgqq7S4CnJX9GLQ9vUVBr+UP
	CS+dDQSMGxZCa3oqCfeGCij4Nm7GwewZpuF1rQkDpykIyvXe1sujMyQ8T63F4HJRBQbtb6sQ
	1Fztw8BqcVNQ5xnEwGY14vDrbj2CfsN3GhJTJmm4qTUgSE7MJEDfHQ5TE97l3LEw0N4uJ+De
	bzfauoW35FkQXzc4jPN62zn+l6eD4u3jJoJ/UcDxT3J6aF5f00XzJutZ3lYcyhdWD2B8/oiH
	5K2l1yjeOpJB80nf2zF+qLmZ3rcoQrQ5UlAqYgX12i3HRfJ68xR2us8n7nHHF5SApukk5MNw
	7AYu0dGHzzLFLufevJmc40B2KWdL/UwmIRGDs25frjP3LZoNAtjdnKl70Ms0Q7AhXIkw64rZ
	jVzDqxH8X+USrqy8do59vH5Xct3cpYQN59rL8og0JDKheaUoUBEdq5IplOFrNFHy+GhF3JoT
	MSor8v6P+eJ0eiUaa9vuQCyDpH7icvtKuYSUxWriVQ7EMbg0UFxqWyGXiCNl8ecFdcwx9Vml
	oHGghQwhXSDeeUg4LmFPyc4IUYJwWlD/TzHGJzgBqVK2fV18p2vGKQ3I8WsJGCnRaInrKzPk
	lVSUr2iXYvjR0T+uknVKldKQfUTz8Yfbf2jZ2LvmC5eCnlFBui+10vzRkpYJ9Y2qLMeVqk79
	jvXVh43aif0/Uq0VGy2GiPem4Be+nSESnbFR4y9qOnJRHXDS/2PFqF7f0Fg4EXXA76CU0Mhl
	YaG4WiP7C409OyQ7AwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

cb92173d1f0 ("locking/lockdep, cpu/hotplug: Annotate AP thread") was
introduced to make lockdep_assert_cpus_held() work in AP thread.

However, the annotation is too strong for that purpose.  We don't have
to use more than try lock annotation for that.

rwsem_acquire() implies:

   1. might be a waiter on contention of the lock.
   2. enter to the critical section of the lock.

All we need in here is to act 2, not 1.  So trylock version of
annotation is sufficient for that purpose.  Now that dept partially
relies on lockdep annotaions, dept interpets rwsem_acquire() as a
potential wait and might report a deadlock by the wait.

Replace it with trylock version of annotation.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index b08bb34b1718..3eecd0a7b5b3 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -537,7 +537,7 @@ int lockdep_is_cpus_held(void)
 
 static void lockdep_acquire_cpus_lock(void)
 {
-	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 0, _THIS_IP_);
+	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 1, _THIS_IP_);
 }
 
 static void lockdep_release_cpus_lock(void)
-- 
2.17.1



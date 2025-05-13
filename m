Return-Path: <linux-fsdevel+bounces-48853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AD4AB51C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04ACD981D81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4CD274FF4;
	Tue, 13 May 2025 10:08:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3614225CC69;
	Tue, 13 May 2025 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130882; cv=none; b=OvDROwblmm2+0G2NUCBbdTBIAf7ZvDkSixgegPAVko7h7SChVBvHDaa9ANoFFXr6veDnuZEQ7GBjTroJZEgCZP82lSviCBRUAbLzsZTgJU0hOeQP5rQg0l5aQCkUS61DYtE2NrhgeIXCnn+P3JfR6qIiA4fmsZpN/NxXwApO2rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130882; c=relaxed/simple;
	bh=TSPxdh3H9mjhA/wDLLlJUz6YZTY7hYg5ulgpaHBJJSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=M9UkoWFxJb26aK3k0aWyJPdndCx6zqahtjLorU9m6ugz6M5E7/Zo31dDVnddtmsPzBSANFgnrj3xYU16vGp0Q3v5fdI/l8f8Yd++mmGec2x+VL6IvqYq0LK9z+k5b48FIUW+/7HnuacLl3PJApLzCKCG8yJAaZ+hdU6zeL36ByY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-ec-682319f0e72e
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
Subject: [PATCH v15 19/43] dept: apply timeout consideration to wait_for_completion()/complete()
Date: Tue, 13 May 2025 19:07:06 +0900
Message-Id: <20250513100730.12664-20-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTYRTHe573utXiZXZ5M6lcSGFXI+OQ3agPvhGBXSDKD7XyrY3UZJap
	EEydlaZmF7WLrc1qmq60LcjKlRkuL6Qz70MtJSrLS1kbaXbZrL4cfvwP/9/5clhCXkP5suro
	o6ImWhmpoKWkdHCKccnnWfNVy+3lPLi+nSYhv9RMg+NuCQLz/SQM/dWh0O4eQPDjZSMBeTkO
	BMbebgLu23sQ2IqSaWh+OxVaXMM01OacoSHlRikNTZ/GMXTlnsdQYtkKr03vSKjPLsCQ10/D
	1bwU7BkfMIyaihkwaQOgr+gKA+O9QVDb00aBzbkILuu7aKiw1ZJgL+/D0Pwon4Ye828K6u01
	JLizZoPjXCYFd4YKaPjkNhFgcg0z8KrSgMFumAFlOo/w5NdfFLzIrMRw8uY9DC2djxE8Of0G
	g8XcRsNz1wAGqyWHgLHCagR9WYMMpGaMMnA1KQvBmdRcEnRdwfDju+fytW9BkHS9jIQ7P9vQ
	hrWCWW9GwvOBYULQWY8LY65WWrC5DaRQV8ALD690M4LuiZMRDJZjgrUoULhR0Y8F44iLEizF
	abRgGTnPCOmDLVgYamhgwvz2SNdEiJHqOFGzbN0+qcr86jITo5fGW9OasBa9YdORhOW5lfxL
	ox79Z6vzAuVlmlvAd3SMEl6exs3jrZnvPLmUJbi2yXz7tc6Jgg+3jx8zuLGXSS6A/3rhwwTL
	uFX8l1spxF/pXL6krHKCJZ78Z2ED6WU5F8xnG0pIr5Tnzkr4bmv6v8Is/llRB5mNZAY0qRjJ
	1dFxUUp15MqlqoRodfzSA0eiLMjzX6YT4+HlaMSxowpxLFJMkdX0+6vklDIuNiGqCvEsoZgm
	S3rgiWQRyoREUXNkr+ZYpBhbhWazpGKmbIX7eIScO6Q8Kh4WxRhR83+LWYmvFoWvD2qhHj/T
	J/uHL4vZtvH7zvnpX1oPuRpfV59afzDxXliGT1jonNUHhjaZtGKFLbHb8bEadyoK2w/m9uwP
	CFyyeXzh9hlOv/IqWWMI+JlCjVtCMqZf2hWc3BtaX/feFqK9nVH31Odh11bn591zLvmfXSxp
	2u+bmlaqi7+4Kvvjdr8CBRmrUgYFEppY5R87WIikWwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzHfb/Pz46zZ2k8an6dmS0TmexjDBubRxuimc1sOjzcrS48R9Sw
	0oWkJEvohxNduU7OXVNSLbVOp0m/JC0nMesmWtwdXflxx/zz2Wuv9/Z+//NhiUAjFcyq44+K
	UrwyTkHLSNmWVamLR2bOVy3tMK4Et+s8CQX3TTS0V5QjMFWmYHA2b4RXnmEE489fEJCX247g
	1rs3BFTaHAjqys7Q0PVhKnS7R2iw52bQkHr7Pg0dnyYw9F/NwVBu2QxvDR9JaM0uxpDnpCE/
	LxX7zhCGMYORAUPyAhgsu8HAxLtwsDt6KGgqtFNQ17cIrhf101BbZyfBVj2IoaumgAaH6TcF
	rbYWEjxZIdB+OZOCe1+KafjkMRBgcI8w0Nmgx2DTTwezztd69tsvCp5mNmA4e+cBhu7XjxHU
	nx/AYDH10NDkHsZgteQS4C1tRjCY9ZmBtItjDOSnZCHISLtKgq4/AsZ/+JYLXeGQctNMwr2f
	PWjdGsFUZEJC0/AIIeisxwWv+yUt1Hn0pPCsmBce3XjDCLr6PkbQW44J1rJQ4XatEwu3vrop
	wWJMpwXL1xxGuPC5Gwtf2tqYqFm7ZKv3i3HqBFFasiZGpjJ1XmcOF8lOWNM7cDIaYC+gAJbn
	lvPWviuUn2luId/bO0b4OYiby1szP/q8jCW4nsn8q8LXyB9M42J4r96D/UxyC/hvV4b+spxb
	wY+WpBL/Sufw5eaGvxzg8z9L20g/B3IRfLa+nMxGMj2aZERB6vgEjVIdFxGmjVUlxqtPhO07
	pLEg3wcZTk1crkauro2NiGORYoq8xTlPFUgpE7SJmkbEs4QiSJ5S5VPy/crEJFE6tEc6Fidq
	G1EISypmyCN3ijGB3EHlUTFWFA+L0v8UswHByajm3DWX5GhbPloCWyPnh21twdvlW7J733cl
	VUmRs5NsmlpvfuOg/Un08eCK8aHHM04vO0Otqv51yhXLpU+ZXRkeLMtMW7tkQ4vZu+mAZnfO
	w20ZIQnRSQpntNkxc/ORu5cm6faOrd+2o7V2fBSiKgqyBr4XrIyKJNZJFdWhnXNP9ipIrUoZ
	HkpIWuUfQXCWZD0DAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to wait_for_completion()/complete().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/completion.h | 4 ++--
 kernel/sched/completion.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index bd2c207481d6..3200b741de28 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -41,9 +41,9 @@ do {							\
  */
 #define init_completion_map(x, m) init_completion(x)
 
-static inline void complete_acquire(struct completion *x)
+static inline void complete_acquire(struct completion *x, long timeout)
 {
-	sdt_might_sleep_start(&x->dmap);
+	sdt_might_sleep_start_timeout(&x->dmap, timeout);
 }
 
 static inline void complete_release(struct completion *x)
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 3561ab533dd4..499b1fee9dc1 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -110,7 +110,7 @@ __wait_for_common(struct completion *x,
 {
 	might_sleep();
 
-	complete_acquire(x);
+	complete_acquire(x, timeout);
 
 	raw_spin_lock_irq(&x->wait.lock);
 	timeout = do_wait_for_common(x, action, timeout, state);
-- 
2.17.1



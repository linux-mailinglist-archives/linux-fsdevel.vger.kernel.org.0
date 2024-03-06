Return-Path: <linux-fsdevel+bounces-13708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2C88731B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 10:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E9828185A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79548629E4;
	Wed,  6 Mar 2024 08:55:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDD1605CE;
	Wed,  6 Mar 2024 08:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715343; cv=none; b=WEfixzGfWMKI+GRmr85IwsYeSUV8SHQKiw7s3pOgDh03ItiRX2F4OKXK8osScfAb5bK7MvXfrwbAu6unmZlmUNy4NWC9G6y3yTMG5KDwKYkS1BLp+nKwwVvbPLgNdBUUPSoubv4hz3BYqNeR7EfeJUiFLWV1G/v46yWkJB7CvP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715343; c=relaxed/simple;
	bh=7Na745h6mqt6szPtcPf56L4nwkzcVctpfLScpiam1ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TV11BrnAUH9ymDKVQDnDmlfIoqcDv/n0GnHbrviboDgq5ysJ6hgp4kWfSLv+nydNArKXxG9sUA31HzDbolwlBtWvJY3/AV7K8ayGvv9s/yM+TdRTAiJOwArcn7rp5ZXsPEGWSGTIvuGpDyxpepTZIuKKIDvlwGpWhWqAtGyo9e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-ec-65e82f7dcaa5
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
	42.hyeyoo@gmail.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	hdanton@sina.com,
	her0gyugyu@gmail.com
Subject: [PATCH v13 12/27] dept: Distinguish each work from another
Date: Wed,  6 Mar 2024 17:54:58 +0900
Message-Id: <20240306085513.41482-13-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306085513.41482-1-byungchul@sk.com>
References: <20240306085513.41482-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfb+/x46zn5P5icluw1ZEDfvYPGSMr5mn8QfacNNvuulpF3Ee
	UyGRrraKq+UudlKXy0XLw3HiUh4qdeO0iloeogeLOz15uDL/fPba+/P6vP/68JTiNuPHq6P3
	S5poVaSSldGy7nEFc4/P+yzNz+xXQMb5+eD+kUJDnsXMQv2NYgTmWycxdDrWwBtPF4Khl3UU
	5GTVIzC2tVBwq6oVga0wkYXGjvHgdPeyUJN1joWkKxYWXn0dxtCcnYmh2LoenusKMNgHPtGQ
	08lCbk4S9o7PGAZMRRyYEmZCe6Geg+G2YKhpfc2ArSkQLuU3s3DfVkNDVUU7hsa7eSy0mv8w
	8Lyqmob6jDQGSnoKWPjqMVFgcvdy0GA3YChN9had/v6bgadpdgynr97E4Hx7D8GDlPcYrObX
	LDx2d2Eos2ZRMHjNgaD9QjcHp84PcJB78gKCc6eyaUhuXghD/Xls6GLyuKuXIsllB4nNY6DJ
	swKR3NG3cCT5QRNHDNYDpKwwgFy534mJsc/NEGvRWZZY+zI5ktrtxKSntpYj1ReHaNLhzMGb
	/HbIloRLkep4STNv2W5ZhP5VL4r9MvGQqyKdSkDXhVTkw4vCArE8P4n6z2/N/cwIs8Js0eUa
	GM19hRliWdrH0ZwSumTi1drVIzxRWCmWXk8cdWhhpqh/ZORGWC4sEvNaE+l/nf5ical91PHx
	5uk96ewIK4SF4ssko5dlXqefFzO+5TL/DqaIjwpdtA7JDWhMEVKoo+OjVOrIBUER2mj1oaA9
	MVFW5H0m07HhsArUV7+lEgk8Uo6Th/p8khSMKj5OG1WJRJ5S+sqPDnZICnm4SntY0sTs0hyI
	lOIq0VSeVk6Wh3gOhiuEvar90j5JipU0/7eY9/FLQFvP+LpME8KOOLbXncWBS7WdljpHU0No
	+awVmz5ot/1c03A5xt79xz/EtdNzpppfN7jMot8abN6wVhUxSfemaeV024ZflsYl+pqQWD53
	M3+iJV73xDAnKhwPPnwRZi0n2WtNqYbl9+aUbNSlrH94zP/22HeBVcYKp6MtaNUX6s60o0o6
	LkIVHEBp4lR/ARoqQ6JIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRzF+/3uaxstLtPoYkGxHoaRj8j6UhlFUDd7EEQUFeTKS47UZFPL
	SFC3wvKxDOZyLp0P5mulzQIrZ+bQMvNRDlNRSZPSWlrmRNMezuifw4dzDuevIyJkBspHpIyO
	FVTRikg5LSElh7drNiYGjAiBv5O3QlZ6ILgnU0kwVVpp6LhfgcD6MBnDaOM+eDflQjDb2k6A
	Qd+BoGCwn4CHTQMI7KUpNHQOLwGne5yGZn0aDZqiShrefJnD0Jd9G0OF7RC03CrEUD/ziQTD
	KA25Bg2elxEMM5ZyBixJa2Go1MjA3GAQNA90UeC420yBvXcD5OT10VBrbyahqWYIQ+cTEw0D
	1j8UtDS9JKEjK4OCe2OFNHyZshBgcY8z8LbejKFKO792/cdvCl5k1GO4XvwAg7PnKYK61PcY
	bNYuGhxuF4Zqm56AnyWNCIYyvzJwLX2GgdzkTARp17JJ0PYFw+y0id61jXe4xgleW32Jt0+Z
	Sf5VIcc/NvYzvLaul+HNtji+utSPL6odxXzBhJvibeU3aN42cZvhb351Yn6srY3hX96ZJflh
	pwEfWX5SsiNciFTGC6qAnWGSCOObcRTz2etyd42OSEJl7E0kFnHsZq7HOk15mGZ9ue7uGcLD
	3uwqrjrj44JPsC4JV9y218Ne7B6uqixloUOyaznj8wLGw1J2C2caSCH/ba7kKqrqFzrieV83
	pqM9LGODuVZNAX0LScxoUTnyVkbHRymUkcH+6gsRCdHKy/7nLkbZ0PxdLIlzWTVosnNfA2JF
	SL5Yukv8SZBRinh1QlQD4kSE3Ft69eewIJOGKxKuCKqLZ1RxkYK6AS0XkfJl0tDjQpiMPa+I
	FS4IQoyg+p9ikdgnCa32OZyDH/mWJTpv/Dq2P39wJKb96GiOtvf1ik179ZPTp/JPK1tCmnR+
	Z1MDV4XEVp4X5wu9ac80dS3SEx3qkkxk2nryR850e0ledq6jRr/7QKix36hc0/kha124Uhf8
	dI3tW216Ea779a7VXuzlUpwKWP/9RMhBR1fRpom8u4lLQ+WkOkIR5Eeo1Iq/XDpKMioDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Workqueue already provides concurrency control. By that, any wait in a
work doesn't prevents events in other works with the control enabled.
Thus, each work would better be considered a different context.

So let Dept assign a different context id to each work.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     |  2 ++
 kernel/dependency/dept.c | 10 ++++++++++
 kernel/workqueue.c       |  3 +++
 3 files changed, 15 insertions(+)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 4e359f76ac3c..319a5b43df89 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -509,6 +509,7 @@ extern void dept_ecxt_exit(struct dept_map *m, unsigned long e_f, unsigned long
 extern void dept_sched_enter(void);
 extern void dept_sched_exit(void);
 extern void dept_kernel_enter(void);
+extern void dept_work_enter(void);
 
 static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
 {
@@ -559,6 +560,7 @@ struct dept_task { };
 #define dept_sched_enter()				do { } while (0)
 #define dept_sched_exit()				do { } while (0)
 #define dept_kernel_enter()				do { } while (0)
+#define dept_work_enter()				do { } while (0)
 #define dept_ecxt_enter_nokeep(m)			do { } while (0)
 #define dept_key_init(k)				do { (void)(k); } while (0)
 #define dept_key_destroy(k)				do { (void)(k); } while (0)
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 9aba9eb22760..a8e693fd590f 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -1933,6 +1933,16 @@ void noinstr dept_hardirqs_off(void)
 	dept_task()->hardirqs_enabled = false;
 }
 
+/*
+ * Assign a different context id to each work.
+ */
+void dept_work_enter(void)
+{
+	struct dept_task *dt = dept_task();
+
+	dt->cxt_id[DEPT_CXT_PROCESS] += 1UL << DEPT_CXTS_NR;
+}
+
 void noinstr dept_kernel_enter(void)
 {
 	struct dept_task *dt = dept_task();
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 2989b57e154a..4452864b918b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -53,6 +53,7 @@
 #include <linux/nmi.h>
 #include <linux/kvm_para.h>
 #include <linux/delay.h>
+#include <linux/dept.h>
 
 #include "workqueue_internal.h"
 
@@ -2549,6 +2550,8 @@ __acquires(&pool->lock)
 
 	lockdep_copy_map(&lockdep_map, &work->lockdep_map);
 #endif
+	dept_work_enter();
+
 	/* ensure we're on the correct CPU */
 	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
 		     raw_smp_processor_id() != pool->cpu);
-- 
2.17.1



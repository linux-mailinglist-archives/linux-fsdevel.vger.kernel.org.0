Return-Path: <linux-fsdevel+bounces-49341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C52CAABB896
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F3118926D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9E526E14A;
	Mon, 19 May 2025 09:18:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C8826B96B;
	Mon, 19 May 2025 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646329; cv=none; b=ZS2eNHcjNaFfWOm9poMSOy+31iB+u5N76LQB5Cy/T1DBZnQOgKjR9sWJuKyyuaAygisruyIfhxE1ld9oFJzDg71WlCJ2rRfQUTnJRj/Xh30T2QCX6e4mU/ZwtlyWGY9jBydM9fSWsUDLTfX+HrS2arVuNlhh3oGNASYJu+kmeaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646329; c=relaxed/simple;
	bh=KlggbR8P/n36oRZlJZsBth/VG91g9Dz5bdB/P0jqAy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=I5tSieYR1ckCwfyCrZmtOIRaY0ZyFvyida6pHMN9J2AQWcxsQ8274ay8lCf5IJebYIohvPhlSuYpHjOe3RYHNnx6W8rrj/Ujtgw2u4kPmpmcRpuJ0t8aydzIger6YmVWpIGjRC/SU9HT8Sx1pQBzzrq2su+FYP6cyP7+Pmk7KAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-75-682af76d6e83
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
Subject: [PATCH v16 10/42] dept: distinguish each work from another
Date: Mon, 19 May 2025 18:17:54 +0900
Message-Id: <20250519091826.19752-11-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHfZ57e++lo8tNp3h9SZxNnIqZjkX0ZHNTtw88WWKyzG9oInVc
	bV1pTYsFNIsgYBxdq+KA+EJpkXRNW7W2fEClBEvoBKai1oqkghBlIwJdwJYXca7F7MvJL+ef
	/+98ORwlD0mWc2ptoajXKjUKRkpLx9Ptn2qnM1WfNcRWQ/z1KRouXfMw0HvVjcDTXIZhtDMH
	niTGELy5e5+CuppeBPahZxQ0hwYQBJwnGHj04kMIx2MMdNWYGCi/fI2BB6/mMURrqzG4fbtg
	0DFCQ8+ZRgx1owxcrCvHyfE3hlmHiwVH6RoYdl5gYX4oC7oGIhII9G+A89YoA62BLhpCLcMY
	Ht28xMCA550EekJ3aEhYVkDvWbMErkw0MvAq4aDAEY+x8LDdhiFkywBvRVJ4cupfCfxhbsdw
	suk6hvDTWwjaTj3H4PNEGOiIj2Hw+2oomPu9E8GwZZyFyl9nWbhYZkFgqqyloSKaDW9mkpfr
	X2dBWYOXhitvI2jHV8Rj9SDSMRajSIW/iMzFHzMkkLDRpLtRIDcuPGNJRVs/S2y+I8TvzCSX
	W0cxsU/GJcTn+oUhvslqllSNhzGZuHeP/X5lrnRbvqhRG0X9pq/zpCpvpfHwBFvcFPwHl6JW
	pgpxnMBvFqJDmiqUtoDjjZ1sihl+rdDXN0uleDH/seA3j0iqkJSj+MgHwpP6pygVfMR/K9jt
	A0yKaX6NMDM1j1Ms47cIdlMUv5euEtze9gVRWnLfb+pY6Mr5bCHsttIpqcCfSxNqO6vZ94Vl
	wm1nH30GyWxokQvJ1VpjgVKt2bxRVaJVF2/8UVfgQ8nvcvw8v6cFTfbuDiKeQ4p0mTewXiWX
	KI2GkoIgEjhKsVjm8q9TyWX5ypKjol63T39EIxqCaAVHK5bKPk8U5cv5g8pC8SdRPCzq/08x
	l7a8FOVucvE7bwxayxfpCu8/jGXkvQyfzevObcvuOt+8/e3Ui4jzXeGh1ekj25eajzaTrXMt
	3obMLwq2dRiXtX3jPm7ZX/9l6dwJVe4nQ6jowW+GCYvP7yhe+ed3uuAGy4G/ehR7Z1YN/mAx
	Wc/tMmdkT7+Ude/OmdYda8o6ffqxbMna4zdzFLRBpczKpPQG5X+H3qqAWQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTYRTHe5736mrxtoa9LLQYdDOthlqHLiuQ8qXoQgRBfchhL22oKzZb
	GQSaTkxT0lhiNdumLNOVayvo4kIULYvK0sxkWVpEkjdqW5qaTaMvhx/nz/93vhyWkN2kFKxO
	nyka9Jp0JS0hJXs25cZl/IrRrvucr4JgoICEa/UuGtpv1yFw3c3BMNCSDO9CgwgmXrwioNzS
	jsDe94GAu629CHw152jo+DIfOoMjNLRZimjIraqn4fX3SQz+y2UY6jy74aPzKwnPLzowlA/Q
	cLU8F4fHNwzjzloGnNnLoL/mCgOTfSpo6+2ioNnaRoGvZzVUVPppaPC1kdB6vx9Dx8NrNPS6
	pil43vqUhFDJYmgvLabg1rCDhu8hJwHO4AgDbxptGFptkeDOC1vzf/6h4ElxI4b86jsYOt8/
	QvC44BMGj6uLhubgIAavx0LA7xstCPpLhhgwXxhn4GpOCYIi82US8vyJMDEWvmwNqCDnupuE
	W1NdaJtacFW6kNA8OEIIed5Twu/gW1rwhWyk8MzBCw+ufGCEvMc9jGDznBS8NTFCVcMAFuw/
	gpTgqT1PC54fZYxQONSJheGXL5l9UYckm4+K6TqTaFirTpFo3WbTiWHmdHXTKM5GDXQhimB5
	LoEfcrQwM0xzK/ju7nFihuXcUt5b/JUqRBKW4Lrm8u+s79FMsJBL4u323tkyyS3jx35O4hmW
	cut5e5Ef/5Mu4evcjbOiiPC+p6h5tivjEvnOukryIpLY0JxaJNfpTRkaXXriGmOaNkuvO70m
	9XiGB4UfyHl2svQ+CnQkNyGORcp5UrdvlVZGaUzGrIwmxLOEUi6t9a7UyqRHNVlnRMPxI4aT
	6aKxCS1mSeUi6c6DYoqMO6bJFNNE8YRo+J9iNkKRjTZGsQmSWAthUavjI5fGS6Md8sPdAVVa
	0l65PzW+QV1dsiMy2Xlpw3Tm9sbEJHNa6oFzCkdyQkHsvfqKwIKnow+iuTLblrVR5oqxqY4p
	hfVs5cR03KhJW7r1T3Zo/mp7cPe8FGvs+M1d+rnL90e3TO3IH+3ri407syH3m7xwpyJaSRq1
	GlUMYTBq/gJ+wP42PAMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Workqueue already provides concurrency control.  By that, any wait in a
work doesn't prevents events in other works with the control enabled.
Thus, each work would better be considered a different context.

So let dept assign a different context id to each work.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/workqueue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index cf6203282737..5a6ab354c416 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -55,6 +55,7 @@
 #include <linux/kvm_para.h>
 #include <linux/delay.h>
 #include <linux/irq_work.h>
+#include <linux/dept.h>
 
 #include "workqueue_internal.h"
 
@@ -3155,6 +3156,8 @@ __acquires(&pool->lock)
 
 	lockdep_copy_map(&lockdep_map, &work->lockdep_map);
 #endif
+	dept_update_cxt();
+
 	/* ensure we're on the correct CPU */
 	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
 		     raw_smp_processor_id() != pool->cpu);
-- 
2.17.1



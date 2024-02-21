Return-Path: <linux-fsdevel+bounces-12230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B8585D47B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 10:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F2D1F26C40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 09:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAA841740;
	Wed, 21 Feb 2024 09:50:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2FD3DB8B;
	Wed, 21 Feb 2024 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508999; cv=none; b=K0x8PVKp1n1eahvJ0KB+uyJbWnmkH0hGYDZ21ifCckEO3stCM8Hs7rt0eEM/voOto4vDi8F2xp8uJYH7Ci5j3jDFYRWdU4H6WLice6Yra2WTfoZ9XUe/wSMZTVtPC+Cwnf6PuCTBu30Uja7wvxC0U48qMLDkZ1oRI5ZANhrYb9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508999; c=relaxed/simple;
	bh=tg0pA2ZlUNywKtzMfrdbwkG7GYbhIVlK2HrCAbcpiMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ilXn6EIazSSsZn+F6JDyR0nnMirrCCJINn0G+muttEpJagmlTYMILiJe26RUUn5D9zxW8aKw4gwyu1MQ+FGBccmhltVEMgY4PH9at3wMcs75YOEjamg95iru1gWq0UC2zSOdEK+eHrWEh86AHygHNTjFm73C2XUJ0mGZ0P4HuLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-08-65d5c739c5b2
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
	viro@zeniv.linux.org.uk,
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
Subject: [PATCH v12 08/27] dept: Apply sdt_might_sleep_{start,end}() to swait
Date: Wed, 21 Feb 2024 18:49:14 +0900
Message-Id: <20240221094933.36348-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240221094933.36348-1-byungchul@sk.com>
References: <20240221094933.36348-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0yTZxSHfd/v2mrZl87Ed97ThGxx8cKCenBu0czEz0SNyVjCNo1W+Vib
	FSTlrjFDKKxDQK0iWpqlgGkrMHXFOxQYhCIyoEBBNEAmGhAtYNASKjhtNf5z8uSc3+/56/CU
	8g6zmNcmJEv6BLVOxcpp+fiC0tVRLb3SurHc5XA6fx34XxlpsFypYsFzuRJB1bXjGMaat8P9
	aR+C2fZOCoqLPAhKHw1ScM09hMDlyGKh50kYeP2TLLQWnWAhu/wKC13P5zAMnDNhqHTugrZT
	ZRgaAqM0FI+xUFKcjYPjKYaArYIDW2Y4DDvMHMw9ioDWoT4GXA+/hAt/DrBQ62qlwX1rGEPP
	HQsLQ1VvGWhz36XBc7qAgb8mylh4Pm2jwOaf5KC7wYrhqiEoyn35PwMtBQ0Yci/+jcH7oAZB
	nfE/DM6qPhaa/D4M1c4iCl7bmxEMF45zkJMf4KDkeCGCEznnaOh808KAYWA9zM5Y2C2bxCbf
	JCUaqtNE17SVFu+VEfG2eZATDXUPOdHqTBGrHavE8toxLJZO+RnRWfEHKzqnTJyYN+7F4kRH
	ByfePT9Li0+8xXjPkp/km2MlnTZV0q/99oBcU2j0s4luPt2V6aMzUSebh2Q8ESLJDX89/siW
	phEUYlb4nPT3B6gQLxRWkuqCESYPyXlK+H0+cbxoD5Z5/lNhF2nr+CSUoYVw0mi/976rENaT
	i3YH98G5glRebXjvkQkbyKUSHxNiZTDT23WdCjmJkC0jA1km6kPhM/KPo58+hRRWNK8CKbUJ
	qfFqrS5yjSYjQZu+5tDheCcKfpTt2NzPt9CU5/tGJPBItUChuemVlIw6NSkjvhERnlItVNBp
	wZUiVp1xRNIf3q9P0UlJjWgJT6sWKb6aTotVCr+ok6VfJSlR0n+8Yl62OBMthZxv8nXRYTHz
	Jsq7V6SbLpEI0+r4nfpkS0yFKqtZGKktsmruHzWrR6M0YSc95h8NB523d5zd3Zdi3zf6dpn1
	8vmZbbJS46aV8rMa84TU3xNXH7c30jgz1b3RFgPRyT/Y3STy3wPfNZ+ZG/ri663Lort+e9z+
	rGfcEQCTuebFdRWdpFFHrKL0Sep38+YPL00DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzHfZ/fHcfjNJ5hw01j3VBbtY/fZm2+szH/YMymZzzTrR/sLiXG
	jpL0azIJHVJcpyKemNCRa10q/bquUCc04ubIzl2cChfzz2evfT7v9+uvD0eqjPRMTpuYJOkS
	xXg1o6AUG5enLVra2C2F1bg4yM8JA583kwJjVSUDHTcrEFTeOUqAq2EdPB92IxhpbSehsKAD
	wZW3r0i4Y+tHYDEfY6Dr3WRw+IYYaCrIZiCttIqBzk+jBDjPniagQt4ALadKCKjzf6Cg0MVA
	UWEaERgfCfCbylkwGUJgwHyBhdG34dDU30ND/cUmGiy9Gjh/yclAraWJAlvNAAFdD4wM9Ff+
	pqHF9pSCjvxcGm58KWHg07CJBJNviAV7XTEBt9IDtoxvv2hozK0jIOPqbQIcLx8ieJT5hgC5
	soeBep+bgGq5gISfZQ0IBvI+s3A8x89C0dE8BNnHz1LQPtZIQ7ozEkZ+GJk1y3G9e4jE6dUp
	2DJcTOHmEgHfv/CKxemPellcLO/H1eZQXFrrIvAVj4/GcvlJBsue0yzO+uwg8Je2NhY/PTdC
	4XeOQmLT7O2KFbuleG2ypFuyKkYRm5fpY/bZuAMWg5syoHYmCwVxAh8hGOsH0Tgz/ALhxQs/
	Oc7B/FyhOneQzkIKjuRPTBTMX1sDBY6bxm8QWtqmjGcoPkSwljX/7Sr5SOFqmZn955wjVNyq
	++sJ4qOE60VuepxVgUx3513yFFIUownlKFibmJwgauMjF+vjYlMTtQcW79qbIKPAz5gOj+bX
	IG/XOiviOaSepIy955BUtJisT02wIoEj1cFKKiWwUu4WUw9Kur07dfvjJb0VzeIo9Qzl+q1S
	jIrfIyZJcZK0T9L9vxJc0EwDerJJnCMHjS3TbXvwPe5Mz8Jrnqhs++WVoSvtmhOb98i3I9Z7
	KO3q6LnerdGvG+xHpjo9O/rGYnCfxi9kWqcvzHAtWXFofrQh6jUdsZFf/TD4sn3W+57hPHv7
	jy1uTcoH53bbPNUqVTd+PBgW4p3a2BwZahJvrv39bMZXb62mqypHTeljxfBQUqcX/wCj3/+Y
	LwMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Makes Dept able to track dependencies by swaits.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/swait.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index d324419482a0..277ac74f61c3 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -6,6 +6,7 @@
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
+#include <linux/dept_sdt.h>
 #include <asm/current.h>
 
 /*
@@ -161,6 +162,7 @@ extern void finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
 	struct swait_queue __wait;					\
 	long __ret = ret;						\
 									\
+	sdt_might_sleep_start(NULL);					\
 	INIT_LIST_HEAD(&__wait.task_list);				\
 	for (;;) {							\
 		long __int = prepare_to_swait_event(&wq, &__wait, state);\
@@ -176,6 +178,7 @@ extern void finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
 		cmd;							\
 	}								\
 	finish_swait(&wq, &__wait);					\
+	sdt_might_sleep_end();						\
 __out:	__ret;								\
 })
 
-- 
2.17.1



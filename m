Return-Path: <linux-fsdevel+bounces-49354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E75ABB8F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33ADB17C48D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6374C277811;
	Mon, 19 May 2025 09:18:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A59626FD81;
	Mon, 19 May 2025 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646335; cv=none; b=BiUFp9IzWNiw4rwwc9cQV30lHpHUuSvcHYvLxyqQJA8fO3BEp/62eyNp6S1mBS97aXfCOTw8wDGSMWtvgtInNnqNhQLL3aHozDivOwQvY/5Pi9pfPeqFNNmQV/fcgoalx52ulx5O3fbHzHEtI5X68GrQYKQRN6gMZ8IbKQsHD1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646335; c=relaxed/simple;
	bh=pLUSXjgVOyB6ewzDMD2B/aTj2n2b3ii/EXLHyurcTzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BbQOt1wGFpa3aw7J9hcM9aw9C77CRbFe33i87S3DSNNlDyK0MpujLNDO+cTkQ6lt708FlMhs7D35aVvmCRu53edrkuU1eisVyRoBvPYRsu4aWTT5jRLnnQKXNmNnoE+zrdySflJ9CjhkWg5MmmntiLXsXO5LbRpHxDYfLXduCwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-b5-682af76ebd89
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
Subject: [PATCH v16 14/42] dept: apply sdt_might_sleep_{start,end}() to swait
Date: Mon, 19 May 2025 18:17:58 +0900
Message-Id: <20250519091826.19752-15-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAz2Sa0yTdxTG/b/3VuveVDfeqVHSRLdhvNTocj6oMRHjP0aMcV+8zLgGXm0D
	FNMqt8QIE4yCBcQgXhBr3SrSSrF1mTqLWKSIBNZJKYVxGTjJiCDatcUiXgpRv5w8eZ7z/M6X
	w5HyJnoep9EeEnVaVYqCkVLS0VmmZdrxOPVK0/UlEAqeoKDCZmXAU2NBYL2VS8Bw42boDI8g
	eNP6JwnlZR4EVwZ6Sbjl7kPgrPqZgfZ/Z4M3NMZAc1khA8eu2hj46/kkAT1nSwmw2BOg3zxE
	QUuJiYDyYQYulh8jouM/AiLmahbMOYthsOoCC5MDSmju89Hg7F4K5yt7GLjnbKbAfXuQgPa7
	FQz0Wd/T0OJ+REG4aD54ThtouPHCxMDzsJkEc2iMhSf1RgLcxq+gNi8KPP7/OxqaDPUEHP/l
	JgHerj8Q1J34hwC71cdAQ2iEAIe9jISJa40IBotGWcg/FWHhYm4RgsL8sxTk9ayBN6+jly8F
	lZB7uZaCG299aMM6bK20ItwwMkbiPEcGngh1MNgZNlL4sUnAdy70sjivrpvFRvth7KiKw1fv
	DRP4SiBEY3v1SQbbA6UsLhj1EvhFWxu7fcFu6dokMUWTLupWrP9Jqg4MdNAHG7lM/6932RzU
	xhQgCSfwq4X7+YbPusPmmtYM/43g90fIKT2XjxUchiG6AEk5kvfNFDovdaGpYA6fILzq7You
	cRzFLxbcNfFTtoz/XjhpaP7IXCRYauunOZKo313YMF2V82sEr6WSmmIKfLFEaDln/lj4WnhQ
	5adKkMyIZlQjuUabnqrSpKxers7SajKXJ6al2lH0vcxHJvfcRgHPDy7Ec0gxS1br/E4tp1Xp
	+qxUFxI4UjFXVu34Vi2XJamyskVd2j7d4RRR70LzOUoRI1sVzkiS8wdUh8RkUTwo6j6lBCeZ
	l4Nqftv2haPTW5dY8Y7y3/n9qa9EwySnje/KcArKOkdChO/fatne3tW0Mf7hmdTsjSv3jj+V
	lB59SS4tDh7J8Py9Ux/cmxgbk325dc6iZ1++XFEQvwqfXlAcE7HRjf2B/TPX7ZwY6vjxcVEr
	ufAAH7tj0xYHr8u8pnMlB21o/fsnyl0KSq9WKeNInV71AcIr1Q9aAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTcRTG+793V6uXZfWiRDGKysg0Ug4ZFRX0FhRCRNGXGvrS5mXKpiuj
	QHNJzWYXUMvLWppr6cy5+aHbymbOVmim03SppVQkmpK5ee0ypb4cHp7nnN/z5TC45D4ZwiiU
	aYJKKUuSUiJCdCgme5NyIkweMTuzBHzjlwgoqbFQ0PqgCoGlLguDwcZ98N4/jGCm+S0Ohfmt
	CO709+JQ5+pD4DBfoKD982Lw+EYpcOfnUpBdXkPBu6FZDHoKbmBQZTsIH01fCXhzrQyDwkEK
	iguzscD4hsGUqZIGU+ZaGDAX0TDbHwnuvk4SGkrdJDi8G+GWoYeCpw43Aa6HAxi0Py6hoM/y
	h4Q3rlcE+PNCofW6noTqkTIKhvwmHEy+URra6o0YuIzLwaoNUHN+/iahSV+PQc7dWgw83U8Q
	PLv0CQObpZOCBt8wBnZbPg7T9xoRDOR9p+HilSkairPyEOReLCBA2xMFM5OB5tLxSMi6bSWg
	+lcn2rWDtxgsiG8YHsV5rf00P+3roHiH30jwr8s4/lFRL81rn3lp3mhL5+3mML786SDG3xnz
	kbyt8jLF28Zu0LzuuwfjR1pa6NiVx0Xb44UkhUZQbd5xUiQf6+8gUxuZM10Vj+lM1ELpUBDD
	sVu5jhrnvKbYdVxX1xQ+p4PZ1Zxd/5XUIRGDs50Lufel3WguWMoe5H70dgeWGIZg13KuB3vn
	bDEbzV3Wu/8xV3FV1vp5TlDA9+Y2zJ9K2CjOU2UgriGRES2oRMEKpSZZpkiKClcnyjOUijPh
	cSnJNhR4INP52esP0Xj7PidiGSRdJLY6NsglpEyjzkh2Io7BpcHiSvt6uUQcL8s4K6hSTqjS
	kwS1E4UyhHSF+MBR4aSEPSVLExIFIVVQ/U8xJigkE7VV+KuVwUXHorfcrI44SsQy21R1Vu2e
	iOnUwyPppQbPVU1MfIn5CT15vplsMhfIvet0z7XOn4zRszI39uXgtyhdYzmneZG2zDvUtCBh
	Z21PxqKcsf1m5Zf77KqJ6IrCc3kJzZ82HQnd45/sWKO/Wlyz1CKNiduNPmwJSZwwDPdKCbVc
	FhmGq9Syvzw9T588AwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Make dept able to track dependencies by swaits.

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



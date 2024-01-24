Return-Path: <linux-fsdevel+bounces-8728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF3C83A8D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A7428C484
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51237634F6;
	Wed, 24 Jan 2024 12:00:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CA561689;
	Wed, 24 Jan 2024 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097606; cv=none; b=gWtQ/8TTRLUuCiL2wQMHe/8bkOL0XmEUwuKxVD8TYzfOiBnuQIOOwdCrsJH3iCdmPZHY7tX5xoImIAJ9+dr2pbxlSAAgsCvO9unkMuAqQsaamy/9r8clvNXa1JoywG+k6/8Wt7me/ZuO0z9eWLeIxtqUqhbUeM3HUjjs01I5ApU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097606; c=relaxed/simple;
	bh=tg0pA2ZlUNywKtzMfrdbwkG7GYbhIVlK2HrCAbcpiMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Hj+u0yPTySOtfvFv4PV2MHBT6TLQLoPnOznZkhgLhOvtLpH3jPzvFVs+NcPt3C4YloUelNOf/yRkZHCcCvmJm9nyAVGhQLlInVs2qi/LbYqhBCHjKc7Uk8UST6ebKRUhbcCobSLHOW1WDg3zBocTjPrrTFe3wktGd/9ODyfiAE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-c5-65b0fbb52f43
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
Subject: [PATCH v11 08/26] dept: Apply sdt_might_sleep_{start,end}() to swait
Date: Wed, 24 Jan 2024 20:59:19 +0900
Message-Id: <20240124115938.80132-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124115938.80132-1-byungchul@sk.com>
References: <20240124115938.80132-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTcRSH/b93Z6uXJfRmRDKwe6ZlcjANoQ+9fQiioKAIXfmSq6k10zKI
	vKbNvIat8tLUmGuarq1ArdlSsky8S5qYqJlp3nK5kTorZ/Tl8ON3zvN8OgwuqSE9GHnkFUEZ
	KVNIKREhmlpVvOvFokHwGf3hDzl3fMA2l0ZAQVUFBe2V5QgqnidgMP72EPTYJxEstrThoM5r
	R1A89BmH540DCMy6RAq6RlZDt22Ggqa8dAqSSqso6JhwYNB/LxeDcuMRaM4uwcAy/40A9TgF
	+eokbHmMYTCv1dOgjfeCYd1DGhxDvtA08JEEc98OeFDUT8ErcxMBjdXDGHTVFlAwUPGHhObG
	9wS052SQ8HS6hIIJuxYHrW2Ghk6LBgND8rLo1s/fJLzLsGBw6/EzDLo/vURQlzaIgbHiIwUN
	tkkMTMY8HBbK3iIYzpyiIeXOPA35CZkI0lPuEdC29I6E5P59sPirgAoO4BsmZ3A+2XSVN9s1
	BP+hhONrHn6m+eS6PprXGGN4k247X/pqHOOLrTaSN+pvU7zRmkvzqqlujJ9ubaX59/cXCX6k
	W40d3XBKFBgmKOSxgnL3gVBReGaajbrUyFwzx08S8aiNUiFXhmP9uNSeWVqFmJX8yIacNcVu
	4Xp753Fndmc9OVPGKKlCIgZnU9043Y+WFXYte4Qb7RkinCzBenE1po3OWszu44a/lhL/9Ju4
	coNlxePK+nNPH/St9JLlm0F9Fu10cmyqK9fpSMT/Aeu5N7peIhuJNchFjyTyyNgImVzh5x0e
	Fym/5n0uKsKIlh9Ke8NxuhpZ24/XI5ZB0lXiYH2VICFlsdFxEfWIY3Cpu7h3faUgEYfJ4q4L
	yqgQZYxCiK5HGxhCuk68x341TMKel10RLgrCJUH5f4sxrh7x6PbmgKWF7xbN2P3dE9UuDs+s
	g8cvezUEgHjN5aDg07Vbz41su1sYFmS9cWyv4+zNM4WzmwIV38VF6W5lRaEZrVZ11hMX93VD
	ZRHoROXSG2vpVP3+EM/X/sw3Q4HCpbjWcYEl/VVjdzNj6r6ktZoGT+bVSe2BHb9jD3/JnfMz
	eLvtlBLR4TLf7bgyWvYXhYsroUwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSfUyMcRz3+z3P83uejuPZuc3jbezMGPPe2dcy/OHlN6NYf9i8TEcPHZXc
	kTKslFSUioSSFKddx9Udm3DWatKxFN16k6ZWkiJL15yLdDb/fPbZ5+2vj8Cocrlpgj7ymGyI
	1IVriIJVBAYkLHrkLZWXOq2zIPPiUnAPJbOQZ7UQqH9QgsDyMB5D74tN0DTcj8BbW8dATnY9
	gtsdHxh4WN2OwFF8lkBD10RwuQcIOLMvEEgoshJ42zeCoe1qFoYS21Z4nVGIocLTw0JOL4Hc
	nAQ8Bp8xeExmHkxxc6Gz+AYPIx3LwNneyEHVTScHjtaFcD2/jcAzh5OF6sedGBqe5BFot4xy
	8Lq6hoX6zDQO7n8rJNA3bGLA5B7g4V1FAYbSxLG1pB9/OHiZVoEh6U4ZBlfLUwTPkz9isFka
	CVS5+zHYbdkM/Lr3AkFn+lcezl308JAbn47gwrmrLNT9fslBYpsWvD/zyLoAWtU/wNBE+wnq
	GC5g6atCiZbf+MDTxOetPC2wHaf24gW06FkvprcH3Ry1mVMItQ1m8TT1qwvTb2/e8LTmmpel
	Xa4cvG3GTsXqUDlcHy0blqwJUYSlJ7tJVLUQ44jrZ+NQHUlFgiCJ/tItN0pFfgIR50nNzR7G
	x9XibMme9olLRQqBEc+Pl4q/1xKfMVncKn1q6mB9XVacK5XbZ/pkpaiVOruLWB+XxFlSSWnF
	vx0/caV0/3rrP101lvlovsRnIEUBGmdGan1kdIROH65dbDwcFhupj1m8/0iEDY1dxnR6JPMx
	GmrYVIlEAWkmKNeZrbKK00UbYyMqkSQwGrWyeeoDWaUM1cWelA1H9hqOh8vGSjRdYDVTlJt3
	yCEq8aDumHxYlqNkw38XC37T4tCj0ffDizKcV5SvXO/OBAbOcZfOrFKrA7LmrxqNvxRUtHuz
	K9TjFXf3hfRtH0j5Tpsua4OeLFye1Hx3wqD/5bUb1h9V+Q8GBbeX2coP3DnVOOnsii35OzcE
	H5ojSWXBu8hvHDN/9p6hlEouu8XRfTPfKtbkaVfXnu7p3tjTvWaf5UuXhjWG6ZYtYAxG3V8+
	1AJ4LgMAAA==
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



Return-Path: <linux-fsdevel+bounces-13705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620748731A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129661F21478
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 08:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCD560DD0;
	Wed,  6 Mar 2024 08:55:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB695F488;
	Wed,  6 Mar 2024 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715340; cv=none; b=kSWa9MPeXw568SR7rkuhAf+WzjKJR0SKIqM2nk6pajSkIXyn/ieiVb50DzYrBXCsIegdTN4j+X5rGpYbUpUyUGEdgMhF1VhdDT0FHlg1+/mipVJKk8eVSYUq9zumgSbpYpsqnbEolN4FG5uVJpYB2K5c+mH6xQJaiQP1OzZTucM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715340; c=relaxed/simple;
	bh=tg0pA2ZlUNywKtzMfrdbwkG7GYbhIVlK2HrCAbcpiMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kGjAPx53zNwpPmq7Z7zzWdqYhn55VD+CQWORpch4FOxy1sKtqeL1GPbD2lbZ6CkaM/bQEdPuI+V+SAKP8OMHiIp4RkQfn0nGSJOfCnnIZRv3KCIvvbijjSglg+SB31ui//Is02v0S/8HW3oB9D4a6pl1iIo3uJgtm4tTarhg9Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-a8-65e82f7d71d2
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
Subject: [PATCH v13 08/27] dept: Apply sdt_might_sleep_{start,end}() to swait
Date: Wed,  6 Mar 2024 17:54:54 +0900
Message-Id: <20240306085513.41482-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306085513.41482-1-byungchul@sk.com>
References: <20240306085513.41482-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0zMcRjH+3x/d5y+O22+sokzbFk/EB6b0V98/7EZ5g9s3PRVR3fs+nVR
	W1dJSqUsh8J1tZM6ypWJuuTiCOXUjeRKEkpXWVzrFLkO/zx77Xleez/PHw+DS+6QAYxcGSeo
	lLIYKSUiRCNz9cEpoYNCWPFYEBScDQPXjywCSqqNFNhuVSEw1mkwGHq8Dd5MOBFMtb3EQVtk
	Q1D6oQeHOmsvAnNFGgWdA/PA7hqjoLUoh4L0smoKXg1PY+C4UIhBlWk7PD+nx6DZ/YUA7RAF
	xdp0zFMGMXAbKmkwpC6H/orLNEx/WA2tva9JMHevgktXHRQ0mlsJsNb3Y9B5v4SCXuMMCc+t
	TwmwFeSScHNUT8HwhAEHg2uMho5mHQY1GZ6gzO+/SXiS24xBZvltDOxvGxA0ZfVhYDK+pqDF
	5cSg1lSEw8/rjxH0543QcOqsm4ZiTR6CnFMXCMhwrIOpyRIqYiPf4hzD+YzaRN48oSP4Z3qO
	v3e5h+YzmrppXmeK52srgviyxiGMLx13kbyp8gzFm8YLaT57xI7xo+3tNP/04hTBD9i12I6A
	vaJNkUKMPEFQhW4+KIrOy3JRx62M2pzqJFLRSyob+TIcG859s1yh/7PjdyE5yxS7kuvqcuOz
	7M8u4WpzP3v7OOsUceXtW2d5PrudK5s673UIdjln+DHjdcTsOq49N5/4mxnIVdU0ex1fdj2X
	P5rv3SvxOG3ppR4WeZwZhmvTlP87aCH3sKKLOIfEOuRTiSRyZYJCJo8JD4lOUsrVIYeOKUzI
	80yGlOl99WjctsuCWAZJ54ojfL8IElKWEJuksCCOwaX+4uSfA4JEHClLOiGojh1QxccIsRa0
	iCGkC8RrJhIjJWyULE44KgjHBdX/Kcb4BqSiI8kBxprJk1tu+uui1oS4hS3XLvlEbR4MTLvY
	ZfmqMBToFF+Fpr3Zp5f1+N3QBT9Qq/sWhzN75JlLd6pW6B3fdsfvduzPeaRVc58m0+zkvDCT
	UjXQdMD/l19ow4vvyxJHu8sjRjo6yw5zGudan7vv+vW2OYF+1cMbF358b12h2ZAiJWKjZauD
	cFWs7A8OglZcSAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa2xLYRjHve855z1tqZzUcGIfUPfJZsJ4YiKTCCeEkAWLSDjmRGsX0tqY
	W8o2GbOrTOlGdpFqtrm1c53KbFkZNmONa9exLGxWHbUuagu2ii9PfnmeX/7Pl7+MUhmZSTJt
	8j5JlywmqomCVqyLTg8/Mq9bivzybRwUnI4Ef38WDSXXqgm0Xq1CUF1zDENP4yp4PeBBMNj8
	nAJjUSuCso/tFNQ43AjsluME2rrGgtPfR6CpKJtAesU1Ai96hzC4zhZiqLKuhaf55RjqAp9p
	MPYQKDam4+HRjSFgrmTBbJgBnRYTC0Mf50OT+xUDDReaGLC/mwvnL7oI3Lc30eC404mh7V4J
	AXf1HwaeOh7T0FqQw8AVbzmB3gEzBWZ/Hwsv60oxXM8YTjvx4zcDj3LqMJy4dAOD820tggdZ
	HzBYq18RaPB7MNisRRT8utyIoDP3KwuZpwMsFB/LRZCdeZaGDFcUDP4sITFLhAZPHyVk2PYL
	9oFSWnhSzgt3Te2skPHgHSuUWlMEmyVMqLjfg4Uyn58RrJUniWD1FbLCqa9OLHhbWljh8blB
	WuhyGvH60C2KpTulRG2qpJu3bLtCk5vlJ3sdsgN2g4c2oOfkFJLLeG4h7/pdyIww4Wbxb94E
	qBEO4abwtpxPwT3FeRT8pZaVIzyOW8tXDJ4JOjQ3gzf3/wk6Si6Kb8nJo/9lTuarrtcFHTm3
	iM/z5gV/qYad5vQyko8UpWhUJQrRJqcmidrEqAh9giYtWXsgIn5PkhUN18V8ZKjgDupvW1WP
	OBlSj1HGyD9LKkZM1acl1SNeRqlDlId/dUkq5U4x7aCk27NNl5Io6etRqIxWT1Su3ixtV3G7
	xH1SgiTtlXT/r1gmn2RAFYHY9tGxC7q3Dhg0s933TG9DFzldCxwbfTVx3vxwy9HlCzFujvdu
	nD4h72Im7jD5bBFVY8Kv+m4tftR4s6MxjpuG43cffebteH8rJTZyzYeQqeN31R5aMfPhhk0J
	0dMfyhWm2+KQZUJW7Y606Js9c76L+i/eyCW7Z+/3OGKyNWFuNa3XiPPDKJ1e/AudERJ6KgMA
	AA==
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



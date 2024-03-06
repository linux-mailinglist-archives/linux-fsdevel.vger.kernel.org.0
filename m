Return-Path: <linux-fsdevel+bounces-13706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B848731AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 10:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071611C20399
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C8960ED4;
	Wed,  6 Mar 2024 08:55:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464785FDD2;
	Wed,  6 Mar 2024 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715341; cv=none; b=pfYRemDs93kw6JBGVikpiGnSg/Q4fyYK0Y+IW1QmZ1Fr4RoRsURu+XkonrhTUsxs12EfVPFhtAnomjEPj4i/lsz7kdNSM9KNqKPy5LWZueA86+Hs73PbqpiTsGC2aSlgo//oDCeCS8ohy5tOe8eOeGm2eBp9vvZ7HrcAAzF9tps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715341; c=relaxed/simple;
	bh=MruAYr/ze2aZU4Q6DDtEFdBspBpkL05uqzvhsrQG5Gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=l9oNF9fJLa7+ayKDGgJFgljVzKnZmKD2hAX4Q2G1YKjKtnPV0GOdEGzdz1p5bh2CE6LyILPVfD60BAy0n+rGDSaMBvHTI0Dw6nu5ZHIQy9o0+eMKrXee+i0NbRUN8ZaFKa8faapTbwtdxHgCVYdKx/QxI1FQSGLV1nkClwGxJJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-c8-65e82f7dd99b
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
Subject: [PATCH v13 10/27] dept: Apply sdt_might_sleep_{start,end}() to hashed-waitqueue wait
Date: Wed,  6 Mar 2024 17:54:56 +0900
Message-Id: <20240306085513.41482-11-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306085513.41482-1-byungchul@sk.com>
References: <20240306085513.41482-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzHfb/Pz05nz06bRww7a01WZOJjzJoZz5Y2W+bHmXHco051cqUf
	xkRlSCpbDt1Sp51bXeJipB9SpESKG09WTa2ppjo77kiRu+ifz177fN577fPHmyUUDyh/VqtL
	EvU6dZySlpGyUV9T8KkVQ+LKzub1kH9pJbi+nyfBWGmloeNOOQLr/TMYhp9vhQ/uEQQTr98Q
	YCjoQFDS10PA/eZeBHWWszS8G5gDdpeDhtaCbBoyblXS0PllEkP31SsYym2R0JZnwtAwPkiC
	YZiGQkMG9owhDOPmMgbM6QHQb7nBwGRfKLT2vqeg7uNyuF7UTUNtXSsJzY/6Mbx7bKSh1zpF
	QVtzCwkd+TkUVIyZaPjiNhNgdjkYeNtQjOFupkd07tsfCl7kNGA4V3oPg72rBkH9+U8YbNb3
	NDS5RjBU2QoI+HX7OYL+y6MMZF0aZ6DwzGUE2VlXScjsDoOJn0Y6fJ3QNOIghMyqFKHOXUwK
	L028UH2jhxEy6z8yQrHtuFBlCRJu1Q5jocTpogRb2QVasDmvMMLFUTsWxtrbGaHl2gQpDNgN
	eLu/SrZBI8Zpk0X9io0HZDGDPflUgsSm/n5WzaQjib6IfFieW827jDfxDNdLTcjLNBfIS9I4
	4WU/bglflfOZ8jLBjcj40vYtXp7L7eNbSiXGyyQXwH8aezLtlHNr+D5bAfrnXMyX322Y9vh4
	9rljudMZBRfGv84o8bDMk/nJ8tVNRf8fms8/tUhkHpIXo1llSKHVJcertXGrQ2LSdNrUkENH
	423IUybzqcm9j5CzI6oRcSxS+srDfQZFBaVOTkyLb0Q8Syj95Cd/DYgKuUaddkLUH92vPx4n
	JjaiBSypnCdf5U7RKLhodZIYK4oJon7milkf/3R0+MjutojAYy/nFQXRC+2qV5st3bmpu4Jj
	1u5d9uG0ZVuAu+vh5L1WppdrdHwVdcsORvsNBS/S/Og8yTlCJmqORRSm7Pz8TOObMNWZNLso
	6mz8pqjoyKV7tlUskLreOHaHPzEHGIxkSReF+q5L4TmzY3cwlppZP5wKVZgq0nXEUKskE2PU
	oUGEPlH9Fy08XIRIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+5/L/8zV5LCsDvYhGd2jMlJ5yYqKLofI6FOBULnylCs3ZTPT
	qDA3o4s2FebKS8wLS6ZlbV1WUxOnpolmumyJWi7JJNNuk6Z2cUZfXn48z8Pv0ysipUY6WKRQ
	JQlqlTxehsWUeG+kdvW5tR+F0An9YsjJDAXvj0sUFFZVYui4U4Gg8v4FAoYbd8Hr8REEk20v
	SDAaOhAUD/SRcL+pH0FNeTqGrsFAcHnHMLQYrmLQllZhePlpioDevFwCKqxR0JpdQkCdb4gC
	4zCGAqOWmD4fCfCZLQyY05aApzyfgamBddDS302Ds6iFhpqeVXDjZi+G6poWCprsHgK6nhRi
	6K/8Q0NrUzMFHTlZNNweLcHwadxMgtk7xkBnnYmAu7pp28Xvv2l4llVHwMWyewS43jgQ1F56
	R4C1shuD0ztCgM1qIGHiViMCz7XPDGRk+hgouHANwdWMPAp0veEw+bMQb9nAO0fGSF5nO83X
	jJso/nkJxz/O72N4XW0Pw5usp3hb+Uq+tHqY4Iu/eWnearmMeeu3XIa/8tlF8KPt7QzffH2S
	4gddRmLfwmjxxlghXpEsqNdujhHHDfXl0IluUcqvhsdMGnLjKyhAxLFhXK3bifyM2WWc2+0j
	/RzEhnC2rA+0n0l2RMyVte/081z2INdc5mb8TLFLuHejT2c8EjaCG7Aa0D/nIq7ibt2MJ2A6
	14/qZzZSNpxr0xbjbCQ2oVkWFKRQJSvlivjwNZqTcakqRcqaowlKK5p+F/O5qRw7+tG1qx6x
	IiSbI9kSMCRIaXmyJlVZjzgRKQuSnJ0YFKSSWHnqGUGdcFh9Kl7Q1KOFIkq2QLL7gBAjZY/L
	k4STgpAoqP+3hCggOA29t+zXb38Vms7I9xkPLQ3btL717SJJcIo2ko5yFF2fOO+URbzkolct
	9zT4Oh89nGdPq7ZvC6Se2fRPTjwoflsa44h1tIVsdZ0/VjS3ymBR5pd+ietanD4UudQ2plsx
	+fXegJkJmR8tMelxmCrSk6HszLMH9jrSjygyA2/u2COZLaM0cfJ1K0m1Rv4X/86YqyoDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Makes Dept able to track dependencies by hashed-waitqueue waits.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait_bit.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 7725b7579b78..fe89282c3e96 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -6,6 +6,7 @@
  * Linux wait-bit related types and methods:
  */
 #include <linux/wait.h>
+#include <linux/dept_sdt.h>
 
 struct wait_bit_key {
 	void			*flags;
@@ -246,6 +247,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
 	struct wait_bit_queue_entry __wbq_entry;			\
 	long __ret = ret; /* explicit shadow */				\
 									\
+	sdt_might_sleep_start(NULL);					\
 	init_wait_var_entry(&__wbq_entry, var,				\
 			    exclusive ? WQ_FLAG_EXCLUSIVE : 0);		\
 	for (;;) {							\
@@ -263,6 +265,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
 		cmd;							\
 	}								\
 	finish_wait(__wq_head, &__wbq_entry.wq_entry);			\
+	sdt_might_sleep_end();						\
 __out:	__ret;								\
 })
 
-- 
2.17.1



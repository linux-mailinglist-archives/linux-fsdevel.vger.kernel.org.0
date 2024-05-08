Return-Path: <linux-fsdevel+bounces-19072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A43B8BFA8C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 12:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36348281A5D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 10:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B0E127E06;
	Wed,  8 May 2024 10:03:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F48C7E111;
	Wed,  8 May 2024 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162587; cv=none; b=GyJ2zw5xwHbqB3FFMYUT/s2HGc7pAiJyYNUO9ginqc/PEn6jQtu3g+fZ46vaCB5p3ZEYJt+2TfWJEFYOzZAaWksuCZVgLpK3U2zvw7rmIKS22N49/M3rTQl7Y+kyEJb4aOrD/NyvQuBVthEf7Eh57AgrmVvURouB6Y/LJjweHkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162587; c=relaxed/simple;
	bh=tg0pA2ZlUNywKtzMfrdbwkG7GYbhIVlK2HrCAbcpiMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EfOnsrAtLat4m/d9St0ywM6KrZ1YZcvdUUf5DSRautxZU0yjrw/vMN1aeSkiXl1bAW0hee+rjvBSfO4/EQkj7Sdrf/G1jEZayoIHJZa5CuDg4kOX30BNbjEOfMFBDuIwBHzER9JjZwf9C1rOKcnou1qAzqlMFhG72pMwRzIHkdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-d5-663b4a3a34c6
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
Subject: [PATCH v14 12/28] dept: Apply sdt_might_sleep_{start,end}() to swait
Date: Wed,  8 May 2024 18:47:09 +0900
Message-Id: <20240508094726.35754-13-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508094726.35754-1-byungchul@sk.com>
References: <20240508094726.35754-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSfUzMcRwHcN/v7/Funf12bP3kD3ZjhomMfDzMbMSXeZynDcNNv9xRyV0i
	G7ueqNQREhUqdqVLcdc837mOotCTprKrEUvN1XFckxoq/PPZa5/Pe++/PjylLGcCeG1ktKSL
	VIerWDkt7/HLn7Fg1cKwWV1JYyAjbRb4vifTkFtWwkJ9qRlBSXkchu7KFdDc50Yw8KqOgqzM
	egT579soKK9qR2Arimfh9cfR0OTzsFCdeYqFhGtlLDR8HsTgunAWg9myBl6cKcDg6P9EQ1Y3
	CzlZCXhodGHoNxVzYDJMho6ibA4G3wdBdfsbBmxvp8OlKy4WHtmqaai614Hh9YNcFtpLfjPw
	ouo5DfUZ6Qzc7C1g4XOfiQKTz8NBoyMPw63EoaIT334x8CzdgeHE9dsYmlofIrAnv8NgKXnD
	whOfG4PVkknBz8JKBB3GHg6S0vo5yIkzIjiVdIGGRNdcGPiRyy6ZT564PRRJtB4mtr48mtQU
	iOR+dhtHEu1vOZJnOUSsRdPItUfdmOR7fQyxFKewxOI9y5HUniZMemtrOfL84gBNPjZl4fUB
	2+SLQqVwbYykm7l4t1xjTPaxUVX8EZvBTRtQHZuKZLwozBHLalKZ/z7prqaGzQpTxJaW/hGP
	FSaK1vTOkQwluOXi9drlwx4jrBGtd15yw6aFyWJXW8JIRiEEiwXPXP86J4jmW46RHtnQvvVT
	Lxq2UpgrPkzI5v5mfvBiTcPUvx4nVhS10GeQIg+NKkZKbWRMhFobPidQExupPRK450CEBQ39
	kunY4PZ7yFu/0YkEHqn8FA7/BWFKRh2jj41wIpGnVGMVlSfnhSkVoerYo5LuwC7doXBJ70Tj
	eVrlr5jddzhUKexVR0v7JSlK0v2/Yl4WYEBB8VN6jnvX7rt63nm6MXvVsq+2kO6nIRWexg5j
	pumL2fDhQ6D5Eh7/tLPVL2lrof/OjOBl+u/RzavvMqHrPK0byf0w2QZ3qWHpTn/j5pXnJsXd
	KDWA5nLKDo14MIWxb3mc1hk878bC1falTpk3JN71NcBQqFyca24+XbGpMuqdzq6i9Rp10DRK
	p1f/AaJ0MwxHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSa0hTYRgHcN9zec8cTU7L6GAfqkVGdo+sp4yo6HISii4fjL7kyGOOpsWm
	ltHFtaVWOjSw5SWxLZY4MzuLsmy2NK1l2WqjTKal3ZSm0mXSVCpn9OXhx/N/+H96JKTcREdJ
	VGnpgiZNqVZgKSXdHqdfuCo+LnnJiG01FOUvgcDPPArKb9RgcNfaENTc0hHQ37IF3gz7EYw+
	f0GCqdiN4EpPFwm3WrsROKpOY/B8jABvYAiDq/g8Br3lBoaXX8cI8F28QIBN3AZthWYCnMEv
	FJj6MZSZ9MT46CMgaK1mwJo9B3qrShkY61kKru7XNDRfdtHg6JwPJRU+DPcdLgpa63sJ8Nwr
	x9Bd84eGttYnFLiLCmi4PmjG8HXYSoI1MMTAK2clAXWG8bacH79peFzgJCDn6k0CvG8bEDTm
	vSdArHmNoTngJ8AuFpMwcq0FQa9xgIEz+UEGynRGBOfPXKTA4IuF0V/leN1qvtk/RPIG+xHe
	MVxJ8U/NHH+3tIvhDY2dDF8pZvD2qhjecr+f4K98D9C8WH0W8+L3Cwx/bsBL8IPt7Qz/5NIo
	xX/0mogd0/dK1yQJalWmoFm8NlGaYswL4MOtkqOObD+VjV7gcyhcwrHLuVy/iwwZs3O5jo7g
	hCPZmZy94DMdMsn6pdzV9s0hT2G3cfbbz5iQKXYO19eln7iRsSs482Mf/a9zBmerc070hI/v
	334ZRCHL2ViuQV/KFCJpJQqrRpGqtMxUpUodu0h7MCUrTXV00f5DqSIafxfribGievTTs6UJ
	sRKkmCRz47hkOa3M1GalNiFOQioiZS25K5PlsiRl1jFBc2ifJkMtaJvQdAmlmCaLTxAS5ewB
	ZbpwUBAOC5r/KSEJj8pGlNa4vLm/tswTtqa2Ir3uz5Rob9SI5VRf2zpnoq9xTNczW2m45pfN
	25AQPPnQErF204dd3wZOeT70OHfm5IhvjCVhk+OLZUMRhawu/1NufrSufm5hh5V9ueK2fmNJ
	/Z6B6GmPnDMt6qncw9+63e8W2Na7PVlt5ll3fCuXwVbxwXEFpU1RLo0hNVrlX27/Nt0qAwAA
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



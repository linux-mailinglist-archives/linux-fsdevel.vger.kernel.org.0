Return-Path: <linux-fsdevel+bounces-48850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F04CBAB518B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF1E1B475E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B493F26B0B2;
	Tue, 13 May 2025 10:08:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98BA2472A2;
	Tue, 13 May 2025 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130880; cv=none; b=WQPMfvypT1oHmf+9mzH92COqC93R3Cob4wUOaeKFTyRBuDVApR2FdPgwWrBelaJ28VC2CPYUmQpzKocmjSbkOO1B72uB5N2YonA4yNjdwxcnLMXZlpii2Nw6D1dYYmcPHLLmX9n7BpbIxR4L0Hh0OXhcU680O0sbas7AHm0gQn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130880; c=relaxed/simple;
	bh=+bd9WiorYKiALUTe/ZE9Twmt5uX3p97amk10CfbvR3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=A+kW/oAnwgiO5a66VsNS0bR3miysfDLgrEyeP7kVYtLlwI0fdBdm2+AVc/1nvL5Hq/TXJT7OaXuEEoBN4201qNzIZuwUfoMkpdY7peVMmsaCxywqq7ryYYaapfO1b1x0ldddQx3tn7dVGJP2dgwmjtVTyDOyUfdKrYhuSv8CTgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-bc-682319efd1c9
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
Subject: [PATCH v15 16/43] dept: apply sdt_might_sleep_{start,end}() to hashed-waitqueue wait
Date: Tue, 13 May 2025 19:07:03 +0900
Message-Id: <20250513100730.12664-17-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbWxLYRTHPc+9vfe2W7mp4dokrCISYsxbTgTxzfVBQiyREKGxS8tWS0ut
	QqzMwmYzYkb3otusm62zapdg1plJy2ammL3Ziw2jsa1JaZltaL18Ofnlf05+53w4DCF7LIpk
	VOrDgkatSJBTElIyEl68xDt7vnJZmmcF+L+eJSG/2kKB+1YlAkuNAYPHuRE6AsMIxp89JyA3
	x42gaKCXgBpXHwJH+SkKXr2fCm1+LwVNORkUnC6ppuDF5wkMPVcuYai0bYZ+8xAJT7OLMeR6
	KMjLPY2D5ROGMXMFDeaUBTBYbqRhYiAWmvraReDoXgzXCnsoqHM0keC6O4jhVW0+BX2WXyJ4
	6npCQiArCtwXM0VQNVpMweeAmQCz30vDywYTBpdpJlhTg8K0Lz9F8DizAUPajdsY2rruI6g/
	+xaDzdJOwSP/MAa7LYeAH2VOBINZIzScOT9GQ54hC0HGmSskpPasgvHvwc0FX2PBcN1KQtVk
	O9qwjrcUWhD/aNhL8Kn2o/wP/2uKdwRMJN9czPH3jL00n1rfTfMm2xHeXr6IL6nzYL7I5xfx
	topzFG/zXaL59JE2zI+2ttJb5uyQrI0XElQ6QbN0/R6JsqblHErqZ5JL3NVECuqn0pGY4diV
	XH1zM/2fzfkdOMQUu5Dr7BwjQhzBzuPsmUOidCRhCLY9jOso6EKhxnR2F/cx51twiGFIdgFn
	rFsTiqXsaq529DL665zLVVob/njEwXyyrJUMsYxdxWWbKsmQk2PzxNwnb+m/I2ZzD8s7yWwk
	NaEpFUimUusSFaqElTFKvVqVHLP3UKINBd/LfGJi513kc29rRCyD5OHSJ55opUyk0Gn1iY2I
	Ywh5hNRwJxhJ4xX6Y4Lm0G7NkQRB24iiGFI+S7o8cDRexu5XHBYOCkKSoPnfxYw4MgUV+JbH
	dOOZb23fdq8wLcObwkY/tGie6QXdjO3c1QvjTm1/n6+77rnOaU802Pf3nlpYFmWMc4cZ4yI2
	zXtXWhW9xeHYU3U72Vo6YFFPmV94IGMopWjxzshbJ2upaeFOe7TsuLWLQeM7urY+SDp4TO/p
	cbW8nvXxzU28Txx3efqkS05qlYrYRYRGq/gNiTI3HFoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSaUxTaRSG/e5OnZorEuZaBpcaYoJRbLTkRI3RH4YvY9x+mWhUGr3SKqBt
	gQEnZsACCk4ZIFaUzQqmIBTBC4mo1BAQlMGpnQFBHRYlE5SwNKm0yubYavxz8uR5T97z53Bk
	8G1awekSk0RDoiZeycgo2d6tpvXu5Wu0G689Cwfv9CUKSuvtDLju1CKwN2UQMNYRA/2+CQRz
	fz0nocjiQnDz7SAJTZ1DCBzVFxjo+W8J9HrdDHRZLjNgqqxn4O/xeQIGrhYSUCvtgWHbKAXd
	+RUEFI0xUFJkIvzjPQEzthoWbOkRMFJdzML8WxV0DfXR0F7WRYPj9Tq4Xj7AQIuji4LO5hEC
	eh6UMjBk/5+G7s6nFPjywsBVYKahbqqCgXGfjQSb183CP61WAjqtodCQ6W/N/vCZhifmVgKy
	b90loPfVQwSPLr0hQLL3MdDunSCgUbKQMFvVgWAkb5KFrN9nWCjJyENwOesqBZkDapj75L9c
	Nq2CjBsNFNQt9KEd27G93I5w+4SbxJmNv+BZ7wsGO3xWCv9ZIeD7xYMsznz0msVWKRk3Vkfi
	ypYxAt/0eGks1eQwWPIUsjh3spfAU04nuz/8kGzbCTFelyIaorbHyrRNz3LQ2WEutdJVT6aj
	YSYXBXECv1mwlfYTAWb4tcLLlzNkgEP4VUKjeZTORTKO5PsWC/1lr1AgWMYfEd5ZPvqXOI7i
	I4Tili0BLeejhQdTV9C3zpVCbUPr154gv1+oclIBDubVQr61lspHMitaVINCdIkpCRpdvHqD
	8bQ2LVGXuuH4mQQJ+R/Idn6+oBlN98S0IZ5Dyh/kT8dWa4NpTYoxLaENCRypDJFn3PMr+QlN
	2jnRcOaYITleNLahMI5S/ij/+aAYG8zHaZLE06J4VjR8TwkuSJGOemP36mN/XVOfE6XYvdNd
	MJv0+Ld9o58GTbtMSdez1Qqp3FO1Y1P/+cowZ2iJc8483nQy7l/T0j+OvtEYXO/xqfCIuslU
	H5+1UGg5YNHXqc3RoioibtnhA4rd637Sb5WSFSuizfootapDf3Em9JS+NCbV45mOjvFNpH92
	bLrWvVxJGbUaVSRpMGq+AKEJfCU8AwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Make dept able to track dependencies by hashed-waitqueue waits.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait_bit.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 9e29d79fc790..179a616ad245 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -6,6 +6,7 @@
  * Linux wait-bit related types and methods:
  */
 #include <linux/wait.h>
+#include <linux/dept_sdt.h>
 
 struct wait_bit_key {
 	unsigned long		*flags;
@@ -257,6 +258,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
 	struct wait_bit_queue_entry __wbq_entry;			\
 	long __ret = ret; /* explicit shadow */				\
 									\
+	sdt_might_sleep_start(NULL);					\
 	init_wait_var_entry(&__wbq_entry, var,				\
 			    exclusive ? WQ_FLAG_EXCLUSIVE : 0);		\
 	for (;;) {							\
@@ -274,6 +276,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
 		cmd;							\
 	}								\
 	finish_wait(__wq_head, &__wbq_entry.wq_entry);			\
+	sdt_might_sleep_end();						\
 __out:	__ret;								\
 })
 
-- 
2.17.1



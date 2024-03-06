Return-Path: <linux-fsdevel+bounces-13703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF328731A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9A61C21757
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 08:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0FE60BBC;
	Wed,  6 Mar 2024 08:55:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75385FB8E;
	Wed,  6 Mar 2024 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715340; cv=none; b=LsjcznYzl2RxDV0fl/6ObXdtfDWVzgSBMdBgR9ZodgY1hNAnrvKlnuFyzKdDLVoTz+rniJqebftvcnj/r6bxJEnxyCxe7Jd2EUt4O359WShCZvaM1kA9mLNGOX2xClNeS3itctNlN0g8HvfQVr9TUvVHcP1KK1D4CI+CekRLXbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715340; c=relaxed/simple;
	bh=RIc5udGVOneBYojEExyl4QYDrUVZJa4Vo+L4Ic7nXzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GsQGC8r1ozAQSu1uWrUMIThLAabOoE7+cjqMSvuU5aVfOX82Xr0ot1qG0i4jYAi7SK311rvjjcb/OgbgOltWwg0HL325m9N6RCrqzt5S4/SoaCDMjxoyCEMflL8xfAdXAFt0CozJVRwYCeSxrNK6+bUKkTHgiWKWSEsf2ejmpWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-b8-65e82f7dce79
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
Subject: [PATCH v13 09/27] dept: Apply sdt_might_sleep_{start,end}() to waitqueue wait
Date: Wed,  6 Mar 2024 17:54:55 +0900
Message-Id: <20240306085513.41482-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306085513.41482-1-byungchul@sk.com>
References: <20240306085513.41482-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSV0xTcRSH/d/ZVmtuqtErPmCqBuMCFMgxMcYnvEZNHIkaieMKV2ksqEVm
	MKIMwUoFEqijQimkrCpahgsQMVSRMFREMAUFUUHKCNhqgagt0ZeTL7/zO9/TEeGyKtJDpAg/
	J6jCeaWckhCSkXn56857Dwo+RY83QuZVH7D/SCVAV26ioP1uGQJT5UUMhhq3wXuHDcF0SxsO
	2ux2BPl9PThUWnoR1BZfouDtwHzosI9R0JStpiCxoJyC18MzGFhzsjAoM++C5gwDBvXObwRo
	hyi4pU3EXGMQA6exlAZjwkroL75Jw0yfLzT1dpJQ+2EN3Mi1UlBT20SA5WE/Bm8f6yjoNf0h
	odnykoD2zHQS7owaKBh2GHEw2sdoeFOvx+BekkuUMvmbhBfp9RikFN7HoKP7CYK61E8YmE2d
	FDy32zCoMGfjMFXUiKBfM0JD8lUnDbcuahCok3MISLL6w/QvHbV1E/fcNoZzSRXRXK1DT3Cv
	DCz36GYPzSXVfaA5vTmSqyhezRXUDGFc/oSd5MylaRRnnsiiuSsjHRg32tpKcy+vTxPcQIcW
	2+1xSLI5RFAqogSV95ZjktBXP4fIMyXimPGMy1QCKqKvILGIZfzYvMER/D9/tRQQbqYYL7ar
	yzmbL2SWsRXpX0k344xNwha2Brp5AbOf1ZaOIjcTzEr2uz53tiNlAtjOB/3//J5s2b36WY/Y
	lV8bvUa5Wcb4sy2J+S6WuDqJYjY3w/DvYAn7rLiLyEBSPZpTimSK8KgwXqH0Wx8aG66IWR98
	OsyMXM9kPD8T9BBNtO9rQIwIyedJt4q/CTKSj4qIDWtArAiXL5TGTw0IMmkIHxsnqE4fVUUq
	hYgGtFREyBdLNziiQ2TMSf6ccEoQzgiq/1tMJPZIQB65db7xjZo4EgKOZ55o6QnWpZQUDi9a
	hc+1kF/G+ZkjznU6JmuzWnEh+vamuc6P3aazBwOjNfanvisEfkfNTo3m0uRye17al3deAZ7O
	tPFsz+pypSGmuS/Iuqe6zRsPUX8sU29flvx5zwGrT9X+XUrF2srD3TlBnxW3bY7qvVFyIiKU
	912NqyL4vwEA7wJIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSa0hTYRgH8N73nPOebbQ4LatD0oXVsgvds54udCHKl+4QGAVRow651Blb
	mUaBpdnFLI10Vlbz0jRdZWdFN2dLyZySWYpWqKRYaU0Nc5YXKhf15eHH83/4f3oUjMbCjVEY
	jAckk1EfpiUqVrVxSeyMo7NapdkVHn9IPjsbvN2nWEi/YydQdTsfgf3eMQxtz4OgrseDoP/l
	KwYsKVUIMpoaGLhX2ojAmXucQHXLMKjxdhJwpyQQiM26Q+D11wEM9akXMOTLG6AiKRODq/cz
	C5Y2AlcssXhwtGLoteXxYIvRQXPuZR4GmuaAu7GWg5Krbg6c76fDpWv1BAqdbhZKHzZjqH6c
	TqDR/puDitIyFqqSEzm41ZFJ4GuPjQGbt5OHNy4rhoK4wbb47784eJHowhCffRdDzbsnCIpO
	fcAg22sJlHg9GBxyCgN9Oc8RNJ9r5+HE2V4erhw7hyDhRCoLcfWB0P8znaxYTEs8nQyNcxyi
	zh4rS8szRfrocgNP44re89QqH6SO3Gk0q7AN04wuL0flvNOEyl0XeHqmvQbTjspKnpal9bO0
	pcaCN/tvVy3dI4UZIiXTrGW7VCHlP9q4/TeVUd+STpIYlMOfQUqFKMwXP5VmsT4TIUB8+7aX
	8dlPmCA6Ej9xPjOCRyVmV67xeYQQLFryOpDPrKATv1iv/b1RCwvE2gfN/zrHi/kFrr89ysH9
	+Y7zxGeNECi+jM0gSUhlRUPykJ/BGBmuN4QFzjSHhkQbDVEzd0eEy2jwXWxHB5Ifou7qoGIk
	KJB2qHqF8rOk4fSR5ujwYiQqGK2f+khfi6RR79FHH5ZMETtNB8MkczHyV7Da0eq1W6VdGmGv
	/oAUKkn7JdP/FCuUY2KQtsCvemzo6U2vNRPzV92dMXnexaIbuVM/1re+CYqSg+X7U3Z8aLhZ
	Vtf1fZihb5Xu+kjPo6ejIhw/n4GxOKVowrrhwWMnHSkM1cYvWJ4wvmeLxr0teG6arntNeVPO
	RG3d6vW04pD8YMeoKvuPhQGLhl7V7TM7g9ovzuWXYFfqyluH28dpWXOIfs40xmTW/wGOP7T+
	KgMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Makes Dept able to track dependencies by waitqueue waits.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 3473b663176f..ebeb4678859f 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -7,6 +7,7 @@
 #include <linux/list.h>
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
+#include <linux/dept_sdt.h>
 
 #include <asm/current.h>
 #include <uapi/linux/wait.h>
@@ -303,6 +304,7 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 	struct wait_queue_entry __wq_entry;					\
 	long __ret = ret;	/* explicit shadow */				\
 										\
+	sdt_might_sleep_start(NULL);						\
 	init_wait_entry(&__wq_entry, exclusive ? WQ_FLAG_EXCLUSIVE : 0);	\
 	for (;;) {								\
 		long __int = prepare_to_wait_event(&wq_head, &__wq_entry, state);\
@@ -318,6 +320,7 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 		cmd;								\
 	}									\
 	finish_wait(&wq_head, &__wq_entry);					\
+	sdt_might_sleep_end();							\
 __out:	__ret;									\
 })
 
-- 
2.17.1



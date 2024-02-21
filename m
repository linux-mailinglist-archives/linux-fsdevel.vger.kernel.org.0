Return-Path: <linux-fsdevel+bounces-12233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C18D785D486
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 10:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620401F2741C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 09:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9636E45C08;
	Wed, 21 Feb 2024 09:50:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127593EA71;
	Wed, 21 Feb 2024 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509000; cv=none; b=cobb+hG3vFK6DJMtk2zlGTXsApIClJIQ5//b6ELA4oIDyc0TM2i7EZHnrL544ztGEOJcF0L68T87PfYpG/8q3UCMP81N722IDim5xnYdrkzeR5cOGpoSDsokQBIoXfda5gy1koRoVVMQ7YLJ08b4i9cMHAeoFGa4a6BOx6bc8bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509000; c=relaxed/simple;
	bh=RIc5udGVOneBYojEExyl4QYDrUVZJa4Vo+L4Ic7nXzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XgAwwcOYWFSCFrRb5aJIf4aBfIWpiOeQPtgDITyoQhmb2qhJ6ygBOfosL2pDMtoIgtG5jZXDjOUK6+SiWVazrcv2X4ZLXXRxM1pINOOV7EBtLHLXG05immMv0CFd2eUTqW6ttFlKurq3d4kO/VfiWo8KgX8eM6wrIXq3ocGqIv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-19-65d5c7392c4f
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
Subject: [PATCH v12 09/27] dept: Apply sdt_might_sleep_{start,end}() to waitqueue wait
Date: Wed, 21 Feb 2024 18:49:15 +0900
Message-Id: <20240221094933.36348-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240221094933.36348-1-byungchul@sk.com>
References: <20240221094933.36348-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSV0xTYRiG/f8zW62eVI3HEUfjxIUzn0bBO48aEw3qhcRII0fbWCppsYjR
	BGWKlgAKqBAthZQyXAUiojWACiKCVQuiAaKIg1BGkFaROlqMN1+evG/e5+pjCfk9agar1kaJ
	Oq1So6ClpLRvgnn5hvoWMTD220JIvxAI7uFkEnJvldLguFmCoLT8DIaeJ1vhjceFYLTpBQHZ
	mQ4EeR86CCiv60Rgt56l4XX3RHC6B2hoyDxPQ1z+LRpe9noxtGdlYCix7YTGNDOG6pEvJGT3
	0JCTHYd95yuGEUsxA5bYBdBlvcqA98MqaOhspcD+bilcudZOwwN7Awl1lV0YXlfl0tBZ+oeC
	xrqnJDjSjRTc6DfT0OuxEGBxDzDwqtqE4Xa8T5T47TcF9cZqDIkFdzA4395H8DD5PQZbaSsN
	j9wuDGW2TAJ+Fj5B0JXax0DChREGcs6kIjifkEXCi1/1FMS3r4PRH7n0lo3CI9cAIcSXRQt2
	j4kUnpl54d7VDkaIf/iOEUy240KZNUDIf9CDhbwhNyXYis/Rgm0ogxFS+pxY6G9uZoSnl0dJ
	oduZjXfN3C/dFC5q1AZRtzIoTKp69r2HiiySnBhMS6JjUSGTgliW59byn6pOpSDJGCYO1BB+
	prlFfFvbyBhP4ebyZcbPVAqSsgSXNJ63DjbR/mIyt4/3lP/Afg/JLeAd9rFYxq3nLz5/z/xz
	zuFLblePeSS+vCjHRflZzq3jW15WEH4nz8VJ+Px+D/VvMJ2vsbaRaUhmQuOKkVytNUQo1Zq1
	K1QxWvWJFYeORdiQ76Esp72hlWjIEVKLOBYpJshUd52inFIa9DERtYhnCcUUGRnti2ThypiT
	ou7YQd1xjaivRTNZUjFNttoTHS7njiijxKOiGCnq/reYlcyIRSZNSNj2Ym3IkSx2GvppKNBv
	uHRnanhFpCPrQP6sHWZ5kyrZsSs5eFbBksfza0KHA9G8L/cHd39fHKSa2Lm1du/04NGDAUUV
	WxTLFOP6Thtbzrpch66EXjcqKlqGvZMMbUmm2R+9a9QJsxubDy88sGZbYXdO+9Q9qzcHVfUG
	dhQmdL1SkHqVclUAodMr/wKrqYZqTAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRiH+//PdavFYQkeureKMNMMMt4woovkMejyqaIgHXVoy3lpMy9F
	YXltpqilq1xhGmvpum2GdpmY4mWapbkszUQlqtFMqaaZdplSX14enh88n16WkBupuaw6Jl7U
	xig1ClpKSneGpAasb3olBumNHOSfDwLP9ywSjHctNLTfqUBgqTyDwdUQBq9H3Qgm2l4QYChs
	R3B94B0BlY19COzmszR0vp8NTs8wDY7CbBpSy+7S0PF5EkNvUQGGCusOaM0rxVA7/pEEg4uG
	YkMq9p5PGMZN5QyYUpbDoPkKA5MDa8DR10VB/VUHBfYef7h8rZeGJ3YHCY3Vgxg6Hxlp6LP8
	oaC1sZmE9vwcCm5/KaXh86iJAJNnmIGXtSUY7qV5axnfflPQlFOLIePGfQzO7scIarL6MVgt
	XTTUe9wYbNZCAn7ebEAwmDvEQPr5cQaKz+QiyE4vIuHFryYK0nqDYeKHkd4UItS7hwkhzZYo
	2EdLSKGllBceXnnHCGk1PYxQYj0u2MwrhbInLixc/+qhBGv5OVqwfi1gBP2QEwtfnj9nhOZL
	E6Tw3mnAu+fvl244LGrUCaJ29cZIqaplzEXF3ZIkjeRl0inoJqNHEpbn1vIZw0+JKaa5Ffyb
	N+PT7MMt5m05Hyg9krIElzmTN4+00VPDHG4PP1r5A+sRy5Lccr7dPq1l3Dr+wrP+f81FfMW9
	2umOxOtvFbupKZZzwfyrjgdEHpKWoBnlyEcdkxCtVGuCA3VRquQYdVLgodhoK/L+jOnUZH41
	+t4ZVoc4FilmyVRVTlFOKRN0ydF1iGcJhY+MTPQq2WFl8glRGxuhPa4RdXVoHksqfGXb94qR
	cu6IMl6MEsU4Uft/xaxkbgoKsK/aVvfywr7Q7qOLRoZCTh70dRV05nYvXmqmLtrFnKi4rCUz
	ydJYviNk65ETk2Nt2NfVOmb7udDTk77gkmjQZGs2+PVJ/PWKMP+GZqsqPPRylTt8jzz+wLG9
	p8/mdX1Q6dOXRe4o2+V4uyUg2xKxqTA0qsJ5au0qv2Obe7rWZTYpSJ1KuWYlodUp/wIpHJes
	LwMAAA==
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



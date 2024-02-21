Return-Path: <linux-fsdevel+bounces-12242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E7F85D4BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 10:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E7128C306
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 09:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F58F524A0;
	Wed, 21 Feb 2024 09:50:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AE94C626;
	Wed, 21 Feb 2024 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509006; cv=none; b=py7sVyOj93Aa7g2IFgZK6L/KLSEMe1B8AjTptMNwGOFley5DlyOYKkUynK6E5lgQpPO4UXYg1Qx3KzoykcDofEWuemML2HiORelUd99DWaGQSvOKk2DmV4eHtKtyd0UQPjyMYSoVRtYPIGbCbonkd8HMsU2FsR7UYSEZXIA2myk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509006; c=relaxed/simple;
	bh=9o9SI0ONdb1WbiIWXrCSb5nX53qir4UGX5Gt0IQgpYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DCcN2Vv8/Xz83QHUgamQHnXah+K9Ma6pdcksIGV/vTEVadNj0ZLlTzey8iugKDyyYCbPSL2VYZHLDEquLyhXYHzBxZ2kDiWTgsNAE+0+Qdxe+HGvgxfseBy4LbmzcRAlx6uyVCfTHiFK4mBLlLK9ajUDpIKnsqzBk4bZ+ZjWeI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-a8-65d5c73ab21f
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
Subject: [PATCH v12 18/27] dept: Apply timeout consideration to swait
Date: Wed, 21 Feb 2024 18:49:24 +0900
Message-Id: <20240221094933.36348-19-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240221094933.36348-1-byungchul@sk.com>
References: <20240221094933.36348-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSW0xTWRSG3fucs8+hWnOsTtxqjKbe4oXbjJglMeqLcUdj1Jh5wWS0ygl0
	hlvK3WgsgjcQIiSlCqjc7FRgBAsyOlzSgXDTqDAUBgwwSIgOsQUFS0QQLRhfVv7861/f/7Ik
	TvNYWCnpI2IUQ4QuTEtUvMq1qNA7sKVL8at68BNkXvMD94crPOSVlxFov1+KoKwqCcNI0374
	d9KJYPrZCw7MpnYEBa/6OahqHkBQZ71AoHN4MTjcYwTaTGkEkovKCXS8ncHQl52FodR2CJ5e
	L8Rgn3rDg3mEQK45GXvG/ximLCUiWIwbYMiaI8LMK39oG+gWoO7lVrh5u49AbV0bD82PhjB0
	/pVHYKDsiwBPm1t5aM9MF+CP0UICbyctHFjcYyL8Y8/HUJHiAV2amBWgJd2O4VLxAwyO3hoE
	9VcGMdjKugk0up0YKm0mDj793oRgKMMlwsVrUyLkJmUgSLuYzcOLzy0CpPQFwPTHPLI3kDU6
	xziWUhnP6ibzefakkLLHOf0iS6l/KbJ8WyyrtG5hRbUjmBWMuwVmK7lKmG08S2SpLgdmo8+f
	i6z1xjTPhh1mfGRVkGpXsBKmj1MMvrtPqkLLh5NQ1ARJMDcVC0b0REhFXhKVt9NOZwX3XQ8O
	GtGcJvIm2tMzNe8vk9fSyvTXnrxK4uTLC6n13TOSiiRpqbyPzphWz0le3kAz02Pn4mp5B3V1
	VPPfkGtoaYV9HuPl8e/lOudrNXIA7ep4yM0hqZzsRXvtNeTbwQr6t7WHv47U+WhBCdLoI+LC
	dfqw7T6hiRH6BJ/TkeE25Hkoy7mZ44/QePuxBiRLSLtIHfqnQ9EIurjoxPAGRCVOu0zNx3ss
	dbAu8YxiiDxhiA1TohvQKonXLlf/OBkfrJFDdDHKb4oSpRi+b7HktdKIIKCx+P2tg+fv7dj2
	g6urev3hWZzr2jlxl1yt7t9YMLo70H9t7Js8Rwx1n+8N0f6aYxnM2LN4qa/cHHAyEpPWA0rQ
	l4xftg7oJxxZxUfP3PGVgl3Lxxbu/Zmamv47VR1ybMVpY3Yrsy65L58tjdLtSThbu1lQMr3X
	Bc2mNWy79fqmlo8O1flv4QzRuq8dqHy0TAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfX/PXc5+Tls/ysPOjJGnTXxGHuapL8P4izF047c6dWV3rgcP
	WykkwmU5unAqJxWdK4Rqt86VPFW6ItLSmvQkK9fUXXEx/3z22vvz3uvzz4cjZQZ6CqeMPCKq
	IxURckZCSbatSJy/vKpBXNTY5Q+684vA+TOZgszCAgZq7+cjKChOIKDTHgzvB3sQuN7UkKBP
	r0Vw68tnEoorWxCU5Z5koL59AjicfQxUp59jIDG7kIG6bjcBzVfSCMi3bIVXl7IIsA51UKDv
	ZMCgTyQ84xsBQ6Y8Fkzxs6AtN4MF95fFUN3SSIPtejUNZR/nwbUbzQyUllVTUFnSRkD900wG
	Wgp+0/Cq8gUFtbpUGu59z2Kge9BEgsnZx8I7q5EAc5LHdnpglIaqVCsBp3MeEOBoeoagPLmV
	AEtBIwM2Zw8BRZZ0Eobv2BG0Xehl4dT5IRYMCRcQnDt1hYKakSoakpoDwfUrk1mzAtt6+kic
	VBSDywaNFH6ZJeAnGZ9ZnFT+kcVGixYX5c7F2aWdBL7V76SxJe8sgy39aSxO6XUQ+Pvbtyx+
	cdVF4XaHntjuv1sSdFCMUEaL6oWrQiRhhe0J6PAAE6u359Dx6CWdgrw4gV8itLbGozFm+NnC
	hw9D5Bj78DOEotSvno6EI/kz3kLujzdMCuK4SfwGwZ0+dQwpfpagS9WO1aX8UqG37hH1Tzld
	yDdb/2q8PPldQ8/fUzI+UGioe0heQhIjGpeHfJSR0SqFMiJwgSY8LC5SGbvgQJTKgjwvYzrh
	1pWgn/XBFYjnkHy8NOyxQ5TRimhNnKoCCRwp95FSMZ5IelARd1RUR+1XayNETQXy4yi5r3Tz
	TjFExocqjojhonhYVP/fEpzXlHiUuMxuG3zNn1WZr0/0PjSnyxj3PCMmfBc/fGxvoSEkSFd8
	Jz9oh7ZqpgOjhgDzqPVu077W4zW3NyVvK/XdQ9Mjq7/G5gX6l1+MjXLpbCrZWtc1bnil92Xr
	tPUnmi7aa9fd/J0yogkIWn/ULzh8wmUxZGNOWpT2k3my6OfuCB3dskVOacIUi+eSao3iD6uF
	AVEuAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to swait, assuming an input 'ret' in ___swait_event()
macro is used as a timeout value.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/swait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index 277ac74f61c3..233acdf55e9b 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -162,7 +162,7 @@ extern void finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
 	struct swait_queue __wait;					\
 	long __ret = ret;						\
 									\
-	sdt_might_sleep_start(NULL);					\
+	sdt_might_sleep_start_timeout(NULL, __ret);			\
 	INIT_LIST_HEAD(&__wait.task_list);				\
 	for (;;) {							\
 		long __int = prepare_to_swait_event(&wq, &__wait, state);\
-- 
2.17.1



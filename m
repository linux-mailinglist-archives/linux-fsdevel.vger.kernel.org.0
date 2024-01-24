Return-Path: <linux-fsdevel+bounces-8738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D5C83A90C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FEC5B26F3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE0967A08;
	Wed, 24 Jan 2024 12:00:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E0C657AB;
	Wed, 24 Jan 2024 12:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097613; cv=none; b=W0DnrCsQyMn61OhLCqOtq0NDo0Mb0Myqn0s7aSoB/uepxH56h376JHW8DN0hkFTjZjCmwazjC1AsVNLBSxM6a5oT0Bhu22LxCcbI5b4zQ8HCVtZ6dkziM4Apzgv3frOBLc8ijtloRy19gSOEtn7/CnPccUtRVm0rNt+UnxnuEX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097613; c=relaxed/simple;
	bh=9o9SI0ONdb1WbiIWXrCSb5nX53qir4UGX5Gt0IQgpYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qIYuRuD3nV/7LKQIvkqSpBguURmCSiuZtSxO0w3zXXaZGag8nJD4/vIB/300MqMuSlmwBN62tm0GxIVKo4HIDzQvkiJG6Od0TXnaBSLXIvuTwo+TDZTTlz2yFVXPuWQdeJG+KVBF8+vgC37jcl/C9XKjwLYdzKVwRIgC8xH214o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-65-65b0fbb6c9f0
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
Subject: [PATCH v11 18/26] dept: Apply timeout consideration to swait
Date: Wed, 24 Jan 2024 20:59:29 +0900
Message-Id: <20240124115938.80132-19-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124115938.80132-1-byungchul@sk.com>
References: <20240124115938.80132-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+//Pbc4WpyV1Vh+qYRRWmqLxEhESVCciCiKJImq0gy6nxUzN
	otK85qWs0OWFcCZrTG22WZppLEXTorSSWjZFzS7ipuWauGbWNPry8uN5n+f59IgI6WNquUgV
	f0bQxCvUclpMip0LdRsbvHXCptyS1XA9fxO4f+aQUG6qoaHnXjWCmvo0DKPtu+D9lAOB92U3
	AdqiHgS6oX4C6jsGELQYLtPwdmQR9LonaOgqyqMh/Y6JhtdjMxjsxTcwVJv3wovCSgxWz1cS
	tKM0lGnTse98w+DRGxnQp66BYUMpAzNDodA18I6Clr71UHLbTkNzSxcJHY3DGN42ldMwUPOH
	ghcdnST0XC+goHa8koaxKT0BevcEA2+sFRjqMnxFWa5ZCp4VWDFkVd3H0PvhMYInOYMYzDXv
	aGhzOzBYzEUE/LrbjmD4qpOBzHwPA2VpVxHkZRaT0P37GQUZ9gjwTpfTkVv4NscEwWdYkvmW
	qQqSf17J8Y9K+xk+40kfw1eYE3mLIYi/0zyKed2km+LNxis0b568wfC5zl7Mj796xfCdt7wk
	P9KrxftXHBZvVQpqVZKgCdl2XBxjGklDp130WW17FZWKnlO5yE/EseHcbEED/Z+z2/LRHNPs
	Ws5m8xBzHMCu4iwFX3x+sYhgs/05w/eX84El7A5u3FU7byLZNVx3kwvPsYTdzGWmWsh/pSu5
	6jrrvMfPp9eW9M3rUjaCGzReY+ZKOTbPjyv7XM78C8i4pwYbWYgkFWiBEUlV8UlxCpU6PDgm
	JV51NvjEqTgz8k1Kf2HmSCOa7DnQilgRki+URBpNgpRSJCWkxLUiTkTIAyQ22T1BKlEqUs4J
	mlPHNIlqIaEVrRCR8mWSsKlkpZSNVpwRYgXhtKD5/8Uiv+WpKC5A1l//7Yc30pq3SuYfWNo9
	Ott5SBy+M9Tuv/27f/DXxddC9jSgxNiHGwOjQprH7K1CoX1DUNj5LJty7Vj07o+HfwZ5bg4d
	PfBp5tc6dVdxrLyakVWRmcqTSx8cPPRbF+HcbbqY4nCtNgbu62x0G+/rDE9XTjuRK2qw482l
	9Q6bnEyIUYQGEZoExV8xoGXATgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUhTaxzHe55zznOOq8VxLTrXLtx7F9IbZUXGj+wdyocLNwuCoKIaeciR
	mmw2Neg2r1t2S0sD2630XrNYOjVtq7ByMRxqy3KmYiYmKfYimkZr3tbsZRr98+PD9/vh+9dP
	YFQlXJSgS02X9anaZA1RsIqtcTlLbodq5WV1uQCFecsg8OEkC8U1VQTarlciqLqZjWGoMR6e
	jo8gCD32MWAtakNwuf85Azeb+hC4yv8i0DE4EzoDYwS8RacJ5FypIfBkeAJD7/lzGCodf0BL
	QRkGd/A1C9YhApesOTh83mAI2uw82EzRMFB+kYeJ/uXg7eviwFPi5cDVsxgu/NtLoN7lZaGp
	bgBDx91iAn1VXzloaXrAQlthPgfVo2UEhsdtDNgCYzy0u0sx1JrDayf8XzhozndjOHH1BobO
	Z/cQ3D/5AoOjqouAJzCCwekoYuDTtUYEA2fe8mDJC/JwKfsMgtOW8yz4PjdzYO6NhdDHYrIh
	jnpGxhhqdmZQ13gpSx+WSfTOxec8Nd/v4Wmp4wh1li+iV+qHML38PsBRh/1vQh3vz/H01NtO
	TEdbW3n64J8QSwc7rXjbz7sUaxLlZJ1R1ses269IqhnMRml+kmltvMqZ0EPuFIoQJHGllOvJ
	Q5NMxPlSd3eQmWS1+KvkzH8VdhQCI+ZOl8rfPSaTxSxxszTqr56SWDFa8t3140lWiqski8nJ
	fh/9RaqsdU85EeG8+kLPVK4SY6UX9rN8AVKUoml2pNalGlO0uuTYpYZDSVmpusylBw6nOFD4
	aWzHJgrr0IeO+AYkCkgzQ7nBXiOrOK3RkJXSgCSB0aiV3T9dl1XKRG3WUVl/eJ/+SLJsaEBz
	BVYzR/n7Tnm/SjyoTZcPyXKarP/RYiEiyoRMCZ7cYELzJv2bzxs/9bfkx3u2VphGF+y9Fbvl
	ltHSwGaY9qx+VbBwOz22OrJi1dr/MxdbyPqX3tm1w1q8wufZ7HbVTTs+M+bPsd1R5nZfXJ/y
	SYxuXoTxbFFJSZag1oQy/Pt+2y1VpO3Qixt9Tmw2z2vdon4UeY/a0itb/1MlaFhDknb5IkZv
	0H4DOWK59jADAAA=
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



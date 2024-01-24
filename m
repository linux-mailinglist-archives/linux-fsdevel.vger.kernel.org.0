Return-Path: <linux-fsdevel+bounces-8722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D9C83A8B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B98B1C25CF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDB060DD6;
	Wed, 24 Jan 2024 12:00:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4693D60DEF;
	Wed, 24 Jan 2024 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097602; cv=none; b=DV7ygf//B/cgq2z2SSEnKUeHLIY5pe2tYpNwD/tJtHkWCksE2QQ6u7OX5kb90xXNUCXh2Csvor2xYuH3FPUYi8TiZ06ZRp/0EYf8klQ8J6LD9+T6aAzn3KFJz02JZW0JO9tp7P+9CRxcDTiLkCPxpt7UJb4TywW1OjzR/Y9VuHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097602; c=relaxed/simple;
	bh=yYyo9J9LbrfncpB2CWVjqJhM6aD/eyXV6B0l1bR9NkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=c4Clt3zVw57xbYR/P7R5NXy6kGYspTnKPfkQ7QybycOQ+fQXOCAr55UZUplQu0O8pmzYFdp15x7FCVfaK8EGqbsuD1HWb9cUctaOBnBoPQg8CaVuRG/9aUwGYB6JQF/Pg2c5mWrLTIh+Ym7TGt98A3/2uT+NJHs5hWSjXsIy6Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-71-65b0fbb43154
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
Subject: [PATCH v11 03/26] dept: Add single event dependency tracker APIs
Date: Wed, 24 Jan 2024 20:59:14 +0900
Message-Id: <20240124115938.80132-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124115938.80132-1-byungchul@sk.com>
References: <20240124115938.80132-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTYRTHe573ti1XL0vyLYtkEEGZmVgdIiqC6KkIKqEPSZeVLzqaU6Zp
	iwRLs7yVBroysamxxrzPgpoaXtjSQrNcaqKSYpk4L2hbmXaZRl8OP875nf/5ciSUwsaslai1
	8aJOq9IoWRktm/Ap3vpsvloMdg1JITcrGNzfbtNQWFXOQmdlGYLyp9cxjNkPQY/HhWC+/S0F
	hrxOBMVDAxQ8dQwiaDDfYKFrZAU43VMstOVlspBSWsXCu/EFDP359zCUWY/Bm5wSDI1zozQY
	xlh4aEjB3vIVw5zJwoEpeSMMmws4WBjaDm2D3Qw09G2BB0X9LNQ3tNHgeD6MoctWyMJg+R8G
	3jhaaejMzWagYrKEhXGPiQKTe4qD941GDNWp3qC02d8MvMpuxJD2uAaD82Mdgpe3P2Gwlnez
	0OJ2Yai15lHw84kdwfCdCQ5uZs1x8PD6HQSZN/NpePvrFQOp/Ttg/kchu383aXFNUSS1NpE0
	eIw0eV0ikBcFAxxJfdnHEaP1Mqk1byal9WOYFM+4GWK1pLPEOnOPIxkTTkwmOzo40np/niYj
	TgM+7n9atidC1KgTRN22vedlUc05BUxsj98Vj2FDMnIqMpBUIvChwvCHu9x/rv89wS4yy28S
	envnqEX25QOE2uwvTAaSSSj+1nLBPN2+JK3iDwuZz+qWJJrfKIwO2ulFlvM7hNnWFvpf6Aah
	rLpxyZHyO4WKB31LfYXX+WRZPCzzOilS4c/INP63sEZoMvfSOUhuRMssSKHWJkSr1JrQoCi9
	Vn0l6GJMtBV5P8qUtBD+HM10hjUjXoKUPvL9lipRwagS4vTRzUiQUEpfee+aSlEhj1Dpr4q6
	mHO6yxoxrhn5S2ilnzzEkxih4CNV8eIlUYwVdf+nWCJdm4xiWwKxvrToiFkesmu6yWZffynv
	fVGMNCv9YHsSk3I0NzQkoGd1JOOnGfXxjyTXaBff9LmGGNmwC4/TElfyZ/uPxwcEVdiujR/K
	PqMVpAdWBH6PyO+JP1Y2dSrNFriupsvRXZd4MD0yuE/fvXK9R1az78TopvB6VV2S4+RJ+6MB
	JR0Xpdq+mdLFqf4CNNKfuk0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSWUhUYRiG+886Tk0dJqOTrQ6KkGUGGR/a4kXQX9ByZRBFTnnQybWZGp02
	NW1zSw2bXBKzGIdR045GixqmuOeWU5mNK5JZLqHOkGmZGt28PHzfw3v1Skh5Fu0gUYWcF9Qh
	yiAFI6Wkh71itpbOFAvud0fdICXBHaxTtyjIKipgoO1JPoKC0mgChmv2w0fbCIKZ5lYS9Glt
	CB72d5NQWtuDoMJ4jYGOweVgto4z0JAWz0DMoyIG2r/PEmC5l0pAvngImpJzCaicHqJAP8xA
	pj6GmI+vBEwbTCwYopxhwJjBwmz/dmjo+UBD9YMGGiq6XCE928JAeUUDBbUvBgjoeJXFQE/B
	HA1NtfUUtKUk0lA4lsvAd5uBBIN1nIV3lTkEFMfOt92Y/ENDXWIlATcePyXA/KkMwetbfQSI
	BR8YqLaOEFAippHwK68GwUDSKAvXE6ZZyIxOQhB//R4Frb/raIi1eMDMzyzG2wtXj4yTOLYk
	HFfYcijcmMvjlxndLI593cXiHPECLjFuxo/Khwn8cMJKY9F0m8HiRCqL40bNBB5raWFx/f0Z
	Cg+a9cTRdcelu/yEIJVWUG/b4ysNqErOoMM+ro6w6TdGIbM8DtlJeG4HX/5nlFlghnPhOzun
	yQW25zbxJYlf6DgklZDczaW88UfzorSSO8DHPytblCjOmR/qqaEWWMZ58JP11dS/0o18fnHl
	omPH7eQL07sW7/J5p890h01G0hy0xITsVSHaYKUqyMNNExigC1FFuJ0JDRbR/GYMV2ZTXqCp
	jv1ViJMgxTKZt6lIkNNKrUYXXIV4Camwl3WueSLIZX5K3UVBHXpKfSFI0FShtRJKsVp28Jjg
	K+f8leeFQEEIE9T/v4TEziEK1a2dsiXoLP0vM70dI+d88pyHJp97HmnyTNW+r0/TOn0Kd9r0
	5YTqhNkyHDbnKd1b6rre0rt7n9jSN3D57WCvasXTn65J7/1dzjXiduO3lFVnl1xNXxejaP18
	2N/RY+vEteiavuwt1pUbxNnOSFJ6uSz7tAzCfXyYNwC1l/q7dScVlCZAuX0zqdYo/wK06lAC
	LwMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Wrapped the base APIs for easier annotation on wait and event. Start
with supporting waiters on each single event. More general support for
multiple events is a future work. Do more when the need arises.

How to annotate (the simplest way):

1. Initaialize a map for the interesting wait.

   /*
    * Recommand to place along with the wait instance.
    */
   struct dept_map my_wait;

   /*
    * Recommand to place in the initialization code.
    */
   sdt_map_init(&my_wait);

2. Place the following at the wait code.

   sdt_wait(&my_wait);

3. Place the following at the event code.

   sdt_event(&my_wait);

That's it!

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept_sdt.h | 62 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 include/linux/dept_sdt.h

diff --git a/include/linux/dept_sdt.h b/include/linux/dept_sdt.h
new file mode 100644
index 000000000000..12a793b90c7e
--- /dev/null
+++ b/include/linux/dept_sdt.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Single-event Dependency Tracker
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
+ */
+
+#ifndef __LINUX_DEPT_SDT_H
+#define __LINUX_DEPT_SDT_H
+
+#include <linux/kernel.h>
+#include <linux/dept.h>
+
+#ifdef CONFIG_DEPT
+#define sdt_map_init(m)							\
+	do {								\
+		static struct dept_key __key;				\
+		dept_map_init(m, &__key, 0, #m);			\
+	} while (0)
+
+#define sdt_map_init_key(m, k)		dept_map_init(m, k, 0, #m)
+
+#define sdt_wait(m)							\
+	do {								\
+		dept_request_event(m);					\
+		dept_wait(m, 1UL, _THIS_IP_, __func__, 0);		\
+	} while (0)
+
+/*
+ * sdt_might_sleep() and its family will be committed in __schedule()
+ * when it actually gets to __schedule(). Both dept_request_event() and
+ * dept_wait() will be performed on the commit.
+ */
+
+/*
+ * Use the code location as the class key if an explicit map is not used.
+ */
+#define sdt_might_sleep_start(m)					\
+	do {								\
+		struct dept_map *__m = m;				\
+		static struct dept_key __key;				\
+		dept_stage_wait(__m, __m ? NULL : &__key, _THIS_IP_, __func__);\
+	} while (0)
+
+#define sdt_might_sleep_end()		dept_clean_stage()
+
+#define sdt_ecxt_enter(m)		dept_ecxt_enter(m, 1UL, _THIS_IP_, "start", "event", 0)
+#define sdt_event(m)			dept_event(m, 1UL, _THIS_IP_, __func__)
+#define sdt_ecxt_exit(m)		dept_ecxt_exit(m, 1UL, _THIS_IP_)
+#else /* !CONFIG_DEPT */
+#define sdt_map_init(m)			do { } while (0)
+#define sdt_map_init_key(m, k)		do { (void)(k); } while (0)
+#define sdt_wait(m)			do { } while (0)
+#define sdt_might_sleep_start(m)	do { } while (0)
+#define sdt_might_sleep_end()		do { } while (0)
+#define sdt_ecxt_enter(m)		do { } while (0)
+#define sdt_event(m)			do { } while (0)
+#define sdt_ecxt_exit(m)		do { } while (0)
+#endif
+#endif /* __LINUX_DEPT_SDT_H */
-- 
2.17.1



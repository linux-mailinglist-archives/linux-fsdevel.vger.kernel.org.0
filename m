Return-Path: <linux-fsdevel+bounces-13701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D1087318F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2254B284E6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 08:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ED96024E;
	Wed,  6 Mar 2024 08:55:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EAF5DF17;
	Wed,  6 Mar 2024 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715337; cv=none; b=ZSSKevU4neT9Vx9b2K/XQXXyqLrHa+IYi3/IoPxnitLG8noL0YD70J36TPtQiV1evBK0cjFfzJOH2XPdvVEhhziX45i2UfmIl50J6QSwE+NLG53eWayZIKWBNqq+J8QiZOlaTJ2NfQmS97jKbxB7HH+q8JN3D+DJvpGLPT3eoJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715337; c=relaxed/simple;
	bh=ZnDomY68etRURkOftpc7pgxDDdwCW9QdH8k+FPh35/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bbXUeq3A0wK/iE7CGh5yIYxGACHJQAYIRWDPJ1Uy1zGcr3pEQ09+1gkb0NlToeM2h3zJgun42d1YVUcM0iQLMfsgCcGfxwDi1GBs0YinfBNT0H+RthvzKBum8alpySoSu70+VGHPTjc2DOjjNlg8TAW8cdOzHl38Y1E1STqunnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-68-65e82f7c9f1f
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
Subject: [PATCH v13 04/27] dept: Add lock dependency tracker APIs
Date: Wed,  6 Mar 2024 17:54:50 +0900
Message-Id: <20240306085513.41482-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306085513.41482-1-byungchul@sk.com>
References: <20240306085513.41482-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfb+/p+s4fjusrzDc1qwsYuFjzPP4mdmYfzxtOvpNN1dxJTK2
	S5dF5SEqEusq51Qcd1EeyinSeUgPtyR1Uxqlqyzu9DS5zvzz2Wvvz/vz3uezfSSU/AHjJ1FF
	xoiaSKVawUppac+E3KCTCzrF4PjUiXAxJRhcv5JoyDYVsVB7txBBUXE8hq6XG+GD24lg+N17
	CjLTaxHo21opKK5yICgznmKhoWMi2F19LNjSk1lIyDOxUNc9gqElIw1DoXkLvLmQi8E6+I2G
	zC4WrmUmYE/pxDBoKODAoPWHdmMWByNtC8HmaGSgrHkeXL3RwsLTMhsNVaXtGBoeZ7PgKBpl
	4E1VNQ21F1MZuNOby0K320CBwdXHQb01B8M9nSfo9M8/DLxKtWI4nX8fg/3jEwTlSZ8xmIsa
	Wah0OTFYzOkUDN16iaD9XA8HiSmDHFyLP4cgOTGDBl3LYhgeyGZXLxMqnX2UoLMcFcrcObTw
	OpcIj7JaOUFX3swJOeYjgsUYKOQ97cKCvt/FCOaCM6xg7k/jhLM9diz01tRwQvWVYVrosGfi
	rX67pCvCRLUqVtQsWBkqDdd5FjvU6XvsplWLtKhQfhb5SAgfQqy6euY/l5oyvMzyc0lT0yA1
	xlP42cSS+tWrU7xTSvJrNozxZH4NKS9569Vp3p8MmJK8LOMXE8/V1L/MWaTwntXLPvwScr73
	PDvGco/nXYLew1KPZ0BC9Hnd7L+BaeS5sYm+gGQ5aFwBkqsiYyOUKnXI/PC4SNWx+fujIszI
	80yGkyO7S1F/7fYKxEuQYoJstc83Uc4oY6PjIioQkVCKKbITQx2iXBamjDsuaqL2ao6oxegK
	NF1CK3xli9xHw+T8AWWMeFAUD4ma/10s8fHTopmbH26aqXYGVSc63Fr/+MOj6y5l4R0W6apt
	M4Z826I66e2hfT8+2Fr0QbuWhu20ZMH3ZyVrr9Nxj5fX2ZuX/5m0otXREJOc8OVZa9W4gBft
	l2//DpjzaRXz5Uob2bRUJydp6+tT5t0PsDBTtX4lzgYyfs/kocDG96NG3RPT630fbQo6Oly5
	MJDSRCv/ArCRjz1IAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+93nNlpeltgtIWv0ACM1yjj0DikvQS8ilP6pUZccTq1NTc1K
	3RTzmZXO0mK+5rNWs4eVk6VozseylMpSK9HUnBtYk3xQTaN/Dh++5/Dl+4UjwCVacoVAHh7J
	K8NlCiklIkSHtqs3xvuO8n6DZh/IyfAD589UAgoNNRR03a9GUPMoEYOx5kB4P2VDMNv5Ggdt
	bheCoq/9ODxqGUBgqkiioHtoCfQ4HRRYctMpUJcYKHgzPodBX951DKqNB6H9WjEG5ukRArRj
	FBRo1ZhrjGIwra+iQZ+wFgYrbtMw93UTWAbekdB0x0KC6eMGuHW3j4J6k4WAlrpBDLqfF1Iw
	UPOHhPaWVgK6cjJJuGcvpmB8So+D3umg4a1Zh8EDjcst5cdvEl5lmjFIKX2IQU/vCwQNqV8w
	MNa8o6DJacOg1piLw0x5M4LBrAkakjOmaShIzEKQnpxHgKbPH2Z/FVJ7tnFNNgfOaWovcKYp
	HcG1FbPcs9v9NKdp+EhzOmMUV1vhzZXUj2Fc0aST5IxVVynOOHmd5tImejDObrXSXGv+LMEN
	9WixI54nRDvO8Ap5NK/03XVKFKJxBTs3uiymzJyAElC1JA0JBSyzha0z5JHzTDHr2Q8fpvF5
	dmdWsbWZ3xZ0nLGJ2FLr/nleyuxlG552LOgEs5b9ZUhdYDHjz7qa4v88vdjqB+YFFjJb2Wx7
	NjXPEtdNp7qIuoZEOrSoCrnLw6PDZHKFv48qNCQ2XB7jczoizIhc76K/NJdTh352BzYiRoCk
	i8V7hCO8hJRFq2LDGhErwKXu4viZIV4iPiOLjeOVESeVUQpe1Yg8BYR0mfhAEH9KwpyVRfKh
	PH+OV/7fYgLhigTUa/MPOD8X3N/r+Hxj3/DExeN/HMHRdWl4h2ndneCBfLcRj6VlDet8PXW6
	1pvCzCv2pMfu1jB1ycupAGtl2fLhsdnlM5Vxb27uXtXW2lF1rP1753dFxtn8/PIfufUlm8sD
	35au4Y9avMwed/VBblsj7DvTycvto58MhicrV7e9OhzUIiVUIbJN3rhSJfsLvl4JyioDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Wrapped the base APIs for easier annotation on typical lock.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept_ldt.h | 77 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 include/linux/dept_ldt.h

diff --git a/include/linux/dept_ldt.h b/include/linux/dept_ldt.h
new file mode 100644
index 000000000000..062613e89fc3
--- /dev/null
+++ b/include/linux/dept_ldt.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Lock Dependency Tracker
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
+ */
+
+#ifndef __LINUX_DEPT_LDT_H
+#define __LINUX_DEPT_LDT_H
+
+#include <linux/dept.h>
+
+#ifdef CONFIG_DEPT
+#define LDT_EVT_L			1UL
+#define LDT_EVT_R			2UL
+#define LDT_EVT_W			1UL
+#define LDT_EVT_RW			(LDT_EVT_R | LDT_EVT_W)
+#define LDT_EVT_ALL			(LDT_EVT_L | LDT_EVT_RW)
+
+#define ldt_init(m, k, su, n)		dept_map_init(m, k, su, n)
+#define ldt_lock(m, sl, t, n, i)					\
+	do {								\
+		if (n)							\
+			dept_ecxt_enter_nokeep(m);			\
+		else if (t)						\
+			dept_ecxt_enter(m, LDT_EVT_L, i, "trylock", "unlock", sl);\
+		else {							\
+			dept_wait(m, LDT_EVT_L, i, "lock", sl);		\
+			dept_ecxt_enter(m, LDT_EVT_L, i, "lock", "unlock", sl);\
+		}							\
+	} while (0)
+
+#define ldt_rlock(m, sl, t, n, i, q)					\
+	do {								\
+		if (n)							\
+			dept_ecxt_enter_nokeep(m);			\
+		else if (t)						\
+			dept_ecxt_enter(m, LDT_EVT_R, i, "read_trylock", "read_unlock", sl);\
+		else {							\
+			dept_wait(m, q ? LDT_EVT_RW : LDT_EVT_W, i, "read_lock", sl);\
+			dept_ecxt_enter(m, LDT_EVT_R, i, "read_lock", "read_unlock", sl);\
+		}							\
+	} while (0)
+
+#define ldt_wlock(m, sl, t, n, i)					\
+	do {								\
+		if (n)							\
+			dept_ecxt_enter_nokeep(m);			\
+		else if (t)						\
+			dept_ecxt_enter(m, LDT_EVT_W, i, "write_trylock", "write_unlock", sl);\
+		else {							\
+			dept_wait(m, LDT_EVT_RW, i, "write_lock", sl);	\
+			dept_ecxt_enter(m, LDT_EVT_W, i, "write_lock", "write_unlock", sl);\
+		}							\
+	} while (0)
+
+#define ldt_unlock(m, i)		dept_ecxt_exit(m, LDT_EVT_ALL, i)
+
+#define ldt_downgrade(m, i)						\
+	do {								\
+		if (dept_ecxt_holding(m, LDT_EVT_W))			\
+			dept_map_ecxt_modify(m, LDT_EVT_W, NULL, LDT_EVT_R, i, "downgrade", "read_unlock", -1);\
+	} while (0)
+
+#define ldt_set_class(m, n, k, sl, i)	dept_map_ecxt_modify(m, LDT_EVT_ALL, k, 0UL, i, "lock_set_class", "(any)unlock", sl)
+#else /* !CONFIG_DEPT */
+#define ldt_init(m, k, su, n)		do { (void)(k); } while (0)
+#define ldt_lock(m, sl, t, n, i)	do { } while (0)
+#define ldt_rlock(m, sl, t, n, i, q)	do { } while (0)
+#define ldt_wlock(m, sl, t, n, i)	do { } while (0)
+#define ldt_unlock(m, i)		do { } while (0)
+#define ldt_downgrade(m, i)		do { } while (0)
+#define ldt_set_class(m, n, k, sl, i)	do { } while (0)
+#endif
+#endif /* __LINUX_DEPT_LDT_H */
-- 
2.17.1



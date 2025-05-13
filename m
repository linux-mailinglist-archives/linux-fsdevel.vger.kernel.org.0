Return-Path: <linux-fsdevel+bounces-48838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEB1AB5151
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4033D3B6B0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114B5248F5C;
	Tue, 13 May 2025 10:07:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA17221282;
	Tue, 13 May 2025 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130869; cv=none; b=qtMRyrpoh2fqG9Fay1toaIxLcPt35/7atVYNy6b7GGnauT496IYeH/wpi4mDOgcHt2ZRmBqtsCkZoR33suqdNkcy1cby97pFNTlpGws6DTL5DeQz5ivTN9n7mwJlgzVvWBMfEumUWTzeojaZR6Gz4wc0z9jH/n4a97pIYKiVoKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130869; c=relaxed/simple;
	bh=kvYUJhkWNXGz3XMq3BkQN4+iBe4C0wrSkzgpQBtg3O0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MsZdC49Cr8sMZOOGjLvgv5QMEUfQxKJIoUBxv4e1thdCKsr5F0kfLElh5vrCt8zIkOpWhIDExUfFilPvk/ynlPhftI2UZ58D55uUcHnj2TIRcTz35dBYOW76NScoNmpoJEsGi6i8xJVvIGEiLP3t8ILNc1/ydZ5uo/mO7a5lD08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-fb-682319ed8f02
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
Subject: [PATCH v15 04/43] dept: add lock dependency tracker APIs
Date: Tue, 13 May 2025 19:06:51 +0900
Message-Id: <20250513100730.12664-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUiTaxjGfZ73a652ztuSfMvgnDMxSenDsroJCyM4PVBBUP1TdGrlixtO
	jVmWQaDNzD40K9RO62POmjvbKs80tQ/TVmkmmaWZipqKSZJOW240M2tL+ufmx3VdXPc/l4SS
	1zPzJOqkA6I2SalRsFJaOjKzaJFzbqhq6YVKKbjHs2m4fNvGQvMtKwJbeQaGoacb4K1nGMHX
	Fy8pKMxvRlDU101BeV0PgmrzMRZaBn6DVvcoCw35p1nQFd9m4dXHSQxdBecxWO2b4Z1pkIbG
	PCOGwiEW9IU67DsfMHhNFg5M6WHQb77EwWRfFDT0tDFQ3RkJ/17tYuFBdQMNdVX9GFruXWah
	x/adgca6ZzR4ckOg+VwOAzedRhY+ekwUmNyjHLyuNWCoM8yB0kxfYdbnKQbqc2oxZF3/H0Nr
	x30ED7N7MdhtbSw8dg9jKLPnUzBR8hRBf+4IB8fPeDnQZ+QiOH28gIbMrhXw9Yvv85XxKMi4
	VkrDzW9tKHYNsV21IfJ4eJQimWWHyIT7DUuqPQaaPDcK5O6lbo5kPuzkiMF+kJSZI0jxgyFM
	ilxuhtgtJ1lid53nyKmRVkycTU3clvk7pDFxokadKmqXrN0jVV1z6Zj974MPDzS9xOnILD+F
	AiUCHy3UtJzAv/j11AvGzywfLrS3eyk/B/F/CmU5gz5dKqH4thnC2ysdyG/M5tcJA531P5nm
	w4SBjl7WzzJ+hTBR04imS/8QrKW1P4sC+ZXCt5Im2s9yXybPYKWnM2cDBde51dM8V3hkbqfz
	kMyAAixIrk5KTVSqNdGLVWlJ6sOL9yUn2pFvXqajkzurkKt5qwPxEqSYKXs29JdKzihTU9IS
	HUiQUIogWUalT5LFKdOOiNrk3dqDGjHFgUIktCJYtsxzKE7OxysPiAmiuF/U/nKxJHBeOrrh
	NNLfNXfGyvWhEdvtZ9f/3RcUE7N27+pI9Pv8ilDbmO7GpuTYjYb3E+HFlqwqXS8X8I8yYUl4
	Qk4ABBdl/2fauCA+mhQsDZtcZeFbGvZsn+X4bP0wFlaxd/Pu2C8V2wYveD9ddDj1kfeNJSGt
	Pd2WXdSmquDlU3Htnd6F+qO3nijoFJUyKoLSpih/AP7eDKJaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTYRTHfd67q8XLknxLonojIstKaHKgkPpQPt0vBFEEOfSlLa9saRoU
	W2qUpphgUmbOWdPmLJ1BZs5E0VriNDVLUTOzi+WUzFmaVlvRl8OP///wO18ORyos9BJOE3ta
	0saqokVGRsn2bU4Jci1eqd74vSMI3JOXKLh538pA+70yBNYHBgJGmsLg1dQogp+tbSTk5bYj
	KHrbT8KD5gEE9tILDHQOL4Au9zgDjtwMBlKK7zPw4sssAX3Xcggos+2FN+YPFLRkmwjIG2Eg
	Py+F8IxPBEybLSyY9atgqPQGC7Nvg8Ex0E1DY4GDBnvvWrh+q4+BWruDgubqIQI6a24yMGD9
	TUNL8zMKprICoP1qJg3lYyYGvkyZSTC7x1noqDcS0GxcBBWpHuvFb79oeJpZT8DF25UEdPU8
	RlB3aZAAm7WbgUb3KAFVtlwSZkqaEAxluVhIuzLNQr4hC0FG2jUKUvuU8POH53LBZDAYCiso
	KJ/rRltDsfWWFeHG0XESp1adwTPulwy2Txkp/Nwk4Ec3+lmcWtfLYqMtAVeVBuLi2hECF024
	aWyzXGawbSKHxemuLgKPOZ3sgaXHZFsipWhNoqTdEBouUxdOpNDx7/2Thp1thB6VKtKRLyfw
	m4SOX620lxl+tfD69TTpZT9+uVCV+cGTyziS754nvCroQd5iIb9NGO59+pcpfpUw3DPIeFnO
	K4WZJy3on3SZUFZR/1fky4cIcyVOyssKz062sYzKRjIj8rEgP01sYoxKE61cr4tSJ8dqktZH
	xMXYkOeDzOdmr1ajyc6wBsRzSJwvfzayQq2gVYm65JgGJHCk6Cc3PPRE8khV8llJG3dCmxAt
	6RpQAEeJ/vJdR6RwBX9SdVqKkqR4Sfu/JTjfJXoEhyLy11gKk9J2H91i32UK2yyfd/a4abC8
	sjJ9B37HNmQGiFFFG1yHa7a5fT6u2ytmfA1afcdxnusItPS7Tk2KuGQHN9sWrt+/P35s6Tkx
	PURvDXX4UON65efI4qCEPXevhPrvdAR0Gt4UsOUh0vY775QHTyWcWPm8ds6Zc73aJVI6tSo4
	kNTqVH8AJbTJYz0DAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Wrap the base APIs for easier annotation on typical lock.

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



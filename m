Return-Path: <linux-fsdevel+bounces-12234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C011985D48A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 10:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F101C1C230D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 09:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12A04653A;
	Wed, 21 Feb 2024 09:50:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FD23F8C3;
	Wed, 21 Feb 2024 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509000; cv=none; b=N4/j/8dDWwpkGPbJuP+CI+ad4ayReBGxbBJ3vNgC/XO7tnT+Yg8w4YuTQ9xRn4gtbqWfIgN5l2jB8+KprWmv/tPJzrKSXeX3GFX1gWENuC2NMrHaJ/vaF7JiuTUJxesFxvI7LDle0FtICCQhThbZ6M+v70wpzGY+5+L/RwAO/NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509000; c=relaxed/simple;
	bh=MruAYr/ze2aZU4Q6DDtEFdBspBpkL05uqzvhsrQG5Gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kIrSy8MqjJQ97vU39lyIBnJ3gqkAN6LbkunRPPHRFidzCTkkEFDgNvD8aoRzL9Ou4jK755JmOrssnmp7iMrp0TPSC7eNMQQGzY4kuHemBt2rnpR4Ad+ZcQinWE3kmIFYOdbNSuGmNiCJTIkooqut5/ylEjiVoglqk1iqfF9DTkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-28-65d5c73939f9
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
Subject: [PATCH v12 10/27] dept: Apply sdt_might_sleep_{start,end}() to hashed-waitqueue wait
Date: Wed, 21 Feb 2024 18:49:16 +0900
Message-Id: <20240221094933.36348-11-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240221094933.36348-1-byungchul@sk.com>
References: <20240221094933.36348-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAz2SfUzMcRzHfb+/xzuu/XaMX/mD3ZiNJdmxDzOLGb9/bB5m8xi3+k3HdeVS
	yTwUJxxRzYmrccXOVUe5qylkp+e0FB0d65paHtIlKxepcJfxz2evvd97v/76sIT8ERXCqrWH
	RZ1WpVHQUlI6MC0/dEXDK3FJeU0oZF1cAr5v50jIK7HR0HavGIGtLA1DX90G6BjxIhhraSUg
	x9iGIL/bQ0BZfReCKuspGtp7g8DlG6ShyXiBhtO3Smh40T+OofNqNoZi+0ZozizA4Bz9SEJO
	Hw25Oaex/3zCMGopYsCSOh96rCYGxrvDoanrNQVVbxfB9RudNDyuaiKhvqIHQ/vDPBq6bL8p
	aK5vJKEtK4OCu18KaOgfsRBg8Q0y8NJpxlCq94vSh39R0JDhxJB++z4G15tHCJ6ce4fBbntN
	Q43Pi8FhNxLw804dgp5LAwycuTjKQG7aJQQXzlwloXWigQJ95zIY+5FHR6wUaryDhKB3JAtV
	I2ZSeFbAC5UmDyPon7xlBLM9UXBYFwq3HvdhIX/IRwn2ovO0YB/KZgTDgAsLX54/Z4TGa2Ok
	0OvKwZtm75SuihY16iRRF7Z6nzTmoyeLinezRyZqK5lU5KYNSMLynJI3mb7/5zpDKRlgmlvA
	u92jRIBncHN5R8YHyoCkLMGdncpbv7ZMDqZze3hzXvvkgOTm8+VXvDjAMm4539dqwH+lc/ji
	UuekSOLPC3O9VIDl3DL+1YtyIiDlubMSvlGfTf0dBPNPrW4yE8nMaEoRkqu1SbEqtUa5OCZF
	qz6yOCou1o78L2U5Pr6rAg21ba1GHIsU02QxD1yinFIlJaTEViOeJRQzZGSyP5JFq1KOirq4
	vbpEjZhQjWazpGKWbOlIcrSc2686LB4UxXhR96/FrCQkFR03/nxf1vE09LJn5vDGtPD1hT9c
	O7qUaia9RRM0L7Iucezu9t2mZs9JnLxde0wpfXNAtmVdbUdIELnipTNkc2bkSmnG0UPLv9/M
	8j1oXHRi5pqGcaYwIsKdNpEfGXWM+zxPubZkWzD+LAlbasu1aoYyHcb+fXPLeoeD6e7wd3GR
	WgWZEKMKX0joElR/AKHS4eZOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfb+/x45rP2n85mHsxmyZiI6P1ZqHWT+MYW22MG7dbzoquVPE
	mutBOIqahC67HpxT4VxZoU4rlbQe6ErsapRRuh6WLnrwcGX++ey193vv118flvDIouazqoiT
	ojpCESajJaRkl1/Cyg21reLqqoF5kHplNThHLpKgf1RIQ/PDAgSFxXEYeqsD4d2oA8FEQxMB
	GenNCLI/dRBQXNOJoNwUT0PLZ3ewOQdpqEu/TENC7iMa3vRNYrDfSMNQYNkJ9ddyMFSMfSUh
	o5eGzIwE7Do9GMaM+QwYtcugy3SbgclPPlDX2UZBVVYdBeUfVsCtO3YaysrrSKgp7cLQ8kxP
	Q2fhHwrqa16R0JyaTMGDgRwa+kaNBBidgwy8rTBgMCe6bEnff1NQm1yBISnvMQbb++cIrBc/
	YrAUttFQ5XRgKLKkEzB+rxpBV0o/A+evjDGQGZeC4PL5GyQ0/aqlINEuh4mfenqjn1DlGCSE
	xKJTQvmogRRe5/DC09sdjJBo/cAIBkuUUGTyEnLLerGQPeykBEv+JVqwDKcxgq7fhoWBxkZG
	eHVzghQ+2zLw7oXBEn+lGKaKFtWrAg5LQr92pFKR7ezpXy+fMlrUTuuQG8tzvny1zkxOMc0t
	59vbx4gp9uSW8EXJXygdkrAEd2EmbxpqmB7M4Q7yBn3L9IDklvFPrjvwFEu5dXxvkw7/ky7m
	C8wV0yI3V34/00FNsQcn51vfPCGuIYkBzchHnqqI6HCFKkzurTkWGhOhOu0dcjzcglxPY4yd
	TC1FIy2BlYhjkWyWNLTEJnpQimhNTHgl4llC5iklT7kiqVIRc0ZUHz+kjgoTNZVoAUvK5km3
	7xMPe3BHFCfFY6IYKar/t5h1m69Fce+z5sofl+wxamtLu1VNm4Lct/iKB63WoMCrlVH6pd1e
	e+8qDXJdnD5+Yoc4NJyXoNQcXWs863vAv23cfmJzG2FWbl/l3bojcmuD2R58K3lRgPvH9O5F
	0br1S9lna1Zod/ulaSN/WEI6vr2N+bP/XOzsQNNOa0qP5sX66m1JxQHbZKQmVOHjRag1ir9t
	5u28MAMAAA==
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



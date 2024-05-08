Return-Path: <linux-fsdevel+bounces-19055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7BF8BFA3A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 12:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860201F23B04
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 10:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E831082885;
	Wed,  8 May 2024 10:03:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1187E0F0;
	Wed,  8 May 2024 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162584; cv=none; b=SurNJ4RNJKtlbKyD454aFJay8h95BspMn249KGbTZ4ftKrWyOTUkioJKa5sItTyPiTbc7iZ5kMHmdy8lE9bBfSIiVupg0Z5+jJ/iN2pjA1B9+pSspU92IhuydaEQIA4X9yXrrzx/5isJJ/TCduKe7TKKqNrIrB8NT3Wld5DFyZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162584; c=relaxed/simple;
	bh=MruAYr/ze2aZU4Q6DDtEFdBspBpkL05uqzvhsrQG5Gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ViW4YFX6Qzdcf9geUx/ABt/GuQpSgrFbBSIDsWd0efQ0OPrcrHSQBdmzztbkhdtgm2w0lqsCeRptHQB6dsM6eu4ZhJ9k+YbBnQrDOw+OWtuIWP3ynGmFJBi6oosKaPbyFKa80AQ4ZRG3nsdQx+594arO85wT4tNGC8bIKq2RUE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-f6-663b4a3a5441
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
Subject: [PATCH v14 14/28] dept: Apply sdt_might_sleep_{start,end}() to hashed-waitqueue wait
Date: Wed,  8 May 2024 18:47:11 +0900
Message-Id: <20240508094726.35754-15-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508094726.35754-1-byungchul@sk.com>
References: <20240508094726.35754-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAz3Sa0yTZxQHcJ73TkP1tcPwjpFMmxAVM4YG9UxxMYbpM4mJ15hIjOvgReoA
	tVUQGQlIuchFgQWqgKaAKRWqaOEDIrgKgiApdti4QrhMNCIKNDKK1lY3Ltm+nPxyLv9PhyNl
	jbQ/p0w4LaoSFHFyRkJJJn0qv9m8a0tMSEuXHIryQ8A5k0NBRb2RAeutOgTGxnQCxjt2wp+z
	EwjclickaEusCCqfD5HQ2DmMoNVwnoGnL5eAzelgoLskj4GM6noG/njrIWCwtJiAOtNu6Cms
	IsDsGqNAO85AuTaDmCuvCXDpa1nQpwXCqKGMBc/zddA9/IyG1oG1cOXaIAMtrd0UdDaNEvC0
	uYKBYeM/NPR0dlFgLSqg4eZUFQNvZ/Uk6J0OFvrMOgJua+aCsv7+TMOjAjMBWdfvEGDrv4fg
	fs5fBJiMzxhod04Q0GAqIeFjTQeC0YuTLGTmu1goT7+IIC+zlALN4AZwf6hgtn2H2yccJNY0
	JOHWWR2FH1cJ+G7ZEIs19wdYrDOdwQ2GIFzdMk7gymknjU21Fxhsmi5mce6kjcBTvb0s7rrs
	pvBLm5bY439YEhYtxikTRdW33/8kiR0bKqJP2rmznx7eZdOQnclF3pzAhwo5ngv/u/txDTlv
	hl8l2O2uBfvyK4SGglf0vEl+QiJc790x7y/4I8KlN5ULtxQfKDR35C1Yym8UjPZacjHza6Hu
	tnnB3nP9/rEpNG8Zv0G4l1HGLu7McMI7S8iivxQeGOxUIZLqkFctkikTEuMVyrjQ4NjkBOXZ
	4KgT8SY090v6VE9kE5q27m9DPIfkPlKz3+YYGa1IVCfHtyGBI+W+0o7sTTEyabQi+ZyoOnFU
	dSZOVLehrzhK7iddP5sULeOPKU6Lv4jiSVH135TgvP3T0KqIX90jL/rZlPOW0ON7jL+9dgR/
	6nuYfWnlVU3NgZ2HUlLKLafa8/22uX4PzxxYtjT8zkzA8oA1UXorrvuxuWmr9ENq8I0e2Sbf
	gvDtHvdItjpCu/GU3pP//oewnw2Wg9X12z/ug9V9LUntxie5tii/EMfezGmdV1ZAVuFIM3vj
	c6ScUscq1gWRKrXiX7YHUApHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSbUhTYRQH8J778tzrcHFbUpcsymFUWmaQdUgrP1RejKRPBkLkqGsb6Yyt
	LKNAU3vRfFmhs2kyzaZt86XZB2taos5akVmKTVHJFak1FapJS3tRoy+HH+fP+X86LCnT06tY
	lfqMqFErkuVYQkniIrO27IqNTAofNfiD7kY4eL9fo6C8wYqhp96CwPowk4AJRwy8m/EgmH31
	mgR9cQ+CytFhEh52jSBorb2MoffjUujzTmNwFudhyLrbgOHNlzkChkpuEmCxHYKXRVUEtPnG
	KNBPYCjTZxHzY5wAn8nMgCljPbhrDQzMjW4D50g/DR13nDS0DobC7YohDC2tTgq6mt0E9D4u
	xzBi/UPDy67nFPTo8mmom6rC8GXGRILJO83A2zYjAY3Z821Xvv2m4Vl+GwFXqh8Q0DdgR/Dk
	2nsCbNZ+DB1eDwFNtmISftY4ELgLJhnIueFjoCyzAEFeTgkF2UMRMPujHEfvEjo806SQ3XRO
	aJ0xUsKLKl54ZBhmhOwng4xgtJ0VmmpDhLstE4RQ+dVLCzbzdSzYvt5khNzJPkKY6u5mhOel
	s5TwsU9PHA5MkESdEJNVaaJm655EiXJsWEefdrHnf3U+YjKQC+ciP5bntvPOFzXkgjG3gXe5
	fIsO4NbxTfmf6AWTnEfCV3cfWPBy7ihf+Lly8Zbi1vOPHXmLlnI7eKvLTP7rXMtbGtsW7Te/
	HxibQguWcRG8PcvAFCGJES0xowCVOi1FoUqOCNOeUqarVefDjqem2ND8u5guzema0ffemHbE
	sUjuL+3BkUkyWpGmTU9pRzxLygOkjqs7k2TSE4r0C6Im9ZjmbLKobUeBLCVfKY09IibKuJOK
	M+IpUTwtav6nBOu3KgPdWmNsiJIlRLGdIUFGd2Vzp8VdOG738RmpG+/tV45Z64I6Vw+Nh81J
	YoJn7YV5xvCZ+44PdRWeUX1w2Yr6Bl0MUicESrfmuEyOZZveXdzydJ9oie6ofmvGObilsDRX
	0zWy+fUOZf/uB6b4fH9laFzB3vZ936IO2uNDDSm/42k5pVUqtoWQGq3iL4Oqv/cqAwAA
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



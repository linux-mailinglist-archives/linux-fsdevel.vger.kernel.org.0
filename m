Return-Path: <linux-fsdevel+bounces-48855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AA0AB51B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A6D188FB98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E439258CD5;
	Tue, 13 May 2025 10:08:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E2F267B90;
	Tue, 13 May 2025 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130883; cv=none; b=g4H8iZ0RmxL/jShZK5sVs95jcNu7DI2O5Ahjb7zCk5mklEBEjeSKc+hfxVnbbcICZdrUrdMhHpbUG5/3Cc1LtT2Eo/v3HPyQb51H/1/PoyplvK5an2MTqAJa5FyTSMzPPABYyUJFTNJdmMXXPyikhu/YW98hU3F80T6bKC85Hts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130883; c=relaxed/simple;
	bh=G02jUxrc8GHX4FLfxPcv5jAlvBb9vcSmciPzIKTL9pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FT7QyFPqiRyRdlASUGhDBrDwE9YWlHYj3yogd0zpn8cq3GT29j9NKkShZ8+EMdL7IT1XcRzw+15Nn2ZjmV8lz/4Je7yD50XQnWSMkF1MrIILy+lxD93S5WIloYP5PWHz7HmiCuci192qZivnVDfnMhbVCzZWmr3GqPnxLXsEfIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-0c-682319f0cb72
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
Subject: [PATCH v15 21/43] dept: apply timeout consideration to waitqueue wait
Date: Tue, 13 May 2025 19:07:08 +0900
Message-Id: <20250513100730.12664-22-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTcRTG+7/XuVq8rMjXNKrViopKReMQFX4IeimKoE8VVCNf20inzLQm
	BLOmrYtihkraZVrM6ZaXqWXlzBSXS7KVutSmqYi1vIW6mWmXzerL4cfznPM8X44AF7eQKwUK
	5TlepZTFSighIRxbUrj1W9A6eajRvgk80zoC7pSbKXCUmRCYq1MxcDfvgw/eUQRzb97ikJfj
	QFA40ItDta0PgdV4iYL2oaXQ4ZmgwJ5znYLLD8opeDcyj4ErNxsDk+UgfDIME9CaVYRBnpuC
	grzLmG98wWDWUEqDQSOFQWM+DfMDYWDvc5Jg7dkCt++5KKiz2gmw1Q5i0P7sDgV95t8ktNpa
	CPBmBoPjZgYJj8aLKBjxGnAweCZoeN+gx8CmXwEVWl9g+tQvEl5lNGCQ/rASg47u5wjqdf0Y
	WMxOCpo8oxhUWXJw+FHcjGAwc4yGtBuzNBSkZiK4npZLgNYVCXPffc13p8Mg9X4FAY9+OlHU
	bs58z4y4ptEJnNNWned+eDopzurVE9zrIpZ7mt9Lc9r6HprTW5K4KuNm7kGdG+MKJz0kZym9
	SnGWyWyauzbWgXHjbW304ZBjwl3RfKwimVdt33NKKHdla8mEGvqCqfgSpUFa6hoKELBMBGus
	nCL/84uyxws6xWxku7pmcT8vZ9awVRnDvh2hAGeci9kPd7uR31jGHGJLa+YWjglGyjpffqb9
	LGJ2sAMfs/4VrGZNFQ0LQQE+/WdxG+FnMRPJZulNhD+UZW4FsK4SO/H3IIh9aewispBIjxaV
	IrFCmRwnU8RGbJOrlYoL207Hx1mQ778MF+eP16JJx5FGxAiQZImoxb1WLiZlyYnquEbECnDJ
	clHqE58kipapU3hV/ElVUiyf2IiCBYQkUBTuPR8tZs7IzvFneT6BV/13MUHASg3CyRjrhp2O
	BN1QSkh+0fyvZdLwJsWEqZP/JJ7JWXTqa/xMSJTw4XhoR7070t7XW1I8N7zfsk5DqruV00d1
	QXb1AUaXd3JqdeWV3Bhna2BSJja4dm/1gYzckZoBjZRJq2xfRcedaJJuaU73xNcG2/pnvs8O
	rReHPdtY8LF2TdS4hEiUy8I246pE2R8tt+I4WwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTYRiGfb/jnC2+TOrrRLWywsgSsh4oovrjS5D0I0iigys/2mpO22xp
	B3C5xLTpMmyUaXPFtG2lbR3soJni0iyztGW1LKXTyLLSSTY7bFF/Hi7uG677zyMiI230ZJFC
	lSGoVTKllBFT4sRlOQu+TJolX3S+Wgz+oTwKTlc7GOi4aEfguKwjwNecAE+H+xEEHjwkwVTS
	gaCi9yUJl909COqqDjHQ+WYsdPkHGGgtKWAg52w1A48+jhLgPVFMgN25Fl5Z31HQZrQQYPIx
	UGrKIYLnAwEjVhsL1uxo6Ks6xcJobxy09nhoaCprpaHu+Xw4We5l4FZdKwXu2j4COm+cZqDH
	8ZuGNncLBcOFU6DjmIGGC58tDHwctpJg9Q+w8LjBTIDbPAFq9EFr7uAvGu4aGgjIPXeJgK5n
	NxHU570mwOnwMNDk7yfA5Swh4UdlM4K+wk8sHD46wkKprhBBweETFOi98RD4HlwuG4oD3Zka
	Ci789KCVK7Cj3IFwU/8AifWuvfiH/wmD64bNFL5n4fH1Uy9ZrK9/zmKzcw92VcXgs7d8BK74
	5qex03aEwc5vxSzO/9RF4M/t7ey6aRvFy1MEpUIrqBeuSBbLvcV6Ov0Km2mvPMRkIz2Tj8JF
	PLeYv33x6l9muLl8d/cIGeIobgbvMryj85FYRHKeCP5p2TMUKsZzibztSoAOMcVF854779kQ
	S7glfO8L4z/pdN5e0/BXFB7Mf1a2UyGO5OJ5o9lOGZHYjMJsKEqh0qbKFMr4WM0ueZZKkRm7
	PS3ViYIfZD04eqwWDXUmNCJOhKRjJC2+mfJIWqbVZKU2Il5ESqMkumvBSJIiy9onqNO2qvco
	BU0jmiKipBMlazYIyZHcDlmGsEsQ0gX1/5YQhU/ORknO44PREZtsuPjqV2XCwGBOUmmRJa+x
	fqwxq4nQjls3bZXs4VFDScPXjeJk3ZyZieu9LfNi0w5sPtBt01oCLi6hwDSuaGpXxdvlRau3
	7t/yJaLUuN33+/3usNmxYerc0dvblNay9g+Bpe6M7pW5bS+Om3bezzR4+q7HaNrKX7ObVFJK
	I5fFxZBqjewPbbt9GD0DAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to waitqueue wait, assuming an input 'ret' in
___wait_event() macro is used as a timeout value.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index aae161e500dc..e77344a8160d 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -304,7 +304,7 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 	struct wait_queue_entry __wq_entry;					\
 	long __ret = ret;	/* explicit shadow */				\
 										\
-	sdt_might_sleep_start(NULL);						\
+	sdt_might_sleep_start_timeout(NULL, __ret);				\
 	init_wait_entry(&__wq_entry, exclusive ? WQ_FLAG_EXCLUSIVE : 0);	\
 	for (;;) {								\
 		long __int = prepare_to_wait_event(&wq_head, &__wq_entry, state);\
-- 
2.17.1



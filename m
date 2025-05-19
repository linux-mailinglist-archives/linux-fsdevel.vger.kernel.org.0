Return-Path: <linux-fsdevel+bounces-49364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9AEABB938
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8683B2A45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC1F280026;
	Mon, 19 May 2025 09:19:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2EA275877;
	Mon, 19 May 2025 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646340; cv=none; b=TMThDHYpAAaIwB7c7W1O8kQVzgjYekHuvVtX5rgLrYKrWZ5ncapg/lYdhPJw4CqiJ7MMuoo9zc3zHAVEHQtd/pZRVGC6t4Lrb4m126ER6bpUkCuEQ+GF1ncItUHNyEXpTr4DdtFBM5zsPTeFNvZrvWmsggx2+GxZGEeA3x/M+zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646340; c=relaxed/simple;
	bh=sXq6ZG2FCPgGrD/93i05yDVFGWV/kuOXrwRc2Zt22go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pFaogj0GYg2v/WHeMc10k6Gi+TdbpmqgX+YDPPWRGMVAO7XR/bTzU3AgnEHXuIHamnFlgDDtIcudYjSJYBzBNLnslfVT5a4GN8/+7ytecKHNWzLq8+JGKilp/EfAILbxHm1CPb2HSNousXIE4wXGQ+n8dvHKr5EtxU5SQsz2f5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-38-682af76f1e13
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
Subject: [PATCH v16 22/42] dept: apply timeout consideration to hashed-waitqueue wait
Date: Mon, 19 May 2025 18:18:06 +0900
Message-Id: <20250519091826.19752-23-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSeUiTcRjH+723q8XLut4OMkdW2mkXT5DR8UcvRNFB0QHVaC9ttKlsHikE
	ztRKU9JQO8ymxhq6bG12N1uKKxfVLLNlamlpSbORueXVsRn98/Dh++X5PP88DC5xkNMYZUy8
	oImRqaSUiBD1jitdGPszUrEkLXMm+PpPElB83USBq6oSgalah0FP/UZ44/cgGH72AoeiAheC
	0o42HKod7QhsxjQKXn0aD00+LwUNBdkUHC+/TkHj1xEMWgvzMai0bIb3hm4Cnp4pw6Coh4KL
	RcexwPiCwaChggZDajh0Gi/QMNIRBQ3tzSTYWubD+ZJWCh7YGghw3OnE4NW9YgraTX9IeOp4
	QoA/dzq48nJIuPatjIKvfgMOBp+Xhpd2PQYO/WQwpweEmT9+k/A4x45B5pUbGDS9vY+g5uQH
	DCymZgrqfB4MrJYCHIau1iPozO2lIeP0IA0XdbkIsjMKCUhvXQHDA4HLl/qjQHfZTMC1X81o
	bTRvKjEhvs7jxfl0axI/5HtN8Ta/nuCdZRx/90IbzafXtNC83pLAW42RfPmDHowv7fORvKXi
	FMVb+vJpPqu3CeO/PX9Ob52xV7RaLqiUiYJm8ZqDIsXP7M1xufTRLnMemYo6yCzEMBy7nHN3
	h2ahkFHs+ZhGBpli53Ju9yAe5InsLM6a0x3IRQzONo/l3lx6i4LFBHYnV+McooNMsOFcpt01
	uixmV3J2XRr6Jw3lKs32UVFIIG/JrhvNJewKrqmyhAhKOfZsCFd+q4H8tzCVe2R0E2eQWI/G
	VCCJMiZRLVOqli9SJMcojy46FKu2oMB3GY6N7LuD+lw7ahHLIOk4sdkWoZCQskRtsroWcQwu
	nSiusM5TSMRyWXKKoIk9oElQCdpaNJ0hpFPES/1Jcgl7WBYvHBGEOEHzv8WYkGmpaFVHmGqD
	b3/GhvVzCj3RSWuEz4k6rUPhfye0RVyOniWPWkCeit/2blLrpzr1j0PdtvOO4VBntedc/pF1
	J6qI3b0DE+75vnjFYyXftyo33dTUb9mzy9U2+7AzIWe70b0sLy5ijyYs/PMNb2PjAKvWeqLd
	D1NW9TtT9m7Bwm7LZ3Z5pYRWIYuKxDVa2V8RiASLWQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+93nXE0uS/KSRDWTTKkUMg4U1T/VpUjCCkECXXlpQ52xpWZQ
	+JiWzzJakqYttWVu6twkezgdmiuNzNLUbFlaWcupVG6l2WMa/XP48v1yPge+HAEuvkUuF8gV
	J3ilQhovoYSEMHxL5vrE70GyEM0MDa7pcwRcrTdQ0FOnR2BoTMfA0bEbBtxOBD+fPMWhWNOD
	4PrIaxwabcMILNUZFPS+94Y+1xQFnZo8CjIr6yl4Nj6Hgf3yRQz0pn3wRjdGwOMLFRgUOygo
	Lc7EPOMTBjO6Ghp0aQEwWl1Cw9xIKHQO95PQXtZJgmUoGK6U2ylotnQSYLszikHvvasUDBv+
	kPDY9ogAd6Ef9BQVkFA7WUHBuFuHg841RcNzqxYDm3YZGNUeava33yQ8LLBikF3VgEHfy/sI
	Ws69xcBk6Keg3eXEwGzS4DB7swPBaOEEDVn5niZK0wsR5GVdJkBtD4OfPzyXy6ZDIf2akYDa
	X/1oxzbOUG5AXLtzCufU5hRu1vWC4ixuLcF1VbDc3ZLXNKduGaI5rSmJM1cHcZXNDoy7/tVF
	cqaaHIozfb1Ic7kTfRg32d1N718RJdway8fLk3nlxm0xQtn3vH3HC+mTH4xFZBoaIXORl4Bl
	NrGOdxkLmmLWsoODM/i89mFWseaCMY8vFOBM/2J2oOwlmg+WMofYlq5Zel4TTACbbe1ZWBYx
	m1lregb6B13J6o3WBZCXxx/Ka1/wxUwY26cvJy4goRYtqkE+ckVyglQeH7ZBFSdLVchPbjia
	mGBCngfSnZ4ruoOme3e3IUaAJEtERss6mZiUJqtSE9oQK8AlPqIac6BMLIqVpp7ilYnRyqR4
	XtWG/ASExFe0J5KPETPHpCf4OJ4/ziv/p5jAa3kaOr/3WlVb8MoHB+zsVqLjk2FjV+TBX9XS
	I40o/P3YQHhtROvE9tr84JzASJlll2P8I1MxmqoZjKjXR615F2O2x/rUNaREbzam9H5Z8e3s
	7dY1+UOv1DtNluKlse5E3t+5P+Szb0qw0ftS0w1FyZR/eJKv7XDaGX3psHOOXu1ta26SECqZ
	NDQIV6qkfwEJSOKYPAMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to hashed-waitqueue wait, assuming an input 'ret' in
___wait_var_event() macro is used as a timeout value.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait_bit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 179a616ad245..9885ac4e1ded 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -258,7 +258,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
 	struct wait_bit_queue_entry __wbq_entry;			\
 	long __ret = ret; /* explicit shadow */				\
 									\
-	sdt_might_sleep_start(NULL);					\
+	sdt_might_sleep_start_timeout(NULL, __ret);			\
 	init_wait_var_entry(&__wbq_entry, var,				\
 			    exclusive ? WQ_FLAG_EXCLUSIVE : 0);		\
 	for (;;) {							\
-- 
2.17.1



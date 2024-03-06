Return-Path: <linux-fsdevel+bounces-13718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E45608731EC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 10:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F921C22118
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831BE6775E;
	Wed,  6 Mar 2024 08:55:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF216313F;
	Wed,  6 Mar 2024 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715349; cv=none; b=LTxq/fpP3wOcCYeOXj+9ZUUflbPhK1vKHdK+ZuLisTl0pPEZ/HRbWCxwxTu5mxmy5w60Slxi8S7VO8kVigW0H52tTVOK2vjFDIP60cuQrbplWpQxtOx1pfnEe/rDTsNyIi0kCiNo53Zvi6gPF96lcZJlSgGll3fjgkwqOUYKMe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715349; c=relaxed/simple;
	bh=A0HNCh9MAJFiyY64P3s+ZnF2ZrT06e1PDF08t8YO27Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Z9JpUcH8hmQGoh1XwV09ORm8ogHa8MKEKCnEPUTsz0ckjxxpzwlHswN1pcsnaW2zoClwFocTkKxsKUOwOC1BdMJ+jVixJYxAEdskNHeWXrMT+DNwS09WiuTyf3dDvLIJ+SNn/tN50bOEriZ9IrdikeN5J/aaWLde7woS3+0CG2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-79-65e82f7fe118
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
Subject: [PATCH v13 21/27] dept: Apply timeout consideration to dma fence wait
Date: Wed,  6 Mar 2024 17:55:07 +0900
Message-Id: <20240306085513.41482-22-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306085513.41482-1-byungchul@sk.com>
References: <20240306085513.41482-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSa1BMYRgHcO97zp5zdllzZmvGkfvOYMalcp3HuIyZXI4PDGMMwwc2Hdpp
	29hNZBilWolKqEhMt1mrlnJ2EVkSUkpKDUmlTSS6zMQuWztll/Hlmd/8n8unhyEUVokfo9ZG
	CjqtSqOkZKSsb1ze/BMBX4XA2tqJkHY2EBw/E0nILjZTUH+rCIHZGouh5/l6eOfsRTD86jUB
	men1CHLtbQRYK9sR2EwnKWjsGg9NjgEKqtPPUBCXX0xBw3c3htaM8xiKxI1Qcy4PQ7mrm4TM
	HgquZMZhT/mKwWUspMEYMxM6TVk0uO0LoLr9rQRsLXPh8rVWCh7aqkmoLO3E0Pggm4J286gE
	aiqrSKhPS5bAzf48Cr47jQQYHQM0vCnPwVAS7zlk+DEigRfJ5RgMBbcxNL0vQ/AosQODaH5L
	wVNHLwaLmE7A0PXnCDpT+mhIOOui4UpsCoIzCRkkxLcugeHf2dTqZfzT3gGCj7cc5m3OHJJ/
	mcfx97PaaD7+UQvN54iHeItpDp//sAfzuYMOCS8WnqZ4cfA8zSf1NWG+v66O5qsuDZN8V1Mm
	3uy3U7YiRNCoowRdwKo9stBfn+KoA43MkaqSZjoGFdFJSMpw7GIuf8iK/7vFflXiNcXO5pqb
	XYTXvux0zpL85W9OsL0yrqBundc+7Cau4dYImYQYhmRncgXWld5Yzi7lRrOcxL+T07iikvK/
	lnry1P5UymsFu4R7FZfrscwzc0rKGd61kf8WJnJPTM3kOSTPQWMKkUKtjQpXqTWL/UOjteoj
	/nsjwkXk+SXjcfeuUjRYv7UCsQxSjpOvlnYLCokqSh8dXoE4hlD6yo8NdQkKeYgq+qigi9it
	O6QR9BVoEkMqJ8gXOg+HKNj9qkghTBAOCLr/XcxI/WLQpKCtxSuXJ9qfBa6xLkyaWpM2a8v+
	mz8P3tuwbK3av2Mkcv28950B3U98OmpNQQU3GphfYd/2BrV8/HbhpT4/dtGFKRcPXmXGVuzQ
	dm2oXn5yrb+29G4o3hehyXIVZxh23t5sE0cTNt1xJ4uPZ4QFf2ANr8sub09IvWu2WyanfA52
	j92mJPWhqgVzCJ1e9QeZ9LuDRwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSXUxTZxzG956P9xwau5x1oCcQozYxTlSQhOrfDwwXi32jk+AuptFFbPBY
	GgGxxWqNxroi6VCsGKAOUMtHKgGmeMqFE6sVIoIGRCGIBFAQP4gFEqUgwlSq8ebJL78nea4e
	nlYVsuG8IT1TMqbrUtVYwSgS1tlWHI9+I61sdzGQd3olBMbtDJRcrcHQfqUaQU3dCQqG72rh
	yYQfwXTrQxqcBe0ISgf6aKhr6kfgrfwLQ8fQj9AZGMPQUnAKg638KoZHb2co6C08R0G1vAUe
	nC2jwDf1mgHnMIZip42ajTcUTLmrOHBbF8NgZREHMwMx0NLfxULjhRYWvD3L4J+LvRhuelsY
	aLo+SEHHjRIM/TWfWXjQ1MxAe14uC/+OlmF4O+GmwR0Y4+Cxz0VBbdbsWvb7Tyzcy/VRkF1x
	jYLOp/UIbtmfUyDXdGFoDPgp8MgFNHy8fBfB4JkRDk6enuKg+MQZBKdOFjKQ1auB6Q8lOH4t
	afSP0STLc4h4J1wMuV8mkv+K+jiSdauHIy75IPFURpLym8MUKX0XYIlc9Tcm8rtzHMkZ6aTI
	aFsbR5rPTzNkqNNJJUbsUKzfI6UazJIxesNuRcrkCxvO6OAPN9d2c1ZUzeWgEF4UYsWegQts
	kLGwROzunqKDHCosFD25r756WvArxIq2jUH+WUgQH135xOQgnmeExWJFXVxQK4VV4ueiCfrb
	5AKxutb3lUNmvWPUgYOsEjRiq60Un0UKF/qhCoUa0s1pOkOqJsq0L8WSbjgclbw/TUazb3Ef
	m8m7jsY7tA1I4JF6jjI+5LWkYnVmkyWtAYk8rQ5VHv04JKmUe3SWI5Jxf5LxYKpkakARPKOe
	p9y0TdqtEvS6TGmfJGVIxu8txYeEW9HepEVNf9aH3/5/zeONI31rGTDrtU7Dh/rjkTH6X1Yz
	4wqt/U7yDrpI4/Vvnx+9efNSEvWyz1KuCZu+pF9uzs/e6o2djMh3xMXZR2MTw3btdHheDP70
	u9xK8h2WA9Z67ZZMq5y37fJWeW5YUmLyjT+e/aY/Hz9pL4yyJuzccMf3q5oxpehiImmjSfcF
	3yO57ikDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to dma fence wait.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/dma-buf/dma-fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 76dba11f0dab..95121cbcc6b5 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -784,7 +784,7 @@ dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
 	cb.task = current;
 	list_add(&cb.base.node, &fence->cb_list);
 
-	sdt_might_sleep_start(NULL);
+	sdt_might_sleep_start_timeout(NULL, timeout);
 	while (!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags) && ret > 0) {
 		if (intr)
 			__set_current_state(TASK_INTERRUPTIBLE);
@@ -888,7 +888,7 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 		}
 	}
 
-	sdt_might_sleep_start(NULL);
+	sdt_might_sleep_start_timeout(NULL, timeout);
 	while (ret > 0) {
 		if (intr)
 			set_current_state(TASK_INTERRUPTIBLE);
-- 
2.17.1



Return-Path: <linux-fsdevel+bounces-48852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65570AB5199
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536B11B47A21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EB227055E;
	Tue, 13 May 2025 10:08:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E386248880;
	Tue, 13 May 2025 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130881; cv=none; b=EAjE+hn700nMwn01DNDwbDQIruQXFN3QYpMjSdJR7HnPLqGw/ZUPKlpNpZKzGjZfil/HbP0EXINYyZZ/4E4pC73q3DLlg+PvE4OSm4rkdz6OpOCkx8xkQGnwhDiH6GL1qGN9KT20RikS/dYC04q7GiMKlzG84f1AChX0qvD/sP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130881; c=relaxed/simple;
	bh=9o9SI0ONdb1WbiIWXrCSb5nX53qir4UGX5Gt0IQgpYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=n3Dn1OQcRi3YqqNkKpWhuwgYWc481xv71+npgMwZo34nWPrn8TI7xbBER1/rNYh+S3PtFV+xh0z6Nxrv8upGq9z1YOcEeG7BJCz5M8qUrgu/wzJd0jBV5OSXg/g+3JakzZYvSDoFAIB5QZUlyNPyIM58A2tLHDVSS6DauYDqQkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-fc-682319f015c0
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
Subject: [PATCH v15 20/43] dept: apply timeout consideration to swait
Date: Tue, 13 May 2025 19:07:07 +0900
Message-Id: <20250513100730.12664-21-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0zTZxjFff/XUq3+7cj2etcKajAyi7o8H+biF8P7xWSXZHPTRBv5Z21W
	QAqikJhRBYIIDCGVCKgtkFKhSCle8FJXQe5Y6+iAKrLJjFlHkaXaZkBxKzi/PDk55+T8vjwS
	Wt7DrpRoUjJEXYpKq+CkjHRySc22v1dsVG/3TayH4JsCBqqbrRy4rzYisF7TU+DrTIThkB/B
	7MNHNFQY3AhMz5/RcK1rDIHDcoqDwRdLwROc4qDXcJaD07XNHDyeCFMwer6Mgkb7PvjN/JKB
	/tIaCip8HFRVnKYi508Kps0NPJhzYmHcUslD+LkSeseGWHA82QoXLo1ycNfRy0BX2zgFg7er
	ORiz/stCf1cPA6GSVeA+V8xC06saDiZCZhrMwSkefnEaKegyfgi23Mhg/uu3LHQXOynIr2uh
	wOO9g+Bewe8U2K1DHHQE/RS02g00zNR3IhgvmeQhr2iahyp9CYKzeecZyB3dBbP/RMgX3yhB
	f9nGQNPcENqzm1gvWRHp8E/RJLf1OJkJ/soRR8jIkL4aTG5VPuNJ7r0nPDHaj5FWSxypveuj
	iCkQZIm94QxH7IEynhROeijyyuXiP1/9nfTTJFGryRR1H392WKpufqFHR19zJyo669gc1McW
	oigJFnbiAkse/16fqncw85oTNuORkWl6XkcL63Fr8ctIXyqhhaHFePiiF80HHwh7cXu+YaHE
	CLF49HLlwpBM+ATrp53/A9bhRptzoRMV8efqXQsAubALlxobmflRLPwUhW2V78hYWIHvW0aY
	UiQzokUNSK5JyUxWabQ749VZKZoT8UdSk+0o8l/mk+EDbSjg/qodCRKkWCLr8W1Qy1lVZnpW
	cjvCEloRLdPfjFiyJFVWtqhLPaQ7phXT29EqCaP4SJYQOp4kF75XZYg/iOJRUfc+pSRRK3MQ
	k2zeT9oKZhNtdJnO1FuYWeS3v73yY3ZV3dMmj39ix/ZFM6Zl5V8+PfnzmfJzf+0wdS+ztnzd
	MaCbCoXjUnevcXk9iwfEtbXfbvX/YYQ9g+4m5epsblNeWrjfpd3vPhigYoq2XHfI5gwbvd5v
	Br5wBmKU+EFCRuCGdXlCWmx1j4JJV6uUcbQuXfUfaqoksVsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+5/rXE6OS+qkRbbogpYmZLxQaV/CQ2SEBIEEOfLQlpvGlqZB
	5XKJXSZL0pHXpTJlzqZTUquJTZyXylba0jArG9HIS5STVnaZUl9efjzPw/N8eQW42EyGC+SZ
	Z3lVplQhoYSE8PCegh1f1m6S7ax14eCbLyKg0mqhwHW3CYGlXYOBty8JXi1MI/j59BkOhlIX
	gjvv3+DQ7pxEYG+8TMGIJwRGfXMUDJZep6CgzkrB88+LGEyUlWDQZEuGt6aPBDzW12Jg8FJQ
	YSjAAucTBn6TmQZT/maYaiynYfF9HAxOuknorRokwf46Gm5XT1Dw0D5IgLNzCoOR+5UUTFr+
	kPDYOUDAQnEEuG7qSGieraXg84IJB5NvjoYXPUYMnMbV0KINtBZ++01Cv64Hg8L6VgxGxx8g
	6C56h4HN4qag1zeNQZutFIcfDX0IpopnaLhyw09DhaYYwfUrZQRoJ+Lh5/fActV8HGhqWgho
	/uVG+xM4S7UFcb3TczinbTvH/fC9pDj7gpHghmpZrqv8Dc1pu1/TnNGWzbU1RnF1D70Yd+er
	j+Rs5qsUZ/taQnPXZkYxbnZ4mD6yPlW4N51XyHN4VWxCmlBm9WjQmW9UrqGvnsxHQ+Q1FCRg
	mV3s5QY7scQUs5UdG/PjSxzGRLJtuo+BjFCAM+6V7KuqcbRkrGIOsI7C0uUQwWxmJ2rK6SUW
	MbtZjb/nX+kGtqmlZzkTFNB/NQwvD4iZeFZvbCL0SGhEK8woTJ6Zo5TKFfEx6gxZXqY8N+Zk
	ltKGAh9kurB4sxPNjyQ5ECNAkmDRgHejTExKc9R5SgdiBbgkTKTpCEiidGneeV6VdUKVreDV
	DhQhICRrRAeP8Wli5pT0LJ/B82d41X8XEwSF5yP979R2U/ktb/KlxKjCw+uiY501l7z60/7w
	6tlcQ0Ta+WxdjMTZkZOYmHroWKL4g67q+Qvr0ZHmRt/co/7pd7PbQlwplrCu7hXR/bonW+q0
	6SXe1j3WcJEnxRzyKfJil2dmLDT4+3aHMuvls+57Es96t5Ldl+FSBBc9uhVadjzKKiHUMmlc
	FK5SS/8CJQIgkj0DAAA=
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



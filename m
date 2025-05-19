Return-Path: <linux-fsdevel+bounces-49359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAFAABB918
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BE73BEA86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887E727AC2A;
	Mon, 19 May 2025 09:18:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EC3274FE5;
	Mon, 19 May 2025 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646338; cv=none; b=eVIWCny6MceHJqziLfLiTOdC5pJKHDZCjEXKGoqI96tplV03U2hYQmNpofhYSeRBk3PlS8VKLayLDNEx9DvWzzUHfcB7G1iRJmNTaAvTtncgKeoZLkecd6D4U0BQiCxt2LV9dtXV6EldUnVTdHJ324uTYKEAqxuQPLyZXYG1vpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646338; c=relaxed/simple;
	bh=TSPxdh3H9mjhA/wDLLlJUz6YZTY7hYg5ulgpaHBJJSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sDQySTOpztmCCAhbkOo8TgjHH6KuwYtNmz/LCdfcHxFHIhEMMGcRNfOUL0FfKfRILq6a/MazSejvtgBGo4f8Tk0VW59XKVzk6Chf3AD4d+wupFsfiqI/dqDyr0TnjQOh5BuAlXluJaGTGaY1DYyzRN9R9/Bk/UAl96RbT4c/1V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-04-682af76e7825
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
Subject: [PATCH v16 19/42] dept: apply timeout consideration to wait_for_completion()/complete()
Date: Mon, 19 May 2025 18:18:03 +0900
Message-Id: <20250519091826.19752-20-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+//P2Tln08VhRZ20iw3ENLoYGe+HkqAPHaIoib7YB1t5aiMv
	MS+1QHKlkVfSUslqTY01dOY6M7LLzDRXdtVcS0UtrUzxMrC20tTajL68PDwPz+/98jCEwiEJ
	YjRJqYI2SZWgpGSkbDywYl3yzwj1xqnWQPD8uEDCtToLBe23axBY6vUYRlp3wgfvGILfr98S
	UFbSjqBioI+Aekc/Arv5LAWdXxaC0+OmoK0kj4JzVXUUdIzOYOgtLcZQI+6Bj6YhEl5erMRQ
	NkLB1bJz2HeGMUyZqmkwZYbCoLmchpmBSGjrd0nA3rMWrhh6KXhkbyPB0TCIofPBNQr6LX8k
	8NLxnARvYTC0FxVIoHaikoJRr4kAk8dNw7smIwaHcQlYs3zA89/nJPCsoAnD+Zt3MDi7HyJo
	vPAJg2hxUdDiGcNgE0sImL7VimCwcJyG7PwpGq7qCxHkZZeSkNUbBb9/+T5f/xEJ+htWEmpn
	XWj7Nt5isCC+ZcxN8Fm2k/y05z3F271Gkn9RyfH3y/toPquxh+aNYhpvM0fwVY9GMF8x6ZHw
	YnUOxYuTxTSfO+7E/MSbN/S+5bGyrfFCgiZd0G6IPiRTW95doU8YZKdsOR04E31ichHDcOxm
	zjqgzEXSeTk6JEr8mmLDuK6uKcKvF7MhnK1gyOfLGIJ1BXAfrncjf7CIPcQZOovmCyQbyokd
	pdjPlLNbuIFmxT/mKq7G2jTPkfrsnryW+aqCjeKcNQbSz+TYKiknPniG/hWWcU/MXeRFJDei
	BdVIoUlKT1RpEjavV+uSNKfWH0lOFJFvXaaMmYMNaLJ9fzNiGaQMlFvt4WqFRJWeoktsRhxD
	KBfLq21r1Ap5vEp3WtAmx2nTEoSUZhTMkMql8k3ek/EK9pgqVTguCCcE7f8UM9KgTBQbvvqw
	d9eXrWnSHTHufPL157haz962zOBvsWxeE6rXBRTPXlas3DGR0U3VTR8N2vQiZHtMoSb12N0M
	PWbXxnUX6VRbYqJ1LUvw0+ez5FnnmbnaEfPchu+hwzeNjfl9rpBoMsx8qVGm/xqX8/iAbcHu
	M/vu4HuvJtThAdnqFe5yJZmiVkVGENoU1V8NdDtPWQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTZxjG/b5zpVpzUpkeNWbSBC8Ynajo6yXGRRNOjBBMNCaEZFQ9sQ1Q
	tFWUGZMi4LgIERQIIF3B2ZW2ju4UIypV0kYU3QTkoiCixQVFUKLSMhDFgvGfN0+eJ8/v/edh
	CUU1tYDVaI+KOq0qUUnLSFn05vSV2tEw9erqp2vAN5JFwsUaOw0tf9kQ2GvTMAzciYTH/iEE
	n/5tJqCkqAVBpfcZAbWNvQhcltM0tP03G9p9wzQ0FeXSkH6phobWwQkMPcWFGGxSFDw395Pw
	4FwVhpIBGspL0nHgvMYwZrYyYDaEQp+ljIEJbzg09XZS4KloosDVvQJKjT001LuaSGis68PQ
	duMiDb32SQoeNN4jwZ+/EFoK8ii48q6KhkG/mQCzb5iBRw0mDI2mueDICFDPfPxCwd28Bgxn
	/vgbQ3vXTQS3sl5gkOydNHh8QxicUhEB43/eQdCX/5aBzLNjDJSn5SPIzSwmIaMnAj79H/hc
	MRIOab87SLjyuRNt2yrYjXYkeIaGCSHDeVwY93XQgstvIoX7VbxwvewZI2Tc6mYEk3RMcFrC
	hEv1A1io/OCjBMmaTQvSh0JGyHnbjoV3Dx8yMYtiZVsOiomaFFH309Z4mdr+qJQ5bJSdcGa3
	YgN6weagIJbn1vGD/RI1pWluKf/kyRgxpYO5xbwzrz/gy1iC65zJP67oQlPBHC6eN7YVTBdI
	LpSXWotxDmJZObee97oV35g/8jZHwzQnKGB353qmqwougm+3GclzSGZCM6woWKNNSVJpEiNW
	6RPUqVrNiVUHkpMkFBiQ+dREQR0aaYt0I45Fyllyh2u5WkGpUvSpSW7Es4QyWG51LlMr5AdV
	qb+KuuRfdMcSRb0bLWRJ5Tz5zn1ivII7pDoqJojiYVH3PcVs0AIDWrZpXf755MKaNxEXdrv2
	xEVumNy7v2H/0sjcGPXaZsk72Xc1RRl9IXt+mOX9vgSP7zq+vKt0ZUz6yeNLro1vDvH2PG/2
	72Dj9vycudcw0WXtuH3q5a5ZaT+8ii3ZlHXPMWpYgyps9eWvopZb6o6ExFbH7e5oHY0e2DjP
	zWypDd1+9rd/lKRerQoPI3R61VdrWUlHPAMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to wait_for_completion()/complete().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/completion.h | 4 ++--
 kernel/sched/completion.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index bd2c207481d6..3200b741de28 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -41,9 +41,9 @@ do {							\
  */
 #define init_completion_map(x, m) init_completion(x)
 
-static inline void complete_acquire(struct completion *x)
+static inline void complete_acquire(struct completion *x, long timeout)
 {
-	sdt_might_sleep_start(&x->dmap);
+	sdt_might_sleep_start_timeout(&x->dmap, timeout);
 }
 
 static inline void complete_release(struct completion *x)
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 3561ab533dd4..499b1fee9dc1 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -110,7 +110,7 @@ __wait_for_common(struct completion *x,
 {
 	might_sleep();
 
-	complete_acquire(x);
+	complete_acquire(x, timeout);
 
 	raw_spin_lock_irq(&x->wait.lock);
 	timeout = do_wait_for_common(x, action, timeout, state);
-- 
2.17.1



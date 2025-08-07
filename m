Return-Path: <linux-fsdevel+bounces-56976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C590B1D79D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 14:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B437E0616
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 12:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC37B259CBC;
	Thu,  7 Aug 2025 12:14:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34C7248F70;
	Thu,  7 Aug 2025 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754568896; cv=none; b=TLt0aY47UbjOK3rJxqK05mRNYp7lXDZATSM9TBj3TuIwGXufbkm5MA64ZW4EEVPLMuczo3UGCYw8VW5HCLMn0C4OQZdtVBSGzQ2efcNOtiG817o7h09pl/3CMXxeVui3FJIY1RccUQnRRLEArk5V9AAm1Aw5JcakYektN/o8qOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754568896; c=relaxed/simple;
	bh=skg7Gh50I2yTJaxeatlW2LApBTmyDPXHk6dT0btuKa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sMGNep/t//Z05TCUy2A79aiDr0Dqu4zUJ+1F9yQTm2AoxlhgdVET7nXhdpTYkgkyiSw91uHNGBD9nLc/ET+qOpHWHpk5rEgMxO91zZ+TGuDOrWFiBXnYIccjSXbmk1FkHg3FXd6N79yck+VsEDBNUy15X18FWHMoLJBcctVzoLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1c51a676738811f0b29709d653e92f7d-20250807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:1cdd2b89-b372-4194-b9aa-70d3449c1a06,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:d3db5b041da0d758e8aa142411b5b99e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1c51a676738811f0b29709d653e92f7d-20250807
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1097566653; Thu, 07 Aug 2025 20:14:47 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 1CB2CE01A758;
	Thu,  7 Aug 2025 20:14:47 +0800 (CST)
X-ns-mid: postfix-689498B6-91481065
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id A4A8AE0000B0;
	Thu,  7 Aug 2025 20:14:43 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	len brown <len.brown@intel.com>,
	pavel machek <pavel@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Nico Pache <npache@redhat.com>,
	xu xin <xu.xin16@zte.com.cn>,
	wangfushuai <wangfushuai@baidu.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	linux-pm@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [RFC PATCH v1 3/9] freezer: Add per-priority layered freeze logic
Date: Thu,  7 Aug 2025 20:14:12 +0800
Message-Id: <20250807121418.139765-4-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250807121418.139765-1-zhangzihuan@kylinos.cn>
References: <20250807121418.139765-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current freezer traverses all user tasks in a single pass, without
distinguishing between tasks that are easier or harder to freeze. This
uniform treatment may cause suboptimal behavior when certain newly create=
d
tasks, service daemons, or system threads block the progress of freeze du=
e
to dependency ordering issues.

This patch introduces a simple multi-pass traversal model in
try_to_freeze_tasks(), where user tasks are grouped and frozen by their
freeze_priority in descending order. Tasks marked with higher priority
are attempted earlier, which can help break dependency cycles earlier
and reduce retry iterations.

Specifically:
 - A new loop iterates over priority levels.
 - In each round, only tasks with freeze_priority < current priority are =
visited.
 - The behavior applies only to user task freezing (when user_only =3D=3D=
 true).

This approach preserves compatibility with the current logic, while enabl=
ing
fine-grained control via future enhancements (e.g., dynamic priority tuni=
ng).

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 kernel/power/process.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index dc0dfc349f22..06eafdb32abb 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -32,10 +32,12 @@ static int try_to_freeze_tasks(bool user_only)
 	struct task_struct *g, *p;
 	unsigned long end_time;
 	unsigned int todo;
+	unsigned int round =3D 0;
 	bool wq_busy =3D false;
 	ktime_t start, end, elapsed;
 	unsigned int elapsed_msecs;
 	bool wakeup =3D false;
+	bool has_freezable_task;
 	int sleep_usecs =3D USEC_PER_MSEC;
=20
 	pr_info("Freezing %s\n", what);
@@ -47,13 +49,18 @@ static int try_to_freeze_tasks(bool user_only)
 	if (!user_only)
 		freeze_workqueues_begin();
=20
-	while (true) {
+	while (round < FREEZE_PRIORITY_NEVER) {
 		todo =3D 0;
+		has_freezable_task =3D false;
 		read_lock(&tasklist_lock);
 		for_each_process_thread(g, p) {
+			if (user_only && !(p->flags & PF_KTHREAD) && round < p->freeze_priori=
ty)
+				continue;
+
 			if (p =3D=3D current || !freeze_task(p))
 				continue;
=20
+			has_freezable_task =3D true;
 			todo++;
 		}
 		read_unlock(&tasklist_lock);
@@ -63,6 +70,12 @@ static int try_to_freeze_tasks(bool user_only)
 			todo +=3D wq_busy;
 		}
=20
+		round++;
+
+		/* sleep only if need to freeze tasks */
+		if (user_only && !has_freezable_task)
+			continue;
+
 		if (!todo || time_after(jiffies, end_time))
 			break;
=20
--=20
2.25.1



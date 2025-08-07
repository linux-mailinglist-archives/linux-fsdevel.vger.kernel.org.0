Return-Path: <linux-fsdevel+bounces-56979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D579FB1D79F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 14:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE089584FD4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 12:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C6825BEF8;
	Thu,  7 Aug 2025 12:15:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E59325392D;
	Thu,  7 Aug 2025 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754568908; cv=none; b=qZ0ebwcM2XQzGaSOP4ApS/GsKDoJkLr/7xGUrGFk30YXdkVUbiPuv6AFiiqIWl8yxz1RJjlMbX0Xzh5MVHuqg/KJLkS3STe5vr2f8ChZEv8KXmbZSe31hGEdxWwGz3W4GiD7l+idLxlRLeOVTD49ZCBgyED6vsJOW9KSYM2drJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754568908; c=relaxed/simple;
	bh=3GeUnTuI9VYv4J8qHSrp9VCfqL9y2LFf0Fxsh01NN9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dzOLOmBG9UWNUhayiiAbqgHr8st0/++qX5cqXjq0xhxzWn+2EaBbG6iPIhbbxoxV/f6bK4uF2enSL/aedlEf2CPCFdPnfNSjDorwBeDI6VwugfY1gySqFRjw8NYh1GcYK0iVVO6sJSwJvUCIeB6dPmARMa4i1Yabusvx6yLI+vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 24704682738811f0b29709d653e92f7d-20250807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:1d12fb1f-37f4-4fb7-923e-1f3c2fe62e61,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:12a84b3772c0745d9275fc58a33b6108,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 24704682738811f0b29709d653e92f7d-20250807
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1815612336; Thu, 07 Aug 2025 20:15:01 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id E676AE01A758;
	Thu,  7 Aug 2025 20:15:00 +0800 (CST)
X-ns-mid: postfix-689498C3-49482168
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 3D9FFE0000B0;
	Thu,  7 Aug 2025 20:14:56 +0800 (CST)
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
Subject: [RFC PATCH v1 6/9] freezer: Set default freeze priority for zombie tasks
Date: Thu,  7 Aug 2025 20:14:15 +0800
Message-Id: <20250807121418.139765-7-zhangzihuan@kylinos.cn>
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

Zombie processes are not subject to freezing, but they are still part of
the global task list. During freeze traversal, tasks are examined for
priority and eligibility, which may involve unnecessary locking even for
non-freezable tasks like zombies.

This patch assigns a default freeze priority to zombie tasks during exit,
so that the freezer can skip priority setup and locking for them in
subsequent iterations.

This helps reduce overhead during freeze traversal, especially when many
zombie processes exist in the system.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be00629f0ba4..5a26d7511047 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -42,6 +42,7 @@
 #include <linux/context_tracking.h>
 #include <linux/cpuset.h>
 #include <linux/delayacct.h>
+#include <linux/freezer.h>
 #include <linux/init_task.h>
 #include <linux/interrupt.h>
 #include <linux/ioprio.h>
@@ -6980,6 +6981,7 @@ void __noreturn do_task_dead(void)
 	current->flags |=3D PF_NOFREEZE;
=20
 	__schedule(SM_NONE);
+	freeze_set_default_priority(current, FREEZE_PRIORITY_NEVER);
 	BUG();
=20
 	/* Avoid "noreturn function does return" - but don't continue if BUG() =
is a NOP: */
--=20
2.25.1



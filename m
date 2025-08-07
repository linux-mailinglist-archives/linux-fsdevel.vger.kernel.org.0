Return-Path: <linux-fsdevel+bounces-56974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C41B1D78E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 14:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8246A3BFF8C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 12:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF702566D1;
	Thu,  7 Aug 2025 12:14:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2BB24DCF7;
	Thu,  7 Aug 2025 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754568884; cv=none; b=SbD2CkFHkK9ZnXVmE6ea+0HkEt6Gc6FmvXqqdBR6xLKbvF6WMaeyF+HpelhnwnQLoGPT/+Xs0Jp01MIwul4JbVx26vEFe/5+SIqQiBRtDk6bv4g4MrYwwQBXqyOApTvAlxSdx7rIwLD+1rKuI6Fjnjq0SUL4BLNdk/LA/zC0q1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754568884; c=relaxed/simple;
	bh=gRVc2fe+3PNVteons7idTWlBfHRJwpmfsetmM1+rzHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M9V/KxN841QD8yNAvrnWAwhr7dizkwM+NlUoZvSTDcAZH4LAlPHwZ51RuXPDZLDxC1Oz82zfrkbEAZE7HkTudJNMRv02BVLUFWKEUR2S68AjjTw1QplEPCT6+eX1NVZl4MBo3QVGr97yRITVSGMCCv5Vu6Q5SU6lrovFW736IcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 14f1d57c738811f0b29709d653e92f7d-20250807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:bddde5a2-6be7-407d-9019-230d29b98340,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:ac141f20124bc38f4d6b4969aa6a8eef,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 14f1d57c738811f0b29709d653e92f7d-20250807
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 351858400; Thu, 07 Aug 2025 20:14:35 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id E6B70E01A758;
	Thu,  7 Aug 2025 20:14:34 +0800 (CST)
X-ns-mid: postfix-689498AA-78502062
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 39E6CE0000B0;
	Thu,  7 Aug 2025 20:14:31 +0800 (CST)
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
Subject: [RFC PATCH v1 1/9] freezer: Introduce freeze_priority field in task_struct
Date: Thu,  7 Aug 2025 20:14:10 +0800
Message-Id: <20250807121418.139765-2-zhangzihuan@kylinos.cn>
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

To improve the flexibility and correctness of the freezer subsystem,
we introduce a new field `freeze_priority` in `task_struct`.

This field will allow us to assign different freezing priorities to
tasks, enabling prioritized traversal in future changes. This is
particularly useful when dealing with complex inter-process dependencies
in modern userspace workloads (e.g., service managers, IPC daemons).

Although this patch does not change behavior yet, it provides the
necessary infrastructure for upcoming logic to address issues like
dependency stalls and D-state hangs. It also helps avoid potential
race conditions by paving the way for deterministic freezing order.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 include/linux/freezer.h | 7 +++++++
 include/linux/sched.h   | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index b303472255be..6314f8b68035 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -16,6 +16,13 @@ DECLARE_STATIC_KEY_FALSE(freezer_active);
 extern bool pm_freezing;		/* PM freezing in effect */
 extern bool pm_nosig_freezing;		/* PM nosig freezing in effect */
=20
+enum freeze_priority {
+	FREEZE_PRIORITY_HIGH		=3D 0,
+	FREEZE_PRIORITY_NORMAL		=3D 1,
+	FREEZE_PRIORITY_LOW		=3D 2,
+	FREEZE_PRIORITY_NEVER		=3D 4
+};
+
 /*
  * Timeout for stopping processes
  */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2b272382673d..7915e6214e50 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -910,6 +910,9 @@ struct task_struct {
 	unsigned int			btrace_seq;
 #endif
=20
+#ifdef CONFIG_FREEZER
+	unsigned int			freeze_priority;
+#endif
 	unsigned int			policy;
 	unsigned long			max_allowed_capacity;
 	int				nr_cpus_allowed;
--=20
2.25.1



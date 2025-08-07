Return-Path: <linux-fsdevel+bounces-56975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC71B1D78A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 14:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 968337A6B32
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 12:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AA4257AC8;
	Thu,  7 Aug 2025 12:14:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4F024679F;
	Thu,  7 Aug 2025 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754568891; cv=none; b=esXoVnuyVEzfkZIzGRlJbR+bJztT8UtxxWxxib0zbmSAUB6OwZzCMiE6VJpzqYf/tHLbmP0OyjQXNx/X0HDSA56qQu4Z4MfMrswEeLkO3Bb8ItZm/yVMLa6LCKAznl0E95JDMeeAbq35zwIsvP3OmxKKg0wQwtPScmXnAvN/d+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754568891; c=relaxed/simple;
	bh=j07iyAToycsE4btEpeudiPUxo8gvKtTEhxlqrACMHkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XaDYY3czxU5Ut3pfxYIyeJJP2dIXyRorXxMDffQHzYZ3pbpXpod3UY6DP3ghXHI3fIRZcVtSSzXDeubJkMee/BcE06KLkspxKSy9EMTEZaN8pokcBnvnKr+h/WwnGSHoAzK2YASt/liskEME3r72/pJoudy7uOL5cLdJyFK050o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 19c82fb0738811f0b29709d653e92f7d-20250807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:322cbd87-c348-47e9-af03-2fa2b18264f3,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:0af04b9c10a64e090692712e5936fd26,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:1,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 19c82fb0738811f0b29709d653e92f7d-20250807
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1586284648; Thu, 07 Aug 2025 20:14:43 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 0D4FAE01A759;
	Thu,  7 Aug 2025 20:14:43 +0800 (CST)
X-ns-mid: postfix-689498AF-52865563
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id D10C1E0000B0;
	Thu,  7 Aug 2025 20:14:35 +0800 (CST)
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
Subject: [RFC PATCH v1 2/9] freezer: Introduce API to set per-task freeze priority
Date: Thu,  7 Aug 2025 20:14:11 +0800
Message-Id: <20250807121418.139765-3-zhangzihuan@kylinos.cn>
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

This patch introduces the basic API for setting freeze priority on a per-=
task basis.
The actual usage and policy for assigning specific priorities will be add=
ed in
subsequent patches.

This change lays the groundwork for implementing a more flexible and
dependency-aware freezer model.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 include/linux/freezer.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index 6314f8b68035..f231a60c3120 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -46,6 +46,18 @@ static inline bool freezing(struct task_struct *p)
 	return false;
 }
=20
+static inline bool freeze_set_default_priority(struct task_struct *p, un=
signed int prio)
+{
+	if ((p->flags & PF_KTHREAD) || prio > FREEZE_PRIORITY_NEVER)
+		return false;
+
+	p->freeze_priority =3D prio;
+
+	pr_debug("set default freeze priority for comm:%s pid:%d prio:%d\n",
+		 p->comm, p->pid, p->freeze_priority);
+	return true;
+}
+
 /* Takes and releases task alloc lock using task_lock() */
 extern void __thaw_task(struct task_struct *t);
=20
@@ -80,6 +92,7 @@ static inline bool cgroup_freezing(struct task_struct *=
task)
 #else /* !CONFIG_FREEZER */
 static inline bool frozen(struct task_struct *p) { return false; }
 static inline bool freezing(struct task_struct *p) { return false; }
+static inline bool freeze_set_default_priority(struct task_struct *p, un=
signed int prio) {}
 static inline void __thaw_task(struct task_struct *t) {}
=20
 static inline bool __refrigerator(bool check_kthr_stop) { return false; =
}
--=20
2.25.1



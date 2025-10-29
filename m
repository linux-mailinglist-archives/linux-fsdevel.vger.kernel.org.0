Return-Path: <linux-fsdevel+bounces-66379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD31C1D893
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 22:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDFA14E49E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 21:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A51931A563;
	Wed, 29 Oct 2025 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5l5trJE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D503148AC
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761774995; cv=none; b=iftTsQCDmvdxBz2LgheQgibj1eoESz+7niQ2VYtwWY+wt8YngOijlaU3KLLh/WNDG5d34gOmkGytyhFAjGLw4rgQ9WT8Vb+li5/kHi+u1dvh725RMRrajIFxuTwoJlRe2ucyoOkU0VZ5cMv+yfdgGLUT7AgxdsRu8HkvgXPS9kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761774995; c=relaxed/simple;
	bh=YG+OCyXAx1DocZpNMS6gi5m+fDdTlk1ofhG87v5IIig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJWr37qhkSky/zfwq+tPBaFMOdynPG1fL08mS38qj8xgtfjhH+gk9moP+5kWQIfmKWDhU7u4uUFyV6wk7YArUG8l6B8pfjKro5SRle7mvMDo5jMjglsN00/omGad9F2GK7/gUQwiPq17Jcl54zfTChWlBJ9feXqhcUSzPnBouSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h5l5trJE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761774992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INsiWkY7BmAeJ2Lt+5y778Nm9jHs2zNAVbEZhuTQT9Y=;
	b=h5l5trJEu+dnihq3yChWxpPKRBSP2ak94yjE41CWOmBpCFsENOtcUAMzzU4oo2kEqek1Am
	GzZeqmm+9JKuPE7FQyfbfw7DSUNIyX+FHVd4ITRWeTyifWQCQ3DI17vAwEbb9GZ1sboc23
	1g5wQkSy+vd3U4ZxR2evdsyUnSZkI2I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575--lts_nf-OlqaLFw5pKVUAg-1; Wed,
 29 Oct 2025 17:56:28 -0400
X-MC-Unique: -lts_nf-OlqaLFw5pKVUAg-1
X-Mimecast-MFC-AGG-ID: -lts_nf-OlqaLFw5pKVUAg_1761774986
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 801881800D8F;
	Wed, 29 Oct 2025 21:56:25 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.105])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E22BB19560AD;
	Wed, 29 Oct 2025 21:56:21 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Nico Pache <npache@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	John Coleman <jocolema@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/2] fs/proc: Show the content of task->user_cpus_ptr in /proc/<pid>/status
Date: Wed, 29 Oct 2025 17:55:55 -0400
Message-ID: <20251029215555.1006595-3-longman@redhat.com>
In-Reply-To: <20251029215555.1006595-1-longman@redhat.com>
References: <20251029215555.1006595-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The task->user_cpus_ptr was introduced by commit b90ca8badbd1 ("sched:
Introduce task_struct::user_cpus_ptr to track requested affinity") to
keep track of user-requested CPU affinity. With commit da019032819a
("sched: Enforce user requested affinity"), user_cpus_ptr will
persistently affect how cpus_allowed will be set.

As child processes inherit the user_cpus_ptr setting from its parent,
they may not know that their user_cpus_ptr may be set changing their
CPU affinity in an unexpected way. Currently there is not an easy way
to figure out if their user_cpus_ptr is set even if they have never
called sched_setaffinity(2) themselves. So it makes sense to enable
users to see the presence of a previously set user_cpus_ptr so they
can do something about it without getting a surprise.

Add new "Cpus_user" and "Cpus_user_list" fields to /proc/<pid>/status
output via task_cpus_allowed() as the presence of user_cpus_ptr will
affect their cpus_allowed cpumask. The new fields will be empty if
user_cpus_ptr isn't set.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/filesystems/proc.rst | 3 +++
 fs/proc/array.c                    | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 0b86a8022fa1..4317c79a530f 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -291,6 +291,9 @@ It's slow but very precise.
  SpeculationIndirectBranch   indirect branch speculation mode
  Cpus_allowed                mask of CPUs on which this process may run
  Cpus_allowed_list           Same as previous, but in "list format"
+ Cpus_user                   mask of user requested CPUs from
+                             sched_setaffinity(2), empty if not defined
+ Cpus_user_list              Same as previous, but in "list format"
  Mems_allowed                mask of memory nodes allowed to this process
  Mems_allowed_list           Same as previous, but in "list format"
  voluntary_ctxt_switches     number of voluntary context switches
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 2ae63189091e..17e700556daa 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -403,10 +403,19 @@ static inline void task_context_switch_counts(struct seq_file *m,
 
 static void task_cpus_allowed(struct seq_file *m, struct task_struct *task)
 {
+	cpumask_t *user_cpus = task->user_cpus_ptr;
+
 	seq_printf(m, "Cpus_allowed:\t%*pb\n",
 		   cpumask_pr_args(&task->cpus_mask));
 	seq_printf(m, "Cpus_allowed_list:\t%*pbl\n",
 		   cpumask_pr_args(&task->cpus_mask));
+
+	if (user_cpus) {
+		seq_printf(m, "Cpus_user:\t%*pb\n", cpumask_pr_args(user_cpus));
+		seq_printf(m, "Cpus_user_list:\t%*pbl\n", cpumask_pr_args(user_cpus));
+	} else {
+		seq_puts(m, "Cpus_user:\nCpus_user_list:\n");
+	}
 }
 
 static inline void task_core_dumping(struct seq_file *m, struct task_struct *task)
-- 
2.51.0



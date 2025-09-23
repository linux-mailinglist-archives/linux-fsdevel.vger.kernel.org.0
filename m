Return-Path: <linux-fsdevel+bounces-62517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B407B9721C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 19:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A667C19C5BA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 17:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8360A2DF155;
	Tue, 23 Sep 2025 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6TttM47"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC1E2DF126
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650112; cv=none; b=AFJ29DW3HzrkOwMpgoVqhvC18gZzL5AoBVq9uG0pPiNkgft0fT9TNMyTuhLzAfcmEarn7bqRT0pTkqkTstUAkKSjtcyVHAco/OTHaKDZrCkCpKV7jABTmZ1p5/qwHtxMC90lnm0uZFwfLgbt10Nyi0MedLnknrXl6P/68hz9E0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650112; c=relaxed/simple;
	bh=OOv8D4S4daNqwl3E/EMT55ZkCdNav8iq00JBI+SPh9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qut+SNcXkGjhYFFrE8eutk3OPB1RSpHnoPfiBOgVfxCASDgCh7DVs3USvjM/iLsqi3+UkTnBFDhRgdYyLTT/VCGzU4ZAxFfTdyJSyOXeu5soqfWQ4RXqKiI0a71YJv2w8bazTpZgW9qwiWZtgXWp4XzcT3/FY8xOALamnFooYic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J6TttM47; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758650110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ip150q/jg/OC8vs7auZBSRpRPZ/5ZbR1ifScO9CYqkQ=;
	b=J6TttM47tnnzFSp8BdS4M0PSdjKXw5SyzXIvTafGnzk/wzISCwx6EImlbfVGwk9Mb5d1ky
	/Quw6SL6aXNLzX37yBo0ica2QY8FpF2aZEl9WwpXIRaDqf5aXypujgECiZHPgljea4D1pE
	gCOPUKzLEPd/3agl2pQzMUSdMkOgJgE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-c2A6RXqLNOOXqYjUDgFVXg-1; Tue,
 23 Sep 2025 13:55:06 -0400
X-MC-Unique: c2A6RXqLNOOXqYjUDgFVXg-1
X-Mimecast-MFC-AGG-ID: c2A6RXqLNOOXqYjUDgFVXg_1758650105
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C97F19560B2;
	Tue, 23 Sep 2025 17:55:04 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.189])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A16A6300018D;
	Tue, 23 Sep 2025 17:54:59 +0000 (UTC)
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
Subject: [PATCH 1/2] sched/core: Enable full cpumask to clear user cpumask in sched_setaffinity()
Date: Tue, 23 Sep 2025 13:54:46 -0400
Message-ID: <20250923175447.116782-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
cpumask"), user provided CPU affinity via sched_setaffinity(2) is
perserved even if the task is being moved to a different cpuset.
However, that affinity is also being inherited by any subsequently
created child processes which may not want or be aware of that affinity.

One way to solve this problem is to provide a way to back off from
that user provided CPU affinity.  This patch implements such a scheme
by using a full cpumask (a cpumask with all bits set) to signal the
clearing of the user cpumask to follow the default as allowed by
the current cpuset.  In fact, with a full cpumask in user_cpus_ptr,
the task behavior should be the same as with a NULL user_cpus_ptr.
This patch just formalizes it without causing any incompatibility and
discard an otherwise useless cpumask.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/syscalls.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 77ae87f36e84..d68c7a4ee525 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -1229,14 +1229,22 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 		return retval;
 
 	/*
-	 * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
-	 * alloc_user_cpus_ptr() returns NULL.
+	 * If a full cpumask is passed in, clear user_cpus_ptr and reset the
+	 * current cpu affinity to the default for the current cpuset.
 	 */
-	user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
-	if (user_mask) {
-		cpumask_copy(user_mask, in_mask);
+	if (cpumask_full(in_mask)) {
+		user_mask = NULL;
 	} else {
-		return -ENOMEM;
+		/*
+		 * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
+		 * alloc_user_cpus_ptr() returns NULL.
+		 */
+		user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
+		if (user_mask) {
+			cpumask_copy(user_mask, in_mask);
+		} else {
+			return -ENOMEM;
+		}
 	}
 
 	ac = (struct affinity_context){
-- 
2.51.0



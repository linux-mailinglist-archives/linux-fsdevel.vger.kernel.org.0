Return-Path: <linux-fsdevel+bounces-60795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA97B51A30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE6E1891B49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F713629B5;
	Wed, 10 Sep 2025 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnpkegUG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CB9246774;
	Wed, 10 Sep 2025 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515152; cv=none; b=pW6e/gSIN6Osgus2GF8eeAI/Pks0eSiSPeSBfA60h9XE3plhMzZLXcKDArA0NNemqGNEY+oUDpwQ4A9XM9IswrDVw99RGmFrBvgaTCYhjgtRYlEhHL94gObnypi8iNajSlBactOAD6k4LbNvFRNc3Ej1GfihhEjODIKJNOKpDfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515152; c=relaxed/simple;
	bh=0dDnDj24i/MfTfri3RDCElEpJVNXM5ePPuTvy2KpYKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ngjgRg+91mvNXVLm79Fp7AswUnhWRBX41+MSIIrPhNBcsYLARlOOlIHeAnSCy6q2kgW8zkQwL/WiJEP7dklH5ir2s4QlVOC1nrTKQG5c2USwYJHiL9NIWLtTDy5WR2nnwAZlv1BpRANaEQhVYUVZYqLWP2dFYN36+eCQbV1s5+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnpkegUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C85C4CEEB;
	Wed, 10 Sep 2025 14:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515151;
	bh=0dDnDj24i/MfTfri3RDCElEpJVNXM5ePPuTvy2KpYKw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MnpkegUGxO1vBgAdFeYyhSsrw6WMs4xZKi9nh5Zz1O1xhA/kNk6t/Oz8wFZoYaTCC
	 FsL8MRdyinzyIwB8aH0bD/cWXVWv5VpOWuzRejbTmrkB7bjg57y4jVPYL1T5aMAw/H
	 lJRRt2KXaWGA1FgLvSDIqFlZlEvbE8dyUN9BE93u9Ub/mVy6ySxBndeZ66wAAb3W3d
	 /dZzPpKrhVKGrroVV26z7DK3Edayhu+idNZSuv+TDWN1h1N5jXh4CKb2Nwyi2uo3+0
	 orrp6rVK0A2FCpRr2lc/pfZmMcx2RGlZY+3yxaYfSbPAgemSk/SNUuPWERYUN1Y5mU
	 +e8pr0aDZ+pcg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:37:06 +0200
Subject: [PATCH 21/32] pid: support iterator
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-21-4dd56e7359d8@kernel.org>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
In-Reply-To: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=1243; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0dDnDj24i/MfTfri3RDCElEpJVNXM5ePPuTvy2KpYKw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7OVor/r77utiEc4rArO39PmXXN92fWsco40155W3b
 3qW7ONY31HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR/l8Mf3gq2bhKV7ksCUte
 a/bqhmlFVklnNfOaxD+pP5nyZT4rsDH897UTYDKfXDJf+FFxca7Czc8hzHm1alM+doRydniuaGp
 jAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Support the generic namespace iterator and lookup infrastructure to
support file handles for namespaces.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/pid_namespace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 20ce4052d1c5..228ae20299f9 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -23,6 +23,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/signal.h>
 #include <linux/idr.h>
+#include <linux/nstree.h>
 #include <uapi/linux/wait.h>
 #include "pid_sysctl.h"
 
@@ -122,6 +123,7 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 	ns->memfd_noexec_scope = pidns_memfd_noexec_scope(parent_pid_ns);
 #endif
 
+	ns_tree_add(ns);
 	return ns;
 
 out_free_inum:
@@ -147,6 +149,7 @@ static void delayed_free_pidns(struct rcu_head *p)
 
 static void destroy_pid_namespace(struct pid_namespace *ns)
 {
+	ns_tree_remove(ns);
 	unregister_pidns_sysctls(ns);
 
 	ns_free_inum(&ns->ns);
@@ -473,6 +476,7 @@ static __init int pid_namespaces_init(void)
 #endif
 
 	register_pid_ns_sysctl_table_vm();
+	ns_tree_add(&init_pid_ns);
 	return 0;
 }
 

-- 
2.47.3



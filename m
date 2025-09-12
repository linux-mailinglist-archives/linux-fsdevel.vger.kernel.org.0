Return-Path: <linux-fsdevel+bounces-61067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7331EB54C5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD82AA36A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86702320A15;
	Fri, 12 Sep 2025 11:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD4mlnij"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE7305E18;
	Fri, 12 Sep 2025 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678108; cv=none; b=mDJt6NQqiIpac1IRwigKJsyWZbJ6R4x8UBIBCuj9zgaHGavtd73senQzDaHjOmfk2pMOB6bt3aSnYkdsgad+fhyGu4UcDVKclarmnGgaKZ2dUc76LNAdk/HLQ6XSJy/vIwT3ngymHiumXpr0a94i756kpCAT8N5tQjh3veJ0Ow8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678108; c=relaxed/simple;
	bh=gCV2nPR4wp5zQpsyw5ngD+ZgtV06MuY9BtDbhAzkVgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o+VYB100LbOATlUJDgekutpc1EFEKlmdLnQfkdaOsHgjnKme3l/V8RC+Dlykm3rPqXGFap7df4JFol0+Qr9CTEDbhRrAEM9QlGglV+aixyncEB9PbuL4849RPVuJcKJTOk7dTrMIDm7rZlgyFvuoPs0w6I0nDRfdPR+bOQCyDPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JD4mlnij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50DCC4CEF4;
	Fri, 12 Sep 2025 11:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678108;
	bh=gCV2nPR4wp5zQpsyw5ngD+ZgtV06MuY9BtDbhAzkVgE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JD4mlnijy85fybGP4zk8zjGK33858wpp0SpS7Kkqycfm2RaAu1Tf/rfbRTiyDQ2/s
	 5v4zlcTAntHqvDESMl7TdgUWNYh3BQ/zxYXsF5OGGerMhYlYr3dNo+qW/2nI34iNjw
	 BjNBo2gXhYmmDu0xD1eckTYat8LrzlopiCxhA0J+UzH+vMi2lZfVa9N/uByx0YT8Lc
	 21HtRAuglPTYKSXVkgdSDfQvidaHGT2J5+5tfHekjZjca4iMA1eEH7eQqUNAO/tXO/
	 MTu5FerX/H2QfjXJ7rbYkCL3bxVJ+3IYqMbmpktvtbHhrr9oDfEdjURfgs3EuLockt
	 yRLi6EQrqaJiQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:45 +0200
Subject: [PATCH v2 22/33] pid: support ns lookup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-22-1a247645cef5@kernel.org>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
In-Reply-To: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gCV2nPR4wp5zQpsyw5ngD+ZgtV06MuY9BtDbhAzkVgE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4Zyq9f/1avs6hh27p+Td0X29q/BnTvOsK6eeLVgYJ
 OjH9t/aqaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiUywZ/ntVrbp6o3PSitBf
 DLpWD7lt7yrK/BHIji0XlzyyveD22k6G//Gb9b88aFny//MngfQ7k+278i903tbbX6W4uUHz3K3
 rq9kB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Support the generic ns lookup infrastructure to support file handles for
namespaces.

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



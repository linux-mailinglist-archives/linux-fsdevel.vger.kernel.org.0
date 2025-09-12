Return-Path: <linux-fsdevel+bounces-61057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA1FB54BEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 13:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470B9586CE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 11:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB4C30E859;
	Fri, 12 Sep 2025 11:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJXxV/aH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D1B3043BD;
	Fri, 12 Sep 2025 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678050; cv=none; b=EdIBE4BtgO24OBd+wRNSxXiJIDt0pGOOw/26j+je4mERwoX/7B/D99he6xLpagV6pj9JxPJlHBFx1SVR2nCSA+VbwZWLn3UwEtVYaGN7ZHP/ObEhtmgUXNNmz+86I+/hmZUpb7OnYfEgLiMqgRSWP+wKNxMVSJQA9oNkGXkrj3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678050; c=relaxed/simple;
	bh=MItWr6NaY/GZBLy5jihnYjwfnovy3A1O3ubCIr9NSos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZFu/BHi8R7DphDd7OKTvPRCx7dWoSOszDVxW0WBnSRNyb+mT67hcmDJFM1yxvc9W+Kgsawu8mNR+iJM2A2CQh3Kw+zg2w8oVbZ1CygRWsOleJwdVFypp0abC4Fvs/Weo32L+cQmj9Knnrs2KDR/ly45iiCNeUE8jmJyeqYzVSnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJXxV/aH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68625C4CEF9;
	Fri, 12 Sep 2025 11:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678049;
	bh=MItWr6NaY/GZBLy5jihnYjwfnovy3A1O3ubCIr9NSos=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZJXxV/aHc1cQla5gW9uIP5IALj/2CNcdOyRPyN8ZaOWqOqRPuLX9efUAnA5kiwHoZ
	 gUCU4JOItMb+aRaniDIIi8y5VFQILUIuOwKnQqGTZLJ84x2rJ3IDSDcOGZ5KoNhtzJ
	 Lv9Hrv/tOqwUHfmioMRQiNdiPV9Hl5S9F1caw6owBroYLdxu3yBWgNY5WHaOZLzgWG
	 mzIf91bkY78YIzk+J8nmemF8Wm7gi0KgYcOPQLNHWA7WGQfMsrPpAckuSv/8tsFmma
	 AxACKcjz0SoOQqO0PBA1HUBxVx2rKySfm3yXegoQ47LqGZu7fA3FzvvFnAPAgy3sWM
	 oGkSn95MsrY8A==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:35 +0200
Subject: [PATCH v2 12/33] pid: use ns_common_init()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-12-1a247645cef5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=984; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MItWr6NaY/GZBLy5jihnYjwfnovy3A1O3ubCIr9NSos=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4ZwiNoV9y+1thXMXBm1Y4MR2fWH+XIN9s7O8bkaGS
 hzjfiZzpKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi6oGMDDtYCh5WWE8suFgQ
 Gc6QKcy3qyuGny2P6xDLVutdrl+Pf2f4H7tx0d8uwTMbWowyPkTuLNpoN429RDvc2LpGOVzUwpu
 fHQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't cargo-cult the same thing over and over.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/pid_namespace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 7098ed44e717..20ce4052d1c5 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -102,17 +102,15 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 	if (ns->pid_cachep == NULL)
 		goto out_free_idr;
 
-	err = ns_alloc_inum(&ns->ns);
+	err = ns_common_init(&ns->ns, &pidns_operations, true);
 	if (err)
 		goto out_free_idr;
-	ns->ns.ops = &pidns_operations;
 
 	ns->pid_max = PID_MAX_LIMIT;
 	err = register_pidns_sysctls(ns);
 	if (err)
 		goto out_free_inum;
 
-	refcount_set(&ns->ns.count, 1);
 	ns->level = level;
 	ns->parent = get_pid_ns(parent_pid_ns);
 	ns->user_ns = get_user_ns(user_ns);

-- 
2.47.3



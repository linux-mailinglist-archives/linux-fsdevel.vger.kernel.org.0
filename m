Return-Path: <linux-fsdevel+bounces-60787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A4BB51A01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB68A02E1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D414D350D77;
	Wed, 10 Sep 2025 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoA1MDpk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C723314D4;
	Wed, 10 Sep 2025 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515104; cv=none; b=kMThdHKI+VJjcG9uOHjnEgWxcJFO25EpWH0GUKd4ovIo2j2E1o0iwhR2NsjVr4J6aQ47Os+0X1kdGXeZWJQxBmUstrLSP9KpdSMHR0eTt1QgDskLio8gLlmnrnHT/+2YyCZlQzfBFkvXyV5E2SaIIweAcHcEu9B7h7Clgsr2vxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515104; c=relaxed/simple;
	bh=2Pb+C09AD3Ch8zyPOBqZ4ir9gSxZa2YXPjiwgVDz5cU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gzO98m7l3ioVIa9v3uxyYNiE7Vnt7+ZE3eL2aCWeiAGcWtyaKJQuAYNO+kxGMsqK9OheHtjLx2Tii3X+DeUSmZf/jsoyjPAzj9W14vJ9HTR1mxX0DVI1MK9VQ1Ec5syCWQCgYVigWu8vBTgwXxuNaoDYodxjXSapbpT5U3v2O7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoA1MDpk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9CDC4CEEB;
	Wed, 10 Sep 2025 14:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515103;
	bh=2Pb+C09AD3Ch8zyPOBqZ4ir9gSxZa2YXPjiwgVDz5cU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RoA1MDpk9S+ycSKb/Q+l+kZDQIZH5mDrtrLuYDtbwiGpz30Uhq+sfvSy2CQYDnSR5
	 wg7hzq7eYSjWPE+Z6MBC3TyBfpUCuPzrOtIeV+TcOhVAc4y32dVRqMg1DcuBYHDdKx
	 W1lv1OEpocUHLD0TFu2imsiQZRs9EcORK01Y64oS49umndyHGmW2IaNsyN6hj3LYAH
	 gHe4KpMrGeQ1PL09gAmBQk16BERVL+KtvqORXx7/bHJjG3H1aOZSzZED1lISoh9/0G
	 tYlK+EEMLX7z01ucOjdvu2eI1slN05SbPIuqUdsJhE1S/G1Ku1Hm8JYGzFk5Cq1RZP
	 Quhg4OYKyUNbw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:36:58 +0200
Subject: [PATCH 13/32] user: use ns_common_init()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-13-4dd56e7359d8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=874; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2Pb+C09AD3Ch8zyPOBqZ4ir9gSxZa2YXPjiwgVDz5cU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7OWQVtxd+Ip3bqPKpWIPt+Mu1t7KLJ/urTU58Ki5X
 7pu/uppHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNxcWJk2Ou+LOxd0g/NsjNF
 O2W2vVryxUOktTjt072T+xQeMU7sfcnI8FzUsFY+gvdo/yq1+r6zge/q+g8cfHlNQlJ/BatYdcg
 pbgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't cargo-cult the same thing over and over.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/user_namespace.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 682f40d5632d..98f4fe84d039 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -124,12 +124,11 @@ int create_user_ns(struct cred *new)
 		goto fail_dec;
 
 	ns->parent_could_setfcap = cap_raised(new->cap_effective, CAP_SETFCAP);
-	ret = ns_alloc_inum(&ns->ns);
+
+	ret = ns_common_init(&ns->ns, &userns_operations, true);
 	if (ret)
 		goto fail_free;
-	ns->ns.ops = &userns_operations;
 
-	refcount_set(&ns->ns.count, 1);
 	/* Leave the new->user_ns reference with the new user namespace. */
 	ns->parent = parent_ns;
 	ns->level = parent_ns->level + 1;

-- 
2.47.3



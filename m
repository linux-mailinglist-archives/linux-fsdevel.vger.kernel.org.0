Return-Path: <linux-fsdevel+bounces-61053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A54EB54BDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 13:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C370A047B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 11:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5AF303A3C;
	Fri, 12 Sep 2025 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMQGDLXa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35A4303A15;
	Fri, 12 Sep 2025 11:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678026; cv=none; b=cuAaDu6wP6nPCkyAeqTeYvg6w246MqW7c0cEQKlccFkbBkc73iZFOJ/vT629dz/u2tPWw+G5dcAKqzmvnEEDs/S6AFP+XBKJVO9pjUolY8uZLm1APD5oFEcsV3Ik+vsuqDqcrfPbr1pFTkZNf3CtIu5Kw3G9xviMevLkDK8df+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678026; c=relaxed/simple;
	bh=9cID18MPuDZzPbNG7wHb/YDHOZt15Sv35oYoUc0K8D0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XA/ay7J8mZtRwXO8+JNV66CtrOafKT/0pzmzmcHLYSNeBgXoznsK0kAPKHlJKib//MhvE25zlv+GxJaf6c8J2h48vC7/Zfpx5RlXrZ0AHhzlj07Q4C/hFsPvPQot9U/vh/LrayhsEYJ7g1WXsjlioFdL/e0Ufg/pi6JRkNSNMtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMQGDLXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EA1C4CEF1;
	Fri, 12 Sep 2025 11:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678026;
	bh=9cID18MPuDZzPbNG7wHb/YDHOZt15Sv35oYoUc0K8D0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FMQGDLXaGFbRG+NJRPhgsmejK6WYugM+dkbTV3+gJ26ZfXNVWnjCdL/mDVM242aZA
	 rvlY6X9U76YJFJH29QvXi3JCbqiQnilc70iUI4WJoH72nkPaf94/DkiyzpUZFX+fpH
	 0iajPCzxA88TNB/X+QZZX/rQpyJw6LmfM8TOypRFBoIdwgCSaGowAq2Ss8FqooKHmZ
	 ftAt9DWJSpSH5Lp7Gd72fMQMIweFilMYoAycCBLEFWLPabHDyeuEly4LAp/hOCWkWG
	 r+zUJYq9xwI1TPqZ11FQzoRFc9DgSBUGq+7zM7CUPKprB2KCJJSFIBIdB2W6V/MIb2
	 tlB6aQ4ANtjYw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:31 +0200
Subject: [PATCH v2 08/33] cgroup: use ns_common_init()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-8-1a247645cef5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9cID18MPuDZzPbNG7wHb/YDHOZt15Sv35oYoUc0K8D0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4Zzi3epsddLpv+i+lQueCnw3MpZLj1EQ1fq2zsila
 gLDppbrHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOp9Wf4H7W3qit232vxwuQc
 bcedfR8N9tbMYr9ZHp1+ze1WTGK3AyPD0f7gDTMFlr9+GfLqelWdKvvJYt1V8z4GmVl+Ep7IrXi
 ZFQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't cargo-cult the same thing over and over.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/cgroup/namespace.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
index 144a464e45c6..0391b6ab0bf1 100644
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -21,20 +21,16 @@ static void dec_cgroup_namespaces(struct ucounts *ucounts)
 
 static struct cgroup_namespace *alloc_cgroup_ns(void)
 {
-	struct cgroup_namespace *new_ns;
+	struct cgroup_namespace *new_ns __free(kfree) = NULL;
 	int ret;
 
 	new_ns = kzalloc(sizeof(struct cgroup_namespace), GFP_KERNEL_ACCOUNT);
 	if (!new_ns)
 		return ERR_PTR(-ENOMEM);
-	ret = ns_alloc_inum(&new_ns->ns);
-	if (ret) {
-		kfree(new_ns);
+	ret = ns_common_init(&new_ns->ns, &cgroupns_operations, true);
+	if (ret)
 		return ERR_PTR(ret);
-	}
-	refcount_set(&new_ns->ns.count, 1);
-	new_ns->ns.ops = &cgroupns_operations;
-	return new_ns;
+	return no_free_ptr(new_ns);
 }
 
 void free_cgroup_ns(struct cgroup_namespace *ns)

-- 
2.47.3



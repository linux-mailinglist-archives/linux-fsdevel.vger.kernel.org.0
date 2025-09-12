Return-Path: <linux-fsdevel+bounces-61059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B00B54BF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 13:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD3FBB61128
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 11:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A415B3043D8;
	Fri, 12 Sep 2025 11:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lr9fJbAM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C3A304BD3;
	Fri, 12 Sep 2025 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678063; cv=none; b=ih/1u3JtBeV1GoJoC8PeqR32j1FS1C8JdDIpyzUSdzrErDLfm1s+DhY5AhZmg4R+vvJ0dOMLAbsi6R/mEsIFS+r+9qRF6iMozDrVa8kVF5UXsA/gjmgX7LieDxmQz8S9RPk+c1zuoqzrFYtnDj2Lz03R9ki8L4o2f3uq8bWJ9jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678063; c=relaxed/simple;
	bh=suiGylTo4Z6WWzmdsMZCtH/Gul2oFelJAKvTi6/I740=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pPIszFDLSNwMpUmGjvOWVKhZCWwK2sF9NBeyyt3AtRFpODrkpybOUoshcgzhLzNc25Uom6MOxApgBkIcERBCtxGJyHBz+CzMmnAIVwgxXljTXkXQvyr4sGAsaTVkVcr9nqYmRZKUW6hziE7qP8MkxkHPXtiJKmBnZcRjR+pJrtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lr9fJbAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429E6C4CEF1;
	Fri, 12 Sep 2025 11:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678061;
	bh=suiGylTo4Z6WWzmdsMZCtH/Gul2oFelJAKvTi6/I740=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Lr9fJbAMLF0NnaXee1jsOPavmGVVxzoj07tpMrwuG40WiWgmPOQpRpRSVNgNZzmUd
	 Jbg02tZc4YUgP92nrsCxtVcq+99oNGlEegQ/rNPBBFjoVChSfyjHzeKqzvjk4By2us
	 0O+k6ORrcUI+tXJubEMSUbNsQuNSsB12/yQ6JBbFXQ4bEEpWdRfZR2hXdrsXMK7cB6
	 k07/GIEbjZlKVe5eusPgcY39b9p513MK1AeaIS/+R5psIrQJ9HBrFgdNvwW13OM7H3
	 oIO+kwUSVbg3vY84j1IVh/q2oMqtZFMV3qstSHfge5IEM3tnpx5Oev+oVFSKLCa5Wa
	 YDGg8gxjQ/HdA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:37 +0200
Subject: [PATCH v2 14/33] user: use ns_common_init()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-14-1a247645cef5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=912; i=brauner@kernel.org;
 h=from:subject:message-id; bh=suiGylTo4Z6WWzmdsMZCtH/Gul2oFelJAKvTi6/I740=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4ZzyPk7iXWbrzYrvh+ds3WfqWrfsQqu8ZpPTCbuqx
 la5WxGbO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaSv5fhr4CdT6tp1qc9/1I+
 rHIzSpaI7V/O3deg7F659sennSt8zRn+6TUdmaLBH8rvz1jT4H9Fpvfxveps1v/z/l6586BZ7rU
 6EwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't cargo-cult the same thing over and over.

Reviewed-by: Jan Kara <jack@suse.cz>
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



Return-Path: <linux-fsdevel+bounces-60781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F32B519C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9F91B20742
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970FC33EB18;
	Wed, 10 Sep 2025 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8oCGAZj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB96B32CF8F;
	Wed, 10 Sep 2025 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515068; cv=none; b=IK9TrKm7pxdRTakWpJb3bbKW8ze9GYrfypDutwqJTcg3cnKlVWSbg51JF7LmblTRw1rnadR4BiwwvYD4Gz3JvBNHV0fnkna/skU0j3eNy277lepqQbxfi52RO1V6qxmwpR95rcXWS+/w0h6itPGNJpquC+3EgrM/toHZsQqRM0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515068; c=relaxed/simple;
	bh=Uyf4OUbQ4N9dntxnaqhQjswkZw9lycGwkUdINuCLOMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OZbktQmdkYMSGT54TGrLwbKN6A45PL4+OGmrT1cdB/QDvG2eR6/CaMWk5s7ZuI6iKRE6ezwsZLBClBCaBLzvsYcs17Mu8J9FKzR61fdzcV0hSd6zsNbHZqp30GtqcBYzSEGphndbuBf301RoBJq7MLi/u1UGx9CXAXplE2gkrlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8oCGAZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5335C4CEF0;
	Wed, 10 Sep 2025 14:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515067;
	bh=Uyf4OUbQ4N9dntxnaqhQjswkZw9lycGwkUdINuCLOMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F8oCGAZjorilhalkKn/ywx/TJ/Tok4E+xiv9lQeGdPrOuw8pN0k6qqOZyyxTg4uxt
	 R96lBeq9IPrld9W+9TZJyTEY+9GZ+c94IBPhjTKK96vNW+WobsmdPeRUa7i+5jv+70
	 yDAyEXFPIfY2fHigc0by2sjr73XKF6t8b1l/ERZJWuJSLW3JDRYbSiYfjhvn25kQRz
	 m1AmgFb+9h7oi4MmcrN5OvG3R+Wn1pcB9k805jqV3NDy0tTbXJBGw1im2dIxCVdv7E
	 4JktcHvY1uA9x6x2oRHVB34u3wxY3F6Br1HbuOzjYZ69zf1Peg223bb6Iiix3wQswZ
	 awm3DX268On+w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:36:52 +0200
Subject: [PATCH 07/32] mnt: use ns_common_init()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-7-4dd56e7359d8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1089; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Uyf4OUbQ4N9dntxnaqhQjswkZw9lycGwkUdINuCLOMY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7OXg+P0gyTyYayKDzIEXK1RT1hfe/v3ijWhhpJonv
 69ZjaRlRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQm3GL4Kx/VezdaRvvapt7n
 O1u7FSSPHtB5mbdkt7fdxz+Crz13ODP8M4jb0uBfFNHfM+lRvVLbgekiomf/xDhaf29y/HCu/vZ
 3RgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't cargo-cult the same thing over and over.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ddfd4457d338..14c5cdbdd6e1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4177,18 +4177,15 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
 		dec_mnt_namespaces(ucounts);
 		return ERR_PTR(-ENOMEM);
 	}
-	if (!anon) {
-		ret = ns_alloc_inum(&new_ns->ns);
-		if (ret) {
-			kfree(new_ns);
-			dec_mnt_namespaces(ucounts);
-			return ERR_PTR(ret);
-		}
+
+	ret = ns_common_init(&new_ns->ns, &mntns_operations, !anon);
+	if (ret) {
+		kfree(new_ns);
+		dec_mnt_namespaces(ucounts);
+		return ERR_PTR(ret);
 	}
-	new_ns->ns.ops = &mntns_operations;
 	if (!anon)
 		new_ns->seq = atomic64_inc_return(&mnt_ns_seq);
-	refcount_set(&new_ns->ns.count, 1);
 	refcount_set(&new_ns->passive, 1);
 	new_ns->mounts = RB_ROOT;
 	INIT_LIST_HEAD(&new_ns->mnt_ns_list);

-- 
2.47.3



Return-Path: <linux-fsdevel+bounces-60786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696C2B519FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF438540A4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA73134AB12;
	Wed, 10 Sep 2025 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueyqyW/d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD2232BF22;
	Wed, 10 Sep 2025 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515098; cv=none; b=cE57IEfrDMIGLMSSNu/7oEvMlr2Tj/Epw59LCVCrA+nlcwcHw/RKp2EZyoUM5MV/E0VUTV36ReFIbWMZDX9BnqN5n387i9VcH0HqLo0ajyB4+S4NhnuP5myepmpoDbkiJVdAxftOyYBbbUCMaVpxRG9QfgxJVZH1v5BqvDgZB60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515098; c=relaxed/simple;
	bh=ccs2mPITvV7+tId/BLNyWx+lXkz4V4lk4FOMDck+H58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t42IZsPLFMNcpjQy0JWjafzt6rH7gIvTjmj6uguIHHA6CIvXXyyV+mkWj0u9Ze+2xPt645/XBzEc+sHkCPdnY3mC+aolPJ8IlzHjkpSF9cQRhnRIRtLIEYPQU/wzZggw8yP0TXxMK2fnz3xw76Oz7uh+mWGzycx/DXETKIOvMP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueyqyW/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4571CC4CEF0;
	Wed, 10 Sep 2025 14:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515097;
	bh=ccs2mPITvV7+tId/BLNyWx+lXkz4V4lk4FOMDck+H58=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ueyqyW/dGhM8OGZDuxLW5JsOsfhwDmPetMD4JrYdT7VyNmiwHWrSdI+Sozmsx20Qm
	 spB3thrhcrBVyFvwGgbTcFsTpNHxDKmHcUq+nMyKPZv/lBNHlJzD6XX5xnEd4wChiX
	 AnnTGaZAksoek63PLTNB2LXoaL7ZrCLX2fYhK2pOMGr2D/WtF/Hbc/l/drV5kWiUay
	 /FgG0+KY5vupnmn1zP7lNr7/Zy81OnCWJjsTmCPP2CfdNSa+Q/MuRX5OedY2kUwMpc
	 h8NARbPO7EzqxxOpCFSo5Dcv7qR0RteSKtlA6TTbc39Ae5YoYraPLSrwvpF/2p30eq
	 G675Un6AFTuaQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:36:57 +0200
Subject: [PATCH 12/32] uts: use ns_common_init()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-12-4dd56e7359d8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1376; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ccs2mPITvV7+tId/BLNyWx+lXkz4V4lk4FOMDck+H58=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7OXwljvywTKfUfygeUJ53n61TSvkN366tGK36u9Zi
 3llb9506ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIF22Gv8Kae2LYV7X3Rj0t
 Y9j6Y+/ltw+y+D4e3rou+/GhidwNHwsZ/kcFrJ4Y7WGi9jd2aoR7qV2aV/LJ+z8FNZmY11sXOvP
 fYwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't cargo-cult the same thing over and over.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/utsname.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/kernel/utsname.c b/kernel/utsname.c
index b1ac3ca870f2..02037010b378 100644
--- a/kernel/utsname.c
+++ b/kernel/utsname.c
@@ -27,16 +27,6 @@ static void dec_uts_namespaces(struct ucounts *ucounts)
 	dec_ucount(ucounts, UCOUNT_UTS_NAMESPACES);
 }
 
-static struct uts_namespace *create_uts_ns(void)
-{
-	struct uts_namespace *uts_ns;
-
-	uts_ns = kmem_cache_alloc(uts_ns_cache, GFP_KERNEL);
-	if (uts_ns)
-		refcount_set(&uts_ns->ns.count, 1);
-	return uts_ns;
-}
-
 /*
  * Clone a new ns copying an original utsname, setting refcount to 1
  * @old_ns: namespace to clone
@@ -55,17 +45,15 @@ static struct uts_namespace *clone_uts_ns(struct user_namespace *user_ns,
 		goto fail;
 
 	err = -ENOMEM;
-	ns = create_uts_ns();
+	ns = kmem_cache_zalloc(uts_ns_cache, GFP_KERNEL);
 	if (!ns)
 		goto fail_dec;
 
-	err = ns_alloc_inum(&ns->ns);
+	err = ns_common_init(&ns->ns, &utsns_operations, true);
 	if (err)
 		goto fail_free;
 
 	ns->ucounts = ucounts;
-	ns->ns.ops = &utsns_operations;
-
 	down_read(&uts_sem);
 	memcpy(&ns->name, &old_ns->name, sizeof(ns->name));
 	ns->user_ns = get_user_ns(user_ns);

-- 
2.47.3



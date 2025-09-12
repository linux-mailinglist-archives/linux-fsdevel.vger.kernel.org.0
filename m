Return-Path: <linux-fsdevel+bounces-61058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2213B54C05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805D81CC5D2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 11:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBBC30F545;
	Fri, 12 Sep 2025 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSOmtPCq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5227130498E;
	Fri, 12 Sep 2025 11:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678056; cv=none; b=sGeOD4o9lOcAIycOxPDkoJidKqMGhZ8z8Aou0zv1Q4xEJWuvFZd54sUh9CKn/fy45Pkjn8jDqFinuOMlDJuKAvuzuCzBqbd1cuXxSKxyY0lLZwkWmQWHfSEfdyVVXI2uTPYZtpXB/c5DshGcmZoam1KETDEGCYvAsD92K8HJGPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678056; c=relaxed/simple;
	bh=1wRMILydm7J93H3fWSjJz6o1qamz/2fyRpZHfkYRdgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KP6/oFb014mL65Aub1FN1X6LeLwmwRWKTzjjvsNAzj9GPWimj7QjJ254Vi0DzYVN5byaVEnsWnfQ/apfF8M1YgkyedYWwjmt350B9oSgfmnJplZ693D6UgiH6dxPG7vx5iD0d945EyG2MVhExl8CiMnxhlFRq+Yk3cDLeB2xA7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSOmtPCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B326C4CEF4;
	Fri, 12 Sep 2025 11:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678055;
	bh=1wRMILydm7J93H3fWSjJz6o1qamz/2fyRpZHfkYRdgM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aSOmtPCq9Ia+33u9pKjRAgi3iNQeBLyz3c0WbPRD/k8Rof8NipngklsncGYyDZr7k
	 uLKOeiOjejokFJwhTCJYLGxJQ/sF3zCs+7L52Qc8+EUetJUzQo5qjiH/FHaq1+4d6g
	 N1rWMEyirZwT1l4WYI2SE5EpuhQzKtcXkfuOtVHYTMN4ozpQv6S1AWNNBckDHrXmgW
	 O7crtMkRToZ17vgNt3LrZZBLRUn/d8rS6icr2CTAfci2DAGYgHZiztRcA1LswxLQFw
	 OFv3NMyBbSehrzm26x57oyyUgSpNFQBJk6dXb3LxG22O3MPcbkYs+IUIOUvQW4hYF2
	 Eynp0cX0SwoHg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:36 +0200
Subject: [PATCH v2 13/33] time: use ns_common_init()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-13-1a247645cef5@kernel.org>
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
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=1185; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1wRMILydm7J93H3fWSjJz6o1qamz/2fyRpZHfkYRdgM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4ZxyPen8uYaMAt7rakYzWk0abUs/ivLMD+zgmRmgN
 7Fa4XZjRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERuFDIy/C5TXDQxXX/7Y0OR
 L7OfbHfk5ana71L/SmtKWdrhX9+WxzD809n9yyX4xb7L0tnTHOM0XdNYninkbHdqjWgorzo2sUO
 EDQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't cargo-cult the same thing over and over.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/time/namespace.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 667452768ed3..0be93d8f2896 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -88,22 +88,19 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 		goto fail;
 
 	err = -ENOMEM;
-	ns = kmalloc(sizeof(*ns), GFP_KERNEL_ACCOUNT);
+	ns = kzalloc(sizeof(*ns), GFP_KERNEL_ACCOUNT);
 	if (!ns)
 		goto fail_dec;
 
-	refcount_set(&ns->ns.count, 1);
-
 	ns->vvar_page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	if (!ns->vvar_page)
 		goto fail_free;
 
-	err = ns_alloc_inum(&ns->ns);
+	err = ns_common_init(&ns->ns, &timens_operations, true);
 	if (err)
 		goto fail_free_page;
 
 	ns->ucounts = ucounts;
-	ns->ns.ops = &timens_operations;
 	ns->user_ns = get_user_ns(user_ns);
 	ns->offsets = old_ns->offsets;
 	ns->frozen_offsets = false;

-- 
2.47.3



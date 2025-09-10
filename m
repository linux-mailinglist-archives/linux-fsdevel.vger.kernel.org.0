Return-Path: <linux-fsdevel+bounces-60785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA6BB519E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86A01C8785E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CB53469E3;
	Wed, 10 Sep 2025 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYvkz+cf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D53732F74D;
	Wed, 10 Sep 2025 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515092; cv=none; b=Nqkv0FPrYfEuL1wV20w84l+3ZpqrjXLt5nGsYnFUoyg0wudj9n+Kcn95xaHVZ57nOZ8R+dTiV9mDhi21eqkTyoDk1EbqeUnLeRV2pNLxpIozFMqR1maz6HTcisUYoLTaaAKUDAjba49DGdMGYve2ZrZxV/f14JW4SmI1z0pHA3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515092; c=relaxed/simple;
	bh=iiPFC5SPYrdUEWp7Bw5ri9JWaFV5ytA5eNIM6tGTIgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KxP9pliAUkiUwn94F1ulPW9WIyAvSms9xK7vMmvhLOI7hTgN/pCx73xYEhCIwNkYD/KN5aa3C2TInLvM4sK81DV9+sMN+zZ8834YMX+1cFvqOPp96q0eX/R6ED2tyG3aywbaHa1yZFu+UdCDBZZB3x63siUvsFh2xAR28bSHEWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYvkz+cf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CADFC4CEEB;
	Wed, 10 Sep 2025 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515091;
	bh=iiPFC5SPYrdUEWp7Bw5ri9JWaFV5ytA5eNIM6tGTIgE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AYvkz+cfX0obtODPvJ6wd/mWGSPoffsYFJm0datfvhBzNtKNQvq4Sx3li9LYX7upi
	 aQ1L7+Bzrev6MY3XZvJLWusvSruvX42icMSDaMvOr6+5sDlJbMN9It51L4Iro2SuJ5
	 fbRDsi9nGrTbgo6I6zsj/mpp0ty9GktoQbdakeM/bTf6RiPU0fSd2cfqfCxwCk8XRS
	 nLsVow8WlyO8tuqabnQLLzfya+BWQ5/qGv/eUpp2Q+Xl2iz96YYoMvvdr5dyYT2IG7
	 LwOaD+QTGMEJ7J2FChYbqq35pH9xu7J6FTRM63NG9wfZ5TcFAPbACCm6WooYMbkoBt
	 MEohRrz3bOKrw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:36:56 +0200
Subject: [PATCH 11/32] time: use ns_common_init()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-11-4dd56e7359d8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=957; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iiPFC5SPYrdUEWp7Bw5ri9JWaFV5ytA5eNIM6tGTIgE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7OXIn3Fi343fhasjU/Ra2OOaN/Ik1L8N1DtoFbjv4
 eH+wqYfHSUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNJvc3wTVfgsnecaLDqxZfW
 091sFU4vfLCEs5tt0f+Zd7J5N3CtZvjvcfPQV/Oy35NyGHKiLP7qvNqaXc/hOX+O5jxO81PbKx7
 zAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't cargo-cult the same thing over and over.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/time/namespace.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 667452768ed3..80b3d2ce2fb6 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -92,18 +92,15 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
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



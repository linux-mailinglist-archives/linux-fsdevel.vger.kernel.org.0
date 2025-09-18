Return-Path: <linux-fsdevel+bounces-62102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D99B84007
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 12:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F1F62665B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F932302CBD;
	Thu, 18 Sep 2025 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHTuzu+0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC752BEC32;
	Thu, 18 Sep 2025 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190357; cv=none; b=iGQO6blqiAuIVT2+GTWX11UDFV2xFoB6S989LHDY1VwFzbJH4yP98EvEuSohdR4r7e9JMZn7l81ECd5i2lDiWcrmnoHDev4QxRxo9upVAFqLObzGYi486mr05swFOkRZhdCygmMc2347VOGNW5JdbTOkK+42adBz1iB5pC2pAr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190357; c=relaxed/simple;
	bh=ElLNCBKp3QVkpe3Y+5vJ7NpnjlHdsznRSDUVkiyDnoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rnnm7/yNkgvNM1TWK9sPSl/MW16ebVYIGqavK76zD/tQ3X74OMGyUiqReFW70Y0V5GYPG2TGQhsyeI+V7nPHKMvzrrgxxHwzjc8a+bDkWTrkDnYcv/QqHnNg6SH9d3Vk8W5rIkckqeuua7s+LRMONldZwbdqT7OB8mdZ0BXYWvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHTuzu+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8B4C4CEE7;
	Thu, 18 Sep 2025 10:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190357;
	bh=ElLNCBKp3QVkpe3Y+5vJ7NpnjlHdsznRSDUVkiyDnoM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UHTuzu+0oDQTLOw8Waw/mwjkopKOyNbJoHjQAVbhlfnX3CcZpW2SWMjZwuSP/UzMS
	 7t0nH03vUJQUNUannPMg6lHWetGk5DQuhxU+AJWtGa4woLzVVatHj4z9m5KVCD4Iwd
	 62Cc6oascOnUyO+YgimzGOayhZYNsGHbUbvjojLLqpTjlbUUnIqOsitL3wGwvRgvtc
	 Ei+ZKW7AkGf2XIn9ytnWrGyuguyeD3qBARArb2hLtO6MWyj1gYF8lTvn4alhbz3Ng2
	 WNrbh/woYS9M/w5AYYxvCpOsvm6AakZgcWBUCMDnm3ePku9XTPipL6awIKn0pYPFjT
	 TfjjPi/EY2cfQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 18 Sep 2025 12:11:54 +0200
Subject: [PATCH 09/14] net: use check_net()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-work-namespace-ns_ref-v1-9-1b0a98ee041e@kernel.org>
References: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
In-Reply-To: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=662; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ElLNCBKp3QVkpe3Y+5vJ7NpnjlHdsznRSDUVkiyDnoM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWScvvXMa8NDCTZXaZedM+Zzaa5r1+xqurhH9aXM0YXLe
 nIq3YTbOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCl8/wV+D+5DM3C+ae12mM
 yVse1bksMvbxkY8mBtk8NyfOfdtlqsnIMMtn29H3Dlonrun8NhaZLfvtf/rhC8tSJN7VptWcThE
 s5AcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't directly acess the namespace count. There's even a dedicated
helper for this.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/core/net_namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index fdbaf5f8ac78..d81a8b291ea8 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -315,7 +315,7 @@ int peernet2id_alloc(struct net *net, struct net *peer, gfp_t gfp)
 {
 	int id;
 
-	if (refcount_read(&net->ns.count) == 0)
+	if (!check_net(net))
 		return NETNSA_NSID_NOT_ASSIGNED;
 
 	spin_lock(&net->nsid_lock);

-- 
2.47.3



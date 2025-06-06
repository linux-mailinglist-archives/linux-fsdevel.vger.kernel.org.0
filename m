Return-Path: <linux-fsdevel+bounces-50825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EECACFF93
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 11:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267F83B2058
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 09:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A6F286D70;
	Fri,  6 Jun 2025 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8oRpTB8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0FD19D092;
	Fri,  6 Jun 2025 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749203132; cv=none; b=anaQC2mLWAHr2inbIoy/Y2H+mJ+mTRme24XQ/ey2Ak4yLh5yYwKHP96RzHARYFToWPPiA5sZajblbvSONEugweQ8paxEb46G86c2POoRUwxGZcgIX7vKeP0RHu7DqUbSVBcKGIUZyG1ISlfSWyQYU5KzYczLX3QlfsyM6Abfefo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749203132; c=relaxed/simple;
	bh=XfRIppOipBODY89g7ZPqa8ioCPPwFlLji3gzP/zqmEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZkBGJwcPWThHBq6p8I0a12a9EaiVMeTxIZ+x7XU1gSRVazv+1L3dr9zMAzZMNoXxdAy2m9gUlelVcQ29utc8aYIzQ/mDQO5Vredz4+h0yG76AUv/aHuAPoaMt8Rz23Z/UjFN8/jQDN3r4GxjNcxaprsBZf1R4UISpboSsV9CmdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8oRpTB8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410C7C4CEF3;
	Fri,  6 Jun 2025 09:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749203132;
	bh=XfRIppOipBODY89g7ZPqa8ioCPPwFlLji3gzP/zqmEE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R8oRpTB8Ih/2eQN89dpxTshKDA/bKziMYMT4HD/F9P2vgNqjbAHSbnQB4Gio9gR25
	 mSJjbTAk8aTsl+/Dqc9wXlM11H26M2wgXis78yVTnfG6OMCl9QwLnnOl66pl2H3Hif
	 xh23zc3emLLy8E6XvwP7hD8ikMgmV7K+yo/ivVZM9rJbHwFXv9XYZeLXye6MjsNLEQ
	 c+3vsTeKeSa+VriTOGrPhCeB1G284YOW6efeTS7zwaXAKYEjCOJcNYU78+W4BYTUim
	 gXOgk7d9qBX+I8IQhQPKYILyIow/oMBt/NlQiZNAVgr883vkGNgFLnshBK8/EebRP3
	 HaRtxj/UBDr6g==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Jun 2025 11:45:08 +0200
Subject: [PATCH 2/3] netns: use stable inode number for initial mount ns
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-work-nsfs-v1-2-b8749c9a8844@kernel.org>
References: <20250606-work-nsfs-v1-0-b8749c9a8844@kernel.org>
In-Reply-To: <20250606-work-nsfs-v1-0-b8749c9a8844@kernel.org>
To: linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XfRIppOipBODY89g7ZPqa8ioCPPwFlLji3gzP/zqmEE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ47djOsC71iOyfGWtn7/1e/8+pNj594rSnlvkTVKzYT
 pl8qqwW7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE9gQLk4BmIjAEoa/IuKJZYeOR9gyLJgd
 Hpiy4eBd0YcH7xct+XTuW7jqsVZHAUaG959m9C48K39yN/urG79OTAy2/lDGkJr9sndu5Rnjlal
 pzAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Apart from the network and mount namespace all other namespaces expose a
stable inode number and userspace has been relying on that for a very
long time now. It's very much heavily used API. Align the network
namespace and use a stable inode number from the reserved procfs inode
number space so this is consistent across all namespaces.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/proc_ns.h   | 1 +
 include/uapi/linux/nsfs.h | 1 +
 net/core/net_namespace.c  | 8 ++++++++
 3 files changed, 10 insertions(+)

diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index e77a37b23ca7..3ff0bd381704 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -47,6 +47,7 @@ enum {
 	PROC_PID_INIT_INO	= PID_NS_INIT_INO,
 	PROC_CGROUP_INIT_INO	= CGROUP_NS_INIT_INO,
 	PROC_TIME_INIT_INO	= TIME_NS_INIT_INO,
+	PROC_NET_INIT_INO	= NET_NS_INIT_INO,
 };
 
 #ifdef CONFIG_PROC_FS
diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
index 6683e7ca3996..393778489d85 100644
--- a/include/uapi/linux/nsfs.h
+++ b/include/uapi/linux/nsfs.h
@@ -49,6 +49,7 @@ enum init_ns_ino {
 	PID_NS_INIT_INO		= 0xEFFFFFFCU,
 	CGROUP_NS_INIT_INO	= 0xEFFFFFFBU,
 	TIME_NS_INIT_INO	= 0xEFFFFFFAU,
+	NET_NS_INIT_INO		= 0xEFFFFFF9U,
 };
 
 #endif /* __LINUX_NSFS_H */
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 42ee7fce3d95..3a962b74080b 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -796,11 +796,19 @@ static __net_init int net_ns_net_init(struct net *net)
 #ifdef CONFIG_NET_NS
 	net->ns.ops = &netns_operations;
 #endif
+	if (net == &init_net) {
+		net->ns.inum = PROC_NET_INIT_INO;
+		return 0;
+	}
 	return ns_alloc_inum(&net->ns);
 }
 
 static __net_exit void net_ns_net_exit(struct net *net)
 {
+	/*
+	 * Initial network namespace doesn't exit so we don't need any
+	 * special checks here.
+	 */
 	ns_free_inum(&net->ns);
 }
 

-- 
2.47.2



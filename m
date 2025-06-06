Return-Path: <linux-fsdevel+bounces-50827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C61C8ACFF99
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 11:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9253B256B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 09:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDDD2874FE;
	Fri,  6 Jun 2025 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umZI1rpO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8A2286D6F;
	Fri,  6 Jun 2025 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749203135; cv=none; b=tf2tr5bhDiVdmVmNDP6g2FcA+lHlZ0p2y6ZduXgOgR3HVvo0VQ4wh5i79f6Med2dETWxxE+NfuZjN2oWmvnxOE3MjuIVSa4WEXeN38BxVu1+mxNF7gnMjrJklOL/cuRnhd8nncvUOm1tsd1F5xC6D8ibDWpj/yo+cZwOQrzIToo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749203135; c=relaxed/simple;
	bh=+Hv20eOe0UDj44R6YWbzlBAF2ORNht4ADstkukh9p9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YXB2zZXEKEjjog1ElBf1aJQDoS9hN+Qbcho4CSZrib7c/SEQERQF9zssCd4/uAg4kcUNTyBDzqTqaGmaqBflvRG7QS6uhxDST57b3An7bS+VcmHWS/U5j0E9l4l479KK0Ga641Z80h5NyzxB4yJbjb3QWOxSCZWryyDZ1oS5E8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umZI1rpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E74C4CEF3;
	Fri,  6 Jun 2025 09:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749203134;
	bh=+Hv20eOe0UDj44R6YWbzlBAF2ORNht4ADstkukh9p9w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=umZI1rpOk8O8ifT0Wm37KFXVg+OabiGGD+IzL3Nj8RCK/H+1DgcqC5o/Kl8bkXpot
	 jj/y6ie17B3QLtYorvDVpVmaXzc22UFBumv7YtJmCKm3ukFWKMQvjjjOMSskTXuqA2
	 o5HE4So9t6KfGdJTlqKPyQhFfzHdGp96vUW0brYrsNlOcHdg2VRxk7MpMDXBVUTa25
	 6ffsfLl3GYNdpYh0Qvf27cxA1iXcr01yJtAbxad8oCFFxwHTX+FXbbXeQiLutvFPWa
	 +yljRlCVWclPK3r1Iy1gzmyjdAAbMLVWT7Qd0RalvwsTzADnS/PThlVgbWm7Ew5juD
	 vRc8GOgNRyUUg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Jun 2025 11:45:09 +0200
Subject: [PATCH 3/3] mntns: use stable inode number for initial mount ns
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-work-nsfs-v1-3-b8749c9a8844@kernel.org>
References: <20250606-work-nsfs-v1-0-b8749c9a8844@kernel.org>
In-Reply-To: <20250606-work-nsfs-v1-0-b8749c9a8844@kernel.org>
To: linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1913; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+Hv20eOe0UDj44R6YWbzlBAF2ORNht4ADstkukh9p9w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ47dje2MA5QfW0SmjxUe2EOTrpHVtn+f0SO2zOq8R55
 rzF58/CHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZ3szwP6spUnFu0gsBaclX
 Xl2bnlYyf7IuP8X+6mSV/o8Py9d0fGX4Z+Yk8cbCV/3eZNsld0IWvtk/xUFcZ7GjnnebzimRBbG
 yXAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Apart from the network and mount namespace all other namespaces expose a
stable inode number and userspace has been relying on that for a very
long time now. It's very much heavily used API. Align the mount
namespace and use a stable inode number from the reserved procfs inode
number space so this is consistent across all namespaces.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c            | 4 +++-
 include/linux/proc_ns.h   | 1 +
 include/uapi/linux/nsfs.h | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2f2e93927f46..1829ab9a0a52 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6174,9 +6174,11 @@ static void __init init_mount_tree(void)
 	if (IS_ERR(mnt))
 		panic("Can't create rootfs");
 
-	ns = alloc_mnt_ns(&init_user_ns, false);
+	ns = alloc_mnt_ns(&init_user_ns, true);
 	if (IS_ERR(ns))
 		panic("Can't allocate initial namespace");
+	ns->seq = atomic64_inc_return(&mnt_ns_seq);
+	ns->ns.inum = PROC_MNT_INIT_INO;
 	m = real_mount(mnt);
 	ns->root = m;
 	ns->nr_mounts = 1;
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 3ff0bd381704..6258455e49a4 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -48,6 +48,7 @@ enum {
 	PROC_CGROUP_INIT_INO	= CGROUP_NS_INIT_INO,
 	PROC_TIME_INIT_INO	= TIME_NS_INIT_INO,
 	PROC_NET_INIT_INO	= NET_NS_INIT_INO,
+	PROC_MNT_INIT_INO	= MNT_NS_INIT_INO,
 };
 
 #ifdef CONFIG_PROC_FS
diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
index 393778489d85..97d8d80d139f 100644
--- a/include/uapi/linux/nsfs.h
+++ b/include/uapi/linux/nsfs.h
@@ -50,6 +50,7 @@ enum init_ns_ino {
 	CGROUP_NS_INIT_INO	= 0xEFFFFFFBU,
 	TIME_NS_INIT_INO	= 0xEFFFFFFAU,
 	NET_NS_INIT_INO		= 0xEFFFFFF9U,
+	MNT_NS_INIT_INO		= 0xEFFFFFF8U,
 };
 
 #endif /* __LINUX_NSFS_H */

-- 
2.47.2



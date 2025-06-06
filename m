Return-Path: <linux-fsdevel+bounces-50826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D965EACFF94
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 11:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765A03B1CE1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 09:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AB62874E2;
	Fri,  6 Jun 2025 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Czxy8o/i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4A0286D6F;
	Fri,  6 Jun 2025 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749203133; cv=none; b=g2GwD80DkfaOuNA3GHD5OamJV4zGprOGElFgKioiia78+SUezVRTVcoIVBlVy3qc+IW94HioX9EVLTdYTVBCNfz2HJfu9OOmx4qdGtkHnhzvDquNMthck+cjNK4EmrXdC3TcC7RdYTap/1UAq3t8INSX21vi6R2jmd1/NX23u9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749203133; c=relaxed/simple;
	bh=nfvMium7Qutm7d3UFxXjKgjLOZC1eZF659y9t2Vgn3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hOJprhjExDw1QfgyqOdipfFLx4R0uS0XxopJFHKQNz4x6FHutLSo9ufQLQnmP3BYEuKmYHdKq0qs7pGDcqXIRZk/WYq6MgdKyag1ZYSPlJe1rMVQNvX7Zi//GXggaUF5+rchBua0UVpfJSIvXAjrQ5VxMn2fOouV26WnNHvgeVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Czxy8o/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A15C4CEEF;
	Fri,  6 Jun 2025 09:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749203130;
	bh=nfvMium7Qutm7d3UFxXjKgjLOZC1eZF659y9t2Vgn3A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Czxy8o/iPZLwxFkQvbzKf9KIvB/ns0X6rJEyq8xpD7uR4UYJyF+hdiZQbNqliMEFL
	 smqATui7GQfkxFe1ZJHrXdpZaJrJw5wFj56hww6RXqwgwnMNet/7Wa01Sb2huKB2J0
	 S2p/mlEDpwWTyDJOToZVBHqdKjLCApGzgwX3hDEQ4gOXuUL7sKoIBCDCAMIv+1fW8S
	 71Co6A8bBfOOrL+tD5R5DgOmL3YEuT/I2z/ZTOgSqtx4816gD3uMXzNqbaAeDUCAiQ
	 G7O8dptQlcPKubVYklCXBrHP8rLpp5eA12JF0vZGcZR4qvXNJYVN2ZDL/cpfNvIEsl
	 qSeQ8puA/Nxxg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Jun 2025 11:45:07 +0200
Subject: [PATCH 1/3] nsfs: move root inode number to uapi
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-work-nsfs-v1-1-b8749c9a8844@kernel.org>
References: <20250606-work-nsfs-v1-0-b8749c9a8844@kernel.org>
In-Reply-To: <20250606-work-nsfs-v1-0-b8749c9a8844@kernel.org>
To: linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=2048; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nfvMium7Qutm7d3UFxXjKgjLOZC1eZF659y9t2Vgn3A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ47dh+1/LuifMWwj09t4oYT53s5hBamb9olVns/Mw/l
 baLd2836ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZgI2z2G/8HbK3J7vBP9Yhx4
 rnIvU/px3Hzicd59i5Z8lJNTOJ95KZ2RofGF38/yK5/mmL7338Loa5TfGb6u8no835GAlGlmL2I
 msAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Userspace relies on the root inode numbers to identify the initial
namespaces. That's already a hard dependency. So we cannot change that
anymore. Move the initial inode numbers to a public header.

Link: https://github.com/systemd/systemd/commit/d293fade24b34ccc2f5716b0ff5513e9533cf0c4
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/proc_ns.h   | 13 +++++++------
 include/uapi/linux/nsfs.h |  9 +++++++++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 5ea470eb4d76..e77a37b23ca7 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -6,6 +6,7 @@
 #define _LINUX_PROC_NS_H
 
 #include <linux/ns_common.h>
+#include <uapi/linux/nsfs.h>
 
 struct pid_namespace;
 struct nsset;
@@ -40,12 +41,12 @@ extern const struct proc_ns_operations timens_for_children_operations;
  */
 enum {
 	PROC_ROOT_INO		= 1,
-	PROC_IPC_INIT_INO	= 0xEFFFFFFFU,
-	PROC_UTS_INIT_INO	= 0xEFFFFFFEU,
-	PROC_USER_INIT_INO	= 0xEFFFFFFDU,
-	PROC_PID_INIT_INO	= 0xEFFFFFFCU,
-	PROC_CGROUP_INIT_INO	= 0xEFFFFFFBU,
-	PROC_TIME_INIT_INO	= 0xEFFFFFFAU,
+	PROC_IPC_INIT_INO	= IPC_NS_INIT_INO,
+	PROC_UTS_INIT_INO	= UTS_NS_INIT_INO,
+	PROC_USER_INIT_INO	= USER_NS_INIT_INO,
+	PROC_PID_INIT_INO	= PID_NS_INIT_INO,
+	PROC_CGROUP_INIT_INO	= CGROUP_NS_INIT_INO,
+	PROC_TIME_INIT_INO	= TIME_NS_INIT_INO,
 };
 
 #ifdef CONFIG_PROC_FS
diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
index 34127653fd00..6683e7ca3996 100644
--- a/include/uapi/linux/nsfs.h
+++ b/include/uapi/linux/nsfs.h
@@ -42,4 +42,13 @@ struct mnt_ns_info {
 /* Get previous namespace. */
 #define NS_MNT_GET_PREV		_IOR(NSIO, 12, struct mnt_ns_info)
 
+enum init_ns_ino {
+	IPC_NS_INIT_INO		= 0xEFFFFFFFU,
+	UTS_NS_INIT_INO		= 0xEFFFFFFEU,
+	USER_NS_INIT_INO	= 0xEFFFFFFDU,
+	PID_NS_INIT_INO		= 0xEFFFFFFCU,
+	CGROUP_NS_INIT_INO	= 0xEFFFFFFBU,
+	TIME_NS_INIT_INO	= 0xEFFFFFFAU,
+};
+
 #endif /* __LINUX_NSFS_H */

-- 
2.47.2



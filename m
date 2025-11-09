Return-Path: <linux-fsdevel+bounces-67610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9203C44738
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 22:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D2724E91EA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 21:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781A5272816;
	Sun,  9 Nov 2025 21:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+DrKrzn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8483263F38;
	Sun,  9 Nov 2025 21:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762722808; cv=none; b=P8/zlsMDc5eg0OR0FVLRMRNumCwGGfgemJPwKgWkoLuHxZOrkhxJ1sSM6Dum0wNGrZTy2AK1Leb1KJ1SWsE0VX+GW5ATQapLj4mO2h+Yu+3dnoFYxZh5gLwVmraNJB3zN9GjNShZ3m0UDZ8BA5YmHR6wjomos4F0YK5DZUOfZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762722808; c=relaxed/simple;
	bh=mlYOb4HtaVV/70l/JDdVHAwQod1IKKXY70EZg+ntWnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OiZs5UyXdCRbIoLrjq9PdoClsjFfY4WZiDeMnjR0D3GyRZVrok//bHvi980/uIcgeCCHWF7Jz8YGMYuiM4RXb9Wkv+fbiyzw3CcR/SvJO2Ef7YxH5QbByC8vwkonxHpYSwCo/EanpuR+we11xDjagp2aq9E8AKq/WO46Y/jNxRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+DrKrzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F24C4CEFB;
	Sun,  9 Nov 2025 21:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762722808;
	bh=mlYOb4HtaVV/70l/JDdVHAwQod1IKKXY70EZg+ntWnk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l+DrKrznMk291oiVMWT2W4NyaJYSkfWs7q3kVFizjoDJqZTWCOS66w7a8g8aNoWdE
	 O7uXo10XIvPe/hN4h+wklQWdPrbg8uR0cQFI46Y4ZIQ7rxWBzkVgkhUpleMeeXD6ua
	 XBouleJ/3pkd23cxOkeDbZKPiqgJ9fcC2c7k/JRHXpDqzzHdsStfbfiEE+sEq5uG9T
	 x8ffhtyTxMc+UwV9n9EenhmCSMWxHqXqqpkkyj6ZFz5gaSXnhZKyfE4QcTdf+YWoc/
	 EtcXmD/3frLj4LGSESY7u8R58UTP2nJXHX+otc52oSYTT5y8/HCHuZn49cmNnjNW6p
	 gD/Eubs4eqLdA==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 09 Nov 2025 22:11:23 +0100
Subject: [PATCH 2/8] ns: don't increment or decrement initial namespaces
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-namespace-6-19-fixes-v1-2-ae8a4ad5a3b3@kernel.org>
References: <20251109-namespace-6-19-fixes-v1-0-ae8a4ad5a3b3@kernel.org>
In-Reply-To: <20251109-namespace-6-19-fixes-v1-0-ae8a4ad5a3b3@kernel.org>
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3636; i=brauner@kernel.org;
 h=from:subject:message-id; bh=mlYOb4HtaVV/70l/JDdVHAwQod1IKKXY70EZg+ntWnk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQKMr9Y2vOUpf28kGpY723eh/uP9O8XqmcvZDKIq3VgY
 f7sEbqko5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCL8VxkZjm255bWQI0Pxl2/H
 gotSs5lCFx4/0JmzPVwy4yiLoGPTDob/bmaKT1YJ3tJI+hvHVmeaMeuq2lapcx4Lj24oq9LIn3y
 FEQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

There's no need to bump the active reference counts of initial
namespaces as they're always active and can simply remain at 1.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/ns_common.h | 23 ++++++++++++++++++++---
 kernel/nscommon.c         |  6 ++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index bd4492ef6ffc..791b18dc77d0 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -141,6 +141,12 @@ static __always_inline bool is_initial_namespace(struct ns_common *ns)
 				 IPC_NS_INIT_INO - MNT_NS_INIT_INO + 1));
 }
 
+static __always_inline bool is_ns_init_id(const struct ns_common *ns)
+{
+	VFS_WARN_ON_ONCE(ns->ns_id == 0);
+	return ns->ns_id <= NS_LAST_INIT_ID;
+}
+
 #define to_ns_common(__ns)                                    \
 	_Generic((__ns),                                      \
 		struct cgroup_namespace *:       &(__ns)->ns, \
@@ -285,14 +291,19 @@ void __ns_ref_active_get_owner(struct ns_common *ns);
 
 static __always_inline void __ns_ref_active_get(struct ns_common *ns)
 {
-	WARN_ON_ONCE(atomic_add_negative(1, &ns->__ns_ref_active));
-	VFS_WARN_ON_ONCE(is_initial_namespace(ns) && __ns_ref_active_read(ns) <= 0);
+	/* Initial namespaces are always active. */
+	if (!is_ns_init_id(ns))
+		WARN_ON_ONCE(atomic_add_negative(1, &ns->__ns_ref_active));
 }
 #define ns_ref_active_get(__ns) \
 	do { if (__ns) __ns_ref_active_get(to_ns_common(__ns)); } while (0)
 
 static __always_inline bool __ns_ref_active_get_not_zero(struct ns_common *ns)
 {
+	/* Initial namespaces are always active. */
+	if (is_ns_init_id(ns))
+		return true;
+
 	if (atomic_inc_not_zero(&ns->__ns_ref_active)) {
 		VFS_WARN_ON_ONCE(!__ns_ref_read(ns));
 		return true;
@@ -307,6 +318,10 @@ void __ns_ref_active_put_owner(struct ns_common *ns);
 
 static __always_inline void __ns_ref_active_put(struct ns_common *ns)
 {
+	/* Initial namespaces are always active. */
+	if (is_ns_init_id(ns))
+		return;
+
 	if (atomic_dec_and_test(&ns->__ns_ref_active)) {
 		VFS_WARN_ON_ONCE(is_initial_namespace(ns));
 		VFS_WARN_ON_ONCE(!__ns_ref_read(ns));
@@ -319,8 +334,10 @@ static __always_inline void __ns_ref_active_put(struct ns_common *ns)
 static __always_inline struct ns_common *__must_check ns_get_unless_inactive(struct ns_common *ns)
 {
 	VFS_WARN_ON_ONCE(__ns_ref_active_read(ns) && !__ns_ref_read(ns));
-	if (!__ns_ref_active_read(ns))
+	if (!__ns_ref_active_read(ns)) {
+		VFS_WARN_ON_ONCE(is_ns_init_id(ns));
 		return NULL;
+	}
 	if (!__ns_ref_get(ns))
 		return NULL;
 	return ns;
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index d67ae7ad7759..70cb66232e4c 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -177,6 +177,7 @@ void __ns_ref_active_put_owner(struct ns_common *ns)
 		ns = ns_owner(ns);
 		if (!ns)
 			return;
+		VFS_WARN_ON_ONCE(is_ns_init_id(ns));
 		if (!atomic_dec_and_test(&ns->__ns_ref_active))
 			return;
 	}
@@ -276,6 +277,10 @@ void __ns_ref_active_put_owner(struct ns_common *ns)
  */
 void __ns_ref_active_resurrect(struct ns_common *ns)
 {
+	/* Initial namespaces are always active. */
+	if (is_ns_init_id(ns))
+		return;
+
 	/* If we didn't resurrect the namespace we're done. */
 	if (atomic_fetch_add(1, &ns->__ns_ref_active))
 		return;
@@ -289,6 +294,7 @@ void __ns_ref_active_resurrect(struct ns_common *ns)
 		if (!ns)
 			return;
 
+		VFS_WARN_ON_ONCE(is_ns_init_id(ns));
 		if (atomic_fetch_add(1, &ns->__ns_ref_active))
 			return;
 	}

-- 
2.47.3



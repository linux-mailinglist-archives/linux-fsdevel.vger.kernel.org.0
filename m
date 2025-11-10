Return-Path: <linux-fsdevel+bounces-67710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC2DC47788
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6049F4F22DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9393F327210;
	Mon, 10 Nov 2025 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbHGDJBl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D59314B85;
	Mon, 10 Nov 2025 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787384; cv=none; b=JV/fdGN2PuHHwoxXq2OAUzdTYLUADrNvoAVJNHCQdFbHIUvGpfu1UX0hvJMhhWPDEaAiZ2W7uJUw4RyWBDQ05w+66+JoOkTzZ0xOIuK5FFXeroMTnRZ34vsGHoedaWgivu4SkzmjeOcAT1h1E/4U/5xRcw8uOj6kr4/8FZEICHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787384; c=relaxed/simple;
	bh=1lRr2nELbuCCV2FW5us5ZoDReNBE/v5ees9ZWMkotiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=quBiQkaa/B5FKa0zmanpF6DtyzAJcxYaLLTlnZc/yrTSDtSkB3VQFSg7igRohlub2IOXPEeaH1S5pk6Ucc5Dft//Yw9bGkbrtc9qHJsP+PZ2JJOh5InuCQPelwJA433r+4MtLAGkJI6a7cUKRBlZTQTxdkHMDjmOPsjFUKDwY38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbHGDJBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25034C2BC86;
	Mon, 10 Nov 2025 15:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762787383;
	bh=1lRr2nELbuCCV2FW5us5ZoDReNBE/v5ees9ZWMkotiw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MbHGDJBlhoCU6sbzjxxyIy7KgHB2FMPP/HvLFXrWhGa/CkMxCy7FE/tPDFwRlkFbe
	 ZN4PMLTkmjKbs9wvbtbh+dip+eGzxkjBd170/i7eUAdEObUHk7PqyBNP3NdqYxOOtP
	 PHRx3h7PFNRi2Xo94JmuTx09FjeUN54mVrF7r8KKDadTtaCYR1bbzv3XsU1vRzVPdk
	 48aejf8vCk4aERBeTOSff9ZEF7fk3LS5iuWKVKG10Fu8E7iRJY2lBH5IzOkDY+Atgb
	 Dr8PKB2dYvo7SU9V6O1v6fAnzUWyyEesvwXN4WpQ9LSXG+HES7skmceyX++LxUUMj2
	 fF/niiJ7aFL4Q==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 10 Nov 2025 16:08:24 +0100
Subject: [PATCH 12/17] ns: make all reference counts on initial namespace a
 nop
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-work-namespace-nstree-fixes-v1-12-e8a9264e0fb9@kernel.org>
References: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
In-Reply-To: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2281; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1lRr2nELbuCCV2FW5us5ZoDReNBE/v5ees9ZWMkotiw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQK/v/M9+9c9vG+hbuPRe6uXsE3S1Wsf9HvT5b/3iwrX
 u4+7dKWlx2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATmWvD8D84d1ed8kwZ/ilM
 i2baRhwqTtB696PrSK5QXUbCp64rYtwMv9nFdu7e9/VepNbcxKZ1J5eryAsXnVpfV2lzuVrzyRl
 TI34A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

They are always active so no need to needlessly cacheline ping-pong.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/ns_common.h | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index b9e8f21a6984..5b8f2f0163d7 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -62,6 +62,8 @@ static __always_inline __must_check int __ns_ref_active_read(const struct ns_com
 
 static __always_inline __must_check bool __ns_ref_put(struct ns_common *ns)
 {
+	if (is_ns_init_id(ns))
+		return false;
 	if (refcount_dec_and_test(&ns->__ns_ref)) {
 		VFS_WARN_ON_ONCE(__ns_ref_active_read(ns));
 		return true;
@@ -71,6 +73,8 @@ static __always_inline __must_check bool __ns_ref_put(struct ns_common *ns)
 
 static __always_inline __must_check bool __ns_ref_get(struct ns_common *ns)
 {
+	if (is_ns_init_id(ns))
+		return true;
 	if (refcount_inc_not_zero(&ns->__ns_ref))
 		return true;
 	VFS_WARN_ON_ONCE(__ns_ref_active_read(ns));
@@ -82,12 +86,27 @@ static __always_inline __must_check int __ns_ref_read(const struct ns_common *ns
 	return refcount_read(&ns->__ns_ref);
 }
 
+static __always_inline void __ns_ref_inc(struct ns_common *ns)
+{
+	if (is_ns_init_id(ns))
+		return;
+	refcount_inc(&ns->__ns_ref);
+}
+
+static __always_inline __must_check bool __ns_ref_dec_and_lock(struct ns_common *ns,
+							       spinlock_t *ns_lock)
+{
+	if (is_ns_init_id(ns))
+		return false;
+	return refcount_dec_and_lock(&ns->__ns_ref, ns_lock);
+}
+
 #define ns_ref_read(__ns) __ns_ref_read(to_ns_common((__ns)))
-#define ns_ref_inc(__ns) refcount_inc(&to_ns_common((__ns))->__ns_ref)
+#define ns_ref_inc(__ns) __ns_ref_inc(to_ns_common((__ns)))
 #define ns_ref_get(__ns) __ns_ref_get(to_ns_common((__ns)))
 #define ns_ref_put(__ns) __ns_ref_put(to_ns_common((__ns)))
-#define ns_ref_put_and_lock(__ns, __lock) \
-	refcount_dec_and_lock(&to_ns_common((__ns))->__ns_ref, (__lock))
+#define ns_ref_put_and_lock(__ns, __ns_lock) \
+	__ns_ref_dec_and_lock(to_ns_common((__ns)), __ns_lock)
 
 #define ns_ref_active_read(__ns) \
 	((__ns) ? __ns_ref_active_read(to_ns_common(__ns)) : 0)

-- 
2.47.3



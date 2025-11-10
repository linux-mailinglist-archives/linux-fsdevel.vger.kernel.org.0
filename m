Return-Path: <linux-fsdevel+bounces-67712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 009B9C477B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6F33B4553
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B0D329379;
	Mon, 10 Nov 2025 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4pHJ6Nf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EB63195EB;
	Mon, 10 Nov 2025 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787394; cv=none; b=dTAbEsDvIe2vHS1c49t4l2Ir6U1BrW+GoyQmaq7e1sBuk+vnPMA8dDt90mHhOjpUpSTncCU6heiRjdDlwh7CB+T+q8gvL5JbijgPoKdbtInS0b2kAO17WHn2o8p5s4VOAipxinDStD1jf2Lw07w2eaNLyY55RsDvFWTirvOaZNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787394; c=relaxed/simple;
	bh=HSueTNLDLiciDnAbEMop6IvyniLLhSYMaO0aax1SYAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sZPrFKjmudKnYZMjW4KtBOiBDWP/PDDopi8b+trBBXz4X5PZ/U7WE2O4b6FfscH45+CaKzixm4WBTnri+l+DSF2qWqlUgxrxf58K+Z8JLxhySgnBJq/ZZEUjkw8tQrdv8PnsVppoWTj1lBfRFGUAzwcuBGDVJwSqZMhGJ5amZN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4pHJ6Nf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68462C113D0;
	Mon, 10 Nov 2025 15:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762787394;
	bh=HSueTNLDLiciDnAbEMop6IvyniLLhSYMaO0aax1SYAQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y4pHJ6NfYU8jHVGl6PaxVvNGysGpDRQIvSgp6E1e37g5XafV8tHQww//n8B2CAYEp
	 9pxvdLFu8aAXm9EdQpDTzu36c8NDsoAY9cTn/gzcgnSwwSymSiPv4M4w6kZcYwD5bA
	 ZAhQpcZWP1o7FH51SKWAnqQHGlMMQrV3/yD5lRbI+P6Rww64VmBYG1hCdPm5pCPkbS
	 rEvTKspL+aUWoStaQIJYa0t3QPDaP94tRKRh3h+Aa2CP81tKlw2d29n21Lz4lcIzvB
	 sdHZVMmLoai2T/l2/Ksut/t9EFG2irGeHjT5hWIMg4Bor4SkhKtaexvrdgqNgxXS1l
	 6VJWyVsVT5MCg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 10 Nov 2025 16:08:26 +0100
Subject: [PATCH 14/17] ns: add asserts for initial namespace active
 reference counts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-work-namespace-nstree-fixes-v1-14-e8a9264e0fb9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HSueTNLDLiciDnAbEMop6IvyniLLhSYMaO0aax1SYAQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQK/v/cu7mrXSNqrnQ9y1Z/fa+4c7abH4dP3lytbTV57
 snnSc+EOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYi1MbIsPVkTc+FpE2/N2Ve
 VmZg/nvka/j56pbKI+7t7nXe7TGhDAz/g+YV1MdnrfmqFfwkkz/79aSe1H59uXNTLsnO/JkSf/Q
 ZBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

They always remain fixed at one. Notice when that assumptions is broken.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/ns_common.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index dfb6b798ba82..43f709ab846a 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -69,6 +69,7 @@ static __always_inline __must_check bool __ns_ref_put(struct ns_common *ns)
 {
 	if (is_ns_init_id(ns)) {
 		VFS_WARN_ON_ONCE(__ns_ref_read(ns) != 1);
+		VFS_WARN_ON_ONCE(__ns_ref_active_read(ns) != 1);
 		return false;
 	}
 	if (refcount_dec_and_test(&ns->__ns_ref)) {
@@ -82,6 +83,7 @@ static __always_inline __must_check bool __ns_ref_get(struct ns_common *ns)
 {
 	if (is_ns_init_id(ns)) {
 		VFS_WARN_ON_ONCE(__ns_ref_read(ns) != 1);
+		VFS_WARN_ON_ONCE(__ns_ref_active_read(ns) != 1);
 		return true;
 	}
 	if (refcount_inc_not_zero(&ns->__ns_ref))
@@ -94,6 +96,7 @@ static __always_inline void __ns_ref_inc(struct ns_common *ns)
 {
 	if (is_ns_init_id(ns)) {
 		VFS_WARN_ON_ONCE(__ns_ref_read(ns) != 1);
+		VFS_WARN_ON_ONCE(__ns_ref_active_read(ns) != 1);
 		return;
 	}
 	refcount_inc(&ns->__ns_ref);
@@ -104,6 +107,7 @@ static __always_inline __must_check bool __ns_ref_dec_and_lock(struct ns_common
 {
 	if (is_ns_init_id(ns)) {
 		VFS_WARN_ON_ONCE(__ns_ref_read(ns) != 1);
+		VFS_WARN_ON_ONCE(__ns_ref_active_read(ns) != 1);
 		return false;
 	}
 	return refcount_dec_and_lock(&ns->__ns_ref, ns_lock);

-- 
2.47.3



Return-Path: <linux-fsdevel+bounces-66225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 064FAC1A34C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EE5E4F6813
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AF334FF63;
	Wed, 29 Oct 2025 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubZripBN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A457D343D70;
	Wed, 29 Oct 2025 12:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740499; cv=none; b=QZm3EyzwoIzg2ysI1+myavzP9pjzuglem7BNFDWqtNr4nlfC/Qv7Zsl5o2ZsYKcpULZrO6U0lIXDIMOdpvMYEFjIXJGh4BWyBLkvSx/zFM2BtUM77AiAUSFZDYhBBur5omqG+wODdigMM5/gvjzzJcKkaj/PVAAXwNiJtIUjcpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740499; c=relaxed/simple;
	bh=lN89dkAc1rJX+YACfmrA/G36BNwMab+4/KHiS7lDb0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VEYtTcf46LeREvvCh9JQwzU+iZJyMd+U9Hum84pGGoEzNPQLfpxDE/Xz44g4w1K8xsRqkS5I+MxwGHRvRE48ecCLzW0vbHi1o4o2BdOFocgnI6K1I69athf45OYxDla7FDecwbTU1TEwK32MfTVJOl8u4qaXJWmgXDGvB5HwkvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubZripBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60D1C4CEFF;
	Wed, 29 Oct 2025 12:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740499;
	bh=lN89dkAc1rJX+YACfmrA/G36BNwMab+4/KHiS7lDb0g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ubZripBNNV11xLKcOL51HnpwGrLNf6h89ffYdkix6iUr6BLrpxWWvHTvMZq/S9Dgc
	 jjlSIe5FhNrGWPIQyOIGdeyZf/QVZUtsdMRKXgn/NoIIgGuqmxJMbHgvGA9Op0E0YZ
	 c/SwKk8vjtQoA99i+29sXHcAqDI23lxfu7y5LX5hGXfufLeLnDd5xod5yKNS7lByCs
	 yqUy2rfTpjyKLMNooTa7gAP5P6e8LKD890Dma9n/F/g0MbZ80G2bw3tZNYhqUQ37tt
	 PjMcmm4M/W+aD7X6vgP+dw6JD7ogD9PPiImlSygT5DH+HWKZRpDPP7IAXc1ZZoWLjP
	 +SaK4Fy2xHTfA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:25 +0100
Subject: [PATCH v4 12/72] ns: use anonymous struct to group list member
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-12-2e6f823ebdc0@kernel.org>
References: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
In-Reply-To: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
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
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=775; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lN89dkAc1rJX+YACfmrA/G36BNwMab+4/KHiS7lDb0g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfVwuDVnOuzbuGdq+7+NpsuNO/dsmpMg3p22bNEWs
 XPfXy9f11HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARtgqG/9lmcb+eL7SYp3WT
 +dGXzxKKHK1XV3sw/IzU+M16+AkvawTDP1Wblo31HyJ/5FzetnmntNiiQOfTNntrdxX1rFhhZdE
 yjwUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make it easier to spot that they belong together conceptually.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/ns_common.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index bec01741962d..adc3542042af 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -109,8 +109,10 @@ struct ns_common {
 	union {
 		struct {
 			u64 ns_id;
-			struct rb_node ns_tree_node;
-			struct list_head ns_list_node;
+			struct /* per type rbtree and list */ {
+				struct rb_node ns_tree_node;
+				struct list_head ns_list_node;
+			};
 			atomic_t __ns_ref_active; /* do not use directly */
 		};
 		struct rcu_head ns_rcu;

-- 
2.47.3



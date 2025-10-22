Return-Path: <linux-fsdevel+bounces-65139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3A2BFD127
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFE3C508CD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07F02D0274;
	Wed, 22 Oct 2025 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuGyKgnS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2920227A129;
	Wed, 22 Oct 2025 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149224; cv=none; b=XRcjaEmEeDNSsiQzrJunRhzct6f8ZNn0F8b3c8Dgn/dMeL+MdU2i3MG1u4+PTGdvnbfQ/XATn0NlxDfOhwKFgGk9ziewGyEPLPpNiFH2cItR5GeqSsBhx5VS8dgG6NSWOw3VGDHzzjwgEZwhXRZVSQLEw54CrmKYwBldEGpRqrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149224; c=relaxed/simple;
	bh=BQTckd1lwN42TzFjtcvMTDlqbwW0nSU43xXjRiLpTAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqJ2dL8s6Jv8iSGc8m9AuH2WRzQH9ntKL1CESWkVuDKV4XJix40ivg+CKqewINNQuhUaRHEJKEd9j6L0LY+A/vocWEmyf2f8T+NdQYiBx9IJYHnhoJDG3EwZlaQiZLqmERPp60CornMn3Tb2+4IgQzQeuMjDvtXXAr4ImEY5njs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuGyKgnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E4FC4CEE7;
	Wed, 22 Oct 2025 16:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149224;
	bh=BQTckd1lwN42TzFjtcvMTDlqbwW0nSU43xXjRiLpTAc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CuGyKgnSDuCkBcGOsZyzu/GT4DQb2+JiyLBHtJNlGRTVxUpFGrOcoltIeQNb7eQgM
	 m1Cja7A86ViaW5mlORm27W3MMNI4YDAZHBqIg2qh6WDbvDIxo5fLX9f1eytyoYNRpU
	 50JZ13MDJT+n3qy5uXRwEfuaFdpRXMzJhtzZbtJo4cuUQ0+axlRr0a/TrSXLWnE9LY
	 x20e73TfBGJN7shGonKyVv0/hYPSpTJtBHlGxud6FJG6GqBmBzsmbkwyG/kBYpP22x
	 /90ptKQP3N9dx/CjT1cEMl3NSrheBfk+MArQgdjAriIwi+yRmbaT1NuejppZW2UYMC
	 LOF33Lavu473Q==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:05:49 +0200
Subject: [PATCH v2 11/63] ns: use anonymous struct to group list member
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-11-71a588572371@kernel.org>
References: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
In-Reply-To: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
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
 h=from:subject:message-id; bh=BQTckd1lwN42TzFjtcvMTDlqbwW0nSU43xXjRiLpTAc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHhyW23hLO6ehQd2T9K7JOGZWCa0pP2S+/rK7CXx2
 zjnnJJT6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI6QpGhveCH9TeKlzp78v9
 lvvKJZTRSSapltfjrlr/Zs+THboh+xn+SouF7fi2xrL7apVR2wzJ2B6hlEnmYQ2hH/QvZCkptK9
 gBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make it easier to spot that they belong together conceptually.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/ns_common.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 77ea38d8bac9..f340a279acc2 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -115,8 +115,10 @@ struct ns_common {
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



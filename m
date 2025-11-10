Return-Path: <linux-fsdevel+bounces-67699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF53C476BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 252CC4ED080
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFF631770B;
	Mon, 10 Nov 2025 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nr/p9dc1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E423164A8;
	Mon, 10 Nov 2025 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787332; cv=none; b=ZpSlTXqfGYgAedHmPyGAh4CEwO/1agzq21t+kScb9i9VsjNGYIETCV1WG+JS/Tc4lIMareIBduGSOm3/OL1A14Z1RDQRO9/COV2LAh0NT24MNbBB+t2tDcsYFfAXmWEAuloivXAH4pB20NYU9NWZ593d51eDsRpN4xPp3fiLxz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787332; c=relaxed/simple;
	bh=861lr7p/ihvjgrhgvEVNz229AXQiMKfXnK7oj7F0dgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EHGoSiKKlMeWSB03dQL2eRgF6R4+jEKQ7NvA1A622p2WiYer3hYNCwJ/wyD9bjaE6dMHLtmo0/4fC+lR8OrnZsH6ODDpngmhfhb41jzzIi9yPlgBrEhOlWeS2weZ1WgBvDVqqA0ld903ToVooQEMrGij+QiHXJXkIPbJJ9ZdEN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nr/p9dc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448E1C4CEFB;
	Mon, 10 Nov 2025 15:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762787331;
	bh=861lr7p/ihvjgrhgvEVNz229AXQiMKfXnK7oj7F0dgw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nr/p9dc1D/IwG0q1XZYoLHhPyx9J73BZHgDPhjjthQLQMIdOIJkDj2ny456/I6m5t
	 XX0akQz3JfutblQRL4Om9gXySzRLdSm6Ig+qnY2jWZFPqvnXEx5aBErUFg2WwXR5T4
	 zvZi4zj8eLajZ1g59UXEkzq9e69aTk952nB4Tz3Yy/HScCsiwZdaWYiaVIs0YOM671
	 MYNb/MTpCQUAJcZ3B5ZaV3MXXge+QMX1DSlYFW+lUookLNAh+rjYrPH7nKvOaWpb6i
	 NZoCCystquoegG1oT1sb1rO9WQIGaKV7IXzjMMPrlMJwIBWe23UrV6kLQ4M18PYpOW
	 ZyR3a5OQ6L4Cw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 10 Nov 2025 16:08:14 +0100
Subject: [PATCH 02/17] nstree: decouple from ns_common header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-work-namespace-nstree-fixes-v1-2-e8a9264e0fb9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; i=brauner@kernel.org;
 h=from:subject:message-id; bh=861lr7p/ihvjgrhgvEVNz229AXQiMKfXnK7oj7F0dgw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQK/v+casjzYu0e9akMc54x/9+6O5dZKFlspvqcg9Jnc
 sL/ln/e21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR0zKMDO/lVr3Yxqyl5nTb
 baXIFpGLya8iNVXzq78ENrR5qPed52T4Z5Bqlti6V++nkuqMl6vkaiTKSlbv3iB1OWX273lpqfG
 RfAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Foward declare struct ns_common and remove the include of ns_common.h.
We want ns_common.h to possibly include nstree structures but not the
other way around.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/nstree.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/nstree.h b/include/linux/nstree.h
index 38674c6fa4f7..25040a98a92b 100644
--- a/include/linux/nstree.h
+++ b/include/linux/nstree.h
@@ -3,7 +3,6 @@
 #ifndef _LINUX_NSTREE_H
 #define _LINUX_NSTREE_H
 
-#include <linux/ns_common.h>
 #include <linux/nsproxy.h>
 #include <linux/rbtree.h>
 #include <linux/seqlock.h>
@@ -11,6 +10,8 @@
 #include <linux/cookie.h>
 #include <uapi/linux/nsfs.h>
 
+struct ns_common;
+
 extern struct ns_tree cgroup_ns_tree;
 extern struct ns_tree ipc_ns_tree;
 extern struct ns_tree mnt_ns_tree;

-- 
2.47.3



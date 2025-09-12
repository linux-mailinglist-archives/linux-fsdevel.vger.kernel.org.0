Return-Path: <linux-fsdevel+bounces-61050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD924B54BC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 13:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567E33B5A11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 11:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA18307ACA;
	Fri, 12 Sep 2025 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1jwei3d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7B130149D;
	Fri, 12 Sep 2025 11:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678009; cv=none; b=NvRzBIs+/DhKhmVEgsiOcZAa/6JAFmoJKkLX/2HZAOwp8ydiZ1tN7HseTkC3bclANKqKAKAfrzh28WXMYbHREpChNKlz/RYcRO/ZJ2P97Cs+LkEhCS0Jo0IMNEX0IYrpqQ75VrtKRTodDYkTanVGydvJU9T2HOpHqfGMJsOHlJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678009; c=relaxed/simple;
	bh=2f9D9zlv8glj5NHoHJEYXgqnV3d87eXkc66AyXu1nIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gbpN0M2tsdnI6e0sPUd4UJedmdiJfgm1wuKD7oU1fefvvxehNfHF01tq9tgeHmvtoDnYQXBlk+F14R1F2+vHBj4YpLh5+6alqkJ7r/FaewF5FjmMirq+2FiDS8x3K7qDaHkFJi4VBG3kz4Ja7mY/SK+EUHIvs1l45MDwlqJpgO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1jwei3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E2EC4CEF4;
	Fri, 12 Sep 2025 11:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678009;
	bh=2f9D9zlv8glj5NHoHJEYXgqnV3d87eXkc66AyXu1nIw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o1jwei3d13zi20PiI7abD1Im4WbV5ICLW/1qP9cJby/9+mK9NRncKRQRT1ljIWW0b
	 WuvyJVG2XONXhwE7R7c8lAx2Gs4zMkPjtSJ/hlVJ7T8L7iZ1RYm+UHGW4sP5THefbi
	 nGXQ+dS7OJ+e58zuLyVKeBosalQsLJmoaUPGDUqcUQqfA7XltHPnSnAQ8NU/TGbGxc
	 ONqaHYp0eZOEP6hqqFPggCxRRSCPqiwXzZkX5jrhaKbHS/ZOb0cedB3klaqR/IhsfQ
	 pImq/UXNdlBLk3x1fzOqyoVozOFEe7fMfEWILEYjnF2TeCxLRJGw3XSEypJOIwGdk+
	 gXa4IkHutllfw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:28 +0200
Subject: [PATCH v2 05/33] ns: move to_ns_common() to ns_common.h
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-5-1a247645cef5@kernel.org>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
In-Reply-To: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=2229; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2f9D9zlv8glj5NHoHJEYXgqnV3d87eXkc66AyXu1nIw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4Zyy0S318uq1hiK5yx2+RgXEOxn3nbmk2+PFwplYc
 e0B2/0THaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPpFWZkOK8t92Cx6YPMVWW7
 4mbJcd3vPlO629/Vq4WhtV8qfH1LCMP/NIl/j898SzsgcZzp9UL2Gx0VJ3858ltmPFA/1v1vUWE
 qBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Move the helper to ns_common.h where it belongs.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/ns_common.h | 20 ++++++++++++++++++++
 include/linux/nsproxy.h   | 11 -----------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 7d22ea50b098..bc2e0758e1c9 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -6,6 +6,15 @@
 
 struct proc_ns_operations;
 
+struct cgroup_namespace;
+struct ipc_namespace;
+struct mnt_namespace;
+struct net;
+struct pid_namespace;
+struct time_namespace;
+struct user_namespace;
+struct uts_namespace;
+
 struct ns_common {
 	struct dentry *stashed;
 	const struct proc_ns_operations *ops;
@@ -13,4 +22,15 @@ struct ns_common {
 	refcount_t count;
 };
 
+#define to_ns_common(__ns)                              \
+	_Generic((__ns),                                \
+		struct cgroup_namespace *: &(__ns)->ns, \
+		struct ipc_namespace *:    &(__ns)->ns, \
+		struct mnt_namespace *:    &(__ns)->ns, \
+		struct net *:              &(__ns)->ns, \
+		struct pid_namespace *:    &(__ns)->ns, \
+		struct time_namespace *:   &(__ns)->ns, \
+		struct user_namespace *:   &(__ns)->ns, \
+		struct uts_namespace *:    &(__ns)->ns)
+
 #endif
diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index dab6a1734a22..e6bec522b139 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -42,17 +42,6 @@ struct nsproxy {
 };
 extern struct nsproxy init_nsproxy;
 
-#define to_ns_common(__ns)                              \
-	_Generic((__ns),                                \
-		struct cgroup_namespace *: &(__ns->ns), \
-		struct ipc_namespace *:    &(__ns->ns), \
-		struct net *:              &(__ns->ns), \
-		struct pid_namespace *:    &(__ns->ns), \
-		struct mnt_namespace *:    &(__ns->ns), \
-		struct time_namespace *:   &(__ns->ns), \
-		struct user_namespace *:   &(__ns->ns), \
-		struct uts_namespace *:    &(__ns->ns))
-
 /*
  * A structure to encompass all bits needed to install
  * a partial or complete new set of namespaces.

-- 
2.47.3



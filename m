Return-Path: <linux-fsdevel+bounces-65163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7414EBFD201
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C6A189D386
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667D8357716;
	Wed, 22 Oct 2025 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jayDfAsx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABEF2C031B;
	Wed, 22 Oct 2025 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149352; cv=none; b=KXHlFfRdbq+sdHpk4RJGETyzkfuCz7Eir9OcduiAUIRjPHVC11IBlHYzyb3RkrtZhd1VNY/ar2yOEbBScsGOiDkl+jSudgg717fSLWFVD7rJzDNrTAlT8UzU9zpHD2KC7i9dTXfJG/AA+jYkaqcCcpf9RUr+9OcpYLgO1sUNCU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149352; c=relaxed/simple;
	bh=WU3OpDiHSBOB5eonlPoaP8MJGbmszqupW5dQlbeASiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Czwkl89iVPCQk3nw85zCBQU9wijuxU83PeXxrWcZFCzxyQfSfspX4g3ap6wCs2Ej4nBOVxO59iilx6hfXNXHdPB/341ycd9Vn8bBo0tOk98DJ+GOb0QFnFmSwgDZqbJuwxy+Hu2SI7nkE11vVpVt0+wOdc5vsCad9Ha6+HXwYwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jayDfAsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A1CC4CEE7;
	Wed, 22 Oct 2025 16:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149352;
	bh=WU3OpDiHSBOB5eonlPoaP8MJGbmszqupW5dQlbeASiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jayDfAsxEpv1UY1fJryg7y7EeOxwiMC1cKs8w1p0nHsQpiK0O/UbR+dyzTdud+Fy1
	 Ll5/TQUjsIse2mYrFq36nYQbHz57QZAIX3oa9WlDn7L5ZiPBJug913YFlQNlqA07TN
	 aB+vQhZCtdQYUx9dvK08JK9eQ54d3WUtdZtrvdwM9SPosd6PXb9ztnXVZuiA0qCDmY
	 jejQlxn95GwqDUZ+U+SckQcuJqUi0SXa4zLc2UI0+IUZyykX6y+PPKhtPLqaUGgxZr
	 L16DVIi+qPKk/C5vk3LI2sc/wjJmfKOSKSG71b6mwOIsfvMz0oLxSU/8NdjtNLAlwz
	 nWgRZz6GVmdRA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:13 +0200
Subject: [PATCH v2 35/63] selftests/namespaces: add listns() wrapper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-35-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1405; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WU3OpDiHSBOB5eonlPoaP8MJGbmszqupW5dQlbeASiQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHgWIjlFZn1OzuJ+JqeLLcYOputc9k9sVfk083rt4
 SwmrYfaHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5Npvhn5n9I6mXv1k/Gsps
 2+fC+PXvHtm2l9ncvtK6tpw/P9fw3WBk+BstnTNt4p19J/f8zV772mbn8kRrg2tF/tpGK85LbVn
 hxwgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a wrapper for the listns() system call.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/wrappers.h | 35 +++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/namespaces/wrappers.h b/tools/testing/selftests/namespaces/wrappers.h
new file mode 100644
index 000000000000..9741a64a5b1d
--- /dev/null
+++ b/tools/testing/selftests/namespaces/wrappers.h
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/nsfs.h>
+#include <linux/types.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#ifndef __SELFTESTS_NAMESPACES_WRAPPERS_H__
+#define __SELFTESTS_NAMESPACES_WRAPPERS_H__
+
+#ifndef __NR_listns
+	#if defined __alpha__
+		#define __NR_listns 580
+	#elif defined _MIPS_SIM
+		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
+			#define __NR_listns 4470
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
+			#define __NR_listns 6470
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
+			#define __NR_listns 5470
+		#endif
+	#else
+		#define __NR_listns 470
+	#endif
+#endif
+
+static inline int sys_listns(const struct ns_id_req *req, __u64 *ns_ids,
+			     size_t nr_ns_ids, unsigned int flags)
+{
+	return syscall(__NR_listns, req, ns_ids, nr_ns_ids, flags);
+}
+
+#endif /* __SELFTESTS_NAMESPACES_WRAPPERS_H__ */

-- 
2.47.3



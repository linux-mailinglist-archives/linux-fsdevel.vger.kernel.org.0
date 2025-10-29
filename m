Return-Path: <linux-fsdevel+bounces-66251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AD7C1A456
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 314E035802D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9695837573C;
	Wed, 29 Oct 2025 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+FPOYdD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F4374AC7;
	Wed, 29 Oct 2025 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740632; cv=none; b=WPKGcaR6PI9eaH1RyxKB2B8JoLM5wdFwjo3fHkUVOcgiEvQz9lr4AEO1YqCHGT5uIUEPuLOrmcUNE3ycBMrzdfqMMEX65/Yh0RVR1dT7hTYQUxjowlhqF3Mvwvt+G1/c5UsTvU0JDV2b/InN4fEhFoK6SwExfmd7a7QIY4CY+E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740632; c=relaxed/simple;
	bh=WU3OpDiHSBOB5eonlPoaP8MJGbmszqupW5dQlbeASiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S33/7oW74O+w+08CyoQ4yMTVMnbval5G0l6RK63vEHZjre8FFcS8fziydVaPbkttUpqBk1DVR/6kHCv3BD9YNhkbvVtX3hf/nrr7wo4h1wflK4tr9tE7AHSn2cis5zuKIFF5f9pdMgtbTKYvFzSf2KyVCTRoIdt+YvZKnnc/w9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+FPOYdD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E86C4CEF7;
	Wed, 29 Oct 2025 12:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740631;
	bh=WU3OpDiHSBOB5eonlPoaP8MJGbmszqupW5dQlbeASiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L+FPOYdDZZo/BeqdGByNQMyfLG+Kt3tsoH4nlwcYDBngbxLfcUNmcdy72T3ESY8vc
	 tUVDct/m8Yf0qHEJWYNBdijhe9KJiyqJWc2J1iIxOAHSmNEyAHKI353ZgMaZQG4ny1
	 JU+yzCCtO1QLxuQH43CvxXsKaPJSM4DxpZHh9rWSGz04YMCuq4ZdQN+ZzCKhpHu9yv
	 AAniDr3nyH9eQXFAYDbiLLnP/gngImUYjUVo0A7u71h4mj9Sgz+ye7fPZNih6oi6o3
	 JoVb9axV76IKue0Hvs/zVesjl0NYVF08xgcwEn9pL7rAfQFtbkZZVs72XD1iGQ6TrW
	 bS5QO96N53biw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:51 +0100
Subject: [PATCH v4 38/72] selftests/namespaces: add listns() wrapper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-38-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1405; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WU3OpDiHSBOB5eonlPoaP8MJGbmszqupW5dQlbeASiQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfVVdReE/1/FyLN48bEbkRMnXWbZf/ajzmV5y1t3v
 Uw5G7bZdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExklTPDP2s15dW+nUo7fc+8
 5VmatXTmF7eU1k9PnLMOLWVr3WO/ToGRYZLvxf+n1+UF/au6zbfzCb+6S4NNZua2v8/FVV4KTt0
 TxAcA
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



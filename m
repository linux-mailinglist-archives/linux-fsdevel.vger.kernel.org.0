Return-Path: <linux-fsdevel+bounces-65476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C7FC05D6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291A41C26553
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E04347FCB;
	Fri, 24 Oct 2025 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzI/e047"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F5E314B69;
	Fri, 24 Oct 2025 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303363; cv=none; b=phI5SV07GISmJmkk2ihZGcXcimEIJYZwaFI5DLutXglIOEychK5Bwj2MmG/GOPqYwua/Jd4L5iUTQJiqPTM7l/BQN5PdrVz2A53POHsSQnhJ4pu7r6H+8LoTrELch/98WXJL+SAUuX1q6mD8S/Tc0IYVOCWA7SYZBlfeaywOQMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303363; c=relaxed/simple;
	bh=WU3OpDiHSBOB5eonlPoaP8MJGbmszqupW5dQlbeASiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LaCrhDKAnZck+iA1XS3FTVBvU9M3Q3czFBnCBR8QFU5LgFAiTwLuKmP7KBM8MN7F/4/fwsUe7VxZYSGn7DVETuI5jog5HCGXmaHB/OnNjiN8NS3kiQdMDlL9fZSCU3HmLJpmILf/D8EdXLNp34c6ojYTcR+LaUwf/sviTQJ+RLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzI/e047; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926F0C4CEFF;
	Fri, 24 Oct 2025 10:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303363;
	bh=WU3OpDiHSBOB5eonlPoaP8MJGbmszqupW5dQlbeASiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pzI/e047vSvjARP4MMY8D3oYuvNqG+le1yU5USl711GJm/fNl4JaJTmlFc73uVb/d
	 G2mXBxPht0eLP/xByaZG75YpuPkjQ/kxxgnZ6lChwIpC6StAPb6uRzSBCUI8YE80Zc
	 HSOfxsrAFvfO3Np2NunE7+PYBG75QIZvt4Cd4Dd1VxrevxXtHZpCEvzGfk0tYiMXSZ
	 ttrzVWONCvIRZtqAOsprTBQU0ES3j4pYRcgEWfqvCEiKnQcMqXEtGgHwKn6QYhMOXq
	 Gw6m8PeDLYhY3tIMCBK5oo4ZxFseRy/OIdfHil0hAZboWjczHuYTHkPssAJTU8SDzU
	 tIXbRFjGZ3dYQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:05 +0200
Subject: [PATCH v3 36/70] selftests/namespaces: add listns() wrapper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-36-b6241981b72b@kernel.org>
References: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
In-Reply-To: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
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
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmpLO3jOWn7jyTUpjOn+OY/+raji73KZ+o/brf7dn
 XW/3tYFdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAFzkHMM/01XzJp7bZFIovneG
 rdk21u1NyR3+Ij1i+zS9r+udiAntYGT4oTFD9nBXrl0bt0rO7V9rktJfbN0U7cjxZLtJQHvZxkQ
 OAA==
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



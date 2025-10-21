Return-Path: <linux-fsdevel+bounces-64885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F5EBF6437
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 934C7503D1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065FE3491D2;
	Tue, 21 Oct 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+fux4gZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C95132F76F;
	Tue, 21 Oct 2025 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047211; cv=none; b=R3c5ZNRI6GE+Y0FMJhIdIN4cUnT7WLFHD6ZQvLik5FeYjbGEm23SHBuf87SgcAJGmxTpySeUIiK5izSLgo2hh7JXlBFAV/A879rW1dCCltS03VppCNpVDc3Mi9W9RBM0QV4C3LmJAVOcVMb5DR98c+29M5uq9iMCai+Kd6OPXvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047211; c=relaxed/simple;
	bh=WU3OpDiHSBOB5eonlPoaP8MJGbmszqupW5dQlbeASiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YXywNXrYRDfw5Y+gX0MfcAhYSIdQozGgT2XBzItlzSlvupEuBELi3Zm7PtcODdCJ9lzEvZyz78A15IMgntAdnNmHOPzaPl2r+s74yslcwcHDX6wd0GNuXEk+H8qZtBprTiPy/e6ywmnOUjxdeFzLVPdTEqsnB06Gz3AjRRu5zBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+fux4gZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C19CC4CEF1;
	Tue, 21 Oct 2025 11:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047210;
	bh=WU3OpDiHSBOB5eonlPoaP8MJGbmszqupW5dQlbeASiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R+fux4gZGrE0eeTJwEv601jLFgtJ5sHhYyPEXEZ52Nsx7bKXM95tGjSI75ndyNtl8
	 hjx1gNLTcONiC8gGPSoNrwLK8ArglmET+G3JonAOc2p5qoECjyAlJqwbJgG0m0DIdH
	 sT2ui+JJ+fMuZwdQPMPW6t6k3jYUCuJsM5tsocI72ENXrOhLEZ+lHVL4pWYMps71ip
	 r+xQmnpEclJs5QVBmAlzIJrPnF85WGImN3pNZV76rt80YThtQ0YrhQDYH0IDJLW7+N
	 pPMBn+VEcRlzA9qKjk7gFWqSmKYcMUh4fflPmLBCQ7Xls14CuAio9lrdJz1zExSJQu
	 f2Mj0GrQUrTRg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:40 +0200
Subject: [PATCH RFC DRAFT 34/50] selftests/namespaces: add listns() wrapper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-34-ad44261a8a5b@kernel.org>
References: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
In-Reply-To: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
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
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3wnulyI9cu5nVPmeqhfyj6d8v7bdKmc2XLyO3MmV
 C89v2FuRUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE9p9n+Cvxynb7lp2qlw1a
 uGb+jJmsmnLqv/NBu8P7ps2Rm37JbU8Lwz/jnyz/nVhVlYQTkz6FfOIOK66b5SPKHZLT8XNuYuG
 Vw7wA
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



Return-Path: <linux-fsdevel+bounces-16410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C97189D196
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 06:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48595284110
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 04:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9587A56742;
	Tue,  9 Apr 2024 04:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XR6VWoEr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6333399B;
	Tue,  9 Apr 2024 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712637841; cv=none; b=PpsRYWLQQfLcziOXBAs5ggDcu7c5qt211VjtwmXD1NJAeBgP0XWrXqHO+L2P82Ka0yIc90ufI2djbUwEPYLr4v7m+g1qyIlF0EO3QTdki87yc5kJ1qsK+kFSPgKWZH228eI97hq8W3YET0Sl1hzCYCl/M2VexY5VvxEJBwiWwko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712637841; c=relaxed/simple;
	bh=bDcauKtxgbpkQX74FEAfo2NPyUT++CTn+Q/La644a14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JtE302oORNBmvDaGxh1Qiv00eWsN7+SHF4qaT2K4zN/OhcM+L7/pzIDl1H4XQzfe1pHLjSjC9N17ENqBnpO7d5k15J0aiNeuEE0QcuQmwC20NwCDW2FNtmwDDv69RM5E2rMraRLjs8t0Q9WabIIGMKAczbZQMcq4ht8kxA32aYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XR6VWoEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884B3C43390;
	Tue,  9 Apr 2024 04:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712637840;
	bh=bDcauKtxgbpkQX74FEAfo2NPyUT++CTn+Q/La644a14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XR6VWoEr6C7UVwqHUKtLyLbUz4qYGSXAKHCNIiptwPWIDqrIfaLUWzoPePz7PtEuN
	 wphPVduavnbNUVefIAOcOagpySisqPOThq0VyJyyvwQ+4Y/Wg9+fri719oSGzkCEqs
	 H5r9GaaLlxtrlNrqkb2eHzkoAUrcBIxZ81SXnvUFpZGQ5J4vAZC9eVJJtGRlbnnLlB
	 RjwuSH3DdzSR/HtNH9Fd4byeTiuSRAvI4Ho16/k3BFmUVWG9tHz56oyrHsstMygsoX
	 t++okkLDebsmYjk7r7z4l/8uZLT2NTYCDnZgcK7Dwu5BS4gqktC68r/bxYcO4AMjVq
	 He+j+KMFNRU0Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2D827CE1E93; Mon,  8 Apr 2024 21:44:00 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 fs/proc/bootconfig 2/2] fs/proc: Skip bootloader comment if no embedded kernel parameters
Date: Mon,  8 Apr 2024 21:43:58 -0700
Message-Id: <20240409044358.1156477-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b1ab4893-46cb-4611-80d8-e05f32305d61@paulmck-laptop>
References: <b1ab4893-46cb-4611-80d8-e05f32305d61@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu <mhiramat@kernel.org>

If the "bootconfig" kernel command-line argument was specified or if
the kernel was built with CONFIG_BOOT_CONFIG_FORCE, but if there are
no embedded kernel parameter, omit the "# Parameters from bootloader:"
comment from the /proc/bootconfig file.  This will cause automation
to fall back to the /proc/cmdline file, which will be identical to the
comment in this no-embedded-kernel-parameters case.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 fs/proc/bootconfig.c       | 2 +-
 include/linux/bootconfig.h | 1 +
 init/main.c                | 5 +++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
index e5635a6b127b0..87dcaae32ff87 100644
--- a/fs/proc/bootconfig.c
+++ b/fs/proc/bootconfig.c
@@ -63,7 +63,7 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
 			dst += ret;
 		}
 	}
-	if (ret >= 0 && boot_command_line[0]) {
+	if (cmdline_has_extra_options() && ret >= 0 && boot_command_line[0]) {
 		ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
 			       boot_command_line);
 		if (ret > 0)
diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index ca73940e26df8..e5ee2c694401e 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -10,6 +10,7 @@
 #ifdef __KERNEL__
 #include <linux/kernel.h>
 #include <linux/types.h>
+bool __init cmdline_has_extra_options(void);
 #else /* !__KERNEL__ */
 /*
  * NOTE: This is only for tools/bootconfig, because tools/bootconfig will
diff --git a/init/main.c b/init/main.c
index 2ca52474d0c30..881f6230ee59e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -487,6 +487,11 @@ static int __init warn_bootconfig(char *str)
 
 early_param("bootconfig", warn_bootconfig);
 
+bool __init cmdline_has_extra_options(void)
+{
+	return extra_command_line || extra_init_args;
+}
+
 /* Change NUL term back to "=", to make "param" the whole string. */
 static void __init repair_env_string(char *param, char *val)
 {
-- 
2.40.1



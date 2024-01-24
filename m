Return-Path: <linux-fsdevel+bounces-8652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3F5839EDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68211F2563C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3166171A8;
	Wed, 24 Jan 2024 02:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrAyVMkg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F1A168B1;
	Wed, 24 Jan 2024 02:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062943; cv=none; b=ZfvN8xjzq2MOKZTv72U0wV3G+E++sCnD9GgWbaEpVA7GqpV/SpeT6S+X+MvcIKnZDxx3bVPinig3Q0/ADVwn8oUAFRBG48KZoStG7qfPINXID7p/kwXX1RA0IhrMAgZYoN5m5AOTNKaR1VV7B7GlMW1VKup9TWa+gNoSlhyDHZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062943; c=relaxed/simple;
	bh=6r+lsWai+Oj+c7JWt5GLZDMeO2ouurjNNsav08t6vgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LDc8VscQLVmE4eGmrHj5biiPJyeIIns6pGIht9LqFiWdMedxWuskGU8tYIZ40E1Z6w3kniDolBtq1bNJNR4c4h3KBH0ogqOE0s8aQ+5/NKGkim+oVwqIw1qLcJ21Y4yEn0vZILlcKPUFKhiWJ20FfpqM03nqGjQhl6bCMxTcov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrAyVMkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE362C433C7;
	Wed, 24 Jan 2024 02:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062943;
	bh=6r+lsWai+Oj+c7JWt5GLZDMeO2ouurjNNsav08t6vgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qrAyVMkgkLA5IFNj3lnU9fH+zdn1yu2/5WLWN8baPVRdyHYoGT/6cv2UPTjVsGtno
	 R+ASjmlk6oHrqdJf75mxFobbfDkCIPVprbJvUMa13IZxc6RjrSPJ2R5UjyTLWDrYC1
	 H4RSiRHiJYhVj1Hu0cZAZWojJbzsTyXZXFO8M+VTjmTK7u5+S7HPCkGr/sBnLmbAW5
	 YRD9S2GNEBRR7Xf1XR9K3lQrgwEKXiD3qzmUKT7MyGVdAlmt4pSH3nBNNjP8YHIPtc
	 oj5eUsrZkwnLHSPwmmp5S/wbi1IKuubTn3uh7wrcdPOTfH/zkcBehqU7pC3g0sSj77
	 aDH+/FnjIFwvQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 14/30] libbpf: add BPF token support to bpf_btf_load() API
Date: Tue, 23 Jan 2024 18:21:11 -0800
Message-Id: <20240124022127.2379740-15-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124022127.2379740-1-andrii@kernel.org>
References: <20240124022127.2379740-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow user to specify token_fd for bpf_btf_load() API that wraps
kernel's BPF_BTF_LOAD command. This allows loading BTF from unprivileged
process as long as it has BPF token allowing BPF_BTF_LOAD command, which
can be created and delegated by privileged process.

Wire through new btf_flags as well, so that user can provide
BPF_F_TOKEN_FD flag, if necessary.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 6 +++++-
 tools/lib/bpf/bpf.h | 5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 1653b64b7015..cf250cb1d5ef 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1184,7 +1184,7 @@ int bpf_raw_tracepoint_open(const char *name, int prog_fd)
 
 int bpf_btf_load(const void *btf_data, size_t btf_size, struct bpf_btf_load_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, btf_log_true_size);
+	const size_t attr_sz = offsetofend(union bpf_attr, btf_token_fd);
 	union bpf_attr attr;
 	char *log_buf;
 	size_t log_size;
@@ -1209,6 +1209,10 @@ int bpf_btf_load(const void *btf_data, size_t btf_size, struct bpf_btf_load_opts
 
 	attr.btf = ptr_to_u64(btf_data);
 	attr.btf_size = btf_size;
+
+	attr.btf_flags = OPTS_GET(opts, btf_flags, 0);
+	attr.btf_token_fd = OPTS_GET(opts, token_fd, 0);
+
 	/* log_level == 0 and log_buf != NULL means "try loading without
 	 * log_buf, but retry with log_buf and log_level=1 on error", which is
 	 * consistent across low-level and high-level BTF and program loading
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index ae2136f596b4..fde54ea08e6f 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -133,9 +133,12 @@ struct bpf_btf_load_opts {
 	 * If kernel doesn't support this feature, log_size is left unchanged.
 	 */
 	__u32 log_true_size;
+
+	__u32 btf_flags;
+	__u32 token_fd;
 	size_t :0;
 };
-#define bpf_btf_load_opts__last_field log_true_size
+#define bpf_btf_load_opts__last_field token_fd
 
 LIBBPF_API int bpf_btf_load(const void *btf_data, size_t btf_size,
 			    struct bpf_btf_load_opts *opts);
-- 
2.34.1



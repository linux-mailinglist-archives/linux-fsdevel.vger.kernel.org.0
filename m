Return-Path: <linux-fsdevel+bounces-8653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55558839EE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF3D1F224A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75731171D4;
	Wed, 24 Jan 2024 02:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuoDuzNr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8484171AE;
	Wed, 24 Jan 2024 02:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062946; cv=none; b=H999KZyuQL+d0INmkHtUWO1frL4hpRWj6BeoimdQpqFYlfWRLTECED1fMoUrPnF5L/uoafYywjfL08PcV/Y6Gs7BbRZxRJYKEv0sC1rCHyyV3y1egwu5LtoRbLBGtPaGlqR2PdE2X7eIiIn9ylmMpcHMQLxhDBIrsFnsOOMnA3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062946; c=relaxed/simple;
	bh=DnBmBoEIG9nNyZ3q+v0wmrgN+EDeAc3B8NnjkIoaIZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V4c6Itb6cPXYS4atwyMtevaNWsmyBtFLPlqhNT1QGT9Xvoe9IsfzDvWj17r1soMafboU5jAMXdRu8nIZ4p0yxN8Q7V05zpw4XB7nQyOWQbOkXdDyIsqZGaPXXbr3Mr8ZqaRnqtdb53KjbnGkkYBAwOpIlv59durFXPsAKjcZ5QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuoDuzNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DDFC43390;
	Wed, 24 Jan 2024 02:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062946;
	bh=DnBmBoEIG9nNyZ3q+v0wmrgN+EDeAc3B8NnjkIoaIZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DuoDuzNrmXK9oDthxTKVkHF9Z1MOmOI29Ku00IOypLmR9IYJ93lJ4oHXXF9LJ0lxH
	 y2f6O819WVJkxSAsLY3d5fG3aqJ/g9rFtPVzmz4Y3U6tFj0LBZ02Efk20VTx42191y
	 CnFXas7hcqal9BfGgpm3XomZoKREOD8KFcaV3slM1V2L23ZxZPgngEXJI1qIdUy/bG
	 fnn2jF8VCgTNDg3EG167+RW+6Xy/BMAdpKWXpJX7U5GykWRJq2AMWwDGZe8J25HJdl
	 vbKKYz/XAuyq7WOMQH8YWoWQOPGIzeZ9xXQltYYndbJRKmM/VDUsL0GGgA5IdvlgUL
	 BHxJLX/F3Gy7g==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 15/30] libbpf: add BPF token support to bpf_prog_load() API
Date: Tue, 23 Jan 2024 18:21:12 -0800
Message-Id: <20240124022127.2379740-16-andrii@kernel.org>
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

Wire through token_fd into bpf_prog_load().

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 3 ++-
 tools/lib/bpf/bpf.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index cf250cb1d5ef..d69137459abf 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -234,7 +234,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 		  const struct bpf_insn *insns, size_t insn_cnt,
 		  struct bpf_prog_load_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, log_true_size);
+	const size_t attr_sz = offsetofend(union bpf_attr, prog_token_fd);
 	void *finfo = NULL, *linfo = NULL;
 	const char *func_info, *line_info;
 	__u32 log_size, log_level, attach_prog_fd, attach_btf_obj_fd;
@@ -263,6 +263,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 	attr.prog_flags = OPTS_GET(opts, prog_flags, 0);
 	attr.prog_ifindex = OPTS_GET(opts, prog_ifindex, 0);
 	attr.kern_version = OPTS_GET(opts, kern_version, 0);
+	attr.prog_token_fd = OPTS_GET(opts, token_fd, 0);
 
 	if (prog_name && kernel_supports(NULL, FEAT_PROG_NAME))
 		libbpf_strlcpy(attr.prog_name, prog_name, sizeof(attr.prog_name));
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index fde54ea08e6f..5c7439991f57 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -105,9 +105,10 @@ struct bpf_prog_load_opts {
 	 * If kernel doesn't support this feature, log_size is left unchanged.
 	 */
 	__u32 log_true_size;
+	__u32 token_fd;
 	size_t :0;
 };
-#define bpf_prog_load_opts__last_field log_true_size
+#define bpf_prog_load_opts__last_field token_fd
 
 LIBBPF_API int bpf_prog_load(enum bpf_prog_type prog_type,
 			     const char *prog_name, const char *license,
-- 
2.34.1



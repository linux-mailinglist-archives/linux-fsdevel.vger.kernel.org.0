Return-Path: <linux-fsdevel+bounces-8655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB3C839EEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FBAB1F25B58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B6117571;
	Wed, 24 Jan 2024 02:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mlx/ubCk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA4E17544;
	Wed, 24 Jan 2024 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062954; cv=none; b=hmK8/VG0xx9bPTHsL6TY9U+Rfna6J/sk+LAFG28+9UtUEcka6RkmePbjAnJVTM5uwum7Vsdg9G3ZpqCmXPKP3W2bH3XFen7XknEFYDbQgMnL75ZCuWjJDqZA8esJ0fSsJ0y01nvShnLgfM7FK1KLZ4N28JFSNXj+2wqPXHdRgPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062954; c=relaxed/simple;
	bh=G8rJYeAL+3hM6WoKkSjFgaMoe89An3Dg57Arw89j1/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yqi/jwBoolEnL+WotRLSm4U/Wb+EkgOSpU1PAFFNF5wAPwSZEXRIo6lwvCWE1JC1CavRmvqVxwCtRxubRnMQhLgICe7mMrrzlgDXerrAlll1VkEbsoknxvs/emUbqtQz+219Mq0QpS1akPmfY3CFQfYFHAbgEtND4dNDp0gKmJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mlx/ubCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EC7C433C7;
	Wed, 24 Jan 2024 02:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062953;
	bh=G8rJYeAL+3hM6WoKkSjFgaMoe89An3Dg57Arw89j1/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mlx/ubCkF8jEVpuFpaJdfe5r4e+lg4gaWlM4he6RsYVR05Xawi1VOF3p7f3cl2rzN
	 VTi+QKerRh9pX5O0ZEcZumtaQYd1y2GVFrYGRrnoeuRvud2X2hQ5iWSIn6e3sG19gk
	 UjWTv7uUgAEbV+11HKn29wRloYVnukWsYZdKOSev2u2YftGvTQRGpUX0A20Y4UFRPG
	 D/Ds7z2fwW8+euKWhVKgpc2QdIYrlcF7se4sfbjulo9jal4JJuHPznAUC+A1oPV217
	 p/LY3VavVOiW9GTrda/IXm32+EXDa1fU83bugttIlko6M5x1/B4ak3ZivgT7jB8hXs
	 Y7kWwAe5k8SuA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 17/30] bpf,selinux: allocate bpf_security_struct per BPF token
Date: Tue, 23 Jan 2024 18:21:14 -0800
Message-Id: <20240124022127.2379740-18-andrii@kernel.org>
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

Utilize newly added bpf_token_create/bpf_token_free LSM hooks to
allocate struct bpf_security_struct for each BPF token object in
SELinux. This just follows similar pattern for BPF prog and map.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 security/selinux/hooks.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3d336a7952f7..8dd506ab9b1f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6965,6 +6965,29 @@ static void selinux_bpf_prog_free(struct bpf_prog *prog)
 	prog->aux->security = NULL;
 	kfree(bpfsec);
 }
+
+static int selinux_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
+				    struct path *path)
+{
+	struct bpf_security_struct *bpfsec;
+
+	bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
+	if (!bpfsec)
+		return -ENOMEM;
+
+	bpfsec->sid = current_sid();
+	token->security = bpfsec;
+
+	return 0;
+}
+
+static void selinux_bpf_token_free(struct bpf_token *token)
+{
+	struct bpf_security_struct *bpfsec = token->security;
+
+	token->security = NULL;
+	kfree(bpfsec);
+}
 #endif
 
 struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
@@ -7328,6 +7351,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bpf_prog, selinux_bpf_prog),
 	LSM_HOOK_INIT(bpf_map_free, selinux_bpf_map_free),
 	LSM_HOOK_INIT(bpf_prog_free, selinux_bpf_prog_free),
+	LSM_HOOK_INIT(bpf_token_free, selinux_bpf_token_free),
 #endif
 
 #ifdef CONFIG_PERF_EVENTS
@@ -7386,6 +7410,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 #ifdef CONFIG_BPF_SYSCALL
 	LSM_HOOK_INIT(bpf_map_create, selinux_bpf_map_create),
 	LSM_HOOK_INIT(bpf_prog_load, selinux_bpf_prog_load),
+	LSM_HOOK_INIT(bpf_token_create, selinux_bpf_token_create),
 #endif
 #ifdef CONFIG_PERF_EVENTS
 	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
-- 
2.34.1



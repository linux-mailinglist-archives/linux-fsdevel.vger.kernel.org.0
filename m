Return-Path: <linux-fsdevel+bounces-8667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50686839F1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62C51F2490C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD4A182BF;
	Wed, 24 Jan 2024 02:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASPrLtoC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C7CAD4F;
	Wed, 24 Jan 2024 02:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062998; cv=none; b=dC6BA5QZGJOesP3V00L02tBM0RUH4RbxQaUjGQBhbIJ/+uLSvAOXO8WpGUczBq57+5bTiqjxkHY80TCVAmRcgX4eey8s6cWmrUnZ1luaaNFXbKLyWKukdhVAVhTakNIcyXBXOV8imxGkEuV597RC48EBTxp7s758U/Uade9Z2QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062998; c=relaxed/simple;
	bh=L9MuAQHUskRFcl9CeGST8JoZoVHCgAhu4XUSI1PFNPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OBjrcQiYX8QxHcPg4qa3ISjyG+txU5lrZSo+miB5xFbv1KBGWRJ7Hae3y6pJSg9xxN0kg/GRU+kOmPUWkq/UvBY9YF0M7w3acQGvUjZa591YR22jh+AB1UBfX62qvT3FfBoACe0J/FfcrdZ0QMeSLWCuGLACTYAqNvFqPtKa5Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASPrLtoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449F5C433F1;
	Wed, 24 Jan 2024 02:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062997;
	bh=L9MuAQHUskRFcl9CeGST8JoZoVHCgAhu4XUSI1PFNPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ASPrLtoCvAJhD0zcangv2xdyAf8No+929/IZvUcWIaHVt/yzbgVMloWjlgfwFHvcA
	 4Huw1EvrLuaclITpEP9q7eLJnCKgezQhtSL/4d8MuHHpT6bgj7NGiRMih3mrLX+N9y
	 K4qhg8lqP3d758HhrSbqvP40bQfGSfLOWbiI5mLMfF8cZLLWgJWJRBjIHcNmwNB6Rf
	 7YhTTU9IMHL/UBblaeZRkOEWpW0LgKmEUijMbPkVyoh3YZOGR7dl4K0N3NxcI9zVXH
	 Yg9ghnrli50wOikZYcHC6n7L6eYFr5X02rAoUVv0dMoIdyJo3ZDl71BH7+cYG8sJgD
	 EcHHOi2jeMdeQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 29/30] selftests/bpf: add tests for LIBBPF_BPF_TOKEN_PATH envvar
Date: Tue, 23 Jan 2024 18:21:26 -0800
Message-Id: <20240124022127.2379740-30-andrii@kernel.org>
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

Add new subtest validating LIBBPF_BPF_TOKEN_PATH envvar semantics.
Extend existing test to validate that LIBBPF_BPF_TOKEN_PATH allows to
disable implicit BPF token creation by setting envvar to empty string.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index 003f7c208f4c..1f6aa685e6f7 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -773,6 +773,9 @@ static int userns_obj_priv_btf_success(int mnt_fd)
 	return validate_struct_ops_load(mnt_fd, true /* should succeed */);
 }
 
+#define TOKEN_ENVVAR "LIBBPF_BPF_TOKEN_PATH"
+#define TOKEN_BPFFS_CUSTOM "/bpf-token-fs"
+
 static int userns_obj_priv_implicit_token(int mnt_fd)
 {
 	LIBBPF_OPTS(bpf_object_open_opts, opts);
@@ -795,6 +798,20 @@ static int userns_obj_priv_implicit_token(int mnt_fd)
 	if (!ASSERT_OK(err, "move_mount_bpffs"))
 		return -EINVAL;
 
+	/* disable implicit BPF token creation by setting
+	 * LIBBPF_BPF_TOKEN_PATH envvar to empty value, load should fail
+	 */
+	err = setenv(TOKEN_ENVVAR, "", 1 /*overwrite*/);
+	if (!ASSERT_OK(err, "setenv_token_path"))
+		return -EINVAL;
+	skel = dummy_st_ops_success__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "obj_token_envvar_disabled_load")) {
+		unsetenv(TOKEN_ENVVAR);
+		dummy_st_ops_success__destroy(skel);
+		return -EINVAL;
+	}
+	unsetenv(TOKEN_ENVVAR);
+
 	/* now the same struct_ops skeleton should succeed thanks to libppf
 	 * creating BPF token from /sys/fs/bpf mount point
 	 */
@@ -818,6 +835,76 @@ static int userns_obj_priv_implicit_token(int mnt_fd)
 	return 0;
 }
 
+static int userns_obj_priv_implicit_token_envvar(int mnt_fd)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	struct dummy_st_ops_success *skel;
+	int err;
+
+	/* before we mount BPF FS with token delegation, struct_ops skeleton
+	 * should fail to load
+	 */
+	skel = dummy_st_ops_success__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "obj_tokenless_load")) {
+		dummy_st_ops_success__destroy(skel);
+		return -EINVAL;
+	}
+
+	/* mount custom BPF FS over custom location, so libbpf can't create
+	 * BPF token implicitly, unless pointed to it through
+	 * LIBBPF_BPF_TOKEN_PATH envvar
+	 */
+	rmdir(TOKEN_BPFFS_CUSTOM);
+	if (!ASSERT_OK(mkdir(TOKEN_BPFFS_CUSTOM, 0777), "mkdir_bpffs_custom"))
+		goto err_out;
+	err = sys_move_mount(mnt_fd, "", AT_FDCWD, TOKEN_BPFFS_CUSTOM, MOVE_MOUNT_F_EMPTY_PATH);
+	if (!ASSERT_OK(err, "move_mount_bpffs"))
+		goto err_out;
+
+	/* even though we have BPF FS with delegation, it's not at default
+	 * /sys/fs/bpf location, so we still fail to load until envvar is set up
+	 */
+	skel = dummy_st_ops_success__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "obj_tokenless_load2")) {
+		dummy_st_ops_success__destroy(skel);
+		goto err_out;
+	}
+
+	err = setenv(TOKEN_ENVVAR, TOKEN_BPFFS_CUSTOM, 1 /*overwrite*/);
+	if (!ASSERT_OK(err, "setenv_token_path"))
+		goto err_out;
+
+	/* now the same struct_ops skeleton should succeed thanks to libppf
+	 * creating BPF token from custom mount point
+	 */
+	skel = dummy_st_ops_success__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "obj_implicit_token_load"))
+		goto err_out;
+
+	dummy_st_ops_success__destroy(skel);
+
+	/* now disable implicit token through empty bpf_token_path, envvar
+	 * will be ignored, should fail
+	 */
+	opts.bpf_token_path = "";
+	skel = dummy_st_ops_success__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "obj_empty_token_path_open"))
+		goto err_out;
+
+	err = dummy_st_ops_success__load(skel);
+	dummy_st_ops_success__destroy(skel);
+	if (!ASSERT_ERR(err, "obj_empty_token_path_load"))
+		goto err_out;
+
+	rmdir(TOKEN_BPFFS_CUSTOM);
+	unsetenv(TOKEN_ENVVAR);
+	return 0;
+err_out:
+	rmdir(TOKEN_BPFFS_CUSTOM);
+	unsetenv(TOKEN_ENVVAR);
+	return -EINVAL;
+}
+
 #define bit(n) (1ULL << (n))
 
 void test_token(void)
@@ -896,4 +983,15 @@ void test_token(void)
 
 		subtest_userns(&opts, userns_obj_priv_implicit_token);
 	}
+	if (test__start_subtest("obj_priv_implicit_token_envvar")) {
+		struct bpffs_opts opts = {
+			/* allow BTF loading */
+			.cmds = bit(BPF_BTF_LOAD) | bit(BPF_MAP_CREATE) | bit(BPF_PROG_LOAD),
+			.maps = bit(BPF_MAP_TYPE_STRUCT_OPS),
+			.progs = bit(BPF_PROG_TYPE_STRUCT_OPS),
+			.attachs = ~0ULL,
+		};
+
+		subtest_userns(&opts, userns_obj_priv_implicit_token_envvar);
+	}
 }
-- 
2.34.1



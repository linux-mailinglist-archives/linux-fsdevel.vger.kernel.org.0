Return-Path: <linux-fsdevel+bounces-8658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31123839EF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CAD11F2180E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8152317735;
	Wed, 24 Jan 2024 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzOZDv5r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD449B659;
	Wed, 24 Jan 2024 02:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062965; cv=none; b=f1mDtd9SPOoHXbOIeWV1HRes2FELCGffB19eGjEh+65/7z4qrSdvoXclwOEJTK90mlLtnD9maGFqad03VzCr+/E3Ag+rmN/gZtREdW9mHgueQpC0iK8lVATEt63thhUcIn/ob8lB3DV15DIl2MyPOt3Ypa2ZDGli3VAvZ4eKuoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062965; c=relaxed/simple;
	bh=cn0YLgKPQ1TtahDWAguI+pIP/0vxtg7TKWt6BNQTOfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gqMItSnqrt2UOmkfN7FE6v2T87maFXMGFCoA1mK8dEPlL8oky2VU06jPl9ioxxvyco5RxoF96c44k+pakP2mwUW50WruCTsYN7XBzdL9QsYON9v9NZ2PDRbAy3/8pm1wyOODmt5o0Pw2vREbo7CCi1H4bQCWKtaMnAi3f+zHyJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzOZDv5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BB1C433F1;
	Wed, 24 Jan 2024 02:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062964;
	bh=cn0YLgKPQ1TtahDWAguI+pIP/0vxtg7TKWt6BNQTOfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EzOZDv5rvG2OR/ceFaAhMqxSUm3npLxDauIyigr0yUu9wxLa8Dm/b5UfZ1JyUEBSF
	 sq071ttUlsWZp4XC7Ncvj49WF14MwHtwTCVoqsIRt1sL4Grg48JBh44BHQ5UCaPk9c
	 528djQfo55sK/47fNm5vxWwaP4dwX7RDm+etVnNV2iBZpHjIs7GtfXyxWYIx7chDt4
	 On83xupxRFvZAU6+Kf1gG5Io8hs7PaVWZ/0Y/W1qSMI8EZZQtRb0HaekVIfh3fkkX6
	 1xMUEG+d0czfKjsS2sLQo6T0Xn6o93yASikdTF8gws7n7rQwuRN1zLD3VhpQj5BMWI
	 0htPk3QQR0gWA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 20/30] selftests/bpf: utilize string values for delegate_xxx mount options
Date: Tue, 23 Jan 2024 18:21:17 -0800
Message-Id: <20240124022127.2379740-21-andrii@kernel.org>
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

Use both hex-based and string-based way to specify delegate mount
options for BPF FS.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 52 ++++++++++++-------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index 5394a0c880a9..185ed2f79315 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -55,14 +55,22 @@ static int restore_priv_caps(__u64 old_caps)
 	return cap_enable_effective(old_caps, NULL);
 }
 
-static int set_delegate_mask(int fs_fd, const char *key, __u64 mask)
+static int set_delegate_mask(int fs_fd, const char *key, __u64 mask, const char *mask_str)
 {
 	char buf[32];
 	int err;
 
-	snprintf(buf, sizeof(buf), "0x%llx", (unsigned long long)mask);
+	if (!mask_str) {
+		if (mask == ~0ULL) {
+			mask_str = "any";
+		} else {
+			snprintf(buf, sizeof(buf), "0x%llx", (unsigned long long)mask);
+			mask_str = buf;
+		}
+	}
+
 	err = sys_fsconfig(fs_fd, FSCONFIG_SET_STRING, key,
-			   mask == ~0ULL ? "any" : buf, 0);
+			   mask_str, 0);
 	if (err < 0)
 		err = -errno;
 	return err;
@@ -75,6 +83,10 @@ struct bpffs_opts {
 	__u64 maps;
 	__u64 progs;
 	__u64 attachs;
+	const char *cmds_str;
+	const char *maps_str;
+	const char *progs_str;
+	const char *attachs_str;
 };
 
 static int create_bpffs_fd(void)
@@ -93,16 +105,16 @@ static int materialize_bpffs_fd(int fs_fd, struct bpffs_opts *opts)
 	int mnt_fd, err;
 
 	/* set up token delegation mount options */
-	err = set_delegate_mask(fs_fd, "delegate_cmds", opts->cmds);
+	err = set_delegate_mask(fs_fd, "delegate_cmds", opts->cmds, opts->cmds_str);
 	if (!ASSERT_OK(err, "fs_cfg_cmds"))
 		return err;
-	err = set_delegate_mask(fs_fd, "delegate_maps", opts->maps);
+	err = set_delegate_mask(fs_fd, "delegate_maps", opts->maps, opts->maps_str);
 	if (!ASSERT_OK(err, "fs_cfg_maps"))
 		return err;
-	err = set_delegate_mask(fs_fd, "delegate_progs", opts->progs);
+	err = set_delegate_mask(fs_fd, "delegate_progs", opts->progs, opts->progs_str);
 	if (!ASSERT_OK(err, "fs_cfg_progs"))
 		return err;
-	err = set_delegate_mask(fs_fd, "delegate_attachs", opts->attachs);
+	err = set_delegate_mask(fs_fd, "delegate_attachs", opts->attachs, opts->attachs_str);
 	if (!ASSERT_OK(err, "fs_cfg_attachs"))
 		return err;
 
@@ -284,13 +296,13 @@ static void child(int sock_fd, struct bpffs_opts *opts, child_callback_fn callba
 	}
 
 	/* ensure unprivileged child cannot set delegation options */
-	err = set_delegate_mask(fs_fd, "delegate_cmds", 0x1);
+	err = set_delegate_mask(fs_fd, "delegate_cmds", 0x1, NULL);
 	ASSERT_EQ(err, -EPERM, "delegate_cmd_eperm");
-	err = set_delegate_mask(fs_fd, "delegate_maps", 0x1);
+	err = set_delegate_mask(fs_fd, "delegate_maps", 0x1, NULL);
 	ASSERT_EQ(err, -EPERM, "delegate_maps_eperm");
-	err = set_delegate_mask(fs_fd, "delegate_progs", 0x1);
+	err = set_delegate_mask(fs_fd, "delegate_progs", 0x1, NULL);
 	ASSERT_EQ(err, -EPERM, "delegate_progs_eperm");
-	err = set_delegate_mask(fs_fd, "delegate_attachs", 0x1);
+	err = set_delegate_mask(fs_fd, "delegate_attachs", 0x1, NULL);
 	ASSERT_EQ(err, -EPERM, "delegate_attachs_eperm");
 
 	/* pass BPF FS context object to parent */
@@ -314,22 +326,22 @@ static void child(int sock_fd, struct bpffs_opts *opts, child_callback_fn callba
 	}
 
 	/* ensure unprivileged child cannot reconfigure to set delegation options */
-	err = set_delegate_mask(fs_fd, "delegate_cmds", ~0ULL);
+	err = set_delegate_mask(fs_fd, "delegate_cmds", 0, "any");
 	if (!ASSERT_EQ(err, -EPERM, "delegate_cmd_eperm_reconfig")) {
 		err = -EINVAL;
 		goto cleanup;
 	}
-	err = set_delegate_mask(fs_fd, "delegate_maps", ~0ULL);
+	err = set_delegate_mask(fs_fd, "delegate_maps", 0, "any");
 	if (!ASSERT_EQ(err, -EPERM, "delegate_maps_eperm_reconfig")) {
 		err = -EINVAL;
 		goto cleanup;
 	}
-	err = set_delegate_mask(fs_fd, "delegate_progs", ~0ULL);
+	err = set_delegate_mask(fs_fd, "delegate_progs", 0, "any");
 	if (!ASSERT_EQ(err, -EPERM, "delegate_progs_eperm_reconfig")) {
 		err = -EINVAL;
 		goto cleanup;
 	}
-	err = set_delegate_mask(fs_fd, "delegate_attachs", ~0ULL);
+	err = set_delegate_mask(fs_fd, "delegate_attachs", 0, "any");
 	if (!ASSERT_EQ(err, -EPERM, "delegate_attachs_eperm_reconfig")) {
 		err = -EINVAL;
 		goto cleanup;
@@ -658,8 +670,8 @@ void test_token(void)
 {
 	if (test__start_subtest("map_token")) {
 		struct bpffs_opts opts = {
-			.cmds = 1ULL << BPF_MAP_CREATE,
-			.maps = 1ULL << BPF_MAP_TYPE_STACK,
+			.cmds_str = "map_create",
+			.maps_str = "stack",
 		};
 
 		subtest_userns(&opts, userns_map_create);
@@ -673,9 +685,9 @@ void test_token(void)
 	}
 	if (test__start_subtest("prog_token")) {
 		struct bpffs_opts opts = {
-			.cmds = 1ULL << BPF_PROG_LOAD,
-			.progs = 1ULL << BPF_PROG_TYPE_XDP,
-			.attachs = 1ULL << BPF_XDP,
+			.cmds_str = "PROG_LOAD",
+			.progs_str = "XDP",
+			.attachs_str = "xdp",
 		};
 
 		subtest_userns(&opts, userns_prog_load);
-- 
2.34.1



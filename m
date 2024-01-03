Return-Path: <linux-fsdevel+bounces-7305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD56C82382C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01CD11C2568C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E3922323;
	Wed,  3 Jan 2024 22:25:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B9F20303
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 22:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403GiLf3027546
	for <linux-fsdevel@vger.kernel.org>; Wed, 3 Jan 2024 14:25:09 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vcxn2pph9-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 14:25:08 -0800
Received: from twshared24631.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 3 Jan 2024 14:24:36 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 34A113DF9EC17; Wed,  3 Jan 2024 14:21:42 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>, <torvalds@linuxfoundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next 29/29] selftests/bpf: add tests for LIBBPF_BPF_TOKEN_PATH envvar
Date: Wed, 3 Jan 2024 14:20:34 -0800
Message-ID: <20240103222034.2582628-30-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103222034.2582628-1-andrii@kernel.org>
References: <20240103222034.2582628-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: WU9Dw1drbU8CeI7ZeCzfevHic0ZpiPP_
X-Proofpoint-GUID: WU9Dw1drbU8CeI7ZeCzfevHic0ZpiPP_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02

Add new subtest validating LIBBPF_BPF_TOKEN_PATH envvar semantics.
Extend existing test to validate that LIBBPF_BPF_TOKEN_PATH allows to
disable implicit BPF token creation by setting envvar to empty string.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testi=
ng/selftests/bpf/prog_tests/token.c
index 003f7c208f4c..1f6aa685e6f7 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -773,6 +773,9 @@ static int userns_obj_priv_btf_success(int mnt_fd)
 	return validate_struct_ops_load(mnt_fd, true /* should succeed */);
 }
=20
+#define TOKEN_ENVVAR "LIBBPF_BPF_TOKEN_PATH"
+#define TOKEN_BPFFS_CUSTOM "/bpf-token-fs"
+
 static int userns_obj_priv_implicit_token(int mnt_fd)
 {
 	LIBBPF_OPTS(bpf_object_open_opts, opts);
@@ -795,6 +798,20 @@ static int userns_obj_priv_implicit_token(int mnt_fd=
)
 	if (!ASSERT_OK(err, "move_mount_bpffs"))
 		return -EINVAL;
=20
+	/* disable implicit BPF token creation by setting
+	 * LIBBPF_BPF_TOKEN_PATH envvar to empty value, load should fail
+	 */
+	err =3D setenv(TOKEN_ENVVAR, "", 1 /*overwrite*/);
+	if (!ASSERT_OK(err, "setenv_token_path"))
+		return -EINVAL;
+	skel =3D dummy_st_ops_success__open_and_load();
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
@@ -818,6 +835,76 @@ static int userns_obj_priv_implicit_token(int mnt_fd=
)
 	return 0;
 }
=20
+static int userns_obj_priv_implicit_token_envvar(int mnt_fd)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	struct dummy_st_ops_success *skel;
+	int err;
+
+	/* before we mount BPF FS with token delegation, struct_ops skeleton
+	 * should fail to load
+	 */
+	skel =3D dummy_st_ops_success__open_and_load();
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
+	err =3D sys_move_mount(mnt_fd, "", AT_FDCWD, TOKEN_BPFFS_CUSTOM, MOVE_M=
OUNT_F_EMPTY_PATH);
+	if (!ASSERT_OK(err, "move_mount_bpffs"))
+		goto err_out;
+
+	/* even though we have BPF FS with delegation, it's not at default
+	 * /sys/fs/bpf location, so we still fail to load until envvar is set u=
p
+	 */
+	skel =3D dummy_st_ops_success__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "obj_tokenless_load2")) {
+		dummy_st_ops_success__destroy(skel);
+		goto err_out;
+	}
+
+	err =3D setenv(TOKEN_ENVVAR, TOKEN_BPFFS_CUSTOM, 1 /*overwrite*/);
+	if (!ASSERT_OK(err, "setenv_token_path"))
+		goto err_out;
+
+	/* now the same struct_ops skeleton should succeed thanks to libppf
+	 * creating BPF token from custom mount point
+	 */
+	skel =3D dummy_st_ops_success__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "obj_implicit_token_load"))
+		goto err_out;
+
+	dummy_st_ops_success__destroy(skel);
+
+	/* now disable implicit token through empty bpf_token_path, envvar
+	 * will be ignored, should fail
+	 */
+	opts.bpf_token_path =3D "";
+	skel =3D dummy_st_ops_success__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "obj_empty_token_path_open"))
+		goto err_out;
+
+	err =3D dummy_st_ops_success__load(skel);
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
=20
 void test_token(void)
@@ -896,4 +983,15 @@ void test_token(void)
=20
 		subtest_userns(&opts, userns_obj_priv_implicit_token);
 	}
+	if (test__start_subtest("obj_priv_implicit_token_envvar")) {
+		struct bpffs_opts opts =3D {
+			/* allow BTF loading */
+			.cmds =3D bit(BPF_BTF_LOAD) | bit(BPF_MAP_CREATE) | bit(BPF_PROG_LOAD=
),
+			.maps =3D bit(BPF_MAP_TYPE_STRUCT_OPS),
+			.progs =3D bit(BPF_PROG_TYPE_STRUCT_OPS),
+			.attachs =3D ~0ULL,
+		};
+
+		subtest_userns(&opts, userns_obj_priv_implicit_token_envvar);
+	}
 }
--=20
2.34.1



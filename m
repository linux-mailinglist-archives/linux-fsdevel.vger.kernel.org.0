Return-Path: <linux-fsdevel+bounces-7302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A171A823819
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161581F27024
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FE121A17;
	Wed,  3 Jan 2024 22:24:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F46219ED
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403LQ0ds024548
	for <linux-fsdevel@vger.kernel.org>; Wed, 3 Jan 2024 14:24:06 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vdffy8b5n-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 14:24:05 -0800
Received: from twshared44805.48.prn1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 3 Jan 2024 14:23:45 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 869C33DF9EB96; Wed,  3 Jan 2024 14:21:21 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>, <torvalds@linuxfoundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next 20/29] selftests/bpf: utilize string values for delegate_xxx mount options
Date: Wed, 3 Jan 2024 14:20:25 -0800
Message-ID: <20240103222034.2582628-21-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: LDfXgZaIr1Pzbss4Wfu4SiyIH5vNvfQA
X-Proofpoint-GUID: LDfXgZaIr1Pzbss4Wfu4SiyIH5vNvfQA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02

Use both hex-based and string-based way to specify delegate mount
options for BPF FS.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 52 ++++++++++++-------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testi=
ng/selftests/bpf/prog_tests/token.c
index 5394a0c880a9..185ed2f79315 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -55,14 +55,22 @@ static int restore_priv_caps(__u64 old_caps)
 	return cap_enable_effective(old_caps, NULL);
 }
=20
-static int set_delegate_mask(int fs_fd, const char *key, __u64 mask)
+static int set_delegate_mask(int fs_fd, const char *key, __u64 mask, con=
st char *mask_str)
 {
 	char buf[32];
 	int err;
=20
-	snprintf(buf, sizeof(buf), "0x%llx", (unsigned long long)mask);
+	if (!mask_str) {
+		if (mask =3D=3D ~0ULL) {
+			mask_str =3D "any";
+		} else {
+			snprintf(buf, sizeof(buf), "0x%llx", (unsigned long long)mask);
+			mask_str =3D buf;
+		}
+	}
+
 	err =3D sys_fsconfig(fs_fd, FSCONFIG_SET_STRING, key,
-			   mask =3D=3D ~0ULL ? "any" : buf, 0);
+			   mask_str, 0);
 	if (err < 0)
 		err =3D -errno;
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
=20
 static int create_bpffs_fd(void)
@@ -93,16 +105,16 @@ static int materialize_bpffs_fd(int fs_fd, struct bp=
ffs_opts *opts)
 	int mnt_fd, err;
=20
 	/* set up token delegation mount options */
-	err =3D set_delegate_mask(fs_fd, "delegate_cmds", opts->cmds);
+	err =3D set_delegate_mask(fs_fd, "delegate_cmds", opts->cmds, opts->cmd=
s_str);
 	if (!ASSERT_OK(err, "fs_cfg_cmds"))
 		return err;
-	err =3D set_delegate_mask(fs_fd, "delegate_maps", opts->maps);
+	err =3D set_delegate_mask(fs_fd, "delegate_maps", opts->maps, opts->map=
s_str);
 	if (!ASSERT_OK(err, "fs_cfg_maps"))
 		return err;
-	err =3D set_delegate_mask(fs_fd, "delegate_progs", opts->progs);
+	err =3D set_delegate_mask(fs_fd, "delegate_progs", opts->progs, opts->p=
rogs_str);
 	if (!ASSERT_OK(err, "fs_cfg_progs"))
 		return err;
-	err =3D set_delegate_mask(fs_fd, "delegate_attachs", opts->attachs);
+	err =3D set_delegate_mask(fs_fd, "delegate_attachs", opts->attachs, opt=
s->attachs_str);
 	if (!ASSERT_OK(err, "fs_cfg_attachs"))
 		return err;
=20
@@ -284,13 +296,13 @@ static void child(int sock_fd, struct bpffs_opts *o=
pts, child_callback_fn callba
 	}
=20
 	/* ensure unprivileged child cannot set delegation options */
-	err =3D set_delegate_mask(fs_fd, "delegate_cmds", 0x1);
+	err =3D set_delegate_mask(fs_fd, "delegate_cmds", 0x1, NULL);
 	ASSERT_EQ(err, -EPERM, "delegate_cmd_eperm");
-	err =3D set_delegate_mask(fs_fd, "delegate_maps", 0x1);
+	err =3D set_delegate_mask(fs_fd, "delegate_maps", 0x1, NULL);
 	ASSERT_EQ(err, -EPERM, "delegate_maps_eperm");
-	err =3D set_delegate_mask(fs_fd, "delegate_progs", 0x1);
+	err =3D set_delegate_mask(fs_fd, "delegate_progs", 0x1, NULL);
 	ASSERT_EQ(err, -EPERM, "delegate_progs_eperm");
-	err =3D set_delegate_mask(fs_fd, "delegate_attachs", 0x1);
+	err =3D set_delegate_mask(fs_fd, "delegate_attachs", 0x1, NULL);
 	ASSERT_EQ(err, -EPERM, "delegate_attachs_eperm");
=20
 	/* pass BPF FS context object to parent */
@@ -314,22 +326,22 @@ static void child(int sock_fd, struct bpffs_opts *o=
pts, child_callback_fn callba
 	}
=20
 	/* ensure unprivileged child cannot reconfigure to set delegation optio=
ns */
-	err =3D set_delegate_mask(fs_fd, "delegate_cmds", ~0ULL);
+	err =3D set_delegate_mask(fs_fd, "delegate_cmds", 0, "any");
 	if (!ASSERT_EQ(err, -EPERM, "delegate_cmd_eperm_reconfig")) {
 		err =3D -EINVAL;
 		goto cleanup;
 	}
-	err =3D set_delegate_mask(fs_fd, "delegate_maps", ~0ULL);
+	err =3D set_delegate_mask(fs_fd, "delegate_maps", 0, "any");
 	if (!ASSERT_EQ(err, -EPERM, "delegate_maps_eperm_reconfig")) {
 		err =3D -EINVAL;
 		goto cleanup;
 	}
-	err =3D set_delegate_mask(fs_fd, "delegate_progs", ~0ULL);
+	err =3D set_delegate_mask(fs_fd, "delegate_progs", 0, "any");
 	if (!ASSERT_EQ(err, -EPERM, "delegate_progs_eperm_reconfig")) {
 		err =3D -EINVAL;
 		goto cleanup;
 	}
-	err =3D set_delegate_mask(fs_fd, "delegate_attachs", ~0ULL);
+	err =3D set_delegate_mask(fs_fd, "delegate_attachs", 0, "any");
 	if (!ASSERT_EQ(err, -EPERM, "delegate_attachs_eperm_reconfig")) {
 		err =3D -EINVAL;
 		goto cleanup;
@@ -658,8 +670,8 @@ void test_token(void)
 {
 	if (test__start_subtest("map_token")) {
 		struct bpffs_opts opts =3D {
-			.cmds =3D 1ULL << BPF_MAP_CREATE,
-			.maps =3D 1ULL << BPF_MAP_TYPE_STACK,
+			.cmds_str =3D "map_create",
+			.maps_str =3D "stack",
 		};
=20
 		subtest_userns(&opts, userns_map_create);
@@ -673,9 +685,9 @@ void test_token(void)
 	}
 	if (test__start_subtest("prog_token")) {
 		struct bpffs_opts opts =3D {
-			.cmds =3D 1ULL << BPF_PROG_LOAD,
-			.progs =3D 1ULL << BPF_PROG_TYPE_XDP,
-			.attachs =3D 1ULL << BPF_XDP,
+			.cmds_str =3D "PROG_LOAD",
+			.progs_str =3D "XDP",
+			.attachs_str =3D "xdp",
 		};
=20
 		subtest_userns(&opts, userns_prog_load);
--=20
2.34.1



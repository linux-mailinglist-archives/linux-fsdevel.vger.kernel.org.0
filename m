Return-Path: <linux-fsdevel+bounces-5278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93923809598
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 23:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3251F211C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D576857335
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:47:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E631710
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 14:28:12 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7GeMWJ030180
	for <linux-fsdevel@vger.kernel.org>; Thu, 7 Dec 2023 14:28:12 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uu2jh0b7y-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 07 Dec 2023 14:28:12 -0800
Received: from twshared4634.37.frc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 7 Dec 2023 14:28:07 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id B9B4A3CC5459E; Thu,  7 Dec 2023 14:28:01 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH RFC bpf-next 3/3] selftests/bpf: utilize string values for delegate_xxx mount options
Date: Thu, 7 Dec 2023 14:27:55 -0800
Message-ID: <20231207222755.3920286-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207222755.3920286-1-andrii@kernel.org>
References: <20231207222755.3920286-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: VwrT-84uVbeXUYp2EaW0sjMf8dmBDpfC
X-Proofpoint-ORIG-GUID: VwrT-84uVbeXUYp2EaW0sjMf8dmBDpfC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_17,2023-12-07_01,2023-05-22_02

Use both hex-based and string-based way to specify delegate mount
options for BPF FS.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 43 +++++++++++--------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testi=
ng/selftests/bpf/prog_tests/token.c
index dc03790c6272..ec59c81c54b5 100644
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
@@ -72,6 +80,7 @@ static int set_delegate_mask(int fs_fd, const char *key=
, __u64 mask)
=20
 struct bpffs_opts {
 	__u64 cmds;
+	const char *cmds_str;
 	__u64 maps;
 	__u64 progs;
 	__u64 attachs;
@@ -93,16 +102,16 @@ static int materialize_bpffs_fd(int fs_fd, struct bp=
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
+	err =3D set_delegate_mask(fs_fd, "delegate_maps", opts->maps, NULL);
 	if (!ASSERT_OK(err, "fs_cfg_maps"))
 		return err;
-	err =3D set_delegate_mask(fs_fd, "delegate_progs", opts->progs);
+	err =3D set_delegate_mask(fs_fd, "delegate_progs", opts->progs, NULL);
 	if (!ASSERT_OK(err, "fs_cfg_progs"))
 		return err;
-	err =3D set_delegate_mask(fs_fd, "delegate_attachs", opts->attachs);
+	err =3D set_delegate_mask(fs_fd, "delegate_attachs", opts->attachs, NUL=
L);
 	if (!ASSERT_OK(err, "fs_cfg_attachs"))
 		return err;
=20
@@ -284,13 +293,13 @@ static void child(int sock_fd, struct bpffs_opts *o=
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
@@ -314,22 +323,22 @@ static void child(int sock_fd, struct bpffs_opts *o=
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
@@ -647,7 +656,7 @@ void test_token(void)
 {
 	if (test__start_subtest("map_token")) {
 		struct bpffs_opts opts =3D {
-			.cmds =3D 1ULL << BPF_MAP_CREATE,
+			.cmds_str =3D "BPF_MAP_CREATE",
 			.maps =3D 1ULL << BPF_MAP_TYPE_STACK,
 		};
=20
@@ -662,7 +671,7 @@ void test_token(void)
 	}
 	if (test__start_subtest("prog_token")) {
 		struct bpffs_opts opts =3D {
-			.cmds =3D 1ULL << BPF_PROG_LOAD,
+			.cmds_str =3D "BPF_PROG_LOAD",
 			.progs =3D 1ULL << BPF_PROG_TYPE_XDP,
 			.attachs =3D 1ULL << BPF_XDP,
 		};
--=20
2.34.1



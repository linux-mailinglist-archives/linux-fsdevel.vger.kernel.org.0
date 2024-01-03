Return-Path: <linux-fsdevel+bounces-7306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE2A82382F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDAF1F27924
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60772031F;
	Wed,  3 Jan 2024 22:25:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5B61EB29
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403GiKk1020226
	for <linux-fsdevel@vger.kernel.org>; Wed, 3 Jan 2024 14:25:20 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vda7m300t-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 14:25:18 -0800
Received: from twshared19681.14.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 3 Jan 2024 14:24:42 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 1BF513DF9EBEF; Wed,  3 Jan 2024 14:21:38 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>, <torvalds@linuxfoundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next 27/29] selftests/bpf: add tests for BPF object load with implicit token
Date: Wed, 3 Jan 2024 14:20:32 -0800
Message-ID: <20240103222034.2582628-28-andrii@kernel.org>
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
X-Proofpoint-GUID: rXc7NcOHJEvD5HWr-CT-cRdbIvOIExk1
X-Proofpoint-ORIG-GUID: rXc7NcOHJEvD5HWr-CT-cRdbIvOIExk1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02

Add a test to validate libbpf's implicit BPF token creation from default
BPF FS location (/sys/fs/bpf). Also validate that disabling this
implicit BPF token creation works.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testi=
ng/selftests/bpf/prog_tests/token.c
index 1594d9b94b13..003f7c208f4c 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -12,6 +12,7 @@
 #include <linux/unistd.h>
 #include <linux/mount.h>
 #include <sys/socket.h>
+#include <sys/stat.h>
 #include <sys/syscall.h>
 #include <sys/un.h>
 #include "priv_map.skel.h"
@@ -45,6 +46,13 @@ static inline int sys_fsmount(int fs_fd, unsigned flag=
s, unsigned ms_flags)
 	return syscall(__NR_fsmount, fs_fd, flags, ms_flags);
 }
=20
+static inline int sys_move_mount(int from_dfd, const char *from_path,
+				 int to_dfd, const char *to_path,
+				 unsigned flags)
+{
+	return syscall(__NR_move_mount, from_dfd, from_path, to_dfd, to_path, f=
lags);
+}
+
 static int drop_priv_caps(__u64 *old_caps)
 {
 	return cap_disable_effective((1ULL << CAP_BPF) |
@@ -765,6 +773,51 @@ static int userns_obj_priv_btf_success(int mnt_fd)
 	return validate_struct_ops_load(mnt_fd, true /* should succeed */);
 }
=20
+static int userns_obj_priv_implicit_token(int mnt_fd)
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
+	/* mount custom BPF FS over /sys/fs/bpf so that libbpf can create BPF
+	 * token automatically and implicitly
+	 */
+	err =3D sys_move_mount(mnt_fd, "", AT_FDCWD, "/sys/fs/bpf", MOVE_MOUNT_=
F_EMPTY_PATH);
+	if (!ASSERT_OK(err, "move_mount_bpffs"))
+		return -EINVAL;
+
+	/* now the same struct_ops skeleton should succeed thanks to libppf
+	 * creating BPF token from /sys/fs/bpf mount point
+	 */
+	skel =3D dummy_st_ops_success__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "obj_implicit_token_load"))
+		return -EINVAL;
+
+	dummy_st_ops_success__destroy(skel);
+
+	/* now disable implicit token through empty bpf_token_path, should fail=
 */
+	opts.bpf_token_path =3D "";
+	skel =3D dummy_st_ops_success__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "obj_empty_token_path_open"))
+		return -EINVAL;
+
+	err =3D dummy_st_ops_success__load(skel);
+	dummy_st_ops_success__destroy(skel);
+	if (!ASSERT_ERR(err, "obj_empty_token_path_load"))
+		return -EINVAL;
+
+	return 0;
+}
+
 #define bit(n) (1ULL << (n))
=20
 void test_token(void)
@@ -832,4 +885,15 @@ void test_token(void)
=20
 		subtest_userns(&opts, userns_obj_priv_btf_success);
 	}
+	if (test__start_subtest("obj_priv_implicit_token")) {
+		struct bpffs_opts opts =3D {
+			/* allow BTF loading */
+			.cmds =3D bit(BPF_BTF_LOAD) | bit(BPF_MAP_CREATE) | bit(BPF_PROG_LOAD=
),
+			.maps =3D bit(BPF_MAP_TYPE_STRUCT_OPS),
+			.progs =3D bit(BPF_PROG_TYPE_STRUCT_OPS),
+			.attachs =3D ~0ULL,
+		};
+
+		subtest_userns(&opts, userns_obj_priv_implicit_token);
+	}
 }
--=20
2.34.1



Return-Path: <linux-fsdevel+bounces-8665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF79839F12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE281F26FA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4ED1804E;
	Wed, 24 Jan 2024 02:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vf5K4let"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3007317C61;
	Wed, 24 Jan 2024 02:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062991; cv=none; b=EFlp3erR2p2/LMHq6QvzpEp/QUGBWEtFKSXHPkKe113aRPQKTXyrKtZVDuBcyLXCyFYxyN0hDPQrqp3YKVDjvY9+CAaOMecXlLCUVG+HWMT4CK7f9DhEZSKIZsDwZIUHQDstsDmGhWVyy8rqlkaoc17ZqsCQmgh91IthkzAyiuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062991; c=relaxed/simple;
	bh=H9w+kJDmOSclsbRnv6vDiQQUn65S2G5DUawaAjLJNlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UXhq9Pzpey6tX3nTn6vjP2Hx49/2BIvNV7JfMFAa8/AzcgLMHzzEg8KGyCERLenBQUdW91pKQqO3Shnt6RZjzRYy+gikjJEfbpv3P+jHfzK2Ix9t3sjzO71M7kPWcvBhE6Vk/uMEDV6ctuH9xiBSlAdwP6bgip+JUF4UBGIn5LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vf5K4let; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B0EC433C7;
	Wed, 24 Jan 2024 02:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062990;
	bh=H9w+kJDmOSclsbRnv6vDiQQUn65S2G5DUawaAjLJNlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vf5K4letq4hKX7QSUT98LpwXhxYSpMVoWsij6UNRkcHc+7+05BzK+UYwTVXvFqc4z
	 Rb3jK/jZDu7I4vHQH8cCjDkvEet/RsttzkZqcN2ARcj+YX6vmx0bi4DKtKe2Dama4g
	 x/PjmhyoENiSYPgWkuaH7MgaEKhYIKtg8wKztMSz6MHvA493EhxjqkYaodgU1WNsrK
	 GSwtEnEkbJCN6vBXN3ejiiwrwsFRaRz4GCnQQPlQn6Fbi6mrkk0dLMJydzOaCKNI/G
	 5bX9Abb9LsbofdBasqoOR1F21DYrQEnnf0tm+uluCwD3ohsi0f9VMesuLW7ry+z1RY
	 KWtsTGTsr8dVQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 27/30] selftests/bpf: add tests for BPF object load with implicit token
Date: Tue, 23 Jan 2024 18:21:24 -0800
Message-Id: <20240124022127.2379740-28-andrii@kernel.org>
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

Add a test to validate libbpf's implicit BPF token creation from default
BPF FS location (/sys/fs/bpf). Also validate that disabling this
implicit BPF token creation works.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
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
@@ -45,6 +46,13 @@ static inline int sys_fsmount(int fs_fd, unsigned flags, unsigned ms_flags)
 	return syscall(__NR_fsmount, fs_fd, flags, ms_flags);
 }
 
+static inline int sys_move_mount(int from_dfd, const char *from_path,
+				 int to_dfd, const char *to_path,
+				 unsigned flags)
+{
+	return syscall(__NR_move_mount, from_dfd, from_path, to_dfd, to_path, flags);
+}
+
 static int drop_priv_caps(__u64 *old_caps)
 {
 	return cap_disable_effective((1ULL << CAP_BPF) |
@@ -765,6 +773,51 @@ static int userns_obj_priv_btf_success(int mnt_fd)
 	return validate_struct_ops_load(mnt_fd, true /* should succeed */);
 }
 
+static int userns_obj_priv_implicit_token(int mnt_fd)
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
+	/* mount custom BPF FS over /sys/fs/bpf so that libbpf can create BPF
+	 * token automatically and implicitly
+	 */
+	err = sys_move_mount(mnt_fd, "", AT_FDCWD, "/sys/fs/bpf", MOVE_MOUNT_F_EMPTY_PATH);
+	if (!ASSERT_OK(err, "move_mount_bpffs"))
+		return -EINVAL;
+
+	/* now the same struct_ops skeleton should succeed thanks to libppf
+	 * creating BPF token from /sys/fs/bpf mount point
+	 */
+	skel = dummy_st_ops_success__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "obj_implicit_token_load"))
+		return -EINVAL;
+
+	dummy_st_ops_success__destroy(skel);
+
+	/* now disable implicit token through empty bpf_token_path, should fail */
+	opts.bpf_token_path = "";
+	skel = dummy_st_ops_success__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "obj_empty_token_path_open"))
+		return -EINVAL;
+
+	err = dummy_st_ops_success__load(skel);
+	dummy_st_ops_success__destroy(skel);
+	if (!ASSERT_ERR(err, "obj_empty_token_path_load"))
+		return -EINVAL;
+
+	return 0;
+}
+
 #define bit(n) (1ULL << (n))
 
 void test_token(void)
@@ -832,4 +885,15 @@ void test_token(void)
 
 		subtest_userns(&opts, userns_obj_priv_btf_success);
 	}
+	if (test__start_subtest("obj_priv_implicit_token")) {
+		struct bpffs_opts opts = {
+			/* allow BTF loading */
+			.cmds = bit(BPF_BTF_LOAD) | bit(BPF_MAP_CREATE) | bit(BPF_PROG_LOAD),
+			.maps = bit(BPF_MAP_TYPE_STRUCT_OPS),
+			.progs = bit(BPF_PROG_TYPE_STRUCT_OPS),
+			.attachs = ~0ULL,
+		};
+
+		subtest_userns(&opts, userns_obj_priv_implicit_token);
+	}
 }
-- 
2.34.1



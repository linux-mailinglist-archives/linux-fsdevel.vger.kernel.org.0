Return-Path: <linux-fsdevel+bounces-4130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E7F7FCB93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 01:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7FB282C30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C1D184F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoB8yMC3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB96185E;
	Wed, 29 Nov 2023 00:37:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C99FC433C8;
	Wed, 29 Nov 2023 00:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701218263;
	bh=4bjRujjjjE6o6wC9dqglrwmnzzF5Xtn24Egh3Jz5bcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AoB8yMC3DnhHMn7VbjM08hH7QCvnv7BMbiGK2P4Fvrluwui6uOMxrYyy3+PALcs6N
	 03nqw2OqXKO0X6dcBLkuns/t4Yh0soMVKQLf9iSJWqof/pcXpATF9LII+XM63QjaUm
	 quRfhGwjjnFjXkwLFkdl6ekNfAdUVvWvBW7MCcWk6ZxLqEvcdXEnbFmhkZSFsGTCDX
	 EIib4oNq4uy/l5u2/j2PwGO5ZbuLAP60lUj+Ilt3nAgAxFUwxTr/AE348j2AkYPhD4
	 y3uozOqWkIurSqbhgf33fy9ZX5qRx7KlEWrIoUWn2hp6NeXdy/h/4ahqX6snuzoLvB
	 VqZ0aazwrq54A==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev
Cc: ebiggers@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	casey@schaufler-ca.com,
	amir73il@gmail.com,
	kpsingh@kernel.org,
	roberto.sassu@huawei.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v14 bpf-next 6/6] selftests/bpf: Add test that uses fsverity and xattr to sign a file
Date: Tue, 28 Nov 2023 16:36:56 -0800
Message-Id: <20231129003656.1165061-7-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129003656.1165061-1-song@kernel.org>
References: <20231129003656.1165061-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This selftests shows a proof of concept method to use BPF LSM to enforce
file signature. This test is added to verify_pkcs7_sig, so that some
existing logic can be reused.

This file signature method uses fsverity, which provides reliable and
efficient hash (known as digest) of the file. The file digest is signed
with asymmetic key, and the signature is stored in xattr. At the run time,
BPF LSM reads file digest and the signature, and then checks them against
the public key.

Note that this solution does NOT require FS_VERITY_BUILTIN_SIGNATURES.
fsverity is only used to provide file digest. The signature verification
and access control is all implemented in BPF LSM.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   7 +
 .../bpf/prog_tests/verify_pkcs7_sig.c         | 163 +++++++++++++++++-
 .../selftests/bpf/progs/test_sig_in_xattr.c   |  82 +++++++++
 .../bpf/progs/test_verify_pkcs7_sig.c         |   8 +-
 .../testing/selftests/bpf/verify_sig_setup.sh |  25 +++
 5 files changed, 277 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sig_in_xattr.c

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index c2c084a44eae..b4e78c1eb37b 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -58,4 +58,11 @@ void *bpf_rdonly_cast(void *obj, __u32 btf_id) __ksym;
 extern int bpf_get_file_xattr(struct file *file, const char *name,
 			      struct bpf_dynptr *value_ptr) __ksym;
 extern int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr *digest_ptr) __ksym;
+
+extern struct bpf_key *bpf_lookup_user_key(__u32 serial, __u64 flags) __ksym;
+extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
+extern void bpf_key_put(struct bpf_key *key) __ksym;
+extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
+				      struct bpf_dynptr *sig_ptr,
+				      struct bpf_key *trusted_keyring) __ksym;
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
index dd7f2bc70048..682b6af8d0a4 100644
--- a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
+++ b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
@@ -16,9 +16,12 @@
 #include <sys/wait.h>
 #include <sys/mman.h>
 #include <linux/keyctl.h>
+#include <sys/xattr.h>
+#include <linux/fsverity.h>
 #include <test_progs.h>
 
 #include "test_verify_pkcs7_sig.skel.h"
+#include "test_sig_in_xattr.skel.h"
 
 #define MAX_DATA_SIZE (1024 * 1024)
 #define MAX_SIG_SIZE 1024
@@ -26,6 +29,10 @@
 #define VERIFY_USE_SECONDARY_KEYRING (1UL)
 #define VERIFY_USE_PLATFORM_KEYRING  (2UL)
 
+#ifndef SHA256_DIGEST_SIZE
+#define SHA256_DIGEST_SIZE      32
+#endif
+
 /* In stripped ARM and x86-64 modules, ~ is surprisingly rare. */
 #define MODULE_SIG_STRING "~Module signature appended~\n"
 
@@ -254,7 +261,7 @@ static int populate_data_item_mod(struct data *data_item)
 	return ret;
 }
 
-void test_verify_pkcs7_sig(void)
+static void test_verify_pkcs7_sig_from_map(void)
 {
 	libbpf_print_fn_t old_print_cb;
 	char tmp_dir_template[] = "/tmp/verify_sigXXXXXX";
@@ -400,3 +407,157 @@ void test_verify_pkcs7_sig(void)
 	skel->bss->monitored_pid = 0;
 	test_verify_pkcs7_sig__destroy(skel);
 }
+
+static int get_signature_size(const char *sig_path)
+{
+	struct stat st;
+
+	if (stat(sig_path, &st) == -1)
+		return -1;
+
+	return st.st_size;
+}
+
+static int add_signature_to_xattr(const char *data_path, const char *sig_path)
+{
+	char sig[MAX_SIG_SIZE] = {0};
+	int fd, size, ret;
+
+	if (sig_path) {
+		fd = open(sig_path, O_RDONLY);
+		if (fd < 0)
+			return -1;
+
+		size = read(fd, sig, MAX_SIG_SIZE);
+		close(fd);
+		if (size <= 0)
+			return -1;
+	} else {
+		/* no sig_path, just write 32 bytes of zeros */
+		size = 32;
+	}
+	ret = setxattr(data_path, "user.sig", sig, size, 0);
+	if (!ASSERT_OK(ret, "setxattr"))
+		return -1;
+
+	return 0;
+}
+
+static int test_open_file(struct test_sig_in_xattr *skel, char *data_path,
+			  pid_t pid, bool should_success, char *name)
+{
+	int ret;
+
+	skel->bss->monitored_pid = pid;
+	ret = open(data_path, O_RDONLY);
+	close(ret);
+	skel->bss->monitored_pid = 0;
+
+	if (should_success) {
+		if (!ASSERT_GE(ret, 0, name))
+			return -1;
+	} else {
+		if (!ASSERT_LT(ret, 0, name))
+			return -1;
+	}
+	return 0;
+}
+
+static void test_pkcs7_sig_fsverity(void)
+{
+	char data_path[PATH_MAX];
+	char sig_path[PATH_MAX];
+	char tmp_dir_template[] = "/tmp/verify_sigXXXXXX";
+	char *tmp_dir;
+	struct test_sig_in_xattr *skel = NULL;
+	pid_t pid;
+	int ret;
+
+	tmp_dir = mkdtemp(tmp_dir_template);
+	if (!ASSERT_OK_PTR(tmp_dir, "mkdtemp"))
+		return;
+
+	snprintf(data_path, PATH_MAX, "%s/data-file", tmp_dir);
+	snprintf(sig_path, PATH_MAX, "%s/sig-file", tmp_dir);
+
+	ret = _run_setup_process(tmp_dir, "setup");
+	if (!ASSERT_OK(ret, "_run_setup_process"))
+		goto out;
+
+	ret = _run_setup_process(tmp_dir, "fsverity-create-sign");
+
+	if (ret) {
+		printf("%s: SKIP: fsverity [sign|enable] doesn't work.\n", __func__);
+		test__skip();
+		goto out;
+	}
+
+	skel = test_sig_in_xattr__open();
+	if (!ASSERT_OK_PTR(skel, "test_sig_in_xattr__open"))
+		goto out;
+	ret = get_signature_size(sig_path);
+	if (!ASSERT_GT(ret, 0, "get_signaure_size"))
+		goto out;
+	skel->bss->sig_size = ret;
+	skel->bss->user_keyring_serial = syscall(__NR_request_key, "keyring",
+						 "ebpf_testing_keyring", NULL,
+						 KEY_SPEC_SESSION_KEYRING);
+	memcpy(skel->bss->digest, "FSVerity", 8);
+
+	ret = test_sig_in_xattr__load(skel);
+	if (!ASSERT_OK(ret, "test_sig_in_xattr__load"))
+		goto out;
+
+	ret = test_sig_in_xattr__attach(skel);
+	if (!ASSERT_OK(ret, "test_sig_in_xattr__attach"))
+		goto out;
+
+	pid = getpid();
+
+	/* Case 1: fsverity is not enabled, open should succeed */
+	if (test_open_file(skel, data_path, pid, true, "open_1"))
+		goto out;
+
+	/* Case 2: fsverity is enabled, xattr is missing, open should
+	 * fail
+	 */
+	ret = _run_setup_process(tmp_dir, "fsverity-enable");
+	if (!ASSERT_OK(ret, "fsverity-enable"))
+		goto out;
+	if (test_open_file(skel, data_path, pid, false, "open_2"))
+		goto out;
+
+	/* Case 3: fsverity is enabled, xattr has valid signature, open
+	 * should succeed
+	 */
+	ret = add_signature_to_xattr(data_path, sig_path);
+	if (!ASSERT_OK(ret, "add_signature_to_xattr_1"))
+		goto out;
+
+	if (test_open_file(skel, data_path, pid, true, "open_3"))
+		goto out;
+
+	/* Case 4: fsverity is enabled, xattr has invalid signature, open
+	 * should fail
+	 */
+	ret = add_signature_to_xattr(data_path, NULL);
+	if (!ASSERT_OK(ret, "add_signature_to_xattr_2"))
+		goto out;
+	test_open_file(skel, data_path, pid, false, "open_4");
+
+out:
+	_run_setup_process(tmp_dir, "cleanup");
+	if (!skel)
+		return;
+
+	skel->bss->monitored_pid = 0;
+	test_sig_in_xattr__destroy(skel);
+}
+
+void test_verify_pkcs7_sig(void)
+{
+	if (test__start_subtest("pkcs7_sig_from_map"))
+		test_verify_pkcs7_sig_from_map();
+	if (test__start_subtest("pkcs7_sig_fsverity"))
+		test_pkcs7_sig_fsverity();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_sig_in_xattr.c b/tools/testing/selftests/bpf/progs/test_sig_in_xattr.c
new file mode 100644
index 000000000000..820b891171d8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sig_in_xattr.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+#ifndef SHA256_DIGEST_SIZE
+#define SHA256_DIGEST_SIZE      32
+#endif
+
+#define MAX_SIG_SIZE 1024
+
+/* By default, "fsverity sign" signs a file with fsverity_formatted_digest
+ * of the file. fsverity_formatted_digest on the kernel side is only used
+ * with CONFIG_FS_VERITY_BUILTIN_SIGNATURES. However, BPF LSM doesn't not
+ * require CONFIG_FS_VERITY_BUILTIN_SIGNATURES, so vmlinux.h may not have
+ * fsverity_formatted_digest. In this test, we intentionally avoid using
+ * fsverity_formatted_digest.
+ *
+ * Luckily, fsverity_formatted_digest is simply 8-byte magic followed by
+ * fsverity_digest. We use a char array of size fsverity_formatted_digest
+ * plus SHA256_DIGEST_SIZE. The magic part of it is filled by user space,
+ * and the rest of it is filled by bpf_get_fsverity_digest.
+ *
+ * Note that, generating signatures based on fsverity_formatted_digest is
+ * the design choice of this selftest (and "fsverity sign"). With BPF
+ * LSM, we have the flexibility to generate signature based on other data
+ * sets, for example, fsverity_digest or only the digest[] part of it.
+ */
+#define MAGIC_SIZE 8
+char digest[MAGIC_SIZE + sizeof(struct fsverity_digest) + SHA256_DIGEST_SIZE];
+
+__u32 monitored_pid;
+char sig[MAX_SIG_SIZE];
+__u32 sig_size;
+__u32 user_keyring_serial;
+
+SEC("lsm.s/file_open")
+int BPF_PROG(test_file_open, struct file *f)
+{
+	struct bpf_dynptr digest_ptr, sig_ptr;
+	struct bpf_key *trusted_keyring;
+	__u32 pid;
+	int ret;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid != monitored_pid)
+		return 0;
+
+	/* digest_ptr points to fsverity_digest */
+	bpf_dynptr_from_mem(digest + MAGIC_SIZE, sizeof(digest) - MAGIC_SIZE, 0, &digest_ptr);
+
+	ret = bpf_get_fsverity_digest(f, &digest_ptr);
+	/* No verity, allow access */
+	if (ret < 0)
+		return 0;
+
+	/* Move digest_ptr to fsverity_formatted_digest */
+	bpf_dynptr_from_mem(digest, sizeof(digest), 0, &digest_ptr);
+
+	/* Read signature from xattr */
+	bpf_dynptr_from_mem(sig, sizeof(sig), 0, &sig_ptr);
+	ret = bpf_get_file_xattr(f, "user.sig", &sig_ptr);
+	/* No signature, reject access */
+	if (ret < 0)
+		return -EPERM;
+
+	trusted_keyring = bpf_lookup_user_key(user_keyring_serial, 0);
+	if (!trusted_keyring)
+		return -ENOENT;
+
+	/* Verify signature */
+	ret = bpf_verify_pkcs7_signature(&digest_ptr, &sig_ptr, trusted_keyring);
+
+	bpf_key_put(trusted_keyring);
+	return ret;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
index 7748cc23de8a..f42e9f3831a1 100644
--- a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
+++ b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
@@ -10,17 +10,11 @@
 #include <errno.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include "bpf_kfuncs.h"
 
 #define MAX_DATA_SIZE (1024 * 1024)
 #define MAX_SIG_SIZE 1024
 
-extern struct bpf_key *bpf_lookup_user_key(__u32 serial, __u64 flags) __ksym;
-extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
-extern void bpf_key_put(struct bpf_key *key) __ksym;
-extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
-				      struct bpf_dynptr *sig_ptr,
-				      struct bpf_key *trusted_keyring) __ksym;
-
 __u32 monitored_pid;
 __u32 user_keyring_serial;
 __u64 system_keyring_id;
diff --git a/tools/testing/selftests/bpf/verify_sig_setup.sh b/tools/testing/selftests/bpf/verify_sig_setup.sh
index ba08922b4a27..f2cac42298ba 100755
--- a/tools/testing/selftests/bpf/verify_sig_setup.sh
+++ b/tools/testing/selftests/bpf/verify_sig_setup.sh
@@ -60,6 +60,27 @@ cleanup() {
 	rm -rf ${tmp_dir}
 }
 
+fsverity_create_sign_file() {
+	local tmp_dir="$1"
+
+	data_file=${tmp_dir}/data-file
+	sig_file=${tmp_dir}/sig-file
+	dd if=/dev/urandom of=$data_file bs=1 count=12345 2> /dev/null
+	fsverity sign --key ${tmp_dir}/signing_key.pem $data_file $sig_file
+
+	# We do not want to enable fsverity on $data_file yet. Try whether
+	# the file system support fsverity on a different file.
+	touch ${tmp_dir}/tmp-file
+	fsverity enable ${tmp_dir}/tmp-file
+}
+
+fsverity_enable_file() {
+	local tmp_dir="$1"
+
+	data_file=${tmp_dir}/data-file
+	fsverity enable $data_file
+}
+
 catch()
 {
 	local exit_code="$1"
@@ -86,6 +107,10 @@ main()
 		setup "${tmp_dir}"
 	elif [[ "${action}" == "cleanup" ]]; then
 		cleanup "${tmp_dir}"
+	elif [[ "${action}" == "fsverity-create-sign" ]]; then
+		fsverity_create_sign_file "${tmp_dir}"
+	elif [[ "${action}" == "fsverity-enable" ]]; then
+		fsverity_enable_file "${tmp_dir}"
 	else
 		echo "Unknown action: ${action}"
 		exit 1
-- 
2.34.1



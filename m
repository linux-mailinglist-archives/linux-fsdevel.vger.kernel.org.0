Return-Path: <linux-fsdevel+bounces-76739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMMzI0swimm3IAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:06:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 156DA113F29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B638E302D58E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 19:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD7C423A64;
	Mon,  9 Feb 2026 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gxbZ7qeY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D594F4218BE
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770663981; cv=none; b=U0mrT7Q/sMW84ZyZYFvy0dMS/EdEj0/0C/1tBgruQSXG1cMOIQET4CzA2bht8cLKoRFlZOLU5OjYxo6WUL4AzuJ3pAb/MdTV/8AM6rx9w/6WatkkzxzPIV/2ORhBREWmIrd5vRgeSINgMWKa639Sqi4Yn69swYHMaoVf2BodCpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770663981; c=relaxed/simple;
	bh=t1eYTgIQfsUjEcHPxFna7n0kTRcRTM8rS8PN9kAqxRM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EwImxhbfnBo82tj38qlyfMexUrphHLF9Q5OaE3xigeND6w8443u8sUd3Zh9+waLyk+CBcJ7fA6Hpt+e+/ICG+DI4XiLV7mM5NKaBVZv/xeBaRsMajvxbVyK3kViPSBL2/UvCZ+4OSMVxJy7DKVTZF6vd0/19lrWjTfUmD+P7NYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gxbZ7qeY; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-409e0cc22c6so24143669fac.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 11:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770663980; x=1771268780; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3gza5co478YYPeHfG5MnlQXarASyDN4UjfFwF45d5I=;
        b=gxbZ7qeY5hoMxfxjp/HAdqbdg+E2mNZuW2m95ulTq1KtUhwA1ZUB1X4O93kyNxPCFa
         hu75jryXeTjgN4HDfBy7jdKSQ/jcoAdYIqu4P5KxgB0+6VhwnK4JXsKsyywKN0ggXxl7
         3wo+m4MeX29LGuOFg5RTEdkOKthfoWpzGt75EN7jsMMxuSySSHJ9lbb7qWrwu2tJ7yii
         xrwLaAKfk+J7KRtUWc6b832RBOAr0TsOO7v88384PWBsHq+l8FvwnVWu+lVdACz6+k0E
         nAoVlMWyAz93s3MzLIq+WNo73m4xTpd0ARhxAhSLPfyz38b2/xHZUlRW+1seAUSJ1IOq
         TjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770663980; x=1771268780;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3gza5co478YYPeHfG5MnlQXarASyDN4UjfFwF45d5I=;
        b=aPb0VU87KUy31O46ZFwjX16r2m/vFK1DSgtw5YQ28u20jmo2bfm7VkMZI4bMX7jGPs
         IEhPlRm9LjeTOmtEiEMljJkyLOMzx2YTJeO2i1u2NI3+qxK38pa0UdNpW4zIHusYbyR4
         kFEnom469S9zuF914oFdVy29KSH7PdMRPhRwKZuLO25yZbyO/WfAVx+pIQDgb9a0WKVY
         ZESUItYw0UjFAy3FALIs/v2EkOwI/ruiOh2gC5whf/RLanyyUl/LZJ/7tpxSkXe0m2IK
         /WJNLoJQu88wiFpcXsRPOYdjigN+CpVhjZeXjnjb34cxN9bMJZRVpPJw5q1BJgj/me4T
         NlIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTG9iGfApZ/MwDgZyYHV2jPrqAu54U51eKmr8QWsnHRvCz5xDbyDUrhNfWeCbH9lHhkp9CNyxFx1MpvGez@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2pq9srQVSz9nsm3OtNrTUxWsspJZzEtSe9U7vfbt+UcHXiHe5
	adHbE8GzzoiQk0imuk5lEDBbzVomZxisde9PgEgFUuhRT9SBDMrEs7gDbtizD7aEkPACYQUa9ts
	yntx9KQ==
X-Received: from oalg15.prod.google.com ([2002:a05:6870:85cf:b0:404:59ca:ea1c])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:b414:b0:3d1:a15c:f06a
 with SMTP id 586e51a60fabf-40bf30182b4mr364249fac.0.1770663979793; Mon, 09
 Feb 2026 11:06:19 -0800 (PST)
Date: Mon,  9 Feb 2026 19:06:05 +0000
In-Reply-To: <20260209190605.1564597-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209190605.1564597-1-avagin@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260209190605.1564597-5-avagin@google.com>
Subject: [PATCH 4/4] selftests/exec: add test for HWCAP inheritance
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Chen Ridong <chenridong@huawei.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Koutny <mkoutny@suse.com>, 
	Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-76739-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@google.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,mihalicyn.com,vger.kernel.org,kvack.org,lists.linux.dev,huawei.com,xmission.com,oracle.com,suse.com,google.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 156DA113F29
X-Rspamd-Action: no action

Verify that HWCAPs are correctly inherited/preserved across execve() when
modified via prctl(PR_SET_MM_AUXV).

The test performs the following steps:
* reads the current AUXV using prctl(PR_GET_AUXV);
* finds an HWCAP entry and toggles its most significant bit;
* replaces the AUXV of the current process with the modified one using
  prctl(PR_SET_MM, PR_SET_MM_AUXV);
* executes itself to verify that the new program sees the modified HWCAP
  value.

Signed-off-by: Andrei Vagin <avagin@google.com>
---
 tools/testing/selftests/exec/.gitignore      |   1 +
 tools/testing/selftests/exec/Makefile        |   1 +
 tools/testing/selftests/exec/hwcap_inherit.c | 105 +++++++++++++++++++
 3 files changed, 107 insertions(+)
 create mode 100644 tools/testing/selftests/exec/hwcap_inherit.c

diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
index 7f3d1ae762ec..2ff245fd0ba6 100644
--- a/tools/testing/selftests/exec/.gitignore
+++ b/tools/testing/selftests/exec/.gitignore
@@ -19,3 +19,4 @@ null-argv
 xxxxxxxx*
 pipe
 S_I*.test
+hwcap_inherit
\ No newline at end of file
diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 45a3cfc435cf..e73005965e05 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -20,6 +20,7 @@ TEST_FILES := Makefile
 TEST_GEN_PROGS += recursion-depth
 TEST_GEN_PROGS += null-argv
 TEST_GEN_PROGS += check-exec
+TEST_GEN_PROGS += hwcap_inherit
 
 EXTRA_CLEAN := $(OUTPUT)/subdir.moved $(OUTPUT)/execveat.moved $(OUTPUT)/xxxxx*	\
 	       $(OUTPUT)/S_I*.test
diff --git a/tools/testing/selftests/exec/hwcap_inherit.c b/tools/testing/selftests/exec/hwcap_inherit.c
new file mode 100644
index 000000000000..1b43b2dbb1d0
--- /dev/null
+++ b/tools/testing/selftests/exec/hwcap_inherit.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <sys/auxv.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <linux/prctl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <elf.h>
+#include <linux/auxvec.h>
+
+#include "../kselftest.h"
+
+static int find_msb(unsigned long v)
+{
+	return sizeof(v)*8 - __builtin_clzl(v) - 1;
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned long auxv[1024], hwcap, new_hwcap, hwcap_idx;
+	int size, hwcap_type = 0, hwcap_feature, count, status;
+	char hwcap_str[32], hwcap_type_str[32];
+	pid_t pid;
+
+	if (argc > 1 && strcmp(argv[1], "verify") == 0) {
+		unsigned long type = strtoul(argv[2], NULL, 16);
+		unsigned long expected = strtoul(argv[3], NULL, 16);
+		unsigned long hwcap = getauxval(type);
+
+		if (hwcap != expected) {
+			ksft_print_msg("HWCAP mismatch: type %lx, expected %lx, got %lx\n",
+					type, expected, hwcap);
+			return 1;
+		}
+		ksft_print_msg("HWCAP matched: %lx\n", hwcap);
+		return 0;
+	}
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	size = prctl(PR_GET_AUXV, auxv, sizeof(auxv), 0, 0);
+	if (size == -1)
+		ksft_exit_fail_perror("prctl(PR_GET_AUXV)");
+
+	count = size / sizeof(unsigned long);
+
+	/* Find the "latest" feature and try to mask it out. */
+	for (int i = 0; i < count - 1; i += 2) {
+		hwcap = auxv[i + 1];
+		if (hwcap == 0)
+			continue;
+		switch (auxv[i]) {
+		case AT_HWCAP4:
+		case AT_HWCAP3:
+		case AT_HWCAP2:
+		case AT_HWCAP:
+			hwcap_type = auxv[i];
+			hwcap_feature = find_msb(hwcap);
+			hwcap_idx = i + 1;
+			break;
+		default:
+			continue;
+		}
+	}
+	if (hwcap_type == 0)
+		ksft_exit_skip("No features found, skipping test\n");
+	hwcap = auxv[hwcap_idx];
+	new_hwcap = hwcap ^ (1UL << hwcap_feature);
+	auxv[hwcap_idx] = new_hwcap;
+
+	if (prctl(PR_SET_MM, PR_SET_MM_AUXV, auxv, size, 0) < 0) {
+		if (errno == EPERM)
+			ksft_exit_skip("prctl(PR_SET_MM_AUXV) requires CAP_SYS_RESOURCE\n");
+		ksft_exit_fail_perror("prctl(PR_SET_MM_AUXV)");
+	}
+
+	pid = fork();
+	if (pid < 0)
+		ksft_exit_fail_perror("fork");
+	if (pid == 0) {
+		char *new_argv[] = { argv[0], "verify", hwcap_type_str, hwcap_str, NULL };
+
+		snprintf(hwcap_str, sizeof(hwcap_str), "%lx", new_hwcap);
+		snprintf(hwcap_type_str, sizeof(hwcap_type_str), "%x", hwcap_type);
+
+		execv(argv[0], new_argv);
+		perror("execv");
+		exit(1);
+	}
+
+	if (waitpid(pid, &status, 0) == -1)
+		ksft_exit_fail_perror("waitpid");
+	if (status != 0)
+		ksft_exit_fail_msg("HWCAP inheritance failed (status %d)\n", status);
+
+	ksft_test_result_pass("HWCAP inheritance succeeded\n");
+	ksft_exit_pass();
+	return 0;
+}
-- 
2.53.0.239.g8d8fc8a987-goog



Return-Path: <linux-fsdevel+bounces-37210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E6B9EF8BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 18:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D746D296484
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 17:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D359722A80A;
	Thu, 12 Dec 2024 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="G7AgHd0M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E568E22333B
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025377; cv=none; b=E7Rqjuypf4/l8kplFLqYIh62Rtw/090R+PbO+IbxAknYudeH9Chg4THQwPFJgWgzCRAQKc2LISJJ7cqT4vPvghk9pCKeXiztVate9u6mvjceMld3uPwehoJLWBy0qrZ/Z7eERniXC5bimvtZ17oR70nUWQ3D99932zG/GOfH0K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025377; c=relaxed/simple;
	bh=JRWYVcMH5s897bnNdcaAdJ2sQRGzDoHCkFj5fUhC+NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eTCfqoDbGrIk7yf44HVzhu9neiFIzQ7wCr837RjMc3VvRUcl0o+7lfhydPwQh/Ze5uWN0FuI4A9USvtpKyE94nx1j36eT7hm2PMfVyvPEOEqCsMBP+8/UY3EsZ1KoLI14CD7oFnAin5h0zO5yBPsdVVtlvhpB7pfL9KNIyqk52A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=G7AgHd0M; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Y8KYc6fDdz78r;
	Thu, 12 Dec 2024 18:42:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1734025364;
	bh=6ybjqrej/Df/o67JLMrP/Nkc9gTh6BXP3ChFpaKk0Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G7AgHd0MArq1o4ES0c2/ByE0dSKPLvk0l3QkqlKnlqsi9fg4acLYqBEw8ZSi0qbpF
	 ddw9PARiJH4jJ0rGtKK5BY6QL3x+Phg0VimgvNaEXxcWLcfgL9iJhtDYMzVSNqYjZp
	 1G7rajDpTNMs0C1JqXg3L/rYayU1NXVbPRCVwqMM=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Y8KYb4QnTz59W;
	Thu, 12 Dec 2024 18:42:43 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Alejandro Colomar <alx@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Heimes <christian@python.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Elliott Hughes <enh@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Eric Chiang <ericchiang@google.com>,
	Fan Wu <wufan@linux.microsoft.com>,
	Florian Weimer <fweimer@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Morris <jamorris@linux.microsoft.com>,
	Jan Kara <jack@suse.cz>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jordan R Abrahams <ajordanr@google.com>,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Luca Boccassi <bluca@debian.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Scott Shell <scottsh@microsoft.com>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Steve Dower <steve.dower@python.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
	Xiaoming Ni <nixiaoming@huawei.com>,
	kernel-hardening@lists.openwall.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v23 5/8] samples/check-exec: Add set-exec
Date: Thu, 12 Dec 2024 18:42:20 +0100
Message-ID: <20241212174223.389435-6-mic@digikod.net>
In-Reply-To: <20241212174223.389435-1-mic@digikod.net>
References: <20241212174223.389435-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add a simple tool to set SECBIT_EXEC_RESTRICT_FILE or
SECBIT_EXEC_DENY_INTERACTIVE before executing a command.  This is useful
to easily test against enlighten script interpreters.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241212174223.389435-6-mic@digikod.net
---

Changes since v19:
* Rename file and directory.
* Update securebits and related arguments.
* Remove useless call to prctl() when securebits are unchanged.
---
 samples/Kconfig               |  7 +++
 samples/Makefile              |  1 +
 samples/check-exec/.gitignore |  1 +
 samples/check-exec/Makefile   | 14 ++++++
 samples/check-exec/set-exec.c | 85 +++++++++++++++++++++++++++++++++++
 5 files changed, 108 insertions(+)
 create mode 100644 samples/check-exec/.gitignore
 create mode 100644 samples/check-exec/Makefile
 create mode 100644 samples/check-exec/set-exec.c

diff --git a/samples/Kconfig b/samples/Kconfig
index b288d9991d27..efa28ceadc42 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -291,6 +291,13 @@ config SAMPLE_CGROUP
 	help
 	  Build samples that demonstrate the usage of the cgroup API.
 
+config SAMPLE_CHECK_EXEC
+	bool "Exec secure bits examples"
+	depends on CC_CAN_LINK && HEADERS_INSTALL
+	help
+	  Build a tool to easily configure SECBIT_EXEC_RESTRICT_FILE and
+	  SECBIT_EXEC_DENY_INTERACTIVE.
+
 source "samples/rust/Kconfig"
 
 endif # SAMPLES
diff --git a/samples/Makefile b/samples/Makefile
index b85fa64390c5..f988202f3a30 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -3,6 +3,7 @@
 
 subdir-$(CONFIG_SAMPLE_AUXDISPLAY)	+= auxdisplay
 subdir-$(CONFIG_SAMPLE_ANDROID_BINDERFS) += binderfs
+subdir-$(CONFIG_SAMPLE_CHECK_EXEC)	+= check-exec
 subdir-$(CONFIG_SAMPLE_CGROUP) += cgroup
 obj-$(CONFIG_SAMPLE_CONFIGFS)		+= configfs/
 obj-$(CONFIG_SAMPLE_CONNECTOR)		+= connector/
diff --git a/samples/check-exec/.gitignore b/samples/check-exec/.gitignore
new file mode 100644
index 000000000000..3f8119112ccf
--- /dev/null
+++ b/samples/check-exec/.gitignore
@@ -0,0 +1 @@
+/set-exec
diff --git a/samples/check-exec/Makefile b/samples/check-exec/Makefile
new file mode 100644
index 000000000000..d9f976e3ff98
--- /dev/null
+++ b/samples/check-exec/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: BSD-3-Clause
+
+userprogs-always-y := \
+	set-exec
+
+userccflags += -I usr/include
+
+.PHONY: all clean
+
+all:
+	$(MAKE) -C ../.. samples/check-exec/
+
+clean:
+	$(MAKE) -C ../.. M=samples/check-exec/ clean
diff --git a/samples/check-exec/set-exec.c b/samples/check-exec/set-exec.c
new file mode 100644
index 000000000000..ba86a60a20dd
--- /dev/null
+++ b/samples/check-exec/set-exec.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Simple tool to set SECBIT_EXEC_RESTRICT_FILE, SECBIT_EXEC_DENY_INTERACTIVE,
+ * before executing a command.
+ *
+ * Copyright © 2024 Microsoft Corporation
+ */
+
+#define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__
+#include <errno.h>
+#include <linux/prctl.h>
+#include <linux/securebits.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/prctl.h>
+#include <unistd.h>
+
+static void print_usage(const char *argv0)
+{
+	fprintf(stderr, "usage: %s -f|-i -- <cmd> [args]...\n\n", argv0);
+	fprintf(stderr, "Execute a command with\n");
+	fprintf(stderr, "- SECBIT_EXEC_RESTRICT_FILE set: -f\n");
+	fprintf(stderr, "- SECBIT_EXEC_DENY_INTERACTIVE set: -i\n");
+}
+
+int main(const int argc, char *const argv[], char *const *const envp)
+{
+	const char *cmd_path;
+	char *const *cmd_argv;
+	int opt, secbits_cur, secbits_new;
+	bool has_policy = false;
+
+	secbits_cur = prctl(PR_GET_SECUREBITS);
+	if (secbits_cur == -1) {
+		/*
+		 * This should never happen, except with a buggy seccomp
+		 * filter.
+		 */
+		perror("ERROR: Failed to get securebits");
+		return 1;
+	}
+
+	secbits_new = secbits_cur;
+	while ((opt = getopt(argc, argv, "fi")) != -1) {
+		switch (opt) {
+		case 'f':
+			secbits_new |= SECBIT_EXEC_RESTRICT_FILE |
+				       SECBIT_EXEC_RESTRICT_FILE_LOCKED;
+			has_policy = true;
+			break;
+		case 'i':
+			secbits_new |= SECBIT_EXEC_DENY_INTERACTIVE |
+				       SECBIT_EXEC_DENY_INTERACTIVE_LOCKED;
+			has_policy = true;
+			break;
+		default:
+			print_usage(argv[0]);
+			return 1;
+		}
+	}
+
+	if (!argv[optind] || !has_policy) {
+		print_usage(argv[0]);
+		return 1;
+	}
+
+	if (secbits_cur != secbits_new &&
+	    prctl(PR_SET_SECUREBITS, secbits_new)) {
+		perror("Failed to set secure bit(s).");
+		fprintf(stderr,
+			"Hint: The running kernel may not support this feature.\n");
+		return 1;
+	}
+
+	cmd_path = argv[optind];
+	cmd_argv = argv + optind;
+	fprintf(stderr, "Executing command...\n");
+	execvpe(cmd_path, cmd_argv, envp);
+	fprintf(stderr, "Failed to execute \"%s\": %s\n", cmd_path,
+		strerror(errno));
+	return 1;
+}
-- 
2.47.1



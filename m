Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DE4234B30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 20:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387827AbgGaShv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 14:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387818AbgGaShu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:37:50 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8B0C06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2020 11:37:50 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id a186so5195339qke.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2020 11:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5v86mhTzM4SZYwpUDzMMNrk+SN/FmVXE8SoMYa53F6Y=;
        b=kSNBHuhvWiu3Edhc80EshTZNiBJwW7/jgs6V28cgkNyxmuvHy7vqFAFbcpT5BtWxoh
         gZ0IV7fMZlyWMviQSeHw/mWYkqtXLjPVr1Umbt5L3Mk+43Msb33WT/fLBgwpDyV4ZX2w
         rInWxFkHHL9er683V4RC0fWxdftbZ4D5mGsLGvW0aYLQ5TOBI9MvQym9To7xht1lLt6F
         4839tMbjgQBpMh5PHT/P/cnss4XwATs5lqiRn+TyG219C6xvydjpIVAllNALhq+uolGP
         8WAM3y3vsmxQKxw0gUpzOrYB497D+jxud8jvp1LlhWLmTXfbnlkWn/B+iju5MmT5p3su
         d/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5v86mhTzM4SZYwpUDzMMNrk+SN/FmVXE8SoMYa53F6Y=;
        b=N+vCw1Yszwt8UWbULNyuKkNXnU6xdlsZW0ndVzlofiD9l3ZDFp8oRWcBsPkt1okVhi
         vVzC/adTmGhkeBcOkB2Z1ChFyxR6VpvJWN5oD1D64cy40lqKkGg/0DeuXCXNcbleL6xA
         G+DdSQzPOoIxu0+jj9ftT9NgETlyIR/27ZLAcvXYm6OiR0f7He6XXRD/z8721Ft5Q4Y5
         x4ivI2qOUX8/jvsiqWaioHQcBtmd8ajHKXRWOtwllAXoWd7+9B1itmuoQ1XLW8tVqPT3
         WxmdOzi43PRDuqo6kNxgy9q2Pp/hI/70IWCpvNGx/8IuZgix+TkdoQrgjF1w8EHcvz4z
         oNJw==
X-Gm-Message-State: AOAM530ibWrRXQZ/9qWVGe2el5LWkASsdRRjvK+9xyuMfBiB/QbYUUyu
        XCTwEziM3alaw6M2HkBnccs2GwM6lUKAkE8=
X-Google-Smtp-Source: ABdhPJwjzJJL2kQeuj1qJzZxqRaRImKtWaLo5X70m4f+HV9AozHw6bI9+HYOgUTiJdz2IxZ3sUVEDtCfABQ2Xls=
X-Received: by 2002:a0c:ec86:: with SMTP id u6mr5351729qvo.58.1596220669859;
 Fri, 31 Jul 2020 11:37:49 -0700 (PDT)
Date:   Fri, 31 Jul 2020 14:37:44 -0400
In-Reply-To: <20200731183745.1669355-1-ckennelly@google.com>
Message-Id: <20200731183745.1669355-3-ckennelly@google.com>
Mime-Version: 1.0
References: <20200731183745.1669355-1-ckennelly@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 2/2 v2] Add self-test for verifying load alignment.
From:   Chris Kennelly <ckennelly@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Song Liu <songliubraving@fb.com>
Cc:     David Rientjes <rientjes@google.com>,
        Ian Rogers <irogers@google.com>,
        Hugh Dickens <hughd@google.com>,
        Andrew Morton <akpm@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This produces a PIE binary with a variety of p_align requirements,
suitable for verifying that the load address meets that alignment
requirement.

Signed-off-by: Chris Kennelly <ckennelly@google.com>
---
 tools/testing/selftests/exec/.gitignore     |  1 +
 tools/testing/selftests/exec/Makefile       |  9 ++-
 tools/testing/selftests/exec/load_address.c | 68 +++++++++++++++++++++
 3 files changed, 76 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/exec/load_address.c

diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
index 94b02a18f230b..80f57881e9146 100644
--- a/tools/testing/selftests/exec/.gitignore
+++ b/tools/testing/selftests/exec/.gitignore
@@ -7,6 +7,7 @@ execveat.moved
 execveat.path.ephemeral
 execveat.ephemeral
 execveat.denatured
+/load_address_*
 /recursion-depth
 xxxxxxxx*
 pipe
diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 4453b8f8def37..81cd5d9860629 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -4,7 +4,7 @@ CFLAGS += -Wno-nonnull
 CFLAGS += -D_GNU_SOURCE
 
 TEST_PROGS := binfmt_script
-TEST_GEN_PROGS := execveat
+TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216
 TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir pipe
 # Makefile is a run-time dependency, since it's accessed by the execveat test
 TEST_FILES := Makefile
@@ -26,4 +26,9 @@ $(OUTPUT)/execveat.symlink: $(OUTPUT)/execveat
 $(OUTPUT)/execveat.denatured: $(OUTPUT)/execveat
 	cp $< $@
 	chmod -x $@
-
+$(OUTPUT)/load_address_4096: load_address.c
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000 -pie $< -o $@
+$(OUTPUT)/load_address_2097152: load_address.c
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x200000 -pie $< -o $@
+$(OUTPUT)/load_address_16777216: load_address.c
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000000 -pie $< -o $@
diff --git a/tools/testing/selftests/exec/load_address.c b/tools/testing/selftests/exec/load_address.c
new file mode 100644
index 0000000000000..d487c2f6a6150
--- /dev/null
+++ b/tools/testing/selftests/exec/load_address.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <link.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+struct Statistics {
+	unsigned long long load_address;
+	unsigned long long alignment;
+};
+
+int ExtractStatistics(struct dl_phdr_info *info, size_t size, void *data)
+{
+	struct Statistics *stats = (struct Statistics *) data;
+	int i;
+
+	if (info->dlpi_name != NULL && info->dlpi_name[0] != '\0') {
+		// Ignore headers from other than the executable.
+		return 2;
+	}
+
+	stats->load_address = (unsigned long long) info->dlpi_addr;
+	stats->alignment = 0;
+
+	for (i = 0; i < info->dlpi_phnum; i++) {
+		if (info->dlpi_phdr[i].p_type != PT_LOAD)
+			continue;
+
+		if (info->dlpi_phdr[i].p_align > stats->alignment)
+			stats->alignment = info->dlpi_phdr[i].p_align;
+	}
+
+	return 1;  // Terminate dl_iterate_phdr.
+}
+
+int main(int argc, char **argv)
+{
+	struct Statistics extracted;
+	unsigned long long misalign;
+	int ret;
+
+	ret = dl_iterate_phdr(ExtractStatistics, &extracted);
+	if (ret != 1) {
+		fprintf(stderr, "FAILED\n");
+		return 1;
+	}
+
+	if (extracted.alignment == 0) {
+		fprintf(stderr, "No alignment found\n");
+		return 1;
+	} else if (extracted.alignment & (extracted.alignment - 1)) {
+		fprintf(stderr, "Alignment is not a power of 2\n");
+		return 1;
+	}
+
+	misalign = extracted.load_address & (extracted.alignment - 1);
+	if (misalign) {
+		printf("alignment = %llu, load_address = %llu\n",
+			extracted.alignment, extracted.load_address);
+		fprintf(stderr, "FAILED\n");
+		return 1;
+	}
+
+	fprintf(stderr, "PASS\n");
+	return 0;
+}
-- 
2.28.0.163.g6104cc2f0b6-goog


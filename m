Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0082B24E3F4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 01:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgHUXjO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 19:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgHUXi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 19:38:56 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7217CC061573
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 16:38:56 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id a186so2455128qke.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 16:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TSLmEPwlFccaRVuUrhKv3FaWDdmO/JVWcm6IHHbjArg=;
        b=julErzN+mNPctjW2tIYSo2PVDr4mRN4OJ3eGmTv5d1wb7Fd6DgqQWFQB7bdtal6SdY
         iNYxrxVIY+EbA9V1RcNlGRxzADVibuS9oI+04OoasYO5Pf9vUMe7437Mcu56WzjFDcUa
         4ObuI9OL5wXGcAgNoYV5FEINB0ml+WfOj6jmH8BXWLXzQ3Y4qJqpUZN32AqsdxaJUwY3
         eP95eJk7+yipnN1kilTzgkButU4Gtk8DM6+tjomNOLFc9R9cMZdmqtFciG4JS87A2uHh
         zGg9izTeWf76F5fHLjM4k4RXpCifGN81O9Fvh+/WndzTyEoPHH7YDuwZhrtTzQI3fJ6K
         LykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TSLmEPwlFccaRVuUrhKv3FaWDdmO/JVWcm6IHHbjArg=;
        b=g/wSQSFs1HqCZIvkG6WcT5k7s+p0gqX0CZOW5x88mIPFCKjHgCzYeybZbwnEGldq6h
         mABmS9trviie5CTShctI583HAczcMnvvC6ucN4DPIzKPV90Da6AHXqpCBT3yQ74qkKXX
         7ebUa9Qd/HdFlHDPVDdPg+MaUBAWL70B9t2525LcaGadJ2kVsrmg0cdtvgKsEdc8vHtL
         DisoglFR9JjV2FfvIBkT7ML2MdqT676kMgCj3GzXYElaDODg2knUwGwkttKk21jWcWBt
         hUqKqbKgy8hVXOSoMEppSd6xpRCyIQie6J8A/y6bUMjHk1NXlv1pWE/j/Xos01baI9Uf
         GhQg==
X-Gm-Message-State: AOAM532czp44quJTDtHGfs40Y8l9jAoDHYPSin1Mv2vR8i2bqYpJ3SxM
        +j8LIFJH9oBOw25C7Qf4wEm7iFsmLdEznUw=
X-Google-Smtp-Source: ABdhPJwqfP5FHmg5WUuShDAHQ+afX+0COMOTSMvOLitOZZeWUhCwlY7NYdc5FsUHW8TW0XkGIpD5Fk3T2ZMwv0s=
X-Received: from ckennelly28.nyc.corp.google.com ([2620:0:1003:1003:3e52:82ff:fe5a:a91a])
 (user=ckennelly job=sendgmr) by 2002:a05:6214:d6c:: with SMTP id
 12mr4515046qvs.208.1598053135628; Fri, 21 Aug 2020 16:38:55 -0700 (PDT)
Date:   Fri, 21 Aug 2020 19:38:48 -0400
In-Reply-To: <20200821233848.3904680-1-ckennelly@google.com>
Message-Id: <20200821233848.3904680-3-ckennelly@google.com>
Mime-Version: 1.0
References: <20200821233848.3904680-1-ckennelly@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v4 2/2] Add self-test for verifying load alignment.
From:   Chris Kennelly <ckennelly@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Song Liu <songliubraving@fb.com>
Cc:     David Rientjes <rientjes@google.com>,
        Ian Rogers <irogers@google.com>,
        Hugh Dickens <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
index 344a99c6da1b7..9e2f00343f15f 100644
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
index 0a13b110c1e66..cf69b2fcce59e 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -4,7 +4,7 @@ CFLAGS += -Wno-nonnull
 CFLAGS += -D_GNU_SOURCE
 
 TEST_PROGS := binfmt_script non-regular
-TEST_GEN_PROGS := execveat
+TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216
 TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir pipe
 # Makefile is a run-time dependency, since it's accessed by the execveat test
 TEST_FILES := Makefile
@@ -27,4 +27,9 @@ $(OUTPUT)/execveat.symlink: $(OUTPUT)/execveat
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
2.28.0.297.g1956fa8f8d-goog


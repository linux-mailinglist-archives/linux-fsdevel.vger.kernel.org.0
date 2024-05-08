Return-Path: <linux-fsdevel+bounces-19115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE78D8C0323
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 19:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1FE01C225CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 17:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C1F12B159;
	Wed,  8 May 2024 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TT823LaE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC21C5382
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189515; cv=none; b=oBJoNohJ3StjQzrj7DV1OwjUnSqFMX1cxwEEwRBA1a61Z+o/6SvzbMasrAv/U2htE2n3j78IiBQF6fpNIZedeGfJBlKp8rUc6KXRcgSqanqLjqFnPE3Wb9nK3FcyWyEgUwjBKmm2NOalB4D1HE5STJr3bFB7om/Rp2T7MFnWI3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189515; c=relaxed/simple;
	bh=EVV19YgGbcPQsIHd5yk4GzGYcoILxXyLnNlnQWFy9pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C4/wEP3Qtf+0WVQWaoxM4di5FXaryvE0LMs7O/YSeuIz2y9mhs16mkCHIV8Z31bm0AupYmAi7hmWmqfK97Ved3DA9q/OcuZvIIdTqwiikR0CEgFI+rZVAvw7qRbGrb6bNh5haZGcCq0rru2dLOQpsGJyXQ4VdX3lfJJnZwjujxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TT823LaE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so307105ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2024 10:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715189511; x=1715794311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckhcb2/0RYF0Gnhe/jQlCjJECN0VZ08/Fvs6ZKfOACc=;
        b=TT823LaE2Z4LKXmY/o6l28b988iFT0/bsSW5L6lXPIOXs/YULCFcGE3WfOd071tshz
         kwNyO5Ka+V6+hZiZiUCej4/w3UtP2G4qpnQwPuMSgdQ89kc3bIbDsWPj83n13VDzCet5
         bE2oTZmpkBrcIvXz3Bj4KvQ2xdfJfbDgp8B28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715189511; x=1715794311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckhcb2/0RYF0Gnhe/jQlCjJECN0VZ08/Fvs6ZKfOACc=;
        b=gHH5Wu++YEei0s3sEVyAIZNzvv+uUPSz8r8bNqcqH+QL7bPMuIwKCAsb9YBw53srP4
         gOdHGwK0fCqExumKob6mUd6tp9FO1I63E32+uGxMlQC+C4F5uIQsofzjaarq1nJb0YS4
         GES1kr/8gbHF4iy85Q8DAysAh8LM61gZH5jNwUIxdX2JjHGaDzDxczX+4D2axcd2qBgK
         GUpdlxFCIQjQeYGoQhPciXTYr3uEQCjlfMpWxua82tNxme0y4335Gp5sHpcdAt+ZuFfX
         megVul/plA3oCgIFgpY1c7MPdt1Xe4MGZliKApI9FPq6xvBq9iJQqdDRJS5ZRJzYGbtn
         /AbA==
X-Forwarded-Encrypted: i=1; AJvYcCXk+rDASeL9Z0D/y96fZ3lzFdeszs8Dkp7quJ0TzzJ+aUaYoAuV5XLBVQKeE+yWY5F9VQvUJ1/R+UXl0rkXgwDk3VrWKG/Q4NdNVdTE/w==
X-Gm-Message-State: AOJu0YxYGr4I380zYUu6biD/qf6Avfnggb8NAjIa5b0VmJ322uK29Lep
	spUe1N/l6mu0+Vxr0rJs/rY3O7wZ+Kz0G4KYKDcQHhkS5FcTlNnVF+ZQCJEDjw==
X-Google-Smtp-Source: AGHT+IFe9RE0PlweeOYjLwef5REO+i00c2oo7HJiryhYfaXZtd4BvtB2nxrgXXbdGr6zE8h3r5g01g==
X-Received: by 2002:a17:902:dacc:b0:1eb:8299:db35 with SMTP id d9443c01a7336-1eefa58cfe5mr4314535ad.32.1715189510956;
        Wed, 08 May 2024 10:31:50 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d30300b001e2a479954dsm12129520plc.181.2024.05.08.10.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 10:31:50 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: "H . J . Lu" <hjl.tools@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	Chris Kennelly <ckennelly@google.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Fangrui Song <maskray@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Victor Stinner <vstinner@redhat.com>,
	Jan Palus <jpalus@fastmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/3] selftests/exec: Build both static and non-static load_address tests
Date: Wed,  8 May 2024 10:31:46 -0700
Message-Id: <20240508173149.677910-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508172848.work.131-kees@kernel.org>
References: <20240508172848.work.131-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6882; i=keescook@chromium.org;
 h=from:subject; bh=EVV19YgGbcPQsIHd5yk4GzGYcoILxXyLnNlnQWFy9pw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmO7cE7X4mhGALtYnO3LLjThfOhTf4zqWRzUonM
 YIEVDy8ECGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZju3BAAKCRCJcvTf3G3A
 JqzhEACugoYdfeBq9hllOhN230YzjegmLLmyhu7D4ZUW4opBdmlFfiuiuoZexZQUxlhuR0aHobi
 Xktw+k9RzRwGjeUQm6DqEFJ5/ypq1MYaS2e7qfeSwkLfsLSeRGnn2N3Ag6eXL/e/cXhkcQTPo9b
 Vfd0+o5ctjpzD9SDvJKtjz8hG69soCmtgK6rJyovDQslCzC7aDH33Fvri9GB9lyD1Miafv0AZEA
 9H8+/ycD1h+4dKxrn5h5DP7ZMGEhcGDSz8BTtvTibEaIEJNsIVsPkfb0FySoNeRpgIlKOcynYKm
 W5rADoIiq2Js477XNNWD8awi1czVmZBgBP7vXuSdmgQki7LmPUyd3uBH+xc4wZJX7YqTzuU2p6f
 0kCwpXgkwxz5lVtdItPdl4q7RHdCBAungFLFpCqNvhxfnOjp4EeOQcPZWWrBJ4VRM6JnLz6AyBi
 oaadMihDqXQ3DpElP4hIeED20RpP6RnOoxv9NQPTDNLVryc+aqXTTJyaNVDhjFGTZ3lDDrt2YQJ
 BJuugxHoIMXKzmxjqagdcHEkkEQc3QT+0a7jsiUyJoFqb18rRzPbTRz3p5f5pMt+fBN/tbQxnfY
 gKd6t/Mj+QNdLzLoBnE1r39sCfnDiklNPn3+eQskJ8fUaFsewNAWbhyjVVux6wK3OnQrrcooaNB Agj16aAcMuOgCnA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

After commit 4d1cd3b2c5c1 ("tools/testing/selftests/exec: fix link
error"), the load address alignment tests tried to build statically.
This was silently ignored in some cases. However, after attempting to
further fix the build by switching to "-static-pie", the test started
failing. This appears to be due to non-PT_INTERP ET_DYN execs ("static
PIE") not doing alignment correctly, which remains unfixed[1]. See commit
aeb7923733d1 ("revert "fs/binfmt_elf: use PT_LOAD p_align values for
static PIE"") for more details.

Provide rules to build both static and non-static PIE binaries, improve
debug reporting, and perform several test steps instead of a single
all-or-nothing test. However, do not actually enable static-pie tests;
alignment specification is only supported for ET_DYN with PT_INTERP
("regular PIE").

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215275 [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Chris Kennelly <ckennelly@google.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Fangrui Song <maskray@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/exec/Makefile       | 19 +++---
 tools/testing/selftests/exec/load_address.c | 67 +++++++++++++++++----
 2 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index fb4472ddffd8..619cff81d796 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -3,8 +3,13 @@ CFLAGS = -Wall
 CFLAGS += -Wno-nonnull
 CFLAGS += -D_GNU_SOURCE
 
+ALIGNS := 0x1000 0x200000 0x1000000
+ALIGN_PIES        := $(patsubst %,load_address.%,$(ALIGNS))
+ALIGN_STATIC_PIES := $(patsubst %,load_address.static.%,$(ALIGNS))
+ALIGNMENT_TESTS   := $(ALIGN_PIES)
+
 TEST_PROGS := binfmt_script.py
-TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216 non-regular
+TEST_GEN_PROGS := execveat non-regular $(ALIGNMENT_TESTS)
 TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir
 # Makefile is a run-time dependency, since it's accessed by the execveat test
 TEST_FILES := Makefile
@@ -28,9 +33,9 @@ $(OUTPUT)/execveat.symlink: $(OUTPUT)/execveat
 $(OUTPUT)/execveat.denatured: $(OUTPUT)/execveat
 	cp $< $@
 	chmod -x $@
-$(OUTPUT)/load_address_4096: load_address.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000 -pie -static $< -o $@
-$(OUTPUT)/load_address_2097152: load_address.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x200000 -pie -static $< -o $@
-$(OUTPUT)/load_address_16777216: load_address.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000000 -pie -static $< -o $@
+$(OUTPUT)/load_address.0x%: load_address.c
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=$(lastword $(subst ., ,$@)) \
+		-fPIE -pie $< -o $@
+$(OUTPUT)/load_address.static.0x%: load_address.c
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=$(lastword $(subst ., ,$@)) \
+		-fPIE -static-pie $< -o $@
diff --git a/tools/testing/selftests/exec/load_address.c b/tools/testing/selftests/exec/load_address.c
index 17e3207d34ae..8257fddba8c8 100644
--- a/tools/testing/selftests/exec/load_address.c
+++ b/tools/testing/selftests/exec/load_address.c
@@ -5,11 +5,13 @@
 #include <link.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include "../kselftest.h"
 
 struct Statistics {
 	unsigned long long load_address;
 	unsigned long long alignment;
+	bool interp;
 };
 
 int ExtractStatistics(struct dl_phdr_info *info, size_t size, void *data)
@@ -26,11 +28,20 @@ int ExtractStatistics(struct dl_phdr_info *info, size_t size, void *data)
 	stats->alignment = 0;
 
 	for (i = 0; i < info->dlpi_phnum; i++) {
+		unsigned long long align;
+
+		if (info->dlpi_phdr[i].p_type == PT_INTERP) {
+			stats->interp = true;
+			continue;
+		}
+
 		if (info->dlpi_phdr[i].p_type != PT_LOAD)
 			continue;
 
-		if (info->dlpi_phdr[i].p_align > stats->alignment)
-			stats->alignment = info->dlpi_phdr[i].p_align;
+		align = info->dlpi_phdr[i].p_align;
+
+		if (align > stats->alignment)
+			stats->alignment = align;
 	}
 
 	return 1;  // Terminate dl_iterate_phdr.
@@ -38,27 +49,57 @@ int ExtractStatistics(struct dl_phdr_info *info, size_t size, void *data)
 
 int main(int argc, char **argv)
 {
-	struct Statistics extracted;
-	unsigned long long misalign;
+	struct Statistics extracted = { };
+	unsigned long long misalign, pow2;
+	bool interp_needed;
+	char buf[1024];
+	FILE *maps;
 	int ret;
 
 	ksft_print_header();
-	ksft_set_plan(1);
+	ksft_set_plan(4);
+
+	/* Dump maps file for debugging reference. */
+	maps = fopen("/proc/self/maps", "r");
+	if (!maps)
+		ksft_exit_fail_msg("FAILED: /proc/self/maps: %s\n", strerror(errno));
+	while (fgets(buf, sizeof(buf), maps)) {
+		ksft_print_msg("%s", buf);
+	}
+	fclose(maps);
 
+	/* Walk the program headers. */
 	ret = dl_iterate_phdr(ExtractStatistics, &extracted);
 	if (ret != 1)
 		ksft_exit_fail_msg("FAILED: dl_iterate_phdr\n");
 
-	if (extracted.alignment == 0)
-		ksft_exit_fail_msg("FAILED: No alignment found\n");
-	else if (extracted.alignment & (extracted.alignment - 1))
-		ksft_exit_fail_msg("FAILED: Alignment is not a power of 2\n");
+	/* Report our findings. */
+	ksft_print_msg("load_address=%#llx alignment=%#llx\n",
+		       extracted.load_address, extracted.alignment);
+
+	/* If we're named with ".static." we expect no INTERP. */
+	interp_needed = strstr(argv[0], ".static.") == NULL;
+
+	/* Were we built as expected? */
+	ksft_test_result(interp_needed == extracted.interp,
+			 "%s INTERP program header %s\n",
+			 interp_needed ? "Wanted" : "Unwanted",
+			 extracted.interp ? "seen" : "missing");
+
+	/* Did we find an alignment? */
+	ksft_test_result(extracted.alignment != 0,
+			 "Alignment%s found\n", extracted.alignment ? "" : " NOT");
+
+	/* Is the alignment sane? */
+	pow2 = extracted.alignment & (extracted.alignment - 1);
+	ksft_test_result(pow2 == 0,
+			 "Alignment is%s a power of 2: %#llx\n",
+			 pow2 == 0 ? "" : " NOT", extracted.alignment);
 
+	/* Is the load address aligned? */
 	misalign = extracted.load_address & (extracted.alignment - 1);
-	if (misalign)
-		ksft_exit_fail_msg("FAILED: alignment = %llu, load_address = %llu\n",
-				   extracted.alignment, extracted.load_address);
+	ksft_test_result(misalign == 0, "Load Address is %saligned (%#llx)\n",
+			 misalign ? "MIS" : "", misalign);
 
-	ksft_test_result_pass("Completed\n");
 	ksft_finished();
 }
-- 
2.34.1



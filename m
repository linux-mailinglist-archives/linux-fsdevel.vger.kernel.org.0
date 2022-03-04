Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A004CCCA9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 05:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbiCDEtY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 23:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiCDEtW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 23:49:22 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8A94D255
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Mar 2022 20:48:34 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso9692140pjj.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Mar 2022 20:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ri9qeC8RR8CGain9Bg7eVi/1eh8/QDMjrM/3UAGQLAk=;
        b=PXtRY0hxgnrtqzjIHTTEN/Jfh2c8RhhBY5t9dwNrEBs6VOoLYBuikMk+TtXpTFp44A
         cuT71xzIifuVbTkzTdeeA8xvCYOYIjaJKVCWBfusmi/GVAvHgNl63+3fnNUmIPik6FOe
         uMYBwCV56ZxnJdRke+Mu/9M7mFfZju5GQLaKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ri9qeC8RR8CGain9Bg7eVi/1eh8/QDMjrM/3UAGQLAk=;
        b=yOaKI/+rAohagEf0TwIqrWgrjBLHptveXXC5ChnMhammbQGaxOmOOGN+OU4IIfSCLy
         MmVt8EkefiTunwyczjgqbP11gPED3Yb0aMP+EygL+6dMNgv8p7IbK6EMjBejhbdoWRHi
         ZaUKbu3SrOB1+ycoI+N3pnhjgt5XU7kMjrys3Ob9kXajG3LTGe4pP89wd61J3FT0zHE4
         8DMdBCT2a/G4pQbViDCTpvXihtxfSSagIdhY1K0lKuHrRNpBEC9N8flgqLdpHH+GQMrf
         Qby6ffCcvMXQZG/2Uu8vbjGvKmgg0jOu/gBk3asOYpVGuYJFsJbwrxIH9y8NzpLjUG+U
         yr3Q==
X-Gm-Message-State: AOAM5319gtBJGVpfOOPFVz3YW9yjLMl0kKmPejn3L7whHO0yaS+B9FLI
        tunwolBhL0WT3xBkEAScGofJrp6T1Ly1rA==
X-Google-Smtp-Source: ABdhPJyQNWTopy4B9gFA1y+6qGGV7b+LOm34nlwWaqK1F5w5NbaUAl8KnUoQ/BuXUoi0OIfOd70JcA==
X-Received: by 2002:a17:902:bc47:b0:151:ac43:eae0 with SMTP id t7-20020a170902bc4700b00151ac43eae0mr5525362plz.117.1646369314041;
        Thu, 03 Mar 2022 20:48:34 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e30-20020a056a0000de00b004ef299a4f89sm4399458pfj.180.2022.03.03.20.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 20:48:33 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Daniel Latypov <dlatypov@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?q?Magnus=20Gro=C3=9F?= <magnus.gross@rwth-aachen.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2] binfmt_elf: Introduce KUnit test
Date:   Thu,  3 Mar 2022 20:48:31 -0800
Message-Id: <20220304044831.962450-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6317; h=from:subject; bh=a4w0s4IZAhRLqjb5tB/XeGI0pZPXrfhf132TKT4W6sM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiIZoe6mzGMiS+V65tUEDI5benpoYIwRU5izGHNxNp trQdi96JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYiGaHgAKCRCJcvTf3G3AJswOD/ wJArtGLzdWsYsMObVWMpcm/KSKI6gij5EcZ0Sl/YMn4hB/wbunDSg4l3qUISZ6WBNg999FHe+aN19L kNL44u28ADAqX9UXGCwi1MSZ0ngJQm8XTG3QMoD6lE/Dg4ZQAw/YJYdydHX7xwpvxSJJb46JF63oOf auz58w+XMMJqfO3lUu2svzbgS7gAAeB98TXqzhDWJ5q/Yscm7oU6I7FXUFWixP4fo6anwZtUmh8NVS X77rvrn9nbnAPUB8wN9wbyGXMKCAD2tROg67MHhCmY7oYRA2O1p90gE1l3OL3xNRXdjU1q3I5mXl4H 0V+u/rHf17xNmTJLkhETgCnJBK//XBDnKbDz4jBSiKOvZI3wDpLxn47U2PNAtxgknDaMH50eCyyOVx tHWxouBVHHABaAIKbvr+dD2v/5zQneUShenswE5eclzBqKWuv0IRh5VS9GNlrN4BaJ6bYVnGGnXyNJ ugAxp/CEJSRwbnt/uVU5srLzjAPa8/jLjqKteWXzVvbXRTcdkbzcpdqVmAq+M/WoNRpFPnp5mzHdFH wk1l/Ixz3p0NVEuL6O/MD3tXA8xRprySCgbp5Ke8zeyVUTyYZGgq6pqJ+88zpxtUIerl0hoEybso6d gyEorJy2/nrp1A6ecczPU2crgQm+Xc0S+GKGbBqoQi8AS7Zd/Q+z6LI8jo0g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adds simple KUnit test for some binfmt_elf internals: specifically a
regression test for the problem fixed by commit 8904d9cd90ee ("ELF:
fix overflow in total mapping size calculation").

$ ./tools/testing/kunit/kunit.py run --arch x86_64 \
    --kconfig_add CONFIG_IA32_EMULATION=y '*binfmt_elf'
...
[19:41:08] ================== binfmt_elf (1 subtest) ==================
[19:41:08] [PASSED] total_mapping_size_test
[19:41:08] =================== [PASSED] binfmt_elf ====================
[19:41:08] ============== compat_binfmt_elf (1 subtest) ===============
[19:41:08] [PASSED] total_mapping_size_test
[19:41:08] ================ [PASSED] compat_binfmt_elf ================
[19:41:08] ============================================================
[19:41:08] Testing complete. Passed: 2, Failed: 0, Crashed: 0, Skipped: 0, Errors: 0

Cc: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This is now at the top of my for-next/execve tree
v1: https://lore.kernel.org/lkml/20220224054332.1852813-1-keescook@chromium.org
v2:
 - improve commit log
 - fix comment URL (Daniel)
 - drop redundant KUnit Kconfig help info (Daniel)
 - note in Kconfig help that COMPAT builds add a compat test (David)
---
 fs/Kconfig.binfmt      | 10 +++++++
 fs/binfmt_elf.c        |  4 +++
 fs/binfmt_elf_test.c   | 64 ++++++++++++++++++++++++++++++++++++++++++
 fs/compat_binfmt_elf.c |  2 ++
 4 files changed, 80 insertions(+)
 create mode 100644 fs/binfmt_elf_test.c

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 4d5ae61580aa..f7065e825b7f 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -28,6 +28,16 @@ config BINFMT_ELF
 	  ld.so (check the file <file:Documentation/Changes> for location and
 	  latest version).
 
+config BINFMT_ELF_KUNIT_TEST
+	bool "Build KUnit tests for ELF binary support" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y && BINFMT_ELF=y
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the ELF loader KUnit tests, which try to gather
+	  prior bug fixes into a regression test collection. This is really
+	  only needed for debugging. Note that with CONFIG_COMPAT=y, the
+	  compat_binfmt_elf KUnit test is also created.
+
 config COMPAT_BINFMT_ELF
 	def_bool y
 	depends on COMPAT && BINFMT_ELF
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 4c5a2175f605..eaf39b1bdbbb 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2346,3 +2346,7 @@ static void __exit exit_elf_binfmt(void)
 core_initcall(init_elf_binfmt);
 module_exit(exit_elf_binfmt);
 MODULE_LICENSE("GPL");
+
+#ifdef CONFIG_BINFMT_ELF_KUNIT_TEST
+#include "binfmt_elf_test.c"
+#endif
diff --git a/fs/binfmt_elf_test.c b/fs/binfmt_elf_test.c
new file mode 100644
index 000000000000..11d734fec366
--- /dev/null
+++ b/fs/binfmt_elf_test.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <kunit/test.h>
+
+static void total_mapping_size_test(struct kunit *test)
+{
+	struct elf_phdr empty[] = {
+		{ .p_type = PT_LOAD, .p_vaddr = 0, .p_memsz = 0, },
+		{ .p_type = PT_INTERP, .p_vaddr = 10, .p_memsz = 999999, },
+	};
+	/*
+	 * readelf -lW /bin/mount | grep '^  .*0x0' | awk '{print "\t\t{ .p_type = PT_" \
+	 *				$1 ", .p_vaddr = " $3 ", .p_memsz = " $6 ", },"}'
+	 */
+	struct elf_phdr mount[] = {
+		{ .p_type = PT_PHDR, .p_vaddr = 0x00000040, .p_memsz = 0x0002d8, },
+		{ .p_type = PT_INTERP, .p_vaddr = 0x00000318, .p_memsz = 0x00001c, },
+		{ .p_type = PT_LOAD, .p_vaddr = 0x00000000, .p_memsz = 0x0033a8, },
+		{ .p_type = PT_LOAD, .p_vaddr = 0x00004000, .p_memsz = 0x005c91, },
+		{ .p_type = PT_LOAD, .p_vaddr = 0x0000a000, .p_memsz = 0x0022f8, },
+		{ .p_type = PT_LOAD, .p_vaddr = 0x0000d330, .p_memsz = 0x000d40, },
+		{ .p_type = PT_DYNAMIC, .p_vaddr = 0x0000d928, .p_memsz = 0x000200, },
+		{ .p_type = PT_NOTE, .p_vaddr = 0x00000338, .p_memsz = 0x000030, },
+		{ .p_type = PT_NOTE, .p_vaddr = 0x00000368, .p_memsz = 0x000044, },
+		{ .p_type = PT_GNU_PROPERTY, .p_vaddr = 0x00000338, .p_memsz = 0x000030, },
+		{ .p_type = PT_GNU_EH_FRAME, .p_vaddr = 0x0000b490, .p_memsz = 0x0001ec, },
+		{ .p_type = PT_GNU_STACK, .p_vaddr = 0x00000000, .p_memsz = 0x000000, },
+		{ .p_type = PT_GNU_RELRO, .p_vaddr = 0x0000d330, .p_memsz = 0x000cd0, },
+	};
+	size_t mount_size = 0xE070;
+	/* https://lore.kernel.org/linux-fsdevel/YfF18Dy85mCntXrx@fractal.localdomain */
+	struct elf_phdr unordered[] = {
+		{ .p_type = PT_LOAD, .p_vaddr = 0x00000000, .p_memsz = 0x0033a8, },
+		{ .p_type = PT_LOAD, .p_vaddr = 0x0000d330, .p_memsz = 0x000d40, },
+		{ .p_type = PT_LOAD, .p_vaddr = 0x00004000, .p_memsz = 0x005c91, },
+		{ .p_type = PT_LOAD, .p_vaddr = 0x0000a000, .p_memsz = 0x0022f8, },
+	};
+
+	/* No headers, no size. */
+	KUNIT_EXPECT_EQ(test, total_mapping_size(NULL, 0), 0);
+	KUNIT_EXPECT_EQ(test, total_mapping_size(empty, 0), 0);
+	/* Empty headers, no size. */
+	KUNIT_EXPECT_EQ(test, total_mapping_size(empty, 1), 0);
+	/* No PT_LOAD headers, no size. */
+	KUNIT_EXPECT_EQ(test, total_mapping_size(&empty[1], 1), 0);
+	/* Empty PT_LOAD and non-PT_LOAD headers, no size. */
+	KUNIT_EXPECT_EQ(test, total_mapping_size(empty, 2), 0);
+
+	/* Normal set of PT_LOADS, and expected size. */
+	KUNIT_EXPECT_EQ(test, total_mapping_size(mount, ARRAY_SIZE(mount)), mount_size);
+	/* Unordered PT_LOADs result in same size. */
+	KUNIT_EXPECT_EQ(test, total_mapping_size(unordered, ARRAY_SIZE(unordered)), mount_size);
+}
+
+static struct kunit_case binfmt_elf_test_cases[] = {
+	KUNIT_CASE(total_mapping_size_test),
+	{},
+};
+
+static struct kunit_suite binfmt_elf_test_suite = {
+	.name = KBUILD_MODNAME,
+	.test_cases = binfmt_elf_test_cases,
+};
+
+kunit_test_suite(binfmt_elf_test_suite);
diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index 95e72d271b95..8f0af4f62631 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -135,6 +135,8 @@
 #define elf_format		compat_elf_format
 #define init_elf_binfmt		init_compat_elf_binfmt
 #define exit_elf_binfmt		exit_compat_elf_binfmt
+#define binfmt_elf_test_cases	compat_binfmt_elf_test_cases
+#define binfmt_elf_test_suite	compat_binfmt_elf_test_suite
 
 /*
  * We share all the actual code with the native (64-bit) version.
-- 
2.32.0


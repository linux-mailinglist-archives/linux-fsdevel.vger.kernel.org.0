Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951CB4C23B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 06:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiBXFoH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 00:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiBXFoH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 00:44:07 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FF6136EE8
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 21:43:37 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gb21so1057293pjb.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 21:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8OUhXa3gN3jKPfYHmyLPJirwnZOTLizffe7c+ejkQKg=;
        b=aEE/qtufOBv0isusSaD8SMvPgvKdArha1kY9OewfscqDpJGKqIiVdt7imXgRl4aBC+
         8d0mirSFwNQ8ORGF2ZpEZQ091IiiH8GYiKXEvLVIFZqsaEkWcz0WBm4iDHOQC7k+kG+8
         SjajbIzMiVVzEBfq/XnEyYpedrG7eG/c3gst8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8OUhXa3gN3jKPfYHmyLPJirwnZOTLizffe7c+ejkQKg=;
        b=c7enIwjLo2Nwcvp2wzR1mZiKDSfPkVPfvWurENbeUfNkmtOocZKzpErTmqIyewCFPZ
         npkrB8cTVea8WNc4AaQNW2h2Fqyd/589oZ4uLU3r6oa9aKPQDgyK2CbyBFxUYs++kEhT
         YXCg6MEKQ98gYNy/Riv6q2mD/2Im2m9tv+lesRzSZFwzKN9raSLwiwkRgRk0yK/S9BSa
         3NQpGAzn/eMSRUUQDBssrf6+8iIVvfG6O+i78tGgytUujPUvBhhBoMGn3vy6hRs7+lTu
         EVv+taCDT95UIOd/OotQyWSN2gQIeM03ySm88RxwtVI+j06vuAMBv0c6rvoxl+HST7NU
         icDg==
X-Gm-Message-State: AOAM531zcFWN8rUysFCh/S+Zn7K6iHuFxaHuuVDt4qynithOafAjSH96
        a89XGU8ipfeC+qmMvRNZPQvzvA==
X-Google-Smtp-Source: ABdhPJx1N8wi4XRoqu74YRSQGERxx1hqxpPNJEoLAyM+CnBC+TeroAyN8iGyHBtJS0bkXEFtVXavRg==
X-Received: by 2002:a17:902:aa8a:b0:14f:460d:bf2e with SMTP id d10-20020a170902aa8a00b0014f460dbf2emr1056110plr.144.1645681417049;
        Wed, 23 Feb 2022 21:43:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x14sm1196061pgc.60.2022.02.23.21.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 21:43:36 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>, David Gow <davidgow@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?q?Magnus=20Gro=C3=9F?= <magnus.gross@rwth-aachen.de>,
        kunit-dev@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] binfmt_elf: Introduce KUnit test
Date:   Wed, 23 Feb 2022 21:43:32 -0800
Message-Id: <20220224054332.1852813-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5866; h=from:subject; bh=FRXKK5AYWSBmpPuYpDvqw2/TqIlXTauPBKsuJ6qHMW8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiFxsDRnzYzwVjs3Br0bkTjbBDYrU8HMqGQemoWVyd tK7jF4mJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhcbAwAKCRCJcvTf3G3AJi8AD/ 44cs81v9Turyz+NeH4WqinDkGVPDQu9S0uIuOi8GniiSyXuF8KOI15roR8g7URTuDsQWEsrIeT7PiI PVt1/XOUcRovbl4BMWKA6vri4JwESBbgjRm6DNdZtncomSMBMw7cH+YLjLhPUHMW5ACH0ll/hVO1t7 LZo+kQBkcsExsKfVkTZzZozXLNCHrkQ0haN1GWKWWDAy7Y0t8ovviINJy9GZPwDqGvN6xYfFcB2hr7 lkLJlWae10aVyZIXXgsymQF+j4VUirIu3jBr5JDlj12GTh6LNRZBusEyojxzNaLGNRob4UxJil6QwX Oz2puniFjqRmkG2yyB+nouMuf/msHjFqkuJfB6zYJvgweic+sv+PdE9Jbhuqc4XLPqAg+ue6l3ASul G3paTm5QF1YRWOp0GfX6ML5aE+kYs+ClU6EOU8WsTNnTKFoP4agl2p0MtEpLAsL1bt4JV8G0K0tPbb 5BCGHNHdljAb0YyzQz6Z14nu3WUfyAU6uzzEWXrudZ04Nn4x/nJM872fqRYDeJ8sB5yKdVMfy9Cwo3 2hvBNkqHHptoNjs3Dgu1dFTxIfakbvs+VXvXwby3PC8I7+LsbArLBlEgSqDoqh6436oGCY5ffG6n68 WkjblT+rEzu7tRcSyNBOiLp8HTYkBICu2UGmJLGzGfi6xUs/coE02Kr1pjYQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: David Gow <davidgow@google.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: "Magnus Groß" <magnus.gross@rwth-aachen.de>
Cc: kunit-dev@googlegroups.com
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
I'm exploring ways to mock copy_to_user() for more tests in here.
kprobes doesn't seem to let me easily hijack a function...
---
 fs/Kconfig.binfmt      | 17 +++++++++++
 fs/binfmt_elf.c        |  4 +++
 fs/binfmt_elf_test.c   | 64 ++++++++++++++++++++++++++++++++++++++++++
 fs/compat_binfmt_elf.c |  2 ++
 4 files changed, 87 insertions(+)
 create mode 100644 fs/binfmt_elf_test.c

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 4d5ae61580aa..8e14589ee9cc 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -28,6 +28,23 @@ config BINFMT_ELF
 	  ld.so (check the file <file:Documentation/Changes> for location and
 	  latest version).
 
+config BINFMT_ELF_KUNIT_TEST
+	bool "Build KUnit tests for ELF binary support" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y && BINFMT_ELF=y
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the ELF loader KUnit tests.
+
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (https://testanything.org/). Only useful for kernel devs
+	  running KUnit test harness and are not for inclusion into a
+	  production build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config COMPAT_BINFMT_ELF
 	def_bool y
 	depends on COMPAT && BINFMT_ELF
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 76ff2af15ba5..9bea703ed1c2 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2335,3 +2335,7 @@ static void __exit exit_elf_binfmt(void)
 core_initcall(init_elf_binfmt);
 module_exit(exit_elf_binfmt);
 MODULE_LICENSE("GPL");
+
+#ifdef CONFIG_BINFMT_ELF_KUNIT_TEST
+#include "binfmt_elf_test.c"
+#endif
diff --git a/fs/binfmt_elf_test.c b/fs/binfmt_elf_test.c
new file mode 100644
index 000000000000..486ad419f763
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
+	/* https://lore.kernel.org/lkml/YfF18Dy85mCntXrx@fractal.localdomain */
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
2.30.2


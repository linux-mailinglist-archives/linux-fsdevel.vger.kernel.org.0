Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52B958AD38
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 17:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241189AbiHEPns (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 11:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241092AbiHEPnb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:43:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FA465563;
        Fri,  5 Aug 2022 08:43:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80259B82989;
        Fri,  5 Aug 2022 15:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4590C433D6;
        Fri,  5 Aug 2022 15:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659714192;
        bh=TqMR/tIQcRK94+z9eetCsW+BK+LLUVa7DCQEAcBAA+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=isBRsQSym0LR/4yoqjnucVewW+BloK7+Tm6Ql6gD/IKbM8Pk8XUuq6muzruHqjqki
         nYdZtgYFTqXvQMmQNJzOuqsp2sQMdBsaFlCvSsoNMIeYAuicR3ZK0oF625SqHsDfPC
         49nPgg4c0kXp9kCL3Kv2gLc+fdO1BN9HT7ubaT4USCYGfeKp1xn+tO1av1AfVrok7Q
         FLBY9YlIrgDlKH1Uf+xGJF5sNi/TEGeaSFyc7B5Z6WSNOgaHoytHvOaAESTz5SWo5m
         ES3QDANw4f/yum2g+cDrgpg2N23Jywp7VA2XLcAXbqX6lRFfomLrG3g71QkgKorSo3
         XGnIgrmcTd06w==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        live-patching@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH v9 05/27] kallsyms: increase maximum kernel symbol length to 512
Date:   Fri,  5 Aug 2022 17:41:50 +0200
Message-Id: <20220805154231.31257-6-ojeda@kernel.org>
In-Reply-To: <20220805154231.31257-1-ojeda@kernel.org>
References: <20220805154231.31257-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rust symbols can become quite long due to namespacing introduced
by modules, types, traits, generics, etc. For instance,
the following code:

    pub mod my_module {
        pub struct MyType;
        pub struct MyGenericType<T>(T);

        pub trait MyTrait {
            fn my_method() -> u32;
        }

        impl MyTrait for MyGenericType<MyType> {
            fn my_method() -> u32 {
                42
            }
        }
    }

generates a symbol of length 96 when using the upcoming v0 mangling scheme:

    _RNvXNtCshGpAVYOtgW1_7example9my_moduleINtB2_13MyGenericTypeNtB2_6MyTypeENtB2_7MyTrait9my_method

At the moment, Rust symbols may reach up to 300 in length.
Setting 512 as the maximum seems like a reasonable choice to
keep some headroom.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 include/linux/kallsyms.h            | 2 +-
 kernel/livepatch/core.c             | 4 ++--
 scripts/kallsyms.c                  | 4 ++--
 tools/include/linux/kallsyms.h      | 2 +-
 tools/lib/perf/include/perf/event.h | 2 +-
 tools/lib/symbol/kallsyms.h         | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index ad39636e0c3f..649faac31ddb 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -15,7 +15,7 @@
 
 #include <asm/sections.h>
 
-#define KSYM_NAME_LEN 128
+#define KSYM_NAME_LEN 512
 #define KSYM_SYMBOL_LEN (sizeof("%s+%#lx/%#lx [%s %s]") + \
 			(KSYM_NAME_LEN - 1) + \
 			2*(BITS_PER_LONG*3/10) + (MODULE_NAME_LEN - 1) + \
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index bc475e62279d..ec06ce59d728 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -213,7 +213,7 @@ static int klp_resolve_symbols(Elf_Shdr *sechdrs, const char *strtab,
 	 * we use the smallest/strictest upper bound possible (56, based on
 	 * the current definition of MODULE_NAME_LEN) to prevent overflows.
 	 */
-	BUILD_BUG_ON(MODULE_NAME_LEN < 56 || KSYM_NAME_LEN != 128);
+	BUILD_BUG_ON(MODULE_NAME_LEN < 56 || KSYM_NAME_LEN != 512);
 
 	relas = (Elf_Rela *) relasec->sh_addr;
 	/* For each rela in this klp relocation section */
@@ -227,7 +227,7 @@ static int klp_resolve_symbols(Elf_Shdr *sechdrs, const char *strtab,
 
 		/* Format: .klp.sym.sym_objname.sym_name,sympos */
 		cnt = sscanf(strtab + sym->st_name,
-			     ".klp.sym.%55[^.].%127[^,],%lu",
+			     ".klp.sym.%55[^.].%511[^,],%lu",
 			     sym_objname, sym_name, &sympos);
 		if (cnt != 3) {
 			pr_err("symbol %s has an incorrectly formatted name\n",
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 9da3b7767e9d..3b64dda7e4cc 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -30,10 +30,10 @@
 #define _stringify_1(x)	#x
 #define _stringify(x)	_stringify_1(x)
 
-#define KSYM_NAME_LEN		128
+#define KSYM_NAME_LEN		512
 
 /* A substantially bigger size than the current maximum. */
-#define KSYM_NAME_LEN_BUFFER	512
+#define KSYM_NAME_LEN_BUFFER	2048
 _Static_assert(
 	KSYM_NAME_LEN_BUFFER == KSYM_NAME_LEN * 4,
 	"Please keep KSYM_NAME_LEN_BUFFER in sync with KSYM_NAME_LEN"
diff --git a/tools/include/linux/kallsyms.h b/tools/include/linux/kallsyms.h
index efb6c3f5f2a9..5a37ccbec54f 100644
--- a/tools/include/linux/kallsyms.h
+++ b/tools/include/linux/kallsyms.h
@@ -6,7 +6,7 @@
 #include <stdio.h>
 #include <unistd.h>
 
-#define KSYM_NAME_LEN 128
+#define KSYM_NAME_LEN 512
 
 struct module;
 
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index e7758707cadd..116a80c31675 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -95,7 +95,7 @@ struct perf_record_throttle {
 };
 
 #ifndef KSYM_NAME_LEN
-#define KSYM_NAME_LEN 256
+#define KSYM_NAME_LEN 512
 #endif
 
 struct perf_record_ksymbol {
diff --git a/tools/lib/symbol/kallsyms.h b/tools/lib/symbol/kallsyms.h
index 72ab9870454b..542f9b059c3b 100644
--- a/tools/lib/symbol/kallsyms.h
+++ b/tools/lib/symbol/kallsyms.h
@@ -7,7 +7,7 @@
 #include <linux/types.h>
 
 #ifndef KSYM_NAME_LEN
-#define KSYM_NAME_LEN 256
+#define KSYM_NAME_LEN 512
 #endif
 
 static inline u8 kallsyms2elf_binding(char type)
-- 
2.37.1


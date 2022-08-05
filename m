Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6942C58AD4E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 17:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbiHEPqG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 11:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241244AbiHEPo3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:44:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81C651A1C;
        Fri,  5 Aug 2022 08:44:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98555B82986;
        Fri,  5 Aug 2022 15:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C69C43470;
        Fri,  5 Aug 2022 15:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659714238;
        bh=LJMbIbsmGPh8jLekYZBgD3WYeoa1VFA5q4dxEXu4mdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PKp/4Vv0TnHtJlfe+/ahygOjq18Jn5dHvo9ossvP42owNhBfsYn0CTcEWgJTXOlJm
         Vh3R1XXKxCeODfbBShRuyUGaH1hIZTgLUndM488qsYF0qz5/Th1uWck4dyCCo0jfey
         dTZHmlmiiE0kdfHg0FwaSbpteeBAvQawqKiC0eR57OiE7R95wwoZQ+w9kwfTEbTQAT
         8kDIDVEVzKMEEd5DWPEfBPPmDbrWBOEjQaEYVUr/cQaOZdQ6l7cWg4oPCQFBm0jvd3
         UVlbxQbYshIE5QxG5wTgZJKN0IRwoJJY2lVZ+JvGI5mPmrKbFvNMTuX4SxihvteUBE
         cRaMGDshcJB+w==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v9 14/27] vsprintf: add new `%pA` format specifier
Date:   Fri,  5 Aug 2022 17:41:59 +0200
Message-Id: <20220805154231.31257-15-ojeda@kernel.org>
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

From: Gary Guo <gary@garyguo.net>

This patch adds a format specifier `%pA` to `vsprintf` which formats
a pointer as `core::fmt::Arguments`. Doing so allows us to directly
format to the internal buffer of `printf`, so we do not have to use
a temporary buffer on the stack to pre-assemble the message on
the Rust side.

This specifier is intended only to be used from Rust and not for C, so
`checkpatch.pl` is intentionally unchanged to catch any misuse.

Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Petr Mladek <pmladek@suse.com>
Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/core-api/printk-formats.rst | 10 ++++++++++
 lib/vsprintf.c                            | 13 +++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 5e89497ba314..dbe1aacc79d0 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -625,6 +625,16 @@ Examples::
 	%p4cc	Y10  little-endian (0x20303159)
 	%p4cc	NV12 big-endian (0xb231564e)
 
+Rust
+----
+
+::
+
+	%pA
+
+Only intended to be used from Rust code to format ``core::fmt::Arguments``.
+Do *not* use it from C.
+
 Thanks
 ======
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3c1853a9d1c0..c414a8d9f1ea 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2246,6 +2246,9 @@ int __init no_hash_pointers_enable(char *str)
 }
 early_param("no_hash_pointers", no_hash_pointers_enable);
 
+/* Used for Rust formatting ('%pA'). */
+char *rust_fmt_argument(char *buf, char *end, void *ptr);
+
 /*
  * Show a '%p' thing.  A kernel extension is that the '%p' is followed
  * by an extra set of alphanumeric characters that are extended format
@@ -2372,6 +2375,10 @@ early_param("no_hash_pointers", no_hash_pointers_enable);
  *
  * Note: The default behaviour (unadorned %p) is to hash the address,
  * rendering it useful as a unique identifier.
+ *
+ * There is also a '%pA' format specifier, but it is only intended to be used
+ * from Rust code to format core::fmt::Arguments. Do *not* use it from C.
+ * See rust/kernel/print.rs for details.
  */
 static noinline_for_stack
 char *pointer(const char *fmt, char *buf, char *end, void *ptr,
@@ -2444,6 +2451,12 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		return device_node_string(buf, end, ptr, spec, fmt + 1);
 	case 'f':
 		return fwnode_string(buf, end, ptr, spec, fmt + 1);
+	case 'A':
+		if (!IS_ENABLED(CONFIG_RUST)) {
+			WARN_ONCE(1, "Please remove %%pA from non-Rust code\n");
+			return error_string(buf, end, "(%pA?)", spec);
+		}
+		return rust_fmt_argument(buf, end, ptr);
 	case 'x':
 		return pointer_string(buf, end, ptr, spec);
 	case 'e':
-- 
2.37.1


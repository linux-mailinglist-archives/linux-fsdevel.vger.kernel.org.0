Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FDF5EC41E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 15:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbiI0NSy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 09:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbiI0NRe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:17:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291554C625;
        Tue, 27 Sep 2022 06:16:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1531761993;
        Tue, 27 Sep 2022 13:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DB5C433D7;
        Tue, 27 Sep 2022 13:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664284597;
        bh=t3smOdRq+XT8m4K4GWvohI+ERBcCmJn+60CQCo5i0Ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h8HFzwU6ejkfzP1Jn5at275E9elC8aqiZJ3irxJjmNgVZNzg0Tm4H3Nfp2ADa9LwL
         pDdLnwTp8QfX+pNBIZC2Q+MmMe0ISDuCjj04lO3hZavvfB5o58D7Ae+X7e53eyaSeb
         IkzXWV/Hy2hdErnTnKrLgB1AOncDI0roPd6ofGaI76m+6c5lwjww7y1z7Ca2Yz3QZW
         1RSxEojd09zQbzT42+9WawV7JAxK1enZO9hRow60to4MrU3aQQmR68kx+f7Y77gydb
         Gk2xD+7zb6UjNqd8tSnbu3R/eJ3KdwmxH9bX1ZtzUEa8xZX8zSVnKdyjpxTThBJzRH
         L8YohTFoCfsjg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Gary Guo <gary@garyguo.net>, Matthew Bakhtiari <dev@mtbk.me>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v10 10/27] rust: add `macros` crate
Date:   Tue, 27 Sep 2022 15:14:41 +0200
Message-Id: <20220927131518.30000-11-ojeda@kernel.org>
In-Reply-To: <20220927131518.30000-1-ojeda@kernel.org>
References: <20220927131518.30000-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This crate contains all the procedural macros ("proc macros")
shared by all the kernel.

Procedural macros allow to create syntax extensions. They run at
compile-time and can consume as well as produce Rust syntax.

For instance, the `module!` macro that is used by Rust modules
is implemented here. It allows to easily declare the equivalent
information to the `MODULE_*` macros in C modules, e.g.:

    module! {
        type: RustMinimal,
        name: b"rust_minimal",
        author: b"Rust for Linux Contributors",
        description: b"Rust minimal sample",
        license: b"GPL",
    }

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Finn Behrens <me@kloenk.de>
Signed-off-by: Finn Behrens <me@kloenk.de>
Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Matthew Bakhtiari <dev@mtbk.me>
Signed-off-by: Matthew Bakhtiari <dev@mtbk.me>
Co-developed-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
Signed-off-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/macros/helpers.rs |  51 ++++++++
 rust/macros/lib.rs     |  72 +++++++++++
 rust/macros/module.rs  | 282 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 405 insertions(+)
 create mode 100644 rust/macros/helpers.rs
 create mode 100644 rust/macros/lib.rs
 create mode 100644 rust/macros/module.rs

diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
new file mode 100644
index 000000000000..cdc7dc6135d2
--- /dev/null
+++ b/rust/macros/helpers.rs
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use proc_macro::{token_stream, TokenTree};
+
+pub(crate) fn try_ident(it: &mut token_stream::IntoIter) -> Option<String> {
+    if let Some(TokenTree::Ident(ident)) = it.next() {
+        Some(ident.to_string())
+    } else {
+        None
+    }
+}
+
+pub(crate) fn try_literal(it: &mut token_stream::IntoIter) -> Option<String> {
+    if let Some(TokenTree::Literal(literal)) = it.next() {
+        Some(literal.to_string())
+    } else {
+        None
+    }
+}
+
+pub(crate) fn try_byte_string(it: &mut token_stream::IntoIter) -> Option<String> {
+    try_literal(it).and_then(|byte_string| {
+        if byte_string.starts_with("b\"") && byte_string.ends_with('\"') {
+            Some(byte_string[2..byte_string.len() - 1].to_string())
+        } else {
+            None
+        }
+    })
+}
+
+pub(crate) fn expect_ident(it: &mut token_stream::IntoIter) -> String {
+    try_ident(it).expect("Expected Ident")
+}
+
+pub(crate) fn expect_punct(it: &mut token_stream::IntoIter) -> char {
+    if let TokenTree::Punct(punct) = it.next().expect("Reached end of token stream for Punct") {
+        punct.as_char()
+    } else {
+        panic!("Expected Punct");
+    }
+}
+
+pub(crate) fn expect_byte_string(it: &mut token_stream::IntoIter) -> String {
+    try_byte_string(it).expect("Expected byte string")
+}
+
+pub(crate) fn expect_end(it: &mut token_stream::IntoIter) {
+    if it.next().is_some() {
+        panic!("Expected end");
+    }
+}
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
new file mode 100644
index 000000000000..91764bfb1f89
--- /dev/null
+++ b/rust/macros/lib.rs
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Crate for all kernel procedural macros.
+
+mod helpers;
+mod module;
+
+use proc_macro::TokenStream;
+
+/// Declares a kernel module.
+///
+/// The `type` argument should be a type which implements the [`Module`]
+/// trait. Also accepts various forms of kernel metadata.
+///
+/// C header: [`include/linux/moduleparam.h`](../../../include/linux/moduleparam.h)
+///
+/// [`Module`]: ../kernel/trait.Module.html
+///
+/// # Examples
+///
+/// ```ignore
+/// use kernel::prelude::*;
+///
+/// module!{
+///     type: MyModule,
+///     name: b"my_kernel_module",
+///     author: b"Rust for Linux Contributors",
+///     description: b"My very own kernel module!",
+///     license: b"GPL",
+///     params: {
+///        my_i32: i32 {
+///            default: 42,
+///            permissions: 0o000,
+///            description: b"Example of i32",
+///        },
+///        writeable_i32: i32 {
+///            default: 42,
+///            permissions: 0o644,
+///            description: b"Example of i32",
+///        },
+///    },
+/// }
+///
+/// struct MyModule;
+///
+/// impl kernel::Module for MyModule {
+///     fn init() -> Result<Self> {
+///         // If the parameter is writeable, then the kparam lock must be
+///         // taken to read the parameter:
+///         {
+///             let lock = THIS_MODULE.kernel_param_lock();
+///             pr_info!("i32 param is:  {}\n", writeable_i32.read(&lock));
+///         }
+///         // If the parameter is read only, it can be read without locking
+///         // the kernel parameters:
+///         pr_info!("i32 param is:  {}\n", my_i32.read());
+///         Ok(Self)
+///     }
+/// }
+/// ```
+///
+/// # Supported argument types
+///   - `type`: type which implements the [`Module`] trait (required).
+///   - `name`: byte array of the name of the kernel module (required).
+///   - `author`: byte array of the author of the kernel module.
+///   - `description`: byte array of the description of the kernel module.
+///   - `license`: byte array of the license of the kernel module (required).
+///   - `alias`: byte array of alias name of the kernel module.
+#[proc_macro]
+pub fn module(ts: TokenStream) -> TokenStream {
+    module::module(ts)
+}
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
new file mode 100644
index 000000000000..186a5b8be23c
--- /dev/null
+++ b/rust/macros/module.rs
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use crate::helpers::*;
+use proc_macro::{token_stream, Literal, TokenStream, TokenTree};
+use std::fmt::Write;
+
+struct ModInfoBuilder<'a> {
+    module: &'a str,
+    counter: usize,
+    buffer: String,
+}
+
+impl<'a> ModInfoBuilder<'a> {
+    fn new(module: &'a str) -> Self {
+        ModInfoBuilder {
+            module,
+            counter: 0,
+            buffer: String::new(),
+        }
+    }
+
+    fn emit_base(&mut self, field: &str, content: &str, builtin: bool) {
+        let string = if builtin {
+            // Built-in modules prefix their modinfo strings by `module.`.
+            format!(
+                "{module}.{field}={content}\0",
+                module = self.module,
+                field = field,
+                content = content
+            )
+        } else {
+            // Loadable modules' modinfo strings go as-is.
+            format!("{field}={content}\0", field = field, content = content)
+        };
+
+        write!(
+            &mut self.buffer,
+            "
+                {cfg}
+                #[doc(hidden)]
+                #[link_section = \".modinfo\"]
+                #[used]
+                pub static __{module}_{counter}: [u8; {length}] = *{string};
+            ",
+            cfg = if builtin {
+                "#[cfg(not(MODULE))]"
+            } else {
+                "#[cfg(MODULE)]"
+            },
+            module = self.module.to_uppercase(),
+            counter = self.counter,
+            length = string.len(),
+            string = Literal::byte_string(string.as_bytes()),
+        )
+        .unwrap();
+
+        self.counter += 1;
+    }
+
+    fn emit_only_builtin(&mut self, field: &str, content: &str) {
+        self.emit_base(field, content, true)
+    }
+
+    fn emit_only_loadable(&mut self, field: &str, content: &str) {
+        self.emit_base(field, content, false)
+    }
+
+    fn emit(&mut self, field: &str, content: &str) {
+        self.emit_only_builtin(field, content);
+        self.emit_only_loadable(field, content);
+    }
+}
+
+#[derive(Debug, Default)]
+struct ModuleInfo {
+    type_: String,
+    license: String,
+    name: String,
+    author: Option<String>,
+    description: Option<String>,
+    alias: Option<String>,
+}
+
+impl ModuleInfo {
+    fn parse(it: &mut token_stream::IntoIter) -> Self {
+        let mut info = ModuleInfo::default();
+
+        const EXPECTED_KEYS: &[&str] =
+            &["type", "name", "author", "description", "license", "alias"];
+        const REQUIRED_KEYS: &[&str] = &["type", "name", "license"];
+        let mut seen_keys = Vec::new();
+
+        loop {
+            let key = match it.next() {
+                Some(TokenTree::Ident(ident)) => ident.to_string(),
+                Some(_) => panic!("Expected Ident or end"),
+                None => break,
+            };
+
+            if seen_keys.contains(&key) {
+                panic!(
+                    "Duplicated key \"{}\". Keys can only be specified once.",
+                    key
+                );
+            }
+
+            assert_eq!(expect_punct(it), ':');
+
+            match key.as_str() {
+                "type" => info.type_ = expect_ident(it),
+                "name" => info.name = expect_byte_string(it),
+                "author" => info.author = Some(expect_byte_string(it)),
+                "description" => info.description = Some(expect_byte_string(it)),
+                "license" => info.license = expect_byte_string(it),
+                "alias" => info.alias = Some(expect_byte_string(it)),
+                _ => panic!(
+                    "Unknown key \"{}\". Valid keys are: {:?}.",
+                    key, EXPECTED_KEYS
+                ),
+            }
+
+            assert_eq!(expect_punct(it), ',');
+
+            seen_keys.push(key);
+        }
+
+        expect_end(it);
+
+        for key in REQUIRED_KEYS {
+            if !seen_keys.iter().any(|e| e == key) {
+                panic!("Missing required key \"{}\".", key);
+            }
+        }
+
+        let mut ordered_keys: Vec<&str> = Vec::new();
+        for key in EXPECTED_KEYS {
+            if seen_keys.iter().any(|e| e == key) {
+                ordered_keys.push(key);
+            }
+        }
+
+        if seen_keys != ordered_keys {
+            panic!(
+                "Keys are not ordered as expected. Order them like: {:?}.",
+                ordered_keys
+            );
+        }
+
+        info
+    }
+}
+
+pub(crate) fn module(ts: TokenStream) -> TokenStream {
+    let mut it = ts.into_iter();
+
+    let info = ModuleInfo::parse(&mut it);
+
+    let mut modinfo = ModInfoBuilder::new(info.name.as_ref());
+    if let Some(author) = info.author {
+        modinfo.emit("author", &author);
+    }
+    if let Some(description) = info.description {
+        modinfo.emit("description", &description);
+    }
+    modinfo.emit("license", &info.license);
+    if let Some(alias) = info.alias {
+        modinfo.emit("alias", &alias);
+    }
+
+    // Built-in modules also export the `file` modinfo string.
+    let file =
+        std::env::var("RUST_MODFILE").expect("Unable to fetch RUST_MODFILE environmental variable");
+    modinfo.emit_only_builtin("file", &file);
+
+    format!(
+        "
+            /// The module name.
+            ///
+            /// Used by the printing macros, e.g. [`info!`].
+            const __LOG_PREFIX: &[u8] = b\"{name}\\0\";
+
+            /// The \"Rust loadable module\" mark, for `scripts/is_rust_module.sh`.
+            //
+            // This may be best done another way later on, e.g. as a new modinfo
+            // key or a new section. For the moment, keep it simple.
+            #[cfg(MODULE)]
+            #[doc(hidden)]
+            #[used]
+            static __IS_RUST_MODULE: () = ();
+
+            static mut __MOD: Option<{type_}> = None;
+
+            // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
+            // freed until the module is unloaded.
+            #[cfg(MODULE)]
+            static THIS_MODULE: kernel::ThisModule = unsafe {{
+                kernel::ThisModule::from_ptr(&kernel::bindings::__this_module as *const _ as *mut _)
+            }};
+            #[cfg(not(MODULE))]
+            static THIS_MODULE: kernel::ThisModule = unsafe {{
+                kernel::ThisModule::from_ptr(core::ptr::null_mut())
+            }};
+
+            // Loadable modules need to export the `{{init,cleanup}}_module` identifiers.
+            #[cfg(MODULE)]
+            #[doc(hidden)]
+            #[no_mangle]
+            pub extern \"C\" fn init_module() -> core::ffi::c_int {{
+                __init()
+            }}
+
+            #[cfg(MODULE)]
+            #[doc(hidden)]
+            #[no_mangle]
+            pub extern \"C\" fn cleanup_module() {{
+                __exit()
+            }}
+
+            // Built-in modules are initialized through an initcall pointer
+            // and the identifiers need to be unique.
+            #[cfg(not(MODULE))]
+            #[cfg(not(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS))]
+            #[doc(hidden)]
+            #[link_section = \"{initcall_section}\"]
+            #[used]
+            pub static __{name}_initcall: extern \"C\" fn() -> core::ffi::c_int = __{name}_init;
+
+            #[cfg(not(MODULE))]
+            #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
+            core::arch::global_asm!(
+                r#\".section \"{initcall_section}\", \"a\"
+                __{name}_initcall:
+                    .long   __{name}_init - .
+                    .previous
+                \"#
+            );
+
+            #[cfg(not(MODULE))]
+            #[doc(hidden)]
+            #[no_mangle]
+            pub extern \"C\" fn __{name}_init() -> core::ffi::c_int {{
+                __init()
+            }}
+
+            #[cfg(not(MODULE))]
+            #[doc(hidden)]
+            #[no_mangle]
+            pub extern \"C\" fn __{name}_exit() {{
+                __exit()
+            }}
+
+            fn __init() -> core::ffi::c_int {{
+                match <{type_} as kernel::Module>::init(&THIS_MODULE) {{
+                    Ok(m) => {{
+                        unsafe {{
+                            __MOD = Some(m);
+                        }}
+                        return 0;
+                    }}
+                    Err(e) => {{
+                        return e.to_kernel_errno();
+                    }}
+                }}
+            }}
+
+            fn __exit() {{
+                unsafe {{
+                    // Invokes `drop()` on `__MOD`, which should be used for cleanup.
+                    __MOD = None;
+                }}
+            }}
+
+            {modinfo}
+        ",
+        type_ = info.type_,
+        name = info.name,
+        modinfo = modinfo.buffer,
+        initcall_section = ".initcall6.init"
+    )
+    .parse()
+    .expect("Error parsing formatted string into token stream.")
+}
-- 
2.37.3


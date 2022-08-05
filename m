Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE34658AD52
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 17:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241211AbiHEPqK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 11:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241286AbiHEPpk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:45:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0480F66107;
        Fri,  5 Aug 2022 08:44:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94F7161642;
        Fri,  5 Aug 2022 15:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDE8C43140;
        Fri,  5 Aug 2022 15:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659714258;
        bh=X6lh4WNmtZCkT50Wc3ckSm0pNtS3+5we4IFm0nIix5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n33OKap5HI0sHaP457m8TQx6V8F0lhENA/iuRONTMEd0dBAf9TiRE9uNftFWVK7ue
         loOkIUOtslXGBUxGcBDuSW/kScD2nvyvqGelKsGlrOMkatC1aRd1PEPLONBw6VPGYg
         xkhlbVEeHQfeXT7GtXaL4wwtFP+EHczGb/2470qy3xA6LypqCR8Vu5QoQPyybBCini
         ov1z1UidJ2t5rO3n4e+9RlCxyH4stgf9snAVhcmUcXt06AmM7++MG2ZtRcG2ghEB3E
         hbYL3uQWgKeFK7J0MUF4vWErkC1hGVMndodVFqOy9drEcVUPe3hKW+W711zCbhD9nZ
         pfI1xTczu/kug==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        David Gow <davidgow@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Subject: [PATCH v9 19/27] scripts: add `generate_rust_target.rs`
Date:   Fri,  5 Aug 2022 17:42:04 +0200
Message-Id: <20220805154231.31257-20-ojeda@kernel.org>
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

This script takes care of generating the custom target specification
file for `rustc`, based on the kernel configuration.

It also serves as an example of a Rust host program.

A dummy architecture is kept in this patch so that a later patch
adds x86 support on top with as few changes as possible.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/.gitignore              |   1 +
 scripts/generate_rust_target.rs | 171 ++++++++++++++++++++++++++++++++
 2 files changed, 172 insertions(+)
 create mode 100644 scripts/generate_rust_target.rs

diff --git a/scripts/.gitignore b/scripts/.gitignore
index eed308bef604..b7aec8eb1bd4 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 /asn1_compiler
 /bin2c
+/generate_rust_target
 /insert-sys-cert
 /kallsyms
 /module.lds
diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
new file mode 100644
index 000000000000..7256c9606cf0
--- /dev/null
+++ b/scripts/generate_rust_target.rs
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! The custom target specification file generator for `rustc`.
+//!
+//! To configure a target from scratch, a JSON-encoded file has to be passed
+//! to `rustc` (introduced in [RFC 131]). These options and the file itself are
+//! unstable. Eventually, `rustc` should provide a way to do this in a stable
+//! manner. For instance, via command-line arguments. Therefore, this file
+//! should avoid using keys which can be set via `-C` or `-Z` options.
+//!
+//! [RFC 131]: https://rust-lang.github.io/rfcs/0131-target-specification.html
+
+use std::{
+    collections::HashMap,
+    fmt::{Display, Formatter, Result},
+    io::BufRead,
+};
+
+enum Value {
+    Boolean(bool),
+    Number(i32),
+    String(String),
+    Object(Object),
+}
+
+type Object = Vec<(String, Value)>;
+
+/// Minimal "almost JSON" generator (e.g. no `null`s, no arrays, no escaping),
+/// enough for this purpose.
+impl Display for Value {
+    fn fmt(&self, formatter: &mut Formatter<'_>) -> Result {
+        match self {
+            Value::Boolean(boolean) => write!(formatter, "{}", boolean),
+            Value::Number(number) => write!(formatter, "{}", number),
+            Value::String(string) => write!(formatter, "\"{}\"", string),
+            Value::Object(object) => {
+                formatter.write_str("{")?;
+                if let [ref rest @ .., ref last] = object[..] {
+                    for (key, value) in rest {
+                        write!(formatter, "\"{}\": {},", key, value)?;
+                    }
+                    write!(formatter, "\"{}\": {}", last.0, last.1)?;
+                }
+                formatter.write_str("}")
+            }
+        }
+    }
+}
+
+struct TargetSpec(Object);
+
+impl TargetSpec {
+    fn new() -> TargetSpec {
+        TargetSpec(Vec::new())
+    }
+}
+
+trait Push<T> {
+    fn push(&mut self, key: &str, value: T);
+}
+
+impl Push<bool> for TargetSpec {
+    fn push(&mut self, key: &str, value: bool) {
+        self.0.push((key.to_string(), Value::Boolean(value)));
+    }
+}
+
+impl Push<i32> for TargetSpec {
+    fn push(&mut self, key: &str, value: i32) {
+        self.0.push((key.to_string(), Value::Number(value)));
+    }
+}
+
+impl Push<String> for TargetSpec {
+    fn push(&mut self, key: &str, value: String) {
+        self.0.push((key.to_string(), Value::String(value)));
+    }
+}
+
+impl Push<&str> for TargetSpec {
+    fn push(&mut self, key: &str, value: &str) {
+        self.push(key, value.to_string());
+    }
+}
+
+impl Push<Object> for TargetSpec {
+    fn push(&mut self, key: &str, value: Object) {
+        self.0.push((key.to_string(), Value::Object(value)));
+    }
+}
+
+impl Display for TargetSpec {
+    fn fmt(&self, formatter: &mut Formatter<'_>) -> Result {
+        // We add some newlines for clarity.
+        formatter.write_str("{\n")?;
+        if let [ref rest @ .., ref last] = self.0[..] {
+            for (key, value) in rest {
+                write!(formatter, "    \"{}\": {},\n", key, value)?;
+            }
+            write!(formatter, "    \"{}\": {}\n", last.0, last.1)?;
+        }
+        formatter.write_str("}")
+    }
+}
+
+struct KernelConfig(HashMap<String, String>);
+
+impl KernelConfig {
+    /// Parses `include/config/auto.conf` from `stdin`.
+    fn from_stdin() -> KernelConfig {
+        let mut result = HashMap::new();
+
+        let stdin = std::io::stdin();
+        let mut handle = stdin.lock();
+        let mut line = String::new();
+
+        loop {
+            line.clear();
+
+            if handle.read_line(&mut line).unwrap() == 0 {
+                break;
+            }
+
+            if line.starts_with('#') {
+                continue;
+            }
+
+            let (key, value) = line.split_once('=').expect("Missing `=` in line.");
+            result.insert(key.to_string(), value.trim_end_matches('\n').to_string());
+        }
+
+        KernelConfig(result)
+    }
+
+    /// Does the option exist in the configuration (any value)?
+    ///
+    /// The argument must be passed without the `CONFIG_` prefix.
+    /// This avoids repetition and it also avoids `fixdep` making us
+    /// depend on it.
+    fn has(&self, option: &str) -> bool {
+        let option = "CONFIG_".to_owned() + option;
+        self.0.contains_key(&option)
+    }
+}
+
+fn main() {
+    let cfg = KernelConfig::from_stdin();
+    let mut ts = TargetSpec::new();
+
+    // `llvm-target`s are taken from `scripts/Makefile.clang`.
+    if cfg.has("DUMMY_ARCH") {
+        ts.push("arch", "dummy_arch");
+    } else {
+        panic!("Unsupported architecture");
+    }
+
+    ts.push("emit-debug-gdb-scripts", false);
+    ts.push("frame-pointer", "may-omit");
+    ts.push(
+        "stack-probes",
+        vec![("kind".to_string(), Value::String("none".to_string()))],
+    );
+
+    // Everything else is LE, whether `CPU_LITTLE_ENDIAN` is declared or not
+    // (e.g. x86). It is also `rustc`'s default.
+    if cfg.has("CPU_BIG_ENDIAN") {
+        ts.push("target-endian", "big");
+    }
+
+    println!("{}", ts);
+}
-- 
2.37.1


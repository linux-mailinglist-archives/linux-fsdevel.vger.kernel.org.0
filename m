Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3359A58AD6A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 17:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241353AbiHEPrf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 11:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241386AbiHEPpy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:45:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0E174E3E;
        Fri,  5 Aug 2022 08:44:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F080D61647;
        Fri,  5 Aug 2022 15:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B50C433C1;
        Fri,  5 Aug 2022 15:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659714287;
        bh=/42ISJ9zCS3KsjIVACcPzyUc91ESClfPrYmxgS4vUE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TSnd9zVoG70OkrsPK+hoMkWFOtGjesVxSjAkp2g8pmSH+UePvLCyPJkjZz9HOSGyS
         HuGa0OIeuQ6rUs0iDxVdcVzjTJZ0Tpjf0uL6xqI+9oaz6PbiFSbK1AhkmlfoKwfpzv
         4clph2EK8BYHK9yJh032rfoBU0DOCFlnM7Ac1BLANFQMoG73yRMDifjLrGea/sOEeo
         JzWrw/VK77OPJdXhSfK0F4d/tSFMSP/6R8bfSznymSfyBWUMNRLLjwA00f7h96OTbe
         ztVOkVPvYtYALTh3insfyU3qzNMmOMQ0s1C69sLWekgFX9KHYC4ptHbJSQK1t0ThLG
         OKoXqwpbKhhHg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wu XiangCheng <bobwxc@email.cn>, Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Yuki Okushi <jtitor@2k36.org>, Wei Liu <wei.liu@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, Julian Merkle <me@jvmerkle.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH v9 24/27] docs: add Rust documentation
Date:   Fri,  5 Aug 2022 17:42:09 +0200
Message-Id: <20220805154231.31257-25-ojeda@kernel.org>
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

Most of the documentation for Rust is written within the source code
itself, as it is idiomatic for Rust projects. This applies to both
the shared infrastructure at `rust/` as well as any other Rust module
(e.g. drivers) written across the kernel.

However, these documents contain general information that does not
fit particularly well in the source code, like the Quick Start guide.

It also contains a few other small changes elsewhere in the
documentation folder.

Reviewed-by: Kees Cook <keescook@chromium.org>
Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Finn Behrens <me@kloenk.de>
Signed-off-by: Finn Behrens <me@kloenk.de>
Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Co-developed-by: Sven Van Asbroeck <thesven73@gmail.com>
Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
Co-developed-by: Wu XiangCheng <bobwxc@email.cn>
Signed-off-by: Wu XiangCheng <bobwxc@email.cn>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Boris-Chengbiao Zhou <bobo1239@web.de>
Signed-off-by: Boris-Chengbiao Zhou <bobo1239@web.de>
Co-developed-by: Yuki Okushi <jtitor@2k36.org>
Signed-off-by: Yuki Okushi <jtitor@2k36.org>
Co-developed-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Co-developed-by: Daniel Xu <dxu@dxuuu.xyz>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
Co-developed-by: Julian Merkle <me@jvmerkle.de>
Signed-off-by: Julian Merkle <me@jvmerkle.de>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/doc-guide/kernel-doc.rst     |   3 +
 Documentation/index.rst                    |   1 +
 Documentation/kbuild/kbuild.rst            |  17 ++
 Documentation/kbuild/makefiles.rst         |  50 ++++-
 Documentation/process/changes.rst          |  41 ++++
 Documentation/rust/arch-support.rst        |  18 ++
 Documentation/rust/coding-guidelines.rst   | 216 +++++++++++++++++++
 Documentation/rust/general-information.rst |  79 +++++++
 Documentation/rust/index.rst               |  22 ++
 Documentation/rust/quick-start.rst         | 232 +++++++++++++++++++++
 10 files changed, 675 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/rust/arch-support.rst
 create mode 100644 Documentation/rust/coding-guidelines.rst
 create mode 100644 Documentation/rust/general-information.rst
 create mode 100644 Documentation/rust/index.rst
 create mode 100644 Documentation/rust/quick-start.rst

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index a7cb2afd7990..9b868d9eb20f 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -12,6 +12,9 @@ when it is embedded in source files.
    reasons. The kernel source contains tens of thousands of kernel-doc
    comments. Please stick to the style described here.
 
+.. note:: kernel-doc does not cover Rust code: please see
+   Documentation/rust/general-information.rst instead.
+
 The kernel-doc structure is extracted from the comments, and proper
 `Sphinx C Domain`_ function and type descriptions with anchors are
 generated from them. The descriptions are filtered for special kernel-doc
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 67036a05b771..35d90903242a 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -82,6 +82,7 @@ merged much easier.
    maintainer/index
    fault-injection/index
    livepatch/index
+   rust/index
 
 
 Kernel API documentation
diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index ef19b9c13523..08f575e6236c 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -48,6 +48,10 @@ KCFLAGS
 -------
 Additional options to the C compiler (for built-in and modules).
 
+KRUSTFLAGS
+----------
+Additional options to the Rust compiler (for built-in and modules).
+
 CFLAGS_KERNEL
 -------------
 Additional options for $(CC) when used to compile
@@ -57,6 +61,15 @@ CFLAGS_MODULE
 -------------
 Additional module specific options to use for $(CC).
 
+RUSTFLAGS_KERNEL
+----------------
+Additional options for $(RUSTC) when used to compile
+code that is compiled as built-in.
+
+RUSTFLAGS_MODULE
+----------------
+Additional module specific options to use for $(RUSTC).
+
 LDFLAGS_MODULE
 --------------
 Additional options used for $(LD) when linking modules.
@@ -69,6 +82,10 @@ HOSTCXXFLAGS
 ------------
 Additional flags to be passed to $(HOSTCXX) when building host programs.
 
+HOSTRUSTFLAGS
+-------------
+Additional flags to be passed to $(HOSTRUSTC) when building host programs.
+
 HOSTLDFLAGS
 -----------
 Additional flags to be passed when linking host programs.
diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 11a296e52d68..5ea1e72d89c8 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -29,8 +29,9 @@ This document describes the Linux kernel Makefiles.
 	   --- 4.1 Simple Host Program
 	   --- 4.2 Composite Host Programs
 	   --- 4.3 Using C++ for host programs
-	   --- 4.4 Controlling compiler options for host programs
-	   --- 4.5 When host programs are actually built
+	   --- 4.4 Using Rust for host programs
+	   --- 4.5 Controlling compiler options for host programs
+	   --- 4.6 When host programs are actually built
 
 	=== 5 Userspace Program support
 	   --- 5.1 Simple Userspace Program
@@ -835,7 +836,24 @@ Both possibilities are described in the following.
 		qconf-cxxobjs := qconf.o
 		qconf-objs    := check.o
 
-4.4 Controlling compiler options for host programs
+4.4 Using Rust for host programs
+--------------------------------
+
+	Kbuild offers support for host programs written in Rust. However,
+	since a Rust toolchain is not mandatory for kernel compilation,
+	it may only be used in scenarios where Rust is required to be
+	available (e.g. when  ``CONFIG_RUST`` is enabled).
+
+	Example::
+
+		hostprogs     := target
+		target-rust   := y
+
+	Kbuild will compile ``target`` using ``target.rs`` as the crate root,
+	located in the same directory as the ``Makefile``. The crate may
+	consist of several source files (see ``samples/rust/hostprogs``).
+
+4.5 Controlling compiler options for host programs
 --------------------------------------------------
 
 	When compiling host programs, it is possible to set specific flags.
@@ -867,7 +885,7 @@ Both possibilities are described in the following.
 	When linking qconf, it will be passed the extra option
 	"-L$(QTDIR)/lib".
 
-4.5 When host programs are actually built
+4.6 When host programs are actually built
 -----------------------------------------
 
 	Kbuild will only build host-programs when they are referenced
@@ -1181,6 +1199,17 @@ When kbuild executes, the following steps are followed (roughly):
 	The first example utilises the trick that a config option expands
 	to 'y' when selected.
 
+    KBUILD_RUSTFLAGS
+	$(RUSTC) compiler flags
+
+	Default value - see top level Makefile
+	Append or modify as required per architecture.
+
+	Often, the KBUILD_RUSTFLAGS variable depends on the configuration.
+
+	Note that target specification file generation (for ``--target``)
+	is handled in ``scripts/generate_rust_target.rs``.
+
     KBUILD_AFLAGS_KERNEL
 	Assembler options specific for built-in
 
@@ -1208,6 +1237,19 @@ When kbuild executes, the following steps are followed (roughly):
 	are used for $(CC).
 	From commandline CFLAGS_MODULE shall be used (see kbuild.rst).
 
+    KBUILD_RUSTFLAGS_KERNEL
+	$(RUSTC) options specific for built-in
+
+	$(KBUILD_RUSTFLAGS_KERNEL) contains extra Rust compiler flags used to
+	compile resident kernel code.
+
+    KBUILD_RUSTFLAGS_MODULE
+	Options for $(RUSTC) when building modules
+
+	$(KBUILD_RUSTFLAGS_MODULE) is used to add arch-specific options that
+	are used for $(RUSTC).
+	From commandline RUSTFLAGS_MODULE shall be used (see kbuild.rst).
+
     KBUILD_LDFLAGS_MODULE
 	Options for $(LD) when linking modules
 
diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 19c286c23786..9a90197989dd 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -31,6 +31,8 @@ you probably needn't concern yourself with pcmciautils.
 ====================== ===============  ========================================
 GNU C                  5.1              gcc --version
 Clang/LLVM (optional)  11.0.0           clang --version
+Rust (optional)        1.62.0           rustc --version
+bindgen (optional)     0.56.0           bindgen --version
 GNU make               3.81             make --version
 bash                   4.2              bash --version
 binutils               2.23             ld -v
@@ -80,6 +82,29 @@ kernels. Older releases aren't guaranteed to work, and we may drop workarounds
 from the kernel that were used to support older versions. Please see additional
 docs on :ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
 
+Rust (optional)
+---------------
+
+A particular version of the Rust toolchain is required. Newer versions may or
+may not work because the kernel depends on some unstable Rust features, for
+the moment.
+
+Each Rust toolchain comes with several "components", some of which are required
+(like ``rustc``) and some that are optional. The ``rust-src`` component (which
+is optional) needs to be installed to build the kernel. Other components are
+useful for developing.
+
+Please see Documentation/rust/quick-start.rst for instructions on how to
+satisfy the build requirements of Rust support. In particular, the ``Makefile``
+target ``rustavailable`` is useful to check why the Rust toolchain may not
+be detected.
+
+bindgen (optional)
+------------------
+
+``bindgen`` is used to generate the Rust bindings to the C side of the kernel.
+It depends on ``libclang``.
+
 Make
 ----
 
@@ -348,6 +373,12 @@ Sphinx
 Please see :ref:`sphinx_install` in :ref:`Documentation/doc-guide/sphinx.rst <sphinxdoc>`
 for details about Sphinx requirements.
 
+rustdoc
+-------
+
+``rustdoc`` is used to generate the documentation for Rust code. Please see
+Documentation/rust/general-information.rst for more information.
+
 Getting updated software
 ========================
 
@@ -364,6 +395,16 @@ Clang/LLVM
 
 - :ref:`Getting LLVM <getting_llvm>`.
 
+Rust
+----
+
+- Documentation/rust/quick-start.rst.
+
+bindgen
+-------
+
+- Documentation/rust/quick-start.rst.
+
 Make
 ----
 
diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
new file mode 100644
index 000000000000..1152e0fbdad0
--- /dev/null
+++ b/Documentation/rust/arch-support.rst
@@ -0,0 +1,18 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Arch Support
+============
+
+Currently, the Rust compiler (``rustc``) uses LLVM for code generation,
+which limits the supported architectures that can be targeted. In addition,
+support for building the kernel with LLVM/Clang varies (please see
+Documentation/kbuild/llvm.rst). This support is needed for ``bindgen``
+which uses ``libclang``.
+
+Below is a general summary of architectures that currently work. Level of
+support corresponds to ``S`` values in the ``MAINTAINERS`` file.
+
+============  ================  ==============================================
+Architecture  Level of support  Constraints
+============  ================  ==============================================
+============  ================  ==============================================
diff --git a/Documentation/rust/coding-guidelines.rst b/Documentation/rust/coding-guidelines.rst
new file mode 100644
index 000000000000..aa8ed082613e
--- /dev/null
+++ b/Documentation/rust/coding-guidelines.rst
@@ -0,0 +1,216 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Coding Guidelines
+=================
+
+This document describes how to write Rust code in the kernel.
+
+
+Style & formatting
+------------------
+
+The code should be formatted using ``rustfmt``. In this way, a person
+contributing from time to time to the kernel does not need to learn and
+remember one more style guide. More importantly, reviewers and maintainers
+do not need to spend time pointing out style issues anymore, and thus
+less patch roundtrips may be needed to land a change.
+
+.. note:: Conventions on comments and documentation are not checked by
+  ``rustfmt``. Thus those are still needed to be taken care of.
+
+The default settings of ``rustfmt`` are used. This means the idiomatic Rust
+style is followed. For instance, 4 spaces are used for indentation rather
+than tabs.
+
+It is convenient to instruct editors/IDEs to format while typing,
+when saving or at commit time. However, if for some reason reformatting
+the entire kernel Rust sources is needed at some point, the following can be
+run::
+
+	make LLVM=1 rustfmt
+
+It is also possible to check if everything is formatted (printing a diff
+otherwise), for instance for a CI, with::
+
+	make LLVM=1 rustfmtcheck
+
+Like ``clang-format`` for the rest of the kernel, ``rustfmt`` works on
+individual files, and does not require a kernel configuration. Sometimes it may
+even work with broken code.
+
+
+Comments
+--------
+
+"Normal" comments (i.e. ``//``, rather than code documentation which starts
+with ``///`` or ``//!``) are written in Markdown the same way as documentation
+comments are, even though they will not be rendered. This improves consistency,
+simplifies the rules and allows to move content between the two kinds of
+comments more easily. For instance:
+
+.. code-block:: rust
+
+	// `object` is ready to be handled now.
+	f(object);
+
+Furthermore, just like documentation, comments are capitalized at the beginning
+of a sentence and ended with a period (even if it is a single sentence). This
+includes ``// SAFETY:``, ``// TODO:`` and other "tagged" comments, e.g.:
+
+.. code-block:: rust
+
+	// FIXME: The error should be handled properly.
+
+Comments should not be used for documentation purposes: comments are intended
+for implementation details, not users. This distinction is useful even if the
+reader of the source file is both an implementor and a user of an API. In fact,
+sometimes it is useful to use both comments and documentation at the same time.
+For instance, for a ``TODO`` list or to comment on the documentation itself.
+For the latter case, comments can be inserted in the middle; that is, closer to
+the line of documentation to be commented. For any other case, comments are
+written after the documentation, e.g.:
+
+.. code-block:: rust
+
+	/// Returns a new [`Foo`].
+	///
+	/// # Examples
+	///
+	// TODO: Find a better example.
+	/// ```
+	/// let foo = f(42);
+	/// ```
+	// FIXME: Use fallible approach.
+	pub fn f(x: i32) -> Foo {
+	    // ...
+	}
+
+One special kind of comments are the ``// SAFETY:`` comments. These must appear
+before every ``unsafe`` block, and they explain why the code inside the block is
+correct/sound, i.e. why it cannot trigger undefined behavior in any case, e.g.:
+
+.. code-block:: rust
+
+	// SAFETY: `p` is valid by the safety requirements.
+	unsafe { *p = 0; }
+
+``// SAFETY:`` comments are not to be confused with the ``# Safety`` sections
+in code documentation. ``# Safety`` sections specify the contract that callers
+(for functions) or implementors (for traits) need to abide by. ``// SAFETY:``
+comments show why a call (for functions) or implementation (for traits) actually
+respects the preconditions stated in a ``# Safety`` section or the language
+reference.
+
+
+Code documentation
+------------------
+
+Rust kernel code is not documented like C kernel code (i.e. via kernel-doc).
+Instead, the usual system for documenting Rust code is used: the ``rustdoc``
+tool, which uses Markdown (a lightweight markup language).
+
+To learn Markdown, there are many guides available out there. For instance,
+the one at:
+
+	https://commonmark.org/help/
+
+This is how a well-documented Rust function may look like:
+
+.. code-block:: rust
+
+	/// Returns the contained [`Some`] value, consuming the `self` value,
+	/// without checking that the value is not [`None`].
+	///
+	/// # Safety
+	///
+	/// Calling this method on [`None`] is *[undefined behavior]*.
+	///
+	/// [undefined behavior]: https://doc.rust-lang.org/reference/behavior-considered-undefined.html
+	///
+	/// # Examples
+	///
+	/// ```
+	/// let x = Some("air");
+	/// assert_eq!(unsafe { x.unwrap_unchecked() }, "air");
+	/// ```
+	pub unsafe fn unwrap_unchecked(self) -> T {
+	    match self {
+	        Some(val) => val,
+
+	        // SAFETY: The safety contract must be upheld by the caller.
+	        None => unsafe { hint::unreachable_unchecked() },
+	    }
+	}
+
+This example showcases a few ``rustdoc`` features and some conventions followed
+in the kernel:
+
+  - The first paragraph must be a single sentence briefly describing what
+    the documented item does. Further explanations must go in extra paragraphs.
+
+  - Unsafe functions must document their safety preconditions under
+    a ``# Safety`` section.
+
+  - While not shown here, if a function may panic, the conditions under which
+    that happens must be described under a ``# Panics`` section.
+
+    Please note that panicking should be very rare and used only with a good
+    reason. In almost all cases, a fallible approach should be used, typically
+    returning a ``Result``.
+
+  - If providing examples of usage would help readers, they must be written in
+    a section called ``# Examples``.
+
+  - Rust items (functions, types, constants...) must be linked appropriately
+    (``rustdoc`` will create a link automatically).
+
+  - Any ``unsafe`` block must be preceded by a ``// SAFETY:`` comment
+    describing why the code inside is sound.
+
+    While sometimes the reason might look trivial and therefore unneeded,
+    writing these comments is not just a good way of documenting what has been
+    taken into account, but most importantly, it provides a way to know that
+    there are no *extra* implicit constraints.
+
+To learn more about how to write documentation for Rust and extra features,
+please take a look at the ``rustdoc`` book at:
+
+	https://doc.rust-lang.org/rustdoc/how-to-write-documentation.html
+
+
+Naming
+------
+
+Rust kernel code follows the usual Rust naming conventions:
+
+	https://rust-lang.github.io/api-guidelines/naming.html
+
+When existing C concepts (e.g. macros, functions, objects...) are wrapped into
+a Rust abstraction, a name as close as reasonably possible to the C side should
+be used in order to avoid confusion and to improve readability when switching
+back and forth between the C and Rust sides. For instance, macros such as
+``pr_info`` from C are named the same in the Rust side.
+
+Having said that, casing should be adjusted to follow the Rust naming
+conventions, and namespacing introduced by modules and types should not be
+repeated in the item names. For instance, when wrapping constants like:
+
+.. code-block:: c
+
+	#define GPIO_LINE_DIRECTION_IN	0
+	#define GPIO_LINE_DIRECTION_OUT	1
+
+The equivalent in Rust may look like (ignoring documentation):
+
+.. code-block:: rust
+
+	pub mod gpio {
+	    pub enum LineDirection {
+	        In = bindings::GPIO_LINE_DIRECTION_IN as _,
+	        Out = bindings::GPIO_LINE_DIRECTION_OUT as _,
+	    }
+	}
+
+That is, the equivalent of ``GPIO_LINE_DIRECTION_IN`` would be referred to as
+``gpio::LineDirection::In``. In particular, it should not be named
+``gpio::gpio_line_direction::GPIO_LINE_DIRECTION_IN``.
diff --git a/Documentation/rust/general-information.rst b/Documentation/rust/general-information.rst
new file mode 100644
index 000000000000..49029ee82e55
--- /dev/null
+++ b/Documentation/rust/general-information.rst
@@ -0,0 +1,79 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+General Information
+===================
+
+This document contains useful information to know when working with
+the Rust support in the kernel.
+
+
+Code documentation
+------------------
+
+Rust kernel code is documented using ``rustdoc``, its built-in documentation
+generator.
+
+The generated HTML docs include integrated search, linked items (e.g. types,
+functions, constants), source code, etc. They may be read at (TODO: link when
+in mainline and generated alongside the rest of the documentation):
+
+	http://kernel.org/
+
+The docs can also be easily generated and read locally. This is quite fast
+(same order as compiling the code itself) and no special tools or environment
+are needed. This has the added advantage that they will be tailored to
+the particular kernel configuration used. To generate them, use the ``rustdoc``
+target with the same invocation used for compilation, e.g.::
+
+	make LLVM=1 rustdoc
+
+To read the docs locally in your web browser, run e.g.::
+
+	xdg-open rust/doc/kernel/index.html
+
+To learn about how to write the documentation, please see coding-guidelines.rst.
+
+
+Extra lints
+-----------
+
+While ``rustc`` is a very helpful compiler, some extra lints and analyses are
+available via ``clippy``, a Rust linter. To enable it, pass ``CLIPPY=1`` to
+the same invocation used for compilation, e.g.::
+
+	make LLVM=1 CLIPPY=1
+
+Please note that Clippy may change code generation, thus it should not be
+enabled while building a production kernel.
+
+
+Abstractions vs. bindings
+-------------------------
+
+Abstractions are Rust code wrapping kernel functionality from the C side.
+
+In order to use functions and types from the C side, bindings are created.
+Bindings are the declarations for Rust of those functions and types from
+the C side.
+
+For instance, one may write a ``Mutex`` abstraction in Rust which wraps
+a ``struct mutex`` from the C side and calls its functions through the bindings.
+
+Abstractions are not available for all the kernel internal APIs and concepts,
+but it is intended that coverage is expanded as time goes on. "Leaf" modules
+(e.g. drivers) should not use the C bindings directly. Instead, subsystems
+should provide as-safe-as-possible abstractions as needed.
+
+
+Conditional compilation
+-----------------------
+
+Rust code has access to conditional compilation based on the kernel
+configuration:
+
+.. code-block:: rust
+
+	#[cfg(CONFIG_X)]       // Enabled               (`y` or `m`)
+	#[cfg(CONFIG_X="y")]   // Enabled as a built-in (`y`)
+	#[cfg(CONFIG_X="m")]   // Enabled as a module   (`m`)
+	#[cfg(not(CONFIG_X))]  // Disabled
diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
new file mode 100644
index 000000000000..4ae8c66b94fa
--- /dev/null
+++ b/Documentation/rust/index.rst
@@ -0,0 +1,22 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Rust
+====
+
+Documentation related to Rust within the kernel. To start using Rust
+in the kernel, please read the quick-start.rst guide.
+
+.. toctree::
+    :maxdepth: 1
+
+    quick-start
+    general-information
+    coding-guidelines
+    arch-support
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
new file mode 100644
index 000000000000..13b7744b1e27
--- /dev/null
+++ b/Documentation/rust/quick-start.rst
@@ -0,0 +1,232 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Quick Start
+===========
+
+This document describes how to get started with kernel development in Rust.
+
+
+Requirements: Building
+----------------------
+
+This section explains how to fetch the tools needed for building.
+
+Some of these requirements might be available from Linux distributions
+under names like ``rustc``, ``rust-src``, ``rust-bindgen``, etc. However,
+at the time of writing, they are likely not to be recent enough unless
+the distribution tracks the latest releases.
+
+To easily check whether the requirements are met, the following target
+can be used::
+
+	make LLVM=1 rustavailable
+
+This triggers the same logic used by Kconfig to determine whether
+``RUST_IS_AVAILABLE`` should be enabled; but it also explains why not
+if that is the case.
+
+
+rustc
+*****
+
+A particular version of the Rust compiler is required. Newer versions may or
+may not work because, for the moment, the kernel depends on some unstable
+Rust features.
+
+If ``rustup`` is being used, enter the checked out source code directory
+and run::
+
+	rustup override set $(scripts/min-tool-version.sh rustc)
+
+Otherwise, fetch a standalone installer or install ``rustup`` from:
+
+	https://www.rust-lang.org
+
+
+Rust standard library source
+****************************
+
+The Rust standard library source is required because the build system will
+cross-compile ``core`` and ``alloc``.
+
+If ``rustup`` is being used, run::
+
+	rustup component add rust-src
+
+The components are installed per toolchain, thus upgrading the Rust compiler
+version later on requires re-adding the component.
+
+Otherwise, if a standalone installer is used, the Rust repository may be cloned
+into the installation folder of the toolchain::
+
+	git clone --recurse-submodules \
+		--branch $(scripts/min-tool-version.sh rustc) \
+		https://github.com/rust-lang/rust \
+		$(rustc --print sysroot)/lib/rustlib/src/rust
+
+In this case, upgrading the Rust compiler version later on requires manually
+updating this clone.
+
+
+libclang
+********
+
+``libclang`` (part of LLVM) is used by ``bindgen`` to understand the C code
+in the kernel, which means LLVM needs to be installed; like when the kernel
+is compiled with ``CC=clang`` or ``LLVM=1``.
+
+Linux distributions are likely to have a suitable one available, so it is
+best to check that first.
+
+There are also some binaries for several systems and architectures uploaded at:
+
+	https://releases.llvm.org/download.html
+
+Otherwise, building LLVM takes quite a while, but it is not a complex process:
+
+	https://llvm.org/docs/GettingStarted.html#getting-the-source-code-and-building-llvm
+
+Please see Documentation/kbuild/llvm.rst for more information and further ways
+to fetch pre-built releases and distribution packages.
+
+
+bindgen
+*******
+
+The bindings to the C side of the kernel are generated at build time using
+the ``bindgen`` tool. A particular version is required.
+
+Install it via (note that this will download and build the tool from source)::
+
+	cargo install --locked --version $(scripts/min-tool-version.sh bindgen) bindgen
+
+
+Requirements: Developing
+------------------------
+
+This section explains how to fetch the tools needed for developing. That is,
+they are not needed when just building the kernel.
+
+
+rustfmt
+*******
+
+The ``rustfmt`` tool is used to automatically format all the Rust kernel code,
+including the generated C bindings (for details, please see
+coding-guidelines.rst).
+
+If ``rustup`` is being used, its ``default`` profile already installs the tool,
+thus nothing needs to be done. If another profile is being used, the component
+can be installed manually::
+
+	rustup component add rustfmt
+
+The standalone installers also come with ``rustfmt``.
+
+
+clippy
+******
+
+``clippy`` is a Rust linter. Running it provides extra warnings for Rust code.
+It can be run by passing ``CLIPPY=1`` to ``make`` (for details, please see
+general-information.rst).
+
+If ``rustup`` is being used, its ``default`` profile already installs the tool,
+thus nothing needs to be done. If another profile is being used, the component
+can be installed manually::
+
+	rustup component add clippy
+
+The standalone installers also come with ``clippy``.
+
+
+cargo
+*****
+
+``cargo`` is the Rust native build system. It is currently required to run
+the tests since it is used to build a custom standard library that contains
+the facilities provided by the custom ``alloc`` in the kernel. The tests can
+be run using the ``rusttest`` Make target.
+
+If ``rustup`` is being used, all the profiles already install the tool,
+thus nothing needs to be done.
+
+The standalone installers also come with ``cargo``.
+
+
+rustdoc
+*******
+
+``rustdoc`` is the documentation tool for Rust. It generates pretty HTML
+documentation for Rust code (for details, please see
+general-information.rst).
+
+``rustdoc`` is also used to test the examples provided in documented Rust code
+(called doctests or documentation tests). The ``rusttest`` Make target uses
+this feature.
+
+If ``rustup`` is being used, all the profiles already install the tool,
+thus nothing needs to be done.
+
+The standalone installers also come with ``rustdoc``.
+
+
+rust-analyzer
+*************
+
+The `rust-analyzer <https://rust-analyzer.github.io/>`_ language server can
+be used with many editors to enable syntax highlighting, completion, go to
+definition, and other features.
+
+``rust-analyzer`` needs a configuration file, ``rust-project.json``, which
+can be generated by the ``rust-analyzer`` Make target.
+
+
+Configuration
+-------------
+
+``Rust support`` (``CONFIG_RUST``) needs to be enabled in the ``General setup``
+menu. The option is only shown if a suitable Rust toolchain is found (see
+above), as long as the other requirements are met. In turn, this will make
+visible the rest of options that depend on Rust.
+
+Afterwards, go to::
+
+	Kernel hacking
+	    -> Sample kernel code
+	        -> Rust samples
+
+And enable some sample modules either as built-in or as loadable.
+
+
+Building
+--------
+
+Building a kernel with a complete LLVM toolchain is the best supported setup
+at the moment. That is::
+
+	make LLVM=1
+
+For architectures that do not support a full LLVM toolchain, use::
+
+	make CC=clang
+
+Using GCC also works for some configurations, but it is very experimental at
+the moment.
+
+
+Hacking
+-------
+
+To dive deeper, take a look at the source code of the samples
+at ``samples/rust/``, the Rust support code under ``rust/`` and
+the ``Rust hacking`` menu under ``Kernel hacking``.
+
+If GDB/Binutils is used and Rust symbols are not getting demangled, the reason
+is the toolchain does not support Rust's new v0 mangling scheme yet.
+There are a few ways out:
+
+  - Install a newer release (GDB >= 10.2, Binutils >= 2.36).
+
+  - Some versions of GDB (e.g. vanilla GDB 10.1) are able to use
+    the pre-demangled names embedded in the debug info (``CONFIG_DEBUG_INFO``).
-- 
2.37.1


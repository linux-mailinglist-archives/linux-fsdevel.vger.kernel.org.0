Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2257E5EC3F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 15:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbiI0NQD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 09:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbiI0NP5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:15:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1F613E2D;
        Tue, 27 Sep 2022 06:15:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DA57B81BB6;
        Tue, 27 Sep 2022 13:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A1BC433C1;
        Tue, 27 Sep 2022 13:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664284551;
        bh=BtTLH+cSHuBy5Q/9p2KfMksnestZXgZpovnz/yO4aJw=;
        h=From:To:Cc:Subject:Date:From;
        b=VC7Jyj3ldKs6uGLJvtu8S7SgTUbTgxVotzSP7w/DgHix9+xSYQma0Jmp4XtqdfeUH
         IuRu1c+n3EEwbQ8T/NiJ48Ah612UPH54jAmfe+QAm/hcg2xAAlRMy2uozXNWOtOUUJ
         cvpRY/g7HqOF1mQSCnrDlT1ZJGm2j7NL+ax3Eh5n1MF+1XFqRSMCpmYoCiL2mTYMYW
         7BGzGieNBuW9saY4D4d3QBEvk7rN8UajLYduvtLbDmCLxh1e2ElP2VXbn6g5zTpJzT
         nV9J/1Jw/K+YQLg1OXb472ttSPahspZ0p3FT+N3O9D+yBCkp75PUAXBW8ekGuzH00q
         e8v692I515F4A==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-perf-users@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: [PATCH v10 00/27] Rust support
Date:   Tue, 27 Sep 2022 15:14:31 +0200
Message-Id: <20220927131518.30000-1-ojeda@kernel.org>
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

Rust support

This is the patch series (v10) to add support for Rust as a second
language to the Linux kernel.

If you are interested in following this effort, please join us in
the mailing list at:

    rust-for-linux@vger.kernel.org

and take a look at the project itself at:

    https://github.com/Rust-for-Linux

As usual, special thanks go to ISRG (Internet Security Research Group)
and Google for their financial support on this endeavor.

Cheers,
Miguel

--

# Rust support

This cover letter explains the major changes and updates done since
the previous ones. For those, please see:

    RFC: https://lore.kernel.org/lkml/20210414184604.23473-1-ojeda@kernel.org/
    v1:  https://lore.kernel.org/lkml/20210704202756.29107-1-ojeda@kernel.org/
    v2:  https://lore.kernel.org/lkml/20211206140313.5653-1-ojeda@kernel.org/
    v3:  https://lore.kernel.org/lkml/20220117053349.6804-1-ojeda@kernel.org/
    v4:  https://lore.kernel.org/lkml/20220212130410.6901-1-ojeda@kernel.org/
    v5:  https://lore.kernel.org/lkml/20220317181032.15436-1-ojeda@kernel.org/
    v6:  https://lore.kernel.org/lkml/20220507052451.12890-1-ojeda@kernel.org/
    v7:  https://lore.kernel.org/lkml/20220523020209.11810-1-ojeda@kernel.org/
    v8:  https://lore.kernel.org/lkml/20220802015052.10452-1-ojeda@kernel.org/
    v9:  https://lore.kernel.org/lkml/20220805154231.31257-1-ojeda@kernel.org/

This is v9 with only minimal/trivial changes, intended for v6.1:

  - `scripts/kallsyms.c`: replaced `sizeof` with `ARRAY_SIZE`.

  - `scripts/kallsyms.c`: added a comment on `KSYM_NAME_LEN_BUFFER`
    to clarify why the `_Static_assert` is needed.

  - `Makefile`: added a comment on `export RUSTC_BOOTSTRAP := 1` to
    explain that it enables unstable features in the stable compiler.

  - Moved `min-tool-version.sh` changes to commit "scripts: add
    `rust_is_available.sh`".

  - Reworded commit "rust: import upstream `alloc` crate" to add
    a script snippet to verify that the contents match upstream.

  - Reworded commit "rust: add C helpers" to explain that the file
    will grow over time.

  - Picked `Reviewed-by` and `Tested-by` tags.

  - Rebased on top of v6.0-rc7, which clears a few conflicts.

Most of the code has been around in linux-next for some months now.
In particular, v9 has been 7 weeks there.


## Patch series status

The Rust support is still to be considered experimental. However,
support is good enough that kernel developers can start working on the
Rust abstractions for subsystems and write drivers and other modules.

The current series will appear in the next `linux-next`, as usual.

I have kept the docs as they were in v8/v9 since they showcase best
what the docs would eventually look like:

    https://rust-for-linux.github.io/docs/kernel/

As usual, please see the following link for the live list of unstable
Rust features we are using (note that this trimmed version does not
require all of them):

    https://github.com/Rust-for-Linux/linux/issues/2


## Conferences, meetings and liaisons

Thanks a lot to everyone that joined us in LPC 2022 (Linux Plumbers
Conference) for the Rust MC (microconference)!

    https://lpc.events/event/16/sessions/150/
    https://www.youtube.com/watch?v=Xw9pKeJ-4Bw

In addition, I would like to personally thank Google and ISRG
(Internet Security Research Group) for sponsoring Kangrejos,
the Rust for Linux workshop; and everyone that made the effort
to travel to Spain before LPC:

    https://kangrejos.com


## Acknowledgements

The signatures in the main commits correspond to the people that
wrote code that has ended up in them at the present time. For details
on contributions to code and discussions, please see our repository:

    https://github.com/Rust-for-Linux/linux

However, we would like to give credit to everyone that has contributed
in one way or another to the Rust for Linux project. Since the
previous cover letter:

  - Kees Cook, Nick Desaulniers, Konstantin Shelekhin and Masahiro
    Yamada for their reviews of some of the v9 patches.

  - Matthew Wilcox, Linus Torvalds, comex, Eric W. Biederman,
    Greg Kroah-Hartman and Geert Stappers for their feedback on v9.

  - Asahi Lina for working on her M1 GPU driver.

  - FUJITA Tomonori for continuing his work on PCI, IRQ, BAR, DMA,
    `ioremap`... support for a NVMe Rust driver, as well as adding
    `be16/32/64` and `le16/32/64` types.

  - Li Hongyu for working on making the `get_id_info` function more
    general so that it is not tied to `platform`, continuing the work
    on the virtio abstraction and the `virtio-net` driver, which
    includes abstractions for `ethtool`, `scatterlist`, NAPI...

  - Arnaldo Carvalho de Melo for releasing `pahole` 1.24 with support
    for `--lang` and `--lang_exclude`, useful "to exclude Rust compile
    units while aspects of the DWARF generated for it get sorted out
    in a way that the kernel BPF verifier don't refuse loading the BTF
    generated from them".

  - Martin Rodriguez Reboredo for working on USB abstractions as well
    as using the new `pahole` `--lang_exclude` feature to exclude
    Rust compilation units.

  - David Gow for fixing the UML support.

  - Adam Bratschi-Kaye for redoing his debugfs implementation without
    `seq_file`.

  - Alice Ryhl for continuing her work on adding `BINDER_TYPE_PTR`
    support.

  - Philipp Gesang for updating the `sysctl` module to deal with
    commit 32927393dc1c ("sysctl: pass kernel pointers to
    ->proc_handler") as well as improving the `module!` macro to allow
    overriding the name of module param constants.

  - Masahiro Yamada for proposing a refactor of the Kbuild support for
    Rust as well as removing the `-v` option of the
    `rust_is_available.sh` script.

  - Russell Currey for making `scripts/rust_is_available.sh`
    compatible with using multiple words for `$CC`, e.g. for `ccache`.

  - Jalil David Salamé Messina for marking the `bit` function as
    `const` so that it can be used for e.g. creating `const` masks.

  - Jon Olson for continuing his work on a `cpu` module with utilities
    for SMP systems.

  - Raghvender for working on improving a check on
    `scripts/rust-is-available.sh`.

  - Angelos for working on using `NonZeroI16` as the `Error` inner
    type.

  - Finn Behrens for updating his work on making it possible to
    compile the kernel on macOS with Rust enabled.

  - Kaviraj Kanagaraj for suggesting improvements to the quick start
    guide.

  - Sergio González Collado for suggesting improvements to the
    `Makefile` to show an extra message.

  - Wei Liu for taking the time to answer questions from newcomers
    in Zulip.

  - Philip Li, Yujie Liu et al. for continuing their work on adding
    Rust support to the Intel 0DAY/LKP kernel test robot.

  - Philip Herron and Arthur Cohen (and his supporters Open Source
    Security and Embecosm) et al. for their ongoing work on Rust GCC.

  - Antoni Boucher (and his supporters) et al. for their ongoing
    work on `rustc_codegen_gcc`.

  - Emilio Cobos Álvarez, Christian Poveda et al. for their work on
    `bindgen`, including on issues that affect the kernel.

  - Mats Larsen, Marc Poulhiès et al. for their ongoing work on
    improving Rust support in Compiler Explorer.

  - Many folks that have reported issues, tested the project,
    helped spread the word, joined discussions and contributed in
    other ways!

Please see also the acknowledgements on the previous cover letters.


Boqun Feng (2):
  kallsyms: use `ARRAY_SIZE` instead of hardcoded size
  kallsyms: avoid hardcoding buffer size

Daniel Xu (1):
  scripts: add `is_rust_module.sh`

Gary Guo (1):
  vsprintf: add new `%pA` format specifier

Miguel Ojeda (22):
  kallsyms: add static relationship between `KSYM_NAME_LEN{,_BUFFER}`
  kallsyms: support "big" kernel symbols
  kallsyms: increase maximum kernel symbol length to 512
  rust: add C helpers
  rust: import upstream `alloc` crate
  rust: adapt `alloc` crate to the kernel
  rust: add `compiler_builtins` crate
  rust: add `macros` crate
  rust: add `bindings` crate
  rust: export generated symbols
  scripts: checkpatch: diagnose uses of `%pA` in the C side as errors
  scripts: checkpatch: enable language-independent checks for Rust
  scripts: decode_stacktrace: demangle Rust symbols
  scripts: add `generate_rust_analyzer.py`
  scripts: add `generate_rust_target.rs`
  scripts: add `rust_is_available.sh`
  rust: add `.rustfmt.toml`
  Kbuild: add Rust support
  docs: add Rust documentation
  x86: enable initial Rust support
  samples: add first Rust examples
  MAINTAINERS: Rust

Wedson Almeida Filho (1):
  rust: add `kernel` crate

 .gitignore                                   |    6 +
 .rustfmt.toml                                |   12 +
 Documentation/core-api/printk-formats.rst    |   10 +
 Documentation/doc-guide/kernel-doc.rst       |    3 +
 Documentation/index.rst                      |    1 +
 Documentation/kbuild/kbuild.rst              |   17 +
 Documentation/kbuild/makefiles.rst           |   50 +-
 Documentation/process/changes.rst            |   41 +
 Documentation/rust/arch-support.rst          |   19 +
 Documentation/rust/coding-guidelines.rst     |  216 ++
 Documentation/rust/general-information.rst   |   79 +
 Documentation/rust/index.rst                 |   22 +
 Documentation/rust/quick-start.rst           |  232 ++
 MAINTAINERS                                  |   18 +
 Makefile                                     |  172 +-
 arch/Kconfig                                 |    6 +
 arch/x86/Kconfig                             |    1 +
 arch/x86/Makefile                            |   10 +
 include/linux/compiler_types.h               |    6 +-
 include/linux/kallsyms.h                     |    2 +-
 init/Kconfig                                 |   46 +-
 kernel/configs/rust.config                   |    1 +
 kernel/kallsyms.c                            |   26 +-
 kernel/livepatch/core.c                      |    4 +-
 lib/Kconfig.debug                            |   34 +
 lib/vsprintf.c                               |   13 +
 rust/.gitignore                              |    8 +
 rust/Makefile                                |  381 +++
 rust/alloc/README.md                         |   33 +
 rust/alloc/alloc.rs                          |  440 +++
 rust/alloc/borrow.rs                         |  498 +++
 rust/alloc/boxed.rs                          | 2028 +++++++++++
 rust/alloc/collections/mod.rs                |  156 +
 rust/alloc/lib.rs                            |  244 ++
 rust/alloc/raw_vec.rs                        |  527 +++
 rust/alloc/slice.rs                          | 1204 +++++++
 rust/alloc/vec/drain.rs                      |  186 ++
 rust/alloc/vec/drain_filter.rs               |  145 +
 rust/alloc/vec/into_iter.rs                  |  366 ++
 rust/alloc/vec/is_zero.rs                    |  120 +
 rust/alloc/vec/mod.rs                        | 3140 ++++++++++++++++++
 rust/alloc/vec/partial_eq.rs                 |   49 +
 rust/bindgen_parameters                      |   21 +
 rust/bindings/bindings_helper.h              |   13 +
 rust/bindings/lib.rs                         |   53 +
 rust/compiler_builtins.rs                    |   63 +
 rust/exports.c                               |   21 +
 rust/helpers.c                               |   51 +
 rust/kernel/allocator.rs                     |   64 +
 rust/kernel/error.rs                         |   59 +
 rust/kernel/lib.rs                           |   78 +
 rust/kernel/prelude.rs                       |   20 +
 rust/kernel/print.rs                         |  198 ++
 rust/kernel/str.rs                           |   72 +
 rust/macros/helpers.rs                       |   51 +
 rust/macros/lib.rs                           |   72 +
 rust/macros/module.rs                        |  282 ++
 samples/Kconfig                              |    2 +
 samples/Makefile                             |    1 +
 samples/rust/Kconfig                         |   30 +
 samples/rust/Makefile                        |    5 +
 samples/rust/hostprogs/.gitignore            |    3 +
 samples/rust/hostprogs/Makefile              |    5 +
 samples/rust/hostprogs/a.rs                  |    7 +
 samples/rust/hostprogs/b.rs                  |    5 +
 samples/rust/hostprogs/single.rs             |   12 +
 samples/rust/rust_minimal.rs                 |   38 +
 scripts/.gitignore                           |    1 +
 scripts/Kconfig.include                      |    6 +-
 scripts/Makefile                             |    3 +
 scripts/Makefile.build                       |   60 +
 scripts/Makefile.debug                       |    8 +
 scripts/Makefile.host                        |   34 +-
 scripts/Makefile.lib                         |   12 +
 scripts/Makefile.modfinal                    |    8 +-
 scripts/cc-version.sh                        |   12 +-
 scripts/checkpatch.pl                        |   12 +-
 scripts/decode_stacktrace.sh                 |   14 +
 scripts/generate_rust_analyzer.py            |  135 +
 scripts/generate_rust_target.rs              |  182 +
 scripts/is_rust_module.sh                    |   16 +
 scripts/kallsyms.c                           |   53 +-
 scripts/kconfig/confdata.c                   |   75 +
 scripts/min-tool-version.sh                  |    6 +
 scripts/rust_is_available.sh                 |  160 +
 scripts/rust_is_available_bindgen_libclang.h |    2 +
 tools/include/linux/kallsyms.h               |    2 +-
 tools/lib/perf/include/perf/event.h          |    2 +-
 tools/lib/symbol/kallsyms.h                  |    2 +-
 89 files changed, 12552 insertions(+), 51 deletions(-)
 create mode 100644 .rustfmt.toml
 create mode 100644 Documentation/rust/arch-support.rst
 create mode 100644 Documentation/rust/coding-guidelines.rst
 create mode 100644 Documentation/rust/general-information.rst
 create mode 100644 Documentation/rust/index.rst
 create mode 100644 Documentation/rust/quick-start.rst
 create mode 100644 kernel/configs/rust.config
 create mode 100644 rust/.gitignore
 create mode 100644 rust/Makefile
 create mode 100644 rust/alloc/README.md
 create mode 100644 rust/alloc/alloc.rs
 create mode 100644 rust/alloc/borrow.rs
 create mode 100644 rust/alloc/boxed.rs
 create mode 100644 rust/alloc/collections/mod.rs
 create mode 100644 rust/alloc/lib.rs
 create mode 100644 rust/alloc/raw_vec.rs
 create mode 100644 rust/alloc/slice.rs
 create mode 100644 rust/alloc/vec/drain.rs
 create mode 100644 rust/alloc/vec/drain_filter.rs
 create mode 100644 rust/alloc/vec/into_iter.rs
 create mode 100644 rust/alloc/vec/is_zero.rs
 create mode 100644 rust/alloc/vec/mod.rs
 create mode 100644 rust/alloc/vec/partial_eq.rs
 create mode 100644 rust/bindgen_parameters
 create mode 100644 rust/bindings/bindings_helper.h
 create mode 100644 rust/bindings/lib.rs
 create mode 100644 rust/compiler_builtins.rs
 create mode 100644 rust/exports.c
 create mode 100644 rust/helpers.c
 create mode 100644 rust/kernel/allocator.rs
 create mode 100644 rust/kernel/error.rs
 create mode 100644 rust/kernel/lib.rs
 create mode 100644 rust/kernel/prelude.rs
 create mode 100644 rust/kernel/print.rs
 create mode 100644 rust/kernel/str.rs
 create mode 100644 rust/macros/helpers.rs
 create mode 100644 rust/macros/lib.rs
 create mode 100644 rust/macros/module.rs
 create mode 100644 samples/rust/Kconfig
 create mode 100644 samples/rust/Makefile
 create mode 100644 samples/rust/hostprogs/.gitignore
 create mode 100644 samples/rust/hostprogs/Makefile
 create mode 100644 samples/rust/hostprogs/a.rs
 create mode 100644 samples/rust/hostprogs/b.rs
 create mode 100644 samples/rust/hostprogs/single.rs
 create mode 100644 samples/rust/rust_minimal.rs
 create mode 100755 scripts/generate_rust_analyzer.py
 create mode 100644 scripts/generate_rust_target.rs
 create mode 100755 scripts/is_rust_module.sh
 create mode 100755 scripts/rust_is_available.sh
 create mode 100644 scripts/rust_is_available_bindgen_libclang.h


base-commit: f76349cf41451c5c42a99f18a9163377e4b364ff
-- 
2.37.3


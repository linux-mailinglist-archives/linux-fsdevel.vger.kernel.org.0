Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9775058AD2E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 17:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240920AbiHEPnA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 11:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240871AbiHEPm6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:42:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB602715A;
        Fri,  5 Aug 2022 08:42:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28AC9B82986;
        Fri,  5 Aug 2022 15:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2C5C433D6;
        Fri,  5 Aug 2022 15:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659714172;
        bh=k4V0csirDUCnH7Fhnp9g29fd8eNFkLlG+juJvRWwTjQ=;
        h=From:To:Cc:Subject:Date:From;
        b=UNyNCR1k+qxeQu2aw1lctRAXJeu/A7o6SLb2LCTJM1Q+/CQfTbde4IHVmaNx3gZQJ
         XWNtkd3lKnhMkAr8m6bUPDlPKzIGA/NWtK4Xubd+BMy+9/wuO9YtQv99OQzQdz6rIe
         xTS07hZIS5y+UZ2GdPULEauUE7y88FzVQpDyh1Bnspf3tDLhuVIveePh5vOKxkx/jd
         nuh6+aspmAq80rOxY1QsiSTix0dPt6pE1qgnwAcAyQYdBof4C63zAbS9TCKPZv3aDN
         XWr9pKX0ohtV70jXtxyLgKiKj1JBnzaxxn4u0EUSJi/d10FKO1MqzIOzS0g0DPp37r
         eCLoA64E5gtuQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-perf-users@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: [PATCH v9 00/27] Rust support
Date:   Fri,  5 Aug 2022 17:41:45 +0200
Message-Id: <20220805154231.31257-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Rust support

This is the patch series (v9) to add support for Rust as a second
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

This is a trimmed down v8. It has enough support to compile a minimal
Rust kernel module, with the aim to get the "core" support in first
and then start upstreaming the rest piece by piece.

The kernel module is able to create a `Vec<i32>` (a contiguous,
growable array type), push some numbers and print them on unload to
the kernel log with the `pr_info!` macro.

The patch series could be made even more minimal by removing some of
that too, but this seemed like a good balance.

After the diet regime, 3% of the `kernel` crate remains (down to 500
lines), 60% of `alloc`, and the "adapt `alloc`" commit is 100 lines.
Overall, we went from 40 to 13 klines.

Most of the code has been around in linux-next for some months now,
but to trim down things I had to do minor changes. In any case, please
let me know if this selection is in line with what you expected.


## Patch series status

The Rust support is still to be considered experimental. However,
support is good enough that kernel developers can start working on the
Rust abstractions for subsystems and write drivers and other modules.

The current series will appear in the next `linux-next`, as usual.

I have kept the docs as they were in v8 since they showcase best what
the docs would eventually look like:

    https://rust-for-linux.github.io/docs/kernel/

As usual, please see the following link for the live list of unstable
Rust features we are using (note that this trimmed version does not
require all of them):

    https://github.com/Rust-for-Linux/linux/issues/2


## Conferences, meetings and liaisons

Join us in LPC 2022 (Linux Plumbers Conference) for the Rust MC
(microconference)! The schedule is available at:

    https://lpc.events/event/16/sessions/150/

We will be talking about GCC Rust (the Rust frontend for GCC),
`rustc_codegen_gcc` (the GCC backend for `rustc`), Rust for Linux,
the Rust NVMe driver, the integration of Rust with the Kernel Testing
Service and Rust in the Kernel (via eBPF).

In addition, I would like to personally thank Google and ISRG
(Internet Security Research Group) for sponsoring Kangrejos,
the Rust for Linux workshop:

    https://kangrejos.com


## Acknowledgements

The signatures in the main commits correspond to the people that
wrote code that has ended up in them at the present time. For details
on contributions to code and discussions, please see our repository:

    https://github.com/Rust-for-Linux/linux

However, we would like to give credit to everyone that has contributed
in one way or another to the Rust for Linux project. Since the
previous cover letter:

  - Boqun Feng, Konstantin Shelekhin and David Laight for their
    reviews of some of the v8 patches.

  - Matthew Wilcox, Greg Kroah-Hartman, Rasmus Villemoes and Christoph
    Hellwig for their feedback on v8.

  - Björn Roy Baron, Gary Guo and Boqun Feng for stepping up as
    reviewers in `MAINTAINERS`.

  - Jon Olson for working on a `cpu` module with utilities for
    SMP systems.

  - Alice Ryhl for working on adding `BINDER_TYPE_PTR` support.

  - FUJITA Tomonori for working on PCI support for a NVMe Rust driver.

  - Andreas Reindl for working on adding missing `SAFETY` comments.

  - Wei Liu for taking the time to answer questions from newcomers
    in Zulip.

  - Philip Li, Yujie Liu et al. for continuing their work on adding
    Rust support to the Intel 0DAY/LKP kernel test robot.

  - Philip Herron and Arthur Cohen (and his supporters Open Source
    Security and Embecosm) et al. for their ongoing work on GCC Rust.

  - Antoni Boucher (and his supporters) et al. for their ongoing
    work on `rustc_codegen_gcc`.

  - Emilio Cobos Álvarez et al. for their work on `bindgen`, including
    on issues that affect the kernel.

  - Mats Larsen, Marc Poulhiès et al. for their ongoing work on
    improving Rust support in Compiler Explorer.

  - Many folks that have reported issues, tested the project,
    helped spread the word, joined discussions and contributed in
    other ways!

Please see also the acknowledgements on the previous cover letters.


Boqun Feng (2):
  kallsyms: use `sizeof` instead of hardcoded size
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
 scripts/Makefile.debug                       |   10 +
 scripts/Makefile.host                        |   34 +-
 scripts/Makefile.lib                         |   12 +
 scripts/Makefile.modfinal                    |    8 +-
 scripts/cc-version.sh                        |   12 +-
 scripts/checkpatch.pl                        |   12 +-
 scripts/decode_stacktrace.sh                 |   14 +
 scripts/generate_rust_analyzer.py            |  135 +
 scripts/generate_rust_target.rs              |  182 +
 scripts/is_rust_module.sh                    |   16 +
 scripts/kallsyms.c                           |   47 +-
 scripts/kconfig/confdata.c                   |   75 +
 scripts/min-tool-version.sh                  |    6 +
 scripts/rust_is_available.sh                 |  160 +
 scripts/rust_is_available_bindgen_libclang.h |    2 +
 tools/include/linux/kallsyms.h               |    2 +-
 tools/lib/perf/include/perf/event.h          |    2 +-
 tools/lib/symbol/kallsyms.h                  |    2 +-
 89 files changed, 12548 insertions(+), 51 deletions(-)
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


base-commit: 3d7cb6b04c3f3115719235cc6866b10326de34cd
-- 
2.37.1


Return-Path: <linux-fsdevel+bounces-3361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB727F41E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 10:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3066828166B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 09:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C1654BF3;
	Wed, 22 Nov 2023 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mStM9wWa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2F4C150;
	Wed, 22 Nov 2023 09:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC91C433C8;
	Wed, 22 Nov 2023 09:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700646172;
	bh=uZKJnb2u5AhzIA9X+4vciaKQhiGepe0H1KhmYC0IwcM=;
	h=From:Subject:Date:To:Cc:From;
	b=mStM9wWacigBlUSqe09knkTbwekKMzDd5zJAEwJ6okaKsx9BYWSTZeYm1mA0ctn80
	 do5ZZnRGA+A+iEknxctJAzvLPa/DRWCUqpk6c2oxUzzkEaUrLkJVrHQ4+xxb6QS5YJ
	 4uoNjaQKaHEmv4AOhph3JDcrWRQXoTHiQfIBYMrq/57ktpVv+ZiICk3rNHq4D8quYM
	 g730KwgJzAdlCtKvVAAdDW4nN/QYy74l7CMcZxJv1Q05FaqEFmQqiT+cDKMNscEdVi
	 fvzJRNYMp/sTZyLS1sgjRhFSGULU/jh9nX0AHnC7Ns6HmiJpNBxqG8Sn6O7HR2unut
	 FsipsXCNO7IYg==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v7 00/39] arm64/gcs: Provide support for GCS in userspace
Date: Wed, 22 Nov 2023 09:42:10 +0000
Message-Id: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPLMXWUC/2XOy27DIBAF0F+JWJeKl3lk1f+ougBmsFEbO4LIa
 hX534tTqaWyWN0R587cScWSsZLz6U4KrrnmZW7BPJ1InPw8Is3QMhFMSNYe9eWiFR1jpSg594G
 BNcKR9j/4ijQUP8dpF7fLdZ9eC6b8+djw+tbylOttKV+PhSvfpz/dhuuue+WU0ZAGbZKTIXj98
 o5lxo/npYxkr1lFR4XqqWgUoogclIoCw4HKjkreU9loBEguOcvA2QNVf9Qy01PVqLYxedlOZto
 d6NBRIXo6NOowccsBtBTqQPUv5Yy5nupGjcVhAPReAfyj27Z9A7b2ig3gAQAA
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=13583; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uZKJnb2u5AhzIA9X+4vciaKQhiGepe0H1KhmYC0IwcM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlXcz28WpesSScy5xWudW7kzLCWricgXNONQStW
 f7tgXI1LMmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZV3M9gAKCRAk1otyXVSH
 0NVVB/4gBoYNSuY1Oh4rqqLmn82OjtifuZDINMmJzJMVu7YXri4UWGGRfvABh4KDE6oXaUnFcP4
 +iSBKs6Lxfo15ZuqoNw44g3MOvRTevQITaqq1JuV4oA19mbg9EqqFZCP1Ds48Pt9pFrbLVxo667
 dJQWLb56VjUXHkdWNrUnCydfHJqsHThYBfVM5WHrYBPY3M5mPndMKQ04B14S2Kz3WQe4ddI3RqT
 Ci3lTLCEkW6SGmBzZ5L8o5VfAWMrFlUmZBcttfnhONxFzobEW2qc7MY5UWrBGrN3gM6/MIW7nsu
 l7ZUax9ZhhO2CLxwTVWY4mISiESUqlc85R4lx+UbGjOPjMqF
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The arm64 Guarded Control Stack (GCS) feature provides support for
hardware protected stacks of return addresses, intended to provide
hardening against return oriented programming (ROP) attacks and to make
it easier to gather call stacks for applications such as profiling.

When GCS is active a secondary stack called the Guarded Control Stack is
maintained, protected with a memory attribute which means that it can
only be written with specific GCS operations.  The current GCS pointer
can not be directly written to by userspace.  When a BL is executed the
value stored in LR is also pushed onto the GCS, and when a RET is
executed the top of the GCS is popped and compared to LR with a fault
being raised if the values do not match.  GCS operations may only be
performed on GCS pages, a data abort is generated if they are not.

The combination of hardware enforcement and lack of extra instructions
in the function entry and exit paths should result in something which
has less overhead and is more difficult to attack than a purely software
implementation like clang's shadow stacks.

This series implements support for use of GCS by userspace, along with
support for use of GCS within KVM guests.  It does not enable use of GCS
by either EL1 or EL2, this will be implemented separately.  Executables
are started without GCS and must use a prctl() to enable it, it is
expected that this will be done very early in application execution by
the dynamic linker or other startup code.  For dynamic linking this will
be done by checking that everything in the executable is marked as GCS
compatible.

x86 has an equivalent feature called shadow stacks, this series depends
on the x86 patches for generic memory management support for the new
guarded/shadow stack page type and shares APIs as much as possible.  As
there has been extensive discussion with the wider community around the
ABI for shadow stacks I have as far as practical kept implementation
decisions close to those for x86, anticipating that review would lead to
similar conclusions in the absence of strong reasoning for divergence.

The main divergence I am concious of is that x86 allows shadow stack to
be enabled and disabled repeatedly, freeing the shadow stack for the
thread whenever disabled, while this implementation keeps the GCS
allocated after disable but refuses to reenable it.  This is to avoid
races with things actively walking the GCS during a disable, we do
anticipate that some systems will wish to disable GCS at runtime but are
not aware of any demand for subsequently reenabling it.

x86 uses an arch_prctl() to manage enable and disable, since only x86
and S/390 use arch_prctl() a generic prctl() was proposed[1] as part of a
patch set for the equivalent RISC-V Zicfiss feature which I initially
adopted fairly directly but following review feedback has been revised
quite a bit.

We currently maintain the x86 pattern of implicitly allocating a shadow
stack for threads started with shadow stack enabled, there has been some
discussion of removing this support and requiring the use of clone3()
with explicit allocation of shadow stacks instead.  I have no strong
feelings either way, implicit allocation is not really consistent with
anything else we do and creates the potential for errors around thread
exit but on the other hand it is existing ABI on x86 and minimises the
changes needed in userspace code.

There is an open issue with support for CRIU, on x86 this required the
ability to set the GCS mode via ptrace.  This series supports
configuring mode bits other than enable/disable via ptrace but it needs
to be confirmed if this is sufficient.

The series depends on support for shadow stacks in clone3(), that series
includes the addition of ARCH_HAS_USER_SHADOW_STACK.

   https://lore.kernel.org/r/20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org

It also depends on the addition of more waitpid() flags to nolibc:

   https://lore.kernel.org/r/20231023-nolibc-waitpid-flags-v2-1-b09d096f091f@kernel.org

You can see a branch with the full set of dependencies against Linus'
tree at:

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git arm64-gcs

[1] https://lore.kernel.org/lkml/20230213045351.3945824-1-debug@rivosinc.com/

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v7:
- Rebase onto v6.7-rc2 via the clone3() patch series.
- Change the token used to cap the stack during signal handling to be
  compatible with GCSPOPM.
- Fix flags for new page types.
- Fold in support for clone3().
- Replace copy_to_user_gcs() with put_user_gcs().
- Link to v6: https://lore.kernel.org/r/20231009-arm64-gcs-v6-0-78e55deaa4dd@kernel.org

Changes in v6:
- Rebase onto v6.6-rc3.
- Add some more gcsb_dsync() barriers following spec clarifications.
- Due to ongoing discussion around clone()/clone3() I've not updated
  anything there, the behaviour is the same as on previous versions.
- Link to v5: https://lore.kernel.org/r/20230822-arm64-gcs-v5-0-9ef181dd6324@kernel.org

Changes in v5:
- Don't map any permissions for user GCSs, we always use EL0 accessors
  or use a separate mapping of the page.
- Reduce the standard size of the GCS to RLIMIT_STACK/2.
- Enforce a PAGE_SIZE alignment requirement on map_shadow_stack().
- Clarifications and fixes to documentation.
- More tests.
- Link to v4: https://lore.kernel.org/r/20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org

Changes in v4:
- Implement flags for map_shadow_stack() allowing the cap and end of
  stack marker to be enabled independently or not at all.
- Relax size and alignment requirements for map_shadow_stack().
- Add more blurb explaining the advantages of hardware enforcement.
- Link to v3: https://lore.kernel.org/r/20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org

Changes in v3:
- Rebase onto v6.5-rc4.
- Add a GCS barrier on context switch.
- Add a GCS stress test.
- Link to v2: https://lore.kernel.org/r/20230724-arm64-gcs-v2-0-dc2c1d44c2eb@kernel.org

Changes in v2:
- Rebase onto v6.5-rc3.
- Rework prctl() interface to allow each bit to be locked independently.
- map_shadow_stack() now places the cap token based on the size
  requested by the caller not the actual space allocated.
- Mode changes other than enable via ptrace are now supported.
- Expand test coverage.
- Various smaller fixes and adjustments.
- Link to v1: https://lore.kernel.org/r/20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org

---
Mark Brown (39):
      arm64/mm: Restructure arch_validate_flags() for extensibility
      prctl: arch-agnostic prctl for shadow stack
      mman: Add map_shadow_stack() flags
      arm64: Document boot requirements for Guarded Control Stacks
      arm64/gcs: Document the ABI for Guarded Control Stacks
      arm64/sysreg: Add new system registers for GCS
      arm64/sysreg: Add definitions for architected GCS caps
      arm64/gcs: Add manual encodings of GCS instructions
      arm64/gcs: Provide put_user_gcs()
      arm64/cpufeature: Runtime detection of Guarded Control Stack (GCS)
      arm64/mm: Allocate PIE slots for EL0 guarded control stack
      mm: Define VM_SHADOW_STACK for arm64 when we support GCS
      arm64/mm: Map pages for guarded control stack
      KVM: arm64: Manage GCS registers for guests
      arm64/gcs: Allow GCS usage at EL0 and EL1
      arm64/idreg: Add overrride for GCS
      arm64/hwcap: Add hwcap for GCS
      arm64/traps: Handle GCS exceptions
      arm64/mm: Handle GCS data aborts
      arm64/gcs: Context switch GCS state for EL0
      arm64/gcs: Allocate a new GCS for threads with GCS enabled
      arm64/gcs: Implement shadow stack prctl() interface
      arm64/mm: Implement map_shadow_stack()
      arm64/signal: Set up and restore the GCS context for signal handlers
      arm64/signal: Expose GCS state in signal frames
      arm64/ptrace: Expose GCS via ptrace and core files
      arm64: Add Kconfig for Guarded Control Stack (GCS)
      kselftest/arm64: Verify the GCS hwcap
      kselftest/arm64: Add GCS as a detected feature in the signal tests
      kselftest/arm64: Add framework support for GCS to signal handling tests
      kselftest/arm64: Allow signals tests to specify an expected si_code
      kselftest/arm64: Always run signals tests with GCS enabled
      kselftest/arm64: Add very basic GCS test program
      kselftest/arm64: Add a GCS test program built with the system libc
      kselftest/arm64: Add test coverage for GCS mode locking
      selftests/arm64: Add GCS signal tests
      kselftest/arm64: Add a GCS stress test
      kselftest/arm64: Enable GCS for the FP stress tests
      kselftest/clone3: Enable GCS in the clone3 selftests

 Documentation/admin-guide/kernel-parameters.txt    |   6 +
 Documentation/arch/arm64/booting.rst               |  22 +
 Documentation/arch/arm64/elf_hwcaps.rst            |   3 +
 Documentation/arch/arm64/gcs.rst                   | 233 +++++++
 Documentation/arch/arm64/index.rst                 |   1 +
 Documentation/filesystems/proc.rst                 |   2 +-
 arch/arm64/Kconfig                                 |  20 +
 arch/arm64/include/asm/cpufeature.h                |   6 +
 arch/arm64/include/asm/el2_setup.h                 |  17 +
 arch/arm64/include/asm/esr.h                       |  28 +-
 arch/arm64/include/asm/exception.h                 |   2 +
 arch/arm64/include/asm/gcs.h                       | 107 +++
 arch/arm64/include/asm/hwcap.h                     |   1 +
 arch/arm64/include/asm/kvm_arm.h                   |   4 +-
 arch/arm64/include/asm/kvm_host.h                  |  12 +
 arch/arm64/include/asm/mman.h                      |  23 +-
 arch/arm64/include/asm/pgtable-prot.h              |  14 +-
 arch/arm64/include/asm/processor.h                 |   7 +
 arch/arm64/include/asm/sysreg.h                    |  20 +
 arch/arm64/include/asm/uaccess.h                   |  40 ++
 arch/arm64/include/uapi/asm/hwcap.h                |   1 +
 arch/arm64/include/uapi/asm/ptrace.h               |   8 +
 arch/arm64/include/uapi/asm/sigcontext.h           |   9 +
 arch/arm64/kernel/cpufeature.c                     |  19 +
 arch/arm64/kernel/cpuinfo.c                        |   1 +
 arch/arm64/kernel/entry-common.c                   |  23 +
 arch/arm64/kernel/idreg-override.c                 |   2 +
 arch/arm64/kernel/process.c                        |  81 +++
 arch/arm64/kernel/ptrace.c                         |  59 ++
 arch/arm64/kernel/signal.c                         | 236 ++++++-
 arch/arm64/kernel/traps.c                          |  11 +
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h         |  17 +
 arch/arm64/kvm/sys_regs.c                          |  22 +
 arch/arm64/mm/Makefile                             |   1 +
 arch/arm64/mm/fault.c                              |  79 ++-
 arch/arm64/mm/gcs.c                                | 259 +++++++
 arch/arm64/mm/mmap.c                               |  13 +-
 arch/arm64/tools/cpucaps                           |   1 +
 arch/arm64/tools/sysreg                            |  55 ++
 arch/x86/include/uapi/asm/mman.h                   |   3 -
 fs/proc/task_mmu.c                                 |   3 +
 include/linux/mm.h                                 |  16 +-
 include/uapi/asm-generic/mman.h                    |   4 +
 include/uapi/linux/elf.h                           |   1 +
 include/uapi/linux/prctl.h                         |  22 +
 kernel/sys.c                                       |  30 +
 tools/testing/selftests/arm64/Makefile             |   2 +-
 tools/testing/selftests/arm64/abi/hwcap.c          |  19 +
 tools/testing/selftests/arm64/fp/assembler.h       |  15 +
 tools/testing/selftests/arm64/fp/fpsimd-test.S     |   2 +
 tools/testing/selftests/arm64/fp/sve-test.S        |   2 +
 tools/testing/selftests/arm64/fp/za-test.S         |   2 +
 tools/testing/selftests/arm64/fp/zt-test.S         |   2 +
 tools/testing/selftests/arm64/gcs/.gitignore       |   5 +
 tools/testing/selftests/arm64/gcs/Makefile         |  24 +
 tools/testing/selftests/arm64/gcs/asm-offsets.h    |   0
 tools/testing/selftests/arm64/gcs/basic-gcs.c      | 428 ++++++++++++
 tools/testing/selftests/arm64/gcs/gcs-locking.c    | 200 ++++++
 .../selftests/arm64/gcs/gcs-stress-thread.S        | 311 +++++++++
 tools/testing/selftests/arm64/gcs/gcs-stress.c     | 532 +++++++++++++++
 tools/testing/selftests/arm64/gcs/gcs-util.h       | 100 +++
 tools/testing/selftests/arm64/gcs/libc-gcs.c       | 742 +++++++++++++++++++++
 tools/testing/selftests/arm64/signal/.gitignore    |   1 +
 .../testing/selftests/arm64/signal/test_signals.c  |  17 +-
 .../testing/selftests/arm64/signal/test_signals.h  |   6 +
 .../selftests/arm64/signal/test_signals_utils.c    |  32 +-
 .../selftests/arm64/signal/test_signals_utils.h    |  39 ++
 .../arm64/signal/testcases/gcs_exception_fault.c   |  59 ++
 .../selftests/arm64/signal/testcases/gcs_frame.c   |  78 +++
 .../arm64/signal/testcases/gcs_write_fault.c       |  67 ++
 .../selftests/arm64/signal/testcases/testcases.c   |   7 +
 .../selftests/arm64/signal/testcases/testcases.h   |   1 +
 tools/testing/selftests/clone3/clone3.c            |  37 +
 73 files changed, 4234 insertions(+), 40 deletions(-)
---
base-commit: 3d0134d322380292c055454d9633738733992d61
change-id: 20230303-arm64-gcs-e311ab0d8729

Best regards,
-- 
Mark Brown <broonie@kernel.org>



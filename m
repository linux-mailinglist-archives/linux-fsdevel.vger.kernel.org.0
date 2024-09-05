Return-Path: <linux-fsdevel+bounces-28745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9BD96DCD2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 16:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2121C22F10
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2150519E80F;
	Thu,  5 Sep 2024 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="WfzWC0uI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAD119E7D3;
	Thu,  5 Sep 2024 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548233; cv=none; b=XW+UWpeM6gHL2OSQJmXWsZIWCtpxDtosuh7Ay4JVvUEb1MO+9sT+h02OqMelqtiNpl7gcjU83bMZ814I9yfup2dMgdwo2g2uvwBojq7O6YJ71dtT2iqfjmFt7DkzJauu0Tu4kinp/sA+dq4atjOA8iqH8QtZISL/M3S44uaZlfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548233; c=relaxed/simple;
	bh=S6nSjvgrgeostwnVEtga16zxIZfik5+Z3rFWT7sLalI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OF3lL/j8LztsJOiTdEUbJzA6JT9uC1Q429AGy7dPppnRfcsbRXQHej2ZfsWrCCAZRM3COAalsripdHwdg4GLFwotMtxtk3by3815MR7EoUnU7pGAOBCME556AbZBm8VYFUluN0VZd5C1SR0dfQhavqz1YANGNTN85OFfz9Fa+dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=WfzWC0uI; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4X02Wk0R7Jz9sjG;
	Thu,  5 Sep 2024 16:57:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725548226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=theZEgnObKA5o5sa8iv8/5VUkQlNdUgbzqyzOWK7yC8=;
	b=WfzWC0uI7P1gv/cBAXBe6DUxyILtnG8Rw6T2tWiDn4ib8iCVuyj58PnigX32Nop0SPlA45
	8pFU6SieyP7o05N9Ai8qhZNOcKgNUJp5sWhgstNp62xDH+LXpCZ2kC0hHtIH0MqmgFCMw7
	5JveM5tm0GZ/Wj/4IpM12qCatx0hSv1RpDgA5uijf+EqoJf4pSYW3YwpagRTEAcm2mB+lp
	vO4ThklXM5uqS7u7/JzGWKuG1Puu4HjVxZEMunWsCZwqfQ/DK1th6pfbpbAwPXBfIb5IF5
	pbZmom6KJCPrv+bxUV0uwSYePsel5pwumdroQA7NQ1HrRRkRs/YDL6MOVnUxcA==
From: Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH RFC v2 00/10] extensible syscalls: CHECK_FIELDS to allow
 for easier feature detection
Date: Fri, 06 Sep 2024 00:56:32 +1000
Message-Id: <20240906-extensible-structs-check_fields-v2-0-0f46d2de9bad@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKDG2WYC/4XNQQrCMBAF0KvIrI2kaarGlSB4ALdSpKZTM1jbk
 omlpfTuhlzA5f8f/luA0RMynDYLeByJqe9iUNsNWFd1LxRUxwxKKi2PMhc4BeyYni0KDv5rAwv
 r0L4fDWFbs6j0AY222OxNBvFl8NjQlIQ73K4XKGPpiEPv56SOWZoSYKT6C4yZkKLQBZoca1SNO
 tt5cJXf2f4D5bquPw4Wv57UAAAA
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Florian Weimer <fweimer@redhat.com>, 
 Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, 
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=7270; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=S6nSjvgrgeostwnVEtga16zxIZfik5+Z3rFWT7sLalI=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaTdPLb5kvLOxoytZu0mtzlZ7affWXGK4xIL48Kq6twnl
 S0lTcVqHaUsDGJcDLJiiizb/DxDN81ffCX500o2mDmsTCBDGLg4BWAiBzcw/I+0PXTgd4RChfYU
 oTVxVTK1wj+D+3a+m++YsK5k6a9bm+8wMtxUeHu7wIapeoO1WgNLfq1FfnKQ9stOhl6DmT92Hd5
 eygEA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4X02Wk0R7Jz9sjG

This is something that I've been thinking about for a while. We had a
discussion at LPC 2020 about this[1] but the proposals suggested there
never materialised.

In short, it is quite difficult for userspace to detect the feature
capability of syscalls at runtime. This is something a lot of programs
want to do, but they are forced to create elaborate scenarios to try to
figure out if a feature is supported without causing damage to the
system. For the vast majority of cases, each individual feature also
needs to be tested individually (because syscall results are
all-or-nothing), so testing even a single syscall's feature set can
easily inflate the startup time of programs.

This patchset implements the fairly minimal design I proposed in this
talk[2] and in some old LKML threads (though I can't find the exact
references ATM). The general flow looks like:

 1. Userspace will indicate to the kernel that a syscall should a be
    no-op by setting the top bit of the extensible struct size argument.

    We will almost certainly never support exabyte sized structs, so the
    top bits are free for us to use as makeshift flag bits. This is
    preferable to using the per-syscall flag field inside the structure
    because seccomp can easily detect the bit in the flag and allow the
    probe or forcefully return -EEXTSYS_NOOP.

 2. The kernel will then fill the provided structure with every valid
    bit pattern that the current kernel understands.

    For flags or other bitflag-like fields, this is the set of valid
    flags or bits. For pointer fields or fields that take an arbitrary
    value, the field has every bit set (0xFF... to fill the field) to
    indicate that any value is valid in the field.

 3. The syscall then returns -EEXTSYS_NOOP which is an errno that will
    only ever be used for this purpose (so userspace can be sure that
    the request succeeded).

    On older kernels, the syscall will return a different error (usually
    -E2BIG or -EFAULT) and userspace can do their old-fashioned checks.

 4. Userspace can then check which flags and fields are supported by
    looking at the fields in the returned structure. Flags are checked
    by doing an AND with the flags field, and field support can checked
    by comparing to 0. In principle you could just AND the entire
    structure if you wanted to do this check generically without caring
    about the structure contents (this is what libraries might consider
    doing).

    Userspace can even find out the internal kernel structure size by
    passing a PAGE_SIZE buffer and seeing how many bytes are non-zero.

    As with copy_struct_from_user(), this is designed to be forward- and
    backwards- compatible.

This allows programas to get a one-shot understanding of what features a
syscall supports without having to do any elaborate setups or tricks to
detect support for destructive features. Flags can simply be ANDed to
check if they are in the supported set, and fields can just be checked
to see if they are non-zero.

This patchset is IMHO the simplest way we can add the ability to
introspect the feature set of extensible struct (copy_struct_from_user)
syscalls. It doesn't preclude the chance of a more generic mechanism
being added later.

The intended way of using this interface to get feature information
looks something like the following (imagine that openat2 has gained a
new field and a new flag in the future):

  static bool openat2_no_automount_supported;
  static bool openat2_cwd_fd_supported;

  int check_openat2_support(void)
  {
      int err;
      struct open_how how = {};

      err = openat2(AT_FDCWD, ".", &how, CHECK_FIELDS | sizeof(how));
      assert(err < 0);
      switch (errno) {
      case EFAULT: case E2BIG:
          /* Old kernel... */
          check_support_the_old_way();
          break;
      case EEXTSYS_NOOP:
          openat2_no_automount_supported = (how.flags & RESOLVE_NO_AUTOMOUNT);
          openat2_cwd_fd_supported = (how.cwd_fd != 0);
          break;
      }
  }

This series adds CHECK_FIELDS support for the following extensible
struct syscalls, as they are quite likely to grow flags in the near
future:

 * openat2
 * clone3
 * mount_setattr

[1]: https://lwn.net/Articles/830666/
[2]: https://youtu.be/ggD-eb3yPVs

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
Changes in v2:
- Add CHECK_FIELDS support to mount_setattr(2).
- Fix build failure on architectures with custom errno values.
- Rework selftests to use the tools/ uAPI headers rather than custom
  defining EEXTSYS_NOOP.
- Make sure we return -EINVAL and -E2BIG for invalid sizes even if
  CHECK_FIELDS is set, and add some tests for that.
- v1: <https://lore.kernel.org/r/20240902-extensible-structs-check_fields-v1-0-545e93ede2f2@cyphar.com>

---
Aleksa Sarai (10):
      uaccess: add copy_struct_to_user helper
      sched_getattr: port to copy_struct_to_user
      openat2: explicitly return -E2BIG for (usize > PAGE_SIZE)
      openat2: add CHECK_FIELDS flag to usize argument
      selftests: openat2: add 0xFF poisoned data after misaligned struct
      selftests: openat2: add CHECK_FIELDS selftests
      clone3: add CHECK_FIELDS flag to usize argument
      selftests: clone3: add CHECK_FIELDS selftests
      mount_setattr: add CHECK_FIELDS flag to usize argument
      selftests: mount_setattr: add CHECK_FIELDS selftest

 arch/alpha/include/uapi/asm/errno.h                |   3 +
 arch/mips/include/uapi/asm/errno.h                 |   3 +
 arch/parisc/include/uapi/asm/errno.h               |   3 +
 arch/sparc/include/uapi/asm/errno.h                |   3 +
 fs/namespace.c                                     |  17 ++
 fs/open.c                                          |  18 ++
 include/linux/uaccess.h                            |  98 ++++++++
 include/uapi/asm-generic/errno.h                   |   3 +
 include/uapi/linux/openat2.h                       |   2 +
 kernel/fork.c                                      |  30 ++-
 kernel/sched/syscalls.c                            |  42 +---
 tools/arch/alpha/include/uapi/asm/errno.h          |   3 +
 tools/arch/mips/include/uapi/asm/errno.h           |   3 +
 tools/arch/parisc/include/uapi/asm/errno.h         |   3 +
 tools/arch/sparc/include/uapi/asm/errno.h          |   3 +
 tools/include/uapi/asm-generic/errno.h             |   3 +
 tools/include/uapi/asm-generic/posix_types.h       | 101 ++++++++
 tools/testing/selftests/clone3/.gitignore          |   1 +
 tools/testing/selftests/clone3/Makefile            |   4 +-
 .../testing/selftests/clone3/clone3_check_fields.c | 264 +++++++++++++++++++++
 tools/testing/selftests/mount_setattr/Makefile     |   2 +-
 .../selftests/mount_setattr/mount_setattr_test.c   |  53 ++++-
 tools/testing/selftests/openat2/Makefile           |   2 +
 tools/testing/selftests/openat2/openat2_test.c     | 165 ++++++++++++-
 24 files changed, 778 insertions(+), 51 deletions(-)
---
base-commit: 431c1646e1f86b949fa3685efc50b660a364c2b6
change-id: 20240803-extensible-structs-check_fields-a47e94cef691

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>



Return-Path: <linux-fsdevel+bounces-28201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D18967FF4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 09:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DBAD2829DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 07:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EF81714DF;
	Mon,  2 Sep 2024 07:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="b4o+Uc/5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE1042AB9;
	Mon,  2 Sep 2024 07:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260830; cv=none; b=aNzRyiUjNsSYi8JBtANDFVBMHtWbeUpdfIeEdEQyQCi4Ixh5WUJbEWTUXiSkPtHlajSpLtECWxKzxnMsl9HunUDmfliZODEbPzJBZZnW7zXPuhMMD3dwDguh2wt+1dNt1lh3HberDZjywsqdvJKLHzCQBFINNF93VFhiVDJjDic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260830; c=relaxed/simple;
	bh=wYUxsHmnpJPTecO24huKy9OThyxTStua+g3hdbVKN90=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pvlVmqSTNW8mCXdVm7lYo2vQPV3jBfu1PN0lYgZMUbHYOU/geYLP6YYxaK8o9RjupU7+ZQ/63Z5TEbWu3zEuDeB12I+du/XaBHWl+zBg7X+PMbnXDlplUwKFjMPPWPYBwb2KlTiyf1y3RP9bPKwZFt4qeijXmZe8m9Gho/vcm40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=b4o+Uc/5; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Wy0Dd5scPz9ssD;
	Mon,  2 Sep 2024 09:06:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725260817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+BznJLruHI/J4pk3STyvw395RIO32Poy7czlvNCRZPI=;
	b=b4o+Uc/59W9+ZHRMTfbjkEFArsoeNwi7FpIa0pjI1jBxBnngL9yagBEXatZM8Bf+5Qwx5N
	Vf/F53CbRyasgV2EEX4bXcdB2VzJLniJGpSbNCX+JMWufkNgZjf4YSWYVwCa6DDlWaevlZ
	MnP46jqu2ct/8aUJ3B+CbxOFZE8CWkNPAALQy1VXAQpVCKbQxvFeZM/JQRZLLdxxUuntOe
	KRTBKmyRpRP+5so8GXJD9e+jKL5nDuqXYkzSlvH8xgXhmv7aKbyeDbtY2gIW0wl9IX5Q7I
	gpcs6m28JFCgD5meLzYmY0WYzIXwXjPh3/bxwLoi+zeBwIGL6W4NvCPm40/Uqw==
From: Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH RFC 0/8] extensible syscalls: CHECK_FIELDS to allow for
 easier feature detection
Date: Mon, 02 Sep 2024 17:06:22 +1000
Message-Id: <20240902-extensible-structs-check_fields-v1-0-545e93ede2f2@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO5j1WYC/x3NQQrCMBBG4auUWTuQ1qDWreAB3IpInf6xgyWVT
 JRC6d0NLr/NewsZksLoWC2U8FXTKRbUm4pk6OITrH0xNa7x7uC2jDkjmj5GsOX0kWwsA+R1D4q
 xN+78Hq0XhF1bU6m8E4LO/8OVLucT3db1B/Y9anV2AAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5632; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=wYUxsHmnpJPTecO24huKy9OThyxTStua+g3hdbVKN90=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaRdTWH2d7lzobf327Ynuw7Jh6WvPvg9pS7u57HFZ1Pnv
 /Nbdj3HqaOUhUGMi0FWTJFlm59n6Kb5i68kf1rJBjOHlQlkCAMXpwBMZOYchn/W3SuNDxtqXAl5
 ajld8Lu87HsRL5tA2ROat2vsE/t4sz8x/JVLCetKkBcJ3RY85dhvBePnU8+tOVv66H1EjSvX9cM
 HT3MDAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4Wy0Dd5scPz9ssD

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

[1]: https://lwn.net/Articles/830666/
[2]: https://youtu.be/ggD-eb3yPVs

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
Aleksa Sarai (8):
      uaccess: add copy_struct_to_user helper
      sched_getattr: port to copy_struct_to_user
      openat2: explicitly return -E2BIG for (usize > PAGE_SIZE)
      openat2: add CHECK_FIELDS flag to usize argument
      clone3: add CHECK_FIELDS flag to usize argument
      selftests: openat2: add 0xFF poisoned data after misaligned struct
      selftests: openat2: add CHECK_FIELDS selftests
      selftests: clone3: add CHECK_FIELDS selftests

 fs/open.c                                          |  17 ++
 include/linux/uaccess.h                            |  98 +++++++++
 include/uapi/asm-generic/errno.h                   |   3 +
 include/uapi/linux/openat2.h                       |   2 +
 kernel/fork.c                                      |  33 ++-
 kernel/sched/syscalls.c                            |  42 +---
 tools/testing/selftests/clone3/.gitignore          |   1 +
 tools/testing/selftests/clone3/Makefile            |   2 +-
 .../testing/selftests/clone3/clone3_check_fields.c | 229 +++++++++++++++++++++
 tools/testing/selftests/openat2/openat2_test.c     | 126 +++++++++++-
 10 files changed, 504 insertions(+), 49 deletions(-)
---
base-commit: 431c1646e1f86b949fa3685efc50b660a364c2b6
change-id: 20240803-extensible-structs-check_fields-a47e94cef691

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>



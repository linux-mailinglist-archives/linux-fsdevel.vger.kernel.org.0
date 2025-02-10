Return-Path: <linux-fsdevel+bounces-41356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F84A2E379
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 06:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E793A70D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 05:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE2918C02E;
	Mon, 10 Feb 2025 05:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="ezlx/bof";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L0uzefjL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094C68C0B;
	Mon, 10 Feb 2025 05:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739164881; cv=none; b=QVHQFX8FfKf7LyCWTxxIeAsylNDK60MWev75iD9PEs2wHd4iw7fHDq2y+5LccjM2oKNM5tZ7MUaRlTkbwiz87stsvS05SN297XfWXXY3kDbgKPiU/ycJQxUt18LyJy8SULdNc22RE1ASVzhXoSiKKziwoiDeWudUMnkE4q2JBBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739164881; c=relaxed/simple;
	bh=TzMgsbvZ6+sBCxjBhN5UONVpgMPMHtWJ2dots8VScRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HiTxCu35yBh4JqZhDfRscuT3wB6Veg+NKUfL2Awya9ABukbt4ezA55J3aYt0wuNpjyZ8cW8J5DlNUt2vWJgDQ8Ma4oTq2LcI2WFTZHEMDDhZn4p2nQbCPG8KH/uDU+uatMKgB6pyoU5p2y30IBrhMLLbzIMOw41qd1NFLQmTbQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=ezlx/bof; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L0uzefjL; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D75051140098;
	Mon, 10 Feb 2025 00:21:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 10 Feb 2025 00:21:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1739164875; x=1739251275; bh=uya3ZpZPbP
	gjNOMGj29GAxIPA/3MF/KjPyed0CxCys0=; b=ezlx/bofGhx+133Gyn4KZU3sd4
	s52Po6oFjcWxI6uzzb6gpH/GwFRHO5jyV4HDhTKX4FNPgUFDRzulsrTZ19VhuSKF
	y46oGPmTCTajaMIH1qUT5eNOTeZMXvCAaOjozlhTeO2+ctIDuPMp1O8l9RokI9k7
	sSo/wexG22MVNydn7ZrtKWzVLGb0UrsgFsC5CPqPyD32sE+UsdsXGF1kJNde0uDj
	labbUc24pOwMXAufMwmPL3CdfmHc/DCcicCkAIzQGhSvDXnpqfHsaxTY8F++UWm2
	CWUg//ZnobGgoEIIeLQVyFCZDkBp88bKk2OUd2d+0mjm66KU23DNFSgVFuzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739164875; x=1739251275; bh=uya3ZpZPbPgjNOMGj29GAxIPA/3MF/KjPye
	d0CxCys0=; b=L0uzefjLIjEmLb91gV2DzFzTAQXJ43lVY84UzB/xCa8LfCV1Jke
	wD06qd6yJP6snWssX6jRv7ib6dtjAmSXxlX4kLECqe7SzAnRcDJgwSZzcRrV55hm
	fxw0Jd5Yok/4AsoN5r505XJvTTmtewZeeiMsBUONCKDhR3XkXg5RxW/e9rP5VCeP
	T8JJ0ZsanYeaHOaXGyLQOGfOTr2YFgPG2blrIObwRWKQR2V/KoSW7lSj5PS8eNwa
	QuHY6jxcXvUbyE/WjVTy2sexIsFSGt62Ep+iP9yso8kGMPSPkGUkEhprw1CtfxGV
	fNxP+REB8K9JR0rnTmKpnfj8Uec59QmhHrw==
X-ME-Sender: <xms:y4ypZ4CeQYXoGOZtfkclJ1DMLpM4rLFGvA9FqFLW8kk5r-6U3L1ymQ>
    <xme:y4ypZ6iYTRdJuSN40tWeZ34LDhR8reLMjkCo9yMMATA_TIC_dcBM1_a55UxxSyUcS
    vti_2i9Tdlr5MwsvPc>
X-ME-Received: <xmr:y4ypZ7lHcQXOsboVqisB07RksP36ISyuknxNY28uyknH0Bk0r8i0i5yp66Q7Jwi2xYblmnGXIVOzzKgrNXgYeffRhhbQjjp9wQKZsVjIjcAUvWs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefjedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpeffrghvihguucftvggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrhdrtg
    homheqnecuggftrfgrthhtvghrnhepheetveetgfdvffehfeffieeugeejhfevieejveei
    vdeuiefgvdduueffhfefveehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesuggrvhhi
    ughrvggrvhgvrhdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhr
    ghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepug
    grkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesuggrvhhiughrvggrvhgv
    rhdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtg
    hpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhho
    seiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehlihhnuhigqdhfsh
    guvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghotggtihes
    ihhnrhhirgdrfhhr
X-ME-Proxy: <xmx:y4ypZ-wrG-nAWRiHb-RXw4dPnExMDveZdrF2D39YaVWx4Dxkebu1OA>
    <xmx:y4ypZ9R_2wtJM9nZ71OVYhppxWSQrfDz7T6rJE7QsmO1R5WWGXM5kw>
    <xmx:y4ypZ5aBpHGe1t3aGSJ4lcMtueCo6g9MrjTrepURcIXn1AHWbtzn-w>
    <xmx:y4ypZ2SCXSwG5HYUmLUw_z7vuYLoX35oPzo4qG94UQ-toL-hlg2Lbg>
    <xmx:y4ypZyKvMbbaekeOOJXfTmXa7tPNGcaGCoDS6_jzJxvyqOgWcpVh3s78>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 00:21:13 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: David Reaver <me@davidreaver.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/6] debugfs: Replace dentry with an opaque handle in debugfs API
Date: Sun,  9 Feb 2025 21:20:20 -0800
Message-ID: <20250210052039.144513-1-me@davidreaver.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Overview
========

This patch series replaces raw dentry pointers in the debugfs API with
an opaque wrapper struct:

	struct debugfs_node {
		struct dentry dentry;
	};

Intermediate commits rely on "#define debugfs_node dentry" to migrate
debugfs users without breaking the build. The final commit introduces
the struct and updates debugfs internals accordingly.

Why an RFC?
===========

This is a large change, and I expect a few iterations -- unless this
entire approach is NACKed of course :) Any advice is appreciated, and
I'm particularly looking for feedback on the following:

1. This change touches over 1100 files. Is that okay? I've been told it
   is because the patch series does "one thing", but it is a lot of
   files to touch across many systems.

2. The trickiest part of this migration is ensuring a declaration for
   struct debugfs_node is in scope so we don't get errors that it is
   being implicitly defined, especially as different kernel
   configurations change which headers are transitively included. See
   "#includes and #defines" below. I'm open to any other migration
   strategies.

3. This change is mostly automated with Coccinelle, but I'm really
   contorting Coccinelle to replace dentry with debugfs_node in
   different kinds of declarations. Any Coccinelle advice would be
   appreciated.

Purpose/Background
==================

debugfs currently relies on dentry to represent its filesystem
hierarchy, and its API directly exposes dentry pointers to users. This
tight coupling makes it difficult to modify debugfs internals. A dentry
and inode should exist only when needed, rather than being persistently
tied to debugfs. Some kernel developers have proposed using an opaque
handle for debugfs nodes instead of dentry pointers [1][2][3].

Replacing dentry with debugfs_node simplifies future migrations away
from dentry. Additionally, a declaration with debugfs_node is more
self-explanatory -- its purpose is immediately clear, unlike dentry,
which requires further context to understand its role as a debugfs
dentry.

About this patch series
=======================

This series makes the following changes:

1. Add a temporary "#define debugfs_node dentry".
2. Introduce debugfs helper functions used by Coccinelle rules.
3. Update relay to use debugfs_node instead of dentry.
4. Use Coccinelle to convert most of the kernel to debugfs_node.
5. Apply manual fixes for cases Coccinelle missed.
6. Remove the #define and introduce struct debugfs_node.

The #define is placed in both debugfs.h and dcache.h to avoid
unnecessary #include <linux/debugfs.h> additions or forward declarations
that would be removed in the final commit.

Most changes outside of fs/debugfs/ were mechanical and handled by
Coccinelle. Manual fixes were needed in cases where Coccinelle couldn't
fully convert the code, like dentry declarations nested in layers of
headers or function calls, code inside macros, etc.

The changes to fs/debugfs/ are straightforward, swapping dentry with
debugfs_node in the API where appropriate. Internal functions convert
between the two as needed. I introduced a few trivial helper functions
for specific debugfs users. Thanks to Al Viro's recent refactoring,
parts of this change were simpler to implement.

Relay changes
=============

The most non-obvious change is in the relay system. While the relay
documentation suggests support for non-debugfs users, in practice all
relay users rely on debugfs. I updated relay to use debugfs_node and
revised the documentation.

Coccinelle
==========

I wrote a Coccinelle script to automate most of the conversion. The
script is inlined at the bottom of the commit message where it was run.
This is my first time using Coccinelle, so any feedback is welcome!

The script does the following:

- Find all dentry identifiers that are arguments to or return values of
  a debugfs_* function. This step detects both debugfs.h functions and
  various wrapper functions defined outside of debugfs proper.

- Update relevant declarations and function signatures to use
  debugfs_node instead of dentry.

- Perform further fixups where appropriate. For example, replace
  d_inode() or ->d_inode with debugfs_node_inode().

Challenges I encountered:

- Running a single spatch invocation over the whole tree produces
  inconsistent results because of how header diffs are resolved. spatch
  can take different paths to resolve a header file, sometimes resulting
  in different -- sometimes conflicting -- patch hunks. I avoided this
  problem by writing a bash script that runs spatch against any files
  containing "dentry" or "debugfs", one-by-one.

- The script is more verbose than I would like. I started small but had
  to break out cases and duplicate rules for clarity and reliability.

I focused on handling the most common cases rather than covering every
edge case, balancing script complexity with effectiveness. The script
performs pretty well -- most of this patch set was generated from it.
All clever attempts I made to add new rules resulted in needing more
manual fixups.

#includes and #defines
======================

struct dentry is implicitly defined, transitively included (usually
through <linux/fs.h>), or defined with a forward declaration in much of
the files affected by this patch series. Usually <linux/debugfs.h> is
_not_ included in those same files. For the intermediate commits, we
need to ensure the #define is in scope wherever debugfs_node is used so
it isn't considered a forward declaration of a distinct type.
Automatically ensuring the #define and/or a debugfs.h include is in
scope is difficult.

I found one heuristic that was easy to automate and mostly does the job:
in files we modify, wherever there is a forward declaration of "struct
dentry;", temporarily add a "#define debugfs_node" right below it. The
Coccinelle script implements this heuristic. The final commit removes
these #defines and replaces the dentry declaration with debugfs_node.

Suggestions for solving this problem without peppering #defines in an
intermediate commit is welcome. I'm still not totally confident that
_some_ kernel configuration won't break because an #include is missing.

I originally had this entire patch series reversed, where we immediately
define struct debugfs_node without an intermediate #define, but the
whole migration has to be done in a single commit for that to work. This
approach suffers from similar issues about debugfs_node being in scope
to avoid implicit declaration errors.

Testing
=======

My primary form of testing was compiling without errors. This was tested
by building every commit in this series on an x86_64 machine with
allmodconfig, as well as cross-compiling to s390, arm, and powerpc64. I
also loaded a more minimal kernel into QEMU and ran:

  find /sys/kernel/debug -type f -exec stat {} +

To catch any missed instances of dentry declarations related to debugfs,
I ran the following ripgrep command and reviewed its output to ensure I
didn't miss anything obvious:

  rg 'struct dentry \*.*(debug|dbg)|(debug|dbg).*struct dentry \*' \
    -g '*.{c,h}' -g '!fs/debugfs' -g '!include/linux/debugfs.h'

Links
=====

Link: https://lore.kernel.org/all/2024012600-dose-happiest-f57d@gregkh/ [1]
Link: https://lore.kernel.org/all/20240125104822.04a5ad44@gandalf.local.home/ [2]
Link: https://lore.kernel.org/all/20250128102744.1b94a789@gandalf.local.home/ [3]

David Reaver (6):
  debugfs: Add temporary "#define debugfs_node dentry" directives
  debugfs: Add helper functions for debugfs_node encapsulation
  relay: Replace dentry with debugfs_node
  debugfs: Automated conversion from dentry to debugfs_node
  debugfs: Manual fixes for incomplete Coccinelle conversions
  debugfs: Replace debugfs_node #define with struct wrapping dentry

 Documentation/filesystems/relay.rst           |  32 ++-
 arch/arm/mach-omap1/pm.c                      |   2 +-
 arch/arm/mach-omap2/pm-debug.c                |   6 +-
 arch/loongarch/kernel/kdebugfs.c              |   2 +-
 arch/microblaze/include/asm/processor.h       |   2 +-
 arch/microblaze/kernel/setup.c                |   2 +-
 arch/mips/cavium-octeon/oct_ilm.c             |   2 +-
 arch/mips/include/asm/debug.h                 |   2 +-
 arch/mips/kernel/setup.c                      |   2 +-
 arch/mips/math-emu/me-debugfs.c               |   4 +-
 arch/mips/mm/sc-debugfs.c                     |   2 +-
 arch/powerpc/include/asm/kvm_ppc.h            |   2 +-
 arch/powerpc/include/asm/vas.h                |   2 +-
 arch/powerpc/kernel/iommu.c                   |   4 +-
 arch/powerpc/kernel/kdebugfs.c                |   2 +-
 arch/powerpc/kernel/traps.c                   |   2 +-
 arch/powerpc/kvm/book3s_hv.c                  |   6 +-
 arch/powerpc/kvm/book3s_xics.h                |   2 +-
 arch/powerpc/kvm/book3s_xive.h                |   2 +-
 arch/powerpc/kvm/powerpc.c                    |   3 +-
 arch/powerpc/kvm/timing.c                     |   2 +-
 arch/powerpc/kvm/timing.h                     |   4 +-
 arch/powerpc/platforms/powernv/memtrace.c     |   6 +-
 arch/powerpc/platforms/powernv/opal-imc.c     |   4 +-
 arch/powerpc/platforms/powernv/opal-lpc.c     |   4 +-
 arch/powerpc/platforms/powernv/opal-xscom.c   |   7 +-
 arch/powerpc/platforms/powernv/pci.h          |   2 +-
 arch/powerpc/platforms/powernv/vas-debug.c    |   6 +-
 arch/powerpc/platforms/powernv/vas.h          |   2 +-
 arch/powerpc/platforms/pseries/dtl.c          |   2 +-
 arch/powerpc/platforms/pseries/hvCall_inst.c  |   2 +-
 arch/powerpc/platforms/pseries/lpar.c         |   2 +-
 arch/powerpc/sysdev/xive/common.c             |   4 +-
 arch/powerpc/sysdev/xive/native.c             |   2 +-
 arch/powerpc/sysdev/xive/xive-internal.h      |   2 +-
 arch/s390/hypfs/hypfs.h                       |   2 +-
 arch/s390/hypfs/hypfs_dbfs.c                  |   2 +-
 arch/s390/include/asm/debug.h                 |   4 +-
 arch/s390/include/asm/pci.h                   |   2 +-
 arch/s390/kernel/debug.c                      |  12 +-
 arch/s390/kernel/hiperdispatch.c              |   2 +-
 arch/s390/kernel/kdebugfs.c                   |   2 +-
 arch/s390/kernel/sysinfo.c                    |   2 +-
 arch/s390/kernel/wti.c                        |   2 +-
 arch/s390/pci/pci_debug.c                     |   2 +-
 arch/sh/kernel/kdebugfs.c                     |   2 +-
 arch/x86/kernel/callthunks.c                  |   2 +-
 arch/x86/kernel/cpu/debugfs.c                 |   2 +-
 arch/x86/kernel/cpu/mce/core.c                |   6 +-
 arch/x86/kernel/cpu/mce/inject.c              |   2 +-
 arch/x86/kernel/cpu/mce/internal.h            |   2 +-
 arch/x86/kernel/cpu/mce/severity.c            |   2 +-
 arch/x86/kernel/cpu/resctrl/internal.h        |   4 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        |   2 +-
 arch/x86/kernel/itmt.c                        |   2 +-
 arch/x86/kernel/kdebugfs.c                    |  12 +-
 arch/x86/kvm/debugfs.c                        |   3 +-
 arch/x86/mm/debug_pagetables.c                |   2 +-
 arch/x86/platform/atom/punit_atom_debug.c     |   2 +-
 arch/x86/platform/intel/iosf_mbi.c            |   2 +-
 arch/x86/xen/debugfs.c                        |   4 +-
 arch/x86/xen/p2m.c                            |   4 +-
 arch/x86/xen/xen-ops.h                        |   2 +-
 block/blk-core.c                              |   4 +-
 block/blk-mq-debugfs.c                        |   6 +-
 block/blk-rq-qos.h                            |   2 +-
 block/blk-timeout.c                           |   2 +-
 block/blk.h                                   |   2 +-
 crypto/jitterentropy-testing.c                |   2 +-
 drivers/accel/drm_accel.c                     |   2 +-
 drivers/accel/habanalabs/common/debugfs.c     |   5 +-
 drivers/accel/habanalabs/common/habanalabs.h  |   2 +-
 drivers/accel/ivpu/ivpu_debugfs.c             |   2 +-
 drivers/accel/qaic/qaic_debugfs.c             |   4 +-
 drivers/acpi/acpi_dbg.c                       |   2 +-
 drivers/acpi/apei/apei-base.c                 |   4 +-
 drivers/acpi/apei/apei-internal.h             |   3 +-
 drivers/acpi/apei/einj-core.c                 |   2 +-
 drivers/acpi/debugfs.c                        |   2 +-
 drivers/acpi/ec_sys.c                         |   4 +-
 drivers/acpi/internal.h                       |   2 +-
 drivers/android/binder.c                      |   4 +-
 drivers/android/binder_internal.h             |   2 +-
 drivers/base/component.c                      |   2 +-
 drivers/base/regmap/internal.h                |   2 +-
 drivers/base/regmap/regmap-debugfs.c          |   2 +-
 drivers/block/aoe/aoe.h                       |   2 +-
 drivers/block/aoe/aoeblk.c                    |   2 +-
 drivers/block/brd.c                           |   2 +-
 drivers/block/drbd/drbd_debugfs.c             |  26 +-
 drivers/block/drbd/drbd_int.h                 |  30 +--
 drivers/block/mtip32xx/mtip32xx.c             |   2 +-
 drivers/block/mtip32xx/mtip32xx.h             |   2 +-
 drivers/block/nbd.c                           |   8 +-
 drivers/block/pktcdvd.c                       |   2 +-
 drivers/block/zram/zram_drv.c                 |   2 +-
 drivers/block/zram/zram_drv.h                 |   2 +-
 drivers/bluetooth/btmrvl_debugfs.c            |   4 +-
 drivers/bluetooth/hci_qca.c                   |   2 +-
 drivers/bus/mhi/host/debugfs.c                |   2 +-
 drivers/bus/moxtet.c                          |   2 +-
 drivers/bus/mvebu-mbus.c                      |   6 +-
 drivers/cache/sifive_ccache.c                 |   2 +-
 drivers/cdx/cdx.c                             |   2 +-
 drivers/char/virtio_console.c                 |   4 +-
 drivers/clk/baikal-t1/ccu-div.c               |  12 +-
 drivers/clk/baikal-t1/ccu-pll.c               |   2 +-
 drivers/clk/bcm/clk-bcm2835.c                 |   8 +-
 drivers/clk/clk-fractional-divider.c          |   2 +-
 drivers/clk/clk.c                             |   9 +-
 drivers/clk/davinci/pll.c                     |   5 +-
 .../clk/starfive/clk-starfive-jh7110-pll.c    |   3 +-
 drivers/clk/starfive/clk-starfive-jh71x0.c    |   3 +-
 drivers/clk/tegra/clk-dfll.c                  |   4 +-
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h  |   4 +-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c |   4 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  |   4 +-
 .../crypto/allwinner/sun8i-ss/sun8i-ss-core.c |   4 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h  |   4 +-
 drivers/crypto/amlogic/amlogic-gxl-core.c     |   2 +-
 drivers/crypto/amlogic/amlogic-gxl.h          |   2 +-
 drivers/crypto/axis/artpec6_crypto.c          |   2 +-
 drivers/crypto/bcm/cipher.h                   |   4 +-
 drivers/crypto/caam/caamalg_qi2.h             |   2 +-
 drivers/crypto/caam/ctrl.c                    |   2 +-
 drivers/crypto/caam/debugfs.c                 |   2 +-
 drivers/crypto/caam/debugfs.h                 |   6 +-
 drivers/crypto/caam/intern.h                  |   2 +-
 drivers/crypto/cavium/nitrox/nitrox_debugfs.c |   2 +-
 drivers/crypto/cavium/nitrox/nitrox_dev.h     |   2 +-
 drivers/crypto/cavium/zip/zip_main.c          |   2 +-
 drivers/crypto/ccp/ccp-debugfs.c              |   4 +-
 drivers/crypto/ccp/ccp-dev.h                  |   2 +-
 drivers/crypto/ccree/cc_debugfs.c             |   2 +-
 drivers/crypto/ccree/cc_driver.h              |   2 +-
 drivers/crypto/gemini/sl3516-ce-core.c        |   4 +-
 drivers/crypto/gemini/sl3516-ce.h             |   4 +-
 drivers/crypto/hisilicon/debugfs.c            |   5 +-
 drivers/crypto/hisilicon/hpre/hpre_main.c     |  11 +-
 drivers/crypto/hisilicon/sec2/sec_main.c      |   4 +-
 drivers/crypto/hisilicon/zip/zip_main.c       |   6 +-
 drivers/crypto/intel/iaa/iaa_crypto_stats.c   |   2 +-
 .../intel/qat/qat_common/adf_accel_devices.h  |   8 +-
 drivers/crypto/intel/qat/qat_common/adf_cfg.h |   2 +-
 .../intel/qat/qat_common/adf_heartbeat.h      |  13 +-
 .../qat/qat_common/adf_heartbeat_dbgfs.c      |   2 +-
 .../intel/qat/qat_common/adf_telemetry.h      |   3 +-
 .../intel/qat/qat_common/adf_tl_debugfs.c     |   6 +-
 .../qat/qat_common/adf_transport_debug.c      |   2 +-
 .../qat/qat_common/adf_transport_internal.h   |   8 +-
 drivers/crypto/nx/nx.h                        |   2 +-
 drivers/crypto/nx/nx_debugfs.c                |   2 +-
 drivers/crypto/rockchip/rk3288_crypto.c       |   4 +-
 drivers/crypto/rockchip/rk3288_crypto.h       |   4 +-
 drivers/cxl/core/core.h                       |   2 +-
 drivers/cxl/core/mbox.c                       |   2 +-
 drivers/cxl/core/port.c                       |   6 +-
 drivers/cxl/cxlmem.h                          |   2 +-
 drivers/cxl/mem.c                             |  12 +-
 drivers/devfreq/devfreq.c                     |   2 +-
 drivers/dma-buf/dma-buf.c                     |   4 +-
 drivers/dma-buf/sync_debug.c                  |   2 +-
 drivers/dma/amd/ptdma/ptdma-debugfs.c         |   2 +-
 drivers/dma/bcm-sba-raid.c                    |   2 +-
 drivers/dma/dmaengine.c                       |   2 +-
 drivers/dma/dmaengine.h                       |   5 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  15 +-
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c      |  17 +-
 drivers/dma/hisi_dma.c                        |   2 +-
 drivers/dma/idxd/debugfs.c                    |   2 +-
 drivers/dma/idxd/idxd.h                       |   4 +-
 drivers/dma/pxa_dma.c                         |  11 +-
 drivers/dma/qcom/hidma.h                      |   2 +-
 drivers/dma/qcom/hidma_dbg.c                  |   2 +-
 drivers/dma/xilinx/xilinx_dpdma.c             |   2 +-
 drivers/edac/altera_edac.h                    |   2 +-
 drivers/edac/armada_xp_edac.c                 |   2 +-
 drivers/edac/debugfs.c                        |  21 +-
 drivers/edac/edac_module.h                    |  36 +--
 drivers/edac/i5100_edac.c                     |   4 +-
 drivers/edac/igen6_edac.c                     |   2 +-
 drivers/edac/npcm_edac.c                      |   2 +-
 drivers/edac/pnd2_edac.c                      |   2 +-
 drivers/edac/skx_common.c                     |   2 +-
 drivers/edac/thunderx_edac.c                  |   8 +-
 drivers/edac/versal_edac.c                    |   2 +-
 drivers/edac/xgene_edac.c                     |   6 +-
 drivers/edac/zynqmp_edac.c                    |   2 +-
 drivers/extcon/extcon-rtk-type-c.c            |   2 +-
 drivers/firmware/arm_scmi/driver.c            |  14 +-
 drivers/firmware/arm_scmi/raw_mode.c          |   8 +-
 drivers/firmware/arm_scmi/raw_mode.h          |   2 +-
 drivers/firmware/cirrus/cs_dsp.c              |   8 +-
 drivers/firmware/efi/efi.c                    |   2 +-
 drivers/firmware/tegra/bpmp-debugfs.c         |  10 +-
 drivers/firmware/ti_sci.c                     |   2 +-
 drivers/firmware/turris-mox-rwtm.c            |   2 +-
 drivers/firmware/xilinx/zynqmp-debug.c        |   2 +-
 drivers/gpio/gpio-mockup.c                    |   4 +-
 drivers/gpio/gpio-sloppy-logic-analyzer.c     |   6 +-
 drivers/gpio/gpio-virtuser.c                  |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c       |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h       |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c       |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h       |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c      |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   8 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |   2 +-
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |   2 +-
 drivers/gpu/drm/bridge/ite-it6505.c           |   2 +-
 drivers/gpu/drm/bridge/panel.c                |   2 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c |   2 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c         |   2 +-
 .../gpu/drm/display/drm_bridge_connector.c    |   2 +-
 drivers/gpu/drm/drm_debugfs.c                 |  32 +--
 drivers/gpu/drm/drm_debugfs_crc.c             |   2 +-
 drivers/gpu/drm/drm_drv.c                     |   2 +-
 drivers/gpu/drm/drm_internal.h                |   5 +-
 drivers/gpu/drm/i915/display/intel_alpm.c     |   2 +-
 .../drm/i915/display/intel_display_debugfs.c  |   4 +-
 .../display/intel_display_debugfs_params.c    |  10 +-
 .../drm/i915/display/intel_dp_link_training.c |   2 +-
 drivers/gpu/drm/i915/display/intel_fbc.c      |   2 +-
 drivers/gpu/drm/i915/display/intel_pps.c      |   2 +-
 drivers/gpu/drm/i915/display/intel_psr.c      |   2 +-
 drivers/gpu/drm/i915/gt/intel_gt_debugfs.c    |   7 +-
 drivers/gpu/drm/i915/gt/intel_gt_debugfs.h    |   3 +-
 .../drm/i915/gt/intel_gt_engines_debugfs.c    |   3 +-
 .../drm/i915/gt/intel_gt_engines_debugfs.h    |   4 +-
 drivers/gpu/drm/i915/gt/intel_gt_pm_debugfs.c |   3 +-
 drivers/gpu/drm/i915/gt/intel_gt_pm_debugfs.h |   4 +-
 drivers/gpu/drm/i915/gt/intel_sseu_debugfs.c  |   3 +-
 drivers/gpu/drm/i915/gt/intel_sseu_debugfs.h  |   4 +-
 .../gpu/drm/i915/gt/uc/intel_gsc_uc_debugfs.c |   3 +-
 .../gpu/drm/i915/gt/uc/intel_gsc_uc_debugfs.h |   4 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.h        |   2 +-
 .../gpu/drm/i915/gt/uc/intel_guc_debugfs.c    |   3 +-
 .../gpu/drm/i915/gt/uc/intel_guc_debugfs.h    |   4 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_log.c    |   8 +-
 .../drm/i915/gt/uc/intel_guc_log_debugfs.c    |   2 +-
 .../drm/i915/gt/uc/intel_guc_log_debugfs.h    |   3 +-
 .../gpu/drm/i915/gt/uc/intel_huc_debugfs.c    |   3 +-
 .../gpu/drm/i915/gt/uc/intel_huc_debugfs.h    |   4 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_debugfs.c |   5 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_debugfs.h |   4 +-
 drivers/gpu/drm/i915/gvt/gvt.h                |   4 +-
 drivers/gpu/drm/i915/i915_debugfs_params.c    |  16 +-
 drivers/gpu/drm/i915/i915_debugfs_params.h    |   3 +-
 drivers/gpu/drm/i915/pxp/intel_pxp_debugfs.c  |   2 +-
 drivers/gpu/drm/imagination/pvr_debugfs.c     |   4 +-
 drivers/gpu/drm/imagination/pvr_debugfs.h     |   1 +
 drivers/gpu/drm/imagination/pvr_fw_trace.c    |   3 +-
 drivers/gpu/drm/imagination/pvr_fw_trace.h    |   4 +-
 drivers/gpu/drm/imagination/pvr_params.c      |   2 +-
 drivers/gpu/drm/imagination/pvr_params.h      |   4 +-
 drivers/gpu/drm/loongson/lsdc_output_7a2000.c |   4 +-
 drivers/gpu/drm/loongson/lsdc_ttm.c           |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.h  |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c |   5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h |   3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |   3 +-
 .../gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c   |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h   |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |  11 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c      |   5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h      |   3 +-
 drivers/gpu/drm/msm/dp/dp_debug.c             |   2 +-
 drivers/gpu/drm/msm/dp/dp_debug.h             |   4 +-
 drivers/gpu/drm/msm/dp/dp_display.c           |   3 +-
 drivers/gpu/drm/msm/dp/dp_display.h           |   3 +-
 drivers/gpu/drm/msm/dp/dp_drm.c               |   6 +-
 drivers/gpu/drm/msm/msm_debugfs.c             |   2 +-
 drivers/gpu/drm/nouveau/dispnv50/crc.c        |   2 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/gsp.h |  10 +-
 drivers/gpu/drm/nouveau/nouveau_debugfs.c     |   6 +-
 drivers/gpu/drm/nouveau/nouveau_debugfs.h     |   2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c         |   2 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/r535.c    |  24 +-
 drivers/gpu/drm/omapdrm/dss/dss.c             |   4 +-
 drivers/gpu/drm/omapdrm/dss/dss.h             |   2 +-
 drivers/gpu/drm/panel/panel-edp.c             |   3 +-
 drivers/gpu/drm/panel/panel-sitronix-st7703.c |   2 +-
 drivers/gpu/drm/radeon/r100.c                 |   6 +-
 drivers/gpu/drm/radeon/r300.c                 |   2 +-
 drivers/gpu/drm/radeon/r420.c                 |   2 +-
 drivers/gpu/drm/radeon/r600.c                 |   2 +-
 drivers/gpu/drm/radeon/radeon_fence.c         |   2 +-
 drivers/gpu/drm/radeon/radeon_gem.c           |   2 +-
 drivers/gpu/drm/radeon/radeon_ib.c            |   2 +-
 drivers/gpu/drm/radeon/radeon_pm.c            |   2 +-
 drivers/gpu/drm/radeon/radeon_ring.c          |   2 +-
 drivers/gpu/drm/radeon/radeon_ttm.c           |   2 +-
 drivers/gpu/drm/radeon/rs400.c                |   2 +-
 drivers/gpu/drm/radeon/rv515.c                |   2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c  |   2 +-
 drivers/gpu/drm/tegra/dc.c                    |   4 +-
 drivers/gpu/drm/tegra/dsi.c                   |   2 +-
 drivers/gpu/drm/tegra/hdmi.c                  |   2 +-
 drivers/gpu/drm/tegra/sor.c                   |   2 +-
 drivers/gpu/drm/ttm/ttm_device.c              |   2 +-
 drivers/gpu/drm/ttm/ttm_module.h              |   3 +-
 drivers/gpu/drm/ttm/ttm_resource.c            |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c           |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c           |   2 +-
 drivers/gpu/drm/xe/xe_debugfs.c               |   2 +-
 drivers/gpu/drm/xe/xe_gsc_debugfs.c           |   2 +-
 drivers/gpu/drm/xe/xe_gsc_debugfs.h           |   3 +-
 drivers/gpu/drm/xe/xe_gt_debugfs.c            |   6 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c   |  41 ++--
 drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.h   |   7 +-
 drivers/gpu/drm/xe/xe_gt_sriov_vf_debugfs.c   |   9 +-
 drivers/gpu/drm/xe/xe_gt_sriov_vf_debugfs.h   |   4 +-
 drivers/gpu/drm/xe/xe_guc_debugfs.c           |   2 +-
 drivers/gpu/drm/xe/xe_guc_debugfs.h           |   3 +-
 drivers/gpu/drm/xe/xe_huc_debugfs.c           |   2 +-
 drivers/gpu/drm/xe/xe_huc_debugfs.h           |   3 +-
 drivers/gpu/drm/xe/xe_uc_debugfs.c            |   4 +-
 drivers/gpu/drm/xe/xe_uc_debugfs.h            |   3 +-
 drivers/gpu/drm/xlnx/zynqmp_dp.c              |   4 +-
 drivers/gpu/host1x/debug.c                    |   2 +-
 drivers/gpu/host1x/dev.h                      |   8 +-
 drivers/gpu/vga/vga_switcheroo.c              |   2 +-
 drivers/greybus/debugfs.c                     |   4 +-
 drivers/greybus/es2.c                         |   4 +-
 drivers/greybus/svc.c                         |   4 +-
 drivers/hid/hid-debug.c                       |   2 +-
 drivers/hid/hid-picolcd.h                     |   6 +-
 drivers/hid/hid-picolcd_debugfs.c             |   2 +-
 drivers/hid/hid-wiimote-debug.c               |   4 +-
 drivers/hsi/controllers/omap_ssi.h            |   4 +-
 drivers/hsi/controllers/omap_ssi_core.c       |   2 +-
 drivers/hsi/controllers/omap_ssi_port.c       |   2 +-
 drivers/hte/hte.c                             |   6 +-
 drivers/hv/hv_debugfs.c                       |  17 +-
 drivers/hwmon/aquacomputer_d5next.c           |   2 +-
 drivers/hwmon/asus_atk0110.c                  |   4 +-
 drivers/hwmon/corsair-cpro.c                  |   2 +-
 drivers/hwmon/corsair-psu.c                   |   2 +-
 drivers/hwmon/gigabyte_waterforce.c           |   2 +-
 drivers/hwmon/hp-wmi-sensors.c                |   6 +-
 drivers/hwmon/ina3221.c                       |   2 +-
 drivers/hwmon/isl28022.c                      |   4 +-
 drivers/hwmon/ltc4282.c                       |   2 +-
 drivers/hwmon/mr75203.c                       |   2 +-
 drivers/hwmon/nzxt-kraken3.c                  |   2 +-
 drivers/hwmon/pmbus/acbel-fsg032.c            |   2 +-
 drivers/hwmon/pmbus/adm1266.c                 |   4 +-
 drivers/hwmon/pmbus/dps920ab.c                |   4 +-
 drivers/hwmon/pmbus/ibm-cffps.c               |   2 +-
 drivers/hwmon/pmbus/max20730.c                |   4 +-
 drivers/hwmon/pmbus/pmbus.h                   |   2 +-
 drivers/hwmon/pmbus/pmbus_core.c              |   8 +-
 drivers/hwmon/pmbus/q54sj108a2.c              |   4 +-
 drivers/hwmon/pmbus/ucd9000.c                 |   4 +-
 drivers/hwmon/pt5161l.c                       |   4 +-
 drivers/hwmon/sg2042-mcu.c                    |   4 +-
 drivers/hwmon/sht3x.c                         |   4 +-
 drivers/hwmon/tps23861.c                      |   2 +-
 drivers/hwspinlock/sun6i_hwspinlock.c         |   2 +-
 .../hwtracing/coresight/coresight-cpu-debug.c |   2 +-
 drivers/hwtracing/intel_th/debug.c            |   2 +-
 drivers/hwtracing/intel_th/debug.h            |   2 +-
 drivers/i2c/i2c-core-base.c                   |   2 +-
 drivers/iio/adc/ad9467.c                      |   2 +-
 drivers/iio/adc/stm32-adc.c                   |   2 +-
 drivers/iio/gyro/adis16136.c                  |   2 +-
 drivers/iio/imu/adis16400.c                   |   2 +-
 drivers/iio/imu/adis16460.c                   |   2 +-
 drivers/iio/imu/adis16475.c                   |   2 +-
 drivers/iio/imu/adis16480.c                   |   2 +-
 drivers/iio/imu/bno055/bno055.c               |   2 +-
 drivers/iio/industrialio-backend.c            |   4 +-
 drivers/iio/industrialio-core.c               |   4 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h       |   4 +-
 drivers/infiniband/hw/bnxt_re/debugfs.c       |   2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h      |   2 +-
 drivers/infiniband/hw/cxgb4/device.c          |   2 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |   2 +-
 drivers/infiniband/hw/hfi1/debugfs.c          |   4 +-
 drivers/infiniband/hw/hfi1/fault.c            |   4 +-
 drivers/infiniband/hw/hfi1/fault.h            |   2 +-
 drivers/infiniband/hw/hfi1/verbs.h            |   4 +-
 drivers/infiniband/hw/hns/hns_roce_debugfs.c  |   7 +-
 drivers/infiniband/hw/hns/hns_roce_debugfs.h  |   4 +-
 drivers/infiniband/hw/mlx5/main.c             |   2 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   8 +-
 drivers/infiniband/hw/mlx5/mr.c               |   4 +-
 drivers/infiniband/hw/ocrdma/ocrdma.h         |   2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c   |   2 +-
 drivers/infiniband/hw/qib/qib_debugfs.c       |   4 +-
 drivers/infiniband/hw/qib/qib_verbs.h         |   2 +-
 drivers/infiniband/hw/usnic/usnic_debugfs.c   |   4 +-
 drivers/infiniband/hw/usnic/usnic_ib_qp_grp.h |   2 +-
 drivers/infiniband/ulp/ipoib/ipoib.h          |   4 +-
 drivers/infiniband/ulp/ipoib/ipoib_fs.c       |   2 +-
 drivers/input/keyboard/applespi.c             |   2 +-
 drivers/input/touchscreen/edt-ft5x06.c        |   2 +-
 drivers/interconnect/core.c                   |   2 +-
 drivers/interconnect/debugfs-client.c         |   6 +-
 drivers/interconnect/internal.h               |   2 +-
 drivers/iommu/amd/amd_iommu_types.h           |   2 +-
 drivers/iommu/amd/debugfs.c                   |   2 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |   2 +-
 drivers/iommu/intel/debugfs.c                 |   2 +-
 drivers/iommu/intel/iommu.h                   |   4 +-
 drivers/iommu/iommu-debugfs.c                 |   2 +-
 drivers/iommu/iommufd/selftest.c              |   2 +-
 drivers/iommu/omap-iommu-debug.c              |   4 +-
 drivers/iommu/omap-iommu.h                    |   2 +-
 drivers/iommu/tegra-smmu.c                    |   2 +-
 drivers/mailbox/bcm-flexrm-mailbox.c          |   2 +-
 drivers/mailbox/bcm-pdc-mailbox.c             |   2 +-
 drivers/mailbox/mailbox-test.c                |   2 +-
 drivers/md/bcache/bcache.h                    |   2 +-
 drivers/md/bcache/debug.c                     |   2 +-
 drivers/media/cec/core/cec-core.c             |   2 +-
 drivers/media/common/siano/smsdvb-debugfs.c   |   2 +-
 drivers/media/common/siano/smsdvb.h           |   2 +-
 drivers/media/i2c/adv7511-v4l2.c              |   2 +-
 drivers/media/i2c/adv7604.c                   |   2 +-
 drivers/media/i2c/adv7842.c                   |   2 +-
 drivers/media/i2c/tc358743.c                  |   2 +-
 drivers/media/pci/mgb4/mgb4_core.h            |   2 +-
 drivers/media/pci/mgb4/mgb4_vin.c             |   2 +-
 drivers/media/pci/mgb4/mgb4_vout.c            |   2 +-
 drivers/media/pci/saa7164/saa7164-core.c      |   2 +-
 drivers/media/pci/zoran/zoran.h               |   2 +-
 drivers/media/platform/amphion/vpu.h          |   8 +-
 drivers/media/platform/aspeed/aspeed-video.c  |   2 +-
 .../platform/chips-media/coda/coda-common.c   |   3 +-
 .../media/platform/chips-media/coda/coda.h    |   9 +-
 .../mediatek/vcodec/common/mtk_vcodec_dbgfs.c |   4 +-
 .../mediatek/vcodec/common/mtk_vcodec_dbgfs.h |   2 +-
 drivers/media/platform/mediatek/vpu/mtk_vpu.c |   2 +-
 drivers/media/platform/nxp/dw100/dw100.c      |   2 +-
 drivers/media/platform/nxp/imx-mipi-csis.c    |   2 +-
 .../platform/nxp/imx8-isi/imx8-isi-core.h     |   3 +-
 drivers/media/platform/qcom/venus/core.h      |   2 +-
 .../media/platform/raspberrypi/rp1-cfe/cfe.c  |   2 +-
 .../media/platform/raspberrypi/rp1-cfe/csi2.c |   2 +-
 .../media/platform/raspberrypi/rp1-cfe/csi2.h |   2 +-
 .../platform/raspberrypi/rp1-cfe/pisp-fe.c    |   2 +-
 .../platform/raspberrypi/rp1-cfe/pisp-fe.h    |   2 +-
 .../platform/rockchip/rkisp1/rkisp1-common.h  |   3 +-
 .../platform/rockchip/rkisp1/rkisp1-debug.c   |   2 +-
 .../platform/samsung/exynos4-is/fimc-is.h     |   2 +-
 drivers/media/platform/st/sti/bdisp/bdisp.h   |   2 +-
 .../st/sti/c8sectpfe/c8sectpfe-core.h         |   2 +-
 drivers/media/platform/st/sti/hva/hva.h       |   4 +-
 drivers/media/radio/radio-si476x.c            |   2 +-
 .../media/test-drivers/visl/visl-debugfs.c    |   4 +-
 drivers/media/test-drivers/visl/visl.h        |   6 +-
 drivers/media/usb/uvc/uvc_debugfs.c           |   2 +-
 drivers/media/usb/uvc/uvcvideo.h              |   2 +-
 drivers/media/v4l2-core/v4l2-async.c          |   2 +-
 drivers/media/v4l2-core/v4l2-dev.c            |   4 +-
 drivers/media/v4l2-core/v4l2-dv-timings.c     |   3 +-
 drivers/memory/emif.c                         |   2 +-
 drivers/memory/tegra/tegra124-emc.c           |   2 +-
 drivers/memory/tegra/tegra186-emc.c           |   2 +-
 drivers/memory/tegra/tegra20-emc.c            |   2 +-
 drivers/memory/tegra/tegra210-emc.h           |   2 +-
 drivers/memory/tegra/tegra30-emc.c            |   2 +-
 drivers/mfd/intel-lpss.c                      |   6 +-
 drivers/mfd/tps65010.c                        |   2 +-
 drivers/misc/cxl/cxl.h                        |  30 ++-
 drivers/misc/cxl/debugfs.c                    |  21 +-
 drivers/misc/eeprom/idt_89hpesx.c             |   4 +-
 drivers/misc/genwqe/card_base.c               |   2 +-
 drivers/misc/genwqe/card_base.h               |   4 +-
 drivers/misc/genwqe/card_debugfs.c            |   2 +-
 drivers/misc/lkdtm/core.c                     |   2 +-
 drivers/misc/mei/debugfs.c                    |   2 +-
 drivers/misc/mei/mei_dev.h                    |   2 +-
 drivers/misc/xilinx_tmr_inject.c              |   4 +-
 drivers/mmc/core/block.c                      |   6 +-
 drivers/mmc/core/debugfs.c                    |   4 +-
 drivers/mmc/core/mmc_test.c                   |   4 +-
 drivers/mmc/host/atmel-mci.c                  |   2 +-
 drivers/mmc/host/dw_mmc.c                     |   2 +-
 drivers/mmc/host/sdhci-pci-core.c             |   2 +-
 drivers/mtd/devices/docg3.c                   |   2 +-
 drivers/mtd/mtdcore.c                         |   2 +-
 drivers/mtd/mtdswap.c                         |   2 +-
 drivers/mtd/nand/raw/nandsim.c                |   4 +-
 drivers/mtd/spi-nor/debugfs.c                 |   4 +-
 drivers/mtd/ubi/debug.c                       |  48 ++--
 drivers/mtd/ubi/ubi.h                         |  22 +-
 drivers/net/bonding/bond_debugfs.c            |   2 +-
 drivers/net/caif/caif_serial.c                |   4 +-
 drivers/net/caif/caif_virtio.c                |   2 +-
 drivers/net/ethernet/amd/pds_core/core.h      |   4 +-
 drivers/net/ethernet/amd/pds_core/debugfs.c   |   4 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h          |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_debugfs.c |   6 +-
 drivers/net/ethernet/brocade/bna/bnad.h       |   2 +-
 .../net/ethernet/brocade/bna/bnad_debugfs.c   |   2 +-
 drivers/net/ethernet/chelsio/cxgb3/adapter.h  |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |   3 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |   2 +-
 .../net/ethernet/chelsio/cxgb4vf/adapter.h    |   2 +-
 .../ethernet/chelsio/cxgb4vf/cxgb4vf_main.c   |   2 +-
 .../freescale/dpaa2/dpaa2-eth-debugfs.c       |   4 +-
 .../freescale/dpaa2/dpaa2-eth-debugfs.h       |   2 +-
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  |   4 +-
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  |   6 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   2 +-
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |   6 +-
 .../ethernet/hisilicon/hns3/hns3_debugfs.h    |   2 +-
 .../hisilicon/hns3/hns3pf/hclge_main.h        |   2 +-
 .../net/ethernet/huawei/hinic/hinic_debugfs.c |   9 +-
 drivers/net/ethernet/huawei/hinic/hinic_dev.h |  10 +-
 drivers/net/ethernet/intel/fm10k/fm10k.h      |   4 +-
 .../net/ethernet/intel/fm10k/fm10k_debugfs.c  |   2 +-
 drivers/net/ethernet/intel/i40e/i40e.h        |   2 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |   2 +-
 drivers/net/ethernet/intel/ice/ice.h          |   6 +-
 drivers/net/ethernet/intel/ice/ice_debugfs.c  |   9 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   2 +-
 .../net/ethernet/intel/ixgbe/ixgbe_debugfs.c  |   2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |   2 +-
 .../ethernet/marvell/mvpp2/mvpp2_debugfs.c    |  43 ++--
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  24 +-
 drivers/net/ethernet/marvell/skge.c           |   2 +-
 drivers/net/ethernet/marvell/skge.h           |   2 +-
 drivers/net/ethernet/marvell/sky2.c           |   4 +-
 drivers/net/ethernet/marvell/sky2.h           |   2 +-
 .../net/ethernet/mediatek/mtk_ppe_debugfs.c   |   2 +-
 drivers/net/ethernet/mediatek/mtk_wed.h       |   2 +-
 .../net/ethernet/mediatek/mtk_wed_debugfs.c   |   2 +-
 .../net/ethernet/mellanox/mlx5/core/debugfs.c |  11 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   5 +-
 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    |   2 +-
 .../mellanox/mlx5/core/en_accel/ktls.c        |   2 +-
 .../mellanox/mlx5/core/en_accel/ktls.h        |   4 +-
 .../mellanox/mlx5/core/en_accel/ktls_tx.c     |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   |   8 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |   4 +-
 .../ethernet/mellanox/mlx5/core/esw/bridge.h  |   3 +-
 .../mellanox/mlx5/core/esw/bridge_priv.h      |   2 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |   3 +-
 .../ethernet/mellanox/mlx5/core/lag/debugfs.c |   4 +-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |   2 +-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  |   2 +-
 .../mellanox/mlx5/core/steering/hws/context.h |   4 +-
 .../mellanox/mlx5/core/steering/sws/dr_dbg.h  |   4 +-
 drivers/net/ethernet/meta/fbnic/fbnic.h       |   2 +-
 .../net/ethernet/meta/fbnic/fbnic_debugfs.c   |   2 +-
 .../ethernet/microchip/lan966x/lan966x_main.h |   2 +-
 .../microchip/lan966x/lan966x_vcap_impl.c     |   2 +-
 .../ethernet/microchip/sparx5/sparx5_main.h   |   2 +-
 .../microchip/sparx5/sparx5_vcap_impl.c       |   2 +-
 .../microchip/vcap/vcap_api_debugfs.c         |   9 +-
 .../microchip/vcap/vcap_api_debugfs.h         |  14 +-
 .../net/ethernet/microsoft/mana/gdma_main.c   |   2 +-
 drivers/net/ethernet/netronome/nfp/nfp_main.h |   3 +-
 drivers/net/ethernet/netronome/nfp/nfp_net.h  |  14 +-
 .../ethernet/netronome/nfp/nfp_net_debugfs.c  |  10 +-
 .../ethernet/netronome/nfp/nfp_netvf_main.c   |   2 +-
 drivers/net/ethernet/pensando/ionic/ionic.h   |   2 +-
 .../ethernet/pensando/ionic/ionic_debugfs.c   |   8 +-
 .../net/ethernet/pensando/ionic/ionic_lif.h   |   4 +-
 drivers/net/ethernet/qualcomm/qca_spi.h       |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   2 +-
 drivers/net/ethernet/vertexcom/mse102x.c      |   2 +-
 drivers/net/fjes/fjes.h                       |   2 +-
 drivers/net/fjes/fjes_debugfs.c               |   2 +-
 drivers/net/ieee802154/adf7242.c              |   2 +-
 drivers/net/ieee802154/ca8210.c               |   2 +-
 drivers/net/netdevsim/bpf.c                   |   4 +-
 drivers/net/netdevsim/dev.c                   |   6 +-
 drivers/net/netdevsim/ethtool.c               |   2 +-
 drivers/net/netdevsim/fib.c                   |   2 +-
 drivers/net/netdevsim/netdevsim.h             |  28 +--
 drivers/net/netdevsim/psample.c               |   2 +-
 drivers/net/phy/sfp.c                         |   2 +-
 drivers/net/wireless/ath/ath10k/core.h        |   2 +-
 drivers/net/wireless/ath/ath10k/debug.h       |   3 +-
 drivers/net/wireless/ath/ath10k/debugfs_sta.c |   3 +-
 drivers/net/wireless/ath/ath10k/spectral.c    |   8 +-
 drivers/net/wireless/ath/ath11k/core.h        |   6 +-
 drivers/net/wireless/ath/ath11k/debugfs.c     |   8 +-
 drivers/net/wireless/ath/ath11k/debugfs.h     |   2 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c |   3 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.h |   3 +-
 drivers/net/wireless/ath/ath11k/spectral.c    |   8 +-
 drivers/net/wireless/ath/ath11k/spectral.h    |   6 +-
 drivers/net/wireless/ath/ath12k/core.h        |   6 +-
 drivers/net/wireless/ath/ath12k/debugfs.c     |   4 +-
 drivers/net/wireless/ath/ath5k/debug.c        |   2 +-
 drivers/net/wireless/ath/ath6kl/core.h        |   2 +-
 drivers/net/wireless/ath/ath9k/common-debug.c |   8 +-
 drivers/net/wireless/ath/ath9k/common-debug.h |  16 +-
 .../net/wireless/ath/ath9k/common-spectral.c  |  10 +-
 .../net/wireless/ath/ath9k/common-spectral.h  |   5 +-
 drivers/net/wireless/ath/ath9k/debug.h        |   4 +-
 drivers/net/wireless/ath/ath9k/debug_sta.c    |   2 +-
 drivers/net/wireless/ath/ath9k/htc.h          |   2 +-
 drivers/net/wireless/ath/carl9170/carl9170.h  |   2 +-
 drivers/net/wireless/ath/wcn36xx/debug.c      |   6 +-
 drivers/net/wireless/ath/wcn36xx/debug.h      |   4 +-
 drivers/net/wireless/ath/wil6210/debugfs.c    |  30 +--
 drivers/net/wireless/ath/wil6210/wil6210.h    |   2 +-
 drivers/net/wireless/broadcom/b43/debugfs.c   |   2 +-
 drivers/net/wireless/broadcom/b43/debugfs.h   |   3 +-
 .../net/wireless/broadcom/b43legacy/debugfs.c |   2 +-
 .../net/wireless/broadcom/b43legacy/debugfs.h |   3 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h    |   2 +-
 .../broadcom/brcm80211/brcmfmac/core.h        |   2 +-
 .../broadcom/brcm80211/brcmfmac/debug.c       |   2 +-
 .../broadcom/brcm80211/brcmfmac/debug.h       |   4 +-
 .../broadcom/brcm80211/brcmfmac/pcie.c        |   2 +-
 .../broadcom/brcm80211/brcmfmac/sdio.c        |   2 +-
 .../broadcom/brcm80211/brcmsmac/debug.c       |   4 +-
 .../broadcom/brcm80211/brcmsmac/pub.h         |   2 +-
 drivers/net/wireless/intel/iwlegacy/3945-rs.c |   2 +-
 drivers/net/wireless/intel/iwlegacy/4965-rs.c |   2 +-
 drivers/net/wireless/intel/iwlegacy/common.h  |   2 +-
 drivers/net/wireless/intel/iwlegacy/debug.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h  |   4 +-
 .../net/wireless/intel/iwlwifi/dvm/debugfs.c  |   9 +-
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h  |   2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c   |   2 +-
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   |   2 +-
 .../net/wireless/intel/iwlwifi/fw/debugfs.h   |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |   2 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  10 +-
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   2 +-
 drivers/net/wireless/intel/iwlwifi/mei/main.c |   2 +-
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  10 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |   2 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   2 +-
 .../net/wireless/marvell/libertas/debugfs.c   |   2 +-
 drivers/net/wireless/marvell/libertas/dev.h   |  14 +-
 .../net/wireless/marvell/mwifiex/debugfs.c    |   2 +-
 drivers/net/wireless/marvell/mwifiex/main.h   |   2 +-
 drivers/net/wireless/mediatek/mt76/debugfs.c  |   4 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |   4 +-
 .../wireless/mediatek/mt76/mt7603/debugfs.c   |   2 +-
 .../wireless/mediatek/mt76/mt7615/debugfs.c   |   2 +-
 .../wireless/mediatek/mt76/mt76x02_debugfs.c  |   2 +-
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  14 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   5 +-
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |   2 +-
 .../wireless/mediatek/mt76/mt7925/debugfs.c   |   2 +-
 .../wireless/mediatek/mt76/mt7996/debugfs.c   |  14 +-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |   7 +-
 .../net/wireless/mediatek/mt7601u/debugfs.c   |   2 +-
 drivers/net/wireless/quantenna/qtnfmac/bus.h  |   2 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c |   4 +-
 drivers/net/wireless/quantenna/qtnfmac/core.h |   2 +-
 .../net/wireless/quantenna/qtnfmac/debug.c    |   2 +-
 .../net/wireless/ralink/rt2x00/rt2x00debug.c  |   6 +-
 drivers/net/wireless/realtek/rtlwifi/debug.c  |   4 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h   |   2 +-
 drivers/net/wireless/realtek/rtw88/debug.c    |  11 +-
 drivers/net/wireless/realtek/rtw89/debug.c    |   8 +-
 drivers/net/wireless/rsi/rsi_debugfs.h        |   4 +-
 drivers/net/wireless/silabs/wfx/debug.c       |   2 +-
 drivers/net/wireless/st/cw1200/debug.h        |   2 +-
 drivers/net/wireless/ti/wl1251/wl1251.h       | 194 +++++++--------
 drivers/net/wireless/ti/wl12xx/debugfs.c      |   4 +-
 drivers/net/wireless/ti/wl12xx/debugfs.h      |   2 +-
 drivers/net/wireless/ti/wl18xx/debugfs.c      |   4 +-
 drivers/net/wireless/ti/wl18xx/debugfs.h      |   2 +-
 drivers/net/wireless/ti/wlcore/debugfs.c      |   6 +-
 drivers/net/wireless/ti/wlcore/hw_ops.h       |   2 +-
 drivers/net/wireless/ti/wlcore/wlcore.h       |   2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |   4 +-
 drivers/net/wwan/iosm/iosm_ipc_imem.h         |   4 +-
 drivers/net/wwan/iosm/iosm_ipc_trace.c        |   6 +-
 drivers/net/wwan/iosm/iosm_ipc_trace.h        |   2 +-
 drivers/net/wwan/t7xx/t7xx_pci.h              |   2 +-
 drivers/net/wwan/t7xx/t7xx_port_trace.c       |  12 +-
 drivers/net/wwan/wwan_core.c                  |  10 +-
 drivers/net/wwan/wwan_hwsim.c                 |  10 +-
 drivers/net/xen-netback/common.h              |   4 +-
 drivers/net/xen-netback/xenbus.c              |   2 +-
 drivers/nfc/nfcsim.c                          |   4 +-
 drivers/ntb/hw/amd/ntb_hw_amd.c               |   2 +-
 drivers/ntb/hw/amd/ntb_hw_amd.h               |   4 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c               |   2 +-
 drivers/ntb/hw/idt/ntb_hw_idt.h               |   2 +-
 drivers/ntb/hw/intel/ntb_hw_gen1.c            |   2 +-
 drivers/ntb/hw/intel/ntb_hw_intel.h           |   4 +-
 drivers/ntb/ntb_transport.c                   |   8 +-
 drivers/ntb/test/ntb_msi_test.c               |   6 +-
 drivers/ntb/test/ntb_perf.c                   |   4 +-
 drivers/ntb/test/ntb_pingpong.c               |   4 +-
 drivers/ntb/test/ntb_tool.c                   |   8 +-
 drivers/nvdimm/btt.c                          |   7 +-
 drivers/nvdimm/btt.h                          |   4 +-
 drivers/nvme/host/fault_inject.c              |   2 +-
 drivers/nvme/host/nvme.h                      |   2 +-
 drivers/nvme/target/debugfs.c                 |   6 +-
 drivers/nvme/target/nvmet.h                   |   4 +-
 drivers/opp/debugfs.c                         |  18 +-
 drivers/opp/opp.h                             |   6 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |   2 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |   2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |   2 +-
 drivers/pci/controller/pci-tegra.c            |   2 +-
 drivers/pci/hotplug/cpqphp.h                  |   2 +-
 drivers/pci/hotplug/cpqphp_sysfs.c            |   2 +-
 drivers/perf/arm-cmn.c                        |   4 +-
 drivers/phy/phy-core.c                        |   2 +-
 drivers/phy/realtek/phy-rtk-usb2.c            |   8 +-
 drivers/phy/realtek/phy-rtk-usb3.c            |   8 +-
 drivers/pinctrl/core.c                        |   4 +-
 drivers/pinctrl/core.h                        |   3 +-
 drivers/pinctrl/pinconf.c                     |   4 +-
 drivers/pinctrl/pinconf.h                     |   5 +-
 drivers/pinctrl/pinmux.c                      |   4 +-
 drivers/pinctrl/pinmux.h                      |   5 +-
 drivers/platform/chrome/cros_ec_debugfs.c     |   2 +-
 drivers/platform/chrome/wilco_ec/debugfs.c    |   2 +-
 drivers/platform/olpc/olpc-ec.c               |   8 +-
 drivers/platform/x86/acer-wmi.c               |   2 +-
 drivers/platform/x86/amd/pmc/pmc.h            |   2 +-
 drivers/platform/x86/amd/pmf/pmf.h            |   4 +-
 drivers/platform/x86/amd/pmf/tee-if.c         |   6 +-
 drivers/platform/x86/apple-gmux.c             |   2 +-
 drivers/platform/x86/asus-wmi.c               |   2 +-
 drivers/platform/x86/dell/dell-laptop.c       |   2 +-
 drivers/platform/x86/dell/dell-wmi-ddv.c      |   4 +-
 drivers/platform/x86/huawei-wmi.c             |   2 +-
 drivers/platform/x86/ideapad-laptop.c         |   4 +-
 drivers/platform/x86/intel/bytcrc_pwrsrc.c    |   2 +-
 drivers/platform/x86/intel/plr_tpmi.c         |   4 +-
 drivers/platform/x86/intel/pmc/core.c         |   2 +-
 drivers/platform/x86/intel/pmc/core.h         |   2 +-
 .../platform/x86/intel/telemetry/debugfs.c    |   4 +-
 drivers/platform/x86/intel/vsec_tpmi.c        |   6 +-
 drivers/platform/x86/intel_ips.c              |   2 +-
 drivers/platform/x86/msi-wmi-platform.c       |   9 +-
 drivers/platform/x86/pmc_atom.c               |   4 +-
 drivers/platform/x86/samsung-laptop.c         |   4 +-
 drivers/pmdomain/core.c                       |   4 +-
 drivers/pmdomain/qcom/cpr.c                   |   2 +-
 drivers/power/sequencing/core.c               |   2 +-
 drivers/power/supply/axp288_fuel_gauge.c      |   2 +-
 drivers/power/supply/da9030_battery.c         |   6 +-
 drivers/ptp/ptp_ocp.c                         |   6 +-
 drivers/ptp/ptp_private.h                     |   4 +-
 drivers/ptp/ptp_qoriq_debugfs.c               |   2 +-
 drivers/ras/amd/fmpm.c                        |   6 +-
 drivers/ras/cec.c                             |   2 +-
 drivers/ras/debugfs.c                         |   6 +-
 drivers/ras/debugfs.h                         |   4 +-
 drivers/regulator/core.c                      |   2 +-
 drivers/regulator/internal.h                  |   2 +-
 drivers/remoteproc/remoteproc_debugfs.c       |   6 +-
 drivers/remoteproc/remoteproc_internal.h      |   6 +-
 drivers/s390/block/dasd.c                     |  26 +-
 drivers/s390/block/dasd_int.h                 |   8 +-
 drivers/s390/char/zcore.c                     |   6 +-
 drivers/s390/cio/cio_debug.h                  |   2 +-
 drivers/s390/cio/cio_debugfs.c                |   2 +-
 drivers/s390/cio/qdio.h                       |   2 +-
 drivers/s390/cio/qdio_debug.c                 |   4 +-
 drivers/s390/net/qeth_core.h                  |   2 +-
 drivers/s390/net/qeth_core_main.c             |   2 +-
 drivers/scsi/bfa/bfad_debugfs.c               |   2 +-
 drivers/scsi/bfa/bfad_drv.h                   |   4 +-
 drivers/scsi/csiostor/csio_hw.h               |   2 +-
 drivers/scsi/csiostor/csio_init.c             |   2 +-
 drivers/scsi/elx/efct/efct_driver.h           |   2 +-
 drivers/scsi/elx/efct/efct_xport.c            |   2 +-
 drivers/scsi/fnic/fnic.h                      |   6 +-
 drivers/scsi/fnic/fnic_debugfs.c              |  18 +-
 drivers/scsi/hisi_sas/hisi_sas.h              |  10 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c         |   2 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c        |  14 +-
 drivers/scsi/lpfc/lpfc.h                      |  76 +++---
 drivers/scsi/lpfc/lpfc_debugfs.c              |  42 ++--
 drivers/scsi/megaraid/megaraid_sas.h          |   4 +-
 drivers/scsi/megaraid/megaraid_sas_base.c     |   2 +-
 drivers/scsi/megaraid/megaraid_sas_debugfs.c  |   2 +-
 drivers/scsi/mpt3sas/mpt3sas_base.h           |   4 +-
 drivers/scsi/mpt3sas/mpt3sas_debugfs.c        |   2 +-
 drivers/scsi/qedf/qedf_dbg.h                  |   2 +-
 drivers/scsi/qedf/qedf_debugfs.c              |   2 +-
 drivers/scsi/qedi/qedi_dbg.h                  |   2 +-
 drivers/scsi/qedi/qedi_debugfs.c              |   2 +-
 drivers/scsi/qla2xxx/qla_def.h                |  23 +-
 drivers/scsi/qla2xxx/qla_dfs.c                |   2 +-
 drivers/scsi/scsi_debug.c                     |   8 +-
 drivers/scsi/snic/snic.h                      |  10 +-
 drivers/soc/amlogic/meson-clk-measure.c       |   2 +-
 drivers/soc/mediatek/mtk-svs.c                |   2 +-
 drivers/soc/qcom/qcom_aoss.c                  |   8 +-
 drivers/soc/qcom/qcom_stats.c                 |   9 +-
 drivers/soc/qcom/rpm_master_stats.c           |   4 +-
 drivers/soc/qcom/socinfo.c                    |   4 +-
 drivers/soc/tegra/cbb/tegra-cbb.c             |   2 +-
 drivers/soc/ti/smartreflex.c                  |   4 +-
 drivers/soundwire/cadence_master.c            |   2 +-
 drivers/soundwire/cadence_master.h            |   2 +-
 drivers/soundwire/debugfs.c                   |   6 +-
 drivers/soundwire/intel.c                     |   2 +-
 drivers/soundwire/intel.h                     |   2 +-
 drivers/soundwire/intel_ace2x_debugfs.c       |   2 +-
 drivers/soundwire/qcom.c                      |   2 +-
 drivers/spi/spi-bcm2835.c                     |   4 +-
 drivers/spi/spi-bcm2835aux.c                  |   4 +-
 drivers/spi/spi-dw.h                          |   2 +-
 drivers/spi/spi-hisi-kunpeng.c                |   2 +-
 drivers/staging/greybus/loopback.c            |   4 +-
 .../interface/vchiq_arm/vchiq_debugfs.c       |   6 +-
 .../interface/vchiq_arm/vchiq_debugfs.h       |   2 +-
 drivers/thermal/broadcom/bcm2835_thermal.c    |   2 +-
 drivers/thermal/intel/intel_powerclamp.c      |   2 +-
 drivers/thermal/intel/x86_pkg_temp_thermal.c  |   2 +-
 drivers/thermal/mediatek/lvts_thermal.c       |   4 +-
 drivers/thermal/qcom/tsens.h                  |   4 +-
 drivers/thermal/tegra/soctherm.c              |   4 +-
 drivers/thermal/testing/command.c             |   2 +-
 drivers/thermal/testing/thermal_testing.h     |   2 +-
 drivers/thermal/testing/zone.c                |   2 +-
 drivers/thermal/thermal_debugfs.c             |  11 +-
 drivers/thunderbolt/debugfs.c                 |  22 +-
 drivers/thunderbolt/dma_test.c                |   2 +-
 drivers/thunderbolt/tb.h                      |   2 +-
 drivers/tty/serial/8250/8250_bcm7271.c        |   4 +-
 drivers/ufs/core/ufs-debugfs.c                |   6 +-
 drivers/ufs/host/ufshcd-pci.c                 |   4 +-
 drivers/usb/chipidea/debug.c                  |   2 +-
 drivers/usb/common/common.c                   |   2 +-
 drivers/usb/common/ulpi.c                     |   4 +-
 drivers/usb/dwc2/core.h                       |   4 +-
 drivers/usb/dwc2/debugfs.c                    |   4 +-
 drivers/usb/dwc3/core.h                       |   2 +-
 drivers/usb/dwc3/debugfs.c                    |   4 +-
 drivers/usb/fotg210/fotg210-hcd.c             |   4 +-
 drivers/usb/gadget/udc/atmel_usba_udc.c       |   4 +-
 drivers/usb/gadget/udc/atmel_usba_udc.h       |   4 +-
 drivers/usb/gadget/udc/bcm63xx_udc.c          |   2 +-
 drivers/usb/gadget/udc/gr_udc.c               |   2 +-
 drivers/usb/gadget/udc/pxa27x_udc.c           |   2 +-
 drivers/usb/gadget/udc/renesas_usb3.c         |   2 +-
 drivers/usb/host/ehci-dbg.c                   |   2 +-
 drivers/usb/host/ehci.h                       |   2 +-
 drivers/usb/host/fhci.h                       |   2 +-
 drivers/usb/host/ohci-dbg.c                   |   4 +-
 drivers/usb/host/ohci.h                       |   2 +-
 drivers/usb/host/uhci-debug.c                 |   2 +-
 drivers/usb/host/xhci-debugfs.c               |  18 +-
 drivers/usb/host/xhci-debugfs.h               |   4 +-
 drivers/usb/host/xhci.h                       |   4 +-
 drivers/usb/mon/mon_text.c                    |   2 +-
 drivers/usb/mon/usb_mon.h                     |   6 +-
 drivers/usb/mtu3/mtu3.h                       |   2 +-
 drivers/usb/mtu3/mtu3_debugfs.c               |  16 +-
 drivers/usb/musb/musb_core.h                  |   2 +-
 drivers/usb/musb/musb_debugfs.c               |   2 +-
 drivers/usb/musb/musb_dsps.c                  |   4 +-
 drivers/usb/typec/mux/intel_pmc_mux.c         |   6 +-
 drivers/usb/typec/tcpm/fusb302.c              |   2 +-
 drivers/usb/typec/tcpm/tcpm.c                 |   2 +-
 drivers/usb/typec/ucsi/debugfs.c              |   2 +-
 drivers/usb/typec/ucsi/ucsi.h                 |   3 +-
 drivers/vdpa/mlx5/net/debug.c                 |   2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.h             |  12 +-
 drivers/vdpa/pds/aux_drv.h                    |   2 +-
 drivers/vdpa/pds/debugfs.c                    |   2 +-
 drivers/vfio/debugfs.c                        |   4 +-
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    |   4 +-
 drivers/video/fbdev/omap2/omapfb/dss/core.c   |   2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dss.h    |   1 +
 drivers/virtio/virtio_debug.c                 |   2 +-
 drivers/watchdog/bcm_kona_wdt.c               |   4 +-
 drivers/watchdog/dw_wdt.c                     |   2 +-
 drivers/watchdog/ie6xx_wdt.c                  |   2 +-
 drivers/watchdog/mei_wdt.c                    |   4 +-
 fs/bcachefs/bcachefs.h                        |   4 +-
 fs/bcachefs/debug.c                           |   4 +-
 fs/ceph/super.h                               |  14 +-
 fs/debugfs/file.c                             | 117 ++++-----
 fs/debugfs/inode.c                            | 232 +++++++++++-------
 fs/debugfs/internal.h                         |   6 +
 fs/dlm/debug_fs.c                             |   6 +-
 fs/dlm/dlm_internal.h                         |  12 +-
 fs/f2fs/debug.c                               |   2 +-
 fs/gfs2/glock.c                               |   2 +-
 fs/gfs2/incore.h                              |   2 +-
 fs/ocfs2/blockcheck.c                         |   8 +-
 fs/ocfs2/blockcheck.h                         |   4 +-
 fs/ocfs2/cluster/heartbeat.c                  |  10 +-
 fs/ocfs2/cluster/netdebug.c                   |   2 +-
 fs/ocfs2/dlm/dlmcommon.h                      |   2 +-
 fs/ocfs2/dlm/dlmdebug.c                       |   2 +-
 fs/ocfs2/ocfs2.h                              |   2 +-
 fs/ocfs2/super.c                              |   2 +-
 fs/orangefs/orangefs-debugfs.c                |   4 +-
 fs/pstore/ftrace.c                            |   2 +-
 fs/ubifs/debug.c                              |  76 +++---
 fs/ubifs/debug.h                              |  22 +-
 fs/xfs/scrub/stats.c                          |   7 +-
 fs/xfs/scrub/stats.h                          |   6 +-
 fs/xfs/xfs_mount.h                            |   2 +-
 fs/xfs/xfs_super.c                            |   8 +-
 fs/xfs/xfs_super.h                            |   3 +-
 include/drm/drm_bridge.h                      |   2 +-
 include/drm/drm_connector.h                   |   5 +-
 include/drm/drm_crtc.h                        |   2 +-
 include/drm/drm_debugfs.h                     |  15 +-
 include/drm/drm_device.h                      |   2 +-
 include/drm/drm_drv.h                         |   5 +-
 include/drm/drm_encoder.h                     |   4 +-
 include/drm/drm_file.h                        |   5 +-
 include/drm/drm_panel.h                       |   4 +-
 include/drm/ttm/ttm_resource.h                |   3 +-
 include/kunit/test.h                          |   2 +-
 include/linux/backing-dev-defs.h              |   3 +-
 include/linux/blk-mq.h                        |   4 +-
 include/linux/blkdev.h                        |   6 +-
 include/linux/blktrace_api.h                  |   2 +-
 include/linux/cdx/cdx_bus.h                   |   2 +-
 include/linux/ceph/libceph.h                  |   8 +-
 include/linux/ceph/mon_client.h               |   2 +-
 include/linux/ceph/osd_client.h               |   2 +-
 include/linux/clk-provider.h                  |   4 +-
 include/linux/closure.h                       |   2 +-
 include/linux/debugfs.h                       | 192 +++++++++------
 include/linux/dmaengine.h                     |   2 +-
 include/linux/edac.h                          |   2 +-
 include/linux/fault-inject.h                  |  11 +-
 include/linux/firmware/cirrus/cs_dsp.h        |   5 +-
 include/linux/fsl/ptp_qoriq.h                 |   2 +-
 include/linux/greybus.h                       |   2 +-
 include/linux/greybus/svc.h                   |   2 +-
 include/linux/hid.h                           |   6 +-
 include/linux/hisi_acc_qm.h                   |   4 +-
 include/linux/hyperv.h                        |   2 +-
 include/linux/i2c.h                           |   4 +-
 include/linux/iio/iio-opaque.h                |   2 +-
 include/linux/iio/iio.h                       |   4 +-
 include/linux/intel_tpmi.h                    |   2 +-
 include/linux/iommu.h                         |   2 +-
 include/linux/irqdesc.h                       |   5 +-
 include/linux/kvm_host.h                      |   5 +-
 include/linux/mfd/aat2870.h                   |   2 +-
 include/linux/mhi.h                           |   2 +-
 include/linux/mlx5/driver.h                   |  24 +-
 include/linux/mmc/card.h                      |   2 +-
 include/linux/mmc/host.h                      |   2 +-
 include/linux/moxtet.h                        |   2 +-
 include/linux/mtd/mtd.h                       |   2 +-
 include/linux/mtd/spi-nor.h                   |   2 +-
 include/linux/phy/phy.h                       |   2 +-
 include/linux/pktcdvd.h                       |   4 +-
 include/linux/power/smartreflex.h             |   2 +-
 include/linux/regulator/driver.h              |   2 +-
 include/linux/relay.h                         |  19 +-
 include/linux/remoteproc.h                    |   2 +-
 include/linux/shrinker.h                      |   2 +-
 include/linux/soundwire/sdw.h                 |   5 +-
 include/linux/sunrpc/clnt.h                   |   2 +-
 include/linux/sunrpc/xprt.h                   |   2 +-
 include/linux/swiotlb.h                       |   2 +-
 include/linux/thunderbolt.h                   |   2 +-
 include/linux/usb.h                           |   2 +-
 include/linux/vfio.h                          |   2 +-
 include/linux/virtio.h                        |   2 +-
 include/linux/wkup_m3_ipc.h                   |   2 +-
 include/linux/wwan.h                          |   8 +-
 include/linux/xattr.h                         |   1 +
 include/media/cec.h                           |   2 +-
 include/media/v4l2-async.h                    |   5 +-
 include/media/v4l2-dev.h                      |   5 +-
 include/media/v4l2-dv-timings.h               |   8 +-
 include/net/6lowpan.h                         |   2 +-
 include/net/bluetooth/bluetooth.h             |   2 +-
 include/net/bluetooth/hci_core.h              |   4 +-
 include/net/bonding.h                         |   2 +-
 include/net/cfg80211.h                        |   2 +-
 include/net/mac80211.h                        |  14 +-
 include/net/mana/gdma.h                       |   4 +-
 include/net/mana/mana.h                       |  10 +-
 include/soc/tegra/bpmp.h                      |   2 +-
 include/soc/tegra/mc.h                        |   2 +-
 include/sound/core.h                          |   4 +-
 include/sound/soc-component.h                 |   2 +-
 include/sound/soc-dapm.h                      |   5 +-
 include/sound/soc-dpcm.h                      |   2 +-
 include/sound/soc.h                           |   6 +-
 include/ufs/ufshcd.h                          |   2 +-
 kernel/dma/debug.c                            |   2 +-
 kernel/dma/map_benchmark.c                    |   4 +-
 kernel/dma/pool.c                             |   2 +-
 kernel/fail_function.c                        |   6 +-
 kernel/futex/core.c                           |   2 +-
 kernel/gcov/fs.c                              |   6 +-
 kernel/irq/debugfs.c                          |   4 +-
 kernel/irq/internals.h                        |   4 +-
 kernel/irq/irqdomain.c                        |   4 +-
 kernel/kprobes.c                              |   2 +-
 kernel/locking/lock_events.c                  |   2 +-
 kernel/module/internal.h                      |   2 +-
 kernel/module/main.c                          |   2 +-
 kernel/module/tracking.c                      |   2 +-
 kernel/power/energy_model.c                   |   8 +-
 kernel/printk/index.c                         |   4 +-
 kernel/relay.c                                |  88 +++----
 kernel/sched/debug.c                          |  16 +-
 kernel/trace/blktrace.c                       |   8 +-
 kernel/trace/trace.h                          |   2 +-
 lib/842/842_debugfs.h                         |   2 +-
 lib/debugobjects.c                            |   2 +-
 lib/dynamic_debug.c                           |   2 +-
 lib/error-inject.c                            |   2 +-
 lib/fault-inject-usercopy.c                   |   2 +-
 lib/fault-inject.c                            |  13 +-
 lib/kunit/debugfs.c                           |   2 +-
 lib/memory-notifier-error-inject.c            |   2 +-
 lib/netdev-notifier-error-inject.c            |   2 +-
 lib/notifier-error-inject.c                   |  18 +-
 lib/notifier-error-inject.h                   |   9 +-
 lib/of-reconfig-notifier-error-inject.c       |   2 +-
 lib/pm-notifier-error-inject.c                |   2 +-
 lib/stackdepot.c                              |   2 +-
 lib/test_fpu_glue.c                           |   2 +-
 mm/backing-dev.c                              |   2 +-
 mm/cma_debug.c                                |   7 +-
 mm/fail_page_alloc.c                          |   2 +-
 mm/failslab.c                                 |   2 +-
 mm/hwpoison-inject.c                          |   2 +-
 mm/internal.h                                 |   8 +-
 mm/kfence/core.c                              |   2 +-
 mm/memblock.c                                 |   2 +-
 mm/page_owner.c                               |   2 +-
 mm/shrinker.c                                 |   2 +-
 mm/shrinker_debug.c                           |  13 +-
 mm/slub.c                                     |   4 +-
 mm/vmstat.c                                   |   2 +-
 mm/zsmalloc.c                                 |   4 +-
 mm/zswap.c                                    |   2 +-
 net/6lowpan/debugfs.c                         |  10 +-
 net/bluetooth/6lowpan.c                       |   4 +-
 net/bluetooth/af_bluetooth.c                  |   2 +-
 net/bluetooth/iso.c                           |   2 +-
 net/bluetooth/l2cap_core.c                    |   2 +-
 net/bluetooth/rfcomm/core.c                   |   2 +-
 net/bluetooth/rfcomm/sock.c                   |   2 +-
 net/bluetooth/sco.c                           |   2 +-
 net/caif/caif_socket.c                        |   2 +-
 net/ceph/debugfs.c                            |   2 +-
 net/core/skb_fault_injection.c                |   2 +-
 net/hsr/hsr_debugfs.c                         |   4 +-
 net/hsr/hsr_main.h                            |   2 +-
 net/l2tp/l2tp_debugfs.c                       |   2 +-
 net/mac80211/debugfs.c                        |   4 +-
 net/mac80211/debugfs_netdev.c                 |  14 +-
 net/mac80211/debugfs_sta.c                    |   2 +-
 net/mac80211/driver-ops.h                     |   6 +-
 net/mac80211/ieee80211_i.h                    |  16 +-
 net/mac80211/key.h                            |   4 +-
 net/mac80211/rate.h                           |   2 +-
 net/mac80211/rc80211_minstrel_ht.c            |   2 +-
 net/mac80211/rc80211_minstrel_ht.h            |   3 +-
 net/mac80211/rc80211_minstrel_ht_debugfs.c    |   3 +-
 net/mac80211/sta_info.h                       |   4 +-
 net/sunrpc/debugfs.c                          |  13 +-
 net/wireless/core.c                           |   2 +-
 net/wireless/debugfs.c                        |   6 +-
 samples/qmi/qmi_sample_client.c               |   8 +-
 sound/core/jack.c                             |   2 +-
 sound/core/sound.c                            |   2 +-
 sound/drivers/pcmtest.c                       |   2 +-
 sound/pci/hda/cs35l56_hda.h                   |   3 +-
 sound/soc/codecs/cs35l56.c                    |   2 +-
 sound/soc/fsl/fsl_ssi.h                       |   2 +-
 sound/soc/fsl/imx-audmux.c                    |   2 +-
 sound/soc/intel/avs/avs.h                     |   2 +-
 sound/soc/mediatek/mt8195/mt8195-afe-common.h |   2 +-
 sound/soc/mediatek/mt8365/mt8365-afe-common.h |   2 +-
 sound/soc/renesas/rcar/debugfs.c              |   2 +-
 sound/soc/soc-core.c                          |   2 +-
 sound/soc/soc-dapm.c                          |   4 +-
 sound/soc/sof/debug.c                         |   2 +-
 sound/soc/sof/ipc4-mtrace.c                   |   2 +-
 sound/soc/sof/sof-client-ipc-flood-test.c     |   6 +-
 .../soc/sof/sof-client-ipc-kernel-injector.c  |   4 +-
 sound/soc/sof/sof-client-ipc-msg-injector.c   |   4 +-
 sound/soc/sof/sof-client-probes.c             |   2 +-
 sound/soc/sof/sof-client-probes.h             |   4 +-
 sound/soc/sof/sof-client.c                    |   2 +-
 sound/soc/sof/sof-client.h                    |   3 +-
 sound/soc/sof/sof-priv.h                      |   2 +-
 virt/kvm/kvm_main.c                           |  11 +-
 1117 files changed, 2971 insertions(+), 2636 deletions(-)


base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3


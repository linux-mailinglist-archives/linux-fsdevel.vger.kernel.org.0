Return-Path: <linux-fsdevel+bounces-22256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059A6915416
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 18:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62A6280985
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 16:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9C919DFBB;
	Mon, 24 Jun 2024 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAOXiQwJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF1519DF7C;
	Mon, 24 Jun 2024 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247040; cv=none; b=dee0EMzA9ETXhL2OOX9CJy1LdKeQ1QIXNWMrI3nJSMm9oD3sVYwn6XiusFWriUXtTLY+JsD0oH07jGqQ9T9u4ahnU74ISQcMhI9p/XavdRW2hl4ukHCeZCcPgdCvTN33O3nzAj3Eoa9RotHzbpyGcjzzHwm2p2FW0IOlQk+Er9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247040; c=relaxed/simple;
	bh=9d9HuVaLbxVvYIk0v7QFxagihDIyuBmHy3l8B29CCxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l68DvojM0Cz7Ls6LGlAgueYCNSMdbGxPHmcBtJiWP9eh7vleiBGhtnA5G2rfy8iWELWZM6Lwiy+YhMxTJL0aacD3EsPTLuXjxv6bnQp7Hg6DSn6FVXUk52vLUKOaFE2lTpipXoMz2x//9+nrOKbvdq6UWyKDeHVnhxM1rZ4RmEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAOXiQwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE60CC2BBFC;
	Mon, 24 Jun 2024 16:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719247039;
	bh=9d9HuVaLbxVvYIk0v7QFxagihDIyuBmHy3l8B29CCxM=;
	h=From:To:Cc:Subject:Date:From;
	b=XAOXiQwJP3v0AYOMXFbOl+aKwam/G8B8vHPH86S/9LShi99xORnlW4piK1/QXzERr
	 xSDLEVIY2XUL2OstfMJIdt0rq3JemXryccEJPkd4ghrh6UDdFQr1tbDgHrMymJ5lkT
	 LCJAwLpGg/YP4mak7hJUeKjerzj3Sjeuk9mEeI0PO4M8ngXVwYPSEkSZYIjYXv3lsO
	 IWmu9kkIzBkQryYrYGbzA0waCr299MRkDBhVI15NNGekWiHeTRxr6a39naS5fy6XeX
	 AT9Pv9joOgDX2Gg6Zy/ej9wfBbyGwtMGKM4NEGi3ynRBEI8qKiLmDIsSwZL2m2icP1
	 basUBX/zL+P3Q==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Brian Cain <bcain@quicinc.com>,
	linux-hexagon@vger.kernel.org,
	Guo Ren <guoren@kernel.org>,
	linux-csky@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	libc-alpha@sourceware.org,
	musl@lists.openwall.com
Subject: [PATCH v2 00/13] linux system call fixes
Date: Mon, 24 Jun 2024 18:36:58 +0200
Message-Id: <20240624163707.299494-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This is a minor update to v1 of this series. If there are no new
concerns, I would like to send this as a pull request for v6.10-rc6,
which is a little late, but these are all bug fixes. Changes since
v1 are:

 - collect acks
 - minor fixes to the changelog text
 - drop mips patch that was already merged
 - drop the time32 patch that caused build failures
 - fix a kernel/sys_ni.c stub bug that was exposed by
   the compat_sys_io_pgetevents_time64 change

     Arnd
 
--- 
Original series description:

I'm working on cleanup series for Linux system call handling, trying to
unify some of the architecture specific code there among other things.

In the process, I came across a number of bugs that are ABI relevant,
so I'm trying to merge these first. I found all of these by inspection,
not by running the code, so any extra review would help. I assume some
of the issues were already caught by existing LTP tests, while for others
we could add a test. Again, I did not check what is already there.

The sync_file_range and fadvise64_64 changes on sh, csky and hexagon
are likely to also require changes in the libc implementation.

Once the patches are reviewed, I plan to merge my changes as bugfixes
through the asm-generic tree, but architecture maintainers can also
pick them up directly to speed up the bugfix.

Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Brian Cain <bcain@quicinc.com>
Cc: linux-hexagon@vger.kernel.org
Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: libc-alpha@sourceware.org
Cc: musl@lists.openwall.com

Arnd Bergmann (13):
  ftruncate: pass a signed offset
  syscalls: fix compat_sys_io_pgetevents_time64 usage
  sparc: fix old compat_sys_select()
  sparc: fix compat recv/recvfrom syscalls
  parisc: use correct compat recv/recvfrom syscalls
  parisc: use generic sys_fanotify_mark implementation
  powerpc: restore some missing spu syscalls
  sh: rework sync_file_range ABI
  csky, hexagon: fix broken sys_sync_file_range
  hexagon: fix fadvise64_64 calling conventions
  s390: remove native mmap2() syscall
  syscalls: mmap(): use unsigned offset type consistently
  linux/syscalls.h: add missing __user annotations

 arch/arm64/include/asm/unistd32.h         |   2 +-
 arch/csky/include/uapi/asm/unistd.h       |   1 +
 arch/csky/kernel/syscall.c                |   2 +-
 arch/hexagon/include/asm/syscalls.h       |   6 +
 arch/hexagon/include/uapi/asm/unistd.h    |   1 +
 arch/hexagon/kernel/syscalltab.c          |   7 +
 arch/loongarch/kernel/syscall.c           |   2 +-
 arch/microblaze/kernel/sys_microblaze.c   |   2 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl |   2 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl |   2 +-
 arch/parisc/Kconfig                       |   1 +
 arch/parisc/kernel/sys_parisc32.c         |   9 -
 arch/parisc/kernel/syscalls/syscall.tbl   |   6 +-
 arch/powerpc/kernel/syscalls/syscall.tbl  |   6 +-
 arch/riscv/kernel/sys_riscv.c             |   4 +-
 arch/s390/kernel/syscall.c                |  27 ---
 arch/s390/kernel/syscalls/syscall.tbl     |   2 +-
 arch/sh/kernel/sys_sh32.c                 |  11 ++
 arch/sh/kernel/syscalls/syscall.tbl       |   3 +-
 arch/sparc/kernel/sys32.S                 | 221 ----------------------
 arch/sparc/kernel/syscalls/syscall.tbl    |   8 +-
 arch/x86/entry/syscalls/syscall_32.tbl    |   2 +-
 fs/open.c                                 |   4 +-
 include/asm-generic/syscalls.h            |   2 +-
 include/linux/compat.h                    |   2 +-
 include/linux/syscalls.h                  |  20 +-
 include/uapi/asm-generic/unistd.h         |   2 +-
 kernel/sys_ni.c                           |   2 +-
 28 files changed, 67 insertions(+), 292 deletions(-)
 create mode 100644 arch/hexagon/include/asm/syscalls.h

-- 
2.39.2



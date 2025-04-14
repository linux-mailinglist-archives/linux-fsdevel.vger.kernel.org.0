Return-Path: <linux-fsdevel+bounces-46378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CFFA88499
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 16:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E091889CAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 14:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004352741CF;
	Mon, 14 Apr 2025 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD2ttOfL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56554253932;
	Mon, 14 Apr 2025 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744638914; cv=none; b=lgEflMgym0l7/9Y7U35QVqjOcDIfdTWDzsRYzIPUG0MoIkN7GLi0HmPEwkwAepYNwtbmRoKEBSAUvAjnoqo6mjIyeh3HYDOqQGKmOXy8csfrVISiGMJTUCJ4pK326FrNTtM/fMQq7SYTnWYJQ44AerTefYNqiLfgv/3HeguRey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744638914; c=relaxed/simple;
	bh=8RqAkmbz2l81D3t0B9ThE8x0Hqu+VPdeWun13k7vuFc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pdnSyTmZHOe5bVnuPVe27rRwxEfmVKFzNQQAaUfuLhMTsSopMP808IK5veTUCNgz76aE41XTvN5EQrenhz4I2ONn8atF3Ts7gmbQHZwLiYUObOxlyCPcAejtDVdjElu0BPzmM0f0K09D+09ZH8LqKsSlogh5j6wdtpthTgt5YzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD2ttOfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9D6C4CEE2;
	Mon, 14 Apr 2025 13:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744638913;
	bh=8RqAkmbz2l81D3t0B9ThE8x0Hqu+VPdeWun13k7vuFc=;
	h=From:Subject:Date:To:Cc:From;
	b=UD2ttOfLL6Dn0Ntj/U5mh4Nakc5iP+k4+cIHXYXRxODW3PxgixSHqAyfi9r15tXm2
	 MToEhe5MMi7H1I2BC/owOfKXw++fXZZEQitp/LUT6n3F/eQEvNZboyrn89i8XKOZcG
	 SvxYlbGrLA0sRXCfFLpmX0AMFGOLmuCVtGmjU+o9FqC6OdLtPcsKqrXppnzPEJSuQB
	 i00TlXWZ93ClnJds60t4oz1y7+v2GxWFuqpjURuaYDNE3nxU8Arf0uN6+njzG8IRJB
	 cnzEeqnlvT1n7BOwx4RbPJhdcedDIhCgfnjPPwjnf+2OdyIfAjQph2gOJejJf5FOD0
	 ybcCLGjfL1IBA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/3] coredump: hand a pidfd to the usermode coredump
 helper
Date: Mon, 14 Apr 2025 15:55:04 +0200
Message-Id: <20250414-work-coredump-v2-0-685bf231f828@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALgT/WcC/12OwQ6CMBAFf4X07JIWCxhP/ofhUMoWGqQlW6waw
 r9bSLx4nMO8eSsLSBYDu2YrI4w2WO8SFKeM6UG5HsF2iVnBi5JLcYaXpxG0J+ye0wzc1EbVWEk
 hNUvOTGjs+9i7N4lbFRBaUk4P+8qkwoKUxyoXJZAWuzLYsHj6HA+i2MVfTP7FogAOlVbY6guvj
 ZG3EcnhI/fUs2bbti/AWVdmzgAAAA==
X-Change-ID: 20250413-work-coredump-0f7fa7e6414c
To: linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, 
 Luca Boccassi <luca.boccassi@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2587; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8RqAkmbz2l81D3t0B9ThE8x0Hqu+VPdeWun13k7vuFc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/Fd6fqqQ1+bGAvQXnhtbk/98PrlORWXZJ3NHPY/5Gv
 dwJrQ8md5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExE+SLDX4GH38pOS8g3ysfs
 s29leF7CxGl67tnM6bJyKoFrxIOUZRj+aSZotThFuGnZOTYtYX493+a9cpXWi6tR/x/+NgtSMfv
 ADwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Give userspace a way to instruct the kernel to install a pidfd for the
crashing process into the process started as a usermode helper. There's
still tricky race-windows that cannot be easily or sometimes not closed
at all by userspace. There's various ways like looking at the start time
of a process to make sure that the usermode helper process is started
after the crashing process but it's all very very brittle and fraught
with peril.

The crashed-but-not-reaped process can be killed by userspace before
coredump processing programs like systemd-coredump have had time to
manually open a PIDFD from the PID the kernel provides them, which means
they can be tricked into reading from an arbitrary process, and they run
with full privileges as they are usermode helper processes.

Even if that specific race-window wouldn't exist it's still the safest
and cleanest way to let the kernel provide the pidfd directly instead of
requiring userspace to do it manually. In parallel with this commit we
already have systemd adding support for this in [1].

When the usermode helper process is forked we install a pidfd file
descriptor three into the usermode helper's file descriptor table so
it's available to the exec'd program.

Since usermode helpers are either children of the system_unbound_wq
workqueue or kthreadd we know that the file descriptor table is empty
and can thus always use three as the file descriptor number.

Note, that we'll install a pidfd for the thread-group leader even if a
subthread is calling do_coredump(). We know that task linkage hasn't
been removed yet and even if this @current isn't the actual thread-group
leader we know that the thread-group leader cannot be reaped until
@current has exited.

[1]: https://github.com/systemd/systemd/pull/37125

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- Store a pid in struct coredump_params instead of a file.
- Link to v1: https://lore.kernel.org/20250414-work-coredump-v1-0-6caebc807ff4@kernel.org

---
Christian Brauner (3):
      pidfs: move O_RDWR into pidfs_alloc_file()
      coredump: fix error handling for replace_fd()
      coredump: hand a pidfd to the usermode coredump helper

 fs/coredump.c            | 68 +++++++++++++++++++++++++++++++++++++++++++-----
 fs/pidfs.c               |  1 +
 include/linux/coredump.h |  1 +
 kernel/fork.c            |  2 +-
 4 files changed, 65 insertions(+), 7 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250413-work-coredump-0f7fa7e6414c



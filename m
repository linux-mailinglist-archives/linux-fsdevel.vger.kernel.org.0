Return-Path: <linux-fsdevel+bounces-23613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 892F192FBF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 15:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3361C22383
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 13:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4430C17109D;
	Fri, 12 Jul 2024 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnvGcZis"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2222142E77;
	Fri, 12 Jul 2024 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792742; cv=none; b=nfaKKge+56vwonAX9Oq8dd/eCG9huUke7HNWmYK+3dR4PT/L60KRUBdTmmG1iK2jSHD2DnuevYKA5t82oNpCtju8kMjf73XkLuRLmNp/LEpD+olClIh68qWzjvlCkb+dOEVO7QMrQtiAdwRtPgo6vogvAyBAa4czCYEWqJaoBEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792742; c=relaxed/simple;
	bh=X8636AljHJoYrtKyFyyr59/HGScQY7Ic0JGcHN0bzY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gNoZf359+8sAocDrObUPxPCRt5+OgTlr2PRhHqVJtVQn936iHdc8wp878sUebSDNZ0LjVaewFdLiVe5wX/6H5MPEgwiUvE55AUy1yjZHhrYCLyZMleq3TM7XLURz3UmOBJJOI7RpHlEOZ1pgBZCvxmXbabR2r5GtZkNormWvn8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnvGcZis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01EBC32782;
	Fri, 12 Jul 2024 13:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720792742;
	bh=X8636AljHJoYrtKyFyyr59/HGScQY7Ic0JGcHN0bzY8=;
	h=From:To:Cc:Subject:Date:From;
	b=gnvGcZisVWk/FLvujHDslQPmnFJREJG7neDU1Okc3TuB1dbpJ8a55pz+opdYrrrXG
	 h1rmvWgltAwbn3EYDAop7kSpqQyBf2ECqtbUTtD1ajXy/GPjvNI/3Dw/Sxe+s3x300
	 pBgS/DIV7sBBUOjq1U+jejcpt5JiNg7Do9r5dO0q/SGuXI8UqjKsMwkBluMxmINm+V
	 7TE20M+FlsCvSl6FM5oK6lquS89dRzI0BE/fh8IAUpcanxNzbFxjBUO9c8ZoSMwDyU
	 +9lmbav9cvIy7nG527vDlVXScMs9N3PeCyGqAKeKWvyde2O6nNPBpuyx8nv3oD0ibM
	 9svKsSfqAmFoQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.11] vfs procfs
Date: Fri, 12 Jul 2024 15:58:52 +0200
Message-ID: <20240712-vfs-procfs-ce7e6c7cf26b@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3146; i=brauner@kernel.org; h=from:subject:message-id; bh=X8636AljHJoYrtKyFyyr59/HGScQY7Ic0JGcHN0bzY8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRNNJu7RSzoa7Wm9eU8l/hnfy6dS5vSoah89HC3wM/3j rYFt6/s6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIpGWMDBtdmaf3G0esivJv eLHs0Oo461KJWWnMp4qtAh3+GFRKPWf4p/rYcJmr/v4plucumIoKS/VmCHAUHXq66vOmQotg06m XmQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains work to allow restricting access to /proc/<pid>/mem. Over the
years various exploits started abusing /proc/<pid>/mem (cf. [1] and [2]).
Specifically [2] is interesting as it installed an arbitrary payload from
noexec storage into a running process and then executed it. That payload itself
included an ELF loader to run arbitrary code off of noexec storage.

The biggest problem is that /proc/<pid>/mem ignores page permissions by using
FOLL_FORCE which was discussed several times on- and off-list.

Unfortunately there are various use-cases using /proc/<pid>/mem making it
impossible to just turn it off. They at least include PTRACE_POKEDATA and the
seccomp notifier which is used to emulate system calls.

So give userspace a way to restrict access to /proc/<pid>/mem via kernel
command line options. Setting them to "all" restricts access for all processes
while "ptracer" will allow access to ptracers:

(1) Restrict the use of FOLL_FORCE via proc_mem.restrict_foll_force
(2) Restrict opening /proc/<pid>/mem for reading.
(3) Restrict opening /proc/<pid>/mem for writing.
(4) Restrict writing to /proc/<pid>/mem.

---

The level of fine-grained management isn't my favorite as it requires
distributions to have some level of knowledge around the implications of
FOLL_FORCE and /proc/<pid>/mem access in general. But the use-cases where
/proc/<pid>/mem access is needed do already imply a sophisticated knowledge
around its implications. Especially when it comes to the seccomp notifier and
gdb to inspect or emulate process state. So that ultimately swayed me to accept
this. If we need something simpler I'm all ears.

/* Testing */
clang: Debian clang version 16.0.6 (26)
gcc: (Debian 13.2.0-24)

All patches are based on v6.10-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
No known conflicts.

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.procfs

for you to fetch changes up to 39efa92f9e5fceb44edef5536c58e3750b9d638d:

  proc: restrict /proc/pid/mem (2024-06-18 12:26:54 +0200)

Please consider pulling these changes from the signed vfs-6.11.procfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.11.procfs

----------------------------------------------------------------
Adrian Ratiu (2):
      proc: pass file instead of inode to proc_mem_open
      proc: restrict /proc/pid/mem

 Documentation/admin-guide/kernel-parameters.txt |  38 +++++
 fs/proc/base.c                                  | 203 +++++++++++++++++++++++-
 fs/proc/internal.h                              |   2 +-
 fs/proc/task_mmu.c                              |   6 +-
 fs/proc/task_nommu.c                            |   2 +-
 security/Kconfig                                | 121 ++++++++++++++
 6 files changed, 363 insertions(+), 9 deletions(-)


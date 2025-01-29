Return-Path: <linux-fsdevel+bounces-40282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0DDA218B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 09:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1ED1659CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 08:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D1B19CC3C;
	Wed, 29 Jan 2025 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlW9ZHp9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD3C19A28D;
	Wed, 29 Jan 2025 08:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738138480; cv=none; b=sY/doN0hPMeYTXyyAgl/Af4Gy4obwOKpfS2JAA2YluJ4ROM0OYWjbTujQwfLxcc3kIZW1PXEvHsapI34Q0xHdBeGAw1rAr8gCVOiC4owJiTh3EBLGek+2j6ICIzktoByyiSiL6QEITGnrRkJGll0EWCT/XziruehHfBo4IdvRyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738138480; c=relaxed/simple;
	bh=Iw3ppgBY5sLOi1990ConwcQ4ZKtsA/u/PoORWMqt+Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vEs0t8gvLHfhMewMRbpGUHlMpfqKFaa6B8S40Io4NLIDcnyi8mvgBhh555w2RDegYZCj+vF/l3pl9jMOgiiIAqTg2L0/088WbHtgvc+YTq6WYoODJ1OGMZbAtOG1eya1SRU/7QdS2p4VXolm+ooUZoDwC7zXVYCJkpwaRgLzxLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlW9ZHp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2B1C4CED3;
	Wed, 29 Jan 2025 08:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738138479;
	bh=Iw3ppgBY5sLOi1990ConwcQ4ZKtsA/u/PoORWMqt+Lo=;
	h=Date:From:To:Cc:Subject:From;
	b=NlW9ZHp9VudwHkBpLCWjJBuDBOM5xiUGC07cPz+1W1pid4cQ3A23aWksXQ737B9sR
	 QDd52umKF10CvZNhYGFYGei1XAHJseyQp0LyDmsSJsoDYAfzEbofL8X6KHSGEPCc26
	 2W+9RofmVoDPUoLquZpvDHK14QBda+WL+OAQDLjkinLqC5/Koi4mthsxs5t8jg6CYo
	 pxXpX75EIxi2Dghm6JTtfA10LL/+lPRb/7AF6Nn7xCmcP9VisB1AnBBhWx2wV9X9nB
	 OvNjbL/K8y+RshuTeRQbLlQis7opaZApWFpYMNFLPZACBc1TNefz3hA3mgeQYZxdm6
	 3ObqC2JV6LywA==
Date: Wed, 29 Jan 2025 09:14:20 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Anna Schumaker <anna.schumaker@oracle.com>, 
	Ashutosh Dixit <ashutosh.dixit@intel.com>, Baoquan He <bhe@redhat.com>, 
	Bill O'Donnell <bodonnel@redhat.com>, Corey Minyard <cminyard@mvista.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Jani Nikula <jani.nikula@intel.com>, 
	Joel Granados <joel.granados@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [GIT PULL] sysctl constification changes for v6.14-rc1
Message-ID: <kndlh7lx2gfmz5m3ilwzp7fcsmimsnjgh434hnaro2pmy7evl6@jfui76m22kig>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus:

This is a continuation of the ctl_table constification work started in
commit 78eb4ea25cd5 ("sysctl: treewide: constify the ctl_table argument
of proc_handlers"). That commit allows the const qualifying of the
ctl_tables; with a few exceptions listed in the commit.

As with previous large tree-wide PRs [1], I'm sending it at the end of
the merge window to try to avoid unnecessary conflicts. I have rebased
it on top of what I see as your latest master (6d61a53dd6f5), but I can
rebase it again later if you prefer.

Testing was done in 0-day to avoid generating unnecessary merge
conflicts in linux-next. I do not expect any error/regression given that
all changes contained in this PR are non-functional.

Finally, if you need to regenerate it do:
  1. Run the spatch [2] with the coccichekck command [3].
  2. Run the sed command [4]

Best

[1] https://lore.kernel.org/all/20240724210014.mc6nima6cekgiukx@joelS2.panther.com/
[2] Spatch:
      virtual patch

      @
      depends on !(file in "net")
      disable optional_qualifier
      @

      identifier table_name != {
        watchdog_hardlockup_sysctl,
        iwcm_ctl_table,
        ucma_ctl_table,
        memory_allocation_profiling_sysctls,
        loadpin_sysctl_table
      };
      @@

      + const
      struct ctl_table table_name [] = { ... };

[3] Spatch command:
      make coccicheck MODE=patch \
        SPFLAGS="--in-place --include-headers --smpl-spacing --jobs=16" \
        COCCI=PATCH_FILE

[4] sed:
      sed --in-place \
        -e "s/struct ctl_table .table = &uts_kern/const struct ctl_table *table = \&uts_kern/" \
        kernel/utsname_sysctl.c

The following changes since commit 6d61a53dd6f55405ebcaea6ee38d1ab5a8856c2c:

  Merge tag 'f2fs-for-6.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs (2025-01-27 20:58:58 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/constfy-sysctl-6.14-rc1

for you to fetch changes up to 1751f872cc97f992ed5c4c72c55588db1f0021e1:

  treewide: const qualify ctl_tables where applicable (2025-01-28 13:48:37 +0100)

----------------------------------------------------------------
Summary:

  All ctl_table declared outside of functions and that remain unmodified after
  initialization are const qualified. This prevents unintended modifications to
  proc_handler function pointers by placing them in the .rodata section. This is
  a continuation of the tree-wide effort started a few releases ago with the
  constification of the ctl_table struct arguments in the sysctl API done in
  78eb4ea25cd5 ("sysctl: treewide: constify the ctl_table argument of
  proc_handlers")

Testing:

  Testing was done on 0-day and sysctl selftests in x86_64. The linux-next
  branch was not used for such a big change in order to avoid unnecessary merge
  conflicts

----------------------------------------------------------------
Joel Granados (1):
      treewide: const qualify ctl_tables where applicable

 arch/arm/kernel/isa.c                         | 2 +-
 arch/arm64/kernel/fpsimd.c                    | 4 ++--
 arch/arm64/kernel/process.c                   | 2 +-
 arch/powerpc/kernel/idle.c                    | 2 +-
 arch/powerpc/platforms/pseries/mobility.c     | 2 +-
 arch/riscv/kernel/process.c                   | 2 +-
 arch/riscv/kernel/vector.c                    | 2 +-
 arch/s390/appldata/appldata_base.c            | 2 +-
 arch/s390/kernel/debug.c                      | 2 +-
 arch/s390/kernel/hiperdispatch.c              | 2 +-
 arch/s390/kernel/topology.c                   | 2 +-
 arch/s390/mm/cmm.c                            | 2 +-
 arch/s390/mm/pgalloc.c                        | 2 +-
 arch/x86/entry/vdso/vdso32-setup.c            | 2 +-
 arch/x86/kernel/cpu/bus_lock.c                | 2 +-
 crypto/fips.c                                 | 2 +-
 drivers/base/firmware_loader/fallback_table.c | 2 +-
 drivers/cdrom/cdrom.c                         | 2 +-
 drivers/char/hpet.c                           | 2 +-
 drivers/char/ipmi/ipmi_poweroff.c             | 2 +-
 drivers/char/random.c                         | 2 +-
 drivers/gpu/drm/i915/i915_perf.c              | 2 +-
 drivers/gpu/drm/xe/xe_observation.c           | 2 +-
 drivers/hv/hv_common.c                        | 2 +-
 drivers/md/md.c                               | 2 +-
 drivers/misc/sgi-xp/xpc_main.c                | 4 ++--
 drivers/perf/arm_pmuv3.c                      | 2 +-
 drivers/perf/riscv_pmu_sbi.c                  | 2 +-
 drivers/scsi/scsi_sysctl.c                    | 2 +-
 drivers/scsi/sg.c                             | 2 +-
 drivers/tty/tty_io.c                          | 2 +-
 drivers/xen/balloon.c                         | 2 +-
 fs/aio.c                                      | 2 +-
 fs/cachefiles/error_inject.c                  | 2 +-
 fs/coda/sysctl.c                              | 2 +-
 fs/coredump.c                                 | 2 +-
 fs/dcache.c                                   | 2 +-
 fs/devpts/inode.c                             | 2 +-
 fs/eventpoll.c                                | 2 +-
 fs/exec.c                                     | 2 +-
 fs/file_table.c                               | 2 +-
 fs/fuse/sysctl.c                              | 2 +-
 fs/inode.c                                    | 2 +-
 fs/lockd/svc.c                                | 2 +-
 fs/locks.c                                    | 2 +-
 fs/namei.c                                    | 2 +-
 fs/namespace.c                                | 2 +-
 fs/nfs/nfs4sysctl.c                           | 2 +-
 fs/nfs/sysctl.c                               | 2 +-
 fs/notify/dnotify/dnotify.c                   | 2 +-
 fs/notify/fanotify/fanotify_user.c            | 2 +-
 fs/notify/inotify/inotify_user.c              | 2 +-
 fs/ocfs2/stackglue.c                          | 2 +-
 fs/pipe.c                                     | 2 +-
 fs/quota/dquot.c                              | 2 +-
 fs/sysctls.c                                  | 2 +-
 fs/userfaultfd.c                              | 2 +-
 fs/verity/init.c                              | 2 +-
 fs/xfs/xfs_sysctl.c                           | 2 +-
 init/do_mounts_initrd.c                       | 2 +-
 io_uring/io_uring.c                           | 2 +-
 ipc/ipc_sysctl.c                              | 2 +-
 ipc/mq_sysctl.c                               | 2 +-
 kernel/acct.c                                 | 2 +-
 kernel/bpf/syscall.c                          | 2 +-
 kernel/delayacct.c                            | 2 +-
 kernel/exit.c                                 | 2 +-
 kernel/hung_task.c                            | 2 +-
 kernel/kexec_core.c                           | 2 +-
 kernel/kprobes.c                              | 2 +-
 kernel/latencytop.c                           | 2 +-
 kernel/locking/lockdep.c                      | 2 +-
 kernel/panic.c                                | 2 +-
 kernel/pid.c                                  | 2 +-
 kernel/pid_namespace.c                        | 2 +-
 kernel/pid_sysctl.h                           | 2 +-
 kernel/printk/sysctl.c                        | 2 +-
 kernel/reboot.c                               | 2 +-
 kernel/sched/autogroup.c                      | 2 +-
 kernel/sched/core.c                           | 2 +-
 kernel/sched/deadline.c                       | 2 +-
 kernel/sched/fair.c                           | 2 +-
 kernel/sched/rt.c                             | 2 +-
 kernel/sched/topology.c                       | 2 +-
 kernel/seccomp.c                              | 2 +-
 kernel/signal.c                               | 2 +-
 kernel/stackleak.c                            | 2 +-
 kernel/sysctl-test.c                          | 6 +++---
 kernel/sysctl.c                               | 4 ++--
 kernel/time/timer.c                           | 2 +-
 kernel/trace/ftrace.c                         | 2 +-
 kernel/trace/trace_events_user.c              | 2 +-
 kernel/umh.c                                  | 2 +-
 kernel/utsname_sysctl.c                       | 4 ++--
 kernel/watchdog.c                             | 2 +-
 lib/test_sysctl.c                             | 6 +++---
 mm/compaction.c                               | 2 +-
 mm/hugetlb.c                                  | 2 +-
 mm/hugetlb_vmemmap.c                          | 2 +-
 mm/memory-failure.c                           | 2 +-
 mm/oom_kill.c                                 | 2 +-
 mm/page-writeback.c                           | 2 +-
 mm/page_alloc.c                               | 2 +-
 security/apparmor/lsm.c                       | 2 +-
 security/keys/sysctl.c                        | 2 +-
 security/yama/yama_lsm.c                      | 2 +-
 106 files changed, 114 insertions(+), 114 deletions(-)

-- 

Joel Granados


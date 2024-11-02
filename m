Return-Path: <linux-fsdevel+bounces-33511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1999A9B9CD4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D245B21858
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F173A14A4D6;
	Sat,  2 Nov 2024 05:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FYAkBL3j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF50921364;
	Sat,  2 Nov 2024 05:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730523746; cv=none; b=Vx53yh3Bp9vZtqgmRf04Tlw/lYpMBtpeHkS7mYMC3B5CVHzhXvG3R1jDg+B9RB6/JsfGuhzr32P/ZayoXp81vxe+A3WEqFbIlRWsDaIYYK4J9GAVL6ZSFxEeXO/NTOckGE5m9/Ku8uzO9oxDFWlv2bkXIX7FqVrAdQr8TxkY3aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730523746; c=relaxed/simple;
	bh=kGFVdWWgwPLcOLv8kFKbF4hiZI3g7hWOKWCfBJ6i/74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBZK+xz0gE1xMNXUtOpRJCSs1WsJ/IoKauGRi2YIOFa18TKYvzv8piiiXKOzv0x9GNIwpV3VI1k3Bp9U4daYRvC133QgfBnAoXAanqn0WrOwy9fdCNoSFAagrVe92hmJ1DoVI5NAX1s0w3WIEJbzmUg3iep7hVNzJ08G8C/0U/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FYAkBL3j; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4F81d0sfC46fv7mW68t4r9q10n8w2Wf3N+b7YkMfZcQ=; b=FYAkBL3jYvwYpguF4eLYSfb7zT
	P6ET9B2Jt4g2a4LqeRIOLimsSVFygi4X4/yqAx+/rhY07xj583Ml5H17IJRimfUUbzUGKM5AqpBoW
	L64IaZ15GjEraP8g4jb/XEfeqxlLV09SUuAcKU5+qGKhTGOY9X3TLzzhWsmLvqllzRbcUWh6Q9SnJ
	YxdzVoCIx5C/Ji7wJNfwTesquTABLh9GslqN+o4hsddwDCuSAcbu301wY/i36GWT8g7Hr5YCly0vR
	XLfowyRmFWUWlV+0LrfDbdFv85FVZvZMagaClR+oxsNmyh5UgFaoiujac8VaDMOOBc3f0qg3Fj3M+
	OTqpoBcw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76HD-0000000AHep-3tWz;
	Sat, 02 Nov 2024 05:02:19 +0000
Date: Sat, 2 Nov 2024 05:02:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, kvm@vger.kernel.org,
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCHSET v3] struct fd and memory safety
Message-ID: <20241102050219.GA2450028@ZenIV>
References: <20240730050927.GC5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730050927.GC5334@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

	struct fd stuff got rebased (with fairly minor conflicts), branch
lives in the same place -
	git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.fd

	Changes since the previous version:
* branch rebased to 6.12-rc2
* the fixes gone into mainline.
* so's the conversion to new layout and accessors.
* bpf side of things (with modifications) is gone into mainline (via bpf tree).
* struct fderr side dropped - overlayfs doesn't need that anymore and while it's
possible that use cases show up, for now there's none.
* coda_parse_fd() part dropped - no longer valid due to mainline changes.
* fs/xattr.c and fs/stat.c changes moved to separate branches (#work.xattr2 and
#work.statx2 resp.)

Individual patches in followups; review and testing would be welcome.
If no objections materialize, I'm going to put that into #for-next on
Monday.

Diffstat:
 arch/alpha/kernel/osf_sys.c                |   5 +-
 arch/arm/kernel/sys_oabi-compat.c          |  10 +-
 arch/powerpc/kvm/book3s_64_vio.c           |  21 +-
 arch/powerpc/kvm/powerpc.c                 |  24 +--
 arch/powerpc/platforms/cell/spu_syscalls.c |  68 +++----
 arch/x86/kernel/cpu/sgx/main.c             |  10 +-
 arch/x86/kvm/svm/sev.c                     |  39 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c  |  23 +--
 drivers/gpu/drm/drm_syncobj.c              |   9 +-
 drivers/infiniband/core/ucma.c             |  19 +-
 drivers/infiniband/core/uverbs_cmd.c       |   8 +-
 drivers/media/mc/mc-request.c              |  18 +-
 drivers/media/rc/lirc_dev.c                |  13 +-
 drivers/vfio/group.c                       |   6 +-
 drivers/vfio/virqfd.c                      |  16 +-
 drivers/virt/acrn/irqfd.c                  |  13 +-
 drivers/xen/privcmd.c                      |  28 +--
 fs/btrfs/ioctl.c                           |   5 +-
 fs/eventfd.c                               |   9 +-
 fs/eventpoll.c                             |  38 ++--
 fs/ext4/ioctl.c                            |  21 +-
 fs/f2fs/file.c                             |  15 +-
 fs/fcntl.c                                 |  42 ++--
 fs/fhandle.c                               |   5 +-
 fs/fsopen.c                                |  19 +-
 fs/fuse/dev.c                              |   6 +-
 fs/ioctl.c                                 |  23 +--
 fs/kernel_read_file.c                      |  12 +-
 fs/locks.c                                 |  15 +-
 fs/namei.c                                 |  13 +-
 fs/namespace.c                             |  47 ++---
 fs/notify/fanotify/fanotify_user.c         |  44 ++---
 fs/notify/inotify/inotify_user.c           |  38 ++--
 fs/ocfs2/cluster/heartbeat.c               |  24 +--
 fs/open.c                                  |  61 +++---
 fs/quota/quota.c                           |  12 +-
 fs/read_write.c                            | 145 +++++---------
 fs/readdir.c                               |  28 +--
 fs/remap_range.c                           |  11 +-
 fs/select.c                                |  48 ++---
 fs/signalfd.c                              |   9 +-
 fs/smb/client/ioctl.c                      |  11 +-
 fs/splice.c                                |  78 +++-----
 fs/statfs.c                                |  12 +-
 fs/sync.c                                  |  29 ++-
 fs/timerfd.c                               |  40 ++--
 fs/utimes.c                                |  11 +-
 fs/xfs/xfs_exchrange.c                     |  18 +-
 fs/xfs/xfs_handle.c                        |  16 +-
 fs/xfs/xfs_ioctl.c                         |  69 ++-----
 include/linux/cleanup.h                    |   2 +-
 include/linux/file.h                       |   7 +-
 include/linux/netlink.h                    |   2 +-
 io_uring/sqpoll.c                          |  29 +--
 ipc/mqueue.c                               | 109 +++--------
 kernel/cgroup/cgroup.c                     |  21 +-
 kernel/events/core.c                       |  63 ++----
 kernel/module/main.c                       |  15 +-
 kernel/nsproxy.c                           |   5 +-
 kernel/pid.c                               |  20 +-
 kernel/signal.c                            |  29 +--
 kernel/sys.c                               |  15 +-
 kernel/taskstats.c                         |  18 +-
 kernel/watch_queue.c                       |   6 +-
 mm/fadvise.c                               |  10 +-
 mm/filemap.c                               |  17 +-
 mm/memcontrol-v1.c                         |  44 ++---
 mm/readahead.c                             |  17 +-
 net/core/net_namespace.c                   |  10 +-
 net/netlink/af_netlink.c                   |   9 +-
 net/socket.c                               | 303 +++++++++++++----------------
 security/integrity/ima/ima_main.c          |   7 +-
 security/landlock/syscalls.c               |  45 ++---
 security/loadpin/loadpin.c                 |   8 +-
 sound/core/pcm_native.c                    |   2 +-
 virt/kvm/eventfd.c                         |  15 +-
 virt/kvm/vfio.c                            |  14 +-
 77 files changed, 751 insertions(+), 1395 deletions(-)

Shortlog and commit summaries:

01/28) net/socket.c: switch to CLASS(fd)
	Get rid of the sockfd_lookup_light() and associated irregularities;
fput_light() gone, old users of sockfd_lookup_light() switched to CLASS(fd) +
sock_from_file().

02/28) regularize emptiness checks in fini_module(2) and vfs_dedupe_file_range()

Getting rid of passing struct fd by reference:
03/28) timerfd: switch to CLASS(fd, ...)
04/28) get rid of perf_fget_light(), convert kernel/events/core.c to CLASS(fd)

do_mq_notify() regularization:
05/28) switch netlink_getsockbyfilp() to taking descriptor
06/28) do_mq_notify(): saner skb freeing on failures
07/28) do_mq_notify(): switch to CLASS(fd, ...)

After that the weirdness with reassignments in do_mq_notify() is gone
(and, IMO, the result is easier to follow).

08/28) simplify xfs_find_handle() a bit
	Massage to get rid of reassignment there; simplifies control flow...

Making sure that fdget() and fdput() are done in the same function:
09/28) convert vmsplice() to CLASS(fd, ...)

Deal with fdget_raw() and fdget_pos() users - all trivial to convert.
10/28) fdget_raw() users: switch to CLASS(fd_raw, ...)
11/28) introduce "fd_pos" class, convert fdget_pos() users to it.

Prep for fdget() conversions:
12/28) o2hb_region_dev_store(): avoid goto around fdget()/fdput()
13/28) privcmd_ioeventfd_assign(): don't open-code eventfd_ctx_fdget()

14/28) fdget(), trivial conversions.
	Big one: all callers that have fdget() done the first thing in
scope, with all matching fdput() immediately followed by leaving the
scope.  All of those are trivial to convert.
15/28) fdget(), more trivial conversions
	Same, except that fdget() is preceded by some work.  All fdput()
are still immediately followed by leaving the scope.  These are also
trivial to convert, and along with the previous commit that takes care
of the majority of fdget() calls.

16/28) convert do_preadv()/do_pwritev()
	fdput() is transposable with everything done after it (inc_syscw()
et.al.)
17/28) convert cachestat(2)
	fdput() is transposable with copy_to_user() downstream of it.

18/28) switch spufs_calls_{get,put}() to CLASS() use
19/28) convert spu_run(2)
	fdput() used to be followed by spufs_calls_put(); we could transpose
those two, but spufs_calls_get()/spufd_calls_put() itself can be converted
to CLASS() use and it's cleaner that way.

20/28) convert media_request_get_by_fd()
	fdput() is transposable with debugging printk

21/28) convert cifs_ioctl_copychunk()
	fdput() moved past mnt_drop_file_write(); harmless, if somewhat
cringeworthy.  Reordering could be avoided either by adding an explicit
scope or by making mnt_drop_file_write() called via __cleanup...

22/28) convert vfs_dedupe_file_range()
	fdput() is followed by checking fatal_signal_pending() (and aborting
the loop in such case).  fdput() is transposable with that check.
Yes, it'll probably end up with slightly fatter code (call after the
check has returned false + call on the almost never taken out-of-line path
instead of one call before the check), but it's not worth bothering with
explicit extra scope there (or dragging the check into the loop condition,
for that matter).

23/28) convert do_select()
	take the logics from fdget() to fdput() into an inlined helper -
with existing wait_key_set() subsumed into that.
24/28) do_pollfd(): convert to CLASS(fd)
	lift setting ->revents into the caller, so that failure exits
(including the early one) would be plain returns.

25/28) assorted variants of irqfd setup: convert to CLASS(fd)
	fdput() is transposable with kfree(); some reordering
is required in one of those (we do fdget() a bit earlier there).
26/28) memcg_write_event_control(): switch to CLASS(fd)
	similar to the previous.  As the matter of fact, there
might be a missing common helper or two hiding in both...

27/28) css_set_fork(): switch to CLASS(fd_raw, ...)
	could be separated from the series; its use of fget_raw()
could be converted to fdget_raw(), with the result convertible to
CLASS(fd_raw)

28/28) deal with the last remaing boolean uses of fd_file()
	most of them had been converted to fd_empty() by now; pick
the few remaining strugglers.


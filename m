Return-Path: <linux-fsdevel+bounces-23615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC84992FC04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 16:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AEF61C21E20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 14:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202A1171066;
	Fri, 12 Jul 2024 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwBF1oR5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E76315DBAE;
	Fri, 12 Jul 2024 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792860; cv=none; b=noccvWFdqG8wNsVsklQ4fRVwcmD96rusQ5DNxqI6CjxqnnP9KnF4evY5p8daOMdjk2z901XRxfQAbXjzay3rg5sy3Vba8ACMOJGzDERIIr4AiCXrLntK3d30RVTcN5dr79vLTX/gTfDFFXlVCYlq+NGYFbzUUiMcPOIQBn/Re7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792860; c=relaxed/simple;
	bh=s0eXZj+LH1XIcG1cQW3pPzl+sdAPCfbCtdGH6y0LIs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hs7uC+OOctGX6vh0lgdpooCOkVia9I/7Jqwim0qtHPHRU/DgEuaQD0rCC7c/2R+OTqJKFv5Rat5yBUPP81CbSXTvdcBTfOiqHgZqesPW+O2YGhG57YGmvHhddmoKTbOTeBAWOr2j7wPaXcWl4FYOY4/mTf73tRoegvWq910eR7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwBF1oR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E642BC32782;
	Fri, 12 Jul 2024 14:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720792860;
	bh=s0eXZj+LH1XIcG1cQW3pPzl+sdAPCfbCtdGH6y0LIs4=;
	h=From:To:Cc:Subject:Date:From;
	b=rwBF1oR5YRcWEJx0i2L8OyCvYOdo9bpMUHJhj1AlRWmM/q5JGylBDmQ70qkSeUEqR
	 fixcl+Td1jlDm6mR3l5/k/ri+hGJtsmTv+uYbHEvrlWt3baxacftMCwNVW96O6fsDf
	 MndnZRDPPnlJfAUL/m4SfbsMMRz77Ox3r7H84Vz04VragiUTsqjarNgUQSXOT8Z+58
	 uXVaHhFltQgnQVC6/xg506/7Ydi/BYsp2vYJeNlc7WNcafGdVj9FdOHCkw3JHhkriz
	 0ZFAdFvNjO9ny+EkGS4yJLFE/LtBgjMVLXCtP3tn4LF7nFZ6o+8XElrFciYiIpscAF
	 pH/qWJXaRZeLg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.11] vfs nsfs
Date: Fri, 12 Jul 2024 16:00:48 +0200
Message-ID: <20240712-vfs-nsfs-bb9a28102667@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6057; i=brauner@kernel.org; h=from:subject:message-id; bh=s0eXZj+LH1XIcG1cQW3pPzl+sdAPCfbCtdGH6y0LIs4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRNNBdaZSehU1+7umizpcBSsbVzsmQFe09qRm+fuOrb9 BdSJwQaOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCEsLI8PDv5FuvHotfs2KY wbn8+JbVs0QYt21/88W1z177cv/BxdwM/9SEnffcnLdC7sUqUw+zLuN8ecXy1O8tSTNWS8xeOok xmwcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This adds ioctls allowing to translate PIDs between PID namespaces.

The motivating use-case comes from LXCFS which is a tiny fuse filesystem used
to virtualize various aspects of procfs. LXCFS is run on the host. The files
and directories it creates can be bind-mounted by e.g. a container at startup
and mounted over the various procfs files the container wishes to have
virtualized.

When e.g. a read request for uptime is received, LXCFS will receive the pid of
the reader. In order to virtualize the corresponding read, LXCFS needs to know
the pid of the init process of the reader's pid namespace.

In order to do this, LXCFS first needs to fork() two helper processes. The
first helper process setns() to the readers pid namespace. The second helper
process is needed to create a process that is a proper member of the pid
namespace.

The second helper process then creates a ucred message with ucred.pid set to 1
and sends it back to LXCFS. The kernel will translate the ucred.pid field to
the corresponding pid number in LXCFS's pid namespace. This way LXCFS can learn
the init pid number of the reader's pid namespace and can go on to virtualize.

Since these two forks() are costly LXCFS maintains an init pid cache that
caches a given pid for a fixed amount of time. The cache is pruned during new
read requests. However, even with the cache the hit of the two forks() is
singificant when a very large number of containers are running.

So this adds a simple set of ioctls that let's a caller translate PIDs from and
into a given PID namespace. This significantly improves performance with a very
simple change.

To protect against races pidfds can be used to check whether the process is
still valid.

/* Testing */
clang: Debian clang version 16.0.6 (26)
gcc: (Debian 13.2.0-24)

All patches are based on v6.10-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
[1]: This contains a merge conflict with the vfs-6.11.mount pull request
     https://lore.kernel.org/r/20240712-vfs-mount-8fd93381a87f@brauner

     After conflict resolution the merge diff looks like this:

diff --cc fs/nsfs.c
index af352dadffe1,a23c827a0299..ad6bb91a3e23
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@@ -144,22 -147,56 +148,69 @@@ static long ns_ioctl(struct file *filp
  		argp = (uid_t __user *) arg;
  		uid = from_kuid_munged(current_user_ns(), user_ns->owner);
  		return put_user(uid, argp);
 +	case NS_GET_MNTNS_ID: {
 +		struct mnt_namespace *mnt_ns;
 +		__u64 __user *idp;
 +		__u64 id;
 +
 +		if (ns->ops->type != CLONE_NEWNS)
 +			return -EINVAL;
 +
 +		mnt_ns = container_of(ns, struct mnt_namespace, ns);
 +		idp = (__u64 __user *)arg;
 +		id = mnt_ns->seq;
 +		return put_user(id, idp);
 +	}
+ 	case NS_GET_PID_FROM_PIDNS:
+ 		fallthrough;
+ 	case NS_GET_TGID_FROM_PIDNS:
+ 		fallthrough;
+ 	case NS_GET_PID_IN_PIDNS:
+ 		fallthrough;
+ 	case NS_GET_TGID_IN_PIDNS:
+ 		if (ns->ops->type != CLONE_NEWPID)
+ 			return -EINVAL;
+ 
+ 		ret = -ESRCH;
+ 		pid_ns = container_of(ns, struct pid_namespace, ns);
+ 
+ 		rcu_read_lock();
+ 
+ 		if (ioctl == NS_GET_PID_IN_PIDNS ||
+ 		    ioctl == NS_GET_TGID_IN_PIDNS)
+ 			tsk = find_task_by_vpid(arg);
+ 		else
+ 			tsk = find_task_by_pid_ns(arg, pid_ns);
+ 		if (!tsk)
+ 			break;
+ 
+ 		switch (ioctl) {
+ 		case NS_GET_PID_FROM_PIDNS:
+ 			ret = task_pid_vnr(tsk);
+ 			break;
+ 		case NS_GET_TGID_FROM_PIDNS:
+ 			ret = task_tgid_vnr(tsk);
+ 			break;
+ 		case NS_GET_PID_IN_PIDNS:
+ 			ret = task_pid_nr_ns(tsk, pid_ns);
+ 			break;
+ 		case NS_GET_TGID_IN_PIDNS:
+ 			ret = task_tgid_nr_ns(tsk, pid_ns);
+ 			break;
+ 		default:
+ 			ret = 0;
+ 			break;
+ 		}
+ 		rcu_read_unlock();
+ 
+ 		if (!ret)
+ 			ret = -ESRCH;
+ 		break;
  	default:
- 		return -ENOTTY;
+ 		ret = -ENOTTY;
  	}
+ 
+ 	return ret;
  }
  
  int ns_get_name(char *buf, size_t size, struct task_struct *task,
diff --cc include/uapi/linux/nsfs.h
index 56e8b1639b98,faeb9195da08..b133211331f6
--- a/include/uapi/linux/nsfs.h
+++ b/include/uapi/linux/nsfs.h
@@@ -15,7 -15,13 +15,15 @@@
  #define NS_GET_NSTYPE		_IO(NSIO, 0x3)
  /* Get owner UID (in the caller's user namespace) for a user namespace */
  #define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
 +/* Get the id for a mount namespace */
 +#define NS_GET_MNTNS_ID		_IO(NSIO, 0x5)
+ /* Translate pid from target pid namespace into the caller's pid namespace. */
 -#define NS_GET_PID_FROM_PIDNS	_IOR(NSIO, 0x5, int)
++#define NS_GET_PID_FROM_PIDNS	_IOR(NSIO, 0x6, int)
+ /* Return thread-group leader id of pid in the callers pid namespace. */
+ #define NS_GET_TGID_FROM_PIDNS	_IOR(NSIO, 0x7, int)
+ /* Translate pid from caller's pid namespace into a target pid namespace. */
 -#define NS_GET_PID_IN_PIDNS	_IOR(NSIO, 0x6, int)
++#define NS_GET_PID_IN_PIDNS	_IOR(NSIO, 0x8, int)
+ /* Return thread-group leader id of pid in the target pid namespace. */
 -#define NS_GET_TGID_IN_PIDNS	_IOR(NSIO, 0x8, int)
++#define NS_GET_TGID_IN_PIDNS	_IOR(NSIO, 0x9, int)
  
  #endif /* __LINUX_NSFS_H */

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.nsfs

for you to fetch changes up to ca567df74a28a9fb368c6b2d93e864113f73f5c2:

  nsfs: add pid translation ioctls (2024-06-25 23:00:41 +0200)

Please consider pulling these changes from the signed vfs-6.11.nsfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.11.nsfs

----------------------------------------------------------------
Christian Brauner (1):
      nsfs: add pid translation ioctls

 fs/nsfs.c                 | 53 ++++++++++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/nsfs.h |  8 +++++++
 2 files changed, 60 insertions(+), 1 deletion(-)


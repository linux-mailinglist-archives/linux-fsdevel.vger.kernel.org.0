Return-Path: <linux-fsdevel+bounces-23991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE4F937736
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 13:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58826281F86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 11:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FF685931;
	Fri, 19 Jul 2024 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmbTI5Ho"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B8C1E871
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 11:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721389347; cv=none; b=KN2mX22FUM6t1R0UYiUIfxS2ncZ7YBgsvbD8x5CoHHU5bBS6qquzEHAUF0xo6GHcZC6kV5mnSouOvsq0h/BGJeYiCVXFNfGmIhZ3UFm72aqx1vxLfEt+3W8K1/UTl94PPuCgEP2rYfkSyIdzEeGBmrYbdylXS/ZJU5dVBMuB+jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721389347; c=relaxed/simple;
	bh=nA/KY/f3qaDleqGH7RoVYLI6yNbc3/rxyRsh7BbY8q4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ibQ0A2Wzx0JTgGhv7M/XqfEbMu/EmnnqRKGMucaMhdyon2CJYAYTtSOeruPzXgRL23L74WKhMmreR1nfIzKWQZrfIkzRmjpgBvRpXOJFPb2EwaWPieCsF3pCSRDBLFPB570QoEU5TJjQeaycPRCVaFc0meZCYKEYU4WaN/VKhFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmbTI5Ho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DD4C32782;
	Fri, 19 Jul 2024 11:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721389346;
	bh=nA/KY/f3qaDleqGH7RoVYLI6yNbc3/rxyRsh7BbY8q4=;
	h=From:Subject:Date:To:Cc:From;
	b=QmbTI5HottTI+G5XLAV7sIPfHYMkF7Tg3RVOHf1RzvzY1Spv35qykVfw4TxS/ziLE
	 ESKT3FCdWwQve1YwkLBk0RnNUekg7eYcBwKxWtamCBrhMt+tjXUZvTSBhco2yll8LC
	 vL+dmOtEEeYoN0njgyDZimVTaOx/5h6d274RJga5CulNVpJn27KTKmeW69VoQh9GoI
	 0yvVxsj7OSLgT53xbseWNbdogQr8ghet0OSoCWgtJvbBRBpJblwiAymUN1heFCEi+U
	 G4HlQ0HLkMCPpNDNc4f6lapAfTfqug0ba3e1dtM87/tS1HWCf5L3XcYA1D3OBoCkv3
	 Jl4ejQhpbSd7Q==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/5] nsfs: iterate through mount namespaces
Date: Fri, 19 Jul 2024 13:41:47 +0200
Message-Id: <20240719-work-mount-namespace-v1-0-834113cab0d2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPtQmmYC/x3MywrCMBCF4Vcps3Ykidag24IP4FZcTOLUBklSJ
 vUCpe9u6vI/cL4ZCkvgAqdmBuF3KCGnGnrTgB8oPRjDvTYYZfbKqhY/WZ4Y8ytNmChyGckzanN
 wdkda962Heh2F+/D9s1e4nDu41dFRYXRCyQ+rGKlMLNsVRmVRH2FZfsSzWtOPAAAA
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Karel Zak <kzak@redhat.com>, Stephane Graber <stgraber@stgraber.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=openpgp-sha256; l=9244; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nA/KY/f3qaDleqGH7RoVYLI6yNbc3/rxyRsh7BbY8q4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTNClQ4cnxhgBgHD4OkbFTSO4Y7W/NY7257tfhD2Mceo
 wpbTo75HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOpLGf478e3vmPds9qDniuU
 LLXfMaSXXH2mH6K0wXxukYqMwGM/K0aGE2rZ3RMObzl+b/YKp6rXVctqv3yoVeBn8vFwC326R92
 OFQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

Recently, we added the ability to list mounts in other mount namespaces
and the ability to retrieve namespace file descriptors without having to
go through procfs by deriving them from pidfds.

This extends nsfs in two ways:

(1) Add the ability to retrieve information about a mount namespace via
    NS_MNT_GET_INFO. This will return the mount namespace id and the
    number of mounts currently in the mount namespace. The number of
    mounts can be used to size the buffer that needs to be used for
    listmount() and is in general useful without having to actually
    iterate through all the mounts.

    The structure is extensible.

(2) Add the ability to iterate through all mount namespaces over which
    the caller holds privilege returning the file descriptor for the
    next or previous mount namespace.

    To retrieve a mount namespace the caller must be privileged wrt to
    it's owning user namespace. This means that PID 1 on the host can
    list all mounts in all mount namespaces or that a container can list
    all mounts of its nested containers.

    Optionally pass a structure for NS_MNT_GET_INFO with
    NS_MNT_GET_{PREV,NEXT} to retrieve information about the mount
    namespace in one go.

(1) and (2) can be implemented for other namespace types easily.

Together with recent api additions this means one can iterate through
all mounts in all mount namespaces without ever touching procfs. Here's
a sample program list_all_mounts_everywhere.c:

  // SPDX-License-Identifier: GPL-2.0-or-later

  #define _GNU_SOURCE
  #include <asm/unistd.h>
  #include <assert.h>
  #include <errno.h>
  #include <fcntl.h>
  #include <getopt.h>
  #include <linux/stat.h>
  #include <sched.h>
  #include <stddef.h>
  #include <stdint.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <sys/ioctl.h>
  #include <sys/param.h>
  #include <sys/pidfd.h>
  #include <sys/stat.h>
  #include <sys/statfs.h>

  #define die_errno(format, ...)                                             \
  	do {                                                               \
  		fprintf(stderr, "%m | %s: %d: %s: " format "\n", __FILE__, \
  			__LINE__, __func__, ##__VA_ARGS__);                \
  		exit(EXIT_FAILURE);                                        \
  	} while (0)

  /* Get the id for a mount namespace */
  #define NS_GET_MNTNS_ID		_IO(0xb7, 0x5)
  /* Get next mount namespace. */

  struct mnt_ns_info {
  	__u32 size;
  	__u32 nr_mounts;
  	__u64 mnt_ns_id;
  };

  #define MNT_NS_INFO_SIZE_VER0 16 /* size of first published struct */

  /* Get information about namespace. */
  #define NS_MNT_GET_INFO		_IOR(0xb7, 10, struct mnt_ns_info)
  /* Get next namespace. */
  #define NS_MNT_GET_NEXT		_IOR(0xb7, 11, struct mnt_ns_info)
  /* Get previous namespace. */
  #define NS_MNT_GET_PREV		_IOR(0xb7, 12, struct mnt_ns_info)

  #define PIDFD_GET_MNT_NAMESPACE _IO(0xFF, 3)

  #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */

  #define __NR_listmount 458
  #define __NR_statmount 457

  /*
   * @mask bits for statmount(2)
   */
  #define STATMOUNT_SB_BASIC		0x00000001U     /* Want/got sb_... */
  #define STATMOUNT_MNT_BASIC		0x00000002U	/* Want/got mnt_... */
  #define STATMOUNT_PROPAGATE_FROM	0x00000004U	/* Want/got propagate_from */
  #define STATMOUNT_MNT_ROOT		0x00000008U	/* Want/got mnt_root  */
  #define STATMOUNT_MNT_POINT		0x00000010U	/* Want/got mnt_point */
  #define STATMOUNT_FS_TYPE		0x00000020U	/* Want/got fs_type */
  #define STATMOUNT_MNT_NS_ID             0x00000040U     /* Want/got mnt_ns_id */
  #define STATMOUNT_MNT_OPTS              0x00000080U     /* Want/got mnt_opts */

  struct statmount {
  	__u32 size;		/* Total size, including strings */
  	__u32 mnt_opts;
  	__u64 mask;		/* What results were written */
  	__u32 sb_dev_major;	/* Device ID */
  	__u32 sb_dev_minor;
  	__u64 sb_magic;		/* ..._SUPER_MAGIC */
  	__u32 sb_flags;		/* SB_{RDONLY,SYNCHRONOUS,DIRSYNC,LAZYTIME} */
  	__u32 fs_type;		/* [str] Filesystem type */
  	__u64 mnt_id;		/* Unique ID of mount */
  	__u64 mnt_parent_id;	/* Unique ID of parent (for root == mnt_id) */
  	__u32 mnt_id_old;	/* Reused IDs used in proc/.../mountinfo */
  	__u32 mnt_parent_id_old;
  	__u64 mnt_attr;		/* MOUNT_ATTR_... */
  	__u64 mnt_propagation;	/* MS_{SHARED,SLAVE,PRIVATE,UNBINDABLE} */
  	__u64 mnt_peer_group;	/* ID of shared peer group */
  	__u64 mnt_master;	/* Mount receives propagation from this ID */
  	__u64 propagate_from;	/* Propagation from in current namespace */
  	__u32 mnt_root;		/* [str] Root of mount relative to root of fs */
  	__u32 mnt_point;	/* [str] Mountpoint relative to current root */
  	__u64 mnt_ns_id;
  	__u64 __spare2[49];
  	char str[];		/* Variable size part containing strings */
  };

  struct mnt_id_req {
  	__u32 size;
  	__u32 spare;
  	__u64 mnt_id;
  	__u64 param;
  	__u64 mnt_ns_id;
  };

  #define MNT_ID_REQ_SIZE_VER1	32 /* sizeof second published struct */

  #define LSMT_ROOT		0xffffffffffffffff	/* root mount */

  static int __statmount(__u64 mnt_id, __u64 mnt_ns_id, __u64 mask,
  		       struct statmount *stmnt, size_t bufsize, unsigned int flags)
  {
  	struct mnt_id_req req = {
  		.size = MNT_ID_REQ_SIZE_VER1,
  		.mnt_id = mnt_id,
  		.param = mask,
  		.mnt_ns_id = mnt_ns_id,
  	};

  	return syscall(__NR_statmount, &req, stmnt, bufsize, flags);
  }

  static struct statmount *sys_statmount(__u64 mnt_id, __u64 mnt_ns_id,
  				       __u64 mask, unsigned int flags)
  {
  	size_t bufsize = 1 << 15;
  	struct statmount *stmnt = NULL, *tmp = NULL;
  	int ret;

  	for (;;) {
  		tmp = realloc(stmnt, bufsize);
  		if (!tmp)
  			goto out;

  		stmnt = tmp;
  		ret = __statmount(mnt_id, mnt_ns_id, mask, stmnt, bufsize, flags);
  		if (!ret)
  			return stmnt;

  		if (errno != EOVERFLOW)
  			goto out;

  		bufsize <<= 1;
  		if (bufsize >= UINT_MAX / 2)
  			goto out;

  	}

  out:
  	free(stmnt);
  	printf("statmount failed");
  	return NULL;
  }

  static ssize_t sys_listmount(__u64 mnt_id, __u64 last_mnt_id, __u64 mnt_ns_id,
  			     __u64 list[], size_t num, unsigned int flags)
  {
  	struct mnt_id_req req = {
  		.size = MNT_ID_REQ_SIZE_VER1,
  		.mnt_id = mnt_id,
  		.param = last_mnt_id,
  		.mnt_ns_id = mnt_ns_id,
  	};

  	return syscall(__NR_listmount, &req, list, num, flags);
  }

  int main(int argc, char *argv[])
  {
  #define LISTMNT_BUFFER 10
  	__u64 list[LISTMNT_BUFFER], last_mnt_id = 0;
  	int ret, pidfd, fd_mntns;
  	struct mnt_ns_info info = {};

  	pidfd = pidfd_open(getpid(), 0);
  	if (pidfd < 0)
  		die_errno("pidfd_open failed");

  	fd_mntns = ioctl(pidfd, PIDFD_GET_MNT_NAMESPACE, 0);
  	if (fd_mntns < 0)
  		die_errno("ioctl(PIDFD_GET_MNT_NAMESPACE) failed");

  	ret = ioctl(fd_mntns, NS_MNT_GET_INFO, &info);
  	if (ret < 0)
  		die_errno("ioctl(NS_GET_MNTNS_ID) failed");

  	printf("Listing %u mounts for mount namespace %d:%llu\n", info.nr_mounts, fd_mntns, info.mnt_ns_id);
  	for (;;) {
  		ssize_t nr_mounts;
  	next:
  		nr_mounts = sys_listmount(LSMT_ROOT, last_mnt_id, info.mnt_ns_id, list, LISTMNT_BUFFER, 0);
  		if (nr_mounts <= 0) {
  			printf("Finished listing mounts for mount namespace %d:%llu\n\n", fd_mntns, info.mnt_ns_id);
  			ret = ioctl(fd_mntns, NS_MNT_GET_NEXT, 0);
  			if (ret < 0)
  				die_errno("ioctl(NS_MNT_GET_NEXT) failed");
  			close(ret);
  			ret = ioctl(fd_mntns, NS_MNT_GET_NEXT, &info);
  			if (ret < 0) {
  				if (errno == ENOENT) {
  					printf("Finished listing all mount namespaces\n");
  					exit(0);
  				}
  				die_errno("ioctl(NS_MNT_GET_NEXT) failed");
  			}
  			close(fd_mntns);
  			fd_mntns = ret;
  			last_mnt_id = 0;
  			printf("Listing %u mounts for mount namespace %d:%llu\n", info.nr_mounts, fd_mntns, info.mnt_ns_id);
  			goto next;
  		}

  		for (size_t cur = 0; cur < nr_mounts; cur++) {
  			struct statmount *stmnt;

  			last_mnt_id = list[cur];

  			stmnt = sys_statmount(last_mnt_id, info.mnt_ns_id,
  					      STATMOUNT_SB_BASIC |
  					      STATMOUNT_MNT_BASIC |
  					      STATMOUNT_MNT_ROOT |
  					      STATMOUNT_MNT_POINT |
  					      STATMOUNT_MNT_NS_ID |
  					      STATMOUNT_MNT_OPTS |
  					      STATMOUNT_FS_TYPE,
  					  0);
  			if (!stmnt) {
  				printf("Failed to statmount(%llu) in mount namespace(%llu)\n", last_mnt_id, info.mnt_ns_id);
  				continue;
  			}

  			printf("mnt_id(%u/%llu) | mnt_parent_id(%u/%llu): %s @ %s ==> %s with options: %s\n",
  			       stmnt->mnt_id_old, stmnt->mnt_id,
  			       stmnt->mnt_parent_id_old, stmnt->mnt_parent_id,
  			       stmnt->str + stmnt->fs_type,
  			       stmnt->str + stmnt->mnt_root,
  			       stmnt->str + stmnt->mnt_point,
  			       stmnt->str + stmnt->mnt_opts);
  			free(stmnt);
  		}
  	}

  	exit(0);
  }

Thanks!
Christian

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
---
base-commit: 720261cfc7329406a50c2a8536e0039b9dd9a4e5
change-id: 20240705-work-mount-namespace-126b73a11f5c



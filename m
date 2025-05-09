Return-Path: <linux-fsdevel+bounces-48607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA38AB1545
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 15:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF72188E2B3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 13:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC112918D0;
	Fri,  9 May 2025 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gf1QRKao"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A772749F6
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746797570; cv=none; b=rPqM/hCHk0om/Q+gHEvMMIFnJWdxO8YtH8/x3KjJxY75ashESRiHmeiP7kdz2WmL2b8mOcI48vGfzQBQzg4XOeBBGzLUnxhrDxtnN4cbuLxqIm7+VtI7jhYK5S7SCDqtvFiFzyAJLClfrxCE/r4oTFlAA++jqsqgKb4ycXUd+YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746797570; c=relaxed/simple;
	bh=Rxf7Gr643GKHVwkEFCEha7zBcgfIf85qBKH9GmdoNRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OLs5w+VAxM+V5S+6BUmC3s0kLfI7nMPWwkd6l9rVFsUzxQXcRHEJyxHPalC7FJmNFSm9p4Hdht3UOAQmGLqrGlz5JjnoE9sMuQO74Mli8k2JULl511iBHXxps8n7Bwm/5b84/g1AsBnWLRSjLatFYV+7M0QSJdsJgN7/Qu01zCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gf1QRKao; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a0b7fbdde7so1881179f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 06:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746797566; x=1747402366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+fOcC6F58aPYpDOz4AQo5ogTWO3hQhJCGzkZUvPxcM=;
        b=gf1QRKaomrozU/bvYqVtJD1339q/YESQ8OS06x8TWMjGX+c5xtbMp2cvAqFkFB2RCv
         5J/ZRNhQgBb2f6NSUOXMf3fBqsGXg/ILaC0jI+RPWU++HrHHBWPqzn9QYFBtj9Q7xLwj
         XAYr+fRfxNehp78oM+fEsgb9reyKECyYHR7/h0FIEuxw6EtmMRF5DLraMrP01PlBCzQD
         yDobvJT8QMedK+EO8xOn02Nw3MJq78a6jGdmLfRcRpYlGHHM+v56cfBArG84i/UKXKCM
         L5BzRyPa6hnADTIMJkVDttyrQl3A3I3gUNcOXNgBxG4xlw4D8uXEdsxrJBmxEAzs2NVx
         mrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746797566; x=1747402366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+fOcC6F58aPYpDOz4AQo5ogTWO3hQhJCGzkZUvPxcM=;
        b=HMId4Dnfowqa0lv9lFeEZ/XK8w7gPtsKbayD9YkmdOnsnmvKVz8tziTMBVAx8bhNB+
         fVI6KYTpyRUvkYJiE+ZfVEPafnJvvxPg1hbZnMaNjPuCSiIxcocKd170ZDAT1JxB5cTC
         JnERhw3JrHLh1LEFnoULrP0+xn7RhJ+kol3sd4sjoWzG6IkY2VIPzJwPXZjW49u9LCD8
         l5a7k6e1vWmpPwyWeB76n3A0rZYKE+Pa4s81f9IIUDCGLOPFXWJEZiCLrbNEPr8cGJti
         /CANpExIjGbhbxUnekgaQ5Bf/RCJdLmBhrde+YS+azOq+k6RhaegXr6a3xYZ+UKGg2us
         Vh9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJnnN56QDBUjTVe2vuQuxetLN7XnLO1vqm0zz2UmDIVBLsZg4Sl8B78oqu3YF6hAoeCaimh1sukVFlWLUD@vger.kernel.org
X-Gm-Message-State: AOJu0YwP9ffbYoNN4zmp8jxOjLdq6Th9AvpKhJILoWyiM9ONtBXjWSQu
	G+AMgVzClh9UH43rYrzl3YzfpCMqfjLuG/uD6DmsjOjYVxxrUZ6Z
X-Gm-Gg: ASbGncvaMk/YjbEz1lF6IztHbZiERJPAAGBojo4PGwtFWmLiN2CV0p4xcvt0749SAl8
	6gcXMVSYEphH/N8zBvDDPi0Fpg0ubkQUuZ2eKkwhx6bjBcuJQibnMR+R6KYp+qrzwo2Es0/hru5
	/Ka91MUDWSKmGZrVbrG799mnzsnqigfVDZK1206A1/lMAvE/ucMEb7YSRfPlnHiYwuGwNmbiI16
	WUsvBJq2swoGVxgVD6bob6wYRs80ItaZ6PF+3wjfcjvrPX8p8ayZIw5ywwWTFKzJNkO/Dn70QMh
	m1y2/6LVvKME+YC5V7VnXaQ1RYP9PdoXE/aX1dc5N0ttuhA+eIxAQdFlRXw0dQpL2q7kTccci34
	9o0y6PmdgwCO4xjuQ++a2jZZ7VuAH8xJrMGkXXQ==
X-Google-Smtp-Source: AGHT+IGEByInSqI5LsekVCwoS20EEsKuhEQPaOW6YbDVxK7Dauoh6ucNVugBQa1zHYEQipe1n41B2Q==
X-Received: by 2002:adf:cf03:0:b0:3a1:f6fd:da50 with SMTP id ffacd0b85a97d-3a1f6fddab1mr1855855f8f.46.1746797566040;
        Fri, 09 May 2025 06:32:46 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddfd6sm3232899f8f.4.2025.05.09.06.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 06:32:45 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	John Hubbard <jhubbard@nvidia.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/8] selftests/fs/statmount: build with tools include dir
Date: Fri,  9 May 2025 15:32:34 +0200
Message-Id: <20250509133240.529330-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509133240.529330-1-amir73il@gmail.com>
References: <20250509133240.529330-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Copy the required headers files (mount.h, nsfs.h) to the tools
include dir and define the statmount/listmount syscall numbers
to decouple dependency with headers_install for the common cases.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tools/include/uapi/linux/mount.h              | 235 ++++++++++++++++++
 tools/include/uapi/linux/nsfs.h               |  45 ++++
 .../selftests/filesystems/statmount/Makefile  |   3 +-
 .../filesystems/statmount/statmount.h         |  36 +++
 4 files changed, 318 insertions(+), 1 deletion(-)
 create mode 100644 tools/include/uapi/linux/mount.h
 create mode 100644 tools/include/uapi/linux/nsfs.h

diff --git a/tools/include/uapi/linux/mount.h b/tools/include/uapi/linux/mount.h
new file mode 100644
index 000000000000..7fa67c2031a5
--- /dev/null
+++ b/tools/include/uapi/linux/mount.h
@@ -0,0 +1,235 @@
+#ifndef _UAPI_LINUX_MOUNT_H
+#define _UAPI_LINUX_MOUNT_H
+
+#include <linux/types.h>
+
+/*
+ * These are the fs-independent mount-flags: up to 32 flags are supported
+ *
+ * Usage of these is restricted within the kernel to core mount(2) code and
+ * callers of sys_mount() only.  Filesystems should be using the SB_*
+ * equivalent instead.
+ */
+#define MS_RDONLY	 1	/* Mount read-only */
+#define MS_NOSUID	 2	/* Ignore suid and sgid bits */
+#define MS_NODEV	 4	/* Disallow access to device special files */
+#define MS_NOEXEC	 8	/* Disallow program execution */
+#define MS_SYNCHRONOUS	16	/* Writes are synced at once */
+#define MS_REMOUNT	32	/* Alter flags of a mounted FS */
+#define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
+#define MS_DIRSYNC	128	/* Directory modifications are synchronous */
+#define MS_NOSYMFOLLOW	256	/* Do not follow symlinks */
+#define MS_NOATIME	1024	/* Do not update access times. */
+#define MS_NODIRATIME	2048	/* Do not update directory access times */
+#define MS_BIND		4096
+#define MS_MOVE		8192
+#define MS_REC		16384
+#define MS_VERBOSE	32768	/* War is peace. Verbosity is silence.
+				   MS_VERBOSE is deprecated. */
+#define MS_SILENT	32768
+#define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
+#define MS_UNBINDABLE	(1<<17)	/* change to unbindable */
+#define MS_PRIVATE	(1<<18)	/* change to private */
+#define MS_SLAVE	(1<<19)	/* change to slave */
+#define MS_SHARED	(1<<20)	/* change to shared */
+#define MS_RELATIME	(1<<21)	/* Update atime relative to mtime/ctime. */
+#define MS_KERNMOUNT	(1<<22) /* this is a kern_mount call */
+#define MS_I_VERSION	(1<<23) /* Update inode I_version field */
+#define MS_STRICTATIME	(1<<24) /* Always perform atime updates */
+#define MS_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
+
+/* These sb flags are internal to the kernel */
+#define MS_SUBMOUNT     (1<<26)
+#define MS_NOREMOTELOCK	(1<<27)
+#define MS_NOSEC	(1<<28)
+#define MS_BORN		(1<<29)
+#define MS_ACTIVE	(1<<30)
+#define MS_NOUSER	(1<<31)
+
+/*
+ * Superblock flags that can be altered by MS_REMOUNT
+ */
+#define MS_RMT_MASK	(MS_RDONLY|MS_SYNCHRONOUS|MS_MANDLOCK|MS_I_VERSION|\
+			 MS_LAZYTIME)
+
+/*
+ * Old magic mount flag and mask
+ */
+#define MS_MGC_VAL 0xC0ED0000
+#define MS_MGC_MSK 0xffff0000
+
+/*
+ * open_tree() flags.
+ */
+#define OPEN_TREE_CLONE		1		/* Clone the target tree and attach the clone */
+#define OPEN_TREE_CLOEXEC	O_CLOEXEC	/* Close the file on execve() */
+
+/*
+ * move_mount() flags.
+ */
+#define MOVE_MOUNT_F_SYMLINKS		0x00000001 /* Follow symlinks on from path */
+#define MOVE_MOUNT_F_AUTOMOUNTS		0x00000002 /* Follow automounts on from path */
+#define MOVE_MOUNT_F_EMPTY_PATH		0x00000004 /* Empty from path permitted */
+#define MOVE_MOUNT_T_SYMLINKS		0x00000010 /* Follow symlinks on to path */
+#define MOVE_MOUNT_T_AUTOMOUNTS		0x00000020 /* Follow automounts on to path */
+#define MOVE_MOUNT_T_EMPTY_PATH		0x00000040 /* Empty to path permitted */
+#define MOVE_MOUNT_SET_GROUP		0x00000100 /* Set sharing group instead */
+#define MOVE_MOUNT_BENEATH		0x00000200 /* Mount beneath top mount */
+#define MOVE_MOUNT__MASK		0x00000377
+
+/*
+ * fsopen() flags.
+ */
+#define FSOPEN_CLOEXEC		0x00000001
+
+/*
+ * fspick() flags.
+ */
+#define FSPICK_CLOEXEC		0x00000001
+#define FSPICK_SYMLINK_NOFOLLOW	0x00000002
+#define FSPICK_NO_AUTOMOUNT	0x00000004
+#define FSPICK_EMPTY_PATH	0x00000008
+
+/*
+ * The type of fsconfig() call made.
+ */
+enum fsconfig_command {
+	FSCONFIG_SET_FLAG	= 0,	/* Set parameter, supplying no value */
+	FSCONFIG_SET_STRING	= 1,	/* Set parameter, supplying a string value */
+	FSCONFIG_SET_BINARY	= 2,	/* Set parameter, supplying a binary blob value */
+	FSCONFIG_SET_PATH	= 3,	/* Set parameter, supplying an object by path */
+	FSCONFIG_SET_PATH_EMPTY	= 4,	/* Set parameter, supplying an object by (empty) path */
+	FSCONFIG_SET_FD		= 5,	/* Set parameter, supplying an object by fd */
+	FSCONFIG_CMD_CREATE	= 6,	/* Create new or reuse existing superblock */
+	FSCONFIG_CMD_RECONFIGURE = 7,	/* Invoke superblock reconfiguration */
+	FSCONFIG_CMD_CREATE_EXCL = 8,	/* Create new superblock, fail if reusing existing superblock */
+};
+
+/*
+ * fsmount() flags.
+ */
+#define FSMOUNT_CLOEXEC		0x00000001
+
+/*
+ * Mount attributes.
+ */
+#define MOUNT_ATTR_RDONLY	0x00000001 /* Mount read-only */
+#define MOUNT_ATTR_NOSUID	0x00000002 /* Ignore suid and sgid bits */
+#define MOUNT_ATTR_NODEV	0x00000004 /* Disallow access to device special files */
+#define MOUNT_ATTR_NOEXEC	0x00000008 /* Disallow program execution */
+#define MOUNT_ATTR__ATIME	0x00000070 /* Setting on how atime should be updated */
+#define MOUNT_ATTR_RELATIME	0x00000000 /* - Update atime relative to mtime/ctime. */
+#define MOUNT_ATTR_NOATIME	0x00000010 /* - Do not update access times. */
+#define MOUNT_ATTR_STRICTATIME	0x00000020 /* - Always perform atime updates */
+#define MOUNT_ATTR_NODIRATIME	0x00000080 /* Do not update directory access times */
+#define MOUNT_ATTR_IDMAP	0x00100000 /* Idmap mount to @userns_fd in struct mount_attr. */
+#define MOUNT_ATTR_NOSYMFOLLOW	0x00200000 /* Do not follow symlinks */
+
+/*
+ * mount_setattr()
+ */
+struct mount_attr {
+	__u64 attr_set;
+	__u64 attr_clr;
+	__u64 propagation;
+	__u64 userns_fd;
+};
+
+/* List of all mount_attr versions. */
+#define MOUNT_ATTR_SIZE_VER0	32 /* sizeof first published struct */
+
+
+/*
+ * Structure for getting mount/superblock/filesystem info with statmount(2).
+ *
+ * The interface is similar to statx(2): individual fields or groups can be
+ * selected with the @mask argument of statmount().  Kernel will set the @mask
+ * field according to the supported fields.
+ *
+ * If string fields are selected, then the caller needs to pass a buffer that
+ * has space after the fixed part of the structure.  Nul terminated strings are
+ * copied there and offsets relative to @str are stored in the relevant fields.
+ * If the buffer is too small, then EOVERFLOW is returned.  The actually used
+ * size is returned in @size.
+ */
+struct statmount {
+	__u32 size;		/* Total size, including strings */
+	__u32 mnt_opts;		/* [str] Options (comma separated, escaped) */
+	__u64 mask;		/* What results were written */
+	__u32 sb_dev_major;	/* Device ID */
+	__u32 sb_dev_minor;
+	__u64 sb_magic;		/* ..._SUPER_MAGIC */
+	__u32 sb_flags;		/* SB_{RDONLY,SYNCHRONOUS,DIRSYNC,LAZYTIME} */
+	__u32 fs_type;		/* [str] Filesystem type */
+	__u64 mnt_id;		/* Unique ID of mount */
+	__u64 mnt_parent_id;	/* Unique ID of parent (for root == mnt_id) */
+	__u32 mnt_id_old;	/* Reused IDs used in proc/.../mountinfo */
+	__u32 mnt_parent_id_old;
+	__u64 mnt_attr;		/* MOUNT_ATTR_... */
+	__u64 mnt_propagation;	/* MS_{SHARED,SLAVE,PRIVATE,UNBINDABLE} */
+	__u64 mnt_peer_group;	/* ID of shared peer group */
+	__u64 mnt_master;	/* Mount receives propagation from this ID */
+	__u64 propagate_from;	/* Propagation from in current namespace */
+	__u32 mnt_root;		/* [str] Root of mount relative to root of fs */
+	__u32 mnt_point;	/* [str] Mountpoint relative to current root */
+	__u64 mnt_ns_id;	/* ID of the mount namespace */
+	__u32 fs_subtype;	/* [str] Subtype of fs_type (if any) */
+	__u32 sb_source;	/* [str] Source string of the mount */
+	__u32 opt_num;		/* Number of fs options */
+	__u32 opt_array;	/* [str] Array of nul terminated fs options */
+	__u32 opt_sec_num;	/* Number of security options */
+	__u32 opt_sec_array;	/* [str] Array of nul terminated security options */
+	__u64 supported_mask;	/* Mask flags that this kernel supports */
+	__u32 mnt_uidmap_num;	/* Number of uid mappings */
+	__u32 mnt_uidmap;	/* [str] Array of uid mappings (as seen from callers namespace) */
+	__u32 mnt_gidmap_num;	/* Number of gid mappings */
+	__u32 mnt_gidmap;	/* [str] Array of gid mappings (as seen from callers namespace) */
+	__u64 __spare2[43];
+	char str[];		/* Variable size part containing strings */
+};
+
+/*
+ * Structure for passing mount ID and miscellaneous parameters to statmount(2)
+ * and listmount(2).
+ *
+ * For statmount(2) @param represents the request mask.
+ * For listmount(2) @param represents the last listed mount id (or zero).
+ */
+struct mnt_id_req {
+	__u32 size;
+	__u32 spare;
+	__u64 mnt_id;
+	__u64 param;
+	__u64 mnt_ns_id;
+};
+
+/* List of all mnt_id_req versions. */
+#define MNT_ID_REQ_SIZE_VER0	24 /* sizeof first published struct */
+#define MNT_ID_REQ_SIZE_VER1	32 /* sizeof second published struct */
+
+/*
+ * @mask bits for statmount(2)
+ */
+#define STATMOUNT_SB_BASIC		0x00000001U     /* Want/got sb_... */
+#define STATMOUNT_MNT_BASIC		0x00000002U	/* Want/got mnt_... */
+#define STATMOUNT_PROPAGATE_FROM	0x00000004U	/* Want/got propagate_from */
+#define STATMOUNT_MNT_ROOT		0x00000008U	/* Want/got mnt_root  */
+#define STATMOUNT_MNT_POINT		0x00000010U	/* Want/got mnt_point */
+#define STATMOUNT_FS_TYPE		0x00000020U	/* Want/got fs_type */
+#define STATMOUNT_MNT_NS_ID		0x00000040U	/* Want/got mnt_ns_id */
+#define STATMOUNT_MNT_OPTS		0x00000080U	/* Want/got mnt_opts */
+#define STATMOUNT_FS_SUBTYPE		0x00000100U	/* Want/got fs_subtype */
+#define STATMOUNT_SB_SOURCE		0x00000200U	/* Want/got sb_source */
+#define STATMOUNT_OPT_ARRAY		0x00000400U	/* Want/got opt_... */
+#define STATMOUNT_OPT_SEC_ARRAY		0x00000800U	/* Want/got opt_sec... */
+#define STATMOUNT_SUPPORTED_MASK	0x00001000U	/* Want/got supported mask flags */
+#define STATMOUNT_MNT_UIDMAP		0x00002000U	/* Want/got uidmap... */
+#define STATMOUNT_MNT_GIDMAP		0x00004000U	/* Want/got gidmap... */
+
+/*
+ * Special @mnt_id values that can be passed to listmount
+ */
+#define LSMT_ROOT		0xffffffffffffffff	/* root mount */
+#define LISTMOUNT_REVERSE	(1 << 0) /* List later mounts first */
+
+#endif /* _UAPI_LINUX_MOUNT_H */
diff --git a/tools/include/uapi/linux/nsfs.h b/tools/include/uapi/linux/nsfs.h
new file mode 100644
index 000000000000..34127653fd00
--- /dev/null
+++ b/tools/include/uapi/linux/nsfs.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __LINUX_NSFS_H
+#define __LINUX_NSFS_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+#define NSIO	0xb7
+
+/* Returns a file descriptor that refers to an owning user namespace */
+#define NS_GET_USERNS		_IO(NSIO, 0x1)
+/* Returns a file descriptor that refers to a parent namespace */
+#define NS_GET_PARENT		_IO(NSIO, 0x2)
+/* Returns the type of namespace (CLONE_NEW* value) referred to by
+   file descriptor */
+#define NS_GET_NSTYPE		_IO(NSIO, 0x3)
+/* Get owner UID (in the caller's user namespace) for a user namespace */
+#define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
+/* Get the id for a mount namespace */
+#define NS_GET_MNTNS_ID		_IOR(NSIO, 0x5, __u64)
+/* Translate pid from target pid namespace into the caller's pid namespace. */
+#define NS_GET_PID_FROM_PIDNS	_IOR(NSIO, 0x6, int)
+/* Return thread-group leader id of pid in the callers pid namespace. */
+#define NS_GET_TGID_FROM_PIDNS	_IOR(NSIO, 0x7, int)
+/* Translate pid from caller's pid namespace into a target pid namespace. */
+#define NS_GET_PID_IN_PIDNS	_IOR(NSIO, 0x8, int)
+/* Return thread-group leader id of pid in the target pid namespace. */
+#define NS_GET_TGID_IN_PIDNS	_IOR(NSIO, 0x9, int)
+
+struct mnt_ns_info {
+	__u32 size;
+	__u32 nr_mounts;
+	__u64 mnt_ns_id;
+};
+
+#define MNT_NS_INFO_SIZE_VER0 16 /* size of first published struct */
+
+/* Get information about namespace. */
+#define NS_MNT_GET_INFO		_IOR(NSIO, 10, struct mnt_ns_info)
+/* Get next namespace. */
+#define NS_MNT_GET_NEXT		_IOR(NSIO, 11, struct mnt_ns_info)
+/* Get previous namespace. */
+#define NS_MNT_GET_PREV		_IOR(NSIO, 12, struct mnt_ns_info)
+
+#endif /* __LINUX_NSFS_H */
diff --git a/tools/testing/selftests/filesystems/statmount/Makefile b/tools/testing/selftests/filesystems/statmount/Makefile
index 14ee91a41650..19adebfc2620 100644
--- a/tools/testing/selftests/filesystems/statmount/Makefile
+++ b/tools/testing/selftests/filesystems/statmount/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
+CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
+
 TEST_GEN_PROGS := statmount_test statmount_test_ns listmount_test
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/statmount/statmount.h b/tools/testing/selftests/filesystems/statmount/statmount.h
index a7a5289ddae9..99e5ad082fb1 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount.h
+++ b/tools/testing/selftests/filesystems/statmount/statmount.h
@@ -7,6 +7,42 @@
 #include <linux/mount.h>
 #include <asm/unistd.h>
 
+#ifndef __NR_statmount
+	#if defined __alpha__
+		#define __NR_statmount 567
+	#elif defined _MIPS_SIM
+		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
+			#define __NR_statmount 4457
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
+			#define __NR_statmount 6457
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
+			#define __NR_statmount 5457
+		#endif
+	#else
+		#define __NR_statmount 457
+	#endif
+#endif
+
+#ifndef __NR_listmount
+	#if defined __alpha__
+		#define __NR_listmount 568
+	#elif defined _MIPS_SIM
+		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
+			#define __NR_listmount 4458
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
+			#define __NR_listmount 6458
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
+			#define __NR_listmount 5458
+		#endif
+	#else
+		#define __NR_listmount 458
+	#endif
+#endif
+
 static inline int statmount(uint64_t mnt_id, uint64_t mnt_ns_id, uint64_t mask,
 			    struct statmount *buf, size_t bufsize,
 			    unsigned int flags)
-- 
2.34.1



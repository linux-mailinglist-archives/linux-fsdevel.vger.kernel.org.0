Return-Path: <linux-fsdevel+bounces-41788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0802DA375EC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 17:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938813A60D2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 16:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3788319DF40;
	Sun, 16 Feb 2025 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwFGaf4x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832FB3D6F;
	Sun, 16 Feb 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739724139; cv=none; b=TtQUEgo3XXJG5QIWZtciHVcU8IPWg/mQqNNXxNZ/42/Pt9pHqVFPp/jSiWt88jlBJl1hDQiO3tU8evaxLMdbSWvkyxFk+wxcpNz/1RmO3s+dAYHRVgEcxmpvjDUmd8Kieo2P08vcuzx3rR9ZgBNsrS6U2F0GYRhzPWHJqmUelow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739724139; c=relaxed/simple;
	bh=lz7bGwGUQN+1Kltn46PnjlezsUR8WWvBKZe2J+lCJow=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WvPRztjEXN1WPbT3ChIspaVMfNF2zCbVMWzBGMYIvHc3Yp5TDFPf3UNQ80lIy5DifHrZFoTydU1Gk8jA/gXj//1dUrPGi/gbDHm/Y/GOqTXweXJJ+ItzVNGFpDwwEGrAlPoerqaAIoqV+NbBYVJH2B0alCysCxdVkhk8qxUwIfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwFGaf4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD91C4CEE9;
	Sun, 16 Feb 2025 16:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739724139;
	bh=lz7bGwGUQN+1Kltn46PnjlezsUR8WWvBKZe2J+lCJow=;
	h=From:To:Cc:Subject:Date:From;
	b=WwFGaf4xz6p7DWAngi1RSPCxjkYp4PRbJM9FvzpyEUEhW2VSLOMWiqqrnavkZ6elG
	 clqQ9c736huipke9rGvruqXYOn6DvpQgAOTuDP2HdBBNzmdIoYarOQcQasmOji5mL1
	 f+XMdUXJGQW48BvljN3Xtnmd1kxtvBmbIuffecxOUGOzcSg5zRZKfOjZpwPjsBQ445
	 Op/Ty92P7z+tpUsyF2RBRUrtDdCx0ua758hhS23Zf0PDaO2gX/r7+M9wnxgs1aTK3z
	 uIgXwIg9C90QDkCNgwFceG+94nWU/grBuwy3Of3MiW/t00C9GGMokTsqnjWbxtSoMD
	 wYM9vPuCDOqww==
Received: by pali.im (Postfix)
	id 9B4A4A34; Sun, 16 Feb 2025 17:42:05 +0100 (CET)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] fs: Add support for Windows file attributes
Date: Sun, 16 Feb 2025 17:40:25 +0100
Message-Id: <20250216164029.20673-1-pali@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is RFC patch series, first attempt to implement support for
additional file attributes via FS_IOC_FSGETXATTR and FS_IOC_FSSETXATTR
ioctl APIs, which are used by Windows applications and Windows
filesystems. It is not final, nor precise implementation, it is mean to
show how the API can look like and how it can be used. Please let me
know what do you think about it, if it is the right direction, or how to
move forward.

This RFC patch series contains API definition, VFS integration and
implementation only for SMB client / cifs.ko filesystem. Note that
cifs.ko does not set S_IMMUTABLE flag on local inode because
enforcement of immutable flag has to be done on server.

Design of this API comes from slightly longer discussion:
https://lore.kernel.org/linux-fsdevel/20241227121508.nofy6bho66pc5ry5@pali/t/#u

And conclusion was to abandon any idea of xattr APIs and uses
exclusively only the FS_IOC_FSGETXATTR and FS_IOC_FSSETXATTR ioctls.

There is no statx API extension yet.

Simple test client attrs which uses this new API is bellow.

$ cat attrs.c
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <linux/fs.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <errno.h>

#define FS_XFLAG_IMMUTABLEUSER	0x00000004
#define FS_XFLAG_COMPRESSED	0x00020000
#define FS_XFLAG_ENCRYPTED	0x00040000
#define FS_XFLAG_CHECKSUMS	0x00080000
#define FS_XFLAG_HASEXTFIELDS	0x40000000

#define FS_XFLAG2_HIDDEN	0x0001
#define FS_XFLAG2_SYSTEM	0x0002
#define FS_XFLAG2_ARCHIVE	0x0004
#define FS_XFLAG2_TEMPORARY	0x0008
#define FS_XFLAG2_NOTINDEXED	0x0010
#define FS_XFLAG2_NOSCRUBDATA	0x0020
#define FS_XFLAG2_OFFLINE	0x0040
#define FS_XFLAG2_PINNED	0x0080
#define FS_XFLAG2_UNPINNED	0x0100

int main(int argc, char *argv[]) {
	struct fsxattr fsxattr;
	int bit, is2, set;
	int fd;

	if (argc != 2 && argc != 3) {
		printf("Usage %s path [+|-attr]\n", argv[0]);
		return 1;
	}

	if (argc == 3) {
		if (argv[2][0] != '-' && argv[2][0] != '+') {
			printf("Attr must start with + or -\n");
			return 1;
		}
		set = argv[2][0] == '+';
		is2 = 1;
		if (strcmp(&argv[2][1], "readonly") == 0)
			bit = FS_XFLAG_IMMUTABLEUSER, is2 = 0;
		else if (strcmp(&argv[2][1], "hidden") == 0)
			bit = FS_XFLAG2_HIDDEN;
		else if (strcmp(&argv[2][1], "system") == 0)
			bit = FS_XFLAG2_SYSTEM;
		else if (strcmp(&argv[2][1], "archive") == 0)
			bit = FS_XFLAG2_ARCHIVE;
		else if (strcmp(&argv[2][1], "temporary") == 0)
			bit = FS_XFLAG2_TEMPORARY;
		else if (strcmp(&argv[2][1], "compressed") == 0)
			bit = FS_XFLAG_COMPRESSED, is2 = 0;
		else if (strcmp(&argv[2][1], "offline") == 0)
			bit = FS_XFLAG2_OFFLINE;
		else if (strcmp(&argv[2][1], "notindexed") == 0)
			bit = FS_XFLAG2_NOTINDEXED;
		else if (strcmp(&argv[2][1], "encrypted") == 0)
			bit = FS_XFLAG_ENCRYPTED, is2 = 0;
		else if (strcmp(&argv[2][1], "integrity") == 0)
			bit = FS_XFLAG_CHECKSUMS, is2 = 0;
		else if (strcmp(&argv[2][1], "noscrubdata") == 0)
			bit = FS_XFLAG2_NOSCRUBDATA;
		else if (strcmp(&argv[2][1], "pinned") == 0)
			bit = FS_XFLAG2_PINNED;
		else if (strcmp(&argv[2][1], "unpinned") == 0)
			bit = FS_XFLAG2_UNPINNED;
		else {
			printf("Unknown attr '%s'\n", &argv[2][1]);
			return 1;
		}
	}

	fd = open(argv[1], O_RDONLY | O_NONBLOCK);
	if (fd < 0) {
		printf("Cannot open '%s': %s\n", argv[1], strerror(errno));
		return 1;
	}

	if (ioctl(fd, FS_IOC_FSGETXATTR, &fsxattr) != 0) {
		printf("FS_IOC_FSGETXATTR for '%s' failed: %s\n", argv[1], strerror(errno));
		return 1;
	}

	if (!(fsxattr.fsx_xflags & FS_XFLAG_HASEXTFIELDS)) {
		printf("FS_XFLAG_HASEXTFIELDS is not supported\n");
		return 1;
	}

	if (argc == 2) {
		printf("readonly=%d\n", !!(fsxattr.fsx_xflags & FS_XFLAG_IMMUTABLEUSER));
		printf("hidden=%d\n", !!(*(__u16 *)&fsxattr.fsx_pad[0] & FS_XFLAG2_HIDDEN));
		printf("system=%d\n", !!(*(__u16 *)&fsxattr.fsx_pad[0] & FS_XFLAG2_SYSTEM));
		printf("archive=%d\n", !!(*(__u16 *)&fsxattr.fsx_pad[0] & FS_XFLAG2_ARCHIVE));
		printf("temporary=%d\n", !!(*(__u16 *)&fsxattr.fsx_pad[0] & FS_XFLAG2_TEMPORARY));
		printf("compressed=%d\n", !!(fsxattr.fsx_xflags & FS_XFLAG_COMPRESSED));
		printf("offline=%d\n", !!(*(__u16 *)&fsxattr.fsx_pad[0] & FS_XFLAG2_OFFLINE));
		printf("notindexed=%d\n", !!(*(__u16 *)&fsxattr.fsx_pad[0] & FS_XFLAG2_NOTINDEXED));
		printf("encrypted=%d\n", !!(fsxattr.fsx_xflags & FS_XFLAG_ENCRYPTED));
		printf("integrity=%d\n", !!(fsxattr.fsx_xflags & FS_XFLAG_CHECKSUMS));
		printf("noscrubdata=%d\n", !!(*(__u16 *)&fsxattr.fsx_pad[0] & FS_XFLAG2_NOSCRUBDATA));
		printf("pinned=%d\n", !!(*(__u16 *)&fsxattr.fsx_pad[0] & FS_XFLAG2_PINNED));
		printf("unpinned=%d\n", !!(*(__u16 *)&fsxattr.fsx_pad[0] & FS_XFLAG2_UNPINNED));
		return 0;
	}

	if (is2) {
		if (set)
			*(__u16 *)&fsxattr.fsx_pad[0] |= bit; /* fsx2_xflags */
		else
			*(__u16 *)&fsxattr.fsx_pad[0] &= ~bit; /* fsx2_xflags */
		*(__u16 *)&fsxattr.fsx_pad[2] = bit; /* fsx_xflags2_mask */
		*(__u32 *)&fsxattr.fsx_pad[4] = 0; /* fsx_xflags_mask */
	} else {
		if (set)
			fsxattr.fsx_xflags |= bit;
		else
			fsxattr.fsx_xflags &= ~bit;
		*(__u32 *)&fsxattr.fsx_pad[4] = bit; /* fsx_xflags_mask */
		*(__u16 *)&fsxattr.fsx_pad[2] = 0; /* fsx_xflags2_mask */
	}

	if (ioctl(fd, FS_IOC_FSSETXATTR, &fsxattr) != 0) {
		printf("FS_IOC_FSSETXATTR for '%s' failed: %s\n", argv[1], strerror(errno));
		return 1;
	}

	return 0;
}


Pali Rohár (4):
  fs: Add FS_XFLAG_COMPRESSED & FS_XFLAG_ENCRYPTED for
    FS_IOC_FS[GS]ETXATTR API
  fs: Extend FS_IOC_FS[GS]ETXATTR API for Windows attributes
  fs: Implement support for fsx_xflags_mask, fsx_xflags2 and
    fsx_xflags2_mask into vfs
  cifs: Implement FS_IOC_FS[GS]ETXATTR API for Windows attributes

 fs/btrfs/ioctl.c          |   9 +-
 fs/efivarfs/inode.c       |   3 +-
 fs/ext2/ioctl.c           |   2 +-
 fs/ext4/ioctl.c           |   2 +-
 fs/f2fs/file.c            |   2 +-
 fs/fuse/ioctl.c           |  13 ++-
 fs/gfs2/file.c            |  14 ++-
 fs/hfsplus/inode.c        |   3 +-
 fs/ioctl.c                |  73 +++++++++++++--
 fs/jfs/ioctl.c            |  14 ++-
 fs/nilfs2/ioctl.c         |   2 +-
 fs/ntfs3/file.c           |   3 +-
 fs/ocfs2/ioctl.c          |   2 +-
 fs/orangefs/inode.c       |   2 +-
 fs/smb/client/cifsfs.c    |   4 +
 fs/smb/client/cifsfs.h    |   2 +
 fs/smb/client/cifsglob.h  |   4 +-
 fs/smb/client/cifsproto.h |   2 +-
 fs/smb/client/cifssmb.c   |   4 +-
 fs/smb/client/inode.c     | 181 ++++++++++++++++++++++++++++++++++++++
 fs/smb/client/ioctl.c     |   8 +-
 fs/smb/client/smb1ops.c   |   4 +-
 fs/smb/client/smb2ops.c   |   8 +-
 fs/smb/client/smb2pdu.c   |   4 +-
 fs/smb/client/smb2proto.h |   2 +-
 fs/smb/common/smb2pdu.h   |   2 +
 fs/ubifs/ioctl.c          |   3 +-
 fs/xfs/xfs_ioctl.c        |   5 +-
 include/linux/fileattr.h  |  15 ++--
 include/uapi/linux/fs.h   |  34 ++++++-
 mm/shmem.c                |   2 +-
 31 files changed, 380 insertions(+), 48 deletions(-)

-- 
2.20.1



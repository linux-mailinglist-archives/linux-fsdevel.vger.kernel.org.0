Return-Path: <linux-fsdevel+bounces-53382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A138AEE434
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 18:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDA316DBC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 16:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4700318FDBE;
	Mon, 30 Jun 2025 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNSM+LFk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2091DFF7
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300436; cv=none; b=pZDNLIONOgXuVL96yOhOg14XEUnLRw2wLitZSE+mWfAbeU+yZjVcM2T8QXg/kMUvrrV4tb8hhlUelRPic1GbfdzuhxEB1Y6afmfYn1dfNLBtXJTkclULTKXyOeth+n8d2QsZmqGcYDJBLHMTWwEDLnhf7Dqj8L/h7LgFB29K14c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300436; c=relaxed/simple;
	bh=UaZEmtTk6LQBIwpX1H3cI6wrEZYIs4ph5Bt1MCtdJSw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NW31CuNreCYaNguL23/iFgdStTQ2aS8WNLfJvsEBwwIXuS4Qj68oazKtADiY/iRRXOZS3a2pKioQFe8Y8pRcqBa9QiTHN/URWGfDUm5isOl1wppNWVKAh62wsnu7FDLZ9j815f6884yus4RudmWyiOx5Hg/y+f3JHgGsSPwLjIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNSM+LFk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751300433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ecYMjHnv6x62Jglvhti1a5rHKVzWnYYSdcZZbJIOyU8=;
	b=DNSM+LFkI9X1SH0bHKzCHdQC3jrvnRy0Xe9VGQTm/23JemncBvTXnOkx40/2eyrMDNb1sc
	VVabgDJdH76odcx+Tk75fpmfwA+meEUsuLZ6B7bGWghU1krrYKdf4h4jdlKxwDE6F6o3Cf
	Tpg9dDBaEiRBk2RQQhWwWqpUVDk7ANY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-TbLyeF9RNEG9LJJ11Yn4yA-1; Mon, 30 Jun 2025 12:20:32 -0400
X-MC-Unique: TbLyeF9RNEG9LJJ11Yn4yA-1
X-Mimecast-MFC-AGG-ID: TbLyeF9RNEG9LJJ11Yn4yA_1751300431
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450d244bfabso20203445e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 09:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751300429; x=1751905229;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ecYMjHnv6x62Jglvhti1a5rHKVzWnYYSdcZZbJIOyU8=;
        b=fYdzGQ0QR47AOkoBxXyHAT0RwNQiwjhb9iOpDMLZ2NXIxpnUs7ELWffWYWNKWdtTBg
         VLOlw/fh5eegKrcgLjoDcXQYiC7p0mTwRy28aGiDosJVi0IErWN6PLpexeDou87uKzCU
         1csynN5Q5NbcnRW4f5ASSob5Kz9HM0KbL1bICbxCyEwpTcSbfjDf5ibut5Ymyh5ae9My
         RrYerI+3JD83eIq3lVTQr70yxLQAVOfoe2BW4Kz1+gx1AQRFNf7y1cueeNY4C3VieSDP
         VWGh6Rk99XTvHKOguiewIslnve5qIGdPMi269yQXut0d1nh6mSEluZHlUJli443qWNdC
         ApUg==
X-Forwarded-Encrypted: i=1; AJvYcCVGhs98tpJzJXq57GN5TfHq0VUKUFNsZreSAUVtPjubmu2rBVrU05KhUVfYJpcnM2gizbtF0toYFqscJOIi@vger.kernel.org
X-Gm-Message-State: AOJu0YzSTVuTmJl0r0OKhkCpYOAIciQGESmOVsu5FndJjpE0ienjQhX3
	OiwvGhqIMNiKSKnp6kF1POQsmknQCGs/3if/ViwI1O89ZWMU7VL6CM8tMUBgCrAckuY6HD7TnaA
	Fr1ew14S1s2KhNEU06mtgBLZneYx1uml8jSjLUUKGfQZNeUwS8NExzN9/w1Uvae2hhA==
X-Gm-Gg: ASbGncuJybP8bkQAQsPFf62qIjeaQQhhqWBh8yDX5l65AgNQW7nyRVMxWT/5x5yvX0V
	hu5ZiVGNMAsaJdqeXVf15tLCk41ZRByRhDzrsJ67Z4VBVyUbRCiTZ++ePYtP2z3T0L+b2q6xvjh
	2CqYMIQTDKjnXMmUmT0dhhB82ddgXKQ1EtNcpeZQdut1FJxIqlcNEzp02WmVhoucegIbPMaHiti
	1BIahqQDQewvIdoXFyUCZLD4nVuqgSVf+xi+eai4Tm1o2k6qFySkiNOVoeYLw0ZYhSrfT7LIF81
	6VxuPn8FnCGAud5or3y/BptXm38+
X-Received: by 2002:a05:600c:a07:b0:442:f12f:bd9f with SMTP id 5b1f17b1804b1-4538ee8c552mr151673215e9.27.1751300428509;
        Mon, 30 Jun 2025 09:20:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdUVDSeOrA0RtV7R3mFCcxfA131vGULaT/aJA9sbKcS86akLQJA8inrj2BetophhOUkdLpoA==
X-Received: by 2002:a05:600c:a07:b0:442:f12f:bd9f with SMTP id 5b1f17b1804b1-4538ee8c552mr151672755e9.27.1751300427992;
        Mon, 30 Jun 2025 09:20:27 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c1easm168769245e9.3.2025.06.30.09.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:20:27 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH v6 0/6] fs: introduce file_getattr and file_setattr
 syscalls
Date: Mon, 30 Jun 2025 18:20:10 +0200
Message-Id: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADq5YmgC/23N3YrCMBCG4VuRHJslM/lp65H3sexBfiYaLK0kp
 SjSezeKUJZ6+H4wzzxYoZyosMPuwTLNqaRxqGH2O+bPdjgRT6E2Q4FaACh+s9OU7cTLvXjb99x
 YAGkCBqc7Vq+umWK6vcXfv9rnVKYx398PZnytHwtxY83IgWsnjQgqOu/weKE8UP8z5hN7YbNcA
 QTYArICVjQBdGy79gugVkDiF0BxwSW1SCY6iUZtAL0CGuQW0BVAdK7zxjemif+AZVmeVUu1RXI
 BAAA=
X-Change-ID: 20250114-xattrat-syscall-6a1136d2db59
To: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Casey Schaufler <casey@schaufler-ca.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>, 
 Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9249; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=UaZEmtTk6LQBIwpX1H3cI6wrEZYIs4ph5Bt1MCtdJSw=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMpJ2evEe4nygf2jSy/17NqzKMV77NWrN51k74wUOJ
 FQ8nvf893SZjlIWBjEuBlkxRZZ10lpTk4qk8o8Y1MjDzGFlAhnCwMUpABOxO8Dwv2bHKl2v83cP
 X11fNJv57pGt/P3rvC8dfLzq76NlfVPL6p4x/K98oRrEZ3JO/zJj23QL6ZzfFk+m3GA9P79/e+z
 b+edl9PkApuVPhQ==
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

This patchset introduced two new syscalls file_getattr() and
file_setattr(). These syscalls are similar to FS_IOC_FSSETXATTR ioctl()
except they use *at() semantics. Therefore, there's no need to open the
file to get a fd.

These syscalls allow userspace to set filesystem inode attributes on
special files. One of the usage examples is XFS quota projects.

XFS has project quotas which could be attached to a directory. All
new inodes in these directories inherit project ID set on parent
directory.

The project is created from userspace by opening and calling
FS_IOC_FSSETXATTR on each inode. This is not possible for special
files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
with empty project ID. Those inodes then are not shown in the quota
accounting but still exist in the directory. This is not critical but in
the case when special files are created in the directory with already
existing project quota, these new inodes inherit extended attributes.
This creates a mix of special files with and without attributes.
Moreover, special files with attributes don't have a possibility to
become clear or change the attributes. This, in turn, prevents userspace
from re-creating quota project on these existing files.

An xfstests test generic/766 with basic coverage is at:
https://github.com/alberand/xfstests/commits/b4/file-attr/

NAME

	file_getattr/file_setattr - get/set filesystem inode attributes

SYNOPSIS

	#include <sys/syscall.h>    /* Definition of SYS_* constants */
	#include <unistd.h>

	long syscall(SYS_file_getattr, int dirfd, const char *pathname,
		struct fsx_fileattr *fsx, size_t size,
		unsigned int at_flags);
	long syscall(SYS_file_setattr, int dirfd, const char *pathname,
		struct fsx_fileattr *fsx, size_t size,
		unsigned int at_flags);

	Note: glibc doesn't provide for file_getattr()/file_setattr(),
	use syscall(2) instead.

DESCRIPTION

	The file_getattr()/file_setattr() are used to set extended file
	attributes. These syscalls take dirfd in conjunction with the
	pathname argument. The syscall then operates on inode opened
	according to openat(2) semantics.

	This is an alternative to FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR
	ioctl with a difference that file don't need to be open as file
	can be referenced with a path instead of fd. By having this one
	can manipulated filesystem inode attributes not only on regular
	files but also on special ones. This is not possible with
	FS_IOC_FSSETXATTR ioctl as ioctl() can not be called on special
	files directly for the filesystem inode.

	at_flags can be set to AT_SYMLINK_NOFOLLOW or AT_EMPTY_PATH.

RETURN VALUE

	On success, 0 is returned.  On error, -1 is returned, and errno
	is set to indicate the error.

ERRORS

	EINVAL		Invalid at_flag specified (only
			AT_SYMLINK_NOFOLLOW and AT_EMPTY_PATH is
			supported).

	EINVAL		Size was smaller than any known version of
			struct fsx_fileattr.

	EINVAL		Invalid combination of parameters provided in
			fsx_fileattr for this type of file.

	E2BIG		Size of input argument struct fsx_fileattr
			is too big.

	EBADF		Invalid file descriptor was provided.

	EPERM		No permission to change this file.

	EOPNOTSUPP	Filesystem does not support setting attributes
			on this type of inode

HISTORY

	Added in Linux 6.16.

EXAMPLE

Create directory and file "mkdir ./dir && touch ./dir/foo" and then
execute the following program:

	#include <fcntl.h>
	#include <errno.h>
	#include <string.h>
	#include <linux/fs.h>
	#include <stdio.h>
	#include <sys/syscall.h>
	#include <unistd.h>

	#if !defined(SYS_file_getattr) && defined(__x86_64__)
	#define SYS_file_getattr 468
	#define SYS_file_setattr 469

	struct fsx_fileattr {
	       __u32           fsx_xflags;
	       __u32           fsx_extsize;
	       __u32           fsx_nextents;
	       __u32           fsx_projid;
	       __u32           fsx_cowextsize;
	};
	#endif

	int
	main(int argc, char **argv) {
	        int dfd;
	        int error;
	        struct fsx_fileattr fsx;

	        dfd = open("./dir", O_RDONLY);
	        if (dfd == -1) {
	                printf("can not open ./dir");
	                return dfd;
	        }

	        error = syscall(SYS_file_getattr, dfd, "./foo", &fsx,
	                        sizeof(struct fsx_fileattr), 0);
	        if (error) {
	                printf("can not call SYS_file_getattr: %s",
				strerror(errno));
	                return error;
	        }

	        printf("./dir/foo flags: %d\n", fsx.fsx_xflags);

	        fsx.fsx_xflags |= FS_XFLAG_NODUMP;
	        error = syscall(SYS_file_setattr, dfd, "./foo", &fsx,
	                        sizeof(struct fsx_fileattr), 0);
	        if (error) {
			printf("can not call SYS_file_setattr: %s",
				strerror(errno));
	                return error;
	        }

	        printf("./dir/foo flags: %d\n", fsx.fsx_xflags);

	        return error;
	}

SEE ALSO

	ioctl(2), ioctl_iflags(2), ioctl_xfs_fsgetxattr(2), openat(2)

---
Changes in v6:
- Update cover letter example and docs
- Applied __free() attribute for syscall stack objects
- Introduced struct fsx_fileattr
- Replace 'struct fsxattr' with 'struct fsx_fileattr'
- Add helper to fill in fsx_fileattr from fileattr
- Dropped copy_fsx_to_user() header declaration
- Link to v5: https://lore.kernel.org/r/20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org

Changes in v5:
- Remove setting of LOOKUP_EMPTY flags which does not have any effect
- Return -ENOSUPP from vfs_fileattr_set()
- Add fsxattr masking (by Amir)
- Fix UAF issue dentry
- Fix getname_maybe_null() issue with NULL path
- Implement file_getattr/file_setattr hooks
- Return LSM return code from file_setattr
- Rename from getfsxattrat/setfsxattrat to file_getattr/file_setattr
- Link to v4: https://lore.kernel.org/r/20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org

Changes in v4:
- Use getname_maybe_null() for correct handling of dfd + path semantic
- Remove restriction for special files on which flags are allowed
- Utilize copy_struct_from_user() for better future compatibility
- Add draft man page to cover letter
- Convert -ENOIOCTLCMD to -EOPNOSUPP as more appropriate for syscall
- Add missing __user to header declaration of syscalls
- Link to v3: https://lore.kernel.org/r/20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org

Changes in v3:
- Remove unnecessary "dfd is dir" check as it checked in user_path_at()
- Remove unnecessary "same filesystem" check
- Use CLASS() instead of directly calling fdget/fdput
- Link to v2: https://lore.kernel.org/r/20250122-xattrat-syscall-v2-1-5b360d4fbcb2@kernel.org

v1:
https://lore.kernel.org/linuxppc-dev/20250109174540.893098-1-aalbersh@kernel.org/

Previous discussion:
https://lore.kernel.org/linux-xfs/20240520164624.665269-2-aalbersh@redhat.com/

---
Amir Goldstein (1):
      fs: prepare for extending file_get/setattr()

Andrey Albershteyn (5):
      fs: split fileattr related helpers into separate file
      lsm: introduce new hooks for setting/getting inode fsxattr
      selinux: implement inode_file_[g|s]etattr hooks
      fs: make vfs_fileattr_[get|set] return -EOPNOSUPP
      fs: introduce file_getattr and file_setattr syscalls

 arch/alpha/kernel/syscalls/syscall.tbl      |   2 +
 arch/arm/tools/syscall.tbl                  |   2 +
 arch/arm64/tools/syscall_32.tbl             |   2 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   2 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   2 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   2 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   2 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   2 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   2 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   2 +
 arch/s390/kernel/syscalls/syscall.tbl       |   2 +
 arch/sh/kernel/syscalls/syscall.tbl         |   2 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   2 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   2 +
 fs/Makefile                                 |   3 +-
 fs/ecryptfs/inode.c                         |   8 +-
 fs/file_attr.c                              | 493 ++++++++++++++++++++++++++++
 fs/ioctl.c                                  | 309 -----------------
 fs/overlayfs/inode.c                        |   2 +-
 include/linux/fileattr.h                    |  24 ++
 include/linux/lsm_hook_defs.h               |   2 +
 include/linux/security.h                    |  16 +
 include/linux/syscalls.h                    |   6 +
 include/uapi/asm-generic/unistd.h           |   8 +-
 include/uapi/linux/fs.h                     |  18 +
 scripts/syscall.tbl                         |   2 +
 security/security.c                         |  30 ++
 security/selinux/hooks.c                    |  14 +
 30 files changed, 654 insertions(+), 313 deletions(-)
---
base-commit: d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
change-id: 20250114-xattrat-syscall-6a1136d2db59

Best regards,
-- 
Andrey Albershteyn <aalbersh@kernel.org>



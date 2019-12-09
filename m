Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E80C1165E6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 05:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfLIEtq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Dec 2019 23:49:46 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:1443 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726826AbfLIEtq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Dec 2019 23:49:46 -0500
X-IronPort-AV: E=Sophos;i="5.69,294,1571673600"; 
   d="scan'208";a="79850878"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Dec 2019 12:49:43 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 72DB04CE1A05;
        Mon,  9 Dec 2019 12:41:06 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 9 Dec 2019 12:49:39 +0800
Subject: Re: [LTP] [PATCH v2] syscalls/newmount: new test case for new mount
 API
To:     Zorro Lang <zlang@redhat.com>, <ltp@lists.linux.it>
CC:     <linux-fsdevel@vger.kernel.org>
References: <20191208141617.21925-1-zlang@redhat.com>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <b59bb33a-205a-581b-91ac-c1e05e92ca93@cn.fujitsu.com>
Date:   Mon, 9 Dec 2019 12:49:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20191208141617.21925-1-zlang@redhat.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 72DB04CE1A05.AEEA2
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Zorro

ON 2019/12/08 22:16, Zorro Lang wrote:
> 
> diff --git a/configure.ac b/configure.ac
> index 50d14967d..28f840c51 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -229,6 +229,7 @@ LTP_CHECK_MADVISE
>   LTP_CHECK_MKDTEMP
>   LTP_CHECK_MMSGHDR
>   LTP_CHECK_MREMAP_FIXED
> +LTP_CHECK_NEWMOUNT
>   LTP_CHECK_NOMMU_LINUX
>   LTP_CHECK_PERF_EVENT
>   LTP_CHECK_PRCTL_SUPPORT
> diff --git a/include/lapi/newmount.h b/include/lapi/newmount.h
> new file mode 100644
> index 000000000..6b787fe7d
> --- /dev/null
> +++ b/include/lapi/newmount.h
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2019 Red Hat, Inc.  All rights reserved.
> + * Author: Zorro Lang <zlang@redhat.com>
> + */
> +
> +#ifndef NEWMOUNT_H__
> +#define NEWMOUNT_H__
> +
> +#include <stdint.h>
> +#include <unistd.h>
> +#include "config.h"
> +#include "lapi/syscalls.h"
> +
> +#if !defined(HAVE_NEWMOUNT)
Why use HVAE_NEWMOUNT?
> +static inline int fsopen(const char *fs_name, unsigned int flags)
> +{
> +	return tst_syscall(__NR_fsopen, fs_name, flags);
> +}
> +
> +/*
> + * fsopen() flags.
> + */
> +#define FSOPEN_CLOEXEC		0x00000001
> +
> +static inline int fsconfig(int fsfd, unsigned int cmd,
> +                           const char *key, const void *val, int aux)
> +{
> +	return tst_syscall(__NR_fsconfig, fsfd, cmd, key, val, aux);
> +}
> +
> +/*
> + * The type of fsconfig() call made.
> + */
> +enum fsconfig_command {
> +	FSCONFIG_SET_FLAG	= 0,    /* Set parameter, supplying no value */
> +	FSCONFIG_SET_STRING	= 1,    /* Set parameter, supplying a string value */
> +	FSCONFIG_SET_BINARY	= 2,    /* Set parameter, supplying a binary blob value */
> +	FSCONFIG_SET_PATH	= 3,    /* Set parameter, supplying an object by path */
> +	FSCONFIG_SET_PATH_EMPTY	= 4,    /* Set parameter, supplying an object by (empty) path */
> +	FSCONFIG_SET_FD		= 5,    /* Set parameter, supplying an object by fd */
> +	FSCONFIG_CMD_CREATE	= 6,    /* Invoke superblock creation */
> +	FSCONFIG_CMD_RECONFIGURE = 7,   /* Invoke superblock reconfiguration */
> +};
> +
> +static inline int fsmount(int fsfd, unsigned int flags, unsigned int ms_flags)
> +{
> +	return tst_syscall(__NR_fsmount, fsfd, flags, ms_flags);
> +}
> +
> +/*
> + * fsmount() flags.
> + */
> +#define FSMOUNT_CLOEXEC		0x00000001
> +
> +/*
> + * Mount attributes.
> + */
> +#define MOUNT_ATTR_RDONLY	0x00000001 /* Mount read-only */
> +#define MOUNT_ATTR_NOSUID	0x00000002 /* Ignore suid and sgid bits */
> +#define MOUNT_ATTR_NODEV	0x00000004 /* Disallow access to device special files */
> +#define MOUNT_ATTR_NOEXEC	0x00000008 /* Disallow program execution */
> +#define MOUNT_ATTR__ATIME	0x00000070 /* Setting on how atime should be updated */
> +#define MOUNT_ATTR_RELATIME	0x00000000 /* - Update atime relative to mtime/ctime. */
> +#define MOUNT_ATTR_NOATIME	0x00000010 /* - Do not update access times. */
> +#define MOUNT_ATTR_STRICTATIME	0x00000020 /* - Always perform atime updates */
> +#define MOUNT_ATTR_NODIRATIME	0x00000080 /* Do not update directory access times */
> +
> +static inline int move_mount(int from_dfd, const char *from_pathname,
> +                             int to_dfd, const char *to_pathname,
> +                             unsigned int flags)
> +{
> +	return tst_syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd,
> +	                   to_pathname, flags);
> +}
> +
> +/*
> + * move_mount() flags.
> + */
> +#define MOVE_MOUNT_F_SYMLINKS		0x00000001 /* Follow symlinks on from path */
> +#define MOVE_MOUNT_F_AUTOMOUNTS		0x00000002 /* Follow automounts on from path */
> +#define MOVE_MOUNT_F_EMPTY_PATH		0x00000004 /* Empty from path permitted */
> +#define MOVE_MOUNT_T_SYMLINKS		0x00000010 /* Follow symlinks on to path */
> +#define MOVE_MOUNT_T_AUTOMOUNTS		0x00000020 /* Follow automounts on to path */
> +#define MOVE_MOUNT_T_EMPTY_PATH		0x00000040 /* Empty to path permitted */
> +#define MOVE_MOUNT__MASK		0x00000077
> +
> +#endif /* HAVE_NEWMOUNT */
> +#endif /* NEWMOUNT_H__ */
> diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
> index 0e00641bc..5b9e1d9a4 100644
> --- a/include/lapi/syscalls/aarch64.in
> +++ b/include/lapi/syscalls/aarch64.in
> @@ -270,4 +270,8 @@ pkey_mprotect 288
>   pkey_alloc 289
>   pkey_free 290
>   pidfd_send_signal 424
> +move_mount 429
> +fsopen 430
> +fsconfig 431
> +fsmount 432
>   _sysctl 1078
> diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
> index 660165d7a..3aaed64e0 100644
> --- a/include/lapi/syscalls/powerpc64.in
> +++ b/include/lapi/syscalls/powerpc64.in
> @@ -359,3 +359,7 @@ pidfd_send_signal 424
>   pkey_mprotect 386
>   pkey_alloc 384
>   pkey_free 385
> +move_mount 429
> +fsopen 430
> +fsconfig 431
> +fsmount 432
> diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
> index 7d632d1dc..bd427555a 100644
> --- a/include/lapi/syscalls/s390x.in
> +++ b/include/lapi/syscalls/s390x.in
> @@ -341,3 +341,7 @@ pkey_mprotect 384
>   pkey_alloc 385
>   pkey_free 386
>   pidfd_send_signal 424
> +move_mount 429
> +fsopen 430
> +fsconfig 431
> +fsmount 432
> diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
> index b1cbd4f2f..94f0b562e 100644
> --- a/include/lapi/syscalls/x86_64.in
> +++ b/include/lapi/syscalls/x86_64.in
> @@ -320,3 +320,7 @@ pkey_alloc 330
>   pkey_free 331
>   statx 332
>   pidfd_send_signal 424
> +move_mount 429
> +fsopen 430
> +fsconfig 431
> +fsmount 432
> diff --git a/m4/ltp-newmount.m4 b/m4/ltp-newmount.m4
> new file mode 100644
> index 000000000..e13a6f0b1
> --- /dev/null
> +++ b/m4/ltp-newmount.m4
> @@ -0,0 +1,10 @@
> +dnl SPDX-License-Identifier: GPL-2.0-or-later
> +dnl Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
> +
> +AC_DEFUN([LTP_CHECK_NEWMOUNT],[
> +AC_CHECK_FUNCS(fsopen,,)
> +AC_CHECK_FUNCS(fsconfig,,)
> +AC_CHECK_FUNCS(fsmount,,)
> +AC_CHECK_FUNCS(move_mount,,)
> +AC_CHECK_HEADER(sys/mount.h,,,)
> +])
You use m4 to check them. But it seems that you don't use those macros
in your cases.
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 15dbd9971..fac1c62d2 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -794,6 +794,8 @@ nanosleep01 nanosleep01
>   nanosleep02 nanosleep02
>   nanosleep04 nanosleep04
>   
> +newmount01 newmount01
> +
>   nftw01 nftw01
>   nftw6401 nftw6401
>   
> diff --git a/testcases/kernel/syscalls/newmount/.gitignore b/testcases/kernel/syscalls/newmount/.gitignore
> new file mode 100644
> index 000000000..dc78edd5b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/newmount/.gitignore
> @@ -0,0 +1 @@
> +/newmount01
> diff --git a/testcases/kernel/syscalls/newmount/Makefile b/testcases/kernel/syscalls/newmount/Makefile
> new file mode 100644
> index 000000000..7d0920df6
> --- /dev/null
> +++ b/testcases/kernel/syscalls/newmount/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2019 Red Hat, Inc.  All rights reserved.
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/newmount/newmount01.c b/testcases/kernel/syscalls/newmount/newmount01.c
> new file mode 100644
> index 000000000..464ecb699
> --- /dev/null
> +++ b/testcases/kernel/syscalls/newmount/newmount01.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2019 Red Hat, Inc.  All rights reserved.
> + * Author: Zorro Lang <zlang@redhat.com>
> + *
> + * Use new mount API (fsopen, fsconfig, fsmount, move_mount) to mount
> + * a filesystem without any specified mount options.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <sys/mount.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
"tst_test.h" has included "tst_safe_macros.h"
> +#include "lapi/newmount.h"
> +
> +#define LINELENGTH 256
> +#define MNTPOINT "newmount_point"
> +static int sfd, mfd;
> +static int is_mounted = 0;
static int sfd, mfd, is_mounted;
> +
> +static int ismount(char *mntpoint)
> +{
> +	int ret = 0;
> +	FILE *file;
> +	char line[LINELENGTH];
> +
> +	file = fopen("/proc/mounts", "r");
> +	if (file == NULL)
> +		tst_brk(TFAIL | TTERRNO, "Open /proc/mounts failed");
> +
> +	while (fgets(line, LINELENGTH, file) != NULL) {
> +		if (strstr(line, mntpoint) != NULL) {
> +			ret = 1;
> +			break;
> +		}
> +	}
> +	fclose(file);
> +	return ret;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (is_mounted) {
> +		TEST(tst_umount(MNTPOINT));
> +		if (TST_RET != 0)
> +			tst_brk(TFAIL | TTERRNO, "umount failed in cleanup");
> +	}
> +}
> +
> +static void test_newmount(void)
> +{
> +	TEST(fsopen(tst_device->fs_type, FSOPEN_CLOEXEC));
> +	if (TST_RET < 0) {
> +		tst_brk(TFAIL | TTERRNO,
> +		        "fsopen %s", tst_device->fs_type);
> +	}
> +	sfd = TST_RET;
> +	tst_res(TPASS, "fsopen %s", tst_device->fs_type);
> +
> +	TEST(fsconfig(sfd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
> +	if (TST_RET < 0) {
> +		tst_brk(TFAIL | TTERRNO,
> +		        "fsconfig set source to %s", tst_device->dev);
> +	}
> +	tst_res(TPASS, "fsconfig set source to %s", tst_device->dev);
> +
> +
> +	TEST(fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
> +	if (TST_RET < 0) {
> +		tst_brk(TFAIL | TTERRNO,
> +		        "fsconfig create superblock");
> +	}
> +	tst_res(TPASS, "fsconfig create superblock");
> +
> +	TEST(fsmount(sfd, FSMOUNT_CLOEXEC, 0));
> +	if (TST_RET < 0) {
> +		tst_brk(TFAIL | TTERRNO, "fsmount");
> +	}
> +	mfd = TST_RET;
> +	tst_res(TPASS, "fsmount");
> +	SAFE_CLOSE(sfd);
> +
> +	TEST(move_mount(mfd, "", AT_FDCWD, MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
> +	if (TST_RET < 0) {
> +		tst_brk(TFAIL | TTERRNO, "move_mount attach to mount point");
> +	}
> +	is_mounted = 1;
> +	tst_res(TPASS, "move_mount attach to mount point");
> +	SAFE_CLOSE(mfd);
> +
> +	if (ismount(MNTPOINT)) {
> +		tst_res(TPASS, "new mount works");
> +		TEST(tst_umount(MNTPOINT));
> +		if (TST_RET != 0)
> +			tst_brk(TFAIL | TTERRNO, "umount failed");
> +		is_mounted = 0;
cleanup also does umount operation. Maybe we can call it in here.
> +	} else {
> +		tst_res(TFAIL, "new mount fails");
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.test_all	= test_newmount,
> +	.cleanup	= cleanup,
> +	.needs_root	= 1,
> +	.mntpoint	= MNTPOINT,
> +	.needs_device	= 1,
In ltp library code, if you sepecify "format_device = 1", it will auto 
set "needs_device = 1". So remove it.

> +	.format_device	= 1,
> +	.all_filesystems = 1,
> +};
> 



Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B608710FE4A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 14:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfLCNDn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 08:03:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:35848 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfLCNDm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:03:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B4C71B2CA;
        Tue,  3 Dec 2019 13:03:40 +0000 (UTC)
Date:   Tue, 3 Dec 2019 14:03:39 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Zorro Lang <zlang@redhat.com>
Cc:     ltp@lists.linux.it, linux-fsdevel@vger.kernel.org
Subject: Re: [LTP] [PATCH] syscalls/newmount: new test case for new mount API
Message-ID: <20191203130339.GF2844@rei>
References: <20191128173532.6468-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128173532.6468-1-zlang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/newmount/newmount01.c b/testcases/kernel/syscalls/newmount/newmount01.c
> new file mode 100644
> index 000000000..35e355506
> --- /dev/null
> +++ b/testcases/kernel/syscalls/newmount/newmount01.c
> @@ -0,0 +1,150 @@
> +/*
> + * Copyright (C) 2019 Red Hat, Inc.  All rights reserved.
> + * Author: Zorro Lang <zlang@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + *
> + */
> +
> +/*
> + *  DESCRIPTION
> + *	Use new mount API (fsopen, fsconfig, fsmount, move_mount) to mount
> + *	a filesystem.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <sys/prctl.h>
> +#include <sys/wait.h>
> +#include <sys/mount.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +#include "lapi/newmount.h"
> +
> +#define LINELENGTH 256
> +#define MNTPOINT "newmount_point"
> +static int sfd, mfd;
> +static int mount_flag = 0;
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

Hmm, this is very similar to file_lines_scanf(), maybe we need a library
function that would iterate over file lines to call a callback on each
of them as well. I will think about this.

> +static void setup(void)
> +{
> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);

Why aren't we just setting .format_device in the test structure?

> +}
> +
> +static void cleanup(void)
> +{
> +	if (mount_flag == 1) {
> +		TEST(tst_umount(MNTPOINT));
> +		if (TST_RET != 0)
> +			tst_brk(TBROK | TTERRNO, "umount failed");

The library already produces TWARN if we fail to umount the device, so I
would say that there is no need to TBROK here, the TBROK will be
converted to TWARN anyways since it's in the cleanup...

> +	}
> +}
> +
> +
> +static void test_newmount(void)
> +{
> +	TEST(fsopen(tst_device->fs_type, FSOPEN_CLOEXEC));
> +	if (TST_RET < 0) {
> +		tst_brk(TFAIL | TTERRNO,
> +		        "fsopen %s", tst_device->fs_type);
> +	} else {

There is no need for else branches after tst_brk(), the test will exit
if we reach the tst_brk().

> +		sfd = TST_RET;
> +		tst_res(TPASS,
> +			"fsopen %s", tst_device->fs_type);
> +	}
> +
> +	TEST(fsconfig(sfd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
> +	if (TST_RET < 0) {
> +		tst_brk(TFAIL | TTERRNO,
> +		        "fsconfig set source to %s", tst_device->dev);
> +	} else {

Here as well.

> +		tst_res(TPASS,
> +			"fsconfig set source to %s", tst_device->dev);
> +	}
> +
> +	TEST(fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
> +	if (TST_RET < 0) {
> +		tst_brk(TFAIL | TTERRNO,
> +		        "fsconfig create superblock");

And here.

> +	} else {
> +		tst_res(TPASS,
> +			"fsconfig create superblock");
> +	}
> +
> +	TEST(fsmount(sfd, FSMOUNT_CLOEXEC, 0));
> +	if (TST_RET < 0) {
> +		tst_brk(TFAIL | TTERRNO, "fsmount");
> +	} else {

And here.

> +		mfd = TST_RET;
> +		tst_res(TPASS, "fsmount");
> +		SAFE_CLOSE(sfd);
> +	}
> +
> +	TEST(move_mount(mfd, "", AT_FDCWD, MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
> +	if (TST_RET < 0) {
> +		tst_brk(TFAIL | TTERRNO, "move_mount attach to mount point");
> +	} else {

And here.

> +		tst_res(TPASS, "move_mount attach to mount point");
> +		mount_flag = 1;
> +		if (ismount(MNTPOINT))
> +			tst_res(TPASS, "new mount works");
> +		else
> +			tst_res(TFAIL, "new mount fails");
> +	}
> +	SAFE_CLOSE(mfd);

We have to umount the device here, otherwise it would be mounted for
each test iteration with -i.

> +}
> +
> +struct test_cases {
> +	void (*tfunc)(void);
> +} tcases[] = {
> +	{&test_newmount},
> +};

Unless you plan to add more tests here, there is no point in declaring
the structure with function pointers.

> +static void run(unsigned int i)
> +{
> +	tcases[i].tfunc();
> +}
> +
> +static struct tst_test test = {
> +	.test		= run,
> +	.tcnt		= ARRAY_SIZE(tcases),
> +	.setup		= setup,
> +	.cleanup	= cleanup,
> +	.needs_root	= 1,
> +	.mntpoint	= MNTPOINT,
> +	.needs_device	= 1,
> +};

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

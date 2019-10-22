Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F331DFD95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 08:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387456AbfJVGNe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 02:13:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:36988 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730915AbfJVGNe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 02:13:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7BDEB3B5;
        Tue, 22 Oct 2019 06:13:31 +0000 (UTC)
Date:   Tue, 22 Oct 2019 08:13:29 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     ltp@lists.linux.it, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [LTP] [PATCH v2] syscalls/copy_file_range02: skip if cross-fs
 isn't supported
Message-ID: <20191022061328.GA9267@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190930093627.30159-1-pvorel@suse.cz>
 <f9121245-60e5-5dfe-4b17-47b38c0f5ff4@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9121245-60e5-5dfe-4b17-47b38c0f5ff4@cn.fujitsu.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Xu, others,

[ Cc Amir and linux-fsdevel ].

> on 2019/09/30 17:36, Petr Vorel wrote:

> > copy_file_range02 was written to verify copy_file_range() v5.3 changes.
> > Detect it via cross-filesystem copy_file_range() functionality, so that we
> > cover also backports to stable/enterprise distro kernels (if backported,
> > it should be with all those API fixes).

> > Missing these API fixes is detected by errno changes introduced by
> > This fixes errors caused by commits from v5.3-rc1:
> > 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
> > 96e6e8f4a68d ("vfs: add missing checks to copy_file_range")

> > This check requires to put back into copy_file_range02 .mount_device = 1
> > and .mntpoint = MNTPOINT (but .all_filesystems = 1 is obviously not needed).

> Hi Petr
>    Why we must put back .mount_device and .mntpoint = MNTPOINT?

> copy_file_range02 was not only written to verify copy_file_range() v5.3 changes
> and it also tests other errors before v5.3.
This fix was based on Amir's suggestion [1], he states the opposite:

IIUC, copy_file_range02 was written after v5.3 changes to verify that
copy_file_range
stays unbroken.
As such, I would suggest that you check if kernel supports cross-fs copy, like
copy_file_range01 does and if it doesn't, skip the test entirely.
If some one ever backports cross-fs copy to any distro stable kernel, then one
would better also backkport all of those API fixes, otherwise test will fail.


> I think cross-filesystem copy_file_range is a kernel action change and then I
> put it into copy_file_range01.c. So copy_file_range02.c doesn't test EXDEV error .

> Also since commit v5.3-rc1 two commit, immutable file(EPERM)，swap file(ETXTBSY)，
> overlaping range(EINVAL), max length lenght(EOVERFLOW),max file size(EFBIG) these
> check have been add. But other errors still existed before this two commits such as:
> copy contents to file open as readonly *    -> EBADF

> Now, before v5.3-rc1, copy_file_range02.c  is notrun that we don't do error check.
> It is unreasonable.
So, do you suggest to test EBADF for all versions? Or something else?

> ps:
> copy_file_range newest man-pages
> https://github.com/mkerrisk/man-pages/commit/88e75e2c56a68eaf8fcf662a63b802fdf77a4017
Yep, Amir planned to fix it :).

> Thanks
> Yang Xu

[1] http://lists.linux.it/pipermail/ltp/2019-September/013697.html

> > + Remove few unused imports.

> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Changes v1->v2:
> > pass the source and destination as parameters to
> > verify_cross_fs_copy_support(), remove bogus setup checks
> > (Suggested by Cyril).

> > Kind regards,
> > Petr

> >   .../copy_file_range/copy_file_range.h         | 23 ++++++++++++++++---
> >   .../copy_file_range/copy_file_range01.c       | 22 ++----------------
> >   .../copy_file_range/copy_file_range02.c       | 11 ++++++++-
> >   3 files changed, 32 insertions(+), 24 deletions(-)

> > diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range.h b/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
> > index 40d05d653..1d80ab0f7 100644
> > --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
> > +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
> > @@ -7,9 +7,7 @@
> >   #ifndef __COPY_FILE_RANGE_H__
> >   #define __COPY_FILE_RANGE_H__
> > -#include <stdbool.h>
> > -#include <unistd.h>
> > -#include <sys/sysmacros.h>
> > +#include <stdio.h>
> >   #include "lapi/syscalls.h"
> >   #include "lapi/fs.h"
> > @@ -62,4 +60,23 @@ static int sys_copy_file_range(int fd_in, loff_t *off_in,
> >   	return -1;
> >   }
> > +static inline int verify_cross_fs_copy_support(const char *path_in, const char *path_out)
> > +{
> > +	int i, fd, fd_test;
> > +
> > +	fd = SAFE_OPEN(path_in, O_RDWR | O_CREAT, 0664);
> > +	/* Writing page_size * 4 of data into test file */
> > +	for (i = 0; i < (int)(getpagesize() * 4); i++)
> > +		SAFE_WRITE(1, fd, CONTENT, CONTSIZE);
> > +
> > +	fd_test = SAFE_OPEN(path_out, O_RDWR | O_CREAT, 0664);
> > +	TEST(sys_copy_file_range(fd, 0, fd_test, 0, CONTSIZE, 0));
> > +
> > +	SAFE_CLOSE(fd_test);
> > +	remove(FILE_MNTED_PATH);
> > +	SAFE_CLOSE(fd);
> > +
> > +	return TST_ERR == EXDEV ? 0 : 1;
> > +}
> > +
> >   #endif /* __COPY_FILE_RANGE_H__ */
> > diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
> > index ec55e5da1..6097c85b3 100644
> > --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
> > +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
> > @@ -16,8 +16,6 @@
> >   #define _GNU_SOURCE
> > -#include <stdio.h>
> > -#include <stdlib.h>
> >   #include "tst_test.h"
> >   #include "tst_safe_stdio.h"
> >   #include "copy_file_range.h"
> > @@ -179,7 +177,7 @@ static void copy_file_range_verify(unsigned int n)
> >   	if (tc->flags && !cross_sup) {
> >   		tst_res(TCONF,
> > -			"copy_file_range doesn't support cross-device, skip it");
> > +			"copy_file_range() doesn't support cross-device, skip it");
> >   		return;
> >   	}
> > @@ -215,25 +213,9 @@ static void copy_file_range_verify(unsigned int n)
> >   static void setup(void)
> >   {
> > -	int i, fd, fd_test;
> > -
> >   	syscall_info();
> > -
> >   	page_size = getpagesize();
> > -	cross_sup = 1;
> > -	fd = SAFE_OPEN(FILE_SRC_PATH, O_RDWR | O_CREAT, 0664);
> > -	/* Writing page_size * 4 of data into test file */
> > -	for (i = 0; i < (int)(page_size * 4); i++)
> > -		SAFE_WRITE(1, fd, CONTENT, CONTSIZE);
> > -
> > -	fd_test = SAFE_OPEN(FILE_MNTED_PATH, O_RDWR | O_CREAT, 0664);
> > -	TEST(sys_copy_file_range(fd, 0, fd_test, 0, CONTSIZE, 0));
> > -	if (TST_ERR == EXDEV)
> > -		cross_sup = 0;
> > -
> > -	SAFE_CLOSE(fd_test);
> > -	remove(FILE_MNTED_PATH);
> > -	SAFE_CLOSE(fd);
> > +	cross_sup = verify_cross_fs_copy_support(FILE_SRC_PATH, FILE_MNTED_PATH);
> >   }
> >   static void cleanup(void)
> > diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> > index d6e843ee4..6e385adbd 100644
> > --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> > +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> > @@ -49,6 +49,7 @@ static int fd_blkdev;
> >   static int fd_chrdev;
> >   static int fd_fifo;
> >   static int fd_copy;
> > +static int need_unlink;
> >   static int chattr_i_nsup;
> >   static int swap_nsup;
> > @@ -160,7 +161,8 @@ static void cleanup(void)
> >   		SAFE_CLOSE(fd_dup);
> >   	if (fd_copy > 0)
> >   		SAFE_CLOSE(fd_copy);
> > -	SAFE_UNLINK(FILE_FIFO);
> > +	if (need_unlink > 0)
> > +		SAFE_UNLINK(FILE_FIFO);
> >   }
> >   static void setup(void)
> > @@ -168,6 +170,10 @@ static void setup(void)
> >   	syscall_info();
> >   	char dev_path[1024];
> > +	if (!verify_cross_fs_copy_support(FILE_SRC_PATH, FILE_MNTED_PATH))
> > +		tst_brk(TCONF,
> > +			"copy_file_range() doesn't support cross-device, skip it");
> > +
> >   	if (access(FILE_DIR_PATH, F_OK) == -1)
> >   		SAFE_MKDIR(FILE_DIR_PATH, 0777);
> >   	/*
> > @@ -177,6 +183,7 @@ static void setup(void)
> >   	loop_devn = tst_find_free_loopdev(dev_path, sizeof(dev_path));
> >   	SAFE_MKNOD(FILE_FIFO, S_IFIFO | 0777, 0);
> > +	need_unlink = 1;
> >   	fd_src    = SAFE_OPEN(FILE_SRC_PATH, O_RDWR | O_CREAT, 0664);
> >   	fd_dest   = SAFE_OPEN(FILE_DEST_PATH, O_RDWR | O_CREAT, 0664);
> > @@ -223,6 +230,8 @@ static struct tst_test test = {
> >   	.tcnt = ARRAY_SIZE(tcases),
> >   	.setup = setup,
> >   	.cleanup = cleanup,
> > +	.mount_device = 1,
> > +	.mntpoint = MNTPOINT,
> >   	.needs_root = 1,
> >   	.needs_tmpdir = 1,
> >   	.test_variants = TEST_VARIANTS,



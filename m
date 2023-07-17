Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0C57569CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 19:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGQREO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 13:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGQREN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:04:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E059E1;
        Mon, 17 Jul 2023 10:04:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0415E61159;
        Mon, 17 Jul 2023 17:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10942C433C7;
        Mon, 17 Jul 2023 17:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689613451;
        bh=eFRcmjhagGhmISVeQwPqWx/NIgotbqpXzmAQUFtgGGQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YAU1FgeFT9fa7ExhQmBbrFpbaM8MTVkCud+fATEuZ2JSfa6QOrpaqydRxzfEzBfT0
         WLo58tDSYCAan0BWjdIEEetMWlvotyRZfuR+Nkk4jDIc21tSCLZ6bxJ1CI/YifZN1X
         K2/66CsA+mGVAphmsS6RHGIAHq2dad//a6MXyo/0Sn5VUOjrI0lr6jThfqt4VJdy6K
         q31+hXyYuan4UEfT48yWVjO3gJkB8iDEsI9d7zCE02F8IK/F2mb0aTgas4YTbEeb+y
         TolhR2hGDwjTT3UJrewnW6GYVL70fVKnjPVQ8sX9h465ehCUddLjng2zj2CmpdiDkV
         lldT4PLMOKgwg==
Message-ID: <057c999c8c129b70a189d7163422ca45f1cae3ee.camel@kernel.org>
Subject: Re: [fstests PATCH] generic: add a test for multigrain timestamps
From:   Jeff Layton <jlayton@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 17 Jul 2023 13:04:09 -0400
In-Reply-To: <20230717153547.GC11340@frogsfrogsfrogs>
References: <20230713230939.367068-1-jlayton@kernel.org>
         <20230717153547.GC11340@frogsfrogsfrogs>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-07-17 at 08:35 -0700, Darrick J. Wong wrote:
> On Thu, Jul 13, 2023 at 07:09:39PM -0400, Jeff Layton wrote:
> > Ensure that the mtime and ctime apparently change, even when there are
> > multiple writes in quick succession. Older kernels didn't do this, but
> > there are patches in flight that should help ensure it in the future.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  src/Makefile          |   2 +-
> >  src/mgctime.c         | 107 ++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/730     |  25 ++++++++++
> >  tests/generic/730.out |   1 +
> >  4 files changed, 134 insertions(+), 1 deletion(-)
> >  create mode 100644 src/mgctime.c
> >  create mode 100755 tests/generic/730
> >  create mode 100644 tests/generic/730.out
> >=20
> > This patchset is intended to test the new multigrain timestamp feature:
> >=20
> >     https://lore.kernel.org/linux-fsdevel/20230713-mgctime-v5-0-9eb795d=
2ae37@kernel.org/T/#t
> >=20
> > I had originally attempted to write this as a shell script, but it was
> > too slow, which made it falsely pass on unpatched kernels.
> >=20
> > All current filesystems will fail this, so we may want to wait until
> > we are closer to merging the kernel series.
>=20
> I wonder, /should/ there be a way to declare to userspace that small
> writes in rapid succession are supposed to result in separately
> observable mtimestamps?
>
> That might be hard to define generally -- what happens if the filesystem
> doesn't support nanosecond precision, e.g. fat?  Or if the system
> doesn't have any clocks with better precision than jiffies?  The
> expected minimum timestamp change granularity could be exported too, but
> that's even more complexity... :(
>=20
> Thoughts?
>=20

Yeah, I couldn't come up with a good way to report and detect this
behavior in userland.

In principle, I guess we could create a new STATX_ATTR_MGTS flag for
this, but it sort of feels like we're trying expose the existence of an
implementation detail to userland.

We could try to expose the sb->s_time_gran to userland via (e.g.)
fsinfo(), but that's really sort of a different thing than the
granularity we're dealing with here. That's all about how we mask off
low-order bits before reporting the timestamps.

Most filesystems set that to 1ns anyway, even though they fill that out
with a coarse-grained timestamp, so that wouldn't help us detect
filesystems that are expected to fail this. At the end of the day, this
may be the sort of test where we have specific filesystems that are
known to pass opt-in to it somehow.


> > diff --git a/src/Makefile b/src/Makefile
> > index 24cd47479140..aff7d07466f0 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -33,7 +33,7 @@ LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize p=
reallo_rw_pattern_reader \
> >  	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
> >  	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
> >  	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
> > -	uuid_ioctl
> > +	uuid_ioctl mgctime
> > =20
> >  EXTRA_EXECS =3D dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
> >  	      btrfs_crc32c_forged_name.py popdir.pl popattr.py
> > diff --git a/src/mgctime.c b/src/mgctime.c
> > new file mode 100644
> > index 000000000000..38e22a8613ff
> > --- /dev/null
> > +++ b/src/mgctime.c
> > @@ -0,0 +1,107 @@
> > +/*
>=20
> Needs a SPDX header, I think.
>=20
> The C program itself looks ok though.
>=20
> --D
>=20

Thanks, I'll add that in!

> > + * Older Linux kernels always use coarse-grained timestamps, with a
> > + * resolution of around 1 jiffy. Writes that are done in quick success=
ion
> > + * on those kernels apparent change to the ctime or mtime.
> > + *
> > + * Newer kernels attempt to ensure that fine-grained timestamps are us=
ed
> > + * when the mtime or ctime are queried from userland.
> > + *
> > + * Open a file and do a 1 byte write to it and then statx the mtime an=
d ctime.
> > + * Do that in a loop 1000 times and ensure that the value is different=
 from
> > + * the last.
> > + *
> > + * Copyright (c) 2023: Jeff Layton <jlayton@kernel.org>
> > + */
> > +#define _GNU_SOURCE 1
> > +#include <stdio.h>
> > +#include <fcntl.h>
> > +#include <errno.h>
> > +#include <sys/stat.h>
> > +#include <unistd.h>
> > +#include <stdint.h>
> > +#include <getopt.h>
> > +#include <stdbool.h>
> > +
> > +#define NUM_WRITES 1000
> > +
> > +static int64_t statx_ts_cmp(struct statx_timestamp *ts1, struct statx_=
timestamp *ts2)
> > +{
> > +	int64_t ret =3D ts2->tv_sec - ts1->tv_sec;
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D ts2->tv_nsec;
> > +	ret -=3D ts1->tv_nsec;
> > +
> > +	return ret;
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	int ret, fd, i;
> > +	struct statx stx =3D { };
> > +	struct statx_timestamp ctime, mtime;
> > +	bool verbose =3D false;
> > +
> > +	while ((i =3D getopt(argc, argv, "v")) !=3D -1) {
> > +		switch (i) {
> > +		case 'v':
> > +			verbose =3D true;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (argc < 2) {
> > +		errno =3D -EINVAL;
> > +		perror("usage");
> > +	}
> > +
> > +	fd =3D open(argv[1], O_WRONLY|O_CREAT|O_TRUNC, 0644);
> > +	if (fd < 0) {
> > +		perror("open");
> > +		return 1;
> > +	}
> > +
> > +	ret =3D statx(fd, "", AT_EMPTY_PATH, STATX_MTIME|STATX_CTIME, &stx);
> > +	if (ret < 0) {
> > +		perror("stat");
> > +		return 1;
> > +	}
> > +
> > +	ctime =3D stx.stx_ctime;
> > +	mtime =3D stx.stx_mtime;
> > +
> > +	for (i =3D 0; i < NUM_WRITES; ++i) {
> > +		ssize_t written;
> > +
> > +		written =3D write(fd, "a", 1);
> > +		if (written < 0) {
> > +			perror("write");
> > +			return 1;
> > +		}
> > +
> > +		ret =3D statx(fd, "", AT_EMPTY_PATH, STATX_MTIME|STATX_CTIME, &stx);
> > +		if (ret < 0) {
> > +			perror("stat");
> > +			return 1;
> > +		}
> > +
> > +		if (verbose)
> > +			printf("%d: %llu.%u\n", i, stx.stx_ctime.tv_sec, stx.stx_ctime.tv_n=
sec);
> > +
> > +		if (!statx_ts_cmp(&ctime, &stx.stx_ctime)) {
> > +			printf("Duplicate ctime after write!\n");
> > +			return 1;
> > +		}
> > +
> > +		if (!statx_ts_cmp(&mtime, &stx.stx_mtime)) {
> > +			printf("Duplicate mtime after write!\n");
> > +			return 1;
> > +		}
> > +
> > +		ctime =3D stx.stx_ctime;
> > +		mtime =3D stx.stx_mtime;
> > +	}
> > +	return 0;
> > +}
> > diff --git a/tests/generic/730 b/tests/generic/730
> > new file mode 100755
> > index 000000000000..c3f24aeb8534
> > --- /dev/null
> > +++ b/tests/generic/730
> > @@ -0,0 +1,25 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2023, Jeff Layton <jlayton@redhat.com>
> > +#
> > +# FS QA Test No. 730
> > +#
> > +# Multigrain time test
> > +#
> > +# Open a file, and do 1 byte writes to it, and statx the file for
> > +# the ctime and mtime after each write. Ensure that they have changed
> > +# since the previous write.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick
> > +
> > +# Override the default cleanup function.
> > +_require_test_program mgctime
> > +
> > +testfile=3D"$TEST_DIR/test_mgtime_file.$$"
> > +
> > +$here/src/mgctime $testfile
> > +
> > +# success, all done
> > +status=3D0
> > +exit
> > diff --git a/tests/generic/730.out b/tests/generic/730.out
> > new file mode 100644
> > index 000000000000..5dbea532d60f
> > --- /dev/null
> > +++ b/tests/generic/730.out
> > @@ -0,0 +1 @@
> > +QA output created by 730
> > --=20
> > 2.41.0
> >=20

--=20
Jeff Layton <jlayton@kernel.org>

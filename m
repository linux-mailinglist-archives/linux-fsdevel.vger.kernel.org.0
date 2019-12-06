Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01F031154E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 17:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfLFQPb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 11:15:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35677 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726271AbfLFQPa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575648928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlNjqVisVRXGyh1DPQ46MLWpZqiMCY26U11khUWf2Fs=;
        b=HtT7XOIFeuopFHOvwdDD0GY9TvAEHyEJQCBmwaolzfTFLcmAlz739Lc+TmdbE3xDrnTVaa
        SO9OBnI2J4dceuUcdis2lWIAc8Qlm1wIFo7m6xl5WgVZo2OF78RKK+isChiDClRxn6qOJQ
        WCWNzwEKW0HVz4/3FGNYAquLOn7KREA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-Q2oiUNQ7NRmHWiUSN9BOHA-1; Fri, 06 Dec 2019 11:15:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79D168017DF;
        Fri,  6 Dec 2019 16:15:24 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E6D45C6DC;
        Fri,  6 Dec 2019 16:15:23 +0000 (UTC)
Date:   Sat, 7 Dec 2019 00:23:33 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     ltp@lists.linux.it, linux-fsdevel@vger.kernel.org
Subject: Re: [LTP] [PATCH] syscalls/newmount: new test case for new mount API
Message-ID: <20191206162332.GH4601@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
        linux-fsdevel@vger.kernel.org
References: <20191128173532.6468-1-zlang@redhat.com>
 <20191203130339.GF2844@rei>
MIME-Version: 1.0
In-Reply-To: <20191203130339.GF2844@rei>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Q2oiUNQ7NRmHWiUSN9BOHA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 03, 2019 at 02:03:39PM +0100, Cyril Hrubis wrote:
> Hi!
> > +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> > diff --git a/testcases/kernel/syscalls/newmount/newmount01.c b/testcase=
s/kernel/syscalls/newmount/newmount01.c
> > new file mode 100644
> > index 000000000..35e355506
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/newmount/newmount01.c
> > @@ -0,0 +1,150 @@
> > +/*
> > + * Copyright (C) 2019 Red Hat, Inc.  All rights reserved.
> > + * Author: Zorro Lang <zlang@redhat.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms of version 2 of the GNU General Public License as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it would be useful, bu=
t
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> > + *
> > + * You should have received a copy of the GNU General Public License a=
long
> > + * with this program; if not, write the Free Software Foundation, Inc.=
,
> > + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> > + *
> > + */
> > +
> > +/*
> > + *  DESCRIPTION
> > + *=09Use new mount API (fsopen, fsconfig, fsmount, move_mount) to moun=
t
> > + *=09a filesystem.
> > + */
> > +
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <sys/prctl.h>
> > +#include <sys/wait.h>
> > +#include <sys/mount.h>
> > +
> > +#include "tst_test.h"
> > +#include "tst_safe_macros.h"
> > +#include "lapi/newmount.h"
> > +
> > +#define LINELENGTH 256
> > +#define MNTPOINT "newmount_point"
> > +static int sfd, mfd;
> > +static int mount_flag =3D 0;
> > +
> > +static int ismount(char *mntpoint)
> > +{
> > +=09int ret =3D 0;
> > +=09FILE *file;
> > +=09char line[LINELENGTH];
> > +
> > +=09file =3D fopen("/proc/mounts", "r");
> > +=09if (file =3D=3D NULL)
> > +=09=09tst_brk(TFAIL | TTERRNO, "Open /proc/mounts failed");
> > +
> > +=09while (fgets(line, LINELENGTH, file) !=3D NULL) {
> > +=09=09if (strstr(line, mntpoint) !=3D NULL) {
> > +=09=09=09ret =3D 1;
> > +=09=09=09break;
> > +=09=09}
> > +=09}
> > +=09fclose(file);
> > +=09return ret;
> > +}
>=20
> Hmm, this is very similar to file_lines_scanf(), maybe we need a library
> function that would iterate over file lines to call a callback on each
> of them as well. I will think about this.
>=20
> > +static void setup(void)
> > +{
> > +=09SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
>=20
> Why aren't we just setting .format_device in the test structure?
>=20
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +=09if (mount_flag =3D=3D 1) {
> > +=09=09TEST(tst_umount(MNTPOINT));
> > +=09=09if (TST_RET !=3D 0)
> > +=09=09=09tst_brk(TBROK | TTERRNO, "umount failed");
>=20
> The library already produces TWARN if we fail to umount the device, so I
> would say that there is no need to TBROK here, the TBROK will be
> converted to TWARN anyways since it's in the cleanup...
>=20
> > +=09}
> > +}
> > +
> > +
> > +static void test_newmount(void)
> > +{
> > +=09TEST(fsopen(tst_device->fs_type, FSOPEN_CLOEXEC));
> > +=09if (TST_RET < 0) {
> > +=09=09tst_brk(TFAIL | TTERRNO,
> > +=09=09        "fsopen %s", tst_device->fs_type);
> > +=09} else {
>=20
> There is no need for else branches after tst_brk(), the test will exit
> if we reach the tst_brk().

Sorry I can't be 100% sure what you mean at here. Do you mean as this:
--
TEST(fsopen(tst_device->fs_type, FSOPEN_CLOEXEC));
if (TST_RET < 0) {
=09tst_brk(TFAIL | TTERRNO,
=09=09"fsopen %s", tst_device->fs_type);
}
sfd =3D TST_RET;
tst_res(TPASS, "fsopen %s", tst_device->fs_type);
--

>=20
> > +=09=09sfd =3D TST_RET;
> > +=09=09tst_res(TPASS,
> > +=09=09=09"fsopen %s", tst_device->fs_type);
> > +=09}
> > +
> > +=09TEST(fsconfig(sfd, FSCONFIG_SET_STRING, "source", tst_device->dev, =
0));
> > +=09if (TST_RET < 0) {
> > +=09=09tst_brk(TFAIL | TTERRNO,
> > +=09=09        "fsconfig set source to %s", tst_device->dev);
> > +=09} else {
>=20
> Here as well.
>=20
> > +=09=09tst_res(TPASS,
> > +=09=09=09"fsconfig set source to %s", tst_device->dev);
> > +=09}
> > +
> > +=09TEST(fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
> > +=09if (TST_RET < 0) {
> > +=09=09tst_brk(TFAIL | TTERRNO,
> > +=09=09        "fsconfig create superblock");
>=20
> And here.
>=20
> > +=09} else {
> > +=09=09tst_res(TPASS,
> > +=09=09=09"fsconfig create superblock");
> > +=09}
> > +
> > +=09TEST(fsmount(sfd, FSMOUNT_CLOEXEC, 0));
> > +=09if (TST_RET < 0) {
> > +=09=09tst_brk(TFAIL | TTERRNO, "fsmount");
> > +=09} else {
>=20
> And here.
>=20
> > +=09=09mfd =3D TST_RET;
> > +=09=09tst_res(TPASS, "fsmount");
> > +=09=09SAFE_CLOSE(sfd);
> > +=09}
> > +
> > +=09TEST(move_mount(mfd, "", AT_FDCWD, MNTPOINT, MOVE_MOUNT_F_EMPTY_PAT=
H));
> > +=09if (TST_RET < 0) {
> > +=09=09tst_brk(TFAIL | TTERRNO, "move_mount attach to mount point");
> > +=09} else {
>=20
> And here.
>=20
> > +=09=09tst_res(TPASS, "move_mount attach to mount point");
> > +=09=09mount_flag =3D 1;
> > +=09=09if (ismount(MNTPOINT))
> > +=09=09=09tst_res(TPASS, "new mount works");
> > +=09=09else
> > +=09=09=09tst_res(TFAIL, "new mount fails");
> > +=09}
> > +=09SAFE_CLOSE(mfd);
>=20
> We have to umount the device here, otherwise it would be mounted for
> each test iteration with -i.

OK, should I keep the 'umount' operation in cleanup() too?

Thanks,
Zorro

>=20
> > +}
> > +
> > +struct test_cases {
> > +=09void (*tfunc)(void);
> > +} tcases[] =3D {
> > +=09{&test_newmount},
> > +};
>=20
> Unless you plan to add more tests here, there is no point in declaring
> the structure with function pointers.
>=20
> > +static void run(unsigned int i)
> > +{
> > +=09tcases[i].tfunc();
> > +}
> > +
> > +static struct tst_test test =3D {
> > +=09.test=09=09=3D run,
> > +=09.tcnt=09=09=3D ARRAY_SIZE(tcases),
> > +=09.setup=09=09=3D setup,
> > +=09.cleanup=09=3D cleanup,
> > +=09.needs_root=09=3D 1,
> > +=09.mntpoint=09=3D MNTPOINT,
> > +=09.needs_device=09=3D 1,
> > +};
>=20
> Otherwise it looks good.
>=20
> --=20
> Cyril Hrubis
> chrubis@suse.cz
>=20


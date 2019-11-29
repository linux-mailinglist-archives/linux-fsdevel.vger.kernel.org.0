Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F00010D0B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2019 04:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfK2DkJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 22:40:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44139 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726773AbfK2DkJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 22:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574998807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/d6tuiBJ3b12PVCKr9K7EHkZtjL8t4Ip6HwrxaUPIpk=;
        b=ebkWYDRkwcDEbHaNwAZo+7IKtmnWE8OQCH2hXt9RDYXCm+N+r4HfQJ20iUu9zQ8uWcoXWg
        iHxkCVrm2w0FSE1TI2UZNxj9eVObXvcpiV/DCkCh9mpBmoQwmCTlVQonfK19OqPqmcCFp/
        3+0X6G4Gnf9zLmMd0zDlwCyix4+Fpxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-8GnzunOeOPGP-Q3DWm9r-A-1; Thu, 28 Nov 2019 22:40:04 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E617E80183D;
        Fri, 29 Nov 2019 03:40:02 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01912600F8;
        Fri, 29 Nov 2019 03:40:01 +0000 (UTC)
Date:   Fri, 29 Nov 2019 11:48:02 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] syscalls/newmount: new test case for new mount API
Message-ID: <20191129034802.GE4601@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
        linux-fsdevel@vger.kernel.org
References: <20191128173532.6468-1-zlang@redhat.com>
 <20191128191442.GB5202@dell5510>
MIME-Version: 1.0
In-Reply-To: <20191128191442.GB5202@dell5510>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 8GnzunOeOPGP-Q3DWm9r-A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 28, 2019 at 08:14:42PM +0100, Petr Vorel wrote:
> Hi Zorro,
>=20
> > Linux supports new mount syscalls from 5.2, so add new test cases
> > to cover these new API. This newmount01 case make sure new API -
> > fsopen(), fsconfig(), fsmount() and move_mount() can mount a
> > filesystem, then can be unmounted.
> Thanks for writing test for recently added kernel functionality.
> This is important.
> Test itself looks ok to me.
> There are few code style differences (note below), but that's not importa=
nt.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>=20
> BTW I thought it'd be nice to use more filesystems via .all_filesystems =
=3D 1 [1]
> but at least it breaks nfs. And IMHO we don't have blacklist support for
> .all_filesystems.

I(or with my colleagues) would like to add more filesystem specified test l=
ater,
to make sure filesystem specified mount options still works well with new m=
ount
syscalls.

>=20
> >  configure.ac                                  |   4 +
> >  include/lapi/newmount.h                       | 106 +++++++++++++
> >  include/lapi/syscalls/aarch64.in              |   4 +
> >  include/lapi/syscalls/powerpc64.in            |   4 +
> >  include/lapi/syscalls/s390x.in                |   4 +
> >  include/lapi/syscalls/x86_64.in               |   4 +
> In final version we'd want to add syscall numbers for all archs.

Yeah, I tried to find a .in file for all archs, but didn't find, so had to
add these __NR_ definition separately.

>=20
> ...
> > +++ b/include/lapi/newmount.h
> > @@ -0,0 +1,106 @@
> > +/*
> > + * Copyright (C) 2019 Red Hat, Inc.  All rights reserved.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation; either version 2 of
> > + * the License, or (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it would be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write the Free Software Foundation=
,
> > + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > + */
> Use SPDX license identifier instead of verbose GPL everywhere (including =
headers
> and makefiles; we don't want any HISTORY: text, but feel free to add Auth=
or:
> your name).

Wow, sorry I don't learn about the license things so much, just copy from o=
ther file:)
I'll search how to use the SPDX license.

> > +
> > +#ifndef __NEWMOUNT_H__
> > +#define __NEWMOUNT_H__
> Double underscore at the beginning and end (__FOO_H__) is IMHO reserved f=
or library
> (use NEWMOUNT_H__).

Sure, I'll change it to a proper one.

> ...
>=20
> > diff --git a/m4/ltp-fsconfig.m4 b/m4/ltp-fsconfig.m4
> > new file mode 100644
> > index 000000000..397027f1b
> > --- /dev/null
> > +++ b/m4/ltp-fsconfig.m4
> > @@ -0,0 +1,7 @@
> > +dnl SPDX-License-Identifier: GPL-2.0-or-later
> > +dnl Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
> > +
> > +AC_DEFUN([LTP_CHECK_FSCONFIG],[
> > +AC_CHECK_FUNCS(fsconfig,,)
> > +AC_CHECK_HEADER(sys/mount.h,,,)
> > +])
> > diff --git a/m4/ltp-fsmount.m4 b/m4/ltp-fsmount.m4
> > new file mode 100644
> > index 000000000..ee32ef713
> > --- /dev/null
> > +++ b/m4/ltp-fsmount.m4
> > @@ -0,0 +1,7 @@
> > +dnl SPDX-License-Identifier: GPL-2.0-or-later
> > +dnl Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
> > +
> > +AC_DEFUN([LTP_CHECK_FSMOUNT],[
> > +AC_CHECK_FUNCS(fsmount,,)
> > +AC_CHECK_HEADER(sys/mount.h,,,)
> > +])
> > diff --git a/m4/ltp-fsopen.m4 b/m4/ltp-fsopen.m4
> > new file mode 100644
> > index 000000000..6e23d437d
> > --- /dev/null
> > +++ b/m4/ltp-fsopen.m4
> > @@ -0,0 +1,7 @@
> > +dnl SPDX-License-Identifier: GPL-2.0-or-later
> > +dnl Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
> > +
> > +AC_DEFUN([LTP_CHECK_FSOPEN],[
> > +AC_CHECK_FUNCS(fsopen,,)
> > +AC_CHECK_HEADER(sys/mount.h,,,)
> > +])
> > diff --git a/m4/ltp-move_mount.m4 b/m4/ltp-move_mount.m4
> > new file mode 100644
> > index 000000000..d6bfd82e9
> > --- /dev/null
> > +++ b/m4/ltp-move_mount.m4
> > @@ -0,0 +1,7 @@
> > +dnl SPDX-License-Identifier: GPL-2.0-or-later
> > +dnl Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
> > +
> > +AC_DEFUN([LTP_CHECK_MOVE_MOUNT],[
> > +AC_CHECK_FUNCS(move_mount,,)
> > +AC_CHECK_HEADER(sys/mount.h,,,)
> > +])
> As all of these require <sys/mount.h>, I'd add them into single file
> m4/ltp-newmount.m4.

OK, I'll do that.

> BTW it might take a time before it get into <sys/mount.h>, they're now ju=
st <linux/mount.h> (even in musl, which is unlike glic fast with porting ne=
w things).

Yes, there're still in kernel-headers, glibc doesn't have patch for that. M=
aybe
they're waiting. I don't know if there'll be more newmount syscalls (e.g fs=
info
or something else), or fsdevel might would like to disconnect umount() in t=
he
feature:)

>=20
> ...
> > +++ b/testcases/kernel/syscalls/newmount/Makefile
> ...
> > +
> > +top_srcdir=09=09?=3D ../../../..
> > +
> > +include $(top_srcdir)/include/mk/testcases.mk
> > +
> > +CFLAGS=09=09=09+=3D -D_GNU_SOURCE
> Is _GNU_SOURCE needed?

Hmm... I'm not sure, just copy this Makefile from syscalls/mount/Makefile ;=
)
I think the new mount API might not be POSIX defined?

Thanks for your review so much, I'll send V2 patch soon.

Thanks,
Zorro

> > +
> > +include $(top_srcdir)/include/mk/generic_leaf_target.mk
>=20
> Kind regards,
> Petr
>=20
> [1] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guideline=
s#2215-testing-with-a-block-device
>=20


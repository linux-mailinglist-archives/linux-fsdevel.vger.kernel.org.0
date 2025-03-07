Return-Path: <linux-fsdevel+bounces-43399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D54A55D9A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 03:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0F83B4A0B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 02:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE883183CA6;
	Fri,  7 Mar 2025 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G3gPeqyy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81747168B1;
	Fri,  7 Mar 2025 02:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741314016; cv=none; b=afJrKizEQuUyq8HobQ0RIqluEJV1A4QWQOmc+qzYJF2CIInfUjBQYd5zmlABA3OiSZ2tFQ5tOztXYPbEUwodPXtBWatltwLNfN1puVeXzah8jG15gxwFLq7NIYW1tvrXUqmNbSB15psLhgoehkWHkUVubVDQwgvLJ5DeD8IlK3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741314016; c=relaxed/simple;
	bh=XgoaPaZLRFcDNmldrJZnRMu/ZHa9uIzniEYE0qAT29k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Gd86SprNXFN3qDoXGFHMRTyOFy81FmH3MCgasDYehDAsPUAqFZWOsLzRZZAKfV33djVd9EFjaHGCMae2P0VfLLXrSYmYp3tduYDGv7UX+ycpg03CjidXisYVO5X1egvOyh3lKHFK6MqgRfKYQqAubRxm8q4u9kEGvLCJ6XEpxRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G3gPeqyy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=MI9+ZmbRyN8XMo/CxM02plIhNjOeHxU5pdUvVUUf+v8=; b=G3gPeqyyG4G1SQ6aGiFsK38WIo
	XNW/6Ot2orS6FRjfNdySmr6Y/ws8PgrDtHrV5/BvPtyi3UUozUJJ38q4WEw9OvaPyOF2U+X7QZJ0d
	cl6fwREnWyiW/EVurz9Y7vi27xw7rjU1A+iypGqwCzgFwwkxaAl/w6uHe0geNKry2Tjo7DUpDRviC
	RoyfTjd1VbrLdM+VQ3j4YzWp22UeiKcaIF8f8Mn7L7crI83TACZxjKA8kBjU2amv/rESVFGGJWLpy
	u/euK5vWQYbYhA8855NCkZLmrFSVJ2CEa001u5UAEaaNl7qvW/GoGrelqnCGcPe7tyzeSAbiTwYl2
	6ttXf01w==;
Received: from [129.95.238.77] (helo=[127.0.0.1])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tqNJj-0000000Bey7-1Eol;
	Fri, 07 Mar 2025 02:20:03 +0000
Date: Thu, 06 Mar 2025 18:19:58 -0800
From: Randy Dunlap <rdunlap@infradead.org>
To: Pratyush Yadav <ptyadav@amazon.de>, linux-kernel@vger.kernel.org
CC: Jonathan Corbet <corbet@lwn.net>, Eric Biederman <ebiederm@xmission.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Hugh Dickins <hughd@google.com>, Alexander Graf <graf@amazon.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Woodhouse <dwmw2@infradead.org>, James Gowans <jgowans@amazon.com>,
 Mike Rapoport <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Pasha Tatashin <tatashin@google.com>,
 Anthony Yznaga <anthony.yznaga@oracle.com>,
 Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 Wei Yang <richard.weiyang@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH 2/5] misc: add documentation for FDBox
User-Agent: K-9 Mail for Android
In-Reply-To: <20250307005830.65293-3-ptyadav@amazon.de>
References: <20250307005830.65293-1-ptyadav@amazon.de> <20250307005830.65293-3-ptyadav@amazon.de>
Message-ID: <E41DA7C8-635C-4E6E-A2CA-5D657526BE85@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 6, 2025 4:57:36 PM PST, Pratyush Yadav <ptyadav@amazon=2Ede> wrote=
:
>With FDBox in place, add documentation that describes what it is and how
>it is used, along with its UAPI and in-kernel API=2E
>
>Since the document refers to KHO, add a reference tag in kho/index=2Erst=
=2E
>
>Signed-off-by: Pratyush Yadav <ptyadav@amazon=2Ede>
>---
> Documentation/filesystems/locking=2Erst |  21 +++
> Documentation/kho/fdbox=2Erst           | 224 ++++++++++++++++++++++++++
> Documentation/kho/index=2Erst           |   3 +
> MAINTAINERS                           |   1 +
> 4 files changed, 249 insertions(+)
> create mode 100644 Documentation/kho/fdbox=2Erst
>
>diff --git a/Documentation/filesystems/locking=2Erst b/Documentation/file=
systems/locking=2Erst
>index d20a32b77b60f=2E=2E5526833faf79a 100644
>--- a/Documentation/filesystems/locking=2Erst
>+++ b/Documentation/filesystems/locking=2Erst
>@@ -607,6 +607,27 @@ used=2E To block changes to file contents via a memo=
ry mapping during the
> operation, the filesystem must take mapping->invalidate_lock to coordina=
te
> with ->page_mkwrite=2E
>=20
>+fdbox_file_ops
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+prototypes::
>+
>+	int (*kho_write)(struct fdbox_fd *box_fd, void *fdt);
>+	int (*seal)(struct fdbox *box);
>+	int (*unseal)(struct fdbox *box);
>+
>+
>+locking rules:
>+	all may block
>+
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+ops		i_rwsem(box_fd->file->f_inode)
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+kho_write:	exclusive
>+seal:		no
>+unseal:		no
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
> dquot_operations
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>diff --git a/Documentation/kho/fdbox=2Erst b/Documentation/kho/fdbox=2Ers=
t
>new file mode 100644
>index 0000000000000=2E=2E44a3f5cdf1efb
>--- /dev/null
>+++ b/Documentation/kho/fdbox=2Erst
>@@ -0,0 +1,224 @@
>+=2E=2E SPDX-License-Identifier: GPL-2=2E0-or-later
>+
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>+File Descriptor Box (FDBox)
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>+
>+:Author: Pratyush Yadav
>+
>+Introduction
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+The File Descriptor Box (FDBox) is a mechanism for userspace to name fil=
e
>+descriptors and give them over to the kernel to hold=2E They can later b=
e
>+retrieved by passing in the same name=2E
>+
>+The primary purpose of FDBox is to be used with :ref:`kho`=2E There are =
many kinds

    many kinds of=20

>+anonymous file descriptors in the kernel like memfd, guest_memfd, iommuf=
d, etc=2E

   etc=2E,

>+that would be useful to be preserved using KHO=2E To be able to do that,=
 there
>+needs to be a mechanism to label FDs that allows userspace to set the la=
bel
>+before doing KHO and to use the label to map them back after KHO=2E FDBo=
x achieves
>+that purpose by exposing a miscdevice which exposes ioctls to label and =
transfer
>+FDs between the kernel and userspace=2E FDBox is not intended to work wi=
th any
>+generic file descriptor=2E Support for each kind of FDs must be explicit=
ly
>+enabled=2E
>+
>+FDBox can be enabled by setting the ``CONFIG_FDBOX`` option to ``y``=2E =
While the
>+primary purpose of FDBox is to be used with KHO, it does not explicitly =
require
>+``CONFIG_KEXEC_HANDOVER``, since it can be used without KHO, simply as a=
 way to
>+preserve or transfer FDs when userspace exits=2E
>+
>+Concepts
>+=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+Box
>+---
>+
>+The box is a container for FDs=2E Boxes are identified by their name, wh=
ich must
>+be unique=2E Userspace can put FDs in the box using the ``FDBOX_PUT_FD``
>+operation, and take them out of the box using the ``FDBOX_GET_FD`` opera=
tion=2E

Is this ioctl range documented is ioctl-number=2Erst?
I didn't notice a patch for that=2E

>+Once all the required FDs are put into the box, it can be sealed to make=
 it
>+ready for shipping=2E This can be done by the ``FDBOX_SEAL`` operation=
=2E The seal
>+operation notifies each FD in the box=2E If any of the FDs have a depend=
ency on
>+another, this gives them an opportunity to ensure all dependencies are m=
et, or
>+fail the seal if not=2E Once a box is sealed, no FDs can be added or rem=
oved from
>+the box until it is unsealed=2E Only sealed boxes are transported to a n=
ew kernel

What if KHO is not being used?

>+via KHO=2E The box can be unsealed by the ``FDBOX_UNSEAL`` operation=2E =
This is the
>+opposite of seal=2E It also notifies each FD in the box to ensure all de=
pendencies
>+are met=2E This can be useful in case some FDs fail to be restored after=
 KHO=2E
>+
>+Box FD
>+------

I can't tell in my email font, but is each underlinoat least as long as th=
e title above it?

>+
>+The Box FD is a FD that is currently in a box=2E It is identified by its=
 name,
>+which must be unique in the box it belongs to=2E The Box FD is created w=
hen a FD
>+is put into a box by using the ``FDBOX_PUT_FD`` operation=2E This operat=
ion
>+removes the FD from the calling task=2E The FD can be restored by passin=
g the
>+unique name to the ``FDBOX_GET_FD`` operation=2E
>+
>+FDBox control device
>+--------------------
>+
>+This is the ``/dev/fdbox/fdbox`` device=2E A box can be created using th=
e
>+``FDBOX_CREATE_BOX`` operation on the device=2E A box can be removed usi=
ng the
>+``FDBOX_DELETE_BOX`` operation=2E
>+
>+UAPI
>+=3D=3D=3D=3D
>+
>+FDBOX_NAME_LEN
>+--------------
>+
>+=2E=2E code-block:: c
>+
>+    #define FDBOX_NAME_LEN			256
>+
>+Maximum length of the name of a Box or Box FD=2E
>+
>+Ioctls on /dev/fdbox/fdbox
>+--------------------------
>+
>+FDBOX_CREATE_BOX
>+~~~~~~~~~~~~~~~~
>+
>+=2E=2E code-block:: c
>+
>+    #define FDBOX_CREATE_BOX	_IO(FDBOX_TYPE, FDBOX_BASE + 0)
>+    struct fdbox_create_box {
>+    	__u64 flags;
>+    	__u8 name[FDBOX_NAME_LEN];
>+    };
>+
>+Create a box=2E
>+
>+After this returns, the box is available at ``/dev/fdbox/<name>``=2E
>+
>+``name``
>+    The name of the box to be created=2E Must be unique=2E
>+
>+``flags``
>+    Flags to the operation=2E Currently, no flags are defined=2E
>+
>+Returns:
>+    0 on success, -1 on error, with errno set=2E
>+
>+FDBOX_DELETE_BOX
>+~~~~~~~~~~~~~~~~
>+
>+=2E=2E code-block:: c
>+
>+    #define FDBOX_DELETE_BOX	_IO(FDBOX_TYPE, FDBOX_BASE + 1)
>+    struct fdbox_delete_box {
>+    	__u64 flags;
>+    	__u8 name[FDBOX_NAME_LEN];
>+    };
>+
>+Delete a box=2E
>+
>+After this returns, the box is no longer available at ``/dev/fdbox/<name=
>``=2E
>+
>+``name``
>+    The name of the box to be deleted=2E
>+
>+``flags``
>+    Flags to the operation=2E Currently, no flags are defined=2E
>+
>+Returns:
>+    0 on success, -1 on error, with errno set=2E
>+
>+Ioctls on /dev/fdbox/<boxname>
>+------------------------------
>+
>+These must be performed on the ``/dev/fdbox/<boxname>`` device=2E
>+
>+FDBX_PUT_FD
>+~~~~~~~~~~~
>+
>+=2E=2E code-block:: c
>+
>+    #define FDBOX_PUT_FD	_IO(FDBOX_TYPE, FDBOX_BASE + 2)
>+    struct fdbox_put_fd {
>+    	__u64 flags;
>+    	__u32 fd;
>+    	__u32 pad;
>+    	__u8 name[FDBOX_NAME_LEN];
>+    };
>+
>+
>+Put FD into the box=2E
>+
>+After this returns, ``fd`` is removed from the task and can no longer be=
 used by
>+it=2E
>+
>+``name``
>+    The name of the FD=2E
>+
>+``fd``
>+    The file descriptor number to be
>+
>+``flags``
>+    Flags to the operation=2E Currently, no flags are defined=2E
>+
>+Returns:
>+    0 on success, -1 on error, with errno set=2E
>+
>+FDBX_GET_FD
>+~~~~~~~~~~~
>+
>+=2E=2E code-block:: c
>+
>+    #define FDBOX_GET_FD	_IO(FDBOX_TYPE, FDBOX_BASE + 3)
>+    struct fdbox_get_fd {
>+    	__u64 flags;
>+    	__u8 name[FDBOX_NAME_LEN];
>+    };
>+
>+Get an FD from the box=2E
>+
>+After this returns, the FD identified by ``name`` is mapped into the tas=
k and is
>+available for use=2E
>+
>+``name``
>+    The name of the FD to get=2E
>+
>+``flags``
>+    Flags to the operation=2E Currently, no flags are defined=2E
>+
>+Returns:
>+    FD number on success, -1 on error with errno set=2E
>+
>+FDBOX_SEAL
>+~~~~~~~~~~
>+
>+=2E=2E code-block:: c
>+
>+    #define FDBOX_SEAL	_IO(FDBOX_TYPE, FDBOX_BASE + 4)
>+
>+Seal the box=2E
>+
>+Gives the kernel an opportunity to ensure all dependencies are met in th=
e box=2E
>+After this returns, the box is sealed and FDs can no longer be added or =
removed
>+from it=2E A box must be sealed for it to be transported across KHO=2E
>+
>+Returns:
>+    0 on success, -1 on error with errno set=2E
>+
>+FDBOX_UNSEAL
>+~~~~~~~~~~~~
>+
>+=2E=2E code-block:: c
>+
>+    #define FDBOX_UNSEAL	_IO(FDBOX_TYPE, FDBOX_BASE + 5)
>+
>+Unseal the box=2E
>+
>+Gives the kernel an opportunity to ensure all dependencies are met in th=
e box,
>+and in case of KHO, no FDs have been lost in transit=2E
>+
>+Returns:
>+    0 on success, -1 on error with errno set=2E
>+
>+Kernel functions and structures
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>+
>+=2E=2E kernel-doc:: include/linux/fdbox=2Eh
>diff --git a/Documentation/kho/index=2Erst b/Documentation/kho/index=2Ers=
t
>index 5e7eeeca8520f=2E=2E051513b956075 100644
>--- a/Documentation/kho/index=2Erst
>+++ b/Documentation/kho/index=2Erst
>@@ -1,5 +1,7 @@
> =2E=2E SPDX-License-Identifier: GPL-2=2E0-or-later
>=20
>+=2E=2E _kho:
>+
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Kexec Handover Subsystem
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>@@ -9,6 +11,7 @@ Kexec Handover Subsystem
>=20
>    concepts
>    usage
>+   fdbox
>=20
> =2E=2E only::  subproject and html
>=20
>diff --git a/MAINTAINERS b/MAINTAINERS
>index d329d3e5514c5=2E=2E135427582e60f 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -8866,6 +8866,7 @@ FDBOX
> M:	Pratyush Yadav <pratyush@kernel=2Eorg>
> L:	linux-fsdevel@vger=2Ekernel=2Eorg
> S:	Maintained
>+F:	Documentation/kho/fdbox=2Erst
> F:	drivers/misc/fdbox=2Ec
> F:	include/linux/fdbox=2Eh
> F:	include/uapi/linux/fdbox=2Eh


~Randy


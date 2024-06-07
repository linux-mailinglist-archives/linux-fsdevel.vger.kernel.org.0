Return-Path: <linux-fsdevel+bounces-21138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7858FF9BC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 03:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE32282C97
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 01:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DA111CBD;
	Fri,  7 Jun 2024 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gfWnCPgO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA1F10A24
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725005; cv=none; b=rRdrvuGGokkA1NOQmC3UikHNp75qhuRoF7T/y1f4HclY2R2Wfmp+NjYcrm68NgaEDQ9Pfxp6Q1joCNRY2gudYpPH8fWDLCQlcz4gqcGZT5gYTYAfRzaErExZwi8V8rC6RhfYqb98RCQWpZcyvee/5lic/zZvEP+WzTgCPXG2Dnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725005; c=relaxed/simple;
	bh=yHu4MIT8ArMtnYCHIPL7t66IA1H1cKrrnc6xNtyy9/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kc+Hefej4qJCVilNYDuPIclmNGQrI7I+FI90NNmGicFYx4UJU01gX+fwx01cb0N0NGrmoq2BxWMj9qs8/xN8q6hOA1uF4EGgPi9LX5+CbxvaMEXcNgHTxJgKLXIuLSefMVhGK5Kosc7fVmlbmHoh6N1yf44d2er4t+/CsI5OFoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gfWnCPgO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717725002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkAPm8DbDW67h9USLeOSVGxamhmKQHZK3DhyTSz3PxI=;
	b=gfWnCPgOwwogQL2iOqB3tkjOJFanA0hxU1ayhlhS/wRJvuzHlXC6lKNNE0MeGnM7TxkeQM
	t8xwRj9a9zSY9dbB7Fxe0huJcjy5DR9PE2imANtIv7es/WfiOz1S/1JieiThftbfAuuXjo
	zCzh0oAhv/5vm3lxMtvVeHdGIvRXUAw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-91H9ln_-Nae7KsgSWjADwQ-1; Thu, 06 Jun 2024 21:49:58 -0400
X-MC-Unique: 91H9ln_-Nae7KsgSWjADwQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBF6685A588;
	Fri,  7 Jun 2024 01:49:57 +0000 (UTC)
Received: from localhost (unknown [10.39.192.6])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9F461408A402;
	Fri,  7 Jun 2024 01:49:56 +0000 (UTC)
Date: Thu, 6 Jun 2024 21:49:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	Bernd Schubert <bernd.schubert@fastmail.fm>, linux-mm@kvack.org,
	Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
	kwolf@redhat.com
Subject: Re: [PATCH 0/5] sys_ringbuffer
Message-ID: <20240607014954.GA219708@fedora.redhat.com>
References: <20240603003306.2030491-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j/CfATJu0W0vRWqP"
Content-Disposition: inline
In-Reply-To: <20240603003306.2030491-1-kent.overstreet@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


--j/CfATJu0W0vRWqP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 02, 2024 at 08:32:57PM -0400, Kent Overstreet wrote:
> New syscall for mapping generic ringbuffers for arbitary (supported)
> file descriptors.
>=20
> Ringbuffers can be created either when requested or at file open time,
> and can be mapped into multiple address spaces (naturally, since files
> can be shared as well).
>=20
> Initial motivation is for fuse, but I plan on adding support to pipes
> and possibly sockets as well - pipes are a particularly interesting use
> case, because if both the sender and receiver of a pipe opt in to the
> new ringbuffer interface, we can make them the _same_ ringbuffer for
> true zero copy IO, while being backwards compatible with existing pipes.

Hi Kent,
I recently came across a similar use case where the ability to "upgrade"
an fd into a more efficient interface would be useful like in this pipe
scenario you are describing.

My use case is when you have a block device using the ublk driver. ublk
lets userspace servers implement block devices. ublk is great when
compatibility is required with applications that expect block device
fds, but when an application is willing to implement a shared memory
interface to communicate directly with the ublk server then going
through a block device is inefficient.

In my case the application is QEMU, where the virtual machine runs a
virtio-blk driver that could talk directly to the ublk server via
vhost-user-blk. vhost-user-blk is a protocol that allows the virtual
machine to talk directly to the ublk server via shared memory without
going through QEMU or the host kernel block layer.

QEMU would need a way to upgrade from a ublk block device file to a
vhost-user socket. Just like in your pipe example, this approach relies
on being able to go from a "compatibility" fd to a more efficient
interface gracefully when both sides support this feature.

The generic ringbuffer approach in this series would not work for
the vhost-user protocol because the client must be able to provide its
own memory and file descriptor passing is needed in general. The
protocol spec is here:
https://gitlab.com/qemu-project/qemu/-/blob/master/docs/interop/vhost-user.=
rst

A different way to approach the fd upgrading problem is to treat this as
an AF_UNIX connectivity feature rather than a new ring buffer API.
Imagine adding a new address type to AF_UNIX for looking up connections
in a struct file (e.g. the pipe fd) instead of on the file system (or
the other AF_UNIX address types).

The first program creates the pipe and also an AF_UNIX socket. It calls
bind(2) on the socket with the sockaddr_un path
"/dev/self/fd/<fd>/<discriminator>" where fd is a pipe fd and
discriminator is a string like "ring-buffer" that describes the
service/protocol. The AF_UNIX kernel code parses this special path and
stores an association with the pipe file for future connect(2) calls.
The program listens on the AF_UNIX socket and then continues doing its
stuff.

The second program runs and inherits the pipe fd on stdin. It creates an
AF_UNIX socket and attempts to connect(2) to
"/dev/self/fd/0/ring-buffer". The AF_UNIX kernel code parses this
special path and establishes a connection between the connecting and
listening sockets inside the pipe fd's struct file. If connect(2) fails
then the second program knows that this is an ordinary pipe that does
not support upgrading to ring buffer operation.

Now the AF_UNIX socket can be used to pass shared memory for the ring
buffer and futexes. This AF_UNIX approach also works for my ublk block
device to vhost-user-blk upgrade use case. It does not require a new
ring buffer API but instead involves extending AF_UNIX.

You have more use cases than just the pipe scenario, maybe my half-baked
idea won't cover all of them, but I wanted to see what you think.

Stefan

> the ringbuffer_wait and ringbuffer_wakeup syscalls are probably going
> away in a future iteration, in favor of just using futexes.
>=20
> In my testing, reading/writing from the ringbuffer 16 bytes at a time is
> ~7x faster than using read/write syscalls - and I was testing with
> mitigations off, real world benefit will be even higher.
>=20
> Kent Overstreet (5):
>   darray: lift from bcachefs
>   darray: Fix darray_for_each_reverse() when darray is empty
>   fs: sys_ringbuffer
>   ringbuffer: Test device
>   ringbuffer: Userspace test helper
>=20
>  MAINTAINERS                             |   7 +
>  arch/x86/entry/syscalls/syscall_32.tbl  |   3 +
>  arch/x86/entry/syscalls/syscall_64.tbl  |   3 +
>  fs/Makefile                             |   2 +
>  fs/bcachefs/Makefile                    |   1 -
>  fs/bcachefs/btree_types.h               |   2 +-
>  fs/bcachefs/btree_update.c              |   2 +
>  fs/bcachefs/btree_write_buffer_types.h  |   2 +-
>  fs/bcachefs/fsck.c                      |   2 +-
>  fs/bcachefs/journal_io.h                |   2 +-
>  fs/bcachefs/journal_sb.c                |   2 +-
>  fs/bcachefs/sb-downgrade.c              |   3 +-
>  fs/bcachefs/sb-errors_types.h           |   2 +-
>  fs/bcachefs/sb-members.h                |   3 +-
>  fs/bcachefs/subvolume.h                 |   1 -
>  fs/bcachefs/subvolume_types.h           |   2 +-
>  fs/bcachefs/thread_with_file_types.h    |   2 +-
>  fs/bcachefs/util.h                      |  28 +-
>  fs/ringbuffer.c                         | 474 ++++++++++++++++++++++++
>  fs/ringbuffer_test.c                    | 209 +++++++++++
>  {fs/bcachefs =3D> include/linux}/darray.h |  61 +--
>  include/linux/darray_types.h            |  22 ++
>  include/linux/fs.h                      |   2 +
>  include/linux/mm_types.h                |   4 +
>  include/linux/ringbuffer_sys.h          |  18 +
>  include/uapi/linux/futex.h              |   1 +
>  include/uapi/linux/ringbuffer_sys.h     |  40 ++
>  init/Kconfig                            |   9 +
>  kernel/fork.c                           |   2 +
>  lib/Kconfig.debug                       |   5 +
>  lib/Makefile                            |   2 +-
>  {fs/bcachefs =3D> lib}/darray.c           |  12 +-
>  tools/ringbuffer/Makefile               |   3 +
>  tools/ringbuffer/ringbuffer-test.c      | 254 +++++++++++++
>  34 files changed, 1125 insertions(+), 62 deletions(-)
>  create mode 100644 fs/ringbuffer.c
>  create mode 100644 fs/ringbuffer_test.c
>  rename {fs/bcachefs =3D> include/linux}/darray.h (63%)
>  create mode 100644 include/linux/darray_types.h
>  create mode 100644 include/linux/ringbuffer_sys.h
>  create mode 100644 include/uapi/linux/ringbuffer_sys.h
>  rename {fs/bcachefs =3D> lib}/darray.c (56%)
>  create mode 100644 tools/ringbuffer/Makefile
>  create mode 100644 tools/ringbuffer/ringbuffer-test.c
>=20
> --=20
> 2.45.1
>=20

--j/CfATJu0W0vRWqP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZiZ0IACgkQnKSrs4Gr
c8jpagf7BxpNTX4pblcntzL0Y5rs9POU3DQY+Y6yg1MYsv0HdaYISgxeBqbwr4UG
L4MrIpCbkGUJN4L4DJr+qdfv94JjiaGw7ULUjHF9U8e5rhqTiGXC6aOZAbjnIa1e
OXHdQI/V35WkpEbynu7v//5H/be/dkw+6qy7wwyVupAsLm2Uk76QTl6ngvcoOaNv
Z2sc6qWEXaAKIyPrB1PZPMPX7kSKiZtrdCy2y4OhFSfjD3A2kQApkhPk80UP6Z9f
YftM/cNg154DPnItqD4vCH/PDGESy+ITBW9EEQ1PQz8Ydvi2ho31ZX43tSgCxppe
EzRiR6Ano16JtNGo4usvXl+13k+2AA==
=z2cS
-----END PGP SIGNATURE-----

--j/CfATJu0W0vRWqP--



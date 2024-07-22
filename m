Return-Path: <linux-fsdevel+bounces-24080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F83B9390DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 16:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0AEB1F21CA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 14:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060EA16DC39;
	Mon, 22 Jul 2024 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njlsPTOo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6873C125D6
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jul 2024 14:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659362; cv=none; b=HxXhZFPEaHQFNlWPKxgDlCgpGjiAPzLtm0OYW+lwgUuZowOgMYlw67rwzQ26ziy7cxCithtZ0SkxpeIYC393YpmKHt/NS63uXYBNpzvFzpd0VD5DZkAWanB/zlpbFzxxa5fE/NR5ZII9cyae4rJmo2eekVRJihdcMY15sCaqu2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659362; c=relaxed/simple;
	bh=GrJ1+cRcKWOr/iyBN8XueESFBJ8KXlFiznrgyTBRj9k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZwuasPH0k1SLYXV5nCuClnxUGhlyoGp3UXNhN5xVnbnFVXBlHXoXtbF/UGMS1o7EvysNzkOm25cjaWMMW5ws7+QyWHOQNyqyUAk69ME38k9FtZhrtJiEmEpaZQ22cXaEs7fpOEZfS3bQJP5in8IA8Q7ISkUn9ilPX+y0MSnzsYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njlsPTOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A69C116B1;
	Mon, 22 Jul 2024 14:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721659361;
	bh=GrJ1+cRcKWOr/iyBN8XueESFBJ8KXlFiznrgyTBRj9k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=njlsPTOoXuE2VILsIg7HnNeXDyMF6D4AQ4wQYyVnWRbAGQUZVdx2zdkKCO0HosIWv
	 Z6SGv8cWfSPI7z4w6UbF1xpk3lsJWG065zWsDlLsbpMZmglsWH+NJzRrgP1/a/ag8T
	 o5y5pVC0Kj5YLN3dLQkO/mC2ZGcZzriUCssp1FOOjXCyO+rgjt4hzx+HyZgAuGSEXe
	 c9bymbQWAc7Cw6vZbl1t9TGozeJsXCjGzs68oaqZb8HW7VW9P/7GqJE5iftlHr5Fih
	 9Xfj/FP+QwNEXhEhpVWm4vMNPewoX7TEayHuSuF2aMGGZGmE1Nt8UjIOOv/LCBQPQw
	 MvEdlpKhHq90w==
Message-ID: <9b0f44041794d2e0bc5c39263aba8b59441a8704.camel@kernel.org>
Subject: Re: [PATCH RFC 0/5] nsfs: iterate through mount namespaces
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Karel Zak <kzak@redhat.com>, 
 Stephane Graber <stgraber@stgraber.org>, Alexander Mikhalitsyn
 <alexander@mihalicyn.com>
Date: Mon, 22 Jul 2024 10:42:40 -0400
In-Reply-To: <20240719-work-mount-namespace-v1-0-834113cab0d2@kernel.org>
References: <20240719-work-mount-namespace-v1-0-834113cab0d2@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-19 at 13:41 +0200, Christian Brauner wrote:
> Hey,
>=20
> Recently, we added the ability to list mounts in other mount
> namespaces
> and the ability to retrieve namespace file descriptors without having
> to
> go through procfs by deriving them from pidfds.
>=20
> This extends nsfs in two ways:
>=20
> (1) Add the ability to retrieve information about a mount namespace
> via
> =C2=A0=C2=A0=C2=A0 NS_MNT_GET_INFO. This will return the mount namespace =
id and the
> =C2=A0=C2=A0=C2=A0 number of mounts currently in the mount namespace. The=
 number of
> =C2=A0=C2=A0=C2=A0 mounts can be used to size the buffer that needs to be=
 used for
> =C2=A0=C2=A0=C2=A0 listmount() and is in general useful without having to=
 actually
> =C2=A0=C2=A0=C2=A0 iterate through all the mounts.
>=20
> =C2=A0=C2=A0=C2=A0 The structure is extensible.
>=20
> (2) Add the ability to iterate through all mount namespaces over
> which
> =C2=A0=C2=A0=C2=A0 the caller holds privilege returning the file descript=
or for the
> =C2=A0=C2=A0=C2=A0 next or previous mount namespace.
>=20
> =C2=A0=C2=A0=C2=A0 To retrieve a mount namespace the caller must be privi=
leged wrt
> to
> =C2=A0=C2=A0=C2=A0 it's owning user namespace. This means that PID 1 on t=
he host can
> =C2=A0=C2=A0=C2=A0 list all mounts in all mount namespaces or that a cont=
ainer can
> list
> =C2=A0=C2=A0=C2=A0 all mounts of its nested containers.
>=20
> =C2=A0=C2=A0=C2=A0 Optionally pass a structure for NS_MNT_GET_INFO with
> =C2=A0=C2=A0=C2=A0 NS_MNT_GET_{PREV,NEXT} to retrieve information about t=
he mount
> =C2=A0=C2=A0=C2=A0 namespace in one go.
>=20
> (1) and (2) can be implemented for other namespace types easily.
>=20
> Together with recent api additions this means one can iterate through
> all mounts in all mount namespaces without ever touching procfs.
> Here's
> a sample program list_all_mounts_everywhere.c:
>=20
> =C2=A0 // SPDX-License-Identifier: GPL-2.0-or-later
>=20
> =C2=A0 #define _GNU_SOURCE
> =C2=A0 #include <asm/unistd.h>
> =C2=A0 #include <assert.h>
> =C2=A0 #include <errno.h>
> =C2=A0 #include <fcntl.h>
> =C2=A0 #include <getopt.h>
> =C2=A0 #include <linux/stat.h>
> =C2=A0 #include <sched.h>
> =C2=A0 #include <stddef.h>
> =C2=A0 #include <stdint.h>
> =C2=A0 #include <stdio.h>
> =C2=A0 #include <stdlib.h>
> =C2=A0 #include <string.h>
> =C2=A0 #include <sys/ioctl.h>
> =C2=A0 #include <sys/param.h>
> =C2=A0 #include <sys/pidfd.h>
> =C2=A0 #include <sys/stat.h>
> =C2=A0 #include <sys/statfs.h>
>=20
> =C2=A0 #define die_errno(format,
> ...)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0	do
> {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 \
> =C2=A0=C2=A0		fprintf(stderr, "%m | %s: %d: %s: " format "\n",
> __FILE__, \
> =C2=A0=C2=A0			__LINE__, __func__,
> ##__VA_ARGS__);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0		exit(EXIT_FAILURE);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0	} while (0)
>=20
> =C2=A0 /* Get the id for a mount namespace */
> =C2=A0 #define NS_GET_MNTNS_ID		_IO(0xb7, 0x5)
> =C2=A0 /* Get next mount namespace. */
>=20
> =C2=A0 struct mnt_ns_info {
> =C2=A0=C2=A0	__u32 size;
> =C2=A0=C2=A0	__u32 nr_mounts;
> =C2=A0=C2=A0	__u64 mnt_ns_id;
> =C2=A0 };
>=20
> =C2=A0 #define MNT_NS_INFO_SIZE_VER0 16 /* size of first published struct
> */
>=20
> =C2=A0 /* Get information about namespace. */
> =C2=A0 #define NS_MNT_GET_INFO		_IOR(0xb7, 10, struct
> mnt_ns_info)
> =C2=A0 /* Get next namespace. */
> =C2=A0 #define NS_MNT_GET_NEXT		_IOR(0xb7, 11, struct
> mnt_ns_info)
> =C2=A0 /* Get previous namespace. */
> =C2=A0 #define NS_MNT_GET_PREV		_IOR(0xb7, 12, struct
> mnt_ns_info)
>=20
> =C2=A0 #define PIDFD_GET_MNT_NAMESPACE _IO(0xFF, 3)
>=20
> =C2=A0 #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended
> stx_mount_id */
>=20
> =C2=A0 #define __NR_listmount 458
> =C2=A0 #define __NR_statmount 457
>=20
> =C2=A0 /*
> =C2=A0=C2=A0 * @mask bits for statmount(2)
> =C2=A0=C2=A0 */
> =C2=A0 #define STATMOUNT_SB_BASIC		0x00000001U=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 Want/got
> sb_... */
> =C2=A0 #define STATMOUNT_MNT_BASIC		0x00000002U	/* Want/got
> mnt_... */
> =C2=A0 #define STATMOUNT_PROPAGATE_FROM	0x00000004U	/* Want/got
> propagate_from */
> =C2=A0 #define STATMOUNT_MNT_ROOT		0x00000008U	/* Want/got
> mnt_root=C2=A0 */
> =C2=A0 #define STATMOUNT_MNT_POINT		0x00000010U	/* Want/got
> mnt_point */
> =C2=A0 #define STATMOUNT_FS_TYPE		0x00000020U	/* Want/got
> fs_type */
> =C2=A0 #define STATMOUNT_MNT_NS_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00000040U=C2=A0=C2=A0=C2=A0=C2=A0 /* Wa=
nt/got
> mnt_ns_id */
> =C2=A0 #define STATMOUNT_MNT_OPTS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00000080U=C2=A0=C2=A0=C2=A0=C2=A0=
 /* Want/got
> mnt_opts */
>=20
> =C2=A0 struct statmount {
> =C2=A0=C2=A0	__u32 size;		/* Total size, including strings */
> =C2=A0=C2=A0	__u32 mnt_opts;
> =C2=A0=C2=A0	__u64 mask;		/* What results were written */
> =C2=A0=C2=A0	__u32 sb_dev_major;	/* Device ID */
> =C2=A0=C2=A0	__u32 sb_dev_minor;
> =C2=A0=C2=A0	__u64 sb_magic;		/* ..._SUPER_MAGIC */
> =C2=A0=C2=A0	__u32 sb_flags;		/*
> SB_{RDONLY,SYNCHRONOUS,DIRSYNC,LAZYTIME} */
> =C2=A0=C2=A0	__u32 fs_type;		/* [str] Filesystem type */
> =C2=A0=C2=A0	__u64 mnt_id;		/* Unique ID of mount */
> =C2=A0=C2=A0	__u64 mnt_parent_id;	/* Unique ID of parent (for root =3D=3D
> mnt_id) */
> =C2=A0=C2=A0	__u32 mnt_id_old;	/* Reused IDs used in
> proc/.../mountinfo */
> =C2=A0=C2=A0	__u32 mnt_parent_id_old;
> =C2=A0=C2=A0	__u64 mnt_attr;		/* MOUNT_ATTR_... */
> =C2=A0=C2=A0	__u64 mnt_propagation;	/*
> MS_{SHARED,SLAVE,PRIVATE,UNBINDABLE} */
> =C2=A0=C2=A0	__u64 mnt_peer_group;	/* ID of shared peer group */
> =C2=A0=C2=A0	__u64 mnt_master;	/* Mount receives propagation from
> this ID */
> =C2=A0=C2=A0	__u64 propagate_from;	/* Propagation from in current
> namespace */
> =C2=A0=C2=A0	__u32 mnt_root;		/* [str] Root of mount
> relative to root of fs */
> =C2=A0=C2=A0	__u32 mnt_point;	/* [str] Mountpoint relative to
> current root */
> =C2=A0=C2=A0	__u64 mnt_ns_id;
> =C2=A0=C2=A0	__u64 __spare2[49];
> =C2=A0=C2=A0	char str[];		/* Variable size part containing
> strings */
> =C2=A0 };
>=20
> =C2=A0 struct mnt_id_req {
> =C2=A0=C2=A0	__u32 size;
> =C2=A0=C2=A0	__u32 spare;
> =C2=A0=C2=A0	__u64 mnt_id;
> =C2=A0=C2=A0	__u64 param;
> =C2=A0=C2=A0	__u64 mnt_ns_id;
> =C2=A0 };
>=20
> =C2=A0 #define MNT_ID_REQ_SIZE_VER1	32 /* sizeof second published struct
> */
>=20
> =C2=A0 #define LSMT_ROOT		0xffffffffffffffff	/* root
> mount */
>=20
> =C2=A0 static int __statmount(__u64 mnt_id, __u64 mnt_ns_id, __u64 mask,
> =C2=A0=C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct statmount *stmn=
t, size_t bufsize,
> unsigned int flags)
> =C2=A0 {
> =C2=A0=C2=A0	struct mnt_id_req req =3D {
> =C2=A0=C2=A0		.size =3D MNT_ID_REQ_SIZE_VER1,
> =C2=A0=C2=A0		.mnt_id =3D mnt_id,
> =C2=A0=C2=A0		.param =3D mask,
> =C2=A0=C2=A0		.mnt_ns_id =3D mnt_ns_id,
> =C2=A0=C2=A0	};
>=20
> =C2=A0=C2=A0	return syscall(__NR_statmount, &req, stmnt, bufsize, flags);
> =C2=A0 }
>=20
> =C2=A0 static struct statmount *sys_statmount(__u64 mnt_id, __u64
> mnt_ns_id,
> =C2=A0=C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u64 mask, unsigned=
 int
> flags)
> =C2=A0 {
> =C2=A0=C2=A0	size_t bufsize =3D 1 << 15;
> =C2=A0=C2=A0	struct statmount *stmnt =3D NULL, *tmp =3D NULL;
> =C2=A0=C2=A0	int ret;
>=20
> =C2=A0=C2=A0	for (;;) {
> =C2=A0=C2=A0		tmp =3D realloc(stmnt, bufsize);
> =C2=A0=C2=A0		if (!tmp)
> =C2=A0=C2=A0			goto out;
>=20
> =C2=A0=C2=A0		stmnt =3D tmp;
> =C2=A0=C2=A0		ret =3D __statmount(mnt_id, mnt_ns_id, mask, stmnt,
> bufsize, flags);
> =C2=A0=C2=A0		if (!ret)
> =C2=A0=C2=A0			return stmnt;
>=20
> =C2=A0=C2=A0		if (errno !=3D EOVERFLOW)
> =C2=A0=C2=A0			goto out;
>=20
> =C2=A0=C2=A0		bufsize <<=3D 1;
> =C2=A0=C2=A0		if (bufsize >=3D UINT_MAX / 2)
> =C2=A0=C2=A0			goto out;
>=20
> =C2=A0=C2=A0	}
>=20
> =C2=A0 out:
> =C2=A0=C2=A0	free(stmnt);
> =C2=A0=C2=A0	printf("statmount failed");
> =C2=A0=C2=A0	return NULL;
> =C2=A0 }
>=20
> =C2=A0 static ssize_t sys_listmount(__u64 mnt_id, __u64 last_mnt_id, __u6=
4
> mnt_ns_id,
> =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 __u64 list[], size_t num, unsigne=
d int
> flags)
> =C2=A0 {
> =C2=A0=C2=A0	struct mnt_id_req req =3D {
> =C2=A0=C2=A0		.size =3D MNT_ID_REQ_SIZE_VER1,
> =C2=A0=C2=A0		.mnt_id =3D mnt_id,
> =C2=A0=C2=A0		.param =3D last_mnt_id,
> =C2=A0=C2=A0		.mnt_ns_id =3D mnt_ns_id,
> =C2=A0=C2=A0	};
>=20
> =C2=A0=C2=A0	return syscall(__NR_listmount, &req, list, num, flags);
> =C2=A0 }
>=20
> =C2=A0 int main(int argc, char *argv[])
> =C2=A0 {
> =C2=A0 #define LISTMNT_BUFFER 10
> =C2=A0=C2=A0	__u64 list[LISTMNT_BUFFER], last_mnt_id =3D 0;
> =C2=A0=C2=A0	int ret, pidfd, fd_mntns;
> =C2=A0=C2=A0	struct mnt_ns_info info =3D {};
>=20
> =C2=A0=C2=A0	pidfd =3D pidfd_open(getpid(), 0);
> =C2=A0=C2=A0	if (pidfd < 0)
> =C2=A0=C2=A0		die_errno("pidfd_open failed");
>=20
> =C2=A0=C2=A0	fd_mntns =3D ioctl(pidfd, PIDFD_GET_MNT_NAMESPACE, 0);
> =C2=A0=C2=A0	if (fd_mntns < 0)
> =C2=A0=C2=A0		die_errno("ioctl(PIDFD_GET_MNT_NAMESPACE) failed");
>=20
> =C2=A0=C2=A0	ret =3D ioctl(fd_mntns, NS_MNT_GET_INFO, &info);
> =C2=A0=C2=A0	if (ret < 0)
> =C2=A0=C2=A0		die_errno("ioctl(NS_GET_MNTNS_ID) failed");
>=20
> =C2=A0=C2=A0	printf("Listing %u mounts for mount namespace %d:%llu\n",
> info.nr_mounts, fd_mntns, info.mnt_ns_id);
> =C2=A0=C2=A0	for (;;) {
> =C2=A0=C2=A0		ssize_t nr_mounts;
> =C2=A0=C2=A0	next:
> =C2=A0=C2=A0		nr_mounts =3D sys_listmount(LSMT_ROOT, last_mnt_id,
> info.mnt_ns_id, list, LISTMNT_BUFFER, 0);
> =C2=A0=C2=A0		if (nr_mounts <=3D 0) {
> =C2=A0=C2=A0			printf("Finished listing mounts for mount
> namespace %d:%llu\n\n", fd_mntns, info.mnt_ns_id);
> =C2=A0=C2=A0			ret =3D ioctl(fd_mntns, NS_MNT_GET_NEXT, 0);
> =C2=A0=C2=A0			if (ret < 0)
> =C2=A0=C2=A0				die_errno("ioctl(NS_MNT_GET_NEXT)
> failed");
> =C2=A0=C2=A0			close(ret);
> =C2=A0=C2=A0			ret =3D ioctl(fd_mntns, NS_MNT_GET_NEXT,
> &info);
> =C2=A0=C2=A0			if (ret < 0) {
> =C2=A0=C2=A0				if (errno =3D=3D ENOENT) {
> =C2=A0=C2=A0					printf("Finished listing all
> mount namespaces\n");
> =C2=A0=C2=A0					exit(0);
> =C2=A0=C2=A0				}
> =C2=A0=C2=A0				die_errno("ioctl(NS_MNT_GET_NEXT)
> failed");
> =C2=A0=C2=A0			}
> =C2=A0=C2=A0			close(fd_mntns);
> =C2=A0=C2=A0			fd_mntns =3D ret;
> =C2=A0=C2=A0			last_mnt_id =3D 0;
> =C2=A0=C2=A0			printf("Listing %u mounts for mount
> namespace %d:%llu\n", info.nr_mounts, fd_mntns, info.mnt_ns_id);
> =C2=A0=C2=A0			goto next;
> =C2=A0=C2=A0		}
>=20
> =C2=A0=C2=A0		for (size_t cur =3D 0; cur < nr_mounts; cur++) {
> =C2=A0=C2=A0			struct statmount *stmnt;
>=20
> =C2=A0=C2=A0			last_mnt_id =3D list[cur];
>=20
> =C2=A0=C2=A0			stmnt =3D sys_statmount(last_mnt_id,
> info.mnt_ns_id,
> =C2=A0=C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 STATMOUNT_SB_BASIC |
> =C2=A0=C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 STATMOUNT_MNT_BASIC |
> =C2=A0=C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 STATMOUNT_MNT_ROOT |
> =C2=A0=C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 STATMOUNT_MNT_POINT |
> =C2=A0=C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 STATMOUNT_MNT_NS_ID |
> =C2=A0=C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 STATMOUNT_MNT_OPTS |
> =C2=A0=C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 STATMOUNT_FS_TYPE,
> =C2=A0=C2=A0					=C2=A0 0);
> =C2=A0=C2=A0			if (!stmnt) {
> =C2=A0=C2=A0				printf("Failed to statmount(%llu) in
> mount namespace(%llu)\n", last_mnt_id, info.mnt_ns_id);
> =C2=A0=C2=A0				continue;
> =C2=A0=C2=A0			}
>=20
> =C2=A0=C2=A0			printf("mnt_id(%u/%llu) |
> mnt_parent_id(%u/%llu): %s @ %s =3D=3D> %s with options: %s\n",
> =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stmnt->mnt_id_old, st=
mnt->mnt_id,
> =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stmnt->mnt_parent_id_=
old, stmnt-
> >mnt_parent_id,
> =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stmnt->str + stmnt->f=
s_type,
> =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stmnt->str + stmnt->m=
nt_root,
> =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stmnt->str + stmnt->m=
nt_point,
> =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stmnt->str + stmnt->m=
nt_opts);
> =C2=A0=C2=A0			free(stmnt);
> =C2=A0=C2=A0		}
> =C2=A0=C2=A0	}
>=20
> =C2=A0=C2=A0	exit(0);
> =C2=A0 }
>=20
> Thanks!
> Christian
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> ---
> base-commit: 720261cfc7329406a50c2a8536e0039b9dd9a4e5
> change-id: 20240705-work-mount-namespace-126b73a11f5c
>=20

This all looks pretty straightforward to me. I do wish that we had
proper libc bindings for this...or maybe even a new userland library?

I just get the feeling that all of this syscall() and ioctl() usage is
eventually going to bite us in the ass. I don't have any concrete
proposal for that however, and we do have some immediate need for this
functionality, so, you can add

Reviewed-by: Jeff Layton <jlayton@kernel.org>


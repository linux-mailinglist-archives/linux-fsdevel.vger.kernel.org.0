Return-Path: <linux-fsdevel+bounces-70669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 061F2CA3F36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 15:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07B5D301B12F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 14:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A00341AAE;
	Thu,  4 Dec 2025 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tm70lfgF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053F633F8A8;
	Thu,  4 Dec 2025 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764857488; cv=none; b=ao8U/SHUaEJMvH28qrc1TERp6jZ6rb78aPwQpY7m42mdj648B0ilCZ+K7Z3BYnhwBWbyo49Ursw5QW0yKB1+dwCU2c89uLsqQHltdLn/qi29oR5Cyo+hR/yxBbquBUP3O+9KXaeaSa4d4OdCIMzhTJhrt2PfhVTd4touo6l5nSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764857488; c=relaxed/simple;
	bh=m3H/3ioNp9U4j7DEHrzqol59bKijaqgK49gOb72xL0M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZuQeDGl/gA+LTa1ZsFU/DjuMWeKUPT5sR62hfNp9/sif9t0ykBqVXwzt4tkKd+5UUi/QwxuwjgY7kZ8GFIiWvTE/NXk6UQC09GieFcVg9deuh8+iyvevedcd6+tIDvp/13IxMMsmFrtBnrBDgRC4oAv1R5W3XIYLYQP7edzUvTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tm70lfgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1572EC116D0;
	Thu,  4 Dec 2025 14:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764857487;
	bh=m3H/3ioNp9U4j7DEHrzqol59bKijaqgK49gOb72xL0M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tm70lfgFyib2UED/ePDToCcQsDnLXjzfwjRX99vC2YxT5gzG/ZLZj4cPGybJXqrId
	 iSWaNx9HfMsvNN32luCQh6Si5GuSr2OU0q4+KGNtyaZEPasaolyMWRRL6FHDS1er8d
	 mApW7+4L6zWRv0pNVTqT1iM3IklHtMBPgznpvij8n0QoU15RjHFw45lYl8ZpFkfUaF
	 wNU6kuH19ha45AhKDKp3UZ6jIYZOQFWD1Ck8rnUcHhpPfVNh6heVST1W2zHaYYutdT
	 eiABNhMO2t0av1i0rXL6yq1cdRYmm9T5ninVzrbZMoTOBztvQe8wBcrTNwa3pxqmnw
	 rHnr5TXZRG5jw==
Message-ID: <37d39ff38dfef8bae73c5bc6a8593784bb2d3774.camel@kernel.org>
Subject: Re: [PATCH v7 0/3] statmount: accept fd as a parameter
From: Jeff Layton <jlayton@kernel.org>
To: Bhavik Sachdev <b.sachdev1904@gmail.com>, Alexander Viro	
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Shuah
 Khan	 <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, criu@lists.linux.dev, Jan Kara
 <jack@suse.cz>,  Aleksa Sarai <cyphar@cyphar.com>, Miklos Szeredi
 <miklos@szeredi.hu>, Pavel Tikhomirov	 <ptikhomirov@virtuozzo.com>, Andrei
 Vagin <avagin@gmail.com>, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 John Hubbard <jhubbard@nvidia.com>, Amir Goldstein	 <amir73il@gmail.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,  Andrew Donnellan	
 <ajd@linux.ibm.com>
Date: Thu, 04 Dec 2025 09:11:24 -0500
In-Reply-To: <20251129091455.757724-1-b.sachdev1904@gmail.com>
References: <20251129091455.757724-1-b.sachdev1904@gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-11-29 at 14:41 +0530, Bhavik Sachdev wrote:
> We would like to add support for checkpoint/restoring file descriptors
> open on these "unmounted" mounts to CRIU (Checkpoint/Restore in
> Userspace) [1].
>=20
> Currently, we have no way to get mount info for these "unmounted" mounts
> since they do appear in /proc/<pid>/mountinfo and statmount does not
> work on them, since they do not belong to any mount namespace.
>=20
> This patch helps us by providing a way to get mountinfo for these
> "unmounted" mounts by using a fd on the mount.
>=20
> Changes from v6 [2] to v7:
> * Add kselftests for STATMOUNT_BY_FD flag.
>=20
> * Instead of renaming mnt_id_req.mnt_ns_fd to mnt_id_req.fd introduce a
> union so struct mnt_id_req looks like this:
>=20
>     struct mnt_id_req {
>             __u32 size;
>             union {
>                     __u32 mnt_ns_fd;
>                     __u32 mnt_fd;
>             };
>             __u64 mnt_id;
>             __u64 param;
>             __u64 mnt_ns_id;
>     };
>=20
> * In case of STATMOUNT_BY_FD grab mnt_ns inside of do_statmount(),
> since we get mnt_ns from mnt, which should happen under namespace lock.
>=20
> * Remove the modifications made to grab_requested_mnt_ns, those were
> never needed.
>=20
> Changes from v5 [3] to v6:
> * Instead of returning "[unmounted]" as the mount point for "unmounted"
> mounts, we unset the STATMOUNT_MNT_POINT flag in statmount.mask.
>=20
> * Instead of returning 0 as the mnt_ns_id for "unmounted" mounts, we
> unset the STATMOUNT_MNT_NS_ID flag in statmount.mask.
>=20
> * Added comment in `do_statmount` clarifying that the caller sets s->mnt
> in case of STATMOUNT_BY_FD.
>=20
> * In `do_statmount` move the mnt_ns_id and mnt_ns_empty() check just
> before lookup_mnt_in_ns().
>=20
> * We took another look at the capability checks for getting information
> for "unmounted" mounts using an fd and decided to remove them for the
> following reasons:
>=20
>   - All fs related information is available via fstatfs() without any
>     capability check.
>=20
>   - Mount information is also available via /proc/pid/mountinfo (without
>     any capability check).
>=20
>   - Given that we have access to a fd on the mount which tells us that
>     we had access to the mount at some point (or someone that had access
>     gave us the fd). So, we should be able to access mount info.
>=20
> Changes from v4 [4] to v5:
> Check only for s->root.mnt to be NULL instead of checking for both
> s->root.mnt and s->root.dentry (I did not find a case where only one of
> them would be NULL).
>=20
> * Only allow system root (CAP_SYS_ADMIN in init_user_ns) to call
> statmount() on fd's on "unmounted" mounts. We (mostly Pavel) spent some
> time thinking about how our previous approach (of checking the opener's
> file credentials) caused problems.
>=20
> Please take a look at the linked pictures they describe everything more
> clearly.
>=20
> Case 1: A fd is on a normal mount (Link to Picture: [5])
> Consider, a situation where we have two processes P1 and P2 and a file
> F1. F1 is opened on mount ns M1 by P1. P1 is nested inside user
> namespace U1 and U2. P2 is also in U1. P2 is also in a pid namespace and
> mount namespace separate from M1.
>=20
> P1 sends F1 to P2 (using a unix socket). But, P2 is unable to call
> statmount() on F1 because since it is a separate pid and mount
> namespace. This is good and expected.
>=20
> Case 2: A fd is on a "unmounted" mount (Link to Picture: [6])
> Consider a similar situation as Case 1. But now F1 is on a mounted that
> has been "unmounted". Now, since we used openers credentials to check
> for permissions P2 ends up having the ability call statmount() and get
> mount info for this "unmounted" mount.
>=20
> Hence, It is better to restrict the ability to call statmount() on fds
> on "unmounted" mounts to system root only (There could also be other
> cases than the one described above).
>=20
> Changes from v3 [7] to v4:
> * Change the string returned when there is no mountpoint to be
> "[unmounted]" instead of "[detached]".
> * Remove the new DEFINE_FREE put_file and use the one already present in
> include/linux/file.h (fput) [8].
> * Inside listmount consistently pass 0 in flags to copy_mnt_id_req and
> prepare_klistmount()->grab_requested_mnt_ns() and remove flags from the
> prepare_klistmount prototype.
> * If STATMOUNT_BY_FD is set, check for mnt_ns_id =3D=3D 0 && mnt_id =3D=
=3D 0.
>=20
> Changes from v2 [9] to v3:
> * Rename STATMOUNT_FD flag to STATMOUNT_BY_FD.
> * Fixed UAF bug caused by the reference to fd_mount being bound by scope
> of CLASS(fd_raw, f)(kreq.fd) by using fget_raw instead.
> * Reused @spare parameter in mnt_id_req instead of adding new fields to
> the struct.
>=20
> Changes from v1 [10] to v2:
> v1 of this patchset, took a different approach and introduced a new
> umount_mnt_ns, to which "unmounted" mounts would be moved to (instead of
> their namespace being NULL) thus allowing them to be still available via
> statmount.
>=20
> Introducing umount_mnt_ns complicated namespace locking and modified
> performance sensitive code [11] and it was agreed upon that fd-based
> statmount would be better.
>=20
> This code is also available on github [12].
>=20
> [1]: https://github.com/checkpoint-restore/criu/pull/2754
> [2]: https://lore.kernel.org/all/20251118084836.2114503-1-b.sachdev1904@g=
mail.com/
> [3]: https://lore.kernel.org/criu/20251109053921.1320977-2-b.sachdev1904@=
gmail.com/T/#u
> [4]: https://lore.kernel.org/all/20251029052037.506273-2-b.sachdev1904@gm=
ail.com/
> [5]: https://github.com/bsach64/linux/blob/statmount-fd-v5/fd_on_normal_m=
ount.png
> [6]: https://github.com/bsach64/linux/blob/statmount-fd-v5/file_on_unmoun=
ted_mount.png
> [7]: https://lore.kernel.org/all/20251024181443.786363-1-b.sachdev1904@gm=
ail.com/
> [8]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/include/linux/file.h#n97
> [9]: https://lore.kernel.org/linux-fsdevel/20251011124753.1820802-1-b.sac=
hdev1904@gmail.com/
> [10]: https://lore.kernel.org/linux-fsdevel/20251002125422.203598-1-b.sac=
hdev1904@gmail.com/
> [11]: https://lore.kernel.org/linux-fsdevel/7e4d9eb5-6dde-4c59-8ee3-35823=
3f082d0@virtuozzo.com/
> [12]: https://github.com/bsach64/linux/tree/statmount-fd-v7
>=20
> Bhavik Sachdev (3):
>   statmount: permission check should return EPERM
>   statmount: accept fd as a parameter
>   selftests: statmount: tests for STATMOUNT_BY_FD
>=20
>  fs/namespace.c                                | 102 ++++---
>  include/uapi/linux/mount.h                    |  10 +-
>  .../filesystems/statmount/statmount.h         |  15 +-
>  .../filesystems/statmount/statmount_test.c    | 261 +++++++++++++++++-
>  .../filesystems/statmount/statmount_test_ns.c | 101 ++++++-
>  5 files changed, 430 insertions(+), 59 deletions(-)

This looks useful.

Reviewed-by: Jeff Layton <jlayton@kernel.org>


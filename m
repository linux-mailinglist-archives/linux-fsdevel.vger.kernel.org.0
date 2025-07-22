Return-Path: <linux-fsdevel+bounces-55687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3672FB0DB93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 15:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD166AA12D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 13:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2DA2EA163;
	Tue, 22 Jul 2025 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWQcgf5h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1096E22FDFF;
	Tue, 22 Jul 2025 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192222; cv=none; b=JEnHAWCfeWFx0EIn+b/hXq8JiDczFX7tiliEAjrBXg4+vENuAAtXThlBdc3HShY4QrHQhKgmbcSMj7o4uNqUmWVPE+pGKMLkMzGuIK3zUss9x/Q5kly9wj2vi+DH0NfQo00DH1Jhi1uPFBke038GMdw2pmtVv8EZAyIdhrLi1eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192222; c=relaxed/simple;
	bh=bb7KtLo46a3ckn6mm3+IYFHTEZO/HU2x35hTCNETye0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rCXsuJQBfFi/rvlJKOEKxxd8MuA+Zn9GR2DNP4e36TGjaSBzzxsG96GgXHijm//LZMacfAnq7MgER8+gs2Eehj7pleWCTyEs+TN0v3cBu4QmUoZYzi0+GMOLDFQnN38g5RgKWOgjlXj11JY1QW1TS9FwevwyPDglHtQdIV+5luE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWQcgf5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7D1C4CEEB;
	Tue, 22 Jul 2025 13:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753192221;
	bh=bb7KtLo46a3ckn6mm3+IYFHTEZO/HU2x35hTCNETye0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jWQcgf5h3pdNPtQtp8Z7rJLHzLQnZsfkUkkfqs/g6OXmGFnXD6P555nZXwf8Nukog
	 vmjbOuqPRonnQMK2mNlgCUm4oDRcp3GfhUucmqqzuD65lAJI11mWSPGhEciWuFwpSE
	 wxmiQhY2d7lRcqvr1I+N7mLMY24a/3FDUPDcc9mDagKorHfv5OzoMQfK95wvM2j1V9
	 OojFVQhbI62b26CI0kng58ZC71BmSjUMWoDgGVu/Gc+Q/o9XYzztZ/3TP99WyuIwRX
	 X4hbyLjfrUqcSRzSStoS2Z2aHqFvZNnCWZ+IgGfcVt1Vi2nwdiO+xaI4PRb3jjO+F/
	 5o528ecSypaBQ==
Message-ID: <4aa89e94145074a70e51df7353e7e19e30efd06d.camel@kernel.org>
Subject: Re: [PATCH RFC DRAFT v2 00/13] Move fscrypt and fsverity out of
 struct inode
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.com>, 
 Christoph Hellwig	 <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Josef Bacik
 <josef@toxicpanda.com>
Cc: Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	fsverity@lists.linux.dev
Date: Tue, 22 Jul 2025 09:50:19 -0400
In-Reply-To: <20250722-work-inode-fscrypt-v2-0-782f1fdeaeba@kernel.org>
References: 
	<fhppu2rnsykr5obrib3btw7wemislq36wufnbl67salvoguaof@kkxaosrv3oho>
	 <20250722-work-inode-fscrypt-v2-0-782f1fdeaeba@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-22 at 14:57 +0200, Christian Brauner wrote:
> Hey,
>=20
> This is a POC. We're still discussing alternatives and I want to provide
> some useful data on what I learned about using offsets to drop fscrypt
> and fsverity from struct inode.
>=20
> As discussed, this moves the fscrypt and fsverity pointers out of struct
> inode shrinking it by 16 bytes. The pointers move into the individual
> filesystems that actually do make use of them.
>=20
> In order to find the fscrypt and fsverity data pointers offsets from the
> embedded struct inode in the filesystem's private inode data are
> stored in struct inode_operations. This means we get fast access to the
> data pointers without having to rely on indirect calls.
>=20
> Bugs & Issues
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * For fscrypt specifically the biggest issue is
>   fscrypt_prepare_new_inode() is called in filesystem's inode allocation
>   functions before inode->i_op is set. That means the offset isn't
>   available at the time when we would need it. To fix this we can set
>   dummy encrypted inode operations for the respective filesystem with an
>   initialized offset.
>=20
> * For both fscrypt & fsverity the biggest issue is that every codepath
>   that currently calls make_bad_inode() after having initialized fscrypt
>   or fsverity data will override inode->i_op with bad_inode_ops. At
>   which point we're back to the previous problem: The offset isn't
>   available anymore. So when inode->i_sb->s_op->evict_inode() is called
>   fscrypt_put_encryption_info() doesn't have the offset available
>   anymore and would corrupt the hell out of everything and also leak
>   memory.
>=20
>   Obviously we could use a flag to detect a bad inodes instead of i_op
>   and let the filesystem assign it's own bad inode operations including
>   the correct offset. Is it worth it?
>=20
>   The other way I see we can fix this if we require fixed offsets in the
>   filesystems inode so fscrypt and fsverity always now what offset to
>   calculate. We could use two consecutive pointers at the beginning of
>   the filesystem's inode. Does that always work and is it worth it?
>=20

We could store the offsets in the superblock. It's an extra pointer
chase to get to the offset in that case, but presumably it should be in
cache in most cases.

We could even do both -- store it in i_ops and somehow allow falling
back to looking in the superblock when i_ops isn't set or when
make_bad_inode has been called.

> Thanks!
> Christian
>=20
> Test results:
>=20
> + sudo ./check -g encrypt,verity
> FSTYP         -- ext4
> PLATFORM      -- Linux/x86_64 localhost 6.16.0-rc1-g15c8eb9cdbd3 #267 SMP=
 PREEMPT_DYNAMIC Fri Jun  5 15:58:00 CEST 2015
> MKFS_OPTIONS  -- -F /dev/nvme3n1p6
> MOUNT_OPTIONS -- -o acl,user_xattr /dev/nvme3n1p6 /mnt/scratch
>=20
> ext4/024 3s ...  3s
> generic/395 4s ...  4s
> generic/396 3s ...  3s
> generic/397 4s ...  3s
> generic/398 4s ...  4s
> generic/399 39s ...  35s
> generic/419 3s ...  4s
> generic/421 4s ...  4s
> generic/429 14s ...  14s
> generic/435 23s ...  22s
> generic/440 3s ...  4s
> generic/548 10s ...  9s
> generic/549 9s ...  9s
> generic/550       [not run] encryption policy '-c 9 -n 9 -f 0' is unusabl=
e; probably missing kernel crypto API support
> generic/572        6s
> generic/573        4s
> generic/574        28s
> generic/575        9s
> generic/576 5s ...  4s
> generic/577        4s
> generic/579        24s
> generic/580 4s ...  4s
> generic/581 10s ...  11s
> generic/582 10s ...  9s
> generic/583 9s ...  9s
> generic/584       [not run] encryption policy '-c 9 -n 9 -v 2 -f 0' is un=
usable; probably missing kernel crypto API support
> generic/592 10s ...  10s
> generic/593 4s ...  4s
> generic/595 7s ...  7s
> generic/602 9s ...  10s
> generic/613 20s ...  20s
> generic/621 9s ...  9s
> generic/624        3s
> generic/625        3s
> generic/692        5s
> generic/693       [not run] encryption policy '-c 1 -n 10 -v 2 -f 0' is u=
nusable; probably missing kernel crypto API support
> generic/739 17s ...  18s
> Ran: ext4/024 generic/395 generic/396 generic/397 generic/398 generic/399=
 generic/419 generic/421 generic/429 generic/435 generic/440 generic/548 ge=
neric/549 generic/550 generic/572 generic/573 generic/574 generic/575 gener=
ic/576 generic/577 generic/579 generic/580 generic/581 generic/582 generic/=
583 generic/584 generic/592 generic/593 generic/595 generic/602 generic/613=
 generic/621 generic/624 generic/625 generic/692 generic/693 generic/739
> Not run: generic/550 generic/584 generic/693
> Passed all 37 tests
>=20
> ---
> Changes in v2:
> - First full implementation.
> - Link to v1: https://lore.kernel.org/20250715-work-inode-fscrypt-v1-1-aa=
3ef6f44b6b@kernel.org
>=20
> ---
> Christian Brauner (13):
>       fs: add fscrypt offset
>       fs/crypto: use accessors
>       ext4: move fscrypt to filesystem inode
>       ubifs: move fscrypt to filesystem inode
>       f2fs: move fscrypt to filesystem inode
>       ceph: move fscrypt to filesystem inode
>       fs: drop i_crypt_info from struct inode
>       fs: add fsverity offset
>       fs/verity: use accessors
>       btrfs: move fsverity to filesystem inode
>       ext4: move fsverity to filesystem inode
>       f2fs: move fsverity to filesystem inode
>       fs: drop i_verity_info from struct inode
>=20
>  fs/btrfs/btrfs_inode.h       |  3 +++
>  fs/btrfs/inode.c             | 20 ++++++++++++++++-
>  fs/ceph/dir.c                |  8 +++++++
>  fs/ceph/inode.c              | 21 ++++++++++++++++++
>  fs/crypto/bio.c              |  2 +-
>  fs/crypto/crypto.c           |  8 +++----
>  fs/crypto/fname.c            |  8 +++----
>  fs/crypto/fscrypt_private.h  |  2 +-
>  fs/crypto/hooks.c            |  2 +-
>  fs/crypto/inline_crypt.c     | 10 ++++-----
>  fs/crypto/keysetup.c         | 27 +++++++++++++----------
>  fs/crypto/policy.c           |  6 ++---
>  fs/ext4/ext4.h               |  9 ++++++++
>  fs/ext4/file.c               |  8 +++++++
>  fs/ext4/ialloc.c             |  2 ++
>  fs/ext4/inode.c              |  1 +
>  fs/ext4/mballoc.c            |  3 +++
>  fs/ext4/namei.c              | 23 ++++++++++++++++++++
>  fs/ext4/super.c              |  6 +++++
>  fs/ext4/symlink.c            | 24 ++++++++++++++++++++
>  fs/f2fs/f2fs.h               |  7 ++++++
>  fs/f2fs/file.c               |  8 +++++++
>  fs/f2fs/inode.c              |  1 +
>  fs/f2fs/namei.c              | 41 ++++++++++++++++++++++++++++++++++
>  fs/f2fs/super.c              |  6 +++++
>  fs/ubifs/dir.c               | 52 ++++++++++++++++++++++++--------------=
------
>  fs/ubifs/file.c              |  8 +++++++
>  fs/ubifs/super.c             |  8 +++++++
>  fs/ubifs/ubifs.h             |  3 +++
>  fs/verity/enable.c           |  2 +-
>  fs/verity/fsverity_private.h |  2 +-
>  fs/verity/open.c             | 18 +++++++++------
>  fs/verity/verify.c           |  2 +-
>  include/linux/fs.h           | 10 ++-------
>  include/linux/fscrypt.h      | 31 ++++++++++++++++++++++++--
>  include/linux/fsverity.h     | 21 ++++++++++++------
>  include/linux/netfs.h        |  6 +++++
>  37 files changed, 337 insertions(+), 82 deletions(-)
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20250715-work-inode-fscrypt-2b63b276e793

--=20
Jeff Layton <jlayton@kernel.org>


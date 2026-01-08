Return-Path: <linux-fsdevel+bounces-72924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0328FD05B6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 20:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D25E83050193
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 18:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F971328B6A;
	Thu,  8 Jan 2026 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVcj/Up5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87169288510;
	Thu,  8 Jan 2026 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767898626; cv=none; b=a2tp/vbvg5vOz/uU88Hka3SbaN5Ipr9wrhqQ42NjBIeHmxoWwt0pEJ2OCAW5kbzwnLitJQpWsGOp7EwWjS5ByyYIzQDpids0hDiLI/MreDCuZplv5784kj4jB16GtxBWOxwnf7Cmqo64fiYXuPJj20nHBYjppWaeFn57+lTJPDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767898626; c=relaxed/simple;
	bh=5he/mWk942UgyMcVrvD6SAu+dsdYI4IY/ZKYEV0nd4I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lfgwzfcPBGm9NkfKTRiXLXlFHeiFLTFDpxUUFQU0ldDShD6KYbwCHyBuscfVrtQDdKXH/mRyWbdUDrKRCp9u0IPglibY6nVYaih+SUdCQ9OtWvVgpshRcX/eSC0EllZm6b8rJYgwje2Rw9JdogaSDth1P6AqboxNH0YDOfX1iUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVcj/Up5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A8BC116C6;
	Thu,  8 Jan 2026 18:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767898626;
	bh=5he/mWk942UgyMcVrvD6SAu+dsdYI4IY/ZKYEV0nd4I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=IVcj/Up5pUIL/21UD3vdFo7LG1nsqJG0y8MII2rX7fuh3iO8eqoctQChr69A/z58g
	 5KgbF1X8xV00o46rmPIbcqIZEIF8erkf826KYZ1ZoGs2hcwFRvz9oiVBU92gbAhzyA
	 0r+l6Mt1vxiLBuRQjFSLEctLEhTBADuTECQiBZ+9gqw+8u7gUFlUKFPJqHkbOoasko
	 I2D7VrQn9/cdA7UghgaIjR2YaPHOE3ivbWn4hGdWJmaH9cka4Cx7gfyO6gbb1+SzsA
	 TSEp5Wq9R6HWJ/Dy8pXZUMSYMMQX7UKyEKZOf6GGsWFZtBY90ZvwFFESq3Sx7W68cd
	 7b0wtGXIJLNHQ==
Message-ID: <8af369636c32b868f83669c49aea708ca3b894ac.camel@kernel.org>
Subject: Re: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to
 lease support
From: Jeff Layton <jlayton@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Luis de Bethencourt <luisbg@kernel.org>, Salah Triki
 <salah.triki@gmail.com>,  Nicolas Pitre <nico@fluxnic.net>, Christoph
 Hellwig <hch@infradead.org>, Anders Larsen <al@alarsen.net>,  Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 David Sterba <dsterba@suse.com>,  Chris Mason	 <clm@fb.com>, Gao Xiang
 <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu	
 <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep
 Dhavale	 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, Chunhai
 Guo	 <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, Theodore Ts'o
 <tytso@mit.edu>,  Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim
 <jaegeuk@kernel.org>, OGAWA Hirofumi	 <hirofumi@mail.parknet.co.jp>, David
 Woodhouse <dwmw2@infradead.org>,  Richard Weinberger	 <richard@nod.at>,
 Dave Kleikamp <shaggy@kernel.org>, Ryusuke Konishi	
 <konishi.ryusuke@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh
 <mark@fasheh.com>, Joel Becker	 <jlbec@evilplan.org>, Joseph Qi
 <joseph.qi@linux.alibaba.com>, Mike Marshall	 <hubcap@omnibond.com>, Martin
 Brandenburg <martin@omnibond.com>, Miklos Szeredi	 <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>, Phillip Lougher	
 <phillip@squashfs.org.uk>, Carlos Maiolino <cem@kernel.org>, Hugh Dickins	
 <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew
 Morton	 <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>,
 Sungjong Seo	 <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>,
 Chuck Lever	 <chuck.lever@oracle.com>, Alexander Aring
 <alex.aring@gmail.com>, Andreas Gruenbacher <agruenba@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, "Matthew Wilcox (Oracle)"	 <willy@infradead.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, Christian
 Schoenebeck	 <linux_oss@crudebyte.com>, Xiubo Li <xiubli@redhat.com>, Ilya
 Dryomov	 <idryomov@gmail.com>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker	 <anna@kernel.org>, Steve French <sfrench@samba.org>, Paulo
 Alcantara	 <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N	 <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Bharath SM	 <bharathsm@microsoft.com>, Hans de Goede <hansg@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net, 
	linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
 ocfs2-devel@lists.linux.dev, 	devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, 	linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, gfs2@lists.linux.dev, 	linux-doc@vger.kernel.org,
 v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org
Date: Thu, 08 Jan 2026 13:56:57 -0500
In-Reply-To: <m3mywef74xhcakianlrovrnaadnhzhfqjfusulkcnyioforfml@j2xnk7dzkmv4>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
	 <m3mywef74xhcakianlrovrnaadnhzhfqjfusulkcnyioforfml@j2xnk7dzkmv4>
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

On Thu, 2026-01-08 at 18:40 +0100, Jan Kara wrote:
> On Thu 08-01-26 12:12:55, Jeff Layton wrote:
> > Yesterday, I sent patches to fix how directory delegation support is
> > handled on filesystems where the should be disabled [1]. That set is
> > appropriate for v6.19. For v7.0, I want to make lease support be more
> > opt-in, rather than opt-out:
> >=20
> > For historical reasons, when ->setlease() file_operation is set to NULL=
,
> > the default is to use the kernel-internal lease implementation. This
> > means that if you want to disable them, you need to explicitly set the
> > ->setlease() file_operation to simple_nosetlease() or the equivalent.
> >=20
> > This has caused a number of problems over the years as some filesystems
> > have inadvertantly allowed leases to be acquired simply by having left
> > it set to NULL. It would be better if filesystems had to opt-in to leas=
e
> > support, particularly with the advent of directory delegations.
> >=20
> > This series has sets the ->setlease() operation in a pile of existing
> > local filesystems to generic_setlease() and then changes
> > kernel_setlease() to return -EINVAL when the setlease() operation is no=
t
> > set.
> >=20
> > With this change, new filesystems will need to explicitly set the
> > ->setlease() operations in order to provide lease and delegation
> > support.
> >=20
> > I mainly focused on filesystems that are NFS exportable, since NFS and
> > SMB are the main users of file leases, and they tend to end up exportin=
g
> > the same filesystem types. Let me know if I've missed any.
>=20
> So, what about kernfs and fuse? They seem to be exportable and don't have
> .setlease set...
>=20

Yes, FUSE needs this too. I'll add a patch for that.

As far as kernfs goes: AIUI, that's basically what sysfs and resctrl
are built on. Do we really expect people to set leases there?

I guess it's technically a regression since you could set them on those
sorts of files earlier, but people don't usually export kernfs based
filesystems via NFS or SMB, and that seems like something that could be
used to make mischief.

AFAICT, kernfs_export_ops is mostly to support open_by_handle_at(). See
commit aa8188253474 ("kernfs: add exportfs operations").

One idea: we could add a wrapper around generic_setlease() for
filesystems like this that will do a WARN_ONCE() and then call
generic_setlease(). That would keep leases working on them but we might
get some reports that would tell us who's setting leases on these files
and why.

Thanks for the review!

> >=20
> > [1]: https://lore.kernel.org/linux-fsdevel/20260107-setlease-6-19-v1-0-=
85f034abcc57@kernel.org/
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > Jeff Layton (24):
> >       fs: add setlease to generic_ro_fops and read-only filesystem dire=
ctory operations
> >       affs: add setlease file operation
> >       btrfs: add setlease file operation
> >       erofs: add setlease file operation
> >       ext2: add setlease file operation
> >       ext4: add setlease file operation
> >       exfat: add setlease file operation
> >       f2fs: add setlease file operation
> >       fat: add setlease file operation
> >       gfs2: add a setlease file operation
> >       jffs2: add setlease file operation
> >       jfs: add setlease file operation
> >       nilfs2: add setlease file operation
> >       ntfs3: add setlease file operation
> >       ocfs2: add setlease file operation
> >       orangefs: add setlease file operation
> >       overlayfs: add setlease file operation
> >       squashfs: add setlease file operation
> >       tmpfs: add setlease file operation
> >       udf: add setlease file operation
> >       ufs: add setlease file operation
> >       xfs: add setlease file operation
> >       filelock: default to returning -EINVAL when ->setlease operation =
is NULL
> >       fs: remove simple_nosetlease()
> >=20
> >  Documentation/filesystems/porting.rst |  9 +++++++++
> >  Documentation/filesystems/vfs.rst     |  9 ++++++---
> >  fs/9p/vfs_dir.c                       |  2 --
> >  fs/9p/vfs_file.c                      |  2 --
> >  fs/affs/dir.c                         |  2 ++
> >  fs/affs/file.c                        |  2 ++
> >  fs/befs/linuxvfs.c                    |  2 ++
> >  fs/btrfs/file.c                       |  2 ++
> >  fs/btrfs/inode.c                      |  2 ++
> >  fs/ceph/dir.c                         |  2 --
> >  fs/ceph/file.c                        |  1 -
> >  fs/cramfs/inode.c                     |  2 ++
> >  fs/efs/dir.c                          |  2 ++
> >  fs/erofs/data.c                       |  2 ++
> >  fs/erofs/dir.c                        |  2 ++
> >  fs/exfat/dir.c                        |  2 ++
> >  fs/exfat/file.c                       |  2 ++
> >  fs/ext2/dir.c                         |  2 ++
> >  fs/ext2/file.c                        |  2 ++
> >  fs/ext4/dir.c                         |  2 ++
> >  fs/ext4/file.c                        |  2 ++
> >  fs/f2fs/dir.c                         |  2 ++
> >  fs/f2fs/file.c                        |  2 ++
> >  fs/fat/dir.c                          |  2 ++
> >  fs/fat/file.c                         |  2 ++
> >  fs/freevxfs/vxfs_lookup.c             |  2 ++
> >  fs/fuse/dir.c                         |  1 -
> >  fs/gfs2/file.c                        |  3 +--
> >  fs/isofs/dir.c                        |  2 ++
> >  fs/jffs2/dir.c                        |  2 ++
> >  fs/jffs2/file.c                       |  2 ++
> >  fs/jfs/file.c                         |  2 ++
> >  fs/jfs/namei.c                        |  2 ++
> >  fs/libfs.c                            | 20 ++------------------
> >  fs/locks.c                            |  3 +--
> >  fs/nfs/dir.c                          |  1 -
> >  fs/nfs/file.c                         |  1 -
> >  fs/nilfs2/dir.c                       |  3 ++-
> >  fs/nilfs2/file.c                      |  2 ++
> >  fs/ntfs3/dir.c                        |  3 +++
> >  fs/ntfs3/file.c                       |  3 +++
> >  fs/ocfs2/file.c                       |  5 +++++
> >  fs/orangefs/dir.c                     |  4 +++-
> >  fs/orangefs/file.c                    |  1 +
> >  fs/overlayfs/file.c                   |  2 ++
> >  fs/overlayfs/readdir.c                |  2 ++
> >  fs/qnx4/dir.c                         |  2 ++
> >  fs/qnx6/dir.c                         |  2 ++
> >  fs/read_write.c                       |  2 ++
> >  fs/smb/client/cifsfs.c                |  1 -
> >  fs/squashfs/dir.c                     |  2 ++
> >  fs/squashfs/file.c                    |  4 +++-
> >  fs/udf/dir.c                          |  2 ++
> >  fs/udf/file.c                         |  2 ++
> >  fs/ufs/dir.c                          |  2 ++
> >  fs/ufs/file.c                         |  2 ++
> >  fs/vboxsf/dir.c                       |  1 -
> >  fs/vboxsf/file.c                      |  1 -
> >  fs/xfs/xfs_file.c                     |  3 +++
> >  include/linux/fs.h                    |  1 -
> >  mm/shmem.c                            |  2 ++
> >  61 files changed, 116 insertions(+), 42 deletions(-)
> > ---
> > base-commit: 731ce71a6c8adb8b8f873643beacaeedc1564500
> > change-id: 20260107-setlease-6-20-299eb5695c5a
> >=20
> > Best regards,
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20

--=20
Jeff Layton <jlayton@kernel.org>


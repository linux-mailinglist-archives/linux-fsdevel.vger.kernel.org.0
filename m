Return-Path: <linux-fsdevel+bounces-26041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA121952C10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 12:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C7C1F24771
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 10:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4FC1C37A3;
	Thu, 15 Aug 2024 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="wI+5SAfs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDACD178CC8
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713885; cv=none; b=VdMKu4GujZ/65DX/WvQc23eRQtyQBjF2Jl8ySM92z72XzYgbBjrRu0lkwy2mvx/LCZXyyCut0jF+MpnBgybvk0AjSbmAda9mFKF+it+SIj7JateTvuyuuPjdG9QDATlyxCjekGDA/7u6ynWsX51zyTZ0c1ghjAGJ7yIOY8SVVY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713885; c=relaxed/simple;
	bh=kDWx8HJ5pcPW4GHtShvRqjsoHx8LNnWgslfFUVcgEdI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MrX7nYx2VasDAa5doEwq/WZsr8fGIVmqmhv3l8JIxb5KU3xS/54HpgKgAHdhY2yT7weSoAis6QcngVQhCKrjqM5qKqWpvn4A8UdQqbg8i11HcmnoPISwLerFY6uyydYLL4Kch060TOJF6rRmpcE6XdNFwNw0P2sddX0BK+Y1VPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=wI+5SAfs; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 30DF83F1EE
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 09:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723713880;
	bh=F+qdP92HA4WlUvvWo4NLt2pIrqzc50ZjTRsittR4Q5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=wI+5SAfsFO6igR2nhLOu7aoRtoO/yay7AkZZvKm5yqKrdVBTZtoAdDq+DVwCExbdY
	 Wxzno4WL5zEDGuImZpxANEA5Hhxk7K5czjEsbTsiEkKWSSHVUgMd3e0tfaOtetB3s7
	 rnRMFS7vs5qBGwuCNl48EXt10qXDPAzAyJEtdQhuI7S9IV+/tIAx5cr7Ot7ut+zvk8
	 P6ViB2Sr3Z7Fax0WMlNq6YQmVyoeu4KDxyGwscBTU0Xk0xfqAoPVw8kZ+NAlNlBAFI
	 4khUUX6BI4lyQHSPZmeEZK08tZDMANWXUFAc5FV6d4sMRv6WYdHbNyAA0PffJNZKiO
	 oxSZb4hU7oDmw==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a7abaf0aecdso57440766b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 02:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723713880; x=1724318680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+qdP92HA4WlUvvWo4NLt2pIrqzc50ZjTRsittR4Q5I=;
        b=BWzYt0lZOlr8SVJ2Z+3z1+O/iHejyeWwk2Mqw/GAvmaHmcKpgOLK9FVjl5qEO086JK
         83wl+wTUus3m3dT5QlxU4vJ6FVr3n+n6PguIlRYQ4SwlG1xqGHrmeTf2AULKk1GnNTqw
         LBF+6xaLO9BvM5zsimD9Z83v5klrRSV1zbbeEu2rixRAZMmoWvvHqLrKMos0eJbOLEBw
         5SYwekIuyi01qxTpiXSCfJdkyXdEAk3iaBZuLeL3F+l6w8XSFcrY1aYZS+dB7oOcNRlY
         4K44bw4DwoiFtNOyjMwuCLi6S9gXnSa+PVofB4DHP+HkWn6ENjObxtm2D2DXN9/GOyM1
         eORw==
X-Forwarded-Encrypted: i=1; AJvYcCXXLLcvHzTuZ7NcCP55zQI9V4URu+eJifpXG3UYgq2N4ZIhlFJW9OZLnSKZnASa4akWMTWWKc2Vzbf+8smLp2d0adU7F9X9yLcX6cubRA==
X-Gm-Message-State: AOJu0YwMg2PocBtx41lydyNJvzSl12rCPgBJXMKxa97xC+4IS99LsAU4
	qjRPo5zGy8Vj/5HNTh/jr31SSbcePex7z3ibLWp/GBZDeBccd/pdInQJVG0KrAcCfBOyJ4cGfTk
	zkLnpRhgGYNysTWa73aHJDMdNvP1YodZ7yqv1hnqn0eY+COMETsQVMN5Zc2UpAwxVf4liD/TNLp
	V6EoU=
X-Received: by 2002:a17:906:d25a:b0:a6f:ddb3:bf2b with SMTP id a640c23a62f3a-a8366d6579amr387845266b.41.1723713879636;
        Thu, 15 Aug 2024 02:24:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR7X2VB9tXQi77mplbIxMONgPru0+ZsTVdiXwdUCAhLom3WOHWenFiTNXrJWvEw5b852CNeA==
X-Received: by 2002:a17:906:d25a:b0:a6f:ddb3:bf2b with SMTP id a640c23a62f3a-a8366d6579amr387843266b.41.1723713879100;
        Thu, 15 Aug 2024 02:24:39 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934585sm72142866b.107.2024.08.15.02.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 02:24:38 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Vivek Goyal <vgoyal@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/11] fuse: basic support for idmapped mounts
Date: Thu, 15 Aug 2024 11:24:17 +0200
Message-Id: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear friends,

This patch series aimed to provide support for idmapped mounts
for fuse & virtiofs. We already have idmapped mounts support for almost all
widely-used filesystems:
* local (ext4, btrfs, xfs, fat, vfat, ntfs3, squashfs, f2fs, erofs, ZFS (out-of-tree))
* network (ceph)

Git tree (based on torvalds/master):
v3: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts.v3
current: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts

Changelog for version 3:
- introduce and use a new SB_I_NOIDMAP flag (suggested by Christian)
- add support for virtiofs (+user space virtiofsd conversion)

Changelog for version 2:
- removed "fs/namespace: introduce fs_type->allow_idmap hook" and simplified logic
to return -EIO if a fuse daemon does not support idmapped mounts (suggested
by Christian Brauner)
- passed an "idmap" in more cases even when it's not necessary to simplify things (suggested
by Christian Brauner)
- take ->rename() RENAME_WHITEOUT into account and forbid it for idmapped mount case

Links to previous versions:
v2: https://lore.kernel.org/linux-fsdevel/20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com
tree: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts.v2
v1: https://lore.kernel.org/all/20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com/#r
tree: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts.v1

Having fuse (+virtiofs) supported looks like a good next step. At the same time
fuse conceptually close to the network filesystems and supporting it is
a quite challenging task.

Let me briefly explain what was done in this series and which obstacles we have.

With this series, you can use idmapped mounts with fuse if the following
conditions are met:
1. The filesystem daemon declares idmap support (new FUSE_INIT response feature
flags FUSE_OWNER_UID_GID_EXT and FUSE_ALLOW_IDMAP)
2. The filesystem superblock was mounted with the "default_permissions" parameter
3. The filesystem fuse daemon does not perform any UID/GID-based checks internally
and fully trusts the kernel to do that (yes, it's almost the same as 2.)

I have prepared a bunch of real-world examples of the user space modifications
that can be done to use this extension:
- libfuse support
https://github.com/mihalicyn/libfuse/commits/idmap_support
- fuse-overlayfs support:
https://github.com/mihalicyn/fuse-overlayfs/commits/idmap_support
- cephfs-fuse conversion example
https://github.com/mihalicyn/ceph/commits/fuse_idmap
- glusterfs conversion example (there is a conceptual issue)
https://github.com/mihalicyn/glusterfs/commits/fuse_idmap
- virtiofsd conversion example
https://gitlab.com/virtio-fs/virtiofsd/-/merge_requests/245

The glusterfs is a bit problematic, unfortunately, because even if the glusterfs
superblock was mounted with the "default_permissions" parameter (1 and 2 conditions
are satisfied), it fails to satisfy the 3rd condition. The glusterfs fuse daemon sends
caller UIDs/GIDs over the wire and all the permission checks are done twice (first
on the client side (in the fuse kernel module) and second on the glusterfs server side).
Just for demonstration's sake, I found a hacky (but working) solution for glusterfs
that disables these server-side permission checks (see [1]). This allows you to play
with the filesystem and idmapped mounts and it works just fine.

The problem described above is the main problem that we can meet when
working on idmapped mounts support for network-based filesystems (or network-like filesystems
like fuse). When people look at the idmapped mounts feature at first they tend to think
that idmaps are for faking caller UIDs/GIDs, but that's not the case. There was a big
discussion about this in the "ceph: support idmapped mounts" patch series [2], [3].
The brief outcome from this discussion is that we don't want and don't have to fool
filesystem code and map a caller's UID/GID everywhere, but only in VFS i_op's
which are provided with a "struct mnt_idmap *idmap"). For example ->lookup()
callback is not provided with it and that's on purpose! We don't expect the low-level
filesystem code to do any permissions checks inside this callback because everything
was already checked on the higher level (see may_lookup() helper). For local filesystems
this assumption works like a charm, but for network-based, unfortunately, not.
For example, the cephfs kernel client *always* send called UID/GID with *any* request
(->lookup included!) and then *may* (depending on the MDS configuration) perform any
permissions checks on the server side based on these values, which obviously leads
to issues/inconsistencies if VFS idmaps are involved.

Fuse filesystem very-very close to cephfs example, because we have req->in.h.uid/req->in.h.gid
and these values are present in all fuse requests and userspace may use them as it wants.

All of the above explains why we have a "default_permissions" requirement. If filesystem
does not use it, then permission checks will be widespread across all the i_op's like
->lookup, ->unlink, ->readlink instead of being consolidated in the one place (->permission callback).

In this series, my approach is the same as in cephfs [4], [5]. Don't touch req->in.h.uid/req->in.h.gid values
at all (because we can't properly idmap them as we don't have "struct mnt_idmap *idmap" everywhere),
instead, provide the userspace with a new optional (FUSE_OWNER_UID_GID_EXT) UID/GID suitable
only for ->mknod, ->mkdir, ->symlink, ->atomic_open and these values have to be used as the
owner UID and GID for newly created inodes.

Things to discuss:
- we enable idmapped mounts support only if "default_permissions" mode is enabled,
because otherwise, we would need to deal with UID/GID mappings on the userspace side OR
provide the userspace with idmapped req->in.h.uid/req->in.h.gid values which is not
something that we probably want to do. Idmapped mounts philosophy is not about faking
caller uid/gid.

How to play with it:
1. take any patched filesystem from the list (fuse-overlayfs, cephfs-fuse, glusterfs) and mount it
2. ./mount-idmapped --map-mount b:1000:0:2 /mnt/my_fuse_mount /mnt/my_fuse_mount_idmapped
(maps UID/GIDs as 1000 -> 0, 1001 -> 1)
[ taken from https://raw.githubusercontent.com/brauner/mount-idmapped/master/mount-idmapped.c ]

[1] https://github.com/mihalicyn/glusterfs/commit/ab3ec2c7cbe22618cba9cc94a52a492b1904d0b2
[2] https://lore.kernel.org/lkml/20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com/
[3] https://lore.kernel.org/lkml/CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThfzuibrhA3RKM=ZOYLg@mail.gmail.com/
[4] https://github.com/ceph/ceph/pull/52575
[5] https://lore.kernel.org/all/20230807132626.182101-4-aleksandr.mikhalitsyn@canonical.com/

Thanks!
Alex

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: German Maglione <gmaglione@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

Alexander Mikhalitsyn (11):
  fs/namespace: introduce SB_I_NOIDMAP flag
  fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
  fs/fuse: support idmap for mkdir/mknod/symlink/create
  fs/fuse: support idmapped getattr inode op
  fs/fuse: support idmapped ->permission inode op
  fs/fuse: support idmapped ->setattr op
  fs/fuse: drop idmap argument from __fuse_get_acl
  fs/fuse: support idmapped ->set_acl
  fs/fuse: properly handle idmapped ->rename op
  fs/fuse: allow idmapped mounts
  fs/fuse/virtio_fs: allow idmapped mounts

 fs/fuse/acl.c             |  10 ++-
 fs/fuse/dir.c             | 146 +++++++++++++++++++++++++-------------
 fs/fuse/file.c            |   2 +-
 fs/fuse/fuse_i.h          |   7 +-
 fs/fuse/inode.c           |  16 ++++-
 fs/fuse/virtio_fs.c       |   1 +
 fs/namespace.c            |   4 ++
 include/linux/fs.h        |   1 +
 include/uapi/linux/fuse.h |  24 ++++++-
 9 files changed, 148 insertions(+), 63 deletions(-)

-- 
2.34.1



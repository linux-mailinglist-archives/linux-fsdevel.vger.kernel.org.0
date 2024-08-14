Return-Path: <linux-fsdevel+bounces-25900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD282951A3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 13:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4D01C214C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 11:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD841B3F30;
	Wed, 14 Aug 2024 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="H5LHliWF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8DF1B29D2
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635683; cv=none; b=ZC8cMIWW1jxDMy/zxYTlB7jU15sxeDln1uGUFJAzK0LGjm2O+VF8Mi7cyU6cK2ON07HAB7DJm6LYQH9giXznqjH0CROWjZ21J+vhzAOZjIWXsFMDV7wQq5gL3bfIZfNvYABbFOpiYMRqXiBR3x9R0XpNGMYCQWex85iwf/HlC2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635683; c=relaxed/simple;
	bh=DswzfU6KA0ZLI/6fdLQwuYhRLpdqAPIp1+TrM2ShbjE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gX29VbmRftim82zbVHICaCzS4hAiznV9wce3ulxo9OYT9k0HWJusLAcAFZmPVVJL4Gm6BAIiw6q0gCUoiN+3/uHNxrPncO7uwArHSt7o8rA53m22Tf/UNdkG3JPTk74UjX+uelEZ9HfooaSbkT6eiyLYDRXWo8CkuGgL2Tvback=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=H5LHliWF; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 29180421F7
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723635679;
	bh=nSHDRYsJdX6GlnXtzUsYIpcgg3cxft1twVhFPobl7GY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=H5LHliWF9vT9W1rrK4blOorC5LMhslq6CYjhK3rg3I+CYL8Qa6AsuzkYGcTNvSbg5
	 njAAQ4Tjpdr/Ff97nNjCSJCGxjHZ2BM6SZE2rdBnU7P1f7sfM0HHzyR+Xq/IeKS3Tz
	 7yBbCDJkIDT1pKBQbNrw1DtZUSS05amdND5MRqwxEo7gOWEIqrAFgyQ3MVERVp3R4W
	 Tbv2u3Ly2aDUDbsPy06S1eA/zrJoXRrbMBW+87uNJy4nrhtvt1PNZAzOC3LVMcb2UD
	 V82DqOFYVSx3uu4Wxvv2o5rJIRhyLBWiAdk5uGIzBwpVMD1+GeYPk0XSjZY8hPiZfJ
	 4+kpvSRJ6+R3A==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7d63fbf4afso632243966b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 04:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635679; x=1724240479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSHDRYsJdX6GlnXtzUsYIpcgg3cxft1twVhFPobl7GY=;
        b=MAVwCAZKZkoMIEa7c/WbyGkQylIs7HjIkDMVX09wQKnjlhlx5gjoo3DK40LS8pRzXx
         +jZ21QT5FkNX8xOkuR6RKFVQz50dWDdyWp53Of1CzqO/cHuTBk7k5zp/pdL0WmJTJm+Y
         KaVJHMWHCo1Ov/g1ce9BKVP0R3wYdwmK2MA6q3jyu7XAZgqkVxTBQF8lnwqpLWD+F2jb
         qdQfb7m8QhRRwygmNpUhmXg79Zsl5GYQEe/btkrW+mRwt549XAHXHCtB4rX7/6CxI1gp
         CazISNf4sA5o7oo32GoxD3hM78pgitsS8yYzwpDzq/rF5jyFhlpBTjmQbcpNYlcZSWUR
         akJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiQ7JPS/KxUzTj4Pg/m25SsIW0DBmRVcC66nMmBjAqo733yD/U1LWvpRnApK+doLOFhhs1KtSEL2MRkgRC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx89MJSHmBdPTtNJ/S0RO5fagMCp8JuYkS8+FLigQ7ftl4LlMC+
	71y+KRrtBMi6ADY0aFSdInEqQZbPVsxuMlD+uwlvHjWglKAMqhWnGOighWe3mqXSl681IBELZqB
	I0TF/5PtUYURDt/ySxzMoDP1McJ21WhnupuDjcGUpopgMt9ni/qysGTehVDnby+VFznmFan3IKh
	jI1+M=
X-Received: by 2002:a17:906:c141:b0:a7d:a2cc:5d9 with SMTP id a640c23a62f3a-a83670e1ff7mr173150266b.65.1723635678530;
        Wed, 14 Aug 2024 04:41:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGotkpUpF6+IiOGS3UTz7EmrYzKqKjgcvWNyzXuF1PA1Ds28aPQeCnod3zU//fqsplXHt3pRg==
X-Received: by 2002:a17:906:c141:b0:a7d:a2cc:5d9 with SMTP id a640c23a62f3a-a83670e1ff7mr173148266b.65.1723635677918;
        Wed, 14 Aug 2024 04:41:17 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa782csm162586166b.60.2024.08.14.04.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:41:17 -0700 (PDT)
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
Subject: [PATCH v2 0/9] fuse: basic support for idmapped mounts
Date: Wed, 14 Aug 2024 13:40:25 +0200
Message-Id: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
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
for fuse. We already have idmapped mounts support for almost all
widely-used filesystems:
* local (ext4, btrfs, xfs, fat, vfat, ntfs3, squashfs, f2fs, erofs, ZFS (out-of-tree))
* network (ceph)

Git tree (based on torvalds/master):
v2: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts.v2
current: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts

Changelog for version 2:
- removed "fs/namespace: introduce fs_type->allow_idmap hook" and simplified logic
to return -EIO if a fuse daemon does not support idmapped mounts (suggested
by Christian Brauner)
- passed an "idmap" in more cases even when it's not necessary to simplify things (suggested
by Christian Brauner)
- take ->rename() RENAME_WHITEOUT into account and forbid it for idmapped mount case

Links to previous versions:
v1: https://lore.kernel.org/all/20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com/#r
tree: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts.v1

Having fuse supported looks like a good next step (before adding support for virtiofs). At the same time
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

Alexander Mikhalitsyn (9):
  fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
  fs/fuse: support idmap for mkdir/mknod/symlink/create
  fs/fuse: support idmapped getattr inode op
  fs/fuse: support idmapped ->permission inode op
  fs/fuse: support idmapped ->setattr op
  fs/fuse: drop idmap argument from __fuse_get_acl
  fs/fuse: support idmapped ->set_acl
  fs/fuse: properly handle idmapped ->rename op
  fs/fuse: allow idmapped mounts

 fs/fuse/acl.c             |  10 ++-
 fs/fuse/dir.c             | 146 +++++++++++++++++++++++++-------------
 fs/fuse/file.c            |   2 +-
 fs/fuse/fuse_i.h          |  10 ++-
 fs/fuse/inode.c           |  15 +++-
 include/uapi/linux/fuse.h |  24 ++++++-
 6 files changed, 144 insertions(+), 63 deletions(-)

-- 
2.34.1



Return-Path: <linux-fsdevel+bounces-26251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B105C95695B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 13:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39FF1C21776
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 11:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F9F166F07;
	Mon, 19 Aug 2024 11:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knU8H7w5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8B614A4C1;
	Mon, 19 Aug 2024 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067254; cv=none; b=sFEr0XdgAJD2qeSaHD0StRghgt9LGbZuMewlj2PTk902Auuwn5pW7Flney7B5msKfeYu815zovTIKzhWpXbsEiO4s9W7Mw0XLV4hJ+l7Rr4xJaTnj6JT+6ZEEH4jbnwxEMUcFYLDVz5kobpRXRW9axtGnSAxVtKz8XgfwI2NHvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067254; c=relaxed/simple;
	bh=YXi9NAgWSVmNDA5StGAeBv7D+2Dt2es1sfEne8hWFvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ak4FQo4+Vs+mgEUYLtqCF+KI4QN7BjDIMygXseoiGg0CVnxnMHF6SvuXOSr/9P4EFi9nKnkoMAeX+HUBMiaJlev2m85Ljfc4xTff1ibuueiA1i/1GcCD0joqVWifFng+HqiFJbrDbal6GX/BmGqrbc5OEkZtWM/taJ6egEMAnRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knU8H7w5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE644C32782;
	Mon, 19 Aug 2024 11:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724067253;
	bh=YXi9NAgWSVmNDA5StGAeBv7D+2Dt2es1sfEne8hWFvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=knU8H7w5bmbmD1FsfCzRaumh8OZuzBjcpDBNLJCWz1h1B6WSP+06lhbUxhHeHVHBu
	 gimGxKj5JeTaB885YKG5tFW6loFtqThmUXnMPhpNr4k0vsgfxYq9I1ubnbJ3gliQqD
	 sIFnTzd33k869VbBP3wNuIG5T+uBaDJngYZ2IZ0vrncwH8EAZa0E20Xnx1X+aA5V9u
	 iZtk6E7092tNe/YcZ3auoI5iUlghftju5191o32oUxEntdP1OOAVGzc3EbUi5RgZw7
	 IW+ieq1A4MCt9AqUcGr1U4hYnX2XrbpYIWTCTkWISMyJ/MHCC2QbOKdt66zF9PNlaw
	 QgfUJqoitpBgw==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: Christian Brauner <brauner@kernel.org>,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Vivek Goyal <vgoyal@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	linux-kernel@vger.kernel.org,
	mszeredi@redhat.com
Subject: Re: [PATCH v3 00/11] fuse: basic support for idmapped mounts
Date: Mon, 19 Aug 2024 13:34:04 +0200
Message-ID: <20240819-rockermilieu-baumhaus-02b54f20d530@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2469; i=brauner@kernel.org; h=from:subject:message-id; bh=YXi9NAgWSVmNDA5StGAeBv7D+2Dt2es1sfEne8hWFvk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQd1l3bHey39knblth5X7t5E+fW9iRP873q8mTKqY0M+ xl3sMjP6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI9DiG/5WCq/5ydLgv6VlQ knRI+Nn5E96V5sl/+pnC5u668E3041ZGhlVzJqUczdkVo/M7Jvrnr91SJfnV/7adXK3Alq95dv6 eC/wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 15 Aug 2024 11:24:17 +0200, Alexander Mikhalitsyn wrote:
> This patch series aimed to provide support for idmapped mounts
> for fuse & virtiofs. We already have idmapped mounts support for almost all
> widely-used filesystems:
> * local (ext4, btrfs, xfs, fat, vfat, ntfs3, squashfs, f2fs, erofs, ZFS (out-of-tree))
> * network (ceph)
> 
> Git tree (based on torvalds/master):
> v3: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts.v3
> current: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts
> 
> [...]

I've taken this but can drop should it need to end up in a fuse tree.

---

Applied to the vfs.idmap branch of the vfs/vfs.git tree.
Patches in the vfs.idmap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.idmap

[01/11] fs/namespace: introduce SB_I_NOIDMAP flag
        https://git.kernel.org/vfs/vfs/c/cc3e8969ffb2
[02/11] fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
        https://git.kernel.org/vfs/vfs/c/d2c5937035e5
[03/11] fs/fuse: support idmap for mkdir/mknod/symlink/create
        https://git.kernel.org/vfs/vfs/c/9961d396252b
[04/11] fs/fuse: support idmapped getattr inode op
        https://git.kernel.org/vfs/vfs/c/52dfd148ff75
[05/11] fs/fuse: support idmapped ->permission inode op
        https://git.kernel.org/vfs/vfs/c/34ddf0de71be
[06/11] fs/fuse: support idmapped ->setattr op
        https://git.kernel.org/vfs/vfs/c/27b622529cdc
[07/11] fs/fuse: drop idmap argument from __fuse_get_acl
        https://git.kernel.org/vfs/vfs/c/6d8f2f4fde13
[08/11] fs/fuse: support idmapped ->set_acl
        https://git.kernel.org/vfs/vfs/c/ab7c30987cbb
[09/11] fs/fuse: properly handle idmapped ->rename op
        https://git.kernel.org/vfs/vfs/c/76c0baad3782
[10/11] fs/fuse: allow idmapped mounts
        https://git.kernel.org/vfs/vfs/c/9aace2eda1bd
[11/11] fs/fuse/virtio_fs: allow idmapped mounts
        https://git.kernel.org/vfs/vfs/c/020a698f136c


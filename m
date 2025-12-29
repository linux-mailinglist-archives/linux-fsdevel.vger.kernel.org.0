Return-Path: <linux-fsdevel+bounces-72193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 354C1CE7338
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 16:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7875C300D148
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921C432ABF6;
	Mon, 29 Dec 2025 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiB5MFsf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0101E8826
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767021870; cv=none; b=muHgWiIJSwgAwmkqtKJPmXIoJQ4klIv2Sh4bHbsD3Iepvfbg3WCQElt4wfEppQP8yzJ5oX0IH++wdIm6oZJg3GTyyacy2XATC0mwxZ7oYpd1BvO1jXjyzySbX1QYqXqdh+kpaj6QOZB9c1fTBa6MoSj1hX9HTvUNfqDO7zFigRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767021870; c=relaxed/simple;
	bh=zSTlG/uN8qWkOw3969usdIxNp3flPOausILVPnXmSpg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=be8mfF6P6mFdSHpygFe6Zgy+GNXZOYFifpkTa9jrjEqlrv5PNKT4JpOJVqvAPAMcik5QwgSrpBbEmFj+LtqX4aVcnjIZAnl3zAODfWkQlz9h6eHgVe7cXLQRGG044a83Eb2GYZgD1CaZx6YjJDgp6FrPTbZKg+YjP6UlE5BXPqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiB5MFsf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29DCC116C6;
	Mon, 29 Dec 2025 15:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767021869;
	bh=zSTlG/uN8qWkOw3969usdIxNp3flPOausILVPnXmSpg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YiB5MFsf2pSKl1nfdIlKr+bhas4UkvT4XP9tRl0NbfJl4yMwwbeLbTumNtEvSvqPH
	 MwnbqCAm9sU4JdnSy24o5/uR/fOeftDnqvuCe5dCJYvHzWQwEf6wslT1eTGDrjhIp6
	 s9zEUaxq1axyyQwiTEHJdnLcID2p34qzkiOVqmNNAwiYaWQcAzpzmrKehLvGsnvyAW
	 zzcZNpqGKoeBOlFSZMhJzfkcMBzFs1pnBpz1p15MaCddrF3ietjAw+vkU168P2PCZt
	 3eVkF1AmM14Qrf4dNyZ7oUHWNKNQw7eNYMj7Xcs4hBUNzWn/+7vBuS3nvQlAAxiu3v
	 h60sSgHfYpt2A==
Message-ID: <8c263e7031ecb7f2629cdf12a0e680473449c1d0.camel@kernel.org>
Subject: Re: [PATCH 0/2] mount: add OPEN_TREE_NAMESPACE
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Amir Goldstein	
 <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, Jan Kara
 <jack@suse.cz>,  Aleksa Sarai <cyphar@cyphar.com>
Date: Mon, 29 Dec 2025 10:24:27 -0500
In-Reply-To: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
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

On Mon, 2025-12-29 at 14:03 +0100, Christian Brauner wrote:
> When creating containers the setup usually involves using CLONE_NEWNS
> via clone3() or unshare(). This copies the caller's complete mount
> namespace. The runtime will also assemble a new rootfs and then use
> pivot_root() to switch the old mount tree with the new rootfs. Afterward
> it will recursively umount the old mount tree thereby getting rid of all
> mounts.
>=20
> On a basic system here where the mount table isn't particularly large
> this still copies about 30 mounts. Copying all of these mounts only to
> get rid of them later is pretty wasteful.
>=20
> This is exacerbated if intermediary mount namespaces are used that only
> exist for a very short amount of time and are immediately destroyed
> again causing a ton of mounts to be copied and destroyed needlessly.
>=20
> With a large mount table and a system where thousands or ten-thousands
> of namespaces are spawned in parallel this quickly becomes a bottleneck
> increasing contention on the semaphore.
>=20
> Extend open_tree() with a new OPEN_TREE_NAMESPACE flag. Similar to
> OPEN_TREE_CLONE only the indicated mount tree is copied. Instead of
> returning a file descriptor referring to that mount tree
> OPEN_TREE_NAMESPACE will cause open_tree() to return a file descriptor
> to a new mount namespace. In that new mount namespace the copied mount
> tree has been mounted on top of a copy of the real rootfs.
>=20
> The caller can setns() into that mount namespace and perform any
> additionally setup such as move_mount()ing detached mounts in there.
>=20
> This allows OPEN_TREE_NAMESPACE to function as a combined
> unshare(CLONE_NEWNS) and pivot_root().
>=20
> A caller may for example choose to create an extremely minimal rootfs:
>=20
> fd_mntns =3D open_tree(-EBADF, "/var/lib/containers/wootwoot", OPEN_TREE_=
NAMESPACE);
>=20
> This will create a mount namespace where "wootwoot" has become the
> rootfs mounted on top of the real rootfs. The caller can now setns()
> into this new mount namespace and assemble additional mounts.
>=20
> This also works with user namespaces:
>=20
> unshare(CLONE_NEWUSER);
> fd_mntns =3D open_tree(-EBADF, "/var/lib/containers/wootwoot", OPEN_TREE_=
NAMESPACE);
>=20
> which creates a new mount namespace owned by the earlier created user
> namespace with "wootwoot" as the rootfs mounted on top of the real
> rootfs.
>=20
> This will scale a lot better when creating tons of mount namespaces and
> will allow to get rid of a lot of unnecessary mount and umount cycles.
> It also allows to create mount namespaces without needing to spawn
> throwaway helper processes.
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Christian Brauner (2):
>       mount: add OPEN_TREE_NAMESPACE
>       selftests/open_tree: add OPEN_TREE_NAMESPACE tests
>=20
>  fs/internal.h                                      |    1 +
>  fs/namespace.c                                     |  155 ++-
>  fs/nsfs.c                                          |   13 +
>  include/uapi/linux/mount.h                         |    3 +-
>  .../selftests/filesystems/open_tree_ns/.gitignore  |    1 +
>  .../selftests/filesystems/open_tree_ns/Makefile    |   10 +
>  .../filesystems/open_tree_ns/open_tree_ns_test.c   | 1030 ++++++++++++++=
++++++
>  tools/testing/selftests/filesystems/utils.c        |   26 +
>  tools/testing/selftests/filesystems/utils.h        |    1 +
>  9 files changed, 1223 insertions(+), 17 deletions(-)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251229-work-empty-namespace-352a9c2dfe0a

Thanks Christian,

This looks really cool.=C2=A0FWIW, I had a discussion at LPC with Aleksa an=
d
Christian a few weeks ago about the performance problems we were seeing
with spawning a lot of containers in parallel. Cloning a mount
namespace is rather expensive and involves global locks. Hopefully this
would help reduce the contention for them.

I'm on holiday until next week, but I'll plan to play with this when I
get back, and see how it performs vs. the traditional
unshare()/pivot_root().

Cheers!
--=20
Jeff Layton <jlayton@kernel.org>


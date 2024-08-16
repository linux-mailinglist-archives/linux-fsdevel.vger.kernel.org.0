Return-Path: <linux-fsdevel+bounces-26096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21012954397
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 10:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD471F211E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 08:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B1B12CDB0;
	Fri, 16 Aug 2024 08:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHLuEOFP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC8818EAD;
	Fri, 16 Aug 2024 08:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723795321; cv=none; b=egdwT4DT4XNYAyqVPYFwBh1Ps8yn5WcJLUpBz4EHJ+eEBoHetO1tjOlV70pYFAHOi3cZa87VG1m6nNSKGGwC043hIRRzeN0XxwN5HL67oGJmwB+L4cySI4eqFjzMTIfTkomlwRbUhXPKXhtzzS67o+ZB8Pv9Y9KZOjl1qCvzfSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723795321; c=relaxed/simple;
	bh=ZAEFHDb6nfDvtfjvytP1Pe7+5IPhC5D9b1gSpHCIdk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTsJP5bV08YKCj80B7FKbgS0Ib1B2GXtY/ergQmNACGLrFSlLFEjykd8pXjfQrD9/xT2yMwpFhp5Nut6iMj+NHqLgMSI9cxZz+TKyxC2MaBo1kfZlD9tfjdt4A5sJhQtIwGSuhmQZqL3HR32qVr+aI2FjwiXcYoUk73U1mepFFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHLuEOFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F5FC32782;
	Fri, 16 Aug 2024 08:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723795319;
	bh=ZAEFHDb6nfDvtfjvytP1Pe7+5IPhC5D9b1gSpHCIdk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kHLuEOFPl3gcYHmz1X8Kuvu7uHUygTwY8iv5LaoJKIulu7/x3W83Zqgdp0B9E8fzz
	 QbiopZaeFTbvn5bizCO35RV8A5nmuPqmE3soUahmEgF63Kl7EzISzBfhD+dKG27lsy
	 EYZHQtfOjt68viXnTQC6AqHYMQadRslHVaDWBPFUZ7ajVR5RElmO67fszd3sKIoJMl
	 /+ALWyTw38A/sLm4iyqVrlLuero++mfi1ZvBAEUMLKayZHILqgmv7l/HaiW0C0gRUh
	 B6nJlmXSXiMm5Jb/a8gxCMrLKVvCw3/5DjHvc/W1OgcgfnQatT7G9uuSoAW2l09lon
	 ntAAoCZ2f/QGA==
Date: Fri, 16 Aug 2024 10:01:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, stgraber@stgraber.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>, 
	German Maglione <gmaglione@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/11] fuse: basic support for idmapped mounts
Message-ID: <20240815-ehemaligen-duftstoffe-a5f2ab60ddc9@brauner>
References: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>

On Thu, Aug 15, 2024 at 11:24:17AM GMT, Alexander Mikhalitsyn wrote:
> Dear friends,
> 
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
> Changelog for version 3:
> - introduce and use a new SB_I_NOIDMAP flag (suggested by Christian)
> - add support for virtiofs (+user space virtiofsd conversion)
> 
> Changelog for version 2:
> - removed "fs/namespace: introduce fs_type->allow_idmap hook" and simplified logic
> to return -EIO if a fuse daemon does not support idmapped mounts (suggested
> by Christian Brauner)
> - passed an "idmap" in more cases even when it's not necessary to simplify things (suggested
> by Christian Brauner)
> - take ->rename() RENAME_WHITEOUT into account and forbid it for idmapped mount case
> 
> Links to previous versions:
> v2: https://lore.kernel.org/linux-fsdevel/20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com
> tree: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts.v2
> v1: https://lore.kernel.org/all/20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com/#r
> tree: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts.v1
> 
> Having fuse (+virtiofs) supported looks like a good next step. At the same time
> fuse conceptually close to the network filesystems and supporting it is
> a quite challenging task.
> 
> Let me briefly explain what was done in this series and which obstacles we have.
> 
> With this series, you can use idmapped mounts with fuse if the following
> conditions are met:
> 1. The filesystem daemon declares idmap support (new FUSE_INIT response feature
> flags FUSE_OWNER_UID_GID_EXT and FUSE_ALLOW_IDMAP)
> 2. The filesystem superblock was mounted with the "default_permissions" parameter
> 3. The filesystem fuse daemon does not perform any UID/GID-based checks internally
> and fully trusts the kernel to do that (yes, it's almost the same as 2.)
> 
> I have prepared a bunch of real-world examples of the user space modifications
> that can be done to use this extension:
> - libfuse support
> https://github.com/mihalicyn/libfuse/commits/idmap_support
> - fuse-overlayfs support:
> https://github.com/mihalicyn/fuse-overlayfs/commits/idmap_support
> - cephfs-fuse conversion example
> https://github.com/mihalicyn/ceph/commits/fuse_idmap
> - glusterfs conversion example (there is a conceptual issue)
> https://github.com/mihalicyn/glusterfs/commits/fuse_idmap
> - virtiofsd conversion example
> https://gitlab.com/virtio-fs/virtiofsd/-/merge_requests/245

So I have no further comments on this and from my perspective this is:

Reviewed-by: Christian Brauner <brauner@kernel.org>

I would really like to see tests for this feature as this is available
to unprivileged users.


Return-Path: <linux-fsdevel+bounces-63005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D35C3BA8A2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 11:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D8D04E0386
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 09:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4592D372E;
	Mon, 29 Sep 2025 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1E0bFEF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DFD2C21E2;
	Mon, 29 Sep 2025 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138241; cv=none; b=OI9gZ+n3fsg5k3trW0j7Bz7/dyr8zGdZ+1C8Scz0K3BePiZhhSeUdNaYoWJgj2asRkB5Xox+GkwASvWC59JYIAxNQAqS9pDeHrtVQkv9QVxTJVZWzKxbVFBxV1E0QoIpGCu2jrNGQi/idNyrxKGnAITwFi8/8jvLnhuj8qGpRKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138241; c=relaxed/simple;
	bh=BKoHIf138/hk6lID8rDiMQKSjSDMPFy5kMeGNrQHa04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUZFIF8SjISX6IHW3VziwETxtqt79TSaN2SAzx7BlRX5AetkmQnu/BDUFbQed2BKEgEQll6M5JfQzb1ERr8WqKqEjktXso/mtkrLqkSnemz0dVCAs9XDx0AwK3yZ6tR2RTLBvUZHLVE4qsbFEHlplQMXJGjQ9xaeKhAGwFcnK8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1E0bFEF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851E1C4CEF4;
	Mon, 29 Sep 2025 09:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759138241;
	bh=BKoHIf138/hk6lID8rDiMQKSjSDMPFy5kMeGNrQHa04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F1E0bFEFCiAXU2bhcNOwjJji/CUotsAqJvRtzFFy/aiEKsKjYjjOZvuLL1tKGA6kP
	 vxBHVvvTVrgrl1/QyFhyyjW0rZS1zdqq6CEfPxPGxs7qdLJukbjh3fvKIl1mg6RnoZ
	 ODxxKZFAwse7zViONdtFCW5T8h6Tis9KW6gk+6D7VKOstEz98e9zuVaMKiILkEM3JD
	 5qSe77Ehh7DHt4kmv/KaZvKr0hh1uDu9D5Jy0v+3MdltzMwFNq7v7slLy4dGyiPW3t
	 NxK+gBALjPugIX+bPaVh7k75QrAsWD6QY+id3CF9d50CUXAugTdT0kfdk0Q5w95uX9
	 lZLFSjxC3iJfg==
Date: Mon, 29 Sep 2025 11:30:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com, 
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v6 3/4] Manual conversion of ->i_state uses
Message-ID: <20250929-babysitten-weinlaune-9cf5da52b8b2@brauner>
References: <20250923104710.2973493-1-mjguzik@gmail.com>
 <20250923104710.2973493-4-mjguzik@gmail.com>
 <CAGudoHGuFSfSCZcoky+5wX1QfVpg-tj42c2SJijfT7ke_6tR7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGudoHGuFSfSCZcoky+5wX1QfVpg-tj42c2SJijfT7ke_6tR7Q@mail.gmail.com>

On Thu, Sep 25, 2025 at 12:07:13PM +0200, Mateusz Guzik wrote:
> allmodconfig build was done on this patchset but somehow one failure was missed:
> 
> diff --git a/fs/afs/inode.c b/fs/afs/inode.c
> index e9538e91f848..71ec043f7569 100644
> --- a/fs/afs/inode.c
> +++ b/fs/afs/inode.c
> @@ -427,7 +427,7 @@ static void afs_fetch_status_success(struct
> afs_operation *op)
>         struct afs_vnode *vnode = vp->vnode;
>         int ret;
> 
> -       if (vnode->netfs.inode.i_state & I_NEW) {
> +       if (inode_state_read(&vnode->netfs.inode) & I_NEW) {
>                 ret = afs_inode_init_from_status(op, vp, vnode);
>                 afs_op_set_error(op, ret);
>                 if (ret == 0)
> 
> 
> I reran the thing with this bit and now it's all clean. I think this
> can be folded into the manual fixup patch (the one i'm responding to)
> instead of resending the patchset

Folded, thanks!


Return-Path: <linux-fsdevel+bounces-66347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EBAC1C877
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 18:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71AA94E3C8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8962351FAE;
	Wed, 29 Oct 2025 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAg86qKt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62DA2773E5;
	Wed, 29 Oct 2025 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759513; cv=none; b=n5yL8eV1VD51foNGkDzdsBVfEOPxSe9WlV0JCTBTF3RFPTL6vDPi91vb0Nvq0Y0srRoUtctm6463CfPKdmyW0JlSmPJvNbSVMAelPcBPGxdVEa7xMABjst0EwzKFQlr2A4Kqqfy4jx6DKLedfn+kDMZwP/HGqhykBPxtUwogq04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759513; c=relaxed/simple;
	bh=+uAC38QGjgt9TT9rzHSt8a3n8yUaKFUw/CK9H/8jK7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgnkQe0Skx/vdcnzuA37Kpfp2u/2RJWLZqai8Ycfsljman+wc6UAnGP8KtKljHOqNMy+r3NUj8z/Aw5TmlkvTqXuxz8GjS7f9e10xP7qQxtVh416deLWYnvcEt0tL9u6SX7X42NQJqbw6b8Avwv1cIdFHPcSjXfQSSy0ZZKoeXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAg86qKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4972C4CEF8;
	Wed, 29 Oct 2025 17:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761759512;
	bh=+uAC38QGjgt9TT9rzHSt8a3n8yUaKFUw/CK9H/8jK7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iAg86qKtcUF7SwOCG5CYz4/LkLiRVXsNba8kWRDITlr1wz0MThf9QSA9e9tE0ZAoJ
	 mH6Ekh3UX0quX2gnFfqmCfeVcKLCXLqkmQW1RA+9ESzuy7JWNt+NupJfkOdnGHdN+J
	 YnLk3aOE7zBT730iTjzSEX9Q20mOi3SuLsbIUUjIFoE862qloLGx++NbeOe6AwrOZb
	 MsndmdjRvX7i7AVby32QYxwL0Nc66122En+/3F3SS001GTuInW/PxL1/RINHtRJ0Sx
	 4XAMp1v/dTUzfTERtUaZRndRDahg2O4pd9ealuGHwppbGMriaZOic6Z/AV4ihRJnFC
	 Mzx8m08axogag==
Date: Wed, 29 Oct 2025 10:38:28 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] fs/pipe: stop duplicating union pipe_index declaration
Message-ID: <20251029173828.GA1669504@ax162>
References: <20251023082142.2104456-1-linux@rasmusvillemoes.dk>
 <20251029-redezeit-reitz-1fa3f3b4e171@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-redezeit-reitz-1fa3f3b4e171@brauner>

Hi Christian,

On Wed, Oct 29, 2025 at 02:41:06PM +0100, Christian Brauner wrote:
> On Thu, 23 Oct 2025 10:21:42 +0200, Rasmus Villemoes wrote:
> > Now that we build with -fms-extensions, union pipe_index can be
> > included as an anonymous member in struct pipe_inode_info, avoiding
> > the duplication.
> > 
> > 
> 
> Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-6.19.misc branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.19.misc
> 
> [1/1] fs/pipe: stop duplicating union pipe_index declaration
>       https://git.kernel.org/vfs/vfs/c/ade24f8214fe

As you may have noticed since I do not actually see this pushed, this
change requires the '-fms-extensions' change that we are carrying in the
kbuild tree for 6.19.

  https://git.kernel.org/kbuild/c/778740ee2d00e5c04d0c8ffd9c3beea89b1ec554

Would you be okay with us carrying this change there as well with your
Ack? Once '-fms-extensions' makes it into 6.19-rc1, you should be free
to make any other changes like this.

Cheers,
Nathan


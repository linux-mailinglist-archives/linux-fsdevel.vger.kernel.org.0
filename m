Return-Path: <linux-fsdevel+bounces-14421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9473487C7D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 04:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DC35B224CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 03:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04B4D299;
	Fri, 15 Mar 2024 03:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBMOJdHJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06914323D;
	Fri, 15 Mar 2024 03:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710471816; cv=none; b=azultoN87e5dYIjxtEtb4HkGtUKDkfYiUw5vK/rvCPSKlTiJob8vU+Q0kBY2d4Uw6r7Vvueb+1OEQt+4QrRlAIETBOW4Q99/pYXD8hYxQeyCFoY03k+a4jeNu5c41bavDZQBFxlY+rYOc5srMgFVsH7EbPP+B+M6rD2bYXsB+7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710471816; c=relaxed/simple;
	bh=SPAiD+gNmMZ6VPPTpT74GlegJX+PLefRttBB2GafSFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjoybK/NI9vGSkKO2j9fXI2g3i8NqY56J0IcN7IuAybjKeHXbG1MP1HkrvH1owWIuiw32sz3vRPRj1t9f/Spf6qxINasuheqAg7KntBIYd58vvIr5oY0pmoNhFIacLFawUw3gyYBV9VvQkZqawsH8iI1yKm+4ByS+uXAKONGWEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBMOJdHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E17AC433F1;
	Fri, 15 Mar 2024 03:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710471815;
	bh=SPAiD+gNmMZ6VPPTpT74GlegJX+PLefRttBB2GafSFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MBMOJdHJiQ6QvqSDDofBdpjnYI2zM4M0e4xamcU0kd4tG92Yd0CG1BsOCp1ou871q
	 K3ljP6OYBumQvQ4faTxJ+dg0aNmPqgqsXwOmIBTrLqabRXOwC9ReElSaD8Cenxw4EE
	 Xavb/a6kBxkuJcZbanIK4NYSGZYfe+MdynlXRwMYsB2AEpkQ0XRo/eUImTq8mrfPkW
	 RLEJt6xXh28LAkxu0SPTfDzAZh9wZlzBQEPThCJEsds5pmNYZ2DmwS8MxMAo2t8VOc
	 WZYYpHxyzugKRrwrwF1GETF8e7RA39l5zsS5OB1B4nPrHn3+e4QtjsnYqrKyQZV3JO
	 CrEN16YHXtdDg==
Date: Thu, 14 Mar 2024 20:03:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: corbet@lwn.net, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	clm@meta.com, dsterba@suse.com, josef@toxicpanda.com,
	jbacik@toxicpanda.com, kernel-team@meta.com
Subject: Re: [PATCH 0/3] fiemap extension to add physical extent length
Message-ID: <20240315030334.GQ6184@frogsfrogsfrogs>
References: <cover.1709918025.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1709918025.git.sweettea-kernel@dorminy.me>

On Fri, Mar 08, 2024 at 01:03:17PM -0500, Sweet Tea Dorminy wrote:
> For many years, various btrfs users have written programs to discover
> the actual disk space used by files, using root-only interfaces.
> However, this information is a great fit for fiemap: it is inherently
> tied to extent information, all filesystems can use it, and the
> capabilities required for FIEMAP make sense for this additional
> information also.
> 
> Hence, this patchset adds physical extent length information to fiemap,
> and extends btrfs to return it.  This uses some of the reserved padding
> in the fiemap extent structure, so programs unaware of the new field
> will be unaffected by its presence.
> 
> This is based on next-20240307. I've tested the btrfs part of this with
> the standard btrfs testing matrix locally, and verified that the physical extent
> information returned there is correct, but I'm still waiting on more
> tests. Please let me know what you think of the general idea!

Seems useful!  Any chance you'd be willing to pick up this old proposal
to report the dev_t through iomap?  iirc the iomap wrappers for fiemap
can export that pretty easily.

https://lore.kernel.org/linux-fsdevel/20190211094306.fjr6gfehcstm7eqq@hades.usersys.redhat.com/

(Not sure what we do for pmem filesystems)

--D

> Sweet Tea Dorminy (3):
>   fs: add physical_length field to fiemap extents
>   fs: update fiemap_fill_next_extent() signature
>   btrfs: fiemap: return extent physical size
> 
>  Documentation/filesystems/fiemap.rst | 29 +++++++++----
>  fs/bcachefs/fs.c                     |  6 ++-
>  fs/btrfs/extent_io.c                 | 63 +++++++++++++++++-----------
>  fs/ext4/extents.c                    |  1 +
>  fs/f2fs/data.c                       |  8 ++--
>  fs/f2fs/inline.c                     |  3 +-
>  fs/ioctl.c                           |  8 ++--
>  fs/iomap/fiemap.c                    |  2 +-
>  fs/nilfs2/inode.c                    |  8 ++--
>  fs/ntfs3/frecord.c                   |  6 ++-
>  fs/ocfs2/extent_map.c                |  4 +-
>  fs/smb/client/smb2ops.c              |  1 +
>  include/linux/fiemap.h               |  2 +-
>  include/uapi/linux/fiemap.h          | 24 +++++++----
>  14 files changed, 108 insertions(+), 57 deletions(-)
> 
> 
> base-commit: 1843e16d2df9d98427ef8045589571749d627cf7
> -- 
> 2.44.0
> 
> 


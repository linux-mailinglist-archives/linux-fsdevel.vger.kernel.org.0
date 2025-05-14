Return-Path: <linux-fsdevel+bounces-48982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EABC2AB7138
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 18:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DDA94C6DF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 16:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610962797A0;
	Wed, 14 May 2025 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o66krTWH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD53A1AC458;
	Wed, 14 May 2025 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747239874; cv=none; b=QeWCXkf46kIEnCMswmgkItUnr5lYyN+rVVL7gIF+D0SvTdu7x5uQjwIha1vg4t/0DwmGRV5dohtZ7scm6aSzVhKNPa41oOPxdkwY0BnQQy9biber5KaF/u7LR2uJhZiXoz0d3ENyQtufdxwH561m1zlmrVd7KapKl8tgPnXVBRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747239874; c=relaxed/simple;
	bh=hwrr3LREsGIk4GdJ/G+dLDh/ub5qyvihYIVAWgCOI5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBVTo6yJWWQsarp4PMgcZao+EIuUf3CBbF4IvpSXEyZ80hNLY0QVMiqjrUwNmDTFsXOxUtR7DuqqCLGtVo2xrLO+K/MCoKKml1MryyGINVxsZj686Y5LV4pO9oJEVLVTW2uv6R42PWk6WKDqSBr383M/W23BDkQE4UebmWgzac0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o66krTWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CECC4CEE3;
	Wed, 14 May 2025 16:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747239874;
	bh=hwrr3LREsGIk4GdJ/G+dLDh/ub5qyvihYIVAWgCOI5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o66krTWHqmQywhHnyr8t6z5e4CMrjqtWacZxi709qjjuVa5C7qddImtiODE6q21oh
	 5s9/nTM7vdHy9MWxOUlefKggYf12VyLoxVqRAYaCMl0N9H0o5IkN3jmgiTnGVC2kme
	 YHB4INcajnW1pMrujd2c8gleA5tXOkVpH1oGFoxU+JrdFdVezU/Z27U6zOip4nkbSj
	 EFGh4cAN7qkiDJrn6Vlj06umpIowfP7xU9v6eeA4VeJNInQ7OX175+c5db2ZINynrV
	 jsl6qo5ZlIS9FKAvqCmUbdvtpIfzbppsDpNGP1ujR0AuzQfoPdux8cZ8iIh2PACgZo
	 L96fFgFTunmbA==
Date: Wed, 14 May 2025 09:24:33 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] ext4: Check if inode uses extents in
 ext4_inode_can_atomic_write()
Message-ID: <20250514162433.GK25655@frogsfrogsfrogs>
References: <cover.1746734745.git.ritesh.list@gmail.com>
 <f6592ee7a4fc862d19806e4ab9e4a4ea316c4f9b.1746734745.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6592ee7a4fc862d19806e4ab9e4a4ea316c4f9b.1746734745.git.ritesh.list@gmail.com>

On Fri, May 09, 2025 at 02:20:32AM +0530, Ritesh Harjani (IBM) wrote:
> EXT4 only supports doing atomic write on inodes which uses extents, so
> add a check in ext4_inode_can_atomic_write() which gets called during
> open.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Makes sense seeing as advertising the awu geometry is gated on the
filesystem having extents turned on...

Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/ext4/ext4.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 5a20e9cd7184..c0240f6f6491 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3847,7 +3847,9 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
>  static inline bool ext4_inode_can_atomic_write(struct inode *inode)
>  {
>  
> -	return S_ISREG(inode->i_mode) && EXT4_SB(inode->i_sb)->s_awu_min > 0;
> +	return S_ISREG(inode->i_mode) &&
> +		ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS) &&
> +		EXT4_SB(inode->i_sb)->s_awu_min > 0;
>  }
>  
>  extern int ext4_block_write_begin(handle_t *handle, struct folio *folio,
> -- 
> 2.49.0
> 
> 


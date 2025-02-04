Return-Path: <linux-fsdevel+bounces-40829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C34A27E5C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D561164E18
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 22:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7397721B90B;
	Tue,  4 Feb 2025 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2VUPcvw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C376221ADD7;
	Tue,  4 Feb 2025 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738708582; cv=none; b=TcXLgHh3ty9WTfK3B8iVf3de1n0itqzsZs8NyZYIKDjXDMlOnIQmk262fLgTQTv6b8OR/ybtkbm1lcx6H8gluNjYBpr4ojlAeBFXJTPKxcZiTgKHOBwE/4ZQH/pEmJiBt9HfSH2+Z+rwhij6bmAtYSh7k8Hv/vTjzKUBfL5BsTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738708582; c=relaxed/simple;
	bh=GUyS2ieEh/RbxEBcCpkqFVL7Ad+lb8Bs6CbqQ6XWHu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcFZotVOI/i8I9jl9cm5839MhJgmhofmy6efwL+UW7ViIYbAMS7ixVLsXFLD3DyPgwVkJ51qsJVHiJk1xnrV+RBhhKlS85nrl2y7S64pg8zCYYz3UYRPtDl3ASiwiJCT7MDJherP4yCLsKCnUfIAjTZ7AFVxZI5F9URO1QsGW3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2VUPcvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AACC4CEDF;
	Tue,  4 Feb 2025 22:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738708582;
	bh=GUyS2ieEh/RbxEBcCpkqFVL7Ad+lb8Bs6CbqQ6XWHu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2VUPcvw2fLsceeQB4PCRAm+46skinz60jUAfR67YgCjgl88FfPEcfP0yq8AiiQ15
	 W8XYE95A+i/VEJjNRJnszEOqu+miUMxR4RhFIs7NEq7NSmSdV/620npL7kZN5l78dk
	 kict3oySkzRxb9mTH6Sg0o08mhRcjPP25dfx1Sldl4/kWKOyiXZpaACfvlPHuKodWZ
	 NIOms2RqhhEuhHCS+2QTCMXHClpSyUXKOI65uZGp5VEXenDdVzYORNh47WOEUiox8Q
	 KgYi8jXMH4c5gx/X9l/ZczADKXi+1NsFQA1Er/gph8CfcuwDDcwkxFu8Ve86OnmT/r
	 5EWVuv2zHPBAQ==
Date: Tue, 4 Feb 2025 14:36:21 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: sanity check the length passed to
 inode_set_cached_link()
Message-ID: <20250204223621.GC21791@frogsfrogsfrogs>
References: <20250204213207.337980-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250204213207.337980-1-mjguzik@gmail.com>

On Tue, Feb 04, 2025 at 10:32:07PM +0100, Mateusz Guzik wrote:
> This costs a strlen() call when instatianating a symlink.
> 
> Preferably it would be hidden behind VFS_WARN_ON (or compatible), but
> there is no such facility at the moment. With the facility in place the
> call can be patched out in production kernels.
> 
> In the meantime, since the cost is being paid unconditionally, use the
> result to a fixup the bad caller.
> 
> This is not expected to persist in the long run (tm).
> 
> Sample splat:
> bad length passed for symlink [/tmp/syz-imagegen43743633/file0/file0] (got 131109, expected 37)
> [rest of WARN blurp goes here]
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> This has a side effect of working around the panic reported in:
> https://lore.kernel.org/all/67a1e1f4.050a0220.163cdc.0063.GAE@google.com/
> 
> I'm confident this merely exposed a bug in ext4, see:
> https://lore.kernel.org/all/CAGudoHEv+Diti3r0x9VmF5ixgRVKk4trYnX_skVJNkQoTMaDHg@mail.gmail.com/#t

Yes, ext4 should not continue to load a fast symlink where i_size >
sizeof(i_data).  I'm a little surprised that nd_terminate_link exists to
paper over this situation, but the commit adding it (035146851cfa2fe) is
from 2008 when we were all young and naïve.

But yes, would be nice to have a CONFIG_VFS_DEBUG behind which to hide
assertions so that insufficient validation in ext4 will burble up
through Ted's test infrastructure. ;)

That said, I just saw this in ext4_get_link:

	nd_terminate_link(bh->b_data, inode->i_size,
			  inode->i_sb->s_blocksize - 1);

Which is writing into a buffer head without a transaction?  Granted
symlink targets in ext4 are written out to disk with the null terminator
so I guess that's not a big deal.

--D

> 
> Nonethelss, should help catch future problems.
> 
>  include/linux/fs.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index be3ad155ec9f..1437a3323731 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -791,6 +791,19 @@ struct inode {
>  
>  static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
>  {
> +	int testlen;
> +
> +	/*
> +	 * TODO: patch it into a debug-only check if relevant macros show up.
> +	 * In the meantime, since we are suffering strlen even on production kernels
> +	 * to find the right length, do a fixup if the wrong value got passed.
> +	 */
> +	testlen = strlen(link);
> +	if (testlen != linklen) {
> +		WARN_ONCE(1, "bad length passed for symlink [%s] (got %d, expected %d)",
> +			  link, linklen, testlen);
> +		linklen = testlen;
> +	}
>  	inode->i_link = link;
>  	inode->i_linklen = linklen;
>  	inode->i_opflags |= IOP_CACHED_LINK;
> -- 
> 2.43.0
> 
> 


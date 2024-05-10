Return-Path: <linux-fsdevel+bounces-19233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B948C1C01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 03:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6971DB224A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 01:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E5413B79B;
	Fri, 10 May 2024 01:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUg8Be1K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668BA13AA59;
	Fri, 10 May 2024 01:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715304184; cv=none; b=R2FcKt29TkoRTDoYdyww/ScLjLJYJmQJADauBDgMpqG9h2i07eRcmeRTgGMUvh9CpluxvkyslXyV8qSUpYMRF6u/xU5uiA5E67EJHwNYX3J1Mi3HzDdv/N2mdGgmiSe0LWuLg7Ny2fvKlNY56+98E7ltZvyCgMT/CImv8ctpV+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715304184; c=relaxed/simple;
	bh=2BSE5ByOFeu+q4jWzCWPKaw0K5PB4jxT3v2p/qOgpDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFS2CSdAAzGl/JNU5Zwix/D+dkKSULJBgus65lZy1uluJ+atpzto5Nvz96TjsvK/iS1MD++YnopCGKVX4MTvnh/TFeC60A3nlPQ6xCfJa4buDkW1UwXOpam1TlVJJtdhsRPRwm434KLDd+Id+0UY3Nwu/Bgo1qXhkOUHmQCGvic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUg8Be1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2BDC116B1;
	Fri, 10 May 2024 01:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715304184;
	bh=2BSE5ByOFeu+q4jWzCWPKaw0K5PB4jxT3v2p/qOgpDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cUg8Be1KmPeWf8iYT9CHHRWHmyGK3bsggILYcXyIZuU9b1otfUIGcUwxDLCLP1Pfn
	 Gju43ihgPJZPZes15IVpv5xYBvx5OkDeaE/D4Q4TqKKvtpp4EmJ5nY4hhhDvche2wV
	 JjDi7Sjs0jxK0WAvCN2Jo2/vkP3bZPLQbXDlwvEknGjkajsnGPduU2/bEekmdShBes
	 8fUcl5Gc29Q/GquUeSPsRrkVWpVLqu7FHdC5DvU3E6+P4Tn4ccsHltCUK1FVqm1OXk
	 dQjVpkebQMRPohB2rQ/OEEeogsExmgz/T1ynkuyFpERpTs2/HZ3gfcZQnwr6HYYVWS
	 VVBuO6oyZBF+Q==
Date: Fri, 10 May 2024 01:23:02 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, krisman@suse.de,
	Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v16 1/9] ext4: Simplify the handling of cached
 insensitive names
Message-ID: <20240510012302.GA1110919@google.com>
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
 <20240405121332.689228-2-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405121332.689228-2-eugen.hristev@collabora.com>

On Fri, Apr 05, 2024 at 03:13:24PM +0300, Eugen Hristev wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Keeping it as qstr avoids the unnecessary conversion in ext4_match
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> [eugen.hristev@collabora.com: port to 6.8-rc3]
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>

Reviewed-by: Eric Biggers <ebiggers@google.com>

(But please change "cached insensitive" to "case-insensitive")

- Eric


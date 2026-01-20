Return-Path: <linux-fsdevel+bounces-74594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 399D2D3C3D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 10:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9DBAB526349
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 09:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F663DA7D7;
	Tue, 20 Jan 2026 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccj+s/YJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306553A7853;
	Tue, 20 Jan 2026 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900988; cv=none; b=dVahkil1DU8NH+HwxseEMymHGh+xeh8oXmf7st1f6Yg9hAIFE8hoxCHij9DEn6lJ60sM1P59e0HqbDRA2c9qsOIB31RH6LvwZP3Z+Qu4vGwJH3+1JjbHDVSr0M8FRcxq1hDnH6loJMGBwGg2MYl8NUPqQHkF2tgUKGXx+n0NQxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900988; c=relaxed/simple;
	bh=gN06CoZo6pzfhmojwTq7NXXWYwPxUCLoA0Q9in47EjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAQGDTmmtIo27CfzOA2WrIQ5FRTbPpU4m2CwQD7ZrocEv/VdM6F8A2LfdMAYDv746/LLWDMh6VWtCDUv9EiE+/AMKDxmOGPcVIUvWLBCrPD46OA3/Rhy5qZZxYnRp4L6+cIYz2kfx8DTCm+2aFhdmcIgwcqhKLjN5erTBYpg2A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccj+s/YJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D964BC16AAE;
	Tue, 20 Jan 2026 09:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768900987;
	bh=gN06CoZo6pzfhmojwTq7NXXWYwPxUCLoA0Q9in47EjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ccj+s/YJi8n1hqrsOiUc1Lcc/IzhEcbMyQFMc4HuekAo47iNu2c60xkegMjR6g5G4
	 L8GLFPPeBUpJYArwf2/SsYTRnGOGj2dNzdde8QBj1GRuElJMAgNZV1InEbHAAijk3r
	 e4XI+o/y+dB+A5My2weCCJ4Xv9mHG3RDgPvsyJ44cQxancVOh3S3o5wz6hWsUPhmdL
	 9+6T5ph7vDVebVyaSaqll4koFDeW3hyGe3JBfll5JEKZDWOY7kqy8YJf5KX7s8ZsIu
	 4Hv9V1RiAI1iN6xpnVxc9A8d22S7JirKBmH95w9pWBiJJp47FUDnCz/ek9jls5nTM/
	 MObTncL2tPfXA==
Date: Tue, 20 Jan 2026 10:23:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Benjamin Coddington <bcodding@hammerspace.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH v1 0/4] kNFSD Signed Filehandles
Message-ID: <20260120-tratsch-luftfahrt-d447fdd12c10@brauner>
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <20260119-reingehen-gelitten-a5e364f704fa@brauner>
 <176885678653.16766.8436118850581649792@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <176885678653.16766.8436118850581649792@noble.neil.brown.name>

> You don't need signing to ensure a filehandle doesn't persist across
> reboot.  For that you just need a generation number.  Storing a random
> number generated at boot time in the filehandle would be a good solution.

For pidfs I went with the 64-bit inode number. But I dislike the
generation number thing. If I would have to freedom to completely redo
it I would probably assign a uuid to the pidfs sb and then use that in
the file handles alongside the inode number. That would be enough for
sure as the uuid would change on each boot.

> The only reason we need signing is because filesystems only provide
> 32bits of generation number.  If a filesystem stored 64 bits, and used a
> crypto-safe random number for the generation number, then we wouldn't
> need signing or a key.
> 
> We need a key, effectively, to turn a 32bit number that can be iterated
> into a 64bit number which cannot, in a non-reversible way.
> 
> Does userspace refuse the extract the inode number if the filehandle
> size changes?  It it can cope with size change, then adding a random
> number to the end of the filehandle should not be a problem.

At least nsfs file handles are public api and may grow in size.

> I didn't know that.....
> Oh, there is a "permission" operation now:
> 
>  * permission:
>  *    Allow filesystems to specify a custom permission function.
> 
> Not the most useful documentation I have ever read.
> Not documented in Documentation/filesystems/exporting.rst
> 
> Not used in fs/exportfs/.
> Ahhh.. used in fs/fhandle.c to bypass may_decode_fh()
> 
> Fair enough - seems sane for a special-purpose filesystem to give away
> different access.
> 
> Thanks for the info.
> 
> I wonder if nfsd should refuse to export filesystems which have a
> .permission function, as they clearly are something special.

No problem. pidfs and nsfs have custom permission and open because they
both don't need to reconstruct any paths and aren't subject to the same
permission checking.


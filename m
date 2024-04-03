Return-Path: <linux-fsdevel+bounces-15964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 690738962FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 05:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2071C22E97
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 03:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7BD3C6A4;
	Wed,  3 Apr 2024 03:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAAEV/1P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DF94085A;
	Wed,  3 Apr 2024 03:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712115057; cv=none; b=efX0nxd3Sl25GLBVn6b+YKQPcIrWZv17nKqxiPFF/Px0HDQVybMA4gWzhC+tXuE6bq5eMNMCAQJUrRLZVeuoUfeKZ/D3UpAbLv0Az4BnLbTNVLBwADFl3GNz5NjByLL4XlVC3ukdmHFu10ttsSRdSvsh3QsK4uNHNsQvTf3VSmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712115057; c=relaxed/simple;
	bh=aUHCt2G7OXXo2o4YJpgKFb2OWsCjhGSf+zKg2+GPiFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQsBfRJ2p5A6cXElYBw1ZgxmJzhQk113uwbbVlQ6aa2GMH/FWR7Sca0RCIIC45cwAvUur1av/kDEU68e8y8eQDyXWXkRno2w3rp6bAuywM36CL73xy+jxjAaw8pdWedXxtVU8FTOX2IoXR/FA/CfG9fjuGOYZQaKyW86AHtv6f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAAEV/1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3129C433F1;
	Wed,  3 Apr 2024 03:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712115057;
	bh=aUHCt2G7OXXo2o4YJpgKFb2OWsCjhGSf+zKg2+GPiFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uAAEV/1P7uecv9LxBjxJwaDuB2DRliq+mLbtBH9a5/NTqmXTxKzZcVLyIjR7h9nSu
	 RavWKK8nGD3a5I6ZXc5gfgy2LALZOYSpW7/4TrWkzA82V1l+cZvrkNIMW2b1vhxqqe
	 Kso9i34D4Pvnz3sLruOqRQ8siwwmLZwVkNmcAfKQEbe8WYWdesfZdW2m/64pN/xuGQ
	 N+CIMfgrTwjWlJSCPriefrDG1SbvppJhHi4iZ5JqCUMZki6fw0N2TwdUItWBhitd9U
	 13eCEPhcqGY3M3Z9piSfZV7WgYBFuS1Eq7pX1POdh+k8gCSo5wVktHhTKcAwBbU5xx
	 HNgLbEV1k7FxQ==
Date: Tue, 2 Apr 2024 20:30:55 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, krisman@suse.de,
	Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v15 2/9] f2fs: Simplify the handling of cached
 insensitive names
Message-ID: <20240403033055.GD2576@sol.localdomain>
References: <20240402154842.508032-1-eugen.hristev@collabora.com>
 <20240402154842.508032-3-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402154842.508032-3-eugen.hristev@collabora.com>

On Tue, Apr 02, 2024 at 06:48:35PM +0300, Eugen Hristev wrote:
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index d0f24ccbd1ac..7e53abf6d216 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -153,11 +153,8 @@ static int init_recovered_filename(const struct inode *dir,
>  		if (err)
>  			return err;
>  		f2fs_hash_filename(dir, fname);
> -#if IS_ENABLED(CONFIG_UNICODE)
>  		/* Case-sensitive match is fine for recovery */
> -		kmem_cache_free(f2fs_cf_name_slab, fname->cf_name.name);
> -		fname->cf_name.name = NULL;
> -#endif
> +		f2fs_free_casefolded_name(fname);
>  	} else {
>  		f2fs_hash_filename(dir, fname);
>  	}

This change makes the declaration of f2fs_cf_name_slab in recovery.c
unnecessary.  It can be removed.

- Eric


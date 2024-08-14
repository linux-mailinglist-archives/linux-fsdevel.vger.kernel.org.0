Return-Path: <linux-fsdevel+bounces-26008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFD49524D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 23:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87DB284406
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 21:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3061C8222;
	Wed, 14 Aug 2024 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VkoKIQks"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7FB1B0125;
	Wed, 14 Aug 2024 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723671523; cv=none; b=NxAKtOABRG4qBsoBZWgjvLTjpVDKgpuSVG2DbVpyVerYGUfgg2nARqlIhIE6KDPeiZAj/oQbXT8rqq8TLELUiOXYhrXotwOhnNjMIw4UoCHDxOBV2UphMxg7Q+Jhb4yW2rUdxZ74ltDE68w2hgVRj6jDn6dD9DVZV/4uPjY5bu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723671523; c=relaxed/simple;
	bh=CCbQ83Iy1WzmBG4dBLFnVf1SI1eFl9/q84aiMtQ7YIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yg8X0vI7x3l32F+qReWEo1iq3wlvLzrZLsCS4sd1TnJr9VrFigDdn5TgQTIe3hbmqeo9IDnmHCRt/O8rhDVIWFb21A7bCG6jrQevrrYYmzB91OQjfhVbGPFH2iTnK759xAn97sADQr50hvOLxiN7pfzVEG9nGkoc6YcDc9elT5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VkoKIQks; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=co+EjIeuQKptCH4asuM2220HsBlmKKFCANnTP/24k2g=; b=VkoKIQksG7ZyEOcK2IRicOVob/
	EX3C9hozgV45MdjC2uw/t5NtCszDQTj/d5t9Q/73NeQb/J6iQTmbrhr3O7vrmKza1yUMIQfAEAF+V
	d0TSl1tBwRKRnWEeWX7fFJ5Yh95aCm50PJ9PAtZU/gIdog9JHgcWzHXLYNi4aVIXaKIZDURLlUZrg
	OZudE4pvZxymh7PCXaIz+vYCd//uXolUOpFo7Pe786LehJabUEuqm0rDPj1sGEBAK9JMluHehx9bl
	X0iSzCZq4DNjMBr/+wR8WI8iv3cXxNTB/3hq6+BRdgiWTZRO4eFfyhsfxGpQyIJ4to5GRhOiJxYdv
	cit8M0oQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1seLhU-00000001itB-099Y;
	Wed, 14 Aug 2024 21:38:36 +0000
Date: Wed, 14 Aug 2024 22:38:35 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Ma <yu.ma@intel.com>
Cc: brauner@kernel.org, jack@suse.cz, mjguzik@gmail.com,
	edumazet@google.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, pan.deng@intel.com,
	tianyou.li@intel.com, tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v5 1/3] fs/file.c: remove sanity_check and add
 likely/unlikely in alloc_fd()
Message-ID: <20240814213835.GU13701@ZenIV>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240717145018.3972922-1-yu.ma@intel.com>
 <20240717145018.3972922-2-yu.ma@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717145018.3972922-2-yu.ma@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jul 17, 2024 at 10:50:16AM -0400, Yu Ma wrote:
> alloc_fd() has a sanity check inside to make sure the struct file mapping to the
> allocated fd is NULL. Remove this sanity check since it can be assured by
> exisitng zero initilization and NULL set when recycling fd. Meanwhile, add
> likely/unlikely and expand_file() call avoidance to reduce the work under
> file_lock.

> +	if (unlikely(fd >= fdt->max_fds)) {
> +		error = expand_files(files, fd);
> +		if (error < 0)
> +			goto out;
>  
> -	/*
> -	 * If we needed to expand the fs array we
> -	 * might have blocked - try again.
> -	 */
> -	if (error)
> -		goto repeat;
> +		/*
> +		 * If we needed to expand the fs array we
> +		 * might have blocked - try again.
> +		 */
> +		if (error)
> +			goto repeat;

With that change you can't get 0 from expand_files() here, so the
last goto should be unconditional.  The only case when expand_files()
returns 0 is when it has found the descriptor already being covered
by fdt; since fdt->max_fds is stabilized by ->files_lock we are
holding here, comparison in expand_files() will give the same
result as it just had.

IOW, that goto repeat should be unconditional.  The fun part here is
that this was the only caller that distinguished between 0 and 1...


Return-Path: <linux-fsdevel+bounces-12534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D36F18609D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 05:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1020A1C227A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 04:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8977F10A13;
	Fri, 23 Feb 2024 04:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRqh3CYj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5872CA5;
	Fri, 23 Feb 2024 04:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708662187; cv=none; b=fhVuxsy/3kdjIlnJp9Fz2No+rBybvOiQml6rh2QsjD99l5eJa+STP9XgpJdmzaXCApNwaVbzQEnW5SWme2by2dN6NsrXPO0VfzWJlG/GUJR/xXzI+1zPBF5C+CYUAtfBjXuO84o56M4PVjJogToFMFGQoABD/pTRBMTWqKL9Eu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708662187; c=relaxed/simple;
	bh=Z3fH/mjawjD50HyMLDsvAaHokkTHzE3vYVMAEur6rcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7eAw0PXDj6+ZcPwu7QDUonEPjSPP+SeRYLD/dJqS9tD1MA8jozkbE/8kVJ0OS2UbKyjUIbNjvMGJK4Uo2uMxi44ULJFTO0HzioflvhYjeqogVWGavsP14lgv6AmF3yY0adXyqHn68kiCA3zy4ZK73dmJtGgexcp5/bmjJQOS5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRqh3CYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443BAC433C7;
	Fri, 23 Feb 2024 04:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708662186;
	bh=Z3fH/mjawjD50HyMLDsvAaHokkTHzE3vYVMAEur6rcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iRqh3CYjRfCP/WctC5UmuFIxsE4NSXgX7oTGl2I9uyDP0lNdiwrsawkv8Lq5r9Cpg
	 WrQKWPvRUUKSBBr6FLEX/Xi+zY6LFjcmDC3cgCIX1f7Wo87Xqkmx6O5QYhbR249gnS
	 NcOtiqY6pPBCkb+7BA513+CJcSymo0XmnyAS5AaCi/cEYFg/nbzSXm/sXdcZDQjGv3
	 qYK2saZ2tGKI2ZlJr5P+n/9/Lc7LTZLu+j78lI2qP/GAkXurVakDkpogfBqAhBLbtK
	 n8s97oPs9On9kwRG7GvCWv2ReXfP2KLIcwLglyLA7frEw+gCm8CpBfkoteAHDihg4Z
	 bxgm0EYYfjqWw==
Date: Thu, 22 Feb 2024 20:23:04 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	djwong@kernel.org
Subject: Re: [PATCH v4 05/25] fs: add FS_XFLAG_VERITY for verity files
Message-ID: <20240223042304.GA25631@sol.localdomain>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
 <20240212165821.1901300-6-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212165821.1901300-6-aalbersh@redhat.com>

On Mon, Feb 12, 2024 at 05:58:02PM +0100, Andrey Albershteyn wrote:
> +FS_IOC_FSGETXATTR
> +-----------------
> +
> +Since Linux v6.9, FS_XFLAG_VERITY (0x00020000) file attribute is set for verity
> +files. The attribute can be observed via lsattr.
> +
> +    [root@vm:~]# lsattr /mnt/test/foo
> +    --------------------V- /mnt/test/foo
> +
> +Note that this attribute cannot be set with FS_IOC_FSSETXATTR as enabling verity
> +requires input parameters. See FS_IOC_ENABLE_VERITY.

The lsattr example is irrelevant and misleading because lsattr uses
FS_IOC_GETFLAGS, not FS_IOC_FSGETXATTR.

Also, I know that you titled the subsection "FS_IOC_FSGETXATTR", but the text
itself should make it super clear that FS_XFLAG_VERITY is only for
FS_IOC_FSGETXATTR, not FS_IOC_GETFLAGS.

> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 48ad69f7722e..6e63ea832d4f 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -140,6 +140,7 @@ struct fsxattr {
>  #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
>  #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
>  #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
> +#define FS_XFLAG_VERITY		0x00020000	/* fs-verity sealed inode */

There's currently nowhere in the documentation or code that uses the phrase
"fs-verity sealed inode".  It's instead called a verity file, or a file that has
fs-verity enabled.  We should try to avoid inconsistent terminology.

- Eric


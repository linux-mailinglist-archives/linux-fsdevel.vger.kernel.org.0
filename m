Return-Path: <linux-fsdevel+bounces-31-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 728297C48B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 06:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0EB281F1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 04:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE08D2E4;
	Wed, 11 Oct 2023 04:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfNjOtR6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0195CA6A;
	Wed, 11 Oct 2023 04:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27349C433C8;
	Wed, 11 Oct 2023 04:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696997146;
	bh=1JQP12Rvs/L7oR0sDRqcZzvxymBN3sh9uR3BEuj025o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YfNjOtR6nd0yyagEXkt7xRhy4l38kptv6SPKpNrLadp7GIdIuHTUTP8jdTGFJ9mJn
	 6VPey3PLAgJs3FFY5+ZH7PJyWU/xntlp3oGqw5tjgKH8JcefVb8blb7mruciB8s8tG
	 iRr+6fzH82d3SwYvy588qsTfyngYvesIRRLcKJCJekcAMugyFdwYS8im3o8hnD9nbH
	 NLn64OhGlqkuuriOSALE8eXsHGSQ577V2eeJfHkZxeJqu5L37XmdYZ5uWAFz6ei2aZ
	 RGPA/kNabIqlwdXqxtKVV5SRaULZ7e+7ifDMqZWjhxmUh4bfzWI5MJpkJ7Ud3i1PgX
	 T5L5eM2RaqJww==
Date: Tue, 10 Oct 2023 21:05:44 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, djwong@kernel.org, david@fromorbit.com,
	dchinner@redhat.com
Subject: Re: [PATCH v3 05/28] fs: add FS_XFLAG_VERITY for fs-verity sealed
 inodes
Message-ID: <20231011040544.GF1185@sol.localdomain>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-6-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006184922.252188-6-aalbersh@redhat.com>

On Fri, Oct 06, 2023 at 08:48:59PM +0200, Andrey Albershteyn wrote:
> Add extended file attribute FS_XFLAG_VERITY for inodes sealed with
> fs-verity.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  Documentation/filesystems/fsverity.rst | 9 +++++++++
>  include/uapi/linux/fs.h                | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
> index 13e4b18e5dbb..af889512c6ac 100644
> --- a/Documentation/filesystems/fsverity.rst
> +++ b/Documentation/filesystems/fsverity.rst
> @@ -326,6 +326,15 @@ the file has fs-verity enabled.  This can perform better than
>  FS_IOC_GETFLAGS and FS_IOC_MEASURE_VERITY because it doesn't require
>  opening the file, and opening verity files can be expensive.
>  
> +Extended file attributes
> +------------------------
> +
> +For fs-verity sealed files the FS_XFLAG_VERITY extended file
> +attribute is set. The attribute can be observed via lsattr.
> +
> +    [root@vm:~]# lsattr /mnt/test/foo
> +    --------------------V- /mnt/test/foo
> +

There's currently nowhere in the documentation or code that uses the phrase
"fs-verity sealed file".  It's instead called a verity file, or a file that has
fs-verity enabled.  I suggest we try to avoid inconsistent terminology.

Also, it should be mentioned which kernel versions this works on.

See for example what the statx section of the documentation says just above the
new section that you're adding:

    Since Linux v5.5, the statx() system call sets STATX_ATTR_VERITY if
    the file has fs-verity enabled.

Also, is FS_XFLAG_VERITY going to work on all filesystems?  The existing ways to
query the verity flag work on all filesystems.  Hopefully any new API will too.

Also, "Extended file attributes" is easily confused with, well, extended file
attributes (xattrs).  It should be made clear that this is talking about the
FS_IOC_FSGETXATTR ioctl, not real xattrs.

Also, it should be made clear that FS_XFLAG_VERITY cannot be set using
FS_IOC_FSSETXATTR.  See e.g. how the existing documentation says that
FS_IOC_GETFLAGS can get FS_VERITY_FL but FS_IOC_SETFLAGS cannot set it.

- Eric


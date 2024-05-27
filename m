Return-Path: <linux-fsdevel+bounces-20250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFD38D065A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 17:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40F0320070
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 15:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913521E4AE;
	Mon, 27 May 2024 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZkxbGUE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB7717E919;
	Mon, 27 May 2024 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824403; cv=none; b=D4ptkac96LujE8jbyVcU5gIJYxuBCfH7aO0tBKwg2wDDGBACSB3ctvZRjbcHdURFKRilzcPbJZKAdnqj3TIaadqcS5OxP3Oypn9xLPusTUpOxU6d8BN3x2gKc5iBN67aRWfxtQM2DX7SoLsX5VRnlifwgoQ9Ne8aD8LNKPsHmIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824403; c=relaxed/simple;
	bh=U/g2DlIQlcN9KM28tlaBFcTUIku1RJL52DS6Riw5pGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0+tFjzlV32vNPmiTiv3DTgLrHr/2GCzGqMrX82eJL0ns79gmyy20gDeYsbiRtkqZPmRBqWR8wK1vf2F9SQn+4HydHCziatXC2rtMM50OvHAdX3W1pn2oMt3gVgy2VBnWdM/EK2nmIFXy/m29a/BdjngEAfOzNG926bgHgCqL9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZkxbGUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F363DC2BBFC;
	Mon, 27 May 2024 15:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716824402;
	bh=U/g2DlIQlcN9KM28tlaBFcTUIku1RJL52DS6Riw5pGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NZkxbGUEzWW4IU2cD8eb2PfKo00X9sAUgjNEP+Q8Zwcx4Cqu8u5bRvXMrKFIXGc9R
	 EspAQY85IXTJkz/oWqjRtma98LfFaB7VWROXD0DWpkOwNVHoChwAqkP25DI32zPgkk
	 OfRnzG5CHFe3k2uSh1Hs3BL8ITxxTdXx7fiZftZIBCJCJ3GrDDMeV5aSutjMtbrFni
	 F4ajetsvbQDxM8f8pmsSPIi2byYHPdSeAoHzsL80HxbRR17PTjRiPfy7Jll2CQ1LwQ
	 jzupLCx8w8GueVuUo0kjrpcBbgalNdatEnyms9DAOehyQFpbMWRI7OgOrZVU94Almb
	 AhXY38oz7C7xg==
Date: Mon, 27 May 2024 17:39:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, tytso@mit.edu, 
	adilger.kernel@dilger.ca, lczerner@redhat.com, cmaiolino@redhat.com, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v2 3/4] fs: ext4: support relative path for
 `journal_path` in mount option.
Message-ID: <20240527-mahlen-packung-3fe035ab390d@brauner>
References: <20240527075854.1260981-1-lihongbo22@huawei.com>
 <20240527075854.1260981-4-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240527075854.1260981-4-lihongbo22@huawei.com>

On Mon, May 27, 2024 at 03:58:53PM +0800, Hongbo Li wrote:
> After `fs_param_is_blockdev` is implemented(in fs: add blockdev parser
> for filesystem mount option.), `journal_devnum` can be obtained from
> `result.uint_32` directly.
> 
> Additionally, the `fs_lookup_param` did not consider the relative path
> for block device. When we mount ext4 with `journal_path` option using
> relative path, `param->dirfd` was not set which will cause mounting
> error.

That's a failure in userspace though. If a relative pathname is provided
then AT_FDCWD or a valid file descriptor must be provided:

fsconfig(fd_fs, FSCONFIG_SET_PATH, "journal_path", "relative/path", AT_FDCWD);

But if you're seeing this from mount(8) then util-linux very likely
does (cf. [1]):

fsconfig(fd_fs, FSCONFIG_SET_STRING, "journal_path", "relative/path", 0);

So mount(8) is passing that as a string as it has no way to figure out
that this should be passed as FSCONFIG_SET_PATH. So to allow relative
paths in string options we'd need something (untested) like:

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index a4d6ca0b8971..18ca40408e91 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -156,6 +156,9 @@ int fs_lookup_param(struct fs_context *fc,
                f = getname_kernel(param->string);
                if (IS_ERR(f))
                        return PTR_ERR(f);
+               /* relative path */
+               if (*f->name[0] != '/')
+                       param->dirfd = AT_FDCWD;
                put_f = true;
                break;
        case fs_value_is_filename:

https://github.com/util-linux/util-linux/blob/55ca447a6a95226fd031a126fb48b01b3efd6284/libmount/src/hook_mount.c#L178

> 
> This can be reproduced easily like this:
> 
> mke2fs -F -O journal_dev $JOURNAL_DEV -b 4096 100M
> mkfs.ext4 -F -J device=$JOURNAL_DEV -b 4096 $FS_DEV
> cd /dev; mount -t ext4 -o journal_path=`basename $JOURNAL_DEV` $FS_DEV $MNT
> 
> Fixes: 461c3af045d3 ("ext4: Change handle_mount_opt() to use fs_parameter")
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  fs/ext4/super.c | 26 +-------------------------
>  1 file changed, 1 insertion(+), 25 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c682fb927b64..94b39bcae99d 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2290,39 +2290,15 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		ctx->spec |= EXT4_SPEC_s_resgid;
>  		return 0;
>  	case Opt_journal_dev:
> -		if (is_remount) {
> -			ext4_msg(NULL, KERN_ERR,
> -				 "Cannot specify journal on remount");
> -			return -EINVAL;
> -		}
> -		ctx->journal_devnum = result.uint_32;
> -		ctx->spec |= EXT4_SPEC_JOURNAL_DEV;
> -		return 0;
>  	case Opt_journal_path:
> -	{
> -		struct inode *journal_inode;
> -		struct path path;
> -		int error;
> -
>  		if (is_remount) {
>  			ext4_msg(NULL, KERN_ERR,
>  				 "Cannot specify journal on remount");
>  			return -EINVAL;
>  		}

This would cause a path lookup in the VFS layer only to immediately
reject it on remount.


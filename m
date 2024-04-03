Return-Path: <linux-fsdevel+bounces-15968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B304889636F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 06:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6644A1F22ADF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 04:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA25446D2;
	Wed,  3 Apr 2024 04:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhVw4H90"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2E53716D;
	Wed,  3 Apr 2024 04:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712118154; cv=none; b=U2IRQhsBqP1jcJq43mGACCujqDdYAxIGOw1Mb2OuLzHZjWkdfhuZD4AnwDa1PvIoK4e+FeR5zQDgy9IDg7sBhf8rixfJDesluHGuGE0JTiE1a7Fj2/530hW5zdcIvk/PcPKfRHoVgQtGNMmasR7C/pf6gFMv0zSjXnC1fe0P4vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712118154; c=relaxed/simple;
	bh=RziLX4KmfrHv88fw3gSwzASvgPajd59CTngrkRmOSnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEbW3kCeI4uPwCaWEUsL/zK3oviYQJJL9mA+EA9yB30ndNH5fPOdzc/mxxzhO+Q//RICu/wTPiW16p90HTPXEWW1NoxTtwgPulk965CfP1bS4Idjx8lPuYs/mw4TkHA1Hqlu/a2GABIhpkDdiHvvn/7yL4O339nlQpg/6bn0tYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhVw4H90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F81C433F1;
	Wed,  3 Apr 2024 04:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712118154;
	bh=RziLX4KmfrHv88fw3gSwzASvgPajd59CTngrkRmOSnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YhVw4H90SPZTOe+o9L+rwRKHwnOQVJGOPnyIJJpX/jDX8aq8Uboa1HJcC9afYaeEB
	 VvjUDFMW5C3llc/cxvg8AWKe37x/2sDj4tc8YFTpUv0QiuWXwD98OGdj+19O3fVp14
	 ZTL0OtusBj/ekHgjv3xDsMGaKjjK+vvbR4DXTB/Es5eyoIy3mKFDNiHQjtAjwrGHJM
	 T/5oOF+Ve5RB7l9hR43HckD9ZBIFTYK5t/lbk1BKeItYqBWeGIlcXluTSQmVsOtfaA
	 D3jaYXxBcuhm19Qnd7zaMliUfcNoGKGLV76OnKXHkqOPeK5sFH5434b2yM1CHBD46Q
	 KosV6AKUOqE8A==
Date: Tue, 2 Apr 2024 21:22:31 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, krisman@suse.de, brauner@kernel.org,
	jack@suse.cz, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	kernel@collabora.com,
	Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [f2fs-dev] [PATCH v15 6/9] ext4: Log error when lookup of
 encoded dentry fails
Message-ID: <20240403042231.GH2576@sol.localdomain>
References: <20240402154842.508032-1-eugen.hristev@collabora.com>
 <20240402154842.508032-7-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402154842.508032-7-eugen.hristev@collabora.com>

On Tue, Apr 02, 2024 at 06:48:39PM +0300, Eugen Hristev via Linux-f2fs-devel wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> If the volume is in strict mode, ext4_ci_compare can report a broken
> encoding name.  This will not trigger on a bad lookup, which is caught
> earlier, only if the actual disk name is bad.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  fs/ext4/namei.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 2d0ee232fbe7..3268cf45d9db 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1477,6 +1477,9 @@ static bool ext4_match(struct inode *parent,
>  			 * only case where it happens is on a disk
>  			 * corruption or ENOMEM.
>  			 */
> +			if (ret == -EINVAL)
> +				EXT4_ERROR_INODE(parent,
> +					"Directory contains filename that is invalid UTF-8");
>  			return false;

I'm seeing this error when the volume is *not* in strict mode and a file has a
name that is not valid UTF-8.  That doesn't seem to be working as intended.

    mkfs.ext4 -F -O casefold /dev/vdb
    mount /dev/vdb /mnt
    mkdir /mnt/dir
    chattr +F /mnt/dir
    touch /mnt/dir/$'\xff'

[ 1528.691319] EXT4-fs (vdb): Using encoding defined by superblock: utf8-12.1.0 with flags 0x0
[ 1528.707793] EXT4-fs (vdb): mounted filesystem 0be607cc-0dae-4e7f-a40f-4fe8075e8e50 r/w with ordered data mode. Quota mode: none.
[ 1528.728583] EXT4-fs error (device vdb): ext4_match:1481: inode #13: comm touch: Directory contains filename that is invalid UTF-8
[ 1528.730700] EXT4-fs error (device vdb): ext4_match:1481: inode #13: comm touch: Directory contains filename that is invalid UTF-8
[ 1528.732976] EXT4-fs error (device vdb): ext4_match:1481: inode #13: comm touch: Directory contains filename that is invalid UTF-8
[ 1528.735536] EXT4-fs error (device vdb): ext4_match:1481: inode #13: comm touch: Directory contains filename that is invalid UTF-8


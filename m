Return-Path: <linux-fsdevel+bounces-12946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F40D869088
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 13:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6AF21C231A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 12:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC2C13A274;
	Tue, 27 Feb 2024 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5wN7Nqm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA3E13A263
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036782; cv=none; b=ExPx/ij0RIpoTCoM5L6il1OsmyhIOP2e1FqqwicXdGZXu5B9sUaTiHVijk5DEs3AFFs6jXFkiTmadN/9KjoMciP6ZcO05WLpmGKq87h4/L8b1UUu8gFts3FOWk5vYtdjr+fOdNWPS6BJ2dwesxY+Ouywbw7rPuMx3NwmvJAAU4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036782; c=relaxed/simple;
	bh=76mzFTDJAWkF3iqfR9oya3GiYnZtFt1fElosJMoh0A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2wtcRFzgSirh1hHeSa1MmSBLzf0uxi211DirYRLlGCzT2AK0FLYhMjcSTPJwH8b1+yrsDYtlQPPwRSKO4QOKqD32b9xZZR8z8lgjvCuBYOf1ioY/DcpDJvwmIy5mN5s4SzkAnnpxckPWAco/PAVTb3kF1XIYKS3dYK3yTaMhAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5wN7Nqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F5AC433C7;
	Tue, 27 Feb 2024 12:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709036782;
	bh=76mzFTDJAWkF3iqfR9oya3GiYnZtFt1fElosJMoh0A8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5wN7NqmD5L+z9UKgx0U1oKGuT8CUpJGU9eVtjf6WKXBANinSfpto67+Pu8vkzmN4
	 pfn2ZWkDBANnOHJDYWLxYcRWiHZPRMKIx3MW5VXqUuXdoKyO9LHnVF5KlbLjORsAc2
	 cAk1LQ7ozupLW52wwOGgrTPjiTDUKnrJr2u3HyFDcDWvzz6DQE5Ga8FTlmP5E3BemO
	 A309VXlbJ+Iu+FCNsbMYXqxVzhpLAiSzbCInjUKOHDNPV2iSztMiW+0QMo1GfL/le/
	 gcPVuuUWM9H3RTOLdFCM7+WsnMDjZ6+uGxdtacI76qe5zNn9ddf5qX/6SNUTZEo27k
	 42YaCNopQtALg==
Date: Tue, 27 Feb 2024 13:26:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Bill O'Donnell <bodonnel@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, al@alarsen.net, sandeen@redhat.com
Subject: Re: [PATCH] qnx4: convert qnx4 to use the new mount api
Message-ID: <20240227-infrage-imperativ-53428d23802c@brauner>
References: <20240226224628.710547-1-bodonnel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240226224628.710547-1-bodonnel@redhat.com>

On Mon, Feb 26, 2024 at 04:46:28PM -0600, Bill O'Donnell wrote:
> Convert the qnx4 filesystem to use the new mount API.
> 
> Tested mount, umount, and remount using a qnx4 boot image.
> 
> Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
> ---
>  fs/qnx4/inode.c | 49 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
> index 6eb9bb369b57..c36fbe45a0e9 100644
> --- a/fs/qnx4/inode.c
> +++ b/fs/qnx4/inode.c
> @@ -21,6 +21,7 @@
>  #include <linux/buffer_head.h>
>  #include <linux/writeback.h>
>  #include <linux/statfs.h>
> +#include <linux/fs_context.h>
>  #include "qnx4.h"
>  
>  #define QNX4_VERSION  4
> @@ -30,28 +31,33 @@ static const struct super_operations qnx4_sops;
>  
>  static struct inode *qnx4_alloc_inode(struct super_block *sb);
>  static void qnx4_free_inode(struct inode *inode);
> -static int qnx4_remount(struct super_block *sb, int *flags, char *data);
>  static int qnx4_statfs(struct dentry *, struct kstatfs *);
> +static int qnx4_get_tree(struct fs_context *fc);
>  
>  static const struct super_operations qnx4_sops =
>  {
>  	.alloc_inode	= qnx4_alloc_inode,
>  	.free_inode	= qnx4_free_inode,
>  	.statfs		= qnx4_statfs,
> -	.remount_fs	= qnx4_remount,
>  };
>  
> -static int qnx4_remount(struct super_block *sb, int *flags, char *data)
> +static int qnx4_reconfigure(struct fs_context *fc)
>  {
> -	struct qnx4_sb_info *qs;
> +	struct super_block *sb = fc->root->d_sb;
> +	struct qnx4_sb_info *qs = sb->s_fs_info;
>  
>  	sync_filesystem(sb);
>  	qs = qnx4_sb(sb);
>  	qs->Version = QNX4_VERSION;
> -	*flags |= SB_RDONLY;
> +	fc->sb_flags |= SB_RDONLY;

This confused me to no end because setting SB_RDONLY here
unconditionally would be wrong if it's not requested from userspace
during a remount. Because in that case the vfs wouldn't know that an
actual read-only remount request had been made which means that we don't
take the necessary protection steps to transition from read-write to
read-only. But qnx{4,6} are read-only so this is actually correct even
though it seems pretty weird.


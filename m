Return-Path: <linux-fsdevel+bounces-59059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4710B340B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D9C77AD5A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3092274FE8;
	Mon, 25 Aug 2025 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fy2r4gUs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4B2274B22
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128579; cv=none; b=g77gc/WGO3UdEAMtTydw90y+ilS9cW1PfnHyKHy/NroZX268xOsrlGUrZg8HUHzf9NVu144pAzKL65s2VuUfb/qKkS9pxcDy7P/ucWh1++jH4ygrrNRlu6L3jfsFSo6D1H89bZtugwmfaY5ZW9fuoPkkUqwZYRDxwbcsOuhSNe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128579; c=relaxed/simple;
	bh=L42Fq0EGG1m2he92U0ghpdM4GbQXxp4bdk+yuDPw5Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kekZz2LF2ltp/kLc57mPvkaBAgmiE5zKpdyPbx6McGdvnarzCf6ct7+8nXqmPWYmhHMZtj8ypm2p+wEdD+MMlHE8eliTl2AUEiswQ36SHs/xGpR4wqkpPUBWbQhULJEoPpxDIo3CDYphEjZhPI6fcLyWKJD1gnlgYlnD49mT/Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fy2r4gUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E962C4CEED;
	Mon, 25 Aug 2025 13:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756128576;
	bh=L42Fq0EGG1m2he92U0ghpdM4GbQXxp4bdk+yuDPw5Nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fy2r4gUsVENkZZco5CicgFf02WN12NUlElysQTt+/yvD4JEyvgjHgs04FuPGS1kXM
	 LOS5gkJgf3mJ9e1sCTTIBgvoVHD9UmAIVRmHcDbrhYB7Bwp4PjM5m00JrOlykYQY+z
	 YSQL0peYNjCJKGxeC8Z36Q+Ql301ar1Or2v/kDGeks/L7z8wheTWuLV4Ft2ns/1irQ
	 XdruzpmYMciwCN2pF8AxfzCllT6HrL2qpqb6B6/9ItBq/CzCIwYoOepIokc9kymnus
	 FvFgkfsm7tCwblcM7bm7z5exj4rRtf0f8/m42NEKhYa2redz2Fplc7SxSsoWsJv94f
	 dPkh9Q4o8Ibgg==
Date: Mon, 25 Aug 2025 15:29:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 25/52] do_new_mount_rc(): use __free() to deal with
 dropping mnt on failure
Message-ID: <20250825-zugute-verkohlen-945073b3851f@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-25-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-25-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:28AM +0100, Al Viro wrote:
> do_add_mount() consumes vfsmount on success; just follow it with
> conditional retain_and_null_ptr() on success and we can switch
> to __free() for mnt and be done with that - unlock_mount() is
> in the very end.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---


>  fs/namespace.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 99757040a39a..79c87937a7dd 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3694,7 +3694,6 @@ static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags
>  static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
>  			   unsigned int mnt_flags)
>  {
> -	struct vfsmount *mnt;
>  	struct pinned_mountpoint mp = {};
>  	struct super_block *sb = fc->root->d_sb;
>  	int error;
> @@ -3710,7 +3709,7 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
>  
>  	up_write(&sb->s_umount);
>  
> -	mnt = vfs_create_mount(fc);
> +	struct vfsmount *mnt __free(mntput) = vfs_create_mount(fc);

Ugh, can we please not start declaring variables in the middle of a
scope.

>  	if (IS_ERR(mnt))
>  		return PTR_ERR(mnt);
>  
> @@ -3720,10 +3719,10 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
>  	if (!error) {
>  		error = do_add_mount(real_mount(mnt), mp.mp,
>  				     mountpoint, mnt_flags);
> +		if (!error)
> +			retain_and_null_ptr(mnt); // consumed on success
>  		unlock_mount(&mp);
>  	}
> -	if (error < 0)
> -		mntput(mnt);
>  	return error;
>  }
>  
> -- 
> 2.47.2
> 


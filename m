Return-Path: <linux-fsdevel+bounces-48294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B28AACE6A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 21:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319F43BC7C8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 19:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07EA20E030;
	Tue,  6 May 2025 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnVhP0At"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF6E20D4F8;
	Tue,  6 May 2025 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746561164; cv=none; b=IyZsnXolgiHTsr83Sfkf0gL56MvTY7dFr17MqVSEPk+NVUD9sg8Vc9DvOKl+dAsUvRNG8d3l8LuAVInqn2qG8/OzJjgbcTCzEKp3Xkm0aNsbaloeDu0dnaUyqzlyUX7FeToOBtI3wKx/p15HoWWXNdZQFXyULhKITw+Km2I6Igo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746561164; c=relaxed/simple;
	bh=6Sq9/Mghit77tRGUns1KmWPRRmfM1b+iIS4HF3jA+oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMRTD1qaHYjTriHEw4tVGVPnZYem5V6tJlFn/IZtC31C/BuW05/BqBCrk+7rv2d+AAI8G5qRv+b8/I3MqGR07ZJbvx5fRJ5juOGhtATfsi0f+RYTH6fdfn1NHGNIsC69O1teRTmbWMcbXOBFmGeVAILD40di7K7/qyBNATb3tKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnVhP0At; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so7588848e87.2;
        Tue, 06 May 2025 12:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746561160; x=1747165960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZJa/hAGQmMtbYAFjT6Y3m9RqeMvk687A5kvgcVeADk=;
        b=PnVhP0AttP8Aq6mk5SNpyMiw5rb8D5UGcfPgYhA0TbOCoO4a+Pccl7MUanXcBJ70Ek
         Ltevf8u5LAQVk3ZIsTxG1fc+GJWOHmjkAjb7noajNNLJC3I+Y94N1lDKqu5sihQ328Ob
         dO74XBibzIFfJGYUVe0VebXS+kY8MLZsAAxfE0t1GHSWrv5ID1mNYwK8hFy+dKM9Zk0q
         8gUjjYc9znPKaTKATJL1P7F+2NsIjp/jwFWOOa08k5Wgf5WYmIpkgPWOnw2D7zJY0b5p
         IOXcqfoLdpzM9h4/KRiNP68C3n2t7rePH1R9MPWjZoO3Iw6lumDLFFBLKGpw+Os9RVxv
         7Qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746561160; x=1747165960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZJa/hAGQmMtbYAFjT6Y3m9RqeMvk687A5kvgcVeADk=;
        b=jKnU2Rfg4NY+BMxhfhpSIFhpxGF3jYU3zNrXjOnu8dZKqeZ7N1TXvqRXLq9zDyPJBX
         /AkmDE725Cnqgvb6zqPCmrSZfxiDXrpoXNG5MYMXE5O7KpvvCiv8jaHY7D/n4QP3+BBx
         CUUDsqqKLD+1qOmJ8MTnJHT7wkggsYXhwnRz8zXLeKI2lYlb0USwfLOrj7r/O1LOm5Q/
         +xwCJ0Sgk/SkJQwaRxWG/KtNkIyvmGJaVqdOpPt10mhNoKBh0t2LR2jjv528GUD/uyWs
         hh0pQ+MfQUPIoa+pK/wv7xpJ7fBwJ+XsZbI1iJw3yje9XALRZGeyDdV64E9NXPWjcaw1
         BuVg==
X-Forwarded-Encrypted: i=1; AJvYcCUIA7NrpFx23zgjuMn6nqr7+vElla6Xz4WDcMyYb4D/viapoI7wKzcu4tSHFojrswCdNLiAJubipe+vrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOit101CvQ0Clk6QA6HK/oZyhTErI6kaD34GRqbG8YJODXR2C0
	CuecoIGsjlM6zUkxHbSt6+o/yufW/y8mO7PWL1pQpEWpJjZOdVTh90URCA==
X-Gm-Gg: ASbGncsewQOcdPVf7yUDD5cR8NsXuOilXbD5BipHVVDC4df1TUmx0mb9sH7DewZpQpt
	aplwE5sxo/29wQxdaEMO1d4m/GteXwT0XKTQgYCfwhjE1209rEvJ+DjK/vwO8T6b9YJ50R0vZNc
	q/87FzsP7yUXFp7jZuUoOuVaILbKi9r3CjOSoOgnkDzvOTbcnzT2Mmo64bXGXfCZoMSHICN/vxy
	yT1MOu415VDaSI825+AcqDZjEGpvtki3XJX2PhOiRjH5+JTyUXZbXLrmtrixSNNqoP+vUnO7L6x
	1sd3DrAo+6MZUXaqmnETd9Fe+WtWtUtJXDgYISEt6rYU1CNCX2qunOEK1paxThQhdg==
X-Google-Smtp-Source: AGHT+IGxbXp8MOaGnJKromxzDDqyTEcL/gmS7ylRWTtawX57VreTQSmyVjz5rWz7xrJXsjaruLAGeg==
X-Received: by 2002:a05:6512:3e05:b0:545:eef:83f1 with SMTP id 2adb3069b0e04-54fb9293c86mr339110e87.17.1746561160095;
        Tue, 06 May 2025 12:52:40 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-54ea94bf179sm2174815e87.80.2025.05.06.12.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 12:52:39 -0700 (PDT)
Date: Tue, 6 May 2025 21:52:39 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
Message-ID: <2lti24dmmhgthwqu7fm2bhvnsjk5ptwisxco6s6gkoo7m4scgw@ucy5letoospc>
References: <20250505030345.GD2023217@ZenIV>
 <20250506193405.GS2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506193405.GS2023217@ZenIV>

On 2025-05-06 20:34:05 +0100, Al Viro wrote:
> it's simpler to do btrfs_reconfigure_for_mount() right after vfs_get_tree() -
> no need to mess with ->s_umount.
>     
> [fix for braino(s) folded in - kudos to Klara Modin <klarasmodin@gmail.com>]
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 7121d8c7a318..75934b25ff47 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1984,17 +1984,13 @@ static int btrfs_get_tree_super(struct fs_context *fc)
>   * btrfs or not, setting the whole super block RO.  To make per-subvolume mounting
>   * work with different options work we need to keep backward compatibility.
>   */
> -static int btrfs_reconfigure_for_mount(struct fs_context *fc, struct vfsmount *mnt)
> +static int btrfs_reconfigure_for_mount(struct fs_context *fc)
>  {
>  	int ret = 0;
>  
> -	if (fc->sb_flags & SB_RDONLY)
> -		return ret;
> -
> -	down_write(&mnt->mnt_sb->s_umount);
> -	if (!(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONLY))
> +	if (!(fc->sb_flags & SB_RDONLY) && (fc->root->d_sb->s_flags & SB_RDONLY))
>  		ret = btrfs_reconfigure(fc);
> -	up_write(&mnt->mnt_sb->s_umount);
> +
>  	return ret;
>  }
>  
> @@ -2047,17 +2043,18 @@ static int btrfs_get_tree_subvol(struct fs_context *fc)
>  	security_free_mnt_opts(&fc->security);
>  	fc->security = NULL;
>  
> -	mnt = fc_mount(dup_fc);
> -	if (IS_ERR(mnt)) {
> -		put_fs_context(dup_fc);
> -		return PTR_ERR(mnt);
> +	ret = vfs_get_tree(dup_fc);
> +	if (!ret) {
> +		ret = btrfs_reconfigure_for_mount(dup_fc);

> +		up_write(&fc->root->d_sb->s_umount);

Looks like this one crept back in.

>  	}
> -	ret = btrfs_reconfigure_for_mount(dup_fc, mnt);
> +	if (!ret)
> +		mnt = vfs_create_mount(dup_fc);
> +	else
> +		mnt = ERR_PTR(ret);
>  	put_fs_context(dup_fc);
> -	if (ret) {
> -		mntput(mnt);
> -		return ret;
> -	}
> +	if (IS_ERR(mnt))
> +		return PTR_ERR(mnt);
>  
>  	/*
>  	 * This free's ->subvol_name, because if it isn't set we have to


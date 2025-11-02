Return-Path: <linux-fsdevel+bounces-66692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3FAC292EF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 02 Nov 2025 17:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87CCF4E837E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Nov 2025 16:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAAF2D8DD3;
	Sun,  2 Nov 2025 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="gmn4oGGi";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="xl0CzPYW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB723F9FB;
	Sun,  2 Nov 2025 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762102342; cv=none; b=mEtj/l3y8idTpoJCjGh1iTdxd6YFb3yoEu14MsUtu2Q1USI6lc1752hC1wmumfHXniymWl75nPAdW5XSfKEU6RKp4ARwTOx2nNRKaxjihCwFahpdgS7ei1SoaSeRcM9rey4mWsRVHHloTGV6ZqrsJchFO7ZpRNDwCrx6ePG3Fgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762102342; c=relaxed/simple;
	bh=tG1mOj5y8K1Rj355ZBd7CzP/NYRIqnJUqCPOUN4cst8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rxk0Msb4gVkS/Ej9kdvXfGKLqsnmRHFjP2T7h4Z9dXswtr5V00smJWFkh8U5XOtXLBu6BPZryE16R+3ugWyVMqmHhU3j3EHYSnVciwqQ9nQ61q07lcEPYdv6+UgaKPVvB/eh9C0uLePrT9AoMdksEu7vUrfb2wlJy46UpcmEaOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=gmn4oGGi; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=xl0CzPYW; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 7D2D92075526;
	Mon,  3 Nov 2025 01:46:30 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1762101990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4QkNrqTpgLaMsgFLBqdiu/J6+OIfL6+92dz7Yt1R3FM=;
	b=gmn4oGGi2SRKL35r8jLaZiYiaLxj8t5VVX5LCx46bxywhpLnQFUUCUY1DjO4hyU7snR4Ig
	Rkq97snouPU35nCQhc+KyxbqifdSYLwiy8NzQmHlBI4X4pzNN9NxxG5ro8A2tjFuV7paN2
	1MvowMqAnXbGUPe2WzvpWcj8bE/rg9po6gwU4DLLV1tyOPXw2wxlyR78r68dM6a4VkhdkD
	KnGeoPDwenWkDypB7MV/W4CBx2Hu/vVbTMpMEW2E7K7ZTKLa582qws+pyMcJvGyMG4Vgw/
	gX/07BG98DlcExX+IqzUw7SL04Wx1NiKvr2yFRTUDQ1/5PEBdqS/pOTlDmh8FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1762101990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4QkNrqTpgLaMsgFLBqdiu/J6+OIfL6+92dz7Yt1R3FM=;
	b=xl0CzPYWUwSRznIVdVLJV6fC1QxPSGvSFQhYGCxy0oZ70bT72kTwQ+ROvIsoBMW9jYxFW0
	y3akGaRVxZqRjmDg==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 5A2GkTiv003147
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 3 Nov 2025 01:46:30 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 5A2GkTOE007358
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 3 Nov 2025 01:46:29 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 5A2GkPRb007356;
	Mon, 3 Nov 2025 01:46:25 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo
 <sj1557.seo@samsung.com>, Jan Kara <jack@suse.cz>,
        Carlos Maiolino
 <cem@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Alexander
 Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        stable@vger.kernel.org, Matthew Wilcox
 <willy@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Yongpeng
 Yang <yangyongpeng@xiaomi.com>
Subject: Re: [PATCH v2] fix missing sb_min_blocksize() return value checks
 in some filesystems
In-Reply-To: <20251102163835.6533-2-yangyongpeng.storage@gmail.com>
References: <20251102163835.6533-2-yangyongpeng.storage@gmail.com>
Date: Mon, 03 Nov 2025 01:46:25 +0900
Message-ID: <87cy60idr2.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yongpeng Yang <yangyongpeng.storage@gmail.com> writes:

> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index 9648ed097816..d22eec4f17b2 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -1535,7 +1535,7 @@ int fat_fill_super(struct super_block *sb, struct fs_context *fc,
>  		   void (*setup)(struct super_block *))
>  {
>  	struct fat_mount_options *opts = fc->fs_private;
> -	int silent = fc->sb_flags & SB_SILENT;
> +	int silent = fc->sb_flags & SB_SILENT, blocksize;
>  	struct inode *root_inode = NULL, *fat_inode = NULL;
>  	struct inode *fsinfo_inode = NULL;
>  	struct buffer_head *bh;
> @@ -1595,8 +1595,13 @@ int fat_fill_super(struct super_block *sb, struct fs_context *fc,
>  
>  	setup(sb); /* flavour-specific stuff that needs options */
>  
> +	error = -EINVAL;
> +	blocksize = sb_min_blocksize(sb, 512);
> +	if (!blocksize) {

	if (!sb_min_blocksize(sb, 512)) {

Looks like this one is enough?

> +		fat_msg(sb, KERN_ERR, "unable to set blocksize");
> +		goto out_fail;
> +	}
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


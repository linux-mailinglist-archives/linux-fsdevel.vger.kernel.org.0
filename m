Return-Path: <linux-fsdevel+bounces-72304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F2ACECFC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 01 Jan 2026 12:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67F4D300B9B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jan 2026 11:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1669A2BEC34;
	Thu,  1 Jan 2026 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="KNc2DDMi";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="HE1jZ4US"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E0240611;
	Thu,  1 Jan 2026 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767266674; cv=none; b=XoxpozzTgvezJexcelwycvwkxkyw0KprTxhSiYJbUXO++KmXlE8/1r3eGhxSr1sasIMUI5maeS9ryoM3zulW/NNsOJWRrkTs8nyfKFaxh6CuNeNLq3dt+jXVX37Q95HpOo33vOK8SJwnud5H3RuaELKVbGq9Zp50Ao15DIFtZTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767266674; c=relaxed/simple;
	bh=aHw79sT7F6RoUH4tPg/dFyb2phyiVplaAzjPGkm/5As=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kg1Ep1LRW9wUcteqznz8QhsKyYgiJrqEtql8RTTFIMnBOT0ApRsu/vfXTFKwXraP/92W83xb6BmFWm/HYJv+y5JB3LdiBa5iv+cWRFjjzbRJbPEBHGO/ySq5I1zApuA+L1VQCm4PM6r5gKqfGICUFJiiPmHbzrOWnbCj7rVS1Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=KNc2DDMi; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=HE1jZ4US; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 87A9720A0176;
	Thu,  1 Jan 2026 20:24:23 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1767266663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WqLCAFnWAseSMYPgrJK+Q0J/3ywiV3ecjwhSDL1Oc5Q=;
	b=KNc2DDMimxWLSdUp1G7fSt8g589lAjyVz1RlRazXtRHArlKlj6fxdhFeB4uL2BwGSLTH3I
	UbQmHW2h6h8gmkbqrNmrt6yMLtfp+KDH3Tzuh2rHtH8BPW43kdcoMCz3HlFYhvPUxLhYK6
	Jgg5iK4rfKBgSQ1YszN+3FjYEdCydyFMwYtBwLiQfx3NhcW7DbOlC8A1JFeMHzvmo3TO+U
	CWeVwQiGeJ1kmFPxzPNfF/NPsUrLgMkpjLv24h1A2c+fpGNDZl30Xl8Aa90yvNlcNUN3hy
	3CAjcorQ+iYBE8lNH01+AzuBCKNPr2cZLGgTp3OghS2Usj1UuK+YJOnqvOHRag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1767266663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WqLCAFnWAseSMYPgrJK+Q0J/3ywiV3ecjwhSDL1Oc5Q=;
	b=HE1jZ4USdJjSVZdmuJu9qyg74Z4mTzdoU4W7khQJDONuSbkjZN1ycRUkN5t4sZg0QByzFE
	TdBc+K+5Ch/qN2Ag==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 601BOMfe304071
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 1 Jan 2026 20:24:23 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 601BOM1K105612
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 1 Jan 2026 20:24:22 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 601BOLnq105611;
	Thu, 1 Jan 2026 20:24:21 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zhiyu Zhang <zhiyuzhang999@gmail.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: avoid parent link count underflow in rmdir
In-Reply-To: <20260101111148.1437-1-zhiyuzhang999@gmail.com>
References: <20260101111148.1437-1-zhiyuzhang999@gmail.com>
Date: Thu, 01 Jan 2026 20:24:21 +0900
Message-ID: <87secph8yi.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zhiyu Zhang <zhiyuzhang999@gmail.com> writes:

> Corrupted FAT images can leave a directory inode with an incorrect
> i_nlink (e.g. 2 even though subdirectories exist). rmdir then
> unconditionally calls drop_nlink(dir) and can drive i_nlink to 0,
> triggering the WARN_ON in drop_nlink().
>
> Add a sanity check in vfat_rmdir() and msdos_rmdir(): only drop the
> parent link count when it is at least 3, otherwise report a filesystem
> error.
>
> Fixes: 9a53c3a783c2 ("[PATCH] r/o bind mounts: unlink: monitor i_nlink")
> Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> Closes: https://lore.kernel.org/linux-fsdevel/aVN06OKsKxZe6-Kv@casper.infradead.org/T/#t
> Tested-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>

Looks good. Thanks.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> ---
>  fs/fat/namei_msdos.c | 7 ++++++-
>  fs/fat/namei_vfat.c  | 7 ++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
> index 0b920ee40a7f..262ec1b790b5 100644
> --- a/fs/fat/namei_msdos.c
> +++ b/fs/fat/namei_msdos.c
> @@ -325,7 +325,12 @@ static int msdos_rmdir(struct inode *dir, struct dentry *dentry)
>  	err = fat_remove_entries(dir, &sinfo);	/* and releases bh */
>  	if (err)
>  		goto out;
> -	drop_nlink(dir);
> +	if (dir->i_nlink >= 3)
> +		drop_nlink(dir);
> +	else {
> +		fat_fs_error(sb, "parent dir link count too low (%u)",
> +			dir->i_nlink);
> +	}
>  
>  	clear_nlink(inode);
>  	fat_truncate_time(inode, NULL, S_CTIME);
> diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
> index 5dbc4cbb8fce..47ff083cfc7e 100644
> --- a/fs/fat/namei_vfat.c
> +++ b/fs/fat/namei_vfat.c
> @@ -803,7 +803,12 @@ static int vfat_rmdir(struct inode *dir, struct dentry *dentry)
>  	err = fat_remove_entries(dir, &sinfo);	/* and releases bh */
>  	if (err)
>  		goto out;
> -	drop_nlink(dir);
> +	if (dir->i_nlink >= 3)
> +		drop_nlink(dir);
> +	else {
> +		fat_fs_error(sb, "parent dir link count too low (%u)",
> +			dir->i_nlink);
> +	}
>  
>  	clear_nlink(inode);
>  	fat_truncate_time(inode, NULL, S_ATIME|S_MTIME);

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


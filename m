Return-Path: <linux-fsdevel+bounces-73276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF45D13F34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 17:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7589D300501A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124C7364E92;
	Mon, 12 Jan 2026 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="M3WpSvEy";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="SW6lEjmm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C3D2D8DD4;
	Mon, 12 Jan 2026 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234864; cv=none; b=D6M1jHxbuQYhstOKfiDraVnCXfRUKmIgn/TJ0tLXi2Dz2sJG7CkgSyRe+WoXuNFe670eOcuqO0XxsD5PxvuhPj67cWDi41RZF4VWHMgE5UznJqEqhm7rlz3IMvselwkJjyxNKizzvNamFqtfBdWgHehL/zIHltG9TW+7hwui9os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234864; c=relaxed/simple;
	bh=lK8ZvD5KSxVpbR6oeoCLUQSDP1N5og5AsP3csxy4dj0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MEDnWHEk/xTlcKcCWKgmDfb+nqBfrdHi5LIQbtOHXf6/HdQP+SpG/93Z2VcMZvW/d/oRKJxZnwHp6Tf5xFGwYCkGNOrzRmovbClk1npq72bl1CeOUwZUVTLW7CT1DdxOxwAdCMh6/mCDuRQNebchvl2aonuc0XlVpOabg6pr+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=M3WpSvEy; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=SW6lEjmm; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 1CE7320A0176;
	Tue, 13 Jan 2026 01:21:00 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1768234860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iVyphRkBzqFzCcw7fXGK5ylS+InfhGEy9ejNCmI2poM=;
	b=M3WpSvEyApUrkDLAs2CyAlOMFX504HjAPAoNs7oGpMJZpQBH6PCuJ70x4iRF1dSkcbIjBu
	CbCMIz7865yBj/cA83L8+tKBVkG4HpcszaDuyJxpaFBAItASGh1NCiTJ881l2xEW/ah+wu
	XaJbNchqrUDniSuPSMxv2mBag5+Fz+ALfyPEL6lC0+9BHLXmaa4I8Lo72Jvo/fO0d7lAJS
	ujVeZ+OF0u+IOAjRZCgZoeCXIrncw6jTc8om/FMNXT8dwYL6dTccSeue1uaV90gMShwJXj
	MvQdc7VBwuRotteBfSsbkw8koT3cYs0WgIaoi03zyl/BXh3OQZ0I0BKCm+CEdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1768234860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iVyphRkBzqFzCcw7fXGK5ylS+InfhGEy9ejNCmI2poM=;
	b=SW6lEjmmzYw5MeeonpFUw2UvMPVEvDsuRo37SrjZ6SKcc221V0seg1ej1djxvEqPy0JdxU
	LxIBDaKfBuBTwkDA==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 60CGKwRF010901
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 01:20:59 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 60CGKwBH019403
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 01:20:58 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 60CGKwaP019400;
	Tue, 13 Jan 2026 01:20:58 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zhiyu Zhang <zhiyuzhang999@gmail.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: avoid parent link count underflow in rmdir
In-Reply-To: <87secph8yi.fsf@mail.parknet.co.jp>
References: <20260101111148.1437-1-zhiyuzhang999@gmail.com>
	<87secph8yi.fsf@mail.parknet.co.jp>
Date: Tue, 13 Jan 2026 01:20:58 +0900
Message-ID: <87ms2idcph.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping?

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> Zhiyu Zhang <zhiyuzhang999@gmail.com> writes:
>
>> Corrupted FAT images can leave a directory inode with an incorrect
>> i_nlink (e.g. 2 even though subdirectories exist). rmdir then
>> unconditionally calls drop_nlink(dir) and can drive i_nlink to 0,
>> triggering the WARN_ON in drop_nlink().
>>
>> Add a sanity check in vfat_rmdir() and msdos_rmdir(): only drop the
>> parent link count when it is at least 3, otherwise report a filesystem
>> error.
>>
>> Fixes: 9a53c3a783c2 ("[PATCH] r/o bind mounts: unlink: monitor i_nlink")
>> Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
>> Closes: https://lore.kernel.org/linux-fsdevel/aVN06OKsKxZe6-Kv@casper.infradead.org/T/#t
>> Tested-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
>> Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
>
> Looks good. Thanks.
>
> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>
>> ---
>>  fs/fat/namei_msdos.c | 7 ++++++-
>>  fs/fat/namei_vfat.c  | 7 ++++++-
>>  2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
>> index 0b920ee40a7f..262ec1b790b5 100644
>> --- a/fs/fat/namei_msdos.c
>> +++ b/fs/fat/namei_msdos.c
>> @@ -325,7 +325,12 @@ static int msdos_rmdir(struct inode *dir, struct dentry *dentry)
>>  	err = fat_remove_entries(dir, &sinfo);	/* and releases bh */
>>  	if (err)
>>  		goto out;
>> -	drop_nlink(dir);
>> +	if (dir->i_nlink >= 3)
>> +		drop_nlink(dir);
>> +	else {
>> +		fat_fs_error(sb, "parent dir link count too low (%u)",
>> +			dir->i_nlink);
>> +	}
>>  
>>  	clear_nlink(inode);
>>  	fat_truncate_time(inode, NULL, S_CTIME);
>> diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
>> index 5dbc4cbb8fce..47ff083cfc7e 100644
>> --- a/fs/fat/namei_vfat.c
>> +++ b/fs/fat/namei_vfat.c
>> @@ -803,7 +803,12 @@ static int vfat_rmdir(struct inode *dir, struct dentry *dentry)
>>  	err = fat_remove_entries(dir, &sinfo);	/* and releases bh */
>>  	if (err)
>>  		goto out;
>> -	drop_nlink(dir);
>> +	if (dir->i_nlink >= 3)
>> +		drop_nlink(dir);
>> +	else {
>> +		fat_fs_error(sb, "parent dir link count too low (%u)",
>> +			dir->i_nlink);
>> +	}
>>  
>>  	clear_nlink(inode);
>>  	fat_truncate_time(inode, NULL, S_ATIME|S_MTIME);

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


Return-Path: <linux-fsdevel+bounces-55725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6F0B0E41F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669671C28538
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 19:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E4D284B3E;
	Tue, 22 Jul 2025 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="LmmEy/FC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9320127FD48
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212422; cv=none; b=Lwh3taJ/IzgBGKCy6tcUiRftsSU40Xv/BvH8bMZYbwr7Wfp7qCYSnCBg0Wjo8bC2n5QA49BFlB5F+ltXGexZ6sw9DEJQWeaGPKEbqrkQ1X6QoDhV8lSk6yNNJ0gRVgBsTv9jZGe6OhMQIMybDS5CMC5UKBnBENLzkXVyQIxjsSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212422; c=relaxed/simple;
	bh=nL7kBrzyr7z+2vE9AXFIMqKnMDrBlfMMLL7j8sAKYoM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VqTu5jpTsq51E05vg6P2VEPEedAelvl5CTtGnrShfXxkIpdFUxKz7N46FOlz7b4YD7X7eRZ4iqEyObo9/4X/cz3r8fe/VEUoBJpKoD25yqjqF9oV2Sb4E+Ol5I3Dq0wNMNRZltBUBnb2gKyYF3Ut/LZjjjPKvqQRjTpq3Lpv+F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=LmmEy/FC; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e8b3cc12dceso3454605276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 12:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1753212419; x=1753817219; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f6rA10mAFSIy2EN44P/5y4VeVI9jpKueAsjkjfz2urE=;
        b=LmmEy/FCJwFTijiejYVnrXN9xZpk1rl/WeLb672iXR6USCKJ3VhtMPcN8Vq4Ttueha
         jBms13N7wPy7ueHXPJGv/cQOTgugvsXy4V22P9/I5O2wLeB4NqCgcUAdINnRlehR4zsW
         VPJltNdP9RQkz9bqmjCZhtVAk/U09va85yeDio8d/pwkij4MXyDf3Q8XT1voIgtS23AW
         8d2Pg2XsVPktqMh+M534MkMkqLkTMehV38PPwFvVG7EUficHe5HseIzTIeqZKDYTWzED
         iTaaBmunNDdp/+o5+H5Qkwqsep2x3vh8i0nP1Xn0qTqMmot5Nie1oVpu9+vfgWg3nhOG
         OENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753212419; x=1753817219;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6rA10mAFSIy2EN44P/5y4VeVI9jpKueAsjkjfz2urE=;
        b=ehsvM6Or+OdoEZWZzzZrqM2a700CHs1EnslhqatNeW7lOd1QoIsBTsXTa6D2jMfuof
         Zqi9qaBATnowndFWHnNyyKd9AMQBX27GFL0LmOPfKYDQTT06bpwB2+UK80spOye4qoIv
         SrthhniC+fJKlbI6c6l7xAfMghO+UTIg8ujlHV3yUuvK74Vah/oJEyFwsRy6jH+HGDx3
         r1GzFVqkzZmY19gb3XRBPN9/1vqh76NEYmHw7AAn2q7h+xhAId00PgEixjVJbArTZa8C
         z5tclRyvt/DdlF7aS/KSkw5eNbh26dgPfw6tKOj4cOIZcIcqH6mW8KQ7cAA4bvGj5E6n
         Uqxw==
X-Gm-Message-State: AOJu0YxhFzdUjjEXmY+KrrKd3ThnzRFaeD2sYmEcZYjN/W/arCpw9CgF
	Uc7eCnG+Yw/XMoVb0bO7uN1ds5/DFWrBfRRsyi9irlvyIqBsz2CMMuwfARNxAWW5UiY=
X-Gm-Gg: ASbGnctfICeIpsJ6NAxCjONerjAo0O3+/su7T3DNBvWZgxBI0UoInmaVY7YZLmpyfBh
	+mlPxxxgJ6+AI57ghJsZ+WFPlLgrO5a9YPq/e1rRqtgAX2x6chRXwE86jnXTD1xheAL0yEry+Rn
	c6JwGA7nQI4VyIdlxIRTisUtJTtuDx7rzfLNUNt7GvsTHSxiInrLqKOfxAQuK1+MyAyH7dGWq8G
	+Z//VbunkYfKkmc46fEr0efOlbJDyD6p1yEDd4Nonqa/dl9bypBZBg24Zgn/skWU39ZsoNmGiE/
	0Za3GuZutLuxJjvaRMd1Za5Ucu2CBI94tT84HhtlHARhQOZP50p3XqkPVJ3HBfGNrKmSNL777JJ
	oMhhK8kse3plq/wrjyRVz34U3IKDJS6DTolRiVSCnzY954uNcYmE4bV9lLr1H4+bsVm2peQ==
X-Google-Smtp-Source: AGHT+IEM19VoZ2NkyDOPbbFddXU+rX7b8ADde+ckX3B0jE15Ou9SvsZhtRtbB/s4TGJTCugucCzFtA==
X-Received: by 2002:a05:6902:161c:b0:e84:3657:e50 with SMTP id 3f1490d57ef6-e8dc5873435mr671236276.3.1753212419284;
        Tue, 22 Jul 2025 12:26:59 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:7b5e:cc7f:ebd6:8d83? ([2600:1700:6476:1430:7b5e:cc7f:ebd6:8d83])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8db79336a4sm787559276.22.2025.07.22.12.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 12:26:58 -0700 (PDT)
Message-ID: <4a9de6f3edb1d7a894437fb5dda18d709285a628.camel@dubeyko.com>
Subject: Re: [PATCH v4 3/3] hfs: fix to update ctime after rename
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yangtao Li <frank.li@vivo.com>, glaubitz@physik.fu-berlin.de
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Jul 2025 12:26:57 -0700
In-Reply-To: <20250722071347.1076367-3-frank.li@vivo.com>
References: <20250722071347.1076367-1-frank.li@vivo.com>
	 <20250722071347.1076367-3-frank.li@vivo.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-22 at 01:13 -0600, Yangtao Li wrote:
> Similar to hfsplus, let's update file ctime after the rename
> operation
> in hfs_rename().
>=20

I am not completely happy about mentioning HFS+ in the patch for HFS.
:) We make this fix because HFS should work in correct way but not
because HFS+ does it. Imagine that HFS+ will completely disappear or
HFS+ code will be heavily changed. Nobody will be able to follow this
comment. I prefer to see the explanation something like "The file ctime
should be updated after rename operation and blah, blah, blah". :) =20

> W/ patch, the following error in xfstest generic/003 disappears:
>=20
> =C2=A0+ERROR: change time has not been updated after changing file1
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v4:
> -update commit msg
> =C2=A0fs/hfs/dir.c | 17 ++++++++++-------
> =C2=A01 file changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
> index 86a6b317b474..756ea7b895e2 100644
> --- a/fs/hfs/dir.c
> +++ b/fs/hfs/dir.c
> @@ -284,6 +284,7 @@ static int hfs_rename(struct mnt_idmap *idmap,
> struct inode *old_dir,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dentry *old_dentry, struct =
inode
> *new_dir,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dentry *new_dentry, unsigne=
d int flags)
> =C2=A0{
> +	struct inode *inode =3D d_inode(old_dentry);
> =C2=A0	int res;
> =C2=A0
> =C2=A0	if (flags & ~RENAME_NOREPLACE)
> @@ -296,14 +297,16 @@ static int hfs_rename(struct mnt_idmap *idmap,
> struct inode *old_dir,
> =C2=A0			return res;
> =C2=A0	}
> =C2=A0
> -	res =3D hfs_cat_move(d_inode(old_dentry)->i_ino,
> -			=C2=A0=C2=A0 old_dir, &old_dentry->d_name,
> +	res =3D hfs_cat_move(inode->i_ino, old_dir, &old_dentry-
> >d_name,
> =C2=A0			=C2=A0=C2=A0 new_dir, &new_dentry->d_name);
> -	if (!res)
> -		hfs_cat_build_key(old_dir->i_sb,
> -				=C2=A0 (btree_key
> *)&HFS_I(d_inode(old_dentry))->cat_key,
> -				=C2=A0 new_dir->i_ino, &new_dentry-
> >d_name);
> -	return res;
> +	if (res)
> +		return res;
> +
> +	hfs_cat_build_key(old_dir->i_sb, (btree_key *)&HFS_I(inode)-
> >cat_key,
> +			=C2=A0 new_dir->i_ino, &new_dentry->d_name);
> +	inode_set_ctime_current(inode);
> +	mark_inode_dirty(inode);
> +	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0const struct file_operations hfs_dir_operations =3D {

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.


Return-Path: <linux-fsdevel+bounces-69268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1A8C76216
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 20:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9D3CD3586F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 19:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B300303A2A;
	Thu, 20 Nov 2025 19:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="AjGvcTcr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD941FA15E
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 19:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763668411; cv=none; b=leYB7nMJCGh0KB3DhxaaBWhr48NaK5dRXM84GqszB4GA47w9rrQ45ijbwCaXH870Pqjp5pvzao2H5p4JI7dYj/13T/K7SV/HC6l2hVPws1Plhk0mHOiJyIgBA8vEoMIcQB7VQrjFVss36CZyHxR4A+6kqLq49FwYVC1Dc/3UYq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763668411; c=relaxed/simple;
	bh=EpmKL9sXRg4mi+3fXVKfEnFV1GqgIw7hg9d518bHrRA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YgJx1x0bX19hR31lcDPkxxVkcWW9mPr0FY3iux2IQxhCuyULOE8R4Ar1zmXg3sdZCfnxK6QBhj4FCsH01QO8W3k4y9jRlwLp6dmX5xpLDGnbFG5TXGQOQbqf+LJ0NHbrDGWPgquuZ2E9VVFCSGMOgOm09PVaROfAhgsyyDGq1mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=AjGvcTcr; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3ec31d2b7f8so331334fac.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 11:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1763668407; x=1764273207; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2FwvuG/ZjappW3jn6ujjAZi2Kq4FZjtYEBpZApP8KQU=;
        b=AjGvcTcr63RzFBjT+nIj39WCQIh720uHpS8ARFtMmQoULA4Yy5BzfdPtLKXMLZvuIZ
         dn1/qTOjlJACHY7TX3CQBPsBKxE0cjaBxF4qX3j8w/imn9i+KcXHcPJMik+W0a9O9+cL
         bHxQlGM0J/eLqN1xtDVo3oNAcpY7vEzYqcB2qRFPRSe73gSpnghfF3BEFAxGDD1Lbt0+
         R4+lLiY7bSMqw8ASsdQdK0yRQqkfYNC2mI4B9ruuMz35T7Pvhpfei9zzqoZyT2o2j8Oo
         YHJrtY1l4avh0xBRQ7b3Jy+sJ2uaA/4NHC3Owto/O0vKkFYo3hi09QFWk4akXUhufysc
         hkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763668407; x=1764273207;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2FwvuG/ZjappW3jn6ujjAZi2Kq4FZjtYEBpZApP8KQU=;
        b=pa6gPLJXDFImhCAWfQN/CjABO1/FRhvXF5Dbbp0wL14fTGnWuKR1ewoKPp6scod8vi
         7G1uuL3AHafYZgRaVFIvGW3Flzwk9TeQ5zJkipl22TdG+p0DP/psDJtpuQ6qMfWj0Ysv
         xhdivXcEuS+Rmib8cST52Izewrs6QMYXv5Qu4cjus88Uq72qhSjnDSUQ64tTbqqTNRVJ
         pSFrJ2wIRUbckhF+AvhG+6J6ZeacqmcFHWLv5iG98/pzw9KsdFL8TIc80/YoWvmsS2HP
         6i2c9piHlD7KVYdW1vGwV3GcJy/PqRlBy6ym4Op+u3wPBcwz9yE1h4/M9bNP6xNv2F6a
         iYzw==
X-Forwarded-Encrypted: i=1; AJvYcCV0ifktO1tlwtWNJ+pRcxTf9LM44z2QHKp60dPtBSONON+LWeNlERVk8F6Tek10IthpQ5pKpVIdceogUM2b@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9S0f/CBqR1vyR0w9a+JcJ25pcWUqj5cAXcqGhIeZZ3OYbzgEm
	esHRW/H0a6jEgLxLPoom7+5MyJcqIJFam4CHVaCzERM22mJqDFb1GXQREMaGoNZ4honOKD8ubZa
	Zr1t/
X-Gm-Gg: ASbGncsK0XMqVa/20JOcZOIadjBObcYhyjBuIwYkBNzhJ+Q3O5KYuDRzkxCq5LHTBI3
	U082k9C6p1qt/oXftlExA43jO8WdxnUaDZjyasxFq5rcGSSsxDE0Rd2Fcl9dOIIiZuT1kfCsvXm
	FsbZM11Ut4ASgKWptlPMBEuz0cYxtXIpz+2q/+TMOQL5vCuV6V6avVRdlsdhqje+KkxtAlW3uia
	PD5RYZepSGxTAQYkEvOal+zLkcJlTHVJilUTgFWlSUUaPBD1wFqYx8VcEUMiyDwpwik5XOZv9Xn
	aelmpdAmFpXySgGOJJSk4qsiFZdji2uFI5WnCnEGKZIwu+o+XrhxQCyY/txRzGwRMbECcOKE0ex
	PShBmb6sUw5dBOD0E4VXv/dzQ9cnhIdPVPaZBUd84YITb0xC9BUsLcvQ6T+zUnQX02RiRcH7TDa
	jHCq62RBrejv4flneUk5oZDIIXC78LyiYmnUyM8z63lg4EAzoVg8GBqgwk+WI=
X-Google-Smtp-Source: AGHT+IHNLf75ivNOgnRICJmmmXmk2GuwcIE6M6TyJEbH23QODwqgGPiz7g+YNbpLjHEYXKsH5ao8Kg==
X-Received: by 2002:a05:6808:21a4:b0:44f:6ab9:4b14 with SMTP id 5614622812f47-450ff41a1e3mr1684328b6e.62.1763668407487;
        Thu, 20 Nov 2025 11:53:27 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:ef59:1f11:e678:b7b4? ([2600:1700:6476:1430:ef59:1f11:e678:b7b4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65782a359efsm1009399eaf.4.2025.11.20.11.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 11:53:26 -0800 (PST)
Message-ID: <54e47f6ae96b4ed9bc30bd8c58487fa4d5cb6538.camel@dubeyko.com>
Subject: Re: [PATCH] Replace BUG_ON with error handling in hfs_new_inode()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com
Date: Thu, 20 Nov 2025 11:53:25 -0800
In-Reply-To: <20251103131023.2804655-1-jkoolstra@xs4all.nl>
References: <20251103131023.2804655-1-jkoolstra@xs4all.nl>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-03 at 14:10 +0100, Jori Koolstra wrote:
> In a06ec283e125 next_id, folder_count, and file_count in the super
> block
> info were expanded to 64 bits, and BUG_ONs were added to detect
> overflow. This triggered an error reported by syzbot: if the MDB is
> corrupted, the BUG_ON is triggered. This patch replaces this
> mechanism
> with proper error handling and resolves the syzbot reported bug.
>=20
> hfs_new_inode() is the only place were the 32-bit limits need to be
> verified, since only in that function can these values be increased.
> Therefore, the checks in hfs_mdb_commit() and hfs_delete_inode() are
> removed.
>=20

I am terribly sorry, I've missed the patch. But, please, please,
please, add prefix 'hfs:' to the topic. This is the reason why I've
missed the patch. I expected to see something like this:

hfs: Replace BUG_ON with error handling in hfs_new_inode()

I need to process dozens emails every day. So, if I don't see proper
keyword in the topic, then I skip the emails.


> Singed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> Reported-by: syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com
> Closes: https://syzbot.org/bug?extid=3D17cc9bb6d8d69b4139f0
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
> =C2=A0fs/hfs/dir.c=C2=A0=C2=A0 |=C2=A0 8 ++++----
> =C2=A0fs/hfs/inode.c | 30 ++++++++++++++++++++++++------
> =C2=A0fs/hfs/mdb.c=C2=A0=C2=A0 |=C2=A0 3 ---
> =C2=A03 files changed, 28 insertions(+), 13 deletions(-)
>=20
> diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
> index 86a6b317b474..ee1760305380 100644
> --- a/fs/hfs/dir.c
> +++ b/fs/hfs/dir.c
> @@ -196,8 +196,8 @@ static int hfs_create(struct mnt_idmap *idmap,
> struct inode *dir,
> =C2=A0	int res;
> =C2=A0
> =C2=A0	inode =3D hfs_new_inode(dir, &dentry->d_name, mode);
> -	if (!inode)
> -		return -ENOMEM;

I don't think that this removal is correct. The hfs_new_inode() can
return NULL [1].

> +	if (IS_ERR(inode))
> +		return PTR_ERR(inode);
> =C2=A0
> =C2=A0	res =3D hfs_cat_create(inode->i_ino, dir, &dentry->d_name,
> inode);
> =C2=A0	if (res) {
> @@ -226,8 +226,8 @@ static struct dentry *hfs_mkdir(struct mnt_idmap
> *idmap, struct inode *dir,
> =C2=A0	int res;
> =C2=A0
> =C2=A0	inode =3D hfs_new_inode(dir, &dentry->d_name, S_IFDIR | mode);
> -	if (!inode)
> -		return ERR_PTR(-ENOMEM);

Ditto. Please, take a look here [1].

> +	if (IS_ERR(inode))
> +		return ERR_CAST(inode);
> =C2=A0
> =C2=A0	res =3D hfs_cat_create(inode->i_ino, dir, &dentry->d_name,
> inode);
> =C2=A0	if (res) {
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index 9cd449913dc8..beec6fe7e801 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -186,16 +186,23 @@ struct inode *hfs_new_inode(struct inode *dir,
> const struct qstr *name, umode_t
> =C2=A0	s64 next_id;
> =C2=A0	s64 file_count;
> =C2=A0	s64 folder_count;
> +	int err =3D -ENOMEM;
> =C2=A0
> =C2=A0	if (!inode)
> -		return NULL;
> +		goto out_err;

OK. I see. You have modified the hfs_new_inode() with the goal to
return error code instead of NULL.

Frankly speaking, I am not sure that inode is NULL, then it means
always that we are out of memory (-ENOMEM).

> +
> +	err =3D -ENOSPC;

Why do we use -ENOSPC here? If next_id > U32_MAX, then it doesn't mean
that volume is full. Probably, we have corrupted volume, then code
error should be completely different (maybe, -EIO).

> =C2=A0
> =C2=A0	mutex_init(&HFS_I(inode)->extents_lock);
> =C2=A0	INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
> =C2=A0	spin_lock_init(&HFS_I(inode)->open_dir_lock);
> =C2=A0	hfs_cat_build_key(sb, (btree_key *)&HFS_I(inode)->cat_key,
> dir->i_ino, name);
> =C2=A0	next_id =3D atomic64_inc_return(&HFS_SB(sb)->next_id);
> -	BUG_ON(next_id > U32_MAX);
> +	if (next_id > U32_MAX) {
> +		pr_err("hfs: next file ID exceeds 32-bit limit =E2=80=94
> possible "
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "superblock corruption");

The 'hfs:' prefix is not necessary here. It could be not only file but
folder ID too. So, maybe, it makes sense to mention "next CNID". The
whole comment needs to be on one line. Also, I believe it makes sense
to recommend run FSCK tool here.

> +		goto out_discard;
> +	}
> =C2=A0	inode->i_ino =3D (u32)next_id;
> =C2=A0	inode->i_mode =3D mode;
> =C2=A0	inode->i_uid =3D current_fsuid();
> @@ -209,7 +216,11 @@ struct inode *hfs_new_inode(struct inode *dir,
> const struct qstr *name, umode_t
> =C2=A0	if (S_ISDIR(mode)) {
> =C2=A0		inode->i_size =3D 2;
> =C2=A0		folder_count =3D atomic64_inc_return(&HFS_SB(sb)-
> >folder_count);
> -		BUG_ON(folder_count > U32_MAX);
> +		if (folder_count > U32_MAX) {
> +			pr_err("hfs: folder count exceeds 32-bit
> limit =E2=80=94 possible "
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "superblock corruption");

Ditto.

> +			goto out_discard;
> +		}
> =C2=A0		if (dir->i_ino =3D=3D HFS_ROOT_CNID)
> =C2=A0			HFS_SB(sb)->root_dirs++;
> =C2=A0		inode->i_op =3D &hfs_dir_inode_operations;
> @@ -219,7 +230,11 @@ struct inode *hfs_new_inode(struct inode *dir,
> const struct qstr *name, umode_t
> =C2=A0	} else if (S_ISREG(mode)) {
> =C2=A0		HFS_I(inode)->clump_blocks =3D HFS_SB(sb)->clumpablks;
> =C2=A0		file_count =3D atomic64_inc_return(&HFS_SB(sb)-
> >file_count);
> -		BUG_ON(file_count > U32_MAX);
> +		if (file_count > U32_MAX) {
> +			pr_err("hfs: file count exceeds 32-bit limit
> =E2=80=94 possible "
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "superblock corruption");

Ditto.

> +			goto out_discard;
> +		}
> =C2=A0		if (dir->i_ino =3D=3D HFS_ROOT_CNID)
> =C2=A0			HFS_SB(sb)->root_files++;
> =C2=A0		inode->i_op =3D &hfs_file_inode_operations;
> @@ -243,6 +258,11 @@ struct inode *hfs_new_inode(struct inode *dir,
> const struct qstr *name, umode_t
> =C2=A0	hfs_mark_mdb_dirty(sb);
> =C2=A0
> =C2=A0	return inode;
> +
> +	out_discard:
> +		iput(inode);=09
> +	out_err:
> +		return ERR_PTR(err);=20
> =C2=A0}
> =C2=A0
> =C2=A0void hfs_delete_inode(struct inode *inode)
> @@ -251,7 +271,6 @@ void hfs_delete_inode(struct inode *inode)
> =C2=A0
> =C2=A0	hfs_dbg("ino %lu\n", inode->i_ino);
> =C2=A0	if (S_ISDIR(inode->i_mode)) {
> -		BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) >
> U32_MAX);

I don't agree with complete removal of this check. Because, we could
have bugs in file system logic that can increase folder_count
wrongfully above U32_MAX limit.

So, I prefer to have this check in some way. Error code sounds good.

>=20
> =C2=A0		atomic64_dec(&HFS_SB(sb)->folder_count);
> =C2=A0		if (HFS_I(inode)->cat_key.ParID =3D=3D
> cpu_to_be32(HFS_ROOT_CNID))
> =C2=A0			HFS_SB(sb)->root_dirs--;
> @@ -260,7 +279,6 @@ void hfs_delete_inode(struct inode *inode)
> =C2=A0		return;
> =C2=A0	}
> =C2=A0
> -	BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);

Ditto. I don't agree with complete removal of this check.

> =C2=A0	atomic64_dec(&HFS_SB(sb)->file_count);
> =C2=A0	if (HFS_I(inode)->cat_key.ParID =3D=3D
> cpu_to_be32(HFS_ROOT_CNID))
> =C2=A0		HFS_SB(sb)->root_files--;
> diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> index 53f3fae60217..1c3fb631cc8e 100644
> --- a/fs/hfs/mdb.c
> +++ b/fs/hfs/mdb.c
> @@ -273,15 +273,12 @@ void hfs_mdb_commit(struct super_block *sb)
> =C2=A0		/* These parameters may have been modified, so write
> them back */
> =C2=A0		mdb->drLsMod =3D hfs_mtime();
> =C2=A0		mdb->drFreeBks =3D cpu_to_be16(HFS_SB(sb)-
> >free_ablocks);
> -		BUG_ON(atomic64_read(&HFS_SB(sb)->next_id) >
> U32_MAX);

Ditto. I don't agree with complete removal of this check.

> =C2=A0		mdb->drNxtCNID =3D
> =C2=A0			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)-
> >next_id));
> =C2=A0		mdb->drNmFls =3D cpu_to_be16(HFS_SB(sb)->root_files);
> =C2=A0		mdb->drNmRtDirs =3D cpu_to_be16(HFS_SB(sb)-
> >root_dirs);
> -		BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) >
> U32_MAX);

Ditto. I don't agree with complete removal of this check.

> =C2=A0		mdb->drFilCnt =3D
> =C2=A0			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)-
> >file_count));
> -		BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) >
> U32_MAX);

Ditto. I don't agree with complete removal of this check.

> =C2=A0		mdb->drDirCnt =3D
> =C2=A0			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)-
> >folder_count));
> =C2=A0

Thanks,
Slava.

[1]
https://elixir.bootlin.com/linux/v6.18-rc6/source/fs/hfs/inode.c#L190


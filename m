Return-Path: <linux-fsdevel+bounces-72620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26093CFE426
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 15:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E0F43031967
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 14:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F8D34105C;
	Wed,  7 Jan 2026 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPhSGUID"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9513081AD
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 14:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795476; cv=none; b=oeWXlRpMTAABaEVZa2/0ZOOQ/zyFlnOe7RF3Q2/0XAYrVBb21JWE3KPS1sZQOnfAxff/4tPeG6yen8CwfU8cMGhjVOmXTGid8NOEDcIsI75lM087/zDp1JzYrlLv8pgNP9bDiNfX/hiG0qt04dGD6hn22CPiSHP6PATt1DKfuyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795476; c=relaxed/simple;
	bh=VJ25AyciqF2kjhPU+1oAs0tnkPrzzf43OFRA4A7Iio0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6w3w5LY/tjjOZhklx1+baGNFuJVfuIC8kZ8M6P7XPiDixmNuHWlLkCFjlLlKG05EDWcivE4v/eGSy4l2Se2+Vqpzo/pmu7bjI9pztov5nrU/UtpwVANQA5NO0h/Bi13I9DgtHTGKoSnSuUj4L1NcJqEMFUkpCUkZJN3RJaK94Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPhSGUID; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64d02c01865so3271714a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 06:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767795473; x=1768400273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66/bratGcGZn3HnR1gbqSFDvt/cdcUi63+Tx3HjsjYs=;
        b=YPhSGUID+l9A9zAAubNFYgOAmxY271qFuqttPRpOG2N5wfa0sIYrMcpnQy9Ek7d2u2
         ntwFJNrmrU/4JllEjYzcZvuxHr6STl1EZFMSNZl9GDgtcEbHe6RzDkZzQ4EhHIZWnVzu
         vxaoyk2BL/IXGDQ+yOVgnAhi6rntDySvxZaMs7Dupt1Xv4Y2TunGruDkTheCzVYVhH/D
         JNiSdUpDLfwKVGu8bhXZb0+Al2xPHxbABl01/DwjXmGrEejorQ4BF65Yb+lx/mmrXFW/
         M/ZXGckoNs0NtgWq4CRyTQajhX8fxuL7gvfAT6hFN/T5LNLogXhxYUpPzryWPBVKcE68
         WmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767795473; x=1768400273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=66/bratGcGZn3HnR1gbqSFDvt/cdcUi63+Tx3HjsjYs=;
        b=xP8tHjroATbwtkLQ35vc+QqBkQNcGa3BbWswWBn6I9O66XpKW5dbEbO8TVaopDogf0
         F5HJxM9JgKSA8sPHa3iBKp9X50MHLPe5+2GHa+Ba4TSR2FD8RGsx+GJBtVG+9ck2YTa4
         5TXsDZtFgRJLPoIlOgkAlEsK9tWeXFuBxqG+QZbLjlFdp2fcNhyJIUq1e4Egmgv9gXI6
         NSHTOBo+fOZnCl86IZ2m9UFZMQfcw/c7Gj9cav/1rYZRALZu3fk0kaeWYEUTPehZhLr4
         6xvK6anFNB401mQ3dmk1/QA7PDSKMBMFdhJ6PZvK+AJk4qx9r4IcyYLWwPurBZKEVOUi
         iwew==
X-Forwarded-Encrypted: i=1; AJvYcCUIQS11BhlFxmormCtBbZHNrNtDODL3pUZVNUTdEijr6lCAGdPrnOzU5XaS/ynhKQlh7LdTfcyPD/AuJ057@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoe9ICeaJrwoRIilKoikaqt8/jup5ubUfWpg6rHFYUrYTGCK84
	I1qJkMb46+9CrJROGHBMaTZv5VT7CwrYOnqs3bV2U6YcA2CB1hM6LayXRx6Bj0jK8R7k2hnSAGT
	2MkdjIGiDjVLFMZ845tejoTSGV7Yqack=
X-Gm-Gg: AY/fxX5/PcwlpQpxV4IbaOJB/40LwHpf+i+HY9GMKbb7Wr1AIdI57jIMxvaVbSr35QE
	zjvPASnvBT+ODayTCin7482bM1y/c0TaUyP+LAT/atkLIFSz7/EmzjcB3FIKkmdtEtXlSngftML
	YmLGPaQkBQYM5zIJ+zNzxbQGOHjTZqxbyGpmvjSIlym6JY7DmRdqMPYNGL8LPTn+UxeH9uK/wYn
	O1PJ55WCqOcwg5DoCmZ9wmt+9hzJs/XhNhFRDVz8CFVyfxNVNza8sTIaZvEnTtUGIAuRxILDDmk
	198gSPF56T0/kwoe3E0h51kR
X-Google-Smtp-Source: AGHT+IGwBeL+3ReIOmeDcm6tiJoBaKwtDhTciSHSOlHH39RHrINRD6DpanjJ1xFidurvZjT2MbvFb6ekBVq3vsI7i9s=
X-Received: by 2002:a05:6402:26cc:b0:64d:498b:aeff with SMTP id
 4fb4d7f45d1cf-65097e8e49bmr2412344a12.34.1767795472638; Wed, 07 Jan 2026
 06:17:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-likely_device-v1-1-0c55f83a7e47@debian.org>
In-Reply-To: <20260107-likely_device-v1-1-0c55f83a7e47@debian.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 7 Jan 2026 15:17:40 +0100
X-Gm-Features: AQt7F2pKYdwNu8dw95A9vqc5SlwLTJLIWmx9uDoMlLvhq1Aa9_Mu9ZX4QeBKFII
Message-ID: <CAGudoHESsM03W+Qo3sHP5FEXZOxF_bHBYFErYx81wZwWdq5ANg@mail.gmail.com>
Subject: Re: [PATCH] device_cgroup: remove branch hint after code refactor
To: Breno Leitao <leitao@debian.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, rostedt@goodmis.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 3:06=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> commit 4ef4ac360101 ("device_cgroup: avoid access to ->i_rdev in the
> common case in devcgroup_inode_permission()") reordered the checks in
> devcgroup_inode_permission() to check the inode mode before checking
> i_rdev, for better cache behavior.
>
> However, the likely() annotation on the i_rdev check was not updated
> to reflect the new code flow. Originally, when i_rdev was checked
> first, likely(!inode->i_rdev) made sense because most inodes were(?)
> regular files/directories, thus i_rdev =3D=3D 0.
>
> After the reorder, by the time we reach the i_rdev check, we have
> already confirmed the inode IS a block or character device. Block and
> character special files are precisely defined by having a device number
> (i_rdev), so !inode->i_rdev is now the rare edge case, not the common
> case.
>
> Branch profiling confirmed this is 100% mispredicted:
>
>   correct incorrect  %    Function                      File             =
 Line
>   ------- ---------  -    --------                      ----             =
 ----
>         0   2631904 100   devcgroup_inode_permission    device_cgroup.h  =
 24
>
> Remove likely() to avoid giving the wrong hint to the CPU.
>
> Fixes: 4ef4ac360101 ("device_cgroup: avoid access to ->i_rdev in the comm=
on case in devcgroup_inode_permission()")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/linux/device_cgroup.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/device_cgroup.h b/include/linux/device_cgroup.=
h
> index 0864773a57e8..822085bc2d20 100644
> --- a/include/linux/device_cgroup.h
> +++ b/include/linux/device_cgroup.h
> @@ -21,7 +21,7 @@ static inline int devcgroup_inode_permission(struct ino=
de *inode, int mask)
>         if (likely(!S_ISBLK(inode->i_mode) && !S_ISCHR(inode->i_mode)))
>                 return 0;
>
> -       if (likely(!inode->i_rdev))
> +       if (!inode->i_rdev)
>                 return 0;
>

The branch was left there because I could not be bothered to analyze
whether it can be straight up eleminated with the new checks in place.

A quick look at init_special_inode suggests it is an invariant rdev is
there in this case.

So for the time being I would replace likely with WARN_ON_ONCE . Might
be even a good candidate for the pending release.


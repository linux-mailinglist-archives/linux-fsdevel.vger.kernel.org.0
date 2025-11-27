Return-Path: <linux-fsdevel+bounces-70006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77560C8E050
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 12:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A721351E84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 11:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96A232D421;
	Thu, 27 Nov 2025 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb72HO2y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA6D32C329
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764242529; cv=none; b=M3dPLAxn1zMGzqa4yo211Kbz2NlGZ03si5fz+MfOcP1euBuC0WiS39pwUblwP06jchF9NB+7GjeBAuR/VwiApzJUlGg0ZZFigJ5j17beo6OG+Jyba+pHge+fxRHS0WGEXKK/91Rgh18+bzAsO+5b7hygG0+fJdr9QkL2QZNkAAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764242529; c=relaxed/simple;
	bh=ZBgb5nFSb8ceeSDuy3uacyuZ4JuhvybhmD0o/aRMH7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOKp1jr9M/VhFewK1eoozFFOroSO9e3hkPL010P9sHKc1tnhdTfW+WCu5vMl+WsaAUpkrMoYHgS6mBtnemR+YG8rlAJFGr+HNbnBBYLkyyf8vaJLtsZ1vgosonhB3077/kFFe1MEtcPZ+tY9aK42mAUAbxbOgyfD39UpNTXxdV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jb72HO2y; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso1228845a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 03:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764242525; x=1764847325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjPt5R+F3j0Q9az84lkNfE7LfFMYdQ6MjDpEAvVQYZ8=;
        b=Jb72HO2yET8f38IDoi6/6jyVELuBVg+Pc1wkYhyX/gzgdtHtUf53A0+jSV0Eqegou6
         TsLDqwjyTxVRbP+4jf5JwS0+p/E0yazwidbHTDb/zN4wmRhRyUgYTNikOX9TU/PuUaQf
         HfMZ7qXI8alSXHX3PUuIk5cOZE1xbJd0Qb3LB3oonSWeo8JBrtlbRI0ImAlHlIVhufim
         irAVR1oUJNcTbLqDRnlGkIiPL5DEfeMMKlkU02sp0QdUv0pZBT6np86YnpBk0wo5lXIB
         z054SehnrsWctYP/OtwYpJ9oH52Wh7YUgahUBieHh4xzFdOtaxrqTxXY2d+npU9dwkXn
         1Iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764242525; x=1764847325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LjPt5R+F3j0Q9az84lkNfE7LfFMYdQ6MjDpEAvVQYZ8=;
        b=wMkuPSBp4DWHvdJMoRmYEfNU4KyzrYrtQhF4QYz9bzeCRkq1S0V9XU270uz/jF8ywV
         R7TAM0v/cClG3dcJTwPKmMM17Nt71atKkRppJoTB1EEL0cCBXv4cIMVtRpLKJ+dkgjbR
         A/6IMBp/uqZ6nPQyZ29OidcdO80ahrBnkQhVKNkrgW25bmLyWKHD3aTOHtLbv7u7CGrw
         rDgOhQKwP46Mpp6vd0rfQuIFZ7NBinBAXRlJpyaX/FOEoL6o9srw7vutuMCXYOK+xlcx
         TGlKruuzH90sxtSri/fxF6KskNU1jp/gAmmA2DBOb0nKOEXZ/8f/GxYpdQtQCk++mc27
         elxA==
X-Forwarded-Encrypted: i=1; AJvYcCV+9KUNEd4Q+NmugLlMKp7SikXwMMVIuHaRG6NBWWAJssSOhhSzO0VnszR5QbZY7E1ew/FDtL4IS0NtKk2k@vger.kernel.org
X-Gm-Message-State: AOJu0YyW0P0RkNZjdUpkk6KKwR7qtrm1jWHBCnaSKNWP6HDVRsboucnh
	Boyb6QiAlQj6nCigLX6kHtdf+2ZRARH/J+dMAcwD9u+5DcP7eFIlITp3GK6g1kmv9tWcrRC9kvc
	LOYanSuXxn7wkoUg90a1YE1cMHPZfO+0=
X-Gm-Gg: ASbGncsBO8riE8tlxc53aq4dgzGQ00j8UTpL+Fo9yllh1qAxmR/ovau84H63Z9522Jd
	aIK2GM1qf0t2UxZNktKijAlTxgJXaKOe/ZAGOTncx4ue1wXVheOuTwPPIy/wUEIwd2JxiVLx8j/
	R2MNuKwaszsCJYsiVcvJeweLElrMEMFmh3lvQs98Zf3+iXFA8OSOUnoEPT9Pf9d1sIghHW9XcFs
	dVaTo0qR5NY4l5HOHVhjT51E73BqD0Y/YKD7yEWxFSIsUr/U4fERE2G8coin7FRt2l2dhGQ8wOv
	tyoUTC/g5SAdEhKKZMVjyDbhWGM=
X-Google-Smtp-Source: AGHT+IETaEAy+6/CJBc7PbXuxh96AqZ2+hj7zIjTPs2GsVABH4FR0jm7eIjUcTQLYaxgas3BhtOQW7FmABZIXgn0BhY=
X-Received: by 2002:a05:6402:430f:b0:641:27d8:ec72 with SMTP id
 4fb4d7f45d1cf-645eb23f78cmr9742345a12.4.1764242524157; Thu, 27 Nov 2025
 03:22:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127045944.26009-1-linkinjeon@kernel.org> <20251127045944.26009-12-linkinjeon@kernel.org>
In-Reply-To: <20251127045944.26009-12-linkinjeon@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 27 Nov 2025 12:21:50 +0100
X-Gm-Features: AWmQ_bmrpdD94p3gZX2upe-fQZGvwljla9tDqAVZ8Hr5CXSGPPQcLfDJYy-PP-E
Message-ID: <CAOQ4uxhwy1a+dtkoTkMp5LLJ5m4FzvQefJXfZ2JzrUZiZn7w0w@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] ntfsplus: add Kconfig and Makefile
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 6:01=E2=80=AFAM Namjae Jeon <linkinjeon@kernel.org>=
 wrote:
>
> This adds the Kconfig and Makefile for ntfsplus.
>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  fs/Kconfig           |  1 +
>  fs/Makefile          |  1 +
>  fs/ntfsplus/Kconfig  | 45 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/ntfsplus/Makefile | 18 ++++++++++++++++++
>  4 files changed, 65 insertions(+)
>  create mode 100644 fs/ntfsplus/Kconfig
>  create mode 100644 fs/ntfsplus/Makefile
>
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 0bfdaecaa877..70d596b99c8b 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -153,6 +153,7 @@ menu "DOS/FAT/EXFAT/NT Filesystems"
>  source "fs/fat/Kconfig"
>  source "fs/exfat/Kconfig"
>  source "fs/ntfs3/Kconfig"
> +source "fs/ntfsplus/Kconfig"
>
>  endmenu
>  endif # BLOCK
> diff --git a/fs/Makefile b/fs/Makefile
> index e3523ab2e587..2e2473451508 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -91,6 +91,7 @@ obj-y                         +=3D unicode/
>  obj-$(CONFIG_SMBFS)            +=3D smb/
>  obj-$(CONFIG_HPFS_FS)          +=3D hpfs/
>  obj-$(CONFIG_NTFS3_FS)         +=3D ntfs3/
> +obj-$(CONFIG_NTFSPLUS_FS)      +=3D ntfsplus/

I suggested in another reply to keep the original ntfs name

More important is to keep your driver linked before the unmaintained
ntfs3, so that it hopefully gets picked up before ntfs3 for auto mount type
if both drivers are built-in.

I am not sure if keeping the order here would guarantee the link/registrati=
on
order. If not, it may make sense to mutually exclude them as built-in drive=
rs.

Thanks,
Amir.


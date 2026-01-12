Return-Path: <linux-fsdevel+bounces-73282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A855D14767
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 18:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC83D3026A83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 17:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA02337E30C;
	Mon, 12 Jan 2026 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8tp834T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AB930E82B
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239934; cv=none; b=CrZ3thmIAASznMBAjF3FIOsjep6+M3C+N/KFe85uRTqxF7TDUSoLzoi36Ne6u6YT2ZLbWiG++Mo3vlRDZwkXgfBkw9g77+8bFQtLQB7FMYYjWphy3Wg9z0KbAFXb1BDRQFtie99HyXH0KKhbXG5DCxIlH7zIkFYDiZREUhDrJoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239934; c=relaxed/simple;
	bh=OLDySxrdjv8GK+kHtsI/1FnIh0DubqjFbYlsVaHNzjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7A+U+IJJsTpqE5i3Y4dWxGoE+Z0YfNH61fam8ewcFo42T449H4nH5xUvwLXW0vi8GoxiTizHjEjE2w+Pgwcoe6mlJ20s0ypmLa9DnLBYNr5jf1070wYS15zhTz3QL9/Y/oGbRKLP4UoDcS23JzgguNhsN+hfp6/HHRVNEUDxE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8tp834T; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7ce2b17a2e4so4334201a34.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 09:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768239932; x=1768844732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaeXPkWs8aefr/j6ms/BLzdF95n2jhgjYJYOmdDwis0=;
        b=c8tp834TJLahSvsCYuCqHLSI1c1Wxj190RxjwNqlw+FwcjbEzHpnV/ptPxaKzzND6E
         1JswBAB5Cj0/c+91wpakUS6XUXq5QEhjiUOS66R+DeAha22xEPme+g2oqb5Z5RpQTRE7
         3B9ycl2YbSzDnVAy3KnHZKMKKC/R0IfKvupeDF7JxUbo1pzDIRGSjf7Ji/9zAPVpXOpi
         723GionhKn3dBrOnMf7BEmpP/xis/KB6/i4cAdqQKTrZnz3to4mvrCoN45uEYMEqroDl
         Aiu7NYaT1OzA588lGBy7B1e2bjm8apQB1c3zFdHmzpVkUgxsWjVXJXrubTalFjHrvmIQ
         EtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768239932; x=1768844732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aaeXPkWs8aefr/j6ms/BLzdF95n2jhgjYJYOmdDwis0=;
        b=ZWQu0CHK0us3y26JcWKApbuM0ZxlEeUbK2czzcqqlBG28t/sLHDzMWwrrqeDu5urRM
         j2Vv1pzYOlR/GN+HLTU1LpYiSSj2Ntt7Uul74SGmRhKQ895d9UYGzhsUFY1O1DIUy03R
         D7BBfFEAEVmtXPkuo/NEoLlVRWnr1/radScWBcCwQyqKqL3n+jAKuVlY4k5C7tv3rwWQ
         fijPY4E7klhi66ZjhcD+BW5eLTR4MS1UKjPEFZ39JmDYsyGoz2RbIys4mb4gi1IGqjYy
         hKMlu7onK8nwNq/eE7zTApBpnMwOnAQkYPGAU1AwFaRMJFy79kAYzpJGeLtmucZl57wr
         puMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC5fnvshChWu0xgZBRVa0MM2IT5atyuimscgslztS3Hkf959pljmPyK/c5aO5wAqguZBrGKvG4ttM07i2w@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6hhiPTvF6ABOQAZadKBKB5utyb6ni6eNg5cGkFz5bKlrzi/Q9
	RNZSjyjfjHW1KWlKbD900Zx8KyJdQKskZj7qiOx1K5EOhhI++1U/kC73+wxrqpdBcSr2A54tor+
	MEHFEvE258qs+aDMI+JeMchaTYGNoaDk=
X-Gm-Gg: AY/fxX4lY/h/DBtb3utpqR4bKnG7ThjhY7dY5CFASuz0UbYsXi1Zts7qtfP+IJ60lYF
	uf3HVJQrg4hakBfZds/le1y92ZLLSQkDMfcvBaBz+ke6Tq/z9i9V33B+04krRdTjEJ4pYQRfBMa
	xBu6nzcoi47phvvA/kEUf0fOGFWEOFCk0dyrw9I/bajHaOanAuDqGIxUrZwqfzoHsJl3W8aZVpB
	lC1q1Pm2fFNntwcd5Iqw0iyv+x1Y2OVf6pMMt9sRq7/0BELpl4+ulNOJNzuag8DdXq6SZO0
X-Google-Smtp-Source: AGHT+IE+YuJHfhVS+98Suj/KR85jrMfpNNKksu1gFArU8cwrB3tfQn2G73zFlTHp8xvHbQOx7ugy/SvDt9T0ljH7K+k=
X-Received: by 2002:a05:6830:4392:b0:7b7:59c5:7671 with SMTP id
 46e09a7af769-7ce50a998c2mr10755643a34.34.1768239931169; Mon, 12 Jan 2026
 09:45:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260101111148.1437-1-zhiyuzhang999@gmail.com>
 <87secph8yi.fsf@mail.parknet.co.jp> <87ms2idcph.fsf@mail.parknet.co.jp>
In-Reply-To: <87ms2idcph.fsf@mail.parknet.co.jp>
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Date: Tue, 13 Jan 2026 01:45:18 +0800
X-Gm-Features: AZwV_QhA16KXcM1BANviO7LPmkvvlFvT6foXWBAgVrIMGNSu_iVl4Nt7iZ_-Nts
Message-ID: <CALf2hKu=M8TALyqv=Tv9Vu98UKUcFjWix1n5D9raMKYqqZtY5A@mail.gmail.com>
Subject: Re: [PATCH] fat: avoid parent link count underflow in rmdir
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andrew Morton <akpm@linux-foundation.org>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi OGAWA,

Sorry, I thought the further merge request would be done by the maintainers=
.

What should I do then?

Best,
Zhiyu Zhang

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> =E4=BA=8E2026=E5=B9=B41=E6=9C=
=8813=E6=97=A5=E5=91=A8=E4=BA=8C 00:21=E5=86=99=E9=81=93=EF=BC=9A
>
> Ping?
>
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:
>
> > Zhiyu Zhang <zhiyuzhang999@gmail.com> writes:
> >
> >> Corrupted FAT images can leave a directory inode with an incorrect
> >> i_nlink (e.g. 2 even though subdirectories exist). rmdir then
> >> unconditionally calls drop_nlink(dir) and can drive i_nlink to 0,
> >> triggering the WARN_ON in drop_nlink().
> >>
> >> Add a sanity check in vfat_rmdir() and msdos_rmdir(): only drop the
> >> parent link count when it is at least 3, otherwise report a filesystem
> >> error.
> >>
> >> Fixes: 9a53c3a783c2 ("[PATCH] r/o bind mounts: unlink: monitor i_nlink=
")
> >> Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> >> Closes: https://lore.kernel.org/linux-fsdevel/aVN06OKsKxZe6-Kv@casper.=
infradead.org/T/#t
> >> Tested-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> >> Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> >
> > Looks good. Thanks.
> >
> > Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> >
> >> ---
> >>  fs/fat/namei_msdos.c | 7 ++++++-
> >>  fs/fat/namei_vfat.c  | 7 ++++++-
> >>  2 files changed, 12 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
> >> index 0b920ee40a7f..262ec1b790b5 100644
> >> --- a/fs/fat/namei_msdos.c
> >> +++ b/fs/fat/namei_msdos.c
> >> @@ -325,7 +325,12 @@ static int msdos_rmdir(struct inode *dir, struct =
dentry *dentry)
> >>      err =3D fat_remove_entries(dir, &sinfo);  /* and releases bh */
> >>      if (err)
> >>              goto out;
> >> -    drop_nlink(dir);
> >> +    if (dir->i_nlink >=3D 3)
> >> +            drop_nlink(dir);
> >> +    else {
> >> +            fat_fs_error(sb, "parent dir link count too low (%u)",
> >> +                    dir->i_nlink);
> >> +    }
> >>
> >>      clear_nlink(inode);
> >>      fat_truncate_time(inode, NULL, S_CTIME);
> >> diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
> >> index 5dbc4cbb8fce..47ff083cfc7e 100644
> >> --- a/fs/fat/namei_vfat.c
> >> +++ b/fs/fat/namei_vfat.c
> >> @@ -803,7 +803,12 @@ static int vfat_rmdir(struct inode *dir, struct d=
entry *dentry)
> >>      err =3D fat_remove_entries(dir, &sinfo);  /* and releases bh */
> >>      if (err)
> >>              goto out;
> >> -    drop_nlink(dir);
> >> +    if (dir->i_nlink >=3D 3)
> >> +            drop_nlink(dir);
> >> +    else {
> >> +            fat_fs_error(sb, "parent dir link count too low (%u)",
> >> +                    dir->i_nlink);
> >> +    }
> >>
> >>      clear_nlink(inode);
> >>      fat_truncate_time(inode, NULL, S_ATIME|S_MTIME);
>
> --
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


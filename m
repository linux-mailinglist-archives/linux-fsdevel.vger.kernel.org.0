Return-Path: <linux-fsdevel+bounces-52770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5BFAE6623
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 15:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E166416DFCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 13:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958D329B21C;
	Tue, 24 Jun 2025 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqIdX5Zh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60589291C2D;
	Tue, 24 Jun 2025 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750770935; cv=none; b=BiOJQi3IxHotPx8ug3uHUsQzuuMKVw+fwO2ORA5w7Vv89XbgT4Jl2h5Svvf0rmcUPnSjB1KoDDim91xQ1xBqGrPE5vuXOiZoeS/PDPKaSSe4GXKG2rzI/iqLUHLuEG5/Ai5LZZfkx4cAwwDjk9TusGf6bGAkSOp1n2J+y9wpyWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750770935; c=relaxed/simple;
	bh=QmXz1kqBxLQbuTnyTjfMNaNcwY0rqy4SETheMmIysbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQ8GG1QyGMri2nI8hiXoZOYd5c40UL/DP683Zdz28N/1ak+ItQrc9iCbcHluNcAOOx6GEa/SzMFnAVGRufThG0pXgqMEgfazxhndEu6taJFj5liw7jzAqG4gRI73X8bctEbhPpNciPs8cYQZB305FkWTLsilCEhyV9Wh53Nd6gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqIdX5Zh; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso8333093a12.2;
        Tue, 24 Jun 2025 06:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750770932; x=1751375732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DH8dsCGASd7nILeTlz33BBP9ugs6mVhLgyAvx24g4Kk=;
        b=HqIdX5ZhXDhz96uwqXX3jQZZb4wFTuCL3szoQpz9d1e3EpbN379p8w4d4Icu43VA4B
         9YMMscFJmJOp/UfBYcpcPFaM4lFTzbGh+yvGzNY1BB0qM+wm4DvJsveaqNhghZsOkIdZ
         xPC/6w787F1hpt0as+yyGsVFIMaNuu86Tl5Wye/nfZoV+LVaw2z+X9on9OijhwFVeE/y
         23DgstQyK90dvGHObdrdpW5DjIX/qQm0WwfpkiaA9gFGrnao2BLMuXqg4uIlTXV/INv5
         81G3cMcdnV1z5BvlGNVw/QA+pzSg8wr8XqaT1hUuQeZY7bu6VR6YWoEtV1WmSLTGC3/h
         U3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750770932; x=1751375732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DH8dsCGASd7nILeTlz33BBP9ugs6mVhLgyAvx24g4Kk=;
        b=gLDKLomCb0pnCR7yjsXHbsP6WlijK9L3YYBfdiiBzBJBb4G3t/gpLlb5NaFTsqj/lX
         JUFQDp62maSK1KwdkNlzDYPckNXSHTMxGkNjAVYTx3mKs3WLqvhhHTBHIKx6yMUH9pEH
         7Evz6Q6yBTBjcvn9auOYHWNl+B2/TBVEyVTPEoeXO3vr7m8tqMe9kg5eGQROi8BeOXXg
         dfygCyRT/zODUFBpJgn0fauHZ5mmXLJdZxSaQCIZGNqPj9S5LEo+DbfJ3iPZnX04OdAq
         NwtmpM/2VZ9cvPQK5Ib4ddNjsLaHUEj9rpXfdE4CGBTvW+6FNvYfJ03WwoCiNQk0Xx22
         iDcA==
X-Forwarded-Encrypted: i=1; AJvYcCVsR+eLvIv4AIq2Sp/tIUu1vtSBfs3PEiOwsA06b39L/kGset8c07pVL5PlY0Rvd/gTZ82eA539VEe0SmGL@vger.kernel.org, AJvYcCX8OvDQjjKKuOb2wIrcx/42m1xxao2V7SriGtuwm9srJ95TvHCAf6srYrqkK8hu7ZfW+3gVwZwxgIAf@vger.kernel.org
X-Gm-Message-State: AOJu0YxYdFBY5zKoTwhqVP9dJ+L3RvMqCmPw2RJlcSn4Aiu9Hh/w/kBt
	zMmihoSUmP3urzCFxkbEFnk+mbI1Pe6QV3mWWgOEAIWnjPR0omjNpIU76M9n6gcbBsIPxjTQmN+
	6mXGDOwfKn8eaAnXjJlx8w7zOt5OMRLc=
X-Gm-Gg: ASbGncuUhdwnzySxAzYs9JPpBlFBDX6eylEYGMGCVdosN+B1ydDj9LWBdQNObRR9FoJ
	uJOGc0bkSeUG3p666LqpCEWYeJKdi6XKHn2SKGLTXoyKSzOOf8U9SchDTty3XWlmh8fgQ3ybc75
	po9SPCThjVEdxUs4WyRMrAVM7O0+Mng7ULtnnsZUT0JqwXIoj5A5L7wQ==
X-Google-Smtp-Source: AGHT+IFKPPBI3TYcN0DniJVYZicD38NtxcXJLBunx1Cw87035UlVl6xebP+8KIs+VkQ3uBhLCZK+2tExP6APjd18dFw=
X-Received: by 2002:a17:907:1c95:b0:adb:449c:7621 with SMTP id
 a640c23a62f3a-ae057c0f672mr1758789066b.29.1750770931203; Tue, 24 Jun 2025
 06:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org> <20250624-work-pidfs-fhandle-v2-8-d02a04858fe3@kernel.org>
In-Reply-To: <20250624-work-pidfs-fhandle-v2-8-d02a04858fe3@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 24 Jun 2025 15:15:18 +0200
X-Gm-Features: AX0GCFsXPotbTmSWH8R4qDqidmaN2UR6_YRB3GI9TVlyCLftmgi0Z7VIcCLqqR0
Message-ID: <CAOQ4uxgA0FTB8jRC21uA6wC_5_VaFZB7O7CdF_EHA+HrBDS2DA@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] exportfs: add FILEID_PIDFS
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 10:29=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> Introduce new pidfs file handle values.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  include/linux/exportfs.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 25c4a5afbd44..5bb757b51f5c 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -131,6 +131,11 @@ enum fid_type {
>          * Filesystems must not use 0xff file ID.
>          */
>         FILEID_INVALID =3D 0xff,
> +
> +       /* Internal kernel fid types */
> +
> +       /* pidfs fid type */
> +       FILEID_PIDFS =3D 0x100,
>  };
>

Jan,

I just noticed that we have a fh_type <=3D 0xff assumption
built into fanotify:

/* Fixed size struct for file handle */
struct fanotify_fh {
        u8 type;
        u8 len;

and we do not enforce it.
there is only check of type range 1..0xffff
in exportfs_encode_inode_fh()

We should probably do either:

--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -454,7 +454,7 @@ static int fanotify_encode_fh(struct fanotify_fh
*fh, struct inode *inode,
        dwords =3D fh_len >> 2;
        type =3D exportfs_encode_fid(inode, buf, &dwords);
        err =3D -EINVAL;
-       if (type <=3D 0 || type =3D=3D FILEID_INVALID || fh_len !=3D dwords=
 << 2)
+       if (type <=3D 0 || type >=3D FILEID_INVALID || fh_len !=3D dwords <=
< 2)
                goto out_err;

        fh->type =3D type;

OR

--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -29,11 +29,10 @@ enum {

 /* Fixed size struct for file handle */
 struct fanotify_fh {
-       u8 type;
+       u16 type;
        u8 len;
 #define FANOTIFY_FH_FLAG_EXT_BUF 1
        u8 flags;
-       u8 pad;
 } __aligned(4);


Christian,

Do you know if pidfs supports (or should support) fanotify with FAN_REPORT_=
FID?
If it does not need to be supported we can block it in fanotify_test_fid(),
but if it does need fanotify support, we need to think about this.

Especially, if we want fanotify to report autonomous file handles.
In that case, the design that adds the flag in the open_by_handle_at()
syscall won't do.

Thanks,
Amir.


Return-Path: <linux-fsdevel+bounces-68278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB13C57F0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 15:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725AF3BA892
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6021F26F295;
	Thu, 13 Nov 2025 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ18IiLs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE0726E6EB
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042811; cv=none; b=mNMVaAkgm1Ltkw8mnYExxQZ0atVlT5CBa4kSxZDdtpqKLS+LJgUOuWBZBTz5DNwxCzw9AL3D7AyCrWatoVnWFk8ag3ePU6P7PwAzyxSf9vf9f+M371TKXEnUMRob86QtqvWQJV7O8oNJrmNr1rapsaExcxzUm0NW0tWO1G++ZBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042811; c=relaxed/simple;
	bh=D2ODdD/q9ZSb4oKVWcEmQAHLH0t0auUFL11Ew77g4sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jeHGe+rbwaTjOisQXQEWN4r5mEOMUeNxHV7aNSUvQc24u979H3ttrIV6Eu+nSlN+ZV+UDcZCm/s8QXww8XIemDGRRsz6TfKiSLHZLPo7/vBudcpb5dkR5hycf4mmGLcii+yp2+WLYFiQ8igSRv6g69Hc74Ih0Q34ArjYXsej+1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJ18IiLs; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so1392251a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 06:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763042808; x=1763647608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4ymCy60GrQlR96Zc3ezzNbIHD34h6VuRNXowZp2kjw=;
        b=KJ18IiLs3Z1v7tZmuUDbVmsV2mPvVLVV80UndceXE3PXDZEnSgZ3s4sSbY8Q2hAVyw
         gNCwBTU42CY6eooXveg3/iQX7f7YjiQ2dBoGN/XEd5FscSgCmYoILfPcoY1cfv+4X0EA
         SX2n/IA5saoNu8Dz2C5uL3tQGCemm2DLyUQOXwWh3DKk8aUP38QJ2xjJr7bno/IRndtc
         st8ySLx6J4RTwrxA5Zpo/d/NkmK93oq/vIevu8ZtGfU8zY4PazFGXWtTUW0ZQKOCvLaE
         x/fO+hsSJufLEopGRwWkJHk6sQbaemZO3c9y7DyF4+7maHOnkAcsG63wbAdH7Z7hwV5+
         /Lsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763042808; x=1763647608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X4ymCy60GrQlR96Zc3ezzNbIHD34h6VuRNXowZp2kjw=;
        b=PdQJBLZeb0MLsc+6s8yt5uDYVvBxkxoeA0tT6/yXB9GlyJ/YGeUMyYso3+/xYlYLFn
         uSTApzLwUJI3g050MuzDLyQkrrY4aKMIvdYHKADuqd7t5XdGEoBqLCcQxvcvl5SBbTRb
         +aTUxme+JL+LSee2Dfw8imCyW+z3SP6z8zodUxAAzVCaauHga9n+VtTMKW22XnZXL9hy
         DpSbT2YkAsfW9RxJjkfmCEO+urwvcrNbcwY3drGnNFB+GvGqygzOMikj4g6NNljaTZkz
         wCS7oFlTIroNoGfrEq+tEZMVR8tUlFN6iVrnTbTn24oH/Y9IoIzYDttCF20yqrWj82Dn
         x5WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQGuTFl7yW6qryILFwyVuKoE4uH59lF8t6yCLSLlye8kAacLloh3WY8LA3oQJBLbKng+SF5HQEu5x9L2b4@vger.kernel.org
X-Gm-Message-State: AOJu0YxGRctGpkOw42aPMYCUPPG6eVqknUdTYeuV5KIr1G8XFgNYoC6N
	p5shyseI57BayyI/+aBX4y+4FcoMF1TkYzC3S2LGHiW/fUjgn1n1xwosEZvDDIrQMOue/yOrnFd
	BZHsWrRPo1GUVY5/EKrSnzk86UexNpoI=
X-Gm-Gg: ASbGncvNjiY+eAfAbfbIENDCwVbNo81DaLwEJiNpDZJAN5e4FuvSzgcrZjRONdfFx4Z
	aZhJG8n94GJWEF/dMhPwTu1t9nKiHMY/ucoJWIWlEaOGpvk+Pk+uMiZfP0oPjOd8SAdAZnwJjPJ
	UNStHprDG7Ih0FjNwJxmT3UtVAW1DhzMRHTnA8jLP9r3HFqLUSLQDIWMYYeHIsZS82Kodv4jDWA
	K639in3Td1h9TY31uSA+f1U6dcBi1RZxjvnGHeqlvkvBSKbdGNYT32cTDIPv35FOgo6ODqf1OsG
	74ZRV2IBcZmwvwJ8z+VgiTvsPkvsLw==
X-Google-Smtp-Source: AGHT+IGqErlwzPMt/1KLk2kiKyv4l15eEIq5n8jxdRYYN2NkCTT5305DVCpYoJVu688dJqFu8vpLFhTHWj9Bm64apog=
X-Received: by 2002:a05:6402:455c:b0:641:8f8d:e633 with SMTP id
 4fb4d7f45d1cf-6431a55e40bmr5319833a12.28.1763042808257; Thu, 13 Nov 2025
 06:06:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org> <20251113-work-ovl-cred-guard-v1-32-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-32-fa9887f17061@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 13 Nov 2025 15:06:37 +0100
X-Gm-Features: AWmQ_bnJUW7KqpuHQYoAwalgT17XbhBu-qlvnsRxyJbqopd1_u_HI7AB6S5xs5c
Message-ID: <CAOQ4uxhr_UTkEJiJD51KZqh065f=XV0GS8KFYszaR0rzN_Rorg@mail.gmail.com>
Subject: Re: [PATCH RFC 32/42] ovl: port ovl_xattr_set() to cred guard
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 2:03=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Use the scoped ovl cred guard.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---

Typo in subject (wrongly ovl_xattr_set())

Thanks,
Amir.

>  fs/overlayfs/xattrs.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/fs/overlayfs/xattrs.c b/fs/overlayfs/xattrs.c
> index 787df86acb26..788182fff3e0 100644
> --- a/fs/overlayfs/xattrs.c
> +++ b/fs/overlayfs/xattrs.c
> @@ -81,15 +81,11 @@ static int ovl_xattr_set(struct dentry *dentry, struc=
t inode *inode, const char
>  static int ovl_xattr_get(struct dentry *dentry, struct inode *inode, con=
st char *name,
>                          void *value, size_t size)
>  {
> -       ssize_t res;
> -       const struct cred *old_cred;
>         struct path realpath;
>
>         ovl_i_path_real(inode, &realpath);
> -       old_cred =3D ovl_override_creds(dentry->d_sb);
> -       res =3D vfs_getxattr(mnt_idmap(realpath.mnt), realpath.dentry, na=
me, value, size);
> -       ovl_revert_creds(old_cred);
> -       return res;
> +       with_ovl_creds(dentry->d_sb)
> +               return vfs_getxattr(mnt_idmap(realpath.mnt), realpath.den=
try, name, value, size);
>  }
>
>  static bool ovl_can_list(struct super_block *sb, const char *s)
>
> --
> 2.47.3
>


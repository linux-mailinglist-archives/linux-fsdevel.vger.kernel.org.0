Return-Path: <linux-fsdevel+bounces-21109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 977F98FEFF4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 17:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6032892F2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 15:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE4119EEBD;
	Thu,  6 Jun 2024 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qf5xRqGU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730731990BD;
	Thu,  6 Jun 2024 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684909; cv=none; b=ZihfTMClUh+PtOcdhAfnqooTMw2e/5pt5YAR4ytn812OljjXbtk4f1bPaCsmojLj2txydQ8dxLtGf4yxF1vedkXnwU4liDd2pSekgNmRv2oYFCgZw96pGibl2qInFaOJBoQEaza7XK3c0QEpRo5gmwnCusYiH0ffy5LWnmZl3LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684909; c=relaxed/simple;
	bh=pNdNKUz8Qx6fVYu4D3HZWpU/yRKMx8AbP0xu0qMyrvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cer+rwt6eDoXWo/o7v3B6WbxBT4DrwhzUPpOz5YCnTw4f0JWN1Eg1g1es8WpOgyc7j3FvwfS1KIT3DoexE2cfDBfRSHWkkI5Rv53EcKf6F+1qqNiajunCsm0IOzg9oanbgnlDQ+kwUlX+v/o3vXK9sF1lWlycssX9TRNHjq948o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qf5xRqGU; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-79526197ba6so54657585a.2;
        Thu, 06 Jun 2024 07:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717684906; x=1718289706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iCRDxRBjaRLEHPz1RTSOPHgc01ZwAtsHfV91DtTiy4=;
        b=Qf5xRqGUloB6mfSXHP32BMV73am3bsQzW7HFUWcr54+/oRH3mwVcDoJ7kh62yi6la2
         UZBaaYIWmlVKQ8Nslz+X8F7zybqNjODcqAwPgshy/d4pNdpDZ2e9sT25CBdeZyrjqt2B
         3v6xW+8E99UeMry9QE/fCkWUwuxKvHbAJEzDFRXTmx+iCK6moHztM4WzEDRpisOfApGp
         eCTTykIUiHzUrENl1e3zivn1ziC1XUeZhY50vVwceMbfE3hE+dz3Phb17Hhitlagl24t
         OkXBRQ324PJFKKEtP4UikVVNp3pYU/cKuGEJTT+BZ7czovE25U/lcKNp0hMArZj0Hmcn
         mwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684906; x=1718289706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2iCRDxRBjaRLEHPz1RTSOPHgc01ZwAtsHfV91DtTiy4=;
        b=hMy6dA3N3YkUdVKYsNkbUBC3FsaiJHRc2cmJ5vmxzyr7z3f44198ToB+aa/posLq3H
         TzKabSvC9EG4QD8/ncoWEFJVnpaX031ybwZHUOFX+pPZPOao+0BqR9HfiJmahuXi4pWk
         HbK0OSjbAwQhgHXvcBp6dEKzbuPrNQ8nJGUXzviuW2N1wNG9ZtpgBMz9aoJqTz8E9E5D
         BVKUbHbJzVlsOMH+hJ7x/vjoknX2fa3mxOE8ptJR8hQ7dVL8tB/aLEkq61uK1w+ChxHM
         3FBwshixH9UI/+FcudEZcPhvEHxvB7Z2ueofZO+Z3yuyDIp3kLF6So2wec+CPG942GBy
         oTxA==
X-Forwarded-Encrypted: i=1; AJvYcCVQxwwZkIUk0rGfyByZUwMRkJBiXEu6ohc83iIOMbZTDIZwZxe9IGX4bWEHW0hTq1OpxuNBBr8+y2OAR1eJKuJ1hL0fEqr0fIqm72UI4g==
X-Gm-Message-State: AOJu0Yx5t7IORq2E6qbrJ3ykPi3andmXowBS7FetqIXWMDRKBKU9TJMp
	FHp2Wir5KvnRF9ThaSLCIGCwhrYqwQKvMb3xKgTeRAgkoT3mSGeywXWejHchYz0A6T74aoNoSFH
	iVUaASO5z1iUT4mO/pacvyv2nE8Y=
X-Google-Smtp-Source: AGHT+IGE1TzyZQFnzCWobTDTF8CDE5UYv4N4231xtIVgReMpj55uUq4SoSovxY8BTHFD5OUm/0TdtJoRXoi78qdxgI0=
X-Received: by 2002:a05:620a:2f8:b0:792:93ed:2e7c with SMTP id
 af79cd13be357-795240e4073mr589955785a.76.1717684906364; Thu, 06 Jun 2024
 07:41:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606131732.440653204@linuxfoundation.org> <20240606131746.528729378@linuxfoundation.org>
In-Reply-To: <20240606131746.528729378@linuxfoundation.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 6 Jun 2024 17:41:35 +0300
Message-ID: <CAOQ4uxhwgGKf0=y4LTst5ExDVO0c0HWeZ=3iRK63t8GW9zBzbA@mail.gmail.com>
Subject: Re: [PATCH 6.6 438/744] ovl: add helper ovl_file_modified()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Sasha Levin <sashal@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 5:18=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.6-stable review patch.  If anyone has any objections, please let me kno=
w.
>

As I wrote here:
https://lore.kernel.org/stable/CAOQ4uxj6y0TJs9ZEzGCY4UkqUc1frcEOZsnP4UnWvGt=
QX89mRA@mail.gmail.com/

No objection to this patch, but this patch in itself is useless for stable.
It is being backported as
 Stable-dep-of: 7c98f7cb8fda ("remove call_{read,write}_iter() functions")
and I think the decision to backport 7c98f7cb8fda is wrong.
I think that the Fixes: tag in 7c98f7cb8fda is misleading to think that thi=
s
is a bug fix - it is not.

I wonder how my feedback on Sasha's series got lost?

Thanks,
Amir.

> ------------------
>
> From: Amir Goldstein <amir73il@gmail.com>
>
> [ Upstream commit c002728f608183449673818076380124935e6b9b ]
>
> A simple wrapper for updating ovl inode size/mtime, to conform
> with ovl_file_accessed().
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Stable-dep-of: 7c98f7cb8fda ("remove call_{read,write}_iter() functions")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/overlayfs/file.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 8be4dc050d1ed..9fd88579bfbfb 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -235,6 +235,12 @@ static loff_t ovl_llseek(struct file *file, loff_t o=
ffset, int whence)
>         return ret;
>  }
>
> +static void ovl_file_modified(struct file *file)
> +{
> +       /* Update size/mtime */
> +       ovl_copyattr(file_inode(file));
> +}
> +
>  static void ovl_file_accessed(struct file *file)
>  {
>         struct inode *inode, *upperinode;
> @@ -290,10 +296,8 @@ static void ovl_aio_cleanup_handler(struct ovl_aio_r=
eq *aio_req)
>         struct kiocb *orig_iocb =3D aio_req->orig_iocb;
>
>         if (iocb->ki_flags & IOCB_WRITE) {
> -               struct inode *inode =3D file_inode(orig_iocb->ki_filp);
> -
>                 kiocb_end_write(iocb);
> -               ovl_copyattr(inode);
> +               ovl_file_modified(orig_iocb->ki_filp);
>         }
>
>         orig_iocb->ki_pos =3D iocb->ki_pos;
> @@ -403,7 +407,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, str=
uct iov_iter *iter)
>                                      ovl_iocb_to_rwf(ifl));
>                 file_end_write(real.file);
>                 /* Update size */
> -               ovl_copyattr(inode);
> +               ovl_file_modified(file);
>         } else {
>                 struct ovl_aio_req *aio_req;
>
> @@ -489,7 +493,7 @@ static ssize_t ovl_splice_write(struct pipe_inode_inf=
o *pipe, struct file *out,
>
>         file_end_write(real.file);
>         /* Update size */
> -       ovl_copyattr(inode);
> +       ovl_file_modified(out);
>         revert_creds(old_cred);
>         fdput(real);
>
> @@ -570,7 +574,7 @@ static long ovl_fallocate(struct file *file, int mode=
, loff_t offset, loff_t len
>         revert_creds(old_cred);
>
>         /* Update size */
> -       ovl_copyattr(inode);
> +       ovl_file_modified(file);
>
>         fdput(real);
>
> @@ -654,7 +658,7 @@ static loff_t ovl_copyfile(struct file *file_in, loff=
_t pos_in,
>         revert_creds(old_cred);
>
>         /* Update size */
> -       ovl_copyattr(inode_out);
> +       ovl_file_modified(file_out);
>
>         fdput(real_in);
>         fdput(real_out);
> --
> 2.43.0
>
>
>


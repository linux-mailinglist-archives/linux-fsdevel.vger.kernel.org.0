Return-Path: <linux-fsdevel+bounces-74157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF04D3314A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54B67302084F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011C0338906;
	Fri, 16 Jan 2026 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Daxvp1VF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245AB3321D7
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768576061; cv=none; b=qlV/E16v5eH/yBisMt43vKxBmYzC1IZf0SdGy22YC/UO1iiTjR800+MWaLwWr6mKX7LlzRRYXWTa+myU+5xcpXnywAkkwhVEe0QjLq87TyjRHFp9nZOfVgzdNiz1sNFemfQi6W/KFhQABFpLYKenDi02R+p0s06wPw6EQOz6b/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768576061; c=relaxed/simple;
	bh=6yT1WC8wZTZZUj3tYhIVTPm8W9XDCfb90ZmlXfVRUO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzuCc2STxDnlGxq15yWdMOGbsx3LUpPDR5TjtFUb5kFlcgquBJXWJXgwkJWGDnFDKjIhPQIsGfkuzPZSmkUe0fVDB6c6Z/7pKuvUE+Z7pYCOjEE4tfdiBL+7HnPcfXZ8GpbKodWFKILYtuyEpM0u0ZoGgUVPuen3XBd1Lv7skPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Daxvp1VF; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b86f3e88d4dso359969966b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 07:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768576058; x=1769180858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+G6bs7NVzcM44ltQfsJh9pxcBvAo4PqsVFNkRp6foyE=;
        b=Daxvp1VFGn+jpLr6dQJ37HPI4r71yKOCNUZuBpkiTK2l86FG8XXrgca9AWeNImVRc9
         2BhpLApFkj8NefORh/XA7G5rfKprCV40zVEDxhaaHUomAsQXF4fjS2BpEAj6qJScXW7M
         X3vxmwKBMmPARnHZ4Z61c9OaRvCbhRGc9qiHwxTDXYy/V+I7hFsA/Gt9L2u3xaqOx7OB
         di8V2rK8zYlcCl0Jx+go8PXSl6fgSpFdTdNlN5Xjs6OtAoG5LjU0jRLjDPMCxWSMjVKC
         qwNYs/EIDmVVgdY2Mc46Rvbv3Few9FJEmnr0zYaaYDL4EXyLFyqgG3dOMU/arfzeb7eA
         J1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768576058; x=1769180858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+G6bs7NVzcM44ltQfsJh9pxcBvAo4PqsVFNkRp6foyE=;
        b=HTzSc1rQ84pdtkhqQ2Ttmnqxv9VkI1NBZM2WjUjv03jmpkMSz3yrMNrxpahkHwbCiU
         6r0ljZuATRF1uKgheXIaUB1toPnvLGczSds3Gl3QOhYFvEuoij2HDeE6dvXOdT4G39jk
         2JLhfy5XbGvnFNusI7JKJ26t+Q9Q5dDatERsmpbnE5PyuVXpzzZ/OS7h6zsB474gj6q+
         QJSwDjnxEjcz3RQ8sP3PBMYPQLkUaf8Xn+AjMRIBZ/aRSXW6x8QoXEG94eELFZxGKDU/
         L+BLaXfdRWn4ka3YoYTKV5n2Wu6q9h0FggWHehht8T0nO4igbin3fUvHwCLciaaDwMj0
         oY8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVap2KQgFdmJEHRgvqL9RLBeW0QsPpmoe0SRtgIHWrXxuwgz8z0pThfQgNCYMoy+TwuSN0uGuNG+HOsFNgG@vger.kernel.org
X-Gm-Message-State: AOJu0YzWfCH78wH1PL4zcz38KSNdzs/8IkuEcqgOudezEzT+C7v2504W
	CXckt9gqEqYdtrqJ3CEBhUE9W5zTgAORXCJNpB9E36M/Sp/EtoHXCWZBYKKExHy1TEgCLduGFyU
	Cwms88m7dQp3TrGWxFQjJTEYJmeAW6SMvG3b4bKm7Gg==
X-Gm-Gg: AY/fxX5Yn49H1QT94BS69zX5RNWAnY/SCeEC185OHG7FInxVW9L9tGJlJevRNEe2MQg
	ITwJpxUYjw/9T7eqo9sLKkMWiKDgz/PDS7YfVt2+DR31m3IHPjrtwAAKTYqh+ZmJ06SZk/lerjC
	guq38KlpZPGbfSIQ9oXj3qKl8pVSym2ZFZZ8PZjSgMrh35aFG24ZVA9aavEZcEQA21MGPXTI76b
	/H4X22STXBS7tC/sIcvXveJNPb8KH1NwLJqvAvdRJSo8G6y72b7APukzF6/WXmtble9thyBVC3A
	NYDJTOWmqonb4Y+NTkTaGj9OTBjkDA==
X-Received: by 2002:a17:907:868d:b0:b86:fa17:4cf5 with SMTP id
 a640c23a62f3a-b8792d274c0mr310244766b.13.1768576058130; Fri, 16 Jan 2026
 07:07:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116142845.422-1-luochunsheng@ustc.edu> <20260116142845.422-3-luochunsheng@ustc.edu>
In-Reply-To: <20260116142845.422-3-luochunsheng@ustc.edu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 16 Jan 2026 16:07:27 +0100
X-Gm-Features: AZwV_QjaYU4oMfjizdCoDdaU_GpVYkApb84766ay9n4C2RSAJAdqfxRit_k7QeM
Message-ID: <CAOQ4uxhB-L93cj3RbqLy=618ZsFr0B1d3DH0zV+gD-A5BngQrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Relax backing file validation to compare
 backing inodes
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 3:28=E2=80=AFPM Chunsheng Luo <luochunsheng@ustc.ed=
u> wrote:
>
> To simplify crash recovery and reduce performance impact, backing_ids
> are not persisted across daemon restarts. However, when the daemon
> restarts and another process open the same FUSE file and assigning it
> the same backing file (with the same inode) will also cause the
> fuse_inode_uncached_io_start() function to fail due to a mismatch in
> the fb pointer.
>
> So Relax the validation in fuse_inode_uncached_io_start() to compare
> backing inodes instead of fuse_backing pointers.
>
> Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/fuse/iomode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
> index 3728933188f3..ca7619958b0d 100644
> --- a/fs/fuse/iomode.c
> +++ b/fs/fuse/iomode.c
> @@ -90,7 +90,7 @@ int fuse_inode_uncached_io_start(struct fuse_inode *fi,=
 struct fuse_backing *fb)
>         spin_lock(&fi->lock);
>         /* deny conflicting backing files on same fuse inode */
>         oldfb =3D fuse_inode_backing(fi);
> -       if (fb && oldfb && oldfb !=3D fb) {
> +       if (fb && oldfb && file_inode(oldfb->file) !=3D file_inode(fb->fi=
le)) {
>                 err =3D -EBUSY;
>                 goto unlock;
>         }
> --
> 2.43.0
>


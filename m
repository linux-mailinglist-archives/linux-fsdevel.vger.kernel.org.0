Return-Path: <linux-fsdevel+bounces-26889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 098E795C90D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 11:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA45B283CEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 09:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C6A14A4FF;
	Fri, 23 Aug 2024 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goqUiArV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4147F13C918;
	Fri, 23 Aug 2024 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724404763; cv=none; b=Fsfc5hEelr0VSZ4ybgQ5oeEgiCsrKQsa2chiEifM4JlfKx5sBfAWuZhQWrr8owfVaZu9DYDknFh6Zsg/mMDaSCUemfUBRc9mvV7v1Dgeg+XuDvziM0g/Q79afoJnD2muScjOLqtaW/WdGKRPpjLP/tr3gzZWjrw9pkZkn2ZJO6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724404763; c=relaxed/simple;
	bh=IibTBgqhw45+iOawqa2uxmYxJEzTC+NgkR167nJ9zRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvW+QD/bF5Mrk8bvuOkHhhy3qR6U/lCirWKHgiQZfy33KLrFPUp/Ia0T7EiOKK+RgMUvNgHWGXJwa6KyyFBY1tJ3dJ3qFVqlF1XbqAT7mf9OXq/yXCfY/dfujakW7LD8MHAeEzfFlzAh4DG43PPdnqTUXdTzhOoWA+3DSlHUXng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goqUiArV; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-842ef41238fso539609241.0;
        Fri, 23 Aug 2024 02:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724404761; x=1725009561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Aanka2PpayLsWVfpyn/8lArNZtYk4+n0lwBfiN9yMw=;
        b=goqUiArV6HRsUejpA88mnf/o1OS6g5fP5Zvbk1u0IfIC/W7YwjkOSK3kPJWgLDbQ7y
         p2TO1b1zWY52j3fR/8c2pTkRSSgi4Jz3oLdVS8x7XUuei7DlbKalbqEa0Xykv85xI+/z
         RdTn9EjtQxQjEdpOwLJYuDVn0hq4r8eq2twIKhmKCuHwxaLxPQn20BITQ/QBd22EdaEk
         KjmNE6O/1sxwMLZbao8JDZTj3BCND9w4amZWmf/pnDC3yuW1SEs0OJ6mR40KFWWqUAkB
         ai4NOBz8Fj38D5prOq0rV5EOJnWHu1N67xcO4RCNRvS336Ekpx1hpjWKyU7hDNArrYtJ
         uLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724404761; x=1725009561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Aanka2PpayLsWVfpyn/8lArNZtYk4+n0lwBfiN9yMw=;
        b=A8e6Y11Yjq7hILzjvmAGeZO07OsvmZgef+nGemZHHgPERy+5qNsURerdZu/NKCOaJd
         D5nr3QgaDBMLzfqNNlzjJXyusCJKBTb+P4hMVtoc1qRLTz9JqBez43zasgiij43GsLzh
         edHcZyZNrH+q09k7K3Wz8OvaIlAS1sICfwLM0cEulQC9yotGmtVQxzI7wlG64phJd6q9
         DtuS6qd+VdpHbt+PSXFJN6149HLolwpZ448W6ohiRNYquZeiLNtZvWSJtkVRWus7eKu3
         zSNhgQ5rDz7gBRgrAklWhVYQRuIgRoOARh3td39WyQr0L0+2EArBqwL3MivklTjqzyPM
         7V3g==
X-Forwarded-Encrypted: i=1; AJvYcCW+yr5V0F26oDtuCAenMPjUmLDOdz6wrQbULT995zk1wzsxxmHNkaN21Mqpd3Kin/ZIdjNkUxtZG0ltarJm@vger.kernel.org, AJvYcCXhvTyHthMTzjVAy3KOUTzxqAlGxBtO6AlMVBhsqHvHhhuLFvp8UCs0UE+cwTN/qs7Ep7mlvCmTMKmwJlhR@vger.kernel.org, AJvYcCXjqfWvLziLZ/VZ0oBrvGwTyi3nZR/V1cd9cPdr9zpoo5KjJPWZDySDhkvWx8ECB0bSHXhGUi0qNsOml8HrDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVikcaZUEnKB0kOZdkyfnMa28+QDHxA9SxZ61XhMJmDNFp9RYJ
	/FpdQZqW/fFaUn7xiRLBbnU5FktrAa6gr7wNC1++duEyKJKR7k65u30fWQ9zEZMpbJcgAjB9Hha
	Zx4YotEjtTwqdJAZv3aOOFZ6z5NI=
X-Google-Smtp-Source: AGHT+IE9kgNHk6QBa2umXgprmSxk1o4/YViXD66++2xa1BzhHFTA6Y543TCkCl52NCRZ5fO8JYHBI4NWztjCTln4krY=
X-Received: by 2002:a05:6102:38c8:b0:493:b484:ac06 with SMTP id
 ada2fe7eead31-498f4bfa0b1mr2011900137.21.1724404760959; Fri, 23 Aug 2024
 02:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708072208.25244-1-ed.tsai@mediatek.com>
In-Reply-To: <20240708072208.25244-1-ed.tsai@mediatek.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 23 Aug 2024 11:19:09 +0200
Message-ID: <CAOQ4uxjySyTMRQDuFDsA1XVK210K+8CHh3LoSU2zYynh5OyF_w@mail.gmail.com>
Subject: Re: [PATCH 1/1] backing-file: convert to using fops->splice_write
To: ed.tsai@mediatek.com, Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, chun-hung.wu@mediatek.com, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian,

Would you mind picking up this fix via the vfs tree?
The reason that the Fixes tag points to fuse passthrough patch is twofold:

1. fuse passthrough is a new user of backing_file_splice_write() which
    can have a fuse or overlayfs backing file with custom ->splice_write()
2. overlayfs can have a backing upper file which is a fuse passthrough
    file with a custom ->splice_write()

Thanks,
Amir.

On Mon, Jul 8, 2024 at 9:23=E2=80=AFAM <ed.tsai@mediatek.com> wrote:
>
> From: Ed Tsai <ed.tsai@mediatek.com>
>
> Filesystems may define their own splice write. Therefore, use the file
> fops instead of invoking iter_file_splice_write() directly.
>

Fixes: 5ca73468612d ("fuse: implement splice read/write passthrough")
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
> ---
>  fs/backing-file.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index afb557446c27..8860dac58c37 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -303,13 +303,16 @@ ssize_t backing_file_splice_write(struct pipe_inode=
_info *pipe,
>         if (WARN_ON_ONCE(!(out->f_mode & FMODE_BACKING)))
>                 return -EIO;
>
> +       if (!out->f_op->splice_write)
> +               return -EINVAL;
> +
>         ret =3D file_remove_privs(ctx->user_file);
>         if (ret)
>                 return ret;
>
>         old_cred =3D override_creds(ctx->cred);
>         file_start_write(out);
> -       ret =3D iter_file_splice_write(pipe, out, ppos, len, flags);
> +       ret =3D out->f_op->splice_write(pipe, out, ppos, len, flags);
>         file_end_write(out);
>         revert_creds(old_cred);
>
> --
> 2.18.0
>


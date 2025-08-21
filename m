Return-Path: <linux-fsdevel+bounces-58696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF64B308FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8BC74E197B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968052D3ED2;
	Thu, 21 Aug 2025 22:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoUjC+7J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3C81E5206
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 22:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814705; cv=none; b=m9dwMZUq1EnhLrxczMQPEDost+LcjCk514AfcuIwvgyO82YKaHtG03afiOS4HMGY/GzmKv1mUu0ST5aKST/bcrBYyG4Mf8EthIjx4Wd9UL7ciZlFIaSSJGd43O4XPcOTGeTl5xAjP9dkICAOsXhghHl2CQkusy/jyU8zpFfiucc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814705; c=relaxed/simple;
	bh=6/xsa/YG3zsXWGJ1Qgb38Dp8r8mUSHBNab06PeMA4vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMcEkIiLff6e0ub7pjyTOybeVrJy4/wB3LO40AfthwZKbxX2boOyt4FrkdhY7xzmionYEa+4rAevmOyFe8HR4CThT2Og4uuNed46Kb9d+IF4aFrrdBOQSXBp341B44kn7ZK1f1JNSF6SBi8vKZgQJOSodVlW8tq5K0Jg+vOqxYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoUjC+7J; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b134aa13f5so18332131cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 15:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755814702; x=1756419502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZxN3R/tLf4dDldDVKK4PKpHY/0W1RUm9jFEc3Q/kSQ=;
        b=ZoUjC+7JIHwXOAUsaxe4LU0l4tNeDPpma7s13KOTpp55WIfJlpT5EUHxcKJ3VJyVS5
         LhQeozLmeClS1LivrseI3kyMtjB5/3ju5YVbEVXeR3dkK4B1jqm6mOjdBPE91sIYXMRH
         UQygIFdcHXgo3FufGE/0hk8TepKovhwK38QMQJn6tASYc+0YnBXALRe1+XRHCR9wJLuu
         fi3AsfwTXK9czPnyovSQ8OFxkATEUE3e9+pz9Zmy91NsmWEC/1rWnkITRcG2p+K61ccx
         i0kkVfkgi6wG9qdayfssZsv2z8tPUbic+udYsnJnm1Owarldf6JljcYCP+K9Z57Shpw/
         fDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755814702; x=1756419502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZxN3R/tLf4dDldDVKK4PKpHY/0W1RUm9jFEc3Q/kSQ=;
        b=uCiTCnsKpipKBB31uIvM8QMm8KmDYl/I4UJk6mB1ABZRroV8X/veihVXy2K6A0tt4V
         ucJQJn7nQghjhY5yU7Y+5dM41Ts143whAK4EhbMGyMx8p27yqCpDYCI1xKFnmbOCGYjM
         Cau/5AAek7eVaG1yD5/G/ldqHWRBkaTC/kh9824DUvrgEnpi6r080dgKz2JlVTKjLJOA
         Bux2lV+sklF8YAHVOoX+jxfDnZa2L/WBnZJvIxm+gmR34LbfQavbqvm88msQ3GSfPt4p
         uEMQOTPL/8o6++Cbd+K+xjsGrlKuA3G+jN3TAJ3iBqrb4CdZWjitixg3GD9zQAwZuomp
         WyOg==
X-Forwarded-Encrypted: i=1; AJvYcCXFjD6R8h5CU4dDhKN1Z9+ZePjUAL8HaOKgO/bMsEiu8+aGY9R0DghXcBwCsojlBEmsANcbqZ9Ha1BEC2NN@vger.kernel.org
X-Gm-Message-State: AOJu0YyaJ2zxP3L2mZ/cnEFqsmlY68j4l3PID8X7iC9dr6SQBiTyxX7y
	suwKXTldaK8nYRgEQgtATxNl17eGQrDsgABD0BSFHYR9ppw+51/6DlKEbkJIiWnSCCxSsuDhGSG
	XQ+gSt6BOz6owKQCrQBPzHw6QwY7zDdrKOQ==
X-Gm-Gg: ASbGncudLID1kvf+gqqWLQHpYQGu9jnRJZUl9RtD6Bz3G2tebYMmFYnjvWayjxAH2wM
	xDP3yhMMlaZWHNPauN0tJR4wIcXPrmFkRZRjhVS5g+M+RaVuw4FpaPEO8imBPK/6R2Jnyus4WLk
	VgF+go52YVo0eJm3OisvkPlCtV+h1Ba+AjhOaD8e82M0xJ4sgVA/8NT92xqAl4WIdGQGXMg09iS
	pR6itXX
X-Google-Smtp-Source: AGHT+IHlTS2y/btV1DGLPnKV01hvDRwiV+uRGLRANXR4AT4werHnJSYkxVNQlQmhRkWkWOZaFINluzmG+3+0ls8KuEc=
X-Received: by 2002:a05:622a:199e:b0:4b2:9a9b:de41 with SMTP id
 d75a77b69052e-4b2aaa051dfmr16137781cf.13.1755814702309; Thu, 21 Aug 2025
 15:18:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs> <175573708692.15537.2841393845132319610.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708692.15537.2841393845132319610.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 21 Aug 2025 15:18:11 -0700
X-Gm-Features: Ac12FXzurDH6eVdA4JWV8fYg2aHPdX1M5FngZJI1n_o85iTP_OUKD8uhMQE4Ih4
Message-ID: <CAJnrk1Z3JpJM-hO7Hw9_KUN26PHLnoYdiw1BBNMTfwPGJKFiZQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] fuse: enable FUSE_SYNCFS for all servers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 5:52=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Turn on syncfs for all fuse servers so that the ones in the know can
> flush cached intermediate data and logs to disk.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/inode.c |    1 +
>  1 file changed, 1 insertion(+)
>
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 463879830ecf34..b05510799f93e1 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1814,6 +1814,7 @@ int fuse_fill_super_common(struct super_block *sb, =
struct fuse_fs_context *ctx)
>                 if (!sb_set_blocksize(sb, ctx->blksize))
>                         goto err;
>  #endif
> +               fc->sync_fs =3D 1;

AFAICT, this enables syncfs only for fuseblk servers. Is this what you
intended?


Thanks,
Joanne
>         } else {
>                 sb->s_blocksize =3D PAGE_SIZE;
>                 sb->s_blocksize_bits =3D PAGE_SHIFT;
>


Return-Path: <linux-fsdevel+bounces-65745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAA6C0F887
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 18:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 105404F2A96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 17:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AAC315D4F;
	Mon, 27 Oct 2025 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaWNK4M0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776B2314D0A
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584892; cv=none; b=ZZQfFuAwYLkqYdiQku3pS3RBPmzpQe0F4aW1fIbFWLLT0zNRYz0FjbtXdXMqpFQNpM94LvQU9syuryv7YndKg8Dmrch0nnlGkUtIOeHRgMgY7X7FJ3HkSl32DXfZprV+CSdEIEHpdJh13vr0dQj3Tnk67qVmfqAAxfbULnFc/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584892; c=relaxed/simple;
	bh=Ka53cxpwq6TDd0s/BJwOxT5nR+b4eomfy9aOxOy90KE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lq+unnVHorQ9Du2X9C6npewxHD6zonVtaAA/jVxQ/nIvD9NxSdFdWrK98CnFqdfi8k9E4k+O0CLKQb2xC2lWxBPckuMeQ8qcV9KogWOA8/WcvgfvMil4Lz4bSIy6cyWbGwVVkMTKBowvLO48cjBbT+JaMzVZO5rIAAOq6o8Sq2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaWNK4M0; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63bad3cd668so9263414a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 10:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761584889; x=1762189689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/aJpcx16wEq6iLWJmAYoLVa/ENBxlXQoVj8lw6qVT8=;
        b=MaWNK4M0VwrMlIeg+emRdp+Yc3CgJXlujVmJlwYeB4KQfxVYau8U3wU4S77HunSsNZ
         4llDjCufs5l5ZFx7Uu5lLsJ80ghrj3+CRV3hQVHbFlBTtXzFyyYrWEOZLo4VI9/+54T8
         EHlZbgCN04cwzKo3/mJQBvEgpZ6jZlObjKBvuChXJrWEFeQuk0ga7bLZrhssW9bQhTMQ
         L5F8pC1LzRWtbCt3S2K17ctY4LX2DihuzTACdyS/Es2CGqMVraI9+7eaZUyQzte/ttAH
         REF6PVo6i6Z429rNfCfBfVrWQGqmRN4mgrRQLkOlyCAC1dlHYzEFBSNk+eEJXoYwFu7X
         M2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761584889; x=1762189689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/aJpcx16wEq6iLWJmAYoLVa/ENBxlXQoVj8lw6qVT8=;
        b=ucfQedub52OMvWN7Wpr/fCszZlRGxX19nJhU/JWIokanvwSuHFhIP6TuONTPBf125o
         UbL3ddgRLtb5xCC9oNwF9uySMqrkXDLtDgJZtsC/9+bzwRAAgPTqI2/RJ4zdcLMmdw7M
         IeKmeYBBNoT+dGLimrRQPrWMpBeXiI+K8EsBBGyX5nGGU8hcFO4hJ+8vxz0h0Mk188AJ
         XbQ1Ai/NonSA7EqHNz9DRrB7EOtWWR4wTs1AuGDmUhe+AAA88+g696PnMOFOI8S7ZTPu
         UlnZi482DEAqxTYx1dGQjiRqK87EJ4qTKhD2UVWT3XXUF5NmTg0gzH0nG9N/QWXX78BM
         UpXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1BPpNLHQTdiWy50Cfn6xPWWqS2li20dldmqDpdQXnkfLhhytMNvfqJQQ8QpOvqteWXwIO97ZJbWv5Pb0K@vger.kernel.org
X-Gm-Message-State: AOJu0YxKGDXizN80ofUNCYkVG/hueJw+QRzFXnvhVfbuT/V9GbqocDff
	JxVLNiYiy+bPuLr3TbmC2wWmSB3LweXDpBBlP6rdwSlGOAdL0Yol5PgF/FsGwh3I43Twjsesf90
	PutdJ/Asl23tyXcMDyWPhb8QXeH9za4IH9hs2aJw=
X-Gm-Gg: ASbGncuJZB02OAhyeZXBmWPs4SdJRku4Zxboi1UTlsSECyw2EAG3PeF1AIHn8t5Wawn
	SMcuZeWNHMeDy7DoVtXdIRV1mqKxJpaUSEEpDyXiy0gjdkZcGplv64cZUI4IMWmm10nyal3MTHm
	M0ZyCUXty+x7L1s93BRx6YB10ywJ/IogmRNASwhCPCUS15ZWPWvs7B/WFZwl+nmJSqrQqWwtRHU
	N+NCinJKc7s2lYwOkape5b1rRdRE2lN1Pnx5lfbH2RDl5leO96Tryfp58am7hL4LQtV9RbWebLH
	5rPxI+NEMYpMunrDiIM=
X-Google-Smtp-Source: AGHT+IFy5AYcGQeUuouCXeNIv8SgQPkJp09VTLiHUl6FymkxDtypIcL8Uz3yiNnyD8ogxqz/W/ESkTd2N56oPCfboSY=
X-Received: by 2002:a05:6402:f0c:b0:63c:4d42:993b with SMTP id
 4fb4d7f45d1cf-63ed84a220dmr459934a12.34.1761584888538; Mon, 27 Oct 2025
 10:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027141230.657732-1-dmantipov@yandex.ru>
In-Reply-To: <20251027141230.657732-1-dmantipov@yandex.ru>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 27 Oct 2025 18:07:56 +0100
X-Gm-Features: AWmQ_bkOPVPx7i9KVsHLAuWjNBZCtTcFrq31FkzfAc9RdwQf2GB8K76XFIVl6Lc
Message-ID: <CAOQ4uxgRBO9bAi-p_L+Svc13+DiLB_Sh8JVqhUBy80mtFiOKrw@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: avoid redundant call to strlen() in ovl_lookup_temp()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	NeilBrown <neil@brown.name>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 3:13=E2=80=AFPM Dmitry Antipov <dmantipov@yandex.ru=
> wrote:
>
> Since 'snprintf()' returns the number of characters emitted
> and an overflow is impossible, an extra call to 'strlen()'
> in 'ovl_lookup_temp()' may be dropped. Compile tested only.
>
> To whom it still concerns, this also reduces .text a bit.
>
> Before:
>    text    data     bss     dec     hex filename
>  162522   10954      22  173498   2a5ba fs/overlayfs/overlay.ko
>
> After:
>    text    data     bss     dec     hex filename
>  162430   10954      22  173406   2a55e fs/overlayfs/overlay.ko
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  fs/overlayfs/dir.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index a5e9ddf3023b..c5b2553ef6f1 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -66,9 +66,9 @@ struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, stru=
ct dentry *workdir)
>         static atomic_t temp_id =3D ATOMIC_INIT(0);
>
>         /* counter is allowed to wrap, since temp dentries are ephemeral =
*/
> -       snprintf(name, sizeof(name), "#%x", atomic_inc_return(&temp_id));
> +       int len =3D snprintf(name, sizeof(name), "#%x", atomic_inc_return=
(&temp_id));
>
> -       temp =3D ovl_lookup_upper(ofs, name, workdir, strlen(name));
> +       temp =3D ovl_lookup_upper(ofs, name, workdir, len);
>         if (!IS_ERR(temp) && temp->d_inode) {
>                 pr_err("workdir/%s already exists\n", name);
>                 dput(temp);
> --
> 2.51.0
>

Makes sense, but this patch by Neil is going to remove this helper, so I th=
ink
there is no use in fixing it now?

https://lore.kernel.org/linux-fsdevel/20251022044545.893630-11-neilb@ownmai=
l.net/

Thanks,
Amir.


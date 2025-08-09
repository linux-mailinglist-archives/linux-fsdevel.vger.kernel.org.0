Return-Path: <linux-fsdevel+bounces-57169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A09B1F408
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 12:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E250566CEF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 10:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C31424DCF7;
	Sat,  9 Aug 2025 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqYZd+gC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3BA146A72;
	Sat,  9 Aug 2025 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754734090; cv=none; b=jZqFcQCAvFMEtXFEmkxWmGLAxxCIYuUeQlZXlm4YEwyBgUga9Jva3qAQ6K/94MXwk3L4zLdqwLqStR5dHHwP8bpTsS5gO/1HBe3brpjvq6k5SgiK7WQCPh6tBJ123wauIIL279ve8enBli1RKX7oW609HplG2MtCzugHnhk2vpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754734090; c=relaxed/simple;
	bh=lga9pgiwZZMzTGRuWaRxqaiQtbSWaBM34r1Z641KLKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lF6sopBawH7UgmsG8KEdBVfFlGC6l8unOZC09vjAv9J2ePQB/iWQfwgApNNbCvqFDecWGlCOydnYUnGpGnwJeuO4BPCMyPg8Njzxs+1jkvavCnkZk5Y55NoDgNbAlRkYwPanExdvAbdbBZkl/vUIXEOYJGGR1uO9VegMyHrQG/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqYZd+gC; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af949bdf36cso494175466b.0;
        Sat, 09 Aug 2025 03:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754734087; x=1755338887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIQXQZQu1+6vEGMEjeH1puu0gWgZwO1IcUkPlVIjGL4=;
        b=EqYZd+gCDMDa0WnMSgzQbSFfxiokx8IzdozVxXcNXEVE7Ge19OdnY0UAwHDwPr2AXU
         tGM+JYofiusb9x/6DfA5AD072twGYbzRkHCp4//JmfYkRKq8p+u9Fmylk6EJyfPI6Ns4
         WIcNQQz/d7PmxJ67kGBiTQmscntybiq5nei+/510NYJDW1yBLGvSmjjxSkzrSTSzvLup
         Fs+dD3y8eHu3Vyj2dPyDZE3seU6kf3HAi+q+xmGW6paXBZCHZTHXpk37JPblXw79zo5G
         6sGmcrh9PAITShfG+9qSJErkZlpfWGlI1FaOL7UKgOB413lcbQUOEe/wck5/k5pbP9qR
         9VaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754734087; x=1755338887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIQXQZQu1+6vEGMEjeH1puu0gWgZwO1IcUkPlVIjGL4=;
        b=FNbvWwlwRg1HFiouMpXoWvJ8B77r29q6vioVq3Lt309LBr2G5zjXiQBrRnvlNQ7Wrx
         JvAu7ZOC5CHQJy5wr8cmFpQwxajTL0vlz5ehbL7LWlbAKvZExLLZraCievsyakgpd9gb
         3NF0TvAdTmEpydFJdTen8P0bpgHpbeFutHP1FTgGkGRLnceNH+Wzoga+VRwUXiqYlskU
         DD2jqYAEbiu+bvDmvD/ZVqZZfzECTOR6rYi8a2FbNtbZuB7sVh50j0Astn5BWDpUUig/
         atdssIg8pueIVZmfCZxFWJkS8fAdISieYj96x5HZMVV1fCYdcOMkEmgj2IoNapHInrbs
         XNwA==
X-Forwarded-Encrypted: i=1; AJvYcCVcUWNN664zyixNxZnl0khx/fNCv1FTy2kpY7ZFIuls2+gTziB7QRTSQFcDWF0aaz5FRMPwBnGF4Ie0hSEJzA==@vger.kernel.org, AJvYcCWJpB6wdLBAh1eV3WXyvWhnifv5wzP/eYUfWnlMqXpWTV3g0Ef41zuXm/P9QEYzfHqkKv+hBeSPqdcbur1d@vger.kernel.org, AJvYcCWxZoZvrSoISPV09IvoQvUFS92eB6+9ou4dLTCILTdwlO7ZRVKgOclnkIRLnIvile8WAPTQM5jwJIClEptf@vger.kernel.org
X-Gm-Message-State: AOJu0YxCuzViyazsLpsofK/beB/pLb0zGLuAEAVjNSd6LHmmVKah95iN
	MD2MCrgSSRKOIUo+TAt8h6ITVRJEb1i3Vqfk/0Vn3c6WspYUCTTrfiO7pt7ZSoUiRTbQ+u4qRdJ
	Ewth4xRCWgpmU2vpD4LqWkLh2S8OjCuw=
X-Gm-Gg: ASbGncsKTUWEbrjYmQ4qBsmS+5MMbZQ+mvDGwydr4xqH0sQghG5bobBvoXhpzPiIsbo
	Hk0+DRIs9N88sOsHhpoaJEfgL7K0/5b2htd1wsTOYKw6sAtC+mRr11CGq+MSoEkKuPXyare8Wjx
	d46izk0O3NrcwUATb4PHvYhkjJMq4EPADsnnsxcuGjgyxDeB2+PjjKe6yOwYzNFGDOhJXc40EeD
	noSZG8=
X-Google-Smtp-Source: AGHT+IE6dxz8o3+PYhHrDBBahI7Jkews09Ev+dhaBseaNyuXcllm2iXZNfZ4IF8glX36sCDnlH79ucNlTx1kUQ2lMKA=
X-Received: by 2002:a17:907:3d02:b0:ade:3ce3:15d1 with SMTP id
 a640c23a62f3a-af9c645329dmr566121066b.27.1754734087310; Sat, 09 Aug 2025
 03:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com> <20250808-tonyk-overlayfs-v3-4-30f9be426ba8@igalia.com>
In-Reply-To: <20250808-tonyk-overlayfs-v3-4-30f9be426ba8@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 9 Aug 2025 12:07:56 +0200
X-Gm-Features: Ac12FXySHqBT78bwGzLSstGk7mKLDJaNroBOdAsooH4Xa7ziEHPu7nezIHdrW7c
Message-ID: <CAOQ4uxikEukw8o_=SrH6w01bnjD0ZBmMrf3kzLuR1U++B2x4dQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 4/7] ovl: Ensure that all mount points have the
 same encoding
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 10:59=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> When mounting different mount points with casefold support, they should

Different mount points in incorrect terminology, please use:
When merging layers from different filesystems with casefold enabled,
all layers should...


> use the same encoding version and have the same flags to avoid any kind
> of incompatibility issues.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  fs/overlayfs/super.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index df85a76597e910d00323018f1d2cd720c5db921d..bcb7f5dbf9a32e4aa09bc4159=
6be443851e21200 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -998,6 +998,7 @@ static int ovl_get_layers(struct super_block *sb, str=
uct ovl_fs *ofs,
>         int err;
>         unsigned int i;
>         size_t nr_merged_lower;
> +       struct super_block *sb1 =3D NULL;
>
>         ofs->fs =3D kcalloc(ctx->nr + 2, sizeof(struct ovl_sb), GFP_KERNE=
L);
>         if (ofs->fs =3D=3D NULL)
> @@ -1024,6 +1025,8 @@ static int ovl_get_layers(struct super_block *sb, s=
truct ovl_fs *ofs,
>         if (ovl_upper_mnt(ofs)) {
>                 ofs->fs[0].sb =3D ovl_upper_mnt(ofs)->mnt_sb;
>                 ofs->fs[0].is_lower =3D false;
> +
> +               sb1 =3D ofs->fs[0].sb;
>         }
>
>         nr_merged_lower =3D ctx->nr - ctx->nr_data;
> @@ -1067,6 +1070,9 @@ static int ovl_get_layers(struct super_block *sb, s=
truct ovl_fs *ofs,
>                         return err;
>                 }
>
> +               if (!sb1)
> +                       sb1 =3D mnt->mnt_sb;
> +
>                 /*
>                  * Make lower layers R/O.  That way fchmod/fchown on lowe=
r file
>                  * will fail instead of modifying lower fs.
> @@ -1083,6 +1089,11 @@ static int ovl_get_layers(struct super_block *sb, =
struct ovl_fs *ofs,
>                 l->name =3D NULL;
>                 ofs->numlayer++;
>                 ofs->fs[fsid].is_lower =3D true;
> +
> +               if (!sb_same_encoding(sb1, mnt->mnt_sb)) {
> +                       pr_err("all layers must have the same encoding\n"=
);
> +                       return -EINVAL;
> +               }
>         }

This condition is too strict IMO.
It is only needed if ofs->casefold is enabled.
When casefolding is not enabled for the ovl mount,
we need not care about the layers encoding.

This is related to another comment I have on path 7 -
ofs->casefold config should be introduced much earlier in the
series, so that it could be used in conditions like this one and
in the S_CASEFOLD assertions after copying inode flags.

Thanks,
Amir.


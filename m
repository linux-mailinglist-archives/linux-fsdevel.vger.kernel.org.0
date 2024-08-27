Return-Path: <linux-fsdevel+bounces-27476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 618F2961AB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 01:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937D01C22E3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 23:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D4D1D47A0;
	Tue, 27 Aug 2024 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1GHWCco"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768BB15CD4A;
	Tue, 27 Aug 2024 23:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724801943; cv=none; b=NBKUzHXF4bg151Wd12m+REBmiZmlk57dQMMiUg9zTXj60C1DX1I2PYljaoRJxB6DZ62V1ZPp31bwUFTnSdl9h+i/leS9VWH91smh+ylaE0SWGpkoS5Gdo9TFbswQTcCj0OWMGbPPp17IbYixW4ueP0CzkPBTLpA1OvZRRIWrpNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724801943; c=relaxed/simple;
	bh=Iv5XH68xorPUQHJ3UuBYpRFDra7UYg0SpNE4jKP3Q6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/MS/vwNWyaHAOL0lkt+AuT2MYBAZLhCKTdW8BNFD7UURfrZl0JVK7Yh8xO1BhRdHy7xlJ7a6I3K0FJUq3Lk3WVi9eqJWv2T3u2ClXZJDHBxmw9slA8hm8ztF86O9rMIohRx40fyLZvq9aOyYvpbaWig2VGiXZwV4DZZ5ZqnGis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1GHWCco; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bebd3b7c22so112895a12.0;
        Tue, 27 Aug 2024 16:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724801939; x=1725406739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R05NRDGOO1oSOh780OWfzTYLlgnTmADM/nPauNHjeEs=;
        b=I1GHWCcoYDcqL6YZ/xjuMX3OjpX6KipYeO1JAoVitTGIy0QBVLY8Gq5JjXi+ubiUTG
         kZiUJS2mq5NluQUN28G6tkjpuDg/SyjFqVIU4nyJr2jblWtqMaKUo2wS2l20u+zBxHs+
         zoJg3Zi0QuH7CCLwELcOXEGtAOK5UpRW4b1FIdWM8uB6bHHRETtbplBuN+qfKi1FvHgf
         TLaVrmYAloZoPlsF50N2bwEReOnKWwxhuY6csBbNUb8NTLDAP0g/P6unVB9ylRgiFgLZ
         7ytK2qcIC5yiMd+/rbxhv5sSphURn9PqfLO5eHXSSaFMTfnad6xuJE6tdjx7xouYezTY
         Hdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724801939; x=1725406739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R05NRDGOO1oSOh780OWfzTYLlgnTmADM/nPauNHjeEs=;
        b=w3EbncPcYd22mrjZsDgH8pIj2d6g4T9toEftup114cCFLlvkuLf/6BO70qiGsHJQdL
         0uFoOK7td40r9n3kvvtFa+edXFwWqRtQ8WrGmmiaxvhhs9F8SFLsYHVWJmfFRKrJ5Iaq
         sS51GOlRuAR8PjGSxNXr3d1l2UL4dNlJ45NybbTNnSuFKEZqvQIvo3ZjLW2/p00S4Sgb
         NfesjIzAemoeAhI5W7BKGCaFX80hys2KYZ3roTUIINVy5sOcpnzFN75QUYqccTqkRrCr
         RzMRpo+eA4RaW4AGCHUFj/w9iLsOQbocv18s7RCFH5+Q8w454BZfLAAiIF2AmVmqG9sf
         ei/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX50AevotJO3jT4NOgDhX8dL9qcylmnvPgckYd1FObBNTNgNOPrY2C7aMAXy/FxWRbNNARcDaz/HEF1MFIu@vger.kernel.org, AJvYcCXQOmSMXJr4lMyrnYkFIzYR93Zu9LiJXdKBd0WFBxpyDWaFDbA7Z3Qpl19ym2shW0wVbHjhs2nbhpP7DEVn@vger.kernel.org
X-Gm-Message-State: AOJu0YwcraFmH5Mzii/P37sXCRn8gjNGI7n3ZSbGHhbsG2qIjWUqqU6t
	tWreAV7kCTUmXzk0gTbWH6Z8LayqqoifleuM8XobwL79eRvl4t8IMHtoj2Q/cGY1BdlurQUm6MY
	Ly7vi50LbphUiEB1ae3wD9SjPmbghe6sU
X-Google-Smtp-Source: AGHT+IGu4H0HV/KBLUKwzHBe2B1fbkPiH37MLwobFjeSBQdDSdK/LDuQh3+LMDwSobR6E3nuCguSmWiFqVabZlSisWs=
X-Received: by 2002:a17:907:94d2:b0:a77:ab9e:9202 with SMTP id
 a640c23a62f3a-a870a8c8e55mr33125766b.4.1724801939287; Tue, 27 Aug 2024
 16:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827-iversion-v1-1-b46a2b612400@kernel.org>
In-Reply-To: <20240827-iversion-v1-1-b46a2b612400@kernel.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 28 Aug 2024 01:38:46 +0200
Message-ID: <CAGudoHE+PkQp+RVen+0YZ1G6LZfG5aQsq0LrmTP+kZb-6=p2xA@mail.gmail.com>
Subject: Re: [PATCH RFC] fs: don't force i_version increment when timestamps change
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 4:30=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> inode_maybe_inc_iversion will increment the i_version if it has been
> queried. We can also set the "force" parameter to force an increment.
> When we originally did this, the idea was to set it to force when we
> were going to be otherwise updating the inode timestamps anyway --
> purely a "might as well" measure.
>
> When we used coarse-grained timestamps exclusively, this would give us
> an extra cmpxchg operation roughly every jiffy when a file is under
> heavy writes. With the advent of multigrain timestamps however, this can
> fire more frequently.
>
> There is no requirement to force an increment to the i_version just
> because a timestamp changed, so stop doing it.
>
> Cc: Mateusz Guzik <mjguzik@gmail.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> I've not tested this other than for compilation, but it should be fine.
> Mateusz, does this help your workload at all? There may be other places
> where we can just set this to false (maybe even convert some of the
> inode_inc_iversion() calls to this.

This does not make a difference for me since any call to
inode_maybe_inc_iversion is guaranteed to provide a full barrier, this
is at best moving it from the cmpxchg to spelled out smp_mb

As to whether the patch makes sense otherwise I have no idea.

> ---
>  fs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/inode.c b/fs/inode.c
> index 10c4619faeef..2abd6317839b 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1962,7 +1962,7 @@ int inode_update_timestamps(struct inode *inode, in=
t flags)
>                         inode_set_mtime_to_ts(inode, now);
>                         updated |=3D S_MTIME;
>                 }
> -               if (IS_I_VERSION(inode) && inode_maybe_inc_iversion(inode=
, updated))
> +               if (IS_I_VERSION(inode) && inode_maybe_inc_iversion(inode=
, false))
>                         updated |=3D S_VERSION;
>         } else {
>                 now =3D current_time(inode);
>
> ---
> base-commit: 3e9bff3bbe1355805de919f688bef4baefbfd436
> change-id: 20240827-iversion-afa53f0a070b
>
> Best regards,
> --
> Jeff Layton <jlayton@kernel.org>
>


--=20
Mateusz Guzik <mjguzik gmail.com>

